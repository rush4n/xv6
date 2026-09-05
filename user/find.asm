
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <find>:
#include "kernel/stat.h"
#include "kernel/param.h"
#include "user/user.h"

void
find(char *path, char *filename, int cmd_count, char *cmd[]) {
   0:	c7010113          	addi	sp,sp,-912
   4:	38113423          	sd	ra,904(sp)
   8:	38813023          	sd	s0,896(sp)
   c:	36913c23          	sd	s1,888(sp)
  10:	37313423          	sd	s3,872(sp)
  14:	37413023          	sd	s4,864(sp)
  18:	35513c23          	sd	s5,856(sp)
  1c:	0f00                	addi	s0,sp,912
  1e:	84aa                	mv	s1,a0
  20:	8a2e                	mv	s4,a1
  22:	89b2                	mv	s3,a2
  24:	8ab6                	mv	s5,a3
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if ((fd = open(path, O_RDONLY)) < 0) {
  26:	4581                	li	a1,0
  28:	5d8000ef          	jal	600 <open>
  2c:	0a054363          	bltz	a0,d2 <find+0xd2>
  30:	37213823          	sd	s2,880(sp)
  34:	892a                	mv	s2,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if (fstat(fd, &st) < 0) {
  36:	d7840593          	addi	a1,s0,-648
  3a:	5de000ef          	jal	618 <fstat>
  3e:	0a054363          	bltz	a0,e4 <find+0xe4>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return; 
    }   

    switch (st.type) {
  42:	d8041783          	lh	a5,-640(s0)
  46:	4705                	li	a4,1
  48:	10e78863          	beq	a5,a4,158 <find+0x158>
  4c:	37f9                	addiw	a5,a5,-2
  4e:	17c2                	slli	a5,a5,0x30
  50:	93c1                	srli	a5,a5,0x30
  52:	12f76163          	bltu	a4,a5,174 <find+0x174>
        case T_DEVICE:
        case T_FILE:
            p = path + strlen(path);
  56:	8526                	mv	a0,s1
  58:	300000ef          	jal	358 <strlen>
  5c:	02051793          	slli	a5,a0,0x20
  60:	9381                	srli	a5,a5,0x20
  62:	97a6                	add	a5,a5,s1
            while (p >= path && *p != '/') 
  64:	02f00693          	li	a3,47
  68:	0097e963          	bltu	a5,s1,7a <find+0x7a>
  6c:	0007c703          	lbu	a4,0(a5)
  70:	00d70563          	beq	a4,a3,7a <find+0x7a>
                p--;
  74:	17fd                	addi	a5,a5,-1
            while (p >= path && *p != '/') 
  76:	fe97fbe3          	bgeu	a5,s1,6c <find+0x6c>

            p++;
            if (strcmp(p, filename) == 0) {
  7a:	85d2                	mv	a1,s4
  7c:	00178513          	addi	a0,a5,1
  80:	2a8000ef          	jal	328 <strcmp>
  84:	0e051863          	bnez	a0,174 <find+0x174>

                if (cmd_count == 0) {
  88:	06098e63          	beqz	s3,104 <find+0x104>
                    printf("%s\n", path);
                } else {
                    char *args[MAXARG];
                    int i;

                    for (i = 0; i < cmd_count; i++)
  8c:	07305a63          	blez	s3,100 <find+0x100>
  90:	87d6                	mv	a5,s5
  92:	c7840713          	addi	a4,s0,-904
  96:	00399613          	slli	a2,s3,0x3
  9a:	9656                	add	a2,a2,s5
                        args[i] = cmd[i];
  9c:	6394                	ld	a3,0(a5)
  9e:	e314                	sd	a3,0(a4)
                    for (i = 0; i < cmd_count; i++)
  a0:	07a1                	addi	a5,a5,8
  a2:	0721                	addi	a4,a4,8
  a4:	fec79ce3          	bne	a5,a2,9c <find+0x9c>

                    args[i++] = path;
  a8:	c7840713          	addi	a4,s0,-904
  ac:	00399793          	slli	a5,s3,0x3
  b0:	97ba                	add	a5,a5,a4
  b2:	e384                	sd	s1,0(a5)
  b4:	0019879b          	addiw	a5,s3,1
                    args[i] = 0;
  b8:	078e                	slli	a5,a5,0x3
  ba:	97ba                	add	a5,a5,a4
  bc:	0007b023          	sd	zero,0(a5)

                    int pid = fork();
  c0:	4f8000ef          	jal	5b8 <fork>

                    if (pid == 0) {
  c4:	c921                	beqz	a0,114 <find+0x114>
                        exec(args[0], args);
                        fprintf(2, "find: exec failed\n");
                        exit(1);
                    } else if (pid > 0) {
  c6:	08a05163          	blez	a0,148 <find+0x148>
                        wait(0);
  ca:	4501                	li	a0,0
  cc:	4fc000ef          	jal	5c8 <wait>
  d0:	a055                	j	174 <find+0x174>
        fprintf(2, "find: cannot open %s\n", path);
  d2:	8626                	mv	a2,s1
  d4:	00001597          	auipc	a1,0x1
  d8:	abc58593          	addi	a1,a1,-1348 # b90 <malloc+0xf8>
  dc:	4509                	li	a0,2
  de:	0d9000ef          	jal	9b6 <fprintf>
        return;
  e2:	a871                	j	17e <find+0x17e>
        fprintf(2, "find: cannot stat %s\n", path);
  e4:	8626                	mv	a2,s1
  e6:	00001597          	auipc	a1,0x1
  ea:	aca58593          	addi	a1,a1,-1334 # bb0 <malloc+0x118>
  ee:	4509                	li	a0,2
  f0:	0c7000ef          	jal	9b6 <fprintf>
        close(fd);
  f4:	854a                	mv	a0,s2
  f6:	4f2000ef          	jal	5e8 <close>
        return; 
  fa:	37013903          	ld	s2,880(sp)
  fe:	a041                	j	17e <find+0x17e>
                    for (i = 0; i < cmd_count; i++)
 100:	89aa                	mv	s3,a0
 102:	b75d                	j	a8 <find+0xa8>
                    printf("%s\n", path);
 104:	85a6                	mv	a1,s1
 106:	00001517          	auipc	a0,0x1
 10a:	ac250513          	addi	a0,a0,-1342 # bc8 <malloc+0x130>
 10e:	0d3000ef          	jal	9e0 <printf>
 112:	a08d                	j	174 <find+0x174>
 114:	35613823          	sd	s6,848(sp)
 118:	35713423          	sd	s7,840(sp)
 11c:	35813023          	sd	s8,832(sp)
 120:	33913c23          	sd	s9,824(sp)
 124:	33a13823          	sd	s10,816(sp)
                        exec(args[0], args);
 128:	c7840593          	addi	a1,s0,-904
 12c:	c7843503          	ld	a0,-904(s0)
 130:	4c8000ef          	jal	5f8 <exec>
                        fprintf(2, "find: exec failed\n");
 134:	00001597          	auipc	a1,0x1
 138:	a9c58593          	addi	a1,a1,-1380 # bd0 <malloc+0x138>
 13c:	4509                	li	a0,2
 13e:	079000ef          	jal	9b6 <fprintf>
                        exit(1);
 142:	4505                	li	a0,1
 144:	47c000ef          	jal	5c0 <exit>
                    } else {
                        fprintf(2, "find: fork failed\n");
 148:	00001597          	auipc	a1,0x1
 14c:	aa058593          	addi	a1,a1,-1376 # be8 <malloc+0x150>
 150:	4509                	li	a0,2
 152:	065000ef          	jal	9b6 <fprintf>
 156:	a839                	j	174 <find+0x174>
                    }
                }
            }
            break;
        case T_DIR:
            if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 158:	8526                	mv	a0,s1
 15a:	1fe000ef          	jal	358 <strlen>
 15e:	2541                	addiw	a0,a0,16
 160:	20000793          	li	a5,512
 164:	02a7fc63          	bgeu	a5,a0,19c <find+0x19c>
                printf("find: path too long\n");
 168:	00001517          	auipc	a0,0x1
 16c:	a9850513          	addi	a0,a0,-1384 # c00 <malloc+0x168>
 170:	071000ef          	jal	9e0 <printf>
                find(buf, filename, cmd_count, cmd);
            }
            break;
    }

    close(fd);
 174:	854a                	mv	a0,s2
 176:	472000ef          	jal	5e8 <close>
 17a:	37013903          	ld	s2,880(sp)
}
 17e:	38813083          	ld	ra,904(sp)
 182:	38013403          	ld	s0,896(sp)
 186:	37813483          	ld	s1,888(sp)
 18a:	36813983          	ld	s3,872(sp)
 18e:	36013a03          	ld	s4,864(sp)
 192:	35813a83          	ld	s5,856(sp)
 196:	39010113          	addi	sp,sp,912
 19a:	8082                	ret
 19c:	35613823          	sd	s6,848(sp)
 1a0:	35713423          	sd	s7,840(sp)
 1a4:	35813023          	sd	s8,832(sp)
 1a8:	33913c23          	sd	s9,824(sp)
 1ac:	33a13823          	sd	s10,816(sp)
            strcpy(buf, path);
 1b0:	da040b13          	addi	s6,s0,-608
 1b4:	85a6                	mv	a1,s1
 1b6:	855a                	mv	a0,s6
 1b8:	150000ef          	jal	308 <strcpy>
            p = buf + strlen(path);
 1bc:	8526                	mv	a0,s1
 1be:	19a000ef          	jal	358 <strlen>
 1c2:	1502                	slli	a0,a0,0x20
 1c4:	9101                	srli	a0,a0,0x20
 1c6:	9b2a                	add	s6,s6,a0
            *p++ = '/';
 1c8:	001b0d13          	addi	s10,s6,1
 1cc:	02f00793          	li	a5,47
 1d0:	00fb0023          	sb	a5,0(s6)
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 1d4:	d9040b93          	addi	s7,s0,-624
 1d8:	44c1                	li	s1,16
                if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 1da:	d9240c93          	addi	s9,s0,-622
 1de:	00001c17          	auipc	s8,0x1
 1e2:	a3ac0c13          	addi	s8,s8,-1478 # c18 <malloc+0x180>
            while (read(fd, &de, sizeof(de)) == sizeof(de)) {
 1e6:	8626                	mv	a2,s1
 1e8:	85de                	mv	a1,s7
 1ea:	854a                	mv	a0,s2
 1ec:	3ec000ef          	jal	5d8 <read>
 1f0:	04951363          	bne	a0,s1,236 <find+0x236>
                if(de.inum == 0)
 1f4:	d9045783          	lhu	a5,-624(s0)
 1f8:	d7fd                	beqz	a5,1e6 <find+0x1e6>
                if (strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 1fa:	85e2                	mv	a1,s8
 1fc:	8566                	mv	a0,s9
 1fe:	12a000ef          	jal	328 <strcmp>
 202:	d175                	beqz	a0,1e6 <find+0x1e6>
 204:	00001597          	auipc	a1,0x1
 208:	a1c58593          	addi	a1,a1,-1508 # c20 <malloc+0x188>
 20c:	d9240513          	addi	a0,s0,-622
 210:	118000ef          	jal	328 <strcmp>
 214:	d969                	beqz	a0,1e6 <find+0x1e6>
                memmove(p, de.name, DIRSIZ);
 216:	4639                	li	a2,14
 218:	d9240593          	addi	a1,s0,-622
 21c:	856a                	mv	a0,s10
 21e:	2c0000ef          	jal	4de <memmove>
                p[DIRSIZ] = 0;
 222:	000b07a3          	sb	zero,15(s6)
                find(buf, filename, cmd_count, cmd);
 226:	86d6                	mv	a3,s5
 228:	864e                	mv	a2,s3
 22a:	85d2                	mv	a1,s4
 22c:	da040513          	addi	a0,s0,-608
 230:	dd1ff0ef          	jal	0 <find>
 234:	bf4d                	j	1e6 <find+0x1e6>
 236:	35013b03          	ld	s6,848(sp)
 23a:	34813b83          	ld	s7,840(sp)
 23e:	34013c03          	ld	s8,832(sp)
 242:	33813c83          	ld	s9,824(sp)
 246:	33013d03          	ld	s10,816(sp)
 24a:	b72d                	j	174 <find+0x174>

000000000000024c <main>:


int 
main(int argc, char *argv[]) {
 24c:	712d                	addi	sp,sp,-288
 24e:	ee06                	sd	ra,280(sp)
 250:	ea22                	sd	s0,272(sp)
 252:	e626                	sd	s1,264(sp)
 254:	e24a                	sd	s2,256(sp)
 256:	1200                	addi	s0,sp,288
    if (argc < 3) {
 258:	4789                	li	a5,2
 25a:	06a7d763          	bge	a5,a0,2c8 <main+0x7c>
 25e:	84aa                	mv	s1,a0
 260:	892e                	mv	s2,a1
        fprintf(2, "Usage: find [path] [filename]\n");
        exit(1);
    }
    
    if (argc == 3) {
 262:	478d                	li	a5,3
 264:	06f50c63          	beq	a0,a5,2dc <main+0x90>
        char *cmd[] = {0};
        find(argv[1], argv[2], 0, cmd);
    }

    if (argc > 3 && strcmp(argv[3], "-exec") == 0) {
 268:	00001597          	auipc	a1,0x1
 26c:	9e058593          	addi	a1,a1,-1568 # c48 <malloc+0x1b0>
 270:	01893503          	ld	a0,24(s2)
 274:	0b4000ef          	jal	328 <strcmp>
 278:	862a                	mv	a2,a0
 27a:	e93d                	bnez	a0,2f0 <main+0xa4>
        int i;
        char *cmd[MAXARG];

        for(i = 0; i < argc - 4; i++) {
 27c:	4791                	li	a5,4
 27e:	0297d763          	bge	a5,s1,2ac <main+0x60>
 282:	02090713          	addi	a4,s2,32
 286:	ee040793          	addi	a5,s0,-288
 28a:	ffb4861b          	addiw	a2,s1,-5
 28e:	02061693          	slli	a3,a2,0x20
 292:	01d6d613          	srli	a2,a3,0x1d
 296:	ee840693          	addi	a3,s0,-280
 29a:	9636                	add	a2,a2,a3
            cmd[i] = argv[i + 4];
 29c:	6314                	ld	a3,0(a4)
 29e:	e394                	sd	a3,0(a5)
        for(i = 0; i < argc - 4; i++) {
 2a0:	0721                	addi	a4,a4,8
 2a2:	07a1                	addi	a5,a5,8
 2a4:	fec79ce3          	bne	a5,a2,29c <main+0x50>
 2a8:	ffc4861b          	addiw	a2,s1,-4
        }
        cmd[i] = 0;
 2ac:	ee040693          	addi	a3,s0,-288
 2b0:	00361793          	slli	a5,a2,0x3
 2b4:	97b6                	add	a5,a5,a3
 2b6:	0007b023          	sd	zero,0(a5)
        find(argv[1], argv[2], i, cmd);
 2ba:	01093583          	ld	a1,16(s2)
 2be:	00893503          	ld	a0,8(s2)
 2c2:	d3fff0ef          	jal	0 <find>
 2c6:	a02d                	j	2f0 <main+0xa4>
        fprintf(2, "Usage: find [path] [filename]\n");
 2c8:	00001597          	auipc	a1,0x1
 2cc:	96058593          	addi	a1,a1,-1696 # c28 <malloc+0x190>
 2d0:	853e                	mv	a0,a5
 2d2:	6e4000ef          	jal	9b6 <fprintf>
        exit(1);
 2d6:	4505                	li	a0,1
 2d8:	2e8000ef          	jal	5c0 <exit>
        char *cmd[] = {0};
 2dc:	ee043023          	sd	zero,-288(s0)
        find(argv[1], argv[2], 0, cmd);
 2e0:	ee040693          	addi	a3,s0,-288
 2e4:	4601                	li	a2,0
 2e6:	698c                	ld	a1,16(a1)
 2e8:	00893503          	ld	a0,8(s2)
 2ec:	d15ff0ef          	jal	0 <find>
    }

    exit(0);
 2f0:	4501                	li	a0,0
 2f2:	2ce000ef          	jal	5c0 <exit>

00000000000002f6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e406                	sd	ra,8(sp)
 2fa:	e022                	sd	s0,0(sp)
 2fc:	0800                	addi	s0,sp,16
  extern int main();
  main();
 2fe:	f4fff0ef          	jal	24c <main>
  exit(0);
 302:	4501                	li	a0,0
 304:	2bc000ef          	jal	5c0 <exit>

0000000000000308 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 310:	87aa                	mv	a5,a0
 312:	0585                	addi	a1,a1,1
 314:	0785                	addi	a5,a5,1
 316:	fff5c703          	lbu	a4,-1(a1)
 31a:	fee78fa3          	sb	a4,-1(a5)
 31e:	fb75                	bnez	a4,312 <strcpy+0xa>
    ;
  return os;
}
 320:	60a2                	ld	ra,8(sp)
 322:	6402                	ld	s0,0(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret

0000000000000328 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 328:	1141                	addi	sp,sp,-16
 32a:	e406                	sd	ra,8(sp)
 32c:	e022                	sd	s0,0(sp)
 32e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 330:	00054783          	lbu	a5,0(a0)
 334:	cb91                	beqz	a5,348 <strcmp+0x20>
 336:	0005c703          	lbu	a4,0(a1)
 33a:	00f71763          	bne	a4,a5,348 <strcmp+0x20>
    p++, q++;
 33e:	0505                	addi	a0,a0,1
 340:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 342:	00054783          	lbu	a5,0(a0)
 346:	fbe5                	bnez	a5,336 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 348:	0005c503          	lbu	a0,0(a1)
}
 34c:	40a7853b          	subw	a0,a5,a0
 350:	60a2                	ld	ra,8(sp)
 352:	6402                	ld	s0,0(sp)
 354:	0141                	addi	sp,sp,16
 356:	8082                	ret

0000000000000358 <strlen>:

uint
strlen(const char *s)
{
 358:	1141                	addi	sp,sp,-16
 35a:	e406                	sd	ra,8(sp)
 35c:	e022                	sd	s0,0(sp)
 35e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 360:	00054783          	lbu	a5,0(a0)
 364:	cf99                	beqz	a5,382 <strlen+0x2a>
 366:	0505                	addi	a0,a0,1
 368:	87aa                	mv	a5,a0
 36a:	86be                	mv	a3,a5
 36c:	0785                	addi	a5,a5,1
 36e:	fff7c703          	lbu	a4,-1(a5)
 372:	ff65                	bnez	a4,36a <strlen+0x12>
 374:	40a6853b          	subw	a0,a3,a0
 378:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 37a:	60a2                	ld	ra,8(sp)
 37c:	6402                	ld	s0,0(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret
  for(n = 0; s[n]; n++)
 382:	4501                	li	a0,0
 384:	bfdd                	j	37a <strlen+0x22>

0000000000000386 <memset>:

void*
memset(void *dst, int c, uint n)
{
 386:	1141                	addi	sp,sp,-16
 388:	e406                	sd	ra,8(sp)
 38a:	e022                	sd	s0,0(sp)
 38c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 38e:	ca19                	beqz	a2,3a4 <memset+0x1e>
 390:	87aa                	mv	a5,a0
 392:	1602                	slli	a2,a2,0x20
 394:	9201                	srli	a2,a2,0x20
 396:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 39a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 39e:	0785                	addi	a5,a5,1
 3a0:	fee79de3          	bne	a5,a4,39a <memset+0x14>
  }
  return dst;
}
 3a4:	60a2                	ld	ra,8(sp)
 3a6:	6402                	ld	s0,0(sp)
 3a8:	0141                	addi	sp,sp,16
 3aa:	8082                	ret

00000000000003ac <strchr>:

char*
strchr(const char *s, char c)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e406                	sd	ra,8(sp)
 3b0:	e022                	sd	s0,0(sp)
 3b2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3b4:	00054783          	lbu	a5,0(a0)
 3b8:	cf81                	beqz	a5,3d0 <strchr+0x24>
    if(*s == c)
 3ba:	00f58763          	beq	a1,a5,3c8 <strchr+0x1c>
  for(; *s; s++)
 3be:	0505                	addi	a0,a0,1
 3c0:	00054783          	lbu	a5,0(a0)
 3c4:	fbfd                	bnez	a5,3ba <strchr+0xe>
      return (char*)s;
  return 0;
 3c6:	4501                	li	a0,0
}
 3c8:	60a2                	ld	ra,8(sp)
 3ca:	6402                	ld	s0,0(sp)
 3cc:	0141                	addi	sp,sp,16
 3ce:	8082                	ret
  return 0;
 3d0:	4501                	li	a0,0
 3d2:	bfdd                	j	3c8 <strchr+0x1c>

00000000000003d4 <gets>:

char*
gets(char *buf, int max)
{
 3d4:	7159                	addi	sp,sp,-112
 3d6:	f486                	sd	ra,104(sp)
 3d8:	f0a2                	sd	s0,96(sp)
 3da:	eca6                	sd	s1,88(sp)
 3dc:	e8ca                	sd	s2,80(sp)
 3de:	e4ce                	sd	s3,72(sp)
 3e0:	e0d2                	sd	s4,64(sp)
 3e2:	fc56                	sd	s5,56(sp)
 3e4:	f85a                	sd	s6,48(sp)
 3e6:	f45e                	sd	s7,40(sp)
 3e8:	f062                	sd	s8,32(sp)
 3ea:	ec66                	sd	s9,24(sp)
 3ec:	e86a                	sd	s10,16(sp)
 3ee:	1880                	addi	s0,sp,112
 3f0:	8caa                	mv	s9,a0
 3f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3f4:	892a                	mv	s2,a0
 3f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 3f8:	f9f40b13          	addi	s6,s0,-97
 3fc:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 3fe:	4ba9                	li	s7,10
 400:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 402:	8d26                	mv	s10,s1
 404:	0014899b          	addiw	s3,s1,1
 408:	84ce                	mv	s1,s3
 40a:	0349d563          	bge	s3,s4,434 <gets+0x60>
    cc = read(0, &c, 1);
 40e:	8656                	mv	a2,s5
 410:	85da                	mv	a1,s6
 412:	4501                	li	a0,0
 414:	1c4000ef          	jal	5d8 <read>
    if(cc < 1)
 418:	00a05e63          	blez	a0,434 <gets+0x60>
    buf[i++] = c;
 41c:	f9f44783          	lbu	a5,-97(s0)
 420:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 424:	01778763          	beq	a5,s7,432 <gets+0x5e>
 428:	0905                	addi	s2,s2,1
 42a:	fd879ce3          	bne	a5,s8,402 <gets+0x2e>
    buf[i++] = c;
 42e:	8d4e                	mv	s10,s3
 430:	a011                	j	434 <gets+0x60>
 432:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 434:	9d66                	add	s10,s10,s9
 436:	000d0023          	sb	zero,0(s10)
  return buf;
}
 43a:	8566                	mv	a0,s9
 43c:	70a6                	ld	ra,104(sp)
 43e:	7406                	ld	s0,96(sp)
 440:	64e6                	ld	s1,88(sp)
 442:	6946                	ld	s2,80(sp)
 444:	69a6                	ld	s3,72(sp)
 446:	6a06                	ld	s4,64(sp)
 448:	7ae2                	ld	s5,56(sp)
 44a:	7b42                	ld	s6,48(sp)
 44c:	7ba2                	ld	s7,40(sp)
 44e:	7c02                	ld	s8,32(sp)
 450:	6ce2                	ld	s9,24(sp)
 452:	6d42                	ld	s10,16(sp)
 454:	6165                	addi	sp,sp,112
 456:	8082                	ret

0000000000000458 <stat>:

int
stat(const char *n, struct stat *st)
{
 458:	1101                	addi	sp,sp,-32
 45a:	ec06                	sd	ra,24(sp)
 45c:	e822                	sd	s0,16(sp)
 45e:	e04a                	sd	s2,0(sp)
 460:	1000                	addi	s0,sp,32
 462:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 464:	4581                	li	a1,0
 466:	19a000ef          	jal	600 <open>
  if(fd < 0)
 46a:	02054263          	bltz	a0,48e <stat+0x36>
 46e:	e426                	sd	s1,8(sp)
 470:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 472:	85ca                	mv	a1,s2
 474:	1a4000ef          	jal	618 <fstat>
 478:	892a                	mv	s2,a0
  close(fd);
 47a:	8526                	mv	a0,s1
 47c:	16c000ef          	jal	5e8 <close>
  return r;
 480:	64a2                	ld	s1,8(sp)
}
 482:	854a                	mv	a0,s2
 484:	60e2                	ld	ra,24(sp)
 486:	6442                	ld	s0,16(sp)
 488:	6902                	ld	s2,0(sp)
 48a:	6105                	addi	sp,sp,32
 48c:	8082                	ret
    return -1;
 48e:	597d                	li	s2,-1
 490:	bfcd                	j	482 <stat+0x2a>

0000000000000492 <atoi>:

int
atoi(const char *s)
{
 492:	1141                	addi	sp,sp,-16
 494:	e406                	sd	ra,8(sp)
 496:	e022                	sd	s0,0(sp)
 498:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 49a:	00054683          	lbu	a3,0(a0)
 49e:	fd06879b          	addiw	a5,a3,-48
 4a2:	0ff7f793          	zext.b	a5,a5
 4a6:	4625                	li	a2,9
 4a8:	02f66963          	bltu	a2,a5,4da <atoi+0x48>
 4ac:	872a                	mv	a4,a0
  n = 0;
 4ae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4b0:	0705                	addi	a4,a4,1
 4b2:	0025179b          	slliw	a5,a0,0x2
 4b6:	9fa9                	addw	a5,a5,a0
 4b8:	0017979b          	slliw	a5,a5,0x1
 4bc:	9fb5                	addw	a5,a5,a3
 4be:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4c2:	00074683          	lbu	a3,0(a4)
 4c6:	fd06879b          	addiw	a5,a3,-48
 4ca:	0ff7f793          	zext.b	a5,a5
 4ce:	fef671e3          	bgeu	a2,a5,4b0 <atoi+0x1e>
  return n;
}
 4d2:	60a2                	ld	ra,8(sp)
 4d4:	6402                	ld	s0,0(sp)
 4d6:	0141                	addi	sp,sp,16
 4d8:	8082                	ret
  n = 0;
 4da:	4501                	li	a0,0
 4dc:	bfdd                	j	4d2 <atoi+0x40>

00000000000004de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4de:	1141                	addi	sp,sp,-16
 4e0:	e406                	sd	ra,8(sp)
 4e2:	e022                	sd	s0,0(sp)
 4e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4e6:	02b57563          	bgeu	a0,a1,510 <memmove+0x32>
    while(n-- > 0)
 4ea:	00c05f63          	blez	a2,508 <memmove+0x2a>
 4ee:	1602                	slli	a2,a2,0x20
 4f0:	9201                	srli	a2,a2,0x20
 4f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 4f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 4f8:	0585                	addi	a1,a1,1
 4fa:	0705                	addi	a4,a4,1
 4fc:	fff5c683          	lbu	a3,-1(a1)
 500:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 504:	fee79ae3          	bne	a5,a4,4f8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 508:	60a2                	ld	ra,8(sp)
 50a:	6402                	ld	s0,0(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret
    dst += n;
 510:	00c50733          	add	a4,a0,a2
    src += n;
 514:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 516:	fec059e3          	blez	a2,508 <memmove+0x2a>
 51a:	fff6079b          	addiw	a5,a2,-1
 51e:	1782                	slli	a5,a5,0x20
 520:	9381                	srli	a5,a5,0x20
 522:	fff7c793          	not	a5,a5
 526:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 528:	15fd                	addi	a1,a1,-1
 52a:	177d                	addi	a4,a4,-1
 52c:	0005c683          	lbu	a3,0(a1)
 530:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 534:	fef71ae3          	bne	a4,a5,528 <memmove+0x4a>
 538:	bfc1                	j	508 <memmove+0x2a>

000000000000053a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 53a:	1141                	addi	sp,sp,-16
 53c:	e406                	sd	ra,8(sp)
 53e:	e022                	sd	s0,0(sp)
 540:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 542:	ca0d                	beqz	a2,574 <memcmp+0x3a>
 544:	fff6069b          	addiw	a3,a2,-1
 548:	1682                	slli	a3,a3,0x20
 54a:	9281                	srli	a3,a3,0x20
 54c:	0685                	addi	a3,a3,1
 54e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 550:	00054783          	lbu	a5,0(a0)
 554:	0005c703          	lbu	a4,0(a1)
 558:	00e79863          	bne	a5,a4,568 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 55c:	0505                	addi	a0,a0,1
    p2++;
 55e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 560:	fed518e3          	bne	a0,a3,550 <memcmp+0x16>
  }
  return 0;
 564:	4501                	li	a0,0
 566:	a019                	j	56c <memcmp+0x32>
      return *p1 - *p2;
 568:	40e7853b          	subw	a0,a5,a4
}
 56c:	60a2                	ld	ra,8(sp)
 56e:	6402                	ld	s0,0(sp)
 570:	0141                	addi	sp,sp,16
 572:	8082                	ret
  return 0;
 574:	4501                	li	a0,0
 576:	bfdd                	j	56c <memcmp+0x32>

0000000000000578 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 578:	1141                	addi	sp,sp,-16
 57a:	e406                	sd	ra,8(sp)
 57c:	e022                	sd	s0,0(sp)
 57e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 580:	f5fff0ef          	jal	4de <memmove>
}
 584:	60a2                	ld	ra,8(sp)
 586:	6402                	ld	s0,0(sp)
 588:	0141                	addi	sp,sp,16
 58a:	8082                	ret

000000000000058c <sbrk>:

char *
sbrk(int n) {
 58c:	1141                	addi	sp,sp,-16
 58e:	e406                	sd	ra,8(sp)
 590:	e022                	sd	s0,0(sp)
 592:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 594:	4585                	li	a1,1
 596:	0b2000ef          	jal	648 <sys_sbrk>
}
 59a:	60a2                	ld	ra,8(sp)
 59c:	6402                	ld	s0,0(sp)
 59e:	0141                	addi	sp,sp,16
 5a0:	8082                	ret

00000000000005a2 <sbrklazy>:

char *
sbrklazy(int n) {
 5a2:	1141                	addi	sp,sp,-16
 5a4:	e406                	sd	ra,8(sp)
 5a6:	e022                	sd	s0,0(sp)
 5a8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 5aa:	4589                	li	a1,2
 5ac:	09c000ef          	jal	648 <sys_sbrk>
}
 5b0:	60a2                	ld	ra,8(sp)
 5b2:	6402                	ld	s0,0(sp)
 5b4:	0141                	addi	sp,sp,16
 5b6:	8082                	ret

00000000000005b8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b8:	4885                	li	a7,1
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5c0:	4889                	li	a7,2
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c8:	488d                	li	a7,3
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5d0:	4891                	li	a7,4
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <read>:
.global read
read:
 li a7, SYS_read
 5d8:	4895                	li	a7,5
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <write>:
.global write
write:
 li a7, SYS_write
 5e0:	48c1                	li	a7,16
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <close>:
.global close
close:
 li a7, SYS_close
 5e8:	48d5                	li	a7,21
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5f0:	4899                	li	a7,6
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f8:	489d                	li	a7,7
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <open>:
.global open
open:
 li a7, SYS_open
 600:	48bd                	li	a7,15
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 608:	48c5                	li	a7,17
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 610:	48c9                	li	a7,18
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 618:	48a1                	li	a7,8
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <link>:
.global link
link:
 li a7, SYS_link
 620:	48cd                	li	a7,19
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 628:	48d1                	li	a7,20
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 630:	48a5                	li	a7,9
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <dup>:
.global dup
dup:
 li a7, SYS_dup
 638:	48a9                	li	a7,10
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 640:	48ad                	li	a7,11
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 648:	48b1                	li	a7,12
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <pause>:
.global pause
pause:
 li a7, SYS_pause
 650:	48b5                	li	a7,13
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 658:	48b9                	li	a7,14
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 660:	1101                	addi	sp,sp,-32
 662:	ec06                	sd	ra,24(sp)
 664:	e822                	sd	s0,16(sp)
 666:	1000                	addi	s0,sp,32
 668:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 66c:	4605                	li	a2,1
 66e:	fef40593          	addi	a1,s0,-17
 672:	f6fff0ef          	jal	5e0 <write>
}
 676:	60e2                	ld	ra,24(sp)
 678:	6442                	ld	s0,16(sp)
 67a:	6105                	addi	sp,sp,32
 67c:	8082                	ret

