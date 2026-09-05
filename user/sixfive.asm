
user/_sixfive:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <sixfive>:
#include "user/user.h"

#define SEPARATORS " -\r\t\n./,"

void
sixfive(int fd) {
   0:	7159                	addi	sp,sp,-112
   2:	f486                	sd	ra,104(sp)
   4:	f0a2                	sd	s0,96(sp)
   6:	eca6                	sd	s1,88(sp)
   8:	e8ca                	sd	s2,80(sp)
   a:	e4ce                	sd	s3,72(sp)
   c:	e0d2                	sd	s4,64(sp)
   e:	fc56                	sd	s5,56(sp)
  10:	f85a                	sd	s6,48(sp)
  12:	f45e                	sd	s7,40(sp)
  14:	f062                	sd	s8,32(sp)
  16:	ec66                	sd	s9,24(sp)
  18:	1880                	addi	s0,sp,112
  1a:	89aa                	mv	s3,a0
    char c, prev;
    int n;

    prev = '\0';
  1c:	4481                	li	s1,0

    while(read(fd, &c, 1) == 1) {
  1e:	f9f40a13          	addi	s4,s0,-97
  22:	4905                	li	s2,1
        if (c >= '0' && c <= '9' && (prev == '\0' || strchr(SEPARATORS, prev) != 0)) {
  24:	4aa5                	li	s5,9
                n = n * 10 + (c - '0');
                prev = c;
                if (read(fd, &c, 1) != 1) break;
            } while(c >= '0' && c <= '9');

            if (n % 6 == 0 || n % 5 == 0) printf("%d\n", n);
  26:	2aaabb37          	lui	s6,0x2aaab
  2a:	aabb0b13          	addi	s6,s6,-1365 # 2aaaaaab <base+0x2aaa9a9b>
  2e:	00001c17          	auipc	s8,0x1
  32:	a02c0c13          	addi	s8,s8,-1534 # a30 <malloc+0x106>
  36:	66666bb7          	lui	s7,0x66666
  3a:	667b8b93          	addi	s7,s7,1639 # 66666667 <base+0x66665657>
    while(read(fd, &c, 1) == 1) {
  3e:	a019                	j	44 <sixfive+0x44>

            prev = c;
        } else {
            prev = c;
  40:	f9f44483          	lbu	s1,-97(s0)
    while(read(fd, &c, 1) == 1) {
  44:	864a                	mv	a2,s2
  46:	85d2                	mv	a1,s4
  48:	854e                	mv	a0,s3
  4a:	420000ef          	jal	46a <read>
  4e:	0b251063          	bne	a0,s2,ee <sixfive+0xee>
        if (c >= '0' && c <= '9' && (prev == '\0' || strchr(SEPARATORS, prev) != 0)) {
  52:	f9f44783          	lbu	a5,-97(s0)
  56:	fd07879b          	addiw	a5,a5,-48
  5a:	0ff7f793          	zext.b	a5,a5
  5e:	fefae1e3          	bltu	s5,a5,40 <sixfive+0x40>
  62:	c889                	beqz	s1,74 <sixfive+0x74>
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	9ba50513          	addi	a0,a0,-1606 # a20 <malloc+0xf6>
  6e:	1d0000ef          	jal	23e <strchr>
  72:	d579                	beqz	a0,40 <sixfive+0x40>
sixfive(int fd) {
  74:	4c81                	li	s9,0
                n = n * 10 + (c - '0');
  76:	002c979b          	slliw	a5,s9,0x2
  7a:	019787bb          	addw	a5,a5,s9
  7e:	0017979b          	slliw	a5,a5,0x1
  82:	f9f44483          	lbu	s1,-97(s0)
  86:	fd04849b          	addiw	s1,s1,-48
  8a:	9cbd                	addw	s1,s1,a5
  8c:	8ca6                	mv	s9,s1
                if (read(fd, &c, 1) != 1) break;
  8e:	864a                	mv	a2,s2
  90:	85d2                	mv	a1,s4
  92:	854e                	mv	a0,s3
  94:	3d6000ef          	jal	46a <read>
  98:	01251a63          	bne	a0,s2,ac <sixfive+0xac>
            } while(c >= '0' && c <= '9');
  9c:	f9f44783          	lbu	a5,-97(s0)
  a0:	fd07879b          	addiw	a5,a5,-48
  a4:	0ff7f793          	zext.b	a5,a5
  a8:	fcfaf7e3          	bgeu	s5,a5,76 <sixfive+0x76>
            if (n % 6 == 0 || n % 5 == 0) printf("%d\n", n);
  ac:	03648733          	mul	a4,s1,s6
  b0:	9301                	srli	a4,a4,0x20
  b2:	41f4d79b          	sraiw	a5,s1,0x1f
  b6:	9f1d                	subw	a4,a4,a5
  b8:	0017179b          	slliw	a5,a4,0x1
  bc:	9fb9                	addw	a5,a5,a4
  be:	0017979b          	slliw	a5,a5,0x1
  c2:	40f487bb          	subw	a5,s1,a5
  c6:	cf89                	beqz	a5,e0 <sixfive+0xe0>
  c8:	037487b3          	mul	a5,s1,s7
  cc:	9785                	srai	a5,a5,0x21
  ce:	41f4d71b          	sraiw	a4,s1,0x1f
  d2:	9f99                	subw	a5,a5,a4
  d4:	0027971b          	slliw	a4,a5,0x2
  d8:	9fb9                	addw	a5,a5,a4
  da:	40f487bb          	subw	a5,s1,a5
  de:	e789                	bnez	a5,e8 <sixfive+0xe8>
  e0:	85a6                	mv	a1,s1
  e2:	8562                	mv	a0,s8
  e4:	78e000ef          	jal	872 <printf>
            prev = c;
  e8:	f9f44483          	lbu	s1,-97(s0)
  ec:	bfa1                	j	44 <sixfive+0x44>
        }
    }
}
  ee:	70a6                	ld	ra,104(sp)
  f0:	7406                	ld	s0,96(sp)
  f2:	64e6                	ld	s1,88(sp)
  f4:	6946                	ld	s2,80(sp)
  f6:	69a6                	ld	s3,72(sp)
  f8:	6a06                	ld	s4,64(sp)
  fa:	7ae2                	ld	s5,56(sp)
  fc:	7b42                	ld	s6,48(sp)
  fe:	7ba2                	ld	s7,40(sp)
 100:	7c02                	ld	s8,32(sp)
 102:	6ce2                	ld	s9,24(sp)
 104:	6165                	addi	sp,sp,112
 106:	8082                	ret

0000000000000108 <main>:

int 
main(int argc, char *argv[]) {
 108:	7179                	addi	sp,sp,-48
 10a:	f406                	sd	ra,40(sp)
 10c:	f022                	sd	s0,32(sp)
 10e:	1800                	addi	s0,sp,48
    int fd, i;

    if (argc <= 1) {
 110:	4785                	li	a5,1
 112:	04a7d263          	bge	a5,a0,156 <main+0x4e>
 116:	ec26                	sd	s1,24(sp)
 118:	e84a                	sd	s2,16(sp)
 11a:	e44e                	sd	s3,8(sp)
 11c:	00858913          	addi	s2,a1,8
 120:	ffe5099b          	addiw	s3,a0,-2
 124:	02099793          	slli	a5,s3,0x20
 128:	01d7d993          	srli	s3,a5,0x1d
 12c:	05c1                	addi	a1,a1,16
 12e:	99ae                	add	s3,s3,a1
        fprintf(2, "Usage: sixfive [filename]\n");
        exit(1);
    }

    for (i = 1; i < argc; i++) {
        if ((fd = open(argv[i], O_RDONLY)) < 0) {
 130:	4581                	li	a1,0
 132:	00093503          	ld	a0,0(s2)
 136:	35c000ef          	jal	492 <open>
 13a:	84aa                	mv	s1,a0
 13c:	02054a63          	bltz	a0,170 <main+0x68>
            fprintf(2, "sixfive: cannot open %s\n", argv[i]);
            exit(1);
        }
        sixfive(fd);
 140:	ec1ff0ef          	jal	0 <sixfive>
        close(fd);
 144:	8526                	mv	a0,s1
 146:	334000ef          	jal	47a <close>
    for (i = 1; i < argc; i++) {
 14a:	0921                	addi	s2,s2,8
 14c:	ff3912e3          	bne	s2,s3,130 <main+0x28>
    }

    exit(0);
 150:	4501                	li	a0,0
 152:	300000ef          	jal	452 <exit>
 156:	ec26                	sd	s1,24(sp)
 158:	e84a                	sd	s2,16(sp)
 15a:	e44e                	sd	s3,8(sp)
        fprintf(2, "Usage: sixfive [filename]\n");
 15c:	00001597          	auipc	a1,0x1
 160:	8dc58593          	addi	a1,a1,-1828 # a38 <malloc+0x10e>
 164:	4509                	li	a0,2
 166:	6e2000ef          	jal	848 <fprintf>
        exit(1);
 16a:	4505                	li	a0,1
 16c:	2e6000ef          	jal	452 <exit>
            fprintf(2, "sixfive: cannot open %s\n", argv[i]);
 170:	00093603          	ld	a2,0(s2)
 174:	00001597          	auipc	a1,0x1
 178:	8e458593          	addi	a1,a1,-1820 # a58 <malloc+0x12e>
 17c:	4509                	li	a0,2
 17e:	6ca000ef          	jal	848 <fprintf>
            exit(1);
 182:	4505                	li	a0,1
 184:	2ce000ef          	jal	452 <exit>

0000000000000188 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 188:	1141                	addi	sp,sp,-16
 18a:	e406                	sd	ra,8(sp)
 18c:	e022                	sd	s0,0(sp)
 18e:	0800                	addi	s0,sp,16
  extern int main();
  main();
 190:	f79ff0ef          	jal	108 <main>
  exit(0);
 194:	4501                	li	a0,0
 196:	2bc000ef          	jal	452 <exit>

000000000000019a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 19a:	1141                	addi	sp,sp,-16
 19c:	e406                	sd	ra,8(sp)
 19e:	e022                	sd	s0,0(sp)
 1a0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a2:	87aa                	mv	a5,a0
 1a4:	0585                	addi	a1,a1,1
 1a6:	0785                	addi	a5,a5,1
 1a8:	fff5c703          	lbu	a4,-1(a1)
 1ac:	fee78fa3          	sb	a4,-1(a5)
 1b0:	fb75                	bnez	a4,1a4 <strcpy+0xa>
    ;
  return os;
}
 1b2:	60a2                	ld	ra,8(sp)
 1b4:	6402                	ld	s0,0(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1ba:	1141                	addi	sp,sp,-16
 1bc:	e406                	sd	ra,8(sp)
 1be:	e022                	sd	s0,0(sp)
 1c0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 1c2:	00054783          	lbu	a5,0(a0)
 1c6:	cb91                	beqz	a5,1da <strcmp+0x20>
 1c8:	0005c703          	lbu	a4,0(a1)
 1cc:	00f71763          	bne	a4,a5,1da <strcmp+0x20>
    p++, q++;
 1d0:	0505                	addi	a0,a0,1
 1d2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1d4:	00054783          	lbu	a5,0(a0)
 1d8:	fbe5                	bnez	a5,1c8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1da:	0005c503          	lbu	a0,0(a1)
}
 1de:	40a7853b          	subw	a0,a5,a0
 1e2:	60a2                	ld	ra,8(sp)
 1e4:	6402                	ld	s0,0(sp)
 1e6:	0141                	addi	sp,sp,16
 1e8:	8082                	ret

00000000000001ea <strlen>:

uint
strlen(const char *s)
{
 1ea:	1141                	addi	sp,sp,-16
 1ec:	e406                	sd	ra,8(sp)
 1ee:	e022                	sd	s0,0(sp)
 1f0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1f2:	00054783          	lbu	a5,0(a0)
 1f6:	cf99                	beqz	a5,214 <strlen+0x2a>
 1f8:	0505                	addi	a0,a0,1
 1fa:	87aa                	mv	a5,a0
 1fc:	86be                	mv	a3,a5
 1fe:	0785                	addi	a5,a5,1
 200:	fff7c703          	lbu	a4,-1(a5)
 204:	ff65                	bnez	a4,1fc <strlen+0x12>
 206:	40a6853b          	subw	a0,a3,a0
 20a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 20c:	60a2                	ld	ra,8(sp)
 20e:	6402                	ld	s0,0(sp)
 210:	0141                	addi	sp,sp,16
 212:	8082                	ret
  for(n = 0; s[n]; n++)
 214:	4501                	li	a0,0
 216:	bfdd                	j	20c <strlen+0x22>

0000000000000218 <memset>:

void*
memset(void *dst, int c, uint n)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e406                	sd	ra,8(sp)
 21c:	e022                	sd	s0,0(sp)
 21e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 220:	ca19                	beqz	a2,236 <memset+0x1e>
 222:	87aa                	mv	a5,a0
 224:	1602                	slli	a2,a2,0x20
 226:	9201                	srli	a2,a2,0x20
 228:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 22c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 230:	0785                	addi	a5,a5,1
 232:	fee79de3          	bne	a5,a4,22c <memset+0x14>
  }
  return dst;
}
 236:	60a2                	ld	ra,8(sp)
 238:	6402                	ld	s0,0(sp)
 23a:	0141                	addi	sp,sp,16
 23c:	8082                	ret

000000000000023e <strchr>:

char*
strchr(const char *s, char c)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e406                	sd	ra,8(sp)
 242:	e022                	sd	s0,0(sp)
 244:	0800                	addi	s0,sp,16
  for(; *s; s++)
 246:	00054783          	lbu	a5,0(a0)
 24a:	cf81                	beqz	a5,262 <strchr+0x24>
    if(*s == c)
 24c:	00f58763          	beq	a1,a5,25a <strchr+0x1c>
  for(; *s; s++)
 250:	0505                	addi	a0,a0,1
 252:	00054783          	lbu	a5,0(a0)
 256:	fbfd                	bnez	a5,24c <strchr+0xe>
      return (char*)s;
  return 0;
 258:	4501                	li	a0,0
}
 25a:	60a2                	ld	ra,8(sp)
 25c:	6402                	ld	s0,0(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret
  return 0;
 262:	4501                	li	a0,0
 264:	bfdd                	j	25a <strchr+0x1c>

0000000000000266 <gets>:

char*
gets(char *buf, int max)
{
 266:	7159                	addi	sp,sp,-112
 268:	f486                	sd	ra,104(sp)
 26a:	f0a2                	sd	s0,96(sp)
 26c:	eca6                	sd	s1,88(sp)
 26e:	e8ca                	sd	s2,80(sp)
 270:	e4ce                	sd	s3,72(sp)
 272:	e0d2                	sd	s4,64(sp)
 274:	fc56                	sd	s5,56(sp)
 276:	f85a                	sd	s6,48(sp)
 278:	f45e                	sd	s7,40(sp)
 27a:	f062                	sd	s8,32(sp)
 27c:	ec66                	sd	s9,24(sp)
 27e:	e86a                	sd	s10,16(sp)
 280:	1880                	addi	s0,sp,112
 282:	8caa                	mv	s9,a0
 284:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 286:	892a                	mv	s2,a0
 288:	4481                	li	s1,0
    cc = read(0, &c, 1);
 28a:	f9f40b13          	addi	s6,s0,-97
 28e:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 290:	4ba9                	li	s7,10
 292:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 294:	8d26                	mv	s10,s1
 296:	0014899b          	addiw	s3,s1,1
 29a:	84ce                	mv	s1,s3
 29c:	0349d563          	bge	s3,s4,2c6 <gets+0x60>
    cc = read(0, &c, 1);
 2a0:	8656                	mv	a2,s5
 2a2:	85da                	mv	a1,s6
 2a4:	4501                	li	a0,0
 2a6:	1c4000ef          	jal	46a <read>
    if(cc < 1)
 2aa:	00a05e63          	blez	a0,2c6 <gets+0x60>
    buf[i++] = c;
 2ae:	f9f44783          	lbu	a5,-97(s0)
 2b2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 2b6:	01778763          	beq	a5,s7,2c4 <gets+0x5e>
 2ba:	0905                	addi	s2,s2,1
 2bc:	fd879ce3          	bne	a5,s8,294 <gets+0x2e>
    buf[i++] = c;
 2c0:	8d4e                	mv	s10,s3
 2c2:	a011                	j	2c6 <gets+0x60>
 2c4:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 2c6:	9d66                	add	s10,s10,s9
 2c8:	000d0023          	sb	zero,0(s10)
  return buf;
}
 2cc:	8566                	mv	a0,s9
 2ce:	70a6                	ld	ra,104(sp)
 2d0:	7406                	ld	s0,96(sp)
 2d2:	64e6                	ld	s1,88(sp)
 2d4:	6946                	ld	s2,80(sp)
 2d6:	69a6                	ld	s3,72(sp)
 2d8:	6a06                	ld	s4,64(sp)
 2da:	7ae2                	ld	s5,56(sp)
 2dc:	7b42                	ld	s6,48(sp)
 2de:	7ba2                	ld	s7,40(sp)
 2e0:	7c02                	ld	s8,32(sp)
 2e2:	6ce2                	ld	s9,24(sp)
 2e4:	6d42                	ld	s10,16(sp)
 2e6:	6165                	addi	sp,sp,112
 2e8:	8082                	ret

00000000000002ea <stat>:

int
stat(const char *n, struct stat *st)
{
 2ea:	1101                	addi	sp,sp,-32
 2ec:	ec06                	sd	ra,24(sp)
 2ee:	e822                	sd	s0,16(sp)
 2f0:	e04a                	sd	s2,0(sp)
 2f2:	1000                	addi	s0,sp,32
 2f4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f6:	4581                	li	a1,0
 2f8:	19a000ef          	jal	492 <open>
  if(fd < 0)
 2fc:	02054263          	bltz	a0,320 <stat+0x36>
 300:	e426                	sd	s1,8(sp)
 302:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 304:	85ca                	mv	a1,s2
 306:	1a4000ef          	jal	4aa <fstat>
 30a:	892a                	mv	s2,a0
  close(fd);
 30c:	8526                	mv	a0,s1
 30e:	16c000ef          	jal	47a <close>
  return r;
 312:	64a2                	ld	s1,8(sp)
}
 314:	854a                	mv	a0,s2
 316:	60e2                	ld	ra,24(sp)
 318:	6442                	ld	s0,16(sp)
 31a:	6902                	ld	s2,0(sp)
 31c:	6105                	addi	sp,sp,32
 31e:	8082                	ret
    return -1;
 320:	597d                	li	s2,-1
 322:	bfcd                	j	314 <stat+0x2a>

0000000000000324 <atoi>:

int
atoi(const char *s)
{
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 32c:	00054683          	lbu	a3,0(a0)
 330:	fd06879b          	addiw	a5,a3,-48
 334:	0ff7f793          	zext.b	a5,a5
 338:	4625                	li	a2,9
 33a:	02f66963          	bltu	a2,a5,36c <atoi+0x48>
 33e:	872a                	mv	a4,a0
  n = 0;
 340:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 342:	0705                	addi	a4,a4,1
 344:	0025179b          	slliw	a5,a0,0x2
 348:	9fa9                	addw	a5,a5,a0
 34a:	0017979b          	slliw	a5,a5,0x1
 34e:	9fb5                	addw	a5,a5,a3
 350:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 354:	00074683          	lbu	a3,0(a4)
 358:	fd06879b          	addiw	a5,a3,-48
 35c:	0ff7f793          	zext.b	a5,a5
 360:	fef671e3          	bgeu	a2,a5,342 <atoi+0x1e>
  return n;
}
 364:	60a2                	ld	ra,8(sp)
 366:	6402                	ld	s0,0(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret
  n = 0;
 36c:	4501                	li	a0,0
 36e:	bfdd                	j	364 <atoi+0x40>

0000000000000370 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 370:	1141                	addi	sp,sp,-16
 372:	e406                	sd	ra,8(sp)
 374:	e022                	sd	s0,0(sp)
 376:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 378:	02b57563          	bgeu	a0,a1,3a2 <memmove+0x32>
    while(n-- > 0)
 37c:	00c05f63          	blez	a2,39a <memmove+0x2a>
 380:	1602                	slli	a2,a2,0x20
 382:	9201                	srli	a2,a2,0x20
 384:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 388:	872a                	mv	a4,a0
      *dst++ = *src++;
 38a:	0585                	addi	a1,a1,1
 38c:	0705                	addi	a4,a4,1
 38e:	fff5c683          	lbu	a3,-1(a1)
 392:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 396:	fee79ae3          	bne	a5,a4,38a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 39a:	60a2                	ld	ra,8(sp)
 39c:	6402                	ld	s0,0(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret
    dst += n;
 3a2:	00c50733          	add	a4,a0,a2
    src += n;
 3a6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 3a8:	fec059e3          	blez	a2,39a <memmove+0x2a>
 3ac:	fff6079b          	addiw	a5,a2,-1
 3b0:	1782                	slli	a5,a5,0x20
 3b2:	9381                	srli	a5,a5,0x20
 3b4:	fff7c793          	not	a5,a5
 3b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 3ba:	15fd                	addi	a1,a1,-1
 3bc:	177d                	addi	a4,a4,-1
 3be:	0005c683          	lbu	a3,0(a1)
 3c2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 3c6:	fef71ae3          	bne	a4,a5,3ba <memmove+0x4a>
 3ca:	bfc1                	j	39a <memmove+0x2a>

00000000000003cc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e406                	sd	ra,8(sp)
 3d0:	e022                	sd	s0,0(sp)
 3d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3d4:	ca0d                	beqz	a2,406 <memcmp+0x3a>
 3d6:	fff6069b          	addiw	a3,a2,-1
 3da:	1682                	slli	a3,a3,0x20
 3dc:	9281                	srli	a3,a3,0x20
 3de:	0685                	addi	a3,a3,1
 3e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3e2:	00054783          	lbu	a5,0(a0)
 3e6:	0005c703          	lbu	a4,0(a1)
 3ea:	00e79863          	bne	a5,a4,3fa <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 3ee:	0505                	addi	a0,a0,1
    p2++;
 3f0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3f2:	fed518e3          	bne	a0,a3,3e2 <memcmp+0x16>
  }
  return 0;
 3f6:	4501                	li	a0,0
 3f8:	a019                	j	3fe <memcmp+0x32>
      return *p1 - *p2;
 3fa:	40e7853b          	subw	a0,a5,a4
}
 3fe:	60a2                	ld	ra,8(sp)
 400:	6402                	ld	s0,0(sp)
 402:	0141                	addi	sp,sp,16
 404:	8082                	ret
  return 0;
 406:	4501                	li	a0,0
 408:	bfdd                	j	3fe <memcmp+0x32>

000000000000040a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 40a:	1141                	addi	sp,sp,-16
 40c:	e406                	sd	ra,8(sp)
 40e:	e022                	sd	s0,0(sp)
 410:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 412:	f5fff0ef          	jal	370 <memmove>
}
 416:	60a2                	ld	ra,8(sp)
 418:	6402                	ld	s0,0(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret

000000000000041e <sbrk>:

char *
sbrk(int n) {
 41e:	1141                	addi	sp,sp,-16
 420:	e406                	sd	ra,8(sp)
 422:	e022                	sd	s0,0(sp)
 424:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 426:	4585                	li	a1,1
 428:	0b2000ef          	jal	4da <sys_sbrk>
}
 42c:	60a2                	ld	ra,8(sp)
 42e:	6402                	ld	s0,0(sp)
 430:	0141                	addi	sp,sp,16
 432:	8082                	ret

0000000000000434 <sbrklazy>:

char *
sbrklazy(int n) {
 434:	1141                	addi	sp,sp,-16
 436:	e406                	sd	ra,8(sp)
 438:	e022                	sd	s0,0(sp)
 43a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 43c:	4589                	li	a1,2
 43e:	09c000ef          	jal	4da <sys_sbrk>
}
 442:	60a2                	ld	ra,8(sp)
 444:	6402                	ld	s0,0(sp)
 446:	0141                	addi	sp,sp,16
 448:	8082                	ret

000000000000044a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 44a:	4885                	li	a7,1
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <exit>:
.global exit
exit:
 li a7, SYS_exit
 452:	4889                	li	a7,2
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <wait>:
.global wait
wait:
 li a7, SYS_wait
 45a:	488d                	li	a7,3
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 462:	4891                	li	a7,4
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <read>:
.global read
read:
 li a7, SYS_read
 46a:	4895                	li	a7,5
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <write>:
.global write
write:
 li a7, SYS_write
 472:	48c1                	li	a7,16
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <close>:
.global close
close:
 li a7, SYS_close
 47a:	48d5                	li	a7,21
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <kill>:
.global kill
kill:
 li a7, SYS_kill
 482:	4899                	li	a7,6
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <exec>:
.global exec
exec:
 li a7, SYS_exec
 48a:	489d                	li	a7,7
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <open>:
.global open
open:
 li a7, SYS_open
 492:	48bd                	li	a7,15
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 49a:	48c5                	li	a7,17
 ecall
 49c:	00000073          	ecall
 ret
 4a0:	8082                	ret

00000000000004a2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 4a2:	48c9                	li	a7,18
 ecall
 4a4:	00000073          	ecall
 ret
 4a8:	8082                	ret

00000000000004aa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 4aa:	48a1                	li	a7,8
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <link>:
.global link
link:
 li a7, SYS_link
 4b2:	48cd                	li	a7,19
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 4ba:	48d1                	li	a7,20
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 4c2:	48a5                	li	a7,9
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <dup>:
.global dup
dup:
 li a7, SYS_dup
 4ca:	48a9                	li	a7,10
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4d2:	48ad                	li	a7,11
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4da:	48b1                	li	a7,12
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4e2:	48b5                	li	a7,13
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4ea:	48b9                	li	a7,14
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4f2:	1101                	addi	sp,sp,-32
 4f4:	ec06                	sd	ra,24(sp)
 4f6:	e822                	sd	s0,16(sp)
 4f8:	1000                	addi	s0,sp,32
 4fa:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4fe:	4605                	li	a2,1
 500:	fef40593          	addi	a1,s0,-17
 504:	f6fff0ef          	jal	472 <write>
}
 508:	60e2                	ld	ra,24(sp)
 50a:	6442                	ld	s0,16(sp)
 50c:	6105                	addi	sp,sp,32
 50e:	8082                	ret

0000000000000510 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 510:	715d                	addi	sp,sp,-80
 512:	e486                	sd	ra,72(sp)
 514:	e0a2                	sd	s0,64(sp)
 516:	fc26                	sd	s1,56(sp)
 518:	f84a                	sd	s2,48(sp)
 51a:	f44e                	sd	s3,40(sp)
 51c:	0880                	addi	s0,sp,80
 51e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 520:	c299                	beqz	a3,526 <printint+0x16>
 522:	0605cf63          	bltz	a1,5a0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 526:	2581                	sext.w	a1,a1
  neg = 0;
 528:	4e01                	li	t3,0
  }

  i = 0;
 52a:	fb840313          	addi	t1,s0,-72
  neg = 0;
 52e:	869a                	mv	a3,t1
  i = 0;
 530:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 532:	00000817          	auipc	a6,0x0
 536:	54e80813          	addi	a6,a6,1358 # a80 <digits>
 53a:	88be                	mv	a7,a5
 53c:	0017851b          	addiw	a0,a5,1
 540:	87aa                	mv	a5,a0
 542:	02c5f73b          	remuw	a4,a1,a2
 546:	1702                	slli	a4,a4,0x20
 548:	9301                	srli	a4,a4,0x20
 54a:	9742                	add	a4,a4,a6
 54c:	00074703          	lbu	a4,0(a4)
 550:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 554:	872e                	mv	a4,a1
 556:	02c5d5bb          	divuw	a1,a1,a2
 55a:	0685                	addi	a3,a3,1
 55c:	fcc77fe3          	bgeu	a4,a2,53a <printint+0x2a>
  if(neg)
 560:	000e0c63          	beqz	t3,578 <printint+0x68>
    buf[i++] = '-';
 564:	fd050793          	addi	a5,a0,-48
 568:	00878533          	add	a0,a5,s0
 56c:	02d00793          	li	a5,45
 570:	fef50423          	sb	a5,-24(a0)
 574:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 578:	fff7899b          	addiw	s3,a5,-1
 57c:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 580:	fff4c583          	lbu	a1,-1(s1)
 584:	854a                	mv	a0,s2
 586:	f6dff0ef          	jal	4f2 <putc>
  while(--i >= 0)
 58a:	39fd                	addiw	s3,s3,-1
 58c:	14fd                	addi	s1,s1,-1
 58e:	fe09d9e3          	bgez	s3,580 <printint+0x70>
}
 592:	60a6                	ld	ra,72(sp)
 594:	6406                	ld	s0,64(sp)
 596:	74e2                	ld	s1,56(sp)
 598:	7942                	ld	s2,48(sp)
 59a:	79a2                	ld	s3,40(sp)
 59c:	6161                	addi	sp,sp,80
 59e:	8082                	ret
    x = -xx;
 5a0:	40b005bb          	negw	a1,a1
    neg = 1;
 5a4:	4e05                	li	t3,1
    x = -xx;
 5a6:	b751                	j	52a <printint+0x1a>

