#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "kernel/fs.h"
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"

void
find(char *path, char *filename, int cmd_count, char *cmd[]) {
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, O_RDONLY)) < 0) {
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0) {
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return; 
    }   

    switch (st.type) {
        case T_DEVICE:
        case T_FILE:
            p = path + strlen(path);
            while (p >= path && *p != '/') 
                p--;

            p++;
            if (strcmp(p, filename) == 0) {

                if (cmd_count == 0) {
                    printf("%s\n", path);
                } else {
                    char *args[MAXARG];
                    int i;

                    for (i = 0; i < cmd_count; i++)
                        args[i] = cmd[i];

                    args[i++] = path;
                    args[i] = 0;

                    int pid = fork();

                    if (pid == 0) {
                        exec(args[0], args);
                        fprintf(2, "find: exec failed\n");
                        exit(1);
                    } else if (pid > 0) {
                        wait(0);
                    } else {
                        fprintf(2, "find: fork failed\n");
                    }
                }
            }
            break;
        case T_DIR:
            if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
                printf("find: path too long\n");
                break;
            }
            strcpy(buf, path);
            p = buf + strlen(path);
            *p++ = '/';
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
                if(de.inum == 0)
                    continue;
                if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
                    continue;
                memmove(p, de.name, DIRSIZ);
                p[DIRSIZ] = 0;
                find(buf, filename, cmd_count, cmd);
            }
            break;
    }

    close(fd);
}


int 
main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(2, "Usage: find [path] [filename]\n");
        exit(1);
    }
    
    if (argc == 3) {
        char *cmd[] = {0};
        find(argv[1], argv[2], 0, cmd);
    }

    if (argc > 3 && strcmp(argv[3], "-exec") == 0) {
        int i;
        char *cmd[MAXARG];

        for(i = 0; i < argc - 4; i++) {
            cmd[i] = argv[i + 4];
        }
        cmd[i] = 0;
        find(argv[1], argv[2], i, cmd);
    }

    exit(0);
}