000000000000067e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 67e:	715d                	addi	sp,sp,-80
 680:	e486                	sd	ra,72(sp)
 682:	e0a2                	sd	s0,64(sp)
 684:	fc26                	sd	s1,56(sp)
 686:	f84a                	sd	s2,48(sp)
 688:	f44e                	sd	s3,40(sp)
 68a:	0880                	addi	s0,sp,80
 68c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 68e:	c299                	beqz	a3,694 <printint+0x16>
 690:	0605cf63          	bltz	a1,70e <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 694:	2581                	sext.w	a1,a1
  neg = 0;
 696:	4e01                	li	t3,0
  }

  i = 0;
 698:	fb840313          	addi	t1,s0,-72
  neg = 0;
 69c:	869a                	mv	a3,t1
  i = 0;
 69e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 6a0:	00000817          	auipc	a6,0x0
 6a4:	5b880813          	addi	a6,a6,1464 # c58 <digits>
 6a8:	88be                	mv	a7,a5
 6aa:	0017851b          	addiw	a0,a5,1
 6ae:	87aa                	mv	a5,a0
 6b0:	02c5f73b          	remuw	a4,a1,a2
 6b4:	1702                	slli	a4,a4,0x20
 6b6:	9301                	srli	a4,a4,0x20
 6b8:	9742                	add	a4,a4,a6
 6ba:	00074703          	lbu	a4,0(a4)
 6be:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 6c2:	872e                	mv	a4,a1
 6c4:	02c5d5bb          	divuw	a1,a1,a2
 6c8:	0685                	addi	a3,a3,1
 6ca:	fcc77fe3          	bgeu	a4,a2,6a8 <printint+0x2a>
  if(neg)
 6ce:	000e0c63          	beqz	t3,6e6 <printint+0x68>
    buf[i++] = '-';
 6d2:	fd050793          	addi	a5,a0,-48
 6d6:	00878533          	add	a0,a5,s0
 6da:	02d00793          	li	a5,45
 6de:	fef50423          	sb	a5,-24(a0)
 6e2:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 6e6:	fff7899b          	addiw	s3,a5,-1
 6ea:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 6ee:	fff4c583          	lbu	a1,-1(s1)
 6f2:	854a                	mv	a0,s2
 6f4:	f6dff0ef          	jal	660 <putc>
  while(--i >= 0)
 6f8:	39fd                	addiw	s3,s3,-1
 6fa:	14fd                	addi	s1,s1,-1
 6fc:	fe09d9e3          	bgez	s3,6ee <printint+0x70>
}
 700:	60a6                	ld	ra,72(sp)
 702:	6406                	ld	s0,64(sp)
 704:	74e2                	ld	s1,56(sp)
 706:	7942                	ld	s2,48(sp)
 708:	79a2                	ld	s3,40(sp)
 70a:	6161                	addi	sp,sp,80
 70c:	8082                	ret
    x = -xx;
 70e:	40b005bb          	negw	a1,a1
    neg = 1;
 712:	4e05                	li	t3,1
    x = -xx;
 714:	b751                	j	698 <printint+0x1a>

