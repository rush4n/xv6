#include "kernel/types.h"
#include "kernel/fcntl.h"
#include "user/user.h"

#define SEPARATORS " -\r\t\n./,"

void
sixfive(int fd) {
    char c, prev;
    int n;

    prev = '\0';

    while(read(fd, &c, 1) == 1) {
        if (c >= '0' && c <= '9' && (prev == '\0' || strchr(SEPARATORS, prev) != 0)) {
            n = 0;
            
            do {
                n = n * 10 + (c - '0');
                prev = c;
                if (read(fd, &c, 1) != 1) break;
            } while(c >= '0' && c <= '9');

            if (n % 6 == 0 || n % 5 == 0) printf("%d\n", n);

            prev = c;
        } else {
            prev = c;
        }
    }
}

int 
main(int argc, char *argv[]) {
    int fd, i;

    if (argc <= 1) {
        fprintf(2, "Usage: sixfive [filename]\n");
        exit(1);
    }

    for (i = 1; i < argc; i++) {
        if ((fd = open(argv[i], O_RDONLY)) < 0) {
            fprintf(2, "sixfive: cannot open %s\n", argv[i]);
            exit(1);
        }
        sixfive(fd);
        close(fd);
    }

    exit(0);
    
}