00000000000005a8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5a8:	711d                	addi	sp,sp,-96
 5aa:	ec86                	sd	ra,88(sp)
 5ac:	e8a2                	sd	s0,80(sp)
 5ae:	e4a6                	sd	s1,72(sp)
 5b0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5b2:	0005c483          	lbu	s1,0(a1)
 5b6:	28048463          	beqz	s1,83e <vprintf+0x296>
 5ba:	e0ca                	sd	s2,64(sp)
 5bc:	fc4e                	sd	s3,56(sp)
 5be:	f852                	sd	s4,48(sp)
 5c0:	f456                	sd	s5,40(sp)
 5c2:	f05a                	sd	s6,32(sp)
 5c4:	ec5e                	sd	s7,24(sp)
 5c6:	e862                	sd	s8,16(sp)
 5c8:	e466                	sd	s9,8(sp)
 5ca:	8b2a                	mv	s6,a0
 5cc:	8a2e                	mv	s4,a1
 5ce:	8bb2                	mv	s7,a2
  state = 0;
 5d0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5d2:	4901                	li	s2,0
 5d4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5d6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5da:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5de:	06c00c93          	li	s9,108
 5e2:	a00d                	j	604 <vprintf+0x5c>
        putc(fd, c0);
 5e4:	85a6                	mv	a1,s1
 5e6:	855a                	mv	a0,s6
 5e8:	f0bff0ef          	jal	4f2 <putc>
 5ec:	a019                	j	5f2 <vprintf+0x4a>
    } else if(state == '%'){
 5ee:	03598363          	beq	s3,s5,614 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 5f2:	0019079b          	addiw	a5,s2,1
 5f6:	893e                	mv	s2,a5
 5f8:	873e                	mv	a4,a5
 5fa:	97d2                	add	a5,a5,s4
 5fc:	0007c483          	lbu	s1,0(a5)
 600:	22048763          	beqz	s1,82e <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 604:	0004879b          	sext.w	a5,s1
    if(state == 0){
 608:	fe0993e3          	bnez	s3,5ee <vprintf+0x46>
      if(c0 == '%'){
 60c:	fd579ce3          	bne	a5,s5,5e4 <vprintf+0x3c>
        state = '%';
 610:	89be                	mv	s3,a5
 612:	b7c5                	j	5f2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 614:	00ea06b3          	add	a3,s4,a4
 618:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 61c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 61e:	c681                	beqz	a3,626 <vprintf+0x7e>
 620:	9752                	add	a4,a4,s4
 622:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 626:	05878263          	beq	a5,s8,66a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 62a:	05978c63          	beq	a5,s9,682 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 62e:	07500713          	li	a4,117
 632:	0ee78663          	beq	a5,a4,71e <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 636:	07800713          	li	a4,120
 63a:	12e78863          	beq	a5,a4,76a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 63e:	07000713          	li	a4,112
 642:	14e78d63          	beq	a5,a4,79c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 646:	06300713          	li	a4,99
 64a:	18e78c63          	beq	a5,a4,7e2 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 64e:	07300713          	li	a4,115
 652:	1ae78263          	beq	a5,a4,7f6 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 656:	02500713          	li	a4,37
 65a:	04e79463          	bne	a5,a4,6a2 <vprintf+0xfa>
        putc(fd, '%');
 65e:	85ba                	mv	a1,a4
 660:	855a                	mv	a0,s6
 662:	e91ff0ef          	jal	4f2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 666:	4981                	li	s3,0
 668:	b769                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 66a:	008b8493          	addi	s1,s7,8
 66e:	4685                	li	a3,1
 670:	4629                	li	a2,10
 672:	000ba583          	lw	a1,0(s7)
 676:	855a                	mv	a0,s6
 678:	e99ff0ef          	jal	510 <printint>
 67c:	8ba6                	mv	s7,s1
      state = 0;
 67e:	4981                	li	s3,0
 680:	bf8d                	j	5f2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 682:	06400793          	li	a5,100
 686:	02f68963          	beq	a3,a5,6b8 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 68a:	06c00793          	li	a5,108
 68e:	04f68263          	beq	a3,a5,6d2 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 692:	07500793          	li	a5,117
 696:	0af68063          	beq	a3,a5,736 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 69a:	07800793          	li	a5,120
 69e:	0ef68263          	beq	a3,a5,782 <vprintf+0x1da>
        putc(fd, '%');
 6a2:	02500593          	li	a1,37
 6a6:	855a                	mv	a0,s6
 6a8:	e4bff0ef          	jal	4f2 <putc>
        putc(fd, c0);
 6ac:	85a6                	mv	a1,s1
 6ae:	855a                	mv	a0,s6
 6b0:	e43ff0ef          	jal	4f2 <putc>
      state = 0;
 6b4:	4981                	li	s3,0
 6b6:	bf35                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b8:	008b8493          	addi	s1,s7,8
 6bc:	4685                	li	a3,1
 6be:	4629                	li	a2,10
 6c0:	000bb583          	ld	a1,0(s7)
 6c4:	855a                	mv	a0,s6
 6c6:	e4bff0ef          	jal	510 <printint>
        i += 1;
 6ca:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6cc:	8ba6                	mv	s7,s1
      state = 0;
 6ce:	4981                	li	s3,0
        i += 1;
 6d0:	b70d                	j	5f2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6d2:	06400793          	li	a5,100
 6d6:	02f60763          	beq	a2,a5,704 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6da:	07500793          	li	a5,117
 6de:	06f60963          	beq	a2,a5,750 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6e2:	07800793          	li	a5,120
 6e6:	faf61ee3          	bne	a2,a5,6a2 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ea:	008b8493          	addi	s1,s7,8
 6ee:	4681                	li	a3,0
 6f0:	4641                	li	a2,16
 6f2:	000bb583          	ld	a1,0(s7)
 6f6:	855a                	mv	a0,s6
 6f8:	e19ff0ef          	jal	510 <printint>
        i += 2;
 6fc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fe:	8ba6                	mv	s7,s1
      state = 0;
 700:	4981                	li	s3,0
        i += 2;
 702:	bdc5                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 704:	008b8493          	addi	s1,s7,8
 708:	4685                	li	a3,1
 70a:	4629                	li	a2,10
 70c:	000bb583          	ld	a1,0(s7)
 710:	855a                	mv	a0,s6
 712:	dffff0ef          	jal	510 <printint>
        i += 2;
 716:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 718:	8ba6                	mv	s7,s1
      state = 0;
 71a:	4981                	li	s3,0
        i += 2;
 71c:	bdd9                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 71e:	008b8493          	addi	s1,s7,8
 722:	4681                	li	a3,0
 724:	4629                	li	a2,10
 726:	000be583          	lwu	a1,0(s7)
 72a:	855a                	mv	a0,s6
 72c:	de5ff0ef          	jal	510 <printint>
 730:	8ba6                	mv	s7,s1
      state = 0;
 732:	4981                	li	s3,0
 734:	bd7d                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	008b8493          	addi	s1,s7,8
 73a:	4681                	li	a3,0
 73c:	4629                	li	a2,10
 73e:	000bb583          	ld	a1,0(s7)
 742:	855a                	mv	a0,s6
 744:	dcdff0ef          	jal	510 <printint>
        i += 1;
 748:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 74a:	8ba6                	mv	s7,s1
      state = 0;
 74c:	4981                	li	s3,0
        i += 1;
 74e:	b555                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 750:	008b8493          	addi	s1,s7,8
 754:	4681                	li	a3,0
 756:	4629                	li	a2,10
 758:	000bb583          	ld	a1,0(s7)
 75c:	855a                	mv	a0,s6
 75e:	db3ff0ef          	jal	510 <printint>
        i += 2;
 762:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 764:	8ba6                	mv	s7,s1
      state = 0;
 766:	4981                	li	s3,0
        i += 2;
 768:	b569                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 76a:	008b8493          	addi	s1,s7,8
 76e:	4681                	li	a3,0
 770:	4641                	li	a2,16
 772:	000be583          	lwu	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	d99ff0ef          	jal	510 <printint>
 77c:	8ba6                	mv	s7,s1
      state = 0;
 77e:	4981                	li	s3,0
 780:	bd8d                	j	5f2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 782:	008b8493          	addi	s1,s7,8
 786:	4681                	li	a3,0
 788:	4641                	li	a2,16
 78a:	000bb583          	ld	a1,0(s7)
 78e:	855a                	mv	a0,s6
 790:	d81ff0ef          	jal	510 <printint>
        i += 1;
 794:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 796:	8ba6                	mv	s7,s1
      state = 0;
 798:	4981                	li	s3,0
        i += 1;
 79a:	bda1                	j	5f2 <vprintf+0x4a>
 79c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 79e:	008b8d13          	addi	s10,s7,8
 7a2:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7a6:	03000593          	li	a1,48
 7aa:	855a                	mv	a0,s6
 7ac:	d47ff0ef          	jal	4f2 <putc>
  putc(fd, 'x');
 7b0:	07800593          	li	a1,120
 7b4:	855a                	mv	a0,s6
 7b6:	d3dff0ef          	jal	4f2 <putc>
 7ba:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7bc:	00000b97          	auipc	s7,0x0
 7c0:	2c4b8b93          	addi	s7,s7,708 # a80 <digits>
 7c4:	03c9d793          	srli	a5,s3,0x3c
 7c8:	97de                	add	a5,a5,s7
 7ca:	0007c583          	lbu	a1,0(a5)
 7ce:	855a                	mv	a0,s6
 7d0:	d23ff0ef          	jal	4f2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d4:	0992                	slli	s3,s3,0x4
 7d6:	34fd                	addiw	s1,s1,-1
 7d8:	f4f5                	bnez	s1,7c4 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7da:	8bea                	mv	s7,s10
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	6d02                	ld	s10,0(sp)
 7e0:	bd09                	j	5f2 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7e2:	008b8493          	addi	s1,s7,8
 7e6:	000bc583          	lbu	a1,0(s7)
 7ea:	855a                	mv	a0,s6
 7ec:	d07ff0ef          	jal	4f2 <putc>
 7f0:	8ba6                	mv	s7,s1
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	bbfd                	j	5f2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7f6:	008b8993          	addi	s3,s7,8
 7fa:	000bb483          	ld	s1,0(s7)
 7fe:	cc91                	beqz	s1,81a <vprintf+0x272>
        for(; *s; s++)
 800:	0004c583          	lbu	a1,0(s1)
 804:	c195                	beqz	a1,828 <vprintf+0x280>
          putc(fd, *s);
 806:	855a                	mv	a0,s6
 808:	cebff0ef          	jal	4f2 <putc>
        for(; *s; s++)
 80c:	0485                	addi	s1,s1,1
 80e:	0004c583          	lbu	a1,0(s1)
 812:	f9f5                	bnez	a1,806 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 814:	8bce                	mv	s7,s3
      state = 0;
 816:	4981                	li	s3,0
 818:	bbe9                	j	5f2 <vprintf+0x4a>
          s = "(null)";
 81a:	00000497          	auipc	s1,0x0
 81e:	25e48493          	addi	s1,s1,606 # a78 <malloc+0x14e>
        for(; *s; s++)
 822:	02800593          	li	a1,40
 826:	b7c5                	j	806 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 828:	8bce                	mv	s7,s3
      state = 0;
 82a:	4981                	li	s3,0
 82c:	b3d9                	j	5f2 <vprintf+0x4a>
 82e:	6906                	ld	s2,64(sp)
 830:	79e2                	ld	s3,56(sp)
 832:	7a42                	ld	s4,48(sp)
 834:	7aa2                	ld	s5,40(sp)
 836:	7b02                	ld	s6,32(sp)
 838:	6be2                	ld	s7,24(sp)
 83a:	6c42                	ld	s8,16(sp)
 83c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 83e:	60e6                	ld	ra,88(sp)
 840:	6446                	ld	s0,80(sp)
 842:	64a6                	ld	s1,72(sp)
 844:	6125                	addi	sp,sp,96
 846:	8082                	ret

0000000000000848 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 848:	715d                	addi	sp,sp,-80
 84a:	ec06                	sd	ra,24(sp)
 84c:	e822                	sd	s0,16(sp)
 84e:	1000                	addi	s0,sp,32
 850:	e010                	sd	a2,0(s0)
 852:	e414                	sd	a3,8(s0)
 854:	e818                	sd	a4,16(s0)
 856:	ec1c                	sd	a5,24(s0)
 858:	03043023          	sd	a6,32(s0)
 85c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 860:	8622                	mv	a2,s0
 862:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 866:	d43ff0ef          	jal	5a8 <vprintf>
}
 86a:	60e2                	ld	ra,24(sp)
 86c:	6442                	ld	s0,16(sp)
 86e:	6161                	addi	sp,sp,80
 870:	8082                	ret

0000000000000872 <printf>:

void
printf(const char *fmt, ...)
{
 872:	711d                	addi	sp,sp,-96
 874:	ec06                	sd	ra,24(sp)
 876:	e822                	sd	s0,16(sp)
 878:	1000                	addi	s0,sp,32
 87a:	e40c                	sd	a1,8(s0)
 87c:	e810                	sd	a2,16(s0)
 87e:	ec14                	sd	a3,24(s0)
 880:	f018                	sd	a4,32(s0)
 882:	f41c                	sd	a5,40(s0)
 884:	03043823          	sd	a6,48(s0)
 888:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 88c:	00840613          	addi	a2,s0,8
 890:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 894:	85aa                	mv	a1,a0
 896:	4505                	li	a0,1
 898:	d11ff0ef          	jal	5a8 <vprintf>
}
 89c:	60e2                	ld	ra,24(sp)
 89e:	6442                	ld	s0,16(sp)
 8a0:	6125                	addi	sp,sp,96
 8a2:	8082                	ret

00000000000008a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8a4:	1141                	addi	sp,sp,-16
 8a6:	e406                	sd	ra,8(sp)
 8a8:	e022                	sd	s0,0(sp)
 8aa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8ac:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b0:	00000797          	auipc	a5,0x0
 8b4:	7507b783          	ld	a5,1872(a5) # 1000 <freep>
 8b8:	a02d                	j	8e2 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8ba:	4618                	lw	a4,8(a2)
 8bc:	9f2d                	addw	a4,a4,a1
 8be:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8c2:	6398                	ld	a4,0(a5)
 8c4:	6310                	ld	a2,0(a4)
 8c6:	a83d                	j	904 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c8:	ff852703          	lw	a4,-8(a0)
 8cc:	9f31                	addw	a4,a4,a2
 8ce:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8d0:	ff053683          	ld	a3,-16(a0)
 8d4:	a091                	j	918 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d6:	6398                	ld	a4,0(a5)
 8d8:	00e7e463          	bltu	a5,a4,8e0 <free+0x3c>
 8dc:	00e6ea63          	bltu	a3,a4,8f0 <free+0x4c>
{
 8e0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e2:	fed7fae3          	bgeu	a5,a3,8d6 <free+0x32>
 8e6:	6398                	ld	a4,0(a5)
 8e8:	00e6e463          	bltu	a3,a4,8f0 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ec:	fee7eae3          	bltu	a5,a4,8e0 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 8f0:	ff852583          	lw	a1,-8(a0)
 8f4:	6390                	ld	a2,0(a5)
 8f6:	02059813          	slli	a6,a1,0x20
 8fa:	01c85713          	srli	a4,a6,0x1c
 8fe:	9736                	add	a4,a4,a3
 900:	fae60de3          	beq	a2,a4,8ba <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 904:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 908:	4790                	lw	a2,8(a5)
 90a:	02061593          	slli	a1,a2,0x20
 90e:	01c5d713          	srli	a4,a1,0x1c
 912:	973e                	add	a4,a4,a5
 914:	fae68ae3          	beq	a3,a4,8c8 <free+0x24>
    p->s.ptr = bp->s.ptr;
 918:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 91a:	00000717          	auipc	a4,0x0
 91e:	6ef73323          	sd	a5,1766(a4) # 1000 <freep>
}
 922:	60a2                	ld	ra,8(sp)
 924:	6402                	ld	s0,0(sp)
 926:	0141                	addi	sp,sp,16
 928:	8082                	ret

000000000000092a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 92a:	7139                	addi	sp,sp,-64
 92c:	fc06                	sd	ra,56(sp)
 92e:	f822                	sd	s0,48(sp)
 930:	f04a                	sd	s2,32(sp)
 932:	ec4e                	sd	s3,24(sp)
 934:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 936:	02051993          	slli	s3,a0,0x20
 93a:	0209d993          	srli	s3,s3,0x20
 93e:	09bd                	addi	s3,s3,15
 940:	0049d993          	srli	s3,s3,0x4
 944:	2985                	addiw	s3,s3,1
 946:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 948:	00000517          	auipc	a0,0x0
 94c:	6b853503          	ld	a0,1720(a0) # 1000 <freep>
 950:	c905                	beqz	a0,980 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 952:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 954:	4798                	lw	a4,8(a5)
 956:	09377663          	bgeu	a4,s3,9e2 <malloc+0xb8>
 95a:	f426                	sd	s1,40(sp)
 95c:	e852                	sd	s4,16(sp)
 95e:	e456                	sd	s5,8(sp)
 960:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 962:	8a4e                	mv	s4,s3
 964:	6705                	lui	a4,0x1
 966:	00e9f363          	bgeu	s3,a4,96c <malloc+0x42>
 96a:	6a05                	lui	s4,0x1
 96c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 970:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 974:	00000497          	auipc	s1,0x0
 978:	68c48493          	addi	s1,s1,1676 # 1000 <freep>
  if(p == SBRK_ERROR)
 97c:	5afd                	li	s5,-1
 97e:	a83d                	j	9bc <malloc+0x92>
 980:	f426                	sd	s1,40(sp)
 982:	e852                	sd	s4,16(sp)
 984:	e456                	sd	s5,8(sp)
 986:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 988:	00000797          	auipc	a5,0x0
 98c:	68878793          	addi	a5,a5,1672 # 1010 <base>
 990:	00000717          	auipc	a4,0x0
 994:	66f73823          	sd	a5,1648(a4) # 1000 <freep>
 998:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 99a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 99e:	b7d1                	j	962 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 9a0:	6398                	ld	a4,0(a5)
 9a2:	e118                	sd	a4,0(a0)
 9a4:	a899                	j	9fa <malloc+0xd0>
  hp->s.size = nu;
 9a6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9aa:	0541                	addi	a0,a0,16
 9ac:	ef9ff0ef          	jal	8a4 <free>
  return freep;
 9b0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 9b2:	c125                	beqz	a0,a12 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b6:	4798                	lw	a4,8(a5)
 9b8:	03277163          	bgeu	a4,s2,9da <malloc+0xb0>
    if(p == freep)
 9bc:	6098                	ld	a4,0(s1)
 9be:	853e                	mv	a0,a5
 9c0:	fef71ae3          	bne	a4,a5,9b4 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 9c4:	8552                	mv	a0,s4
 9c6:	a59ff0ef          	jal	41e <sbrk>
  if(p == SBRK_ERROR)
 9ca:	fd551ee3          	bne	a0,s5,9a6 <malloc+0x7c>
        return 0;
 9ce:	4501                	li	a0,0
 9d0:	74a2                	ld	s1,40(sp)
 9d2:	6a42                	ld	s4,16(sp)
 9d4:	6aa2                	ld	s5,8(sp)
 9d6:	6b02                	ld	s6,0(sp)
 9d8:	a03d                	j	a06 <malloc+0xdc>
 9da:	74a2                	ld	s1,40(sp)
 9dc:	6a42                	ld	s4,16(sp)
 9de:	6aa2                	ld	s5,8(sp)
 9e0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9e2:	fae90fe3          	beq	s2,a4,9a0 <malloc+0x76>
        p->s.size -= nunits;
 9e6:	4137073b          	subw	a4,a4,s3
 9ea:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ec:	02071693          	slli	a3,a4,0x20
 9f0:	01c6d713          	srli	a4,a3,0x1c
 9f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9fa:	00000717          	auipc	a4,0x0
 9fe:	60a73323          	sd	a0,1542(a4) # 1000 <freep>
      return (void*)(p + 1);
 a02:	01078513          	addi	a0,a5,16
  }
}
 a06:	70e2                	ld	ra,56(sp)
 a08:	7442                	ld	s0,48(sp)
 a0a:	7902                	ld	s2,32(sp)
 a0c:	69e2                	ld	s3,24(sp)
 a0e:	6121                	addi	sp,sp,64
 a10:	8082                	ret
 a12:	74a2                	ld	s1,40(sp)
 a14:	6a42                	ld	s4,16(sp)
 a16:	6aa2                	ld	s5,8(sp)
 a18:	6b02                	ld	s6,0(sp)
 a1a:	b7f5                	j	a06 <malloc+0xdc>