0000000000000716 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 716:	711d                	addi	sp,sp,-96
 718:	ec86                	sd	ra,88(sp)
 71a:	e8a2                	sd	s0,80(sp)
 71c:	e4a6                	sd	s1,72(sp)
 71e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 720:	0005c483          	lbu	s1,0(a1)
 724:	28048463          	beqz	s1,9ac <vprintf+0x296>
 728:	e0ca                	sd	s2,64(sp)
 72a:	fc4e                	sd	s3,56(sp)
 72c:	f852                	sd	s4,48(sp)
 72e:	f456                	sd	s5,40(sp)
 730:	f05a                	sd	s6,32(sp)
 732:	ec5e                	sd	s7,24(sp)
 734:	e862                	sd	s8,16(sp)
 736:	e466                	sd	s9,8(sp)
 738:	8b2a                	mv	s6,a0
 73a:	8a2e                	mv	s4,a1
 73c:	8bb2                	mv	s7,a2
  state = 0;
 73e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 740:	4901                	li	s2,0
 742:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 744:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 748:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 74c:	06c00c93          	li	s9,108
 750:	a00d                	j	772 <vprintf+0x5c>
        putc(fd, c0);
 752:	85a6                	mv	a1,s1
 754:	855a                	mv	a0,s6
 756:	f0bff0ef          	jal	660 <putc>
 75a:	a019                	j	760 <vprintf+0x4a>
    } else if(state == '%'){
 75c:	03598363          	beq	s3,s5,782 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 760:	0019079b          	addiw	a5,s2,1
 764:	893e                	mv	s2,a5
 766:	873e                	mv	a4,a5
 768:	97d2                	add	a5,a5,s4
 76a:	0007c483          	lbu	s1,0(a5)
 76e:	22048763          	beqz	s1,99c <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 772:	0004879b          	sext.w	a5,s1
    if(state == 0){
 776:	fe0993e3          	bnez	s3,75c <vprintf+0x46>
      if(c0 == '%'){
 77a:	fd579ce3          	bne	a5,s5,752 <vprintf+0x3c>
        state = '%';
 77e:	89be                	mv	s3,a5
 780:	b7c5                	j	760 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 782:	00ea06b3          	add	a3,s4,a4
 786:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 78a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 78c:	c681                	beqz	a3,794 <vprintf+0x7e>
 78e:	9752                	add	a4,a4,s4
 790:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 794:	05878263          	beq	a5,s8,7d8 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 798:	05978c63          	beq	a5,s9,7f0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 79c:	07500713          	li	a4,117
 7a0:	0ee78663          	beq	a5,a4,88c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 7a4:	07800713          	li	a4,120
 7a8:	12e78863          	beq	a5,a4,8d8 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 7ac:	07000713          	li	a4,112
 7b0:	14e78d63          	beq	a5,a4,90a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 7b4:	06300713          	li	a4,99
 7b8:	18e78c63          	beq	a5,a4,950 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 7bc:	07300713          	li	a4,115
 7c0:	1ae78263          	beq	a5,a4,964 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 7c4:	02500713          	li	a4,37
 7c8:	04e79463          	bne	a5,a4,810 <vprintf+0xfa>
        putc(fd, '%');
 7cc:	85ba                	mv	a1,a4
 7ce:	855a                	mv	a0,s6
 7d0:	e91ff0ef          	jal	660 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 7d4:	4981                	li	s3,0
 7d6:	b769                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 7d8:	008b8493          	addi	s1,s7,8
 7dc:	4685                	li	a3,1
 7de:	4629                	li	a2,10
 7e0:	000ba583          	lw	a1,0(s7)
 7e4:	855a                	mv	a0,s6
 7e6:	e99ff0ef          	jal	67e <printint>
 7ea:	8ba6                	mv	s7,s1
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	bf8d                	j	760 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 7f0:	06400793          	li	a5,100
 7f4:	02f68963          	beq	a3,a5,826 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7f8:	06c00793          	li	a5,108
 7fc:	04f68263          	beq	a3,a5,840 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 800:	07500793          	li	a5,117
 804:	0af68063          	beq	a3,a5,8a4 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 808:	07800793          	li	a5,120
 80c:	0ef68263          	beq	a3,a5,8f0 <vprintf+0x1da>
        putc(fd, '%');
 810:	02500593          	li	a1,37
 814:	855a                	mv	a0,s6
 816:	e4bff0ef          	jal	660 <putc>
        putc(fd, c0);
 81a:	85a6                	mv	a1,s1
 81c:	855a                	mv	a0,s6
 81e:	e43ff0ef          	jal	660 <putc>
      state = 0;
 822:	4981                	li	s3,0
 824:	bf35                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 826:	008b8493          	addi	s1,s7,8
 82a:	4685                	li	a3,1
 82c:	4629                	li	a2,10
 82e:	000bb583          	ld	a1,0(s7)
 832:	855a                	mv	a0,s6
 834:	e4bff0ef          	jal	67e <printint>
        i += 1;
 838:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 83a:	8ba6                	mv	s7,s1
      state = 0;
 83c:	4981                	li	s3,0
        i += 1;
 83e:	b70d                	j	760 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 840:	06400793          	li	a5,100
 844:	02f60763          	beq	a2,a5,872 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 848:	07500793          	li	a5,117
 84c:	06f60963          	beq	a2,a5,8be <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 850:	07800793          	li	a5,120
 854:	faf61ee3          	bne	a2,a5,810 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 858:	008b8493          	addi	s1,s7,8
 85c:	4681                	li	a3,0
 85e:	4641                	li	a2,16
 860:	000bb583          	ld	a1,0(s7)
 864:	855a                	mv	a0,s6
 866:	e19ff0ef          	jal	67e <printint>
        i += 2;
 86a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 86c:	8ba6                	mv	s7,s1
      state = 0;
 86e:	4981                	li	s3,0
        i += 2;
 870:	bdc5                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 872:	008b8493          	addi	s1,s7,8
 876:	4685                	li	a3,1
 878:	4629                	li	a2,10
 87a:	000bb583          	ld	a1,0(s7)
 87e:	855a                	mv	a0,s6
 880:	dffff0ef          	jal	67e <printint>
        i += 2;
 884:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 886:	8ba6                	mv	s7,s1
      state = 0;
 888:	4981                	li	s3,0
        i += 2;
 88a:	bdd9                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 88c:	008b8493          	addi	s1,s7,8
 890:	4681                	li	a3,0
 892:	4629                	li	a2,10
 894:	000be583          	lwu	a1,0(s7)
 898:	855a                	mv	a0,s6
 89a:	de5ff0ef          	jal	67e <printint>
 89e:	8ba6                	mv	s7,s1
      state = 0;
 8a0:	4981                	li	s3,0
 8a2:	bd7d                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8a4:	008b8493          	addi	s1,s7,8
 8a8:	4681                	li	a3,0
 8aa:	4629                	li	a2,10
 8ac:	000bb583          	ld	a1,0(s7)
 8b0:	855a                	mv	a0,s6
 8b2:	dcdff0ef          	jal	67e <printint>
        i += 1;
 8b6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b8:	8ba6                	mv	s7,s1
      state = 0;
 8ba:	4981                	li	s3,0
        i += 1;
 8bc:	b555                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8be:	008b8493          	addi	s1,s7,8
 8c2:	4681                	li	a3,0
 8c4:	4629                	li	a2,10
 8c6:	000bb583          	ld	a1,0(s7)
 8ca:	855a                	mv	a0,s6
 8cc:	db3ff0ef          	jal	67e <printint>
        i += 2;
 8d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 8d2:	8ba6                	mv	s7,s1
      state = 0;
 8d4:	4981                	li	s3,0
        i += 2;
 8d6:	b569                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 8d8:	008b8493          	addi	s1,s7,8
 8dc:	4681                	li	a3,0
 8de:	4641                	li	a2,16
 8e0:	000be583          	lwu	a1,0(s7)
 8e4:	855a                	mv	a0,s6
 8e6:	d99ff0ef          	jal	67e <printint>
 8ea:	8ba6                	mv	s7,s1
      state = 0;
 8ec:	4981                	li	s3,0
 8ee:	bd8d                	j	760 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 8f0:	008b8493          	addi	s1,s7,8
 8f4:	4681                	li	a3,0
 8f6:	4641                	li	a2,16
 8f8:	000bb583          	ld	a1,0(s7)
 8fc:	855a                	mv	a0,s6
 8fe:	d81ff0ef          	jal	67e <printint>
        i += 1;
 902:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 904:	8ba6                	mv	s7,s1
      state = 0;
 906:	4981                	li	s3,0
        i += 1;
 908:	bda1                	j	760 <vprintf+0x4a>
 90a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 90c:	008b8d13          	addi	s10,s7,8
 910:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 914:	03000593          	li	a1,48
 918:	855a                	mv	a0,s6
 91a:	d47ff0ef          	jal	660 <putc>
  putc(fd, 'x');
 91e:	07800593          	li	a1,120
 922:	855a                	mv	a0,s6
 924:	d3dff0ef          	jal	660 <putc>
 928:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 92a:	00000b97          	auipc	s7,0x0
 92e:	32eb8b93          	addi	s7,s7,814 # c58 <digits>
 932:	03c9d793          	srli	a5,s3,0x3c
 936:	97de                	add	a5,a5,s7
 938:	0007c583          	lbu	a1,0(a5)
 93c:	855a                	mv	a0,s6
 93e:	d23ff0ef          	jal	660 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 942:	0992                	slli	s3,s3,0x4
 944:	34fd                	addiw	s1,s1,-1
 946:	f4f5                	bnez	s1,932 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 948:	8bea                	mv	s7,s10
      state = 0;
 94a:	4981                	li	s3,0
 94c:	6d02                	ld	s10,0(sp)
 94e:	bd09                	j	760 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 950:	008b8493          	addi	s1,s7,8
 954:	000bc583          	lbu	a1,0(s7)
 958:	855a                	mv	a0,s6
 95a:	d07ff0ef          	jal	660 <putc>
 95e:	8ba6                	mv	s7,s1
      state = 0;
 960:	4981                	li	s3,0
 962:	bbfd                	j	760 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 964:	008b8993          	addi	s3,s7,8
 968:	000bb483          	ld	s1,0(s7)
 96c:	cc91                	beqz	s1,988 <vprintf+0x272>
        for(; *s; s++)
 96e:	0004c583          	lbu	a1,0(s1)
 972:	c195                	beqz	a1,996 <vprintf+0x280>
          putc(fd, *s);
 974:	855a                	mv	a0,s6
 976:	cebff0ef          	jal	660 <putc>
        for(; *s; s++)
 97a:	0485                	addi	s1,s1,1
 97c:	0004c583          	lbu	a1,0(s1)
 980:	f9f5                	bnez	a1,974 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 982:	8bce                	mv	s7,s3
      state = 0;
 984:	4981                	li	s3,0
 986:	bbe9                	j	760 <vprintf+0x4a>
          s = "(null)";
 988:	00000497          	auipc	s1,0x0
 98c:	2c848493          	addi	s1,s1,712 # c50 <malloc+0x1b8>
        for(; *s; s++)
 990:	02800593          	li	a1,40
 994:	b7c5                	j	974 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 996:	8bce                	mv	s7,s3
      state = 0;
 998:	4981                	li	s3,0
 99a:	b3d9                	j	760 <vprintf+0x4a>
 99c:	6906                	ld	s2,64(sp)
 99e:	79e2                	ld	s3,56(sp)
 9a0:	7a42                	ld	s4,48(sp)
 9a2:	7aa2                	ld	s5,40(sp)
 9a4:	7b02                	ld	s6,32(sp)
 9a6:	6be2                	ld	s7,24(sp)
 9a8:	6c42                	ld	s8,16(sp)
 9aa:	6ca2                	ld	s9,8(sp)
    }
  }
}
 9ac:	60e6                	ld	ra,88(sp)
 9ae:	6446                	ld	s0,80(sp)
 9b0:	64a6                	ld	s1,72(sp)
 9b2:	6125                	addi	sp,sp,96
 9b4:	8082                	ret

00000000000009b6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9b6:	715d                	addi	sp,sp,-80
 9b8:	ec06                	sd	ra,24(sp)
 9ba:	e822                	sd	s0,16(sp)
 9bc:	1000                	addi	s0,sp,32
 9be:	e010                	sd	a2,0(s0)
 9c0:	e414                	sd	a3,8(s0)
 9c2:	e818                	sd	a4,16(s0)
 9c4:	ec1c                	sd	a5,24(s0)
 9c6:	03043023          	sd	a6,32(s0)
 9ca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9ce:	8622                	mv	a2,s0
 9d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9d4:	d43ff0ef          	jal	716 <vprintf>
}
 9d8:	60e2                	ld	ra,24(sp)
 9da:	6442                	ld	s0,16(sp)
 9dc:	6161                	addi	sp,sp,80
 9de:	8082                	ret

00000000000009e0 <printf>:

void
printf(const char *fmt, ...)
{
 9e0:	711d                	addi	sp,sp,-96
 9e2:	ec06                	sd	ra,24(sp)
 9e4:	e822                	sd	s0,16(sp)
 9e6:	1000                	addi	s0,sp,32
 9e8:	e40c                	sd	a1,8(s0)
 9ea:	e810                	sd	a2,16(s0)
 9ec:	ec14                	sd	a3,24(s0)
 9ee:	f018                	sd	a4,32(s0)
 9f0:	f41c                	sd	a5,40(s0)
 9f2:	03043823          	sd	a6,48(s0)
 9f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9fa:	00840613          	addi	a2,s0,8
 9fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a02:	85aa                	mv	a1,a0
 a04:	4505                	li	a0,1
 a06:	d11ff0ef          	jal	716 <vprintf>
}
 a0a:	60e2                	ld	ra,24(sp)
 a0c:	6442                	ld	s0,16(sp)
 a0e:	6125                	addi	sp,sp,96
 a10:	8082                	ret

0000000000000a12 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a12:	1141                	addi	sp,sp,-16
 a14:	e406                	sd	ra,8(sp)
 a16:	e022                	sd	s0,0(sp)
 a18:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a1a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a1e:	00001797          	auipc	a5,0x1
 a22:	5e27b783          	ld	a5,1506(a5) # 2000 <freep>
 a26:	a02d                	j	a50 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a28:	4618                	lw	a4,8(a2)
 a2a:	9f2d                	addw	a4,a4,a1
 a2c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a30:	6398                	ld	a4,0(a5)
 a32:	6310                	ld	a2,0(a4)
 a34:	a83d                	j	a72 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a36:	ff852703          	lw	a4,-8(a0)
 a3a:	9f31                	addw	a4,a4,a2
 a3c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 a3e:	ff053683          	ld	a3,-16(a0)
 a42:	a091                	j	a86 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a44:	6398                	ld	a4,0(a5)
 a46:	00e7e463          	bltu	a5,a4,a4e <free+0x3c>
 a4a:	00e6ea63          	bltu	a3,a4,a5e <free+0x4c>
{
 a4e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a50:	fed7fae3          	bgeu	a5,a3,a44 <free+0x32>
 a54:	6398                	ld	a4,0(a5)
 a56:	00e6e463          	bltu	a3,a4,a5e <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5a:	fee7eae3          	bltu	a5,a4,a4e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 a5e:	ff852583          	lw	a1,-8(a0)
 a62:	6390                	ld	a2,0(a5)
 a64:	02059813          	slli	a6,a1,0x20
 a68:	01c85713          	srli	a4,a6,0x1c
 a6c:	9736                	add	a4,a4,a3
 a6e:	fae60de3          	beq	a2,a4,a28 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 a72:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a76:	4790                	lw	a2,8(a5)
 a78:	02061593          	slli	a1,a2,0x20
 a7c:	01c5d713          	srli	a4,a1,0x1c
 a80:	973e                	add	a4,a4,a5
 a82:	fae68ae3          	beq	a3,a4,a36 <free+0x24>
    p->s.ptr = bp->s.ptr;
 a86:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a88:	00001717          	auipc	a4,0x1
 a8c:	56f73c23          	sd	a5,1400(a4) # 2000 <freep>
}
 a90:	60a2                	ld	ra,8(sp)
 a92:	6402                	ld	s0,0(sp)
 a94:	0141                	addi	sp,sp,16
 a96:	8082                	ret

0000000000000a98 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a98:	7139                	addi	sp,sp,-64
 a9a:	fc06                	sd	ra,56(sp)
 a9c:	f822                	sd	s0,48(sp)
 a9e:	f04a                	sd	s2,32(sp)
 aa0:	ec4e                	sd	s3,24(sp)
 aa2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa4:	02051993          	slli	s3,a0,0x20
 aa8:	0209d993          	srli	s3,s3,0x20
 aac:	09bd                	addi	s3,s3,15
 aae:	0049d993          	srli	s3,s3,0x4
 ab2:	2985                	addiw	s3,s3,1
 ab4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 ab6:	00001517          	auipc	a0,0x1
 aba:	54a53503          	ld	a0,1354(a0) # 2000 <freep>
 abe:	c905                	beqz	a0,aee <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac2:	4798                	lw	a4,8(a5)
 ac4:	09377663          	bgeu	a4,s3,b50 <malloc+0xb8>
 ac8:	f426                	sd	s1,40(sp)
 aca:	e852                	sd	s4,16(sp)
 acc:	e456                	sd	s5,8(sp)
 ace:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 ad0:	8a4e                	mv	s4,s3
 ad2:	6705                	lui	a4,0x1
 ad4:	00e9f363          	bgeu	s3,a4,ada <malloc+0x42>
 ad8:	6a05                	lui	s4,0x1
 ada:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ade:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae2:	00001497          	auipc	s1,0x1
 ae6:	51e48493          	addi	s1,s1,1310 # 2000 <freep>
  if(p == SBRK_ERROR)
 aea:	5afd                	li	s5,-1
 aec:	a83d                	j	b2a <malloc+0x92>
 aee:	f426                	sd	s1,40(sp)
 af0:	e852                	sd	s4,16(sp)
 af2:	e456                	sd	s5,8(sp)
 af4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 af6:	00001797          	auipc	a5,0x1
 afa:	51a78793          	addi	a5,a5,1306 # 2010 <base>
 afe:	00001717          	auipc	a4,0x1
 b02:	50f73123          	sd	a5,1282(a4) # 2000 <freep>
 b06:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b08:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b0c:	b7d1                	j	ad0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 b0e:	6398                	ld	a4,0(a5)
 b10:	e118                	sd	a4,0(a0)
 b12:	a899                	j	b68 <malloc+0xd0>
  hp->s.size = nu;
 b14:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b18:	0541                	addi	a0,a0,16
 b1a:	ef9ff0ef          	jal	a12 <free>
  return freep;
 b1e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 b20:	c125                	beqz	a0,b80 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b22:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b24:	4798                	lw	a4,8(a5)
 b26:	03277163          	bgeu	a4,s2,b48 <malloc+0xb0>
    if(p == freep)
 b2a:	6098                	ld	a4,0(s1)
 b2c:	853e                	mv	a0,a5
 b2e:	fef71ae3          	bne	a4,a5,b22 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 b32:	8552                	mv	a0,s4
 b34:	a59ff0ef          	jal	58c <sbrk>
  if(p == SBRK_ERROR)
 b38:	fd551ee3          	bne	a0,s5,b14 <malloc+0x7c>
        return 0;
 b3c:	4501                	li	a0,0
 b3e:	74a2                	ld	s1,40(sp)
 b40:	6a42                	ld	s4,16(sp)
 b42:	6aa2                	ld	s5,8(sp)
 b44:	6b02                	ld	s6,0(sp)
 b46:	a03d                	j	b74 <malloc+0xdc>
 b48:	74a2                	ld	s1,40(sp)
 b4a:	6a42                	ld	s4,16(sp)
 b4c:	6aa2                	ld	s5,8(sp)
 b4e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 b50:	fae90fe3          	beq	s2,a4,b0e <malloc+0x76>
        p->s.size -= nunits;
 b54:	4137073b          	subw	a4,a4,s3
 b58:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b5a:	02071693          	slli	a3,a4,0x20
 b5e:	01c6d713          	srli	a4,a3,0x1c
 b62:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b64:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b68:	00001717          	auipc	a4,0x1
 b6c:	48a73c23          	sd	a0,1176(a4) # 2000 <freep>
      return (void*)(p + 1);
 b70:	01078513          	addi	a0,a5,16
  }
}
 b74:	70e2                	ld	ra,56(sp)
 b76:	7442                	ld	s0,48(sp)
 b78:	7902                	ld	s2,32(sp)
 b7a:	69e2                	ld	s3,24(sp)
 b7c:	6121                	addi	sp,sp,64
 b7e:	8082                	ret
 b80:	74a2                	ld	s1,40(sp)
 b82:	6a42                	ld	s4,16(sp)
 b84:	6aa2                	ld	s5,8(sp)
 b86:	6b02                	ld	s6,0(sp)
 b88:	b7f5                	j	b74 <malloc+0xdc>
