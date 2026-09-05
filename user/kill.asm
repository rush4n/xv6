
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	1c8000ef          	jal	1f0 <atoi>
  2c:	322000ef          	jal	34e <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	2e6000ef          	jal	31e <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	8b058593          	addi	a1,a1,-1872 # 8f0 <malloc+0xfa>
  48:	4509                	li	a0,2
  4a:	6ca000ef          	jal	714 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	2ce000ef          	jal	31e <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  5c:	fa5ff0ef          	jal	0 <main>
  exit(0);
  60:	4501                	li	a0,0
  62:	2bc000ef          	jal	31e <exit>

0000000000000066 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	87aa                	mv	a5,a0
  70:	0585                	addi	a1,a1,1
  72:	0785                	addi	a5,a5,1
  74:	fff5c703          	lbu	a4,-1(a1)
  78:	fee78fa3          	sb	a4,-1(a5)
  7c:	fb75                	bnez	a4,70 <strcpy+0xa>
    ;
  return os;
}
  7e:	60a2                	ld	ra,8(sp)
  80:	6402                	ld	s0,0(sp)
  82:	0141                	addi	sp,sp,16
  84:	8082                	ret

0000000000000086 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  86:	1141                	addi	sp,sp,-16
  88:	e406                	sd	ra,8(sp)
  8a:	e022                	sd	s0,0(sp)
  8c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  8e:	00054783          	lbu	a5,0(a0)
  92:	cb91                	beqz	a5,a6 <strcmp+0x20>
  94:	0005c703          	lbu	a4,0(a1)
  98:	00f71763          	bne	a4,a5,a6 <strcmp+0x20>
    p++, q++;
  9c:	0505                	addi	a0,a0,1
  9e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  a0:	00054783          	lbu	a5,0(a0)
  a4:	fbe5                	bnez	a5,94 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  a6:	0005c503          	lbu	a0,0(a1)
}
  aa:	40a7853b          	subw	a0,a5,a0
  ae:	60a2                	ld	ra,8(sp)
  b0:	6402                	ld	s0,0(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strlen>:

uint
strlen(const char *s)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e406                	sd	ra,8(sp)
  ba:	e022                	sd	s0,0(sp)
  bc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  be:	00054783          	lbu	a5,0(a0)
  c2:	cf99                	beqz	a5,e0 <strlen+0x2a>
  c4:	0505                	addi	a0,a0,1
  c6:	87aa                	mv	a5,a0
  c8:	86be                	mv	a3,a5
  ca:	0785                	addi	a5,a5,1
  cc:	fff7c703          	lbu	a4,-1(a5)
  d0:	ff65                	bnez	a4,c8 <strlen+0x12>
  d2:	40a6853b          	subw	a0,a3,a0
  d6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  d8:	60a2                	ld	ra,8(sp)
  da:	6402                	ld	s0,0(sp)
  dc:	0141                	addi	sp,sp,16
  de:	8082                	ret
  for(n = 0; s[n]; n++)
  e0:	4501                	li	a0,0
  e2:	bfdd                	j	d8 <strlen+0x22>

00000000000000e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e4:	1141                	addi	sp,sp,-16
  e6:	e406                	sd	ra,8(sp)
  e8:	e022                	sd	s0,0(sp)
  ea:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ec:	ca19                	beqz	a2,102 <memset+0x1e>
  ee:	87aa                	mv	a5,a0
  f0:	1602                	slli	a2,a2,0x20
  f2:	9201                	srli	a2,a2,0x20
  f4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  f8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fc:	0785                	addi	a5,a5,1
  fe:	fee79de3          	bne	a5,a4,f8 <memset+0x14>
  }
  return dst;
}
 102:	60a2                	ld	ra,8(sp)
 104:	6402                	ld	s0,0(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret

000000000000010a <strchr>:

char*
strchr(const char *s, char c)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e406                	sd	ra,8(sp)
 10e:	e022                	sd	s0,0(sp)
 110:	0800                	addi	s0,sp,16
  for(; *s; s++)
 112:	00054783          	lbu	a5,0(a0)
 116:	cf81                	beqz	a5,12e <strchr+0x24>
    if(*s == c)
 118:	00f58763          	beq	a1,a5,126 <strchr+0x1c>
  for(; *s; s++)
 11c:	0505                	addi	a0,a0,1
 11e:	00054783          	lbu	a5,0(a0)
 122:	fbfd                	bnez	a5,118 <strchr+0xe>
      return (char*)s;
  return 0;
 124:	4501                	li	a0,0
}
 126:	60a2                	ld	ra,8(sp)
 128:	6402                	ld	s0,0(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret
  return 0;
 12e:	4501                	li	a0,0
 130:	bfdd                	j	126 <strchr+0x1c>

0000000000000132 <gets>:

char*
gets(char *buf, int max)
{
 132:	7159                	addi	sp,sp,-112
 134:	f486                	sd	ra,104(sp)
 136:	f0a2                	sd	s0,96(sp)
 138:	eca6                	sd	s1,88(sp)
 13a:	e8ca                	sd	s2,80(sp)
 13c:	e4ce                	sd	s3,72(sp)
 13e:	e0d2                	sd	s4,64(sp)
 140:	fc56                	sd	s5,56(sp)
 142:	f85a                	sd	s6,48(sp)
 144:	f45e                	sd	s7,40(sp)
 146:	f062                	sd	s8,32(sp)
 148:	ec66                	sd	s9,24(sp)
 14a:	e86a                	sd	s10,16(sp)
 14c:	1880                	addi	s0,sp,112
 14e:	8caa                	mv	s9,a0
 150:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 152:	892a                	mv	s2,a0
 154:	4481                	li	s1,0
    cc = read(0, &c, 1);
 156:	f9f40b13          	addi	s6,s0,-97
 15a:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 15c:	4ba9                	li	s7,10
 15e:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 160:	8d26                	mv	s10,s1
 162:	0014899b          	addiw	s3,s1,1
 166:	84ce                	mv	s1,s3
 168:	0349d563          	bge	s3,s4,192 <gets+0x60>
    cc = read(0, &c, 1);
 16c:	8656                	mv	a2,s5
 16e:	85da                	mv	a1,s6
 170:	4501                	li	a0,0
 172:	1c4000ef          	jal	336 <read>
    if(cc < 1)
 176:	00a05e63          	blez	a0,192 <gets+0x60>
    buf[i++] = c;
 17a:	f9f44783          	lbu	a5,-97(s0)
 17e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 182:	01778763          	beq	a5,s7,190 <gets+0x5e>
 186:	0905                	addi	s2,s2,1
 188:	fd879ce3          	bne	a5,s8,160 <gets+0x2e>
    buf[i++] = c;
 18c:	8d4e                	mv	s10,s3
 18e:	a011                	j	192 <gets+0x60>
 190:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 192:	9d66                	add	s10,s10,s9
 194:	000d0023          	sb	zero,0(s10)
  return buf;
}
 198:	8566                	mv	a0,s9
 19a:	70a6                	ld	ra,104(sp)
 19c:	7406                	ld	s0,96(sp)
 19e:	64e6                	ld	s1,88(sp)
 1a0:	6946                	ld	s2,80(sp)
 1a2:	69a6                	ld	s3,72(sp)
 1a4:	6a06                	ld	s4,64(sp)
 1a6:	7ae2                	ld	s5,56(sp)
 1a8:	7b42                	ld	s6,48(sp)
 1aa:	7ba2                	ld	s7,40(sp)
 1ac:	7c02                	ld	s8,32(sp)
 1ae:	6ce2                	ld	s9,24(sp)
 1b0:	6d42                	ld	s10,16(sp)
 1b2:	6165                	addi	sp,sp,112
 1b4:	8082                	ret

00000000000001b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b6:	1101                	addi	sp,sp,-32
 1b8:	ec06                	sd	ra,24(sp)
 1ba:	e822                	sd	s0,16(sp)
 1bc:	e04a                	sd	s2,0(sp)
 1be:	1000                	addi	s0,sp,32
 1c0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c2:	4581                	li	a1,0
 1c4:	19a000ef          	jal	35e <open>
  if(fd < 0)
 1c8:	02054263          	bltz	a0,1ec <stat+0x36>
 1cc:	e426                	sd	s1,8(sp)
 1ce:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d0:	85ca                	mv	a1,s2
 1d2:	1a4000ef          	jal	376 <fstat>
 1d6:	892a                	mv	s2,a0
  close(fd);
 1d8:	8526                	mv	a0,s1
 1da:	16c000ef          	jal	346 <close>
  return r;
 1de:	64a2                	ld	s1,8(sp)
}
 1e0:	854a                	mv	a0,s2
 1e2:	60e2                	ld	ra,24(sp)
 1e4:	6442                	ld	s0,16(sp)
 1e6:	6902                	ld	s2,0(sp)
 1e8:	6105                	addi	sp,sp,32
 1ea:	8082                	ret
    return -1;
 1ec:	597d                	li	s2,-1
 1ee:	bfcd                	j	1e0 <stat+0x2a>

00000000000001f0 <atoi>:

int
atoi(const char *s)
{
 1f0:	1141                	addi	sp,sp,-16
 1f2:	e406                	sd	ra,8(sp)
 1f4:	e022                	sd	s0,0(sp)
 1f6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f8:	00054683          	lbu	a3,0(a0)
 1fc:	fd06879b          	addiw	a5,a3,-48
 200:	0ff7f793          	zext.b	a5,a5
 204:	4625                	li	a2,9
 206:	02f66963          	bltu	a2,a5,238 <atoi+0x48>
 20a:	872a                	mv	a4,a0
  n = 0;
 20c:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 20e:	0705                	addi	a4,a4,1
 210:	0025179b          	slliw	a5,a0,0x2
 214:	9fa9                	addw	a5,a5,a0
 216:	0017979b          	slliw	a5,a5,0x1
 21a:	9fb5                	addw	a5,a5,a3
 21c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 220:	00074683          	lbu	a3,0(a4)
 224:	fd06879b          	addiw	a5,a3,-48
 228:	0ff7f793          	zext.b	a5,a5
 22c:	fef671e3          	bgeu	a2,a5,20e <atoi+0x1e>
  return n;
}
 230:	60a2                	ld	ra,8(sp)
 232:	6402                	ld	s0,0(sp)
 234:	0141                	addi	sp,sp,16
 236:	8082                	ret
  n = 0;
 238:	4501                	li	a0,0
 23a:	bfdd                	j	230 <atoi+0x40>

000000000000023c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 23c:	1141                	addi	sp,sp,-16
 23e:	e406                	sd	ra,8(sp)
 240:	e022                	sd	s0,0(sp)
 242:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 244:	02b57563          	bgeu	a0,a1,26e <memmove+0x32>
    while(n-- > 0)
 248:	00c05f63          	blez	a2,266 <memmove+0x2a>
 24c:	1602                	slli	a2,a2,0x20
 24e:	9201                	srli	a2,a2,0x20
 250:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 254:	872a                	mv	a4,a0
      *dst++ = *src++;
 256:	0585                	addi	a1,a1,1
 258:	0705                	addi	a4,a4,1
 25a:	fff5c683          	lbu	a3,-1(a1)
 25e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 262:	fee79ae3          	bne	a5,a4,256 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 266:	60a2                	ld	ra,8(sp)
 268:	6402                	ld	s0,0(sp)
 26a:	0141                	addi	sp,sp,16
 26c:	8082                	ret
    dst += n;
 26e:	00c50733          	add	a4,a0,a2
    src += n;
 272:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 274:	fec059e3          	blez	a2,266 <memmove+0x2a>
 278:	fff6079b          	addiw	a5,a2,-1
 27c:	1782                	slli	a5,a5,0x20
 27e:	9381                	srli	a5,a5,0x20
 280:	fff7c793          	not	a5,a5
 284:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 286:	15fd                	addi	a1,a1,-1
 288:	177d                	addi	a4,a4,-1
 28a:	0005c683          	lbu	a3,0(a1)
 28e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 292:	fef71ae3          	bne	a4,a5,286 <memmove+0x4a>
 296:	bfc1                	j	266 <memmove+0x2a>

0000000000000298 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 298:	1141                	addi	sp,sp,-16
 29a:	e406                	sd	ra,8(sp)
 29c:	e022                	sd	s0,0(sp)
 29e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a0:	ca0d                	beqz	a2,2d2 <memcmp+0x3a>
 2a2:	fff6069b          	addiw	a3,a2,-1
 2a6:	1682                	slli	a3,a3,0x20
 2a8:	9281                	srli	a3,a3,0x20
 2aa:	0685                	addi	a3,a3,1
 2ac:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	00e79863          	bne	a5,a4,2c6 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2ba:	0505                	addi	a0,a0,1
    p2++;
 2bc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2be:	fed518e3          	bne	a0,a3,2ae <memcmp+0x16>
  }
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	a019                	j	2ca <memcmp+0x32>
      return *p1 - *p2;
 2c6:	40e7853b          	subw	a0,a5,a4
}
 2ca:	60a2                	ld	ra,8(sp)
 2cc:	6402                	ld	s0,0(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfdd                	j	2ca <memcmp+0x32>

00000000000002d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2de:	f5fff0ef          	jal	23c <memmove>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <sbrk>:

char *
sbrk(int n) {
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2f2:	4585                	li	a1,1
 2f4:	0b2000ef          	jal	3a6 <sys_sbrk>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <sbrklazy>:

char *
sbrklazy(int n) {
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 308:	4589                	li	a1,2
 30a:	09c000ef          	jal	3a6 <sys_sbrk>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 316:	4885                	li	a7,1
 ecall
 318:	00000073          	ecall
 ret
 31c:	8082                	ret

000000000000031e <exit>:
.global exit
exit:
 li a7, SYS_exit
 31e:	4889                	li	a7,2
 ecall
 320:	00000073          	ecall
 ret
 324:	8082                	ret

0000000000000326 <wait>:
.global wait
wait:
 li a7, SYS_wait
 326:	488d                	li	a7,3
 ecall
 328:	00000073          	ecall
 ret
 32c:	8082                	ret

000000000000032e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 32e:	4891                	li	a7,4
 ecall
 330:	00000073          	ecall
 ret
 334:	8082                	ret

0000000000000336 <read>:
.global read
read:
 li a7, SYS_read
 336:	4895                	li	a7,5
 ecall
 338:	00000073          	ecall
 ret
 33c:	8082                	ret

000000000000033e <write>:
.global write
write:
 li a7, SYS_write
 33e:	48c1                	li	a7,16
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <close>:
.global close
close:
 li a7, SYS_close
 346:	48d5                	li	a7,21
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <kill>:
.global kill
kill:
 li a7, SYS_kill
 34e:	4899                	li	a7,6
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exec>:
.global exec
exec:
 li a7, SYS_exec
 356:	489d                	li	a7,7
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <open>:
.global open
open:
 li a7, SYS_open
 35e:	48bd                	li	a7,15
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 366:	48c5                	li	a7,17
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 36e:	48c9                	li	a7,18
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 376:	48a1                	li	a7,8
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <link>:
.global link
link:
 li a7, SYS_link
 37e:	48cd                	li	a7,19
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 386:	48d1                	li	a7,20
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 38e:	48a5                	li	a7,9
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <dup>:
.global dup
dup:
 li a7, SYS_dup
 396:	48a9                	li	a7,10
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 39e:	48ad                	li	a7,11
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3a6:	48b1                	li	a7,12
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <pause>:
.global pause
pause:
 li a7, SYS_pause
 3ae:	48b5                	li	a7,13
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b6:	48b9                	li	a7,14
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3be:	1101                	addi	sp,sp,-32
 3c0:	ec06                	sd	ra,24(sp)
 3c2:	e822                	sd	s0,16(sp)
 3c4:	1000                	addi	s0,sp,32
 3c6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3ca:	4605                	li	a2,1
 3cc:	fef40593          	addi	a1,s0,-17
 3d0:	f6fff0ef          	jal	33e <write>
}
 3d4:	60e2                	ld	ra,24(sp)
 3d6:	6442                	ld	s0,16(sp)
 3d8:	6105                	addi	sp,sp,32
 3da:	8082                	ret

00000000000003dc <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3dc:	715d                	addi	sp,sp,-80
 3de:	e486                	sd	ra,72(sp)
 3e0:	e0a2                	sd	s0,64(sp)
 3e2:	fc26                	sd	s1,56(sp)
 3e4:	f84a                	sd	s2,48(sp)
 3e6:	f44e                	sd	s3,40(sp)
 3e8:	0880                	addi	s0,sp,80
 3ea:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ec:	c299                	beqz	a3,3f2 <printint+0x16>
 3ee:	0605cf63          	bltz	a1,46c <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3f2:	2581                	sext.w	a1,a1
  neg = 0;
 3f4:	4e01                	li	t3,0
  }

  i = 0;
 3f6:	fb840313          	addi	t1,s0,-72
  neg = 0;
 3fa:	869a                	mv	a3,t1
  i = 0;
 3fc:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3fe:	00000817          	auipc	a6,0x0
 402:	51280813          	addi	a6,a6,1298 # 910 <digits>
 406:	88be                	mv	a7,a5
 408:	0017851b          	addiw	a0,a5,1
 40c:	87aa                	mv	a5,a0
 40e:	02c5f73b          	remuw	a4,a1,a2
 412:	1702                	slli	a4,a4,0x20
 414:	9301                	srli	a4,a4,0x20
 416:	9742                	add	a4,a4,a6
 418:	00074703          	lbu	a4,0(a4)
 41c:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 420:	872e                	mv	a4,a1
 422:	02c5d5bb          	divuw	a1,a1,a2
 426:	0685                	addi	a3,a3,1
 428:	fcc77fe3          	bgeu	a4,a2,406 <printint+0x2a>
  if(neg)
 42c:	000e0c63          	beqz	t3,444 <printint+0x68>
    buf[i++] = '-';
 430:	fd050793          	addi	a5,a0,-48
 434:	00878533          	add	a0,a5,s0
 438:	02d00793          	li	a5,45
 43c:	fef50423          	sb	a5,-24(a0)
 440:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 444:	fff7899b          	addiw	s3,a5,-1
 448:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 44c:	fff4c583          	lbu	a1,-1(s1)
 450:	854a                	mv	a0,s2
 452:	f6dff0ef          	jal	3be <putc>
  while(--i >= 0)
 456:	39fd                	addiw	s3,s3,-1
 458:	14fd                	addi	s1,s1,-1
 45a:	fe09d9e3          	bgez	s3,44c <printint+0x70>
}
 45e:	60a6                	ld	ra,72(sp)
 460:	6406                	ld	s0,64(sp)
 462:	74e2                	ld	s1,56(sp)
 464:	7942                	ld	s2,48(sp)
 466:	79a2                	ld	s3,40(sp)
 468:	6161                	addi	sp,sp,80
 46a:	8082                	ret
    x = -xx;
 46c:	40b005bb          	negw	a1,a1
    neg = 1;
 470:	4e05                	li	t3,1
    x = -xx;
 472:	b751                	j	3f6 <printint+0x1a>

0000000000000474 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 474:	711d                	addi	sp,sp,-96
 476:	ec86                	sd	ra,88(sp)
 478:	e8a2                	sd	s0,80(sp)
 47a:	e4a6                	sd	s1,72(sp)
 47c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 47e:	0005c483          	lbu	s1,0(a1)
 482:	28048463          	beqz	s1,70a <vprintf+0x296>
 486:	e0ca                	sd	s2,64(sp)
 488:	fc4e                	sd	s3,56(sp)
 48a:	f852                	sd	s4,48(sp)
 48c:	f456                	sd	s5,40(sp)
 48e:	f05a                	sd	s6,32(sp)
 490:	ec5e                	sd	s7,24(sp)
 492:	e862                	sd	s8,16(sp)
 494:	e466                	sd	s9,8(sp)
 496:	8b2a                	mv	s6,a0
 498:	8a2e                	mv	s4,a1
 49a:	8bb2                	mv	s7,a2
  state = 0;
 49c:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 49e:	4901                	li	s2,0
 4a0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4a2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4a6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4aa:	06c00c93          	li	s9,108
 4ae:	a00d                	j	4d0 <vprintf+0x5c>
        putc(fd, c0);
 4b0:	85a6                	mv	a1,s1
 4b2:	855a                	mv	a0,s6
 4b4:	f0bff0ef          	jal	3be <putc>
 4b8:	a019                	j	4be <vprintf+0x4a>
    } else if(state == '%'){
 4ba:	03598363          	beq	s3,s5,4e0 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 4be:	0019079b          	addiw	a5,s2,1
 4c2:	893e                	mv	s2,a5
 4c4:	873e                	mv	a4,a5
 4c6:	97d2                	add	a5,a5,s4
 4c8:	0007c483          	lbu	s1,0(a5)
 4cc:	22048763          	beqz	s1,6fa <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 4d0:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4d4:	fe0993e3          	bnez	s3,4ba <vprintf+0x46>
      if(c0 == '%'){
 4d8:	fd579ce3          	bne	a5,s5,4b0 <vprintf+0x3c>
        state = '%';
 4dc:	89be                	mv	s3,a5
 4de:	b7c5                	j	4be <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4e0:	00ea06b3          	add	a3,s4,a4
 4e4:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4e8:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4ea:	c681                	beqz	a3,4f2 <vprintf+0x7e>
 4ec:	9752                	add	a4,a4,s4
 4ee:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4f2:	05878263          	beq	a5,s8,536 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 4f6:	05978c63          	beq	a5,s9,54e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4fa:	07500713          	li	a4,117
 4fe:	0ee78663          	beq	a5,a4,5ea <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 502:	07800713          	li	a4,120
 506:	12e78863          	beq	a5,a4,636 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 50a:	07000713          	li	a4,112
 50e:	14e78d63          	beq	a5,a4,668 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 512:	06300713          	li	a4,99
 516:	18e78c63          	beq	a5,a4,6ae <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 51a:	07300713          	li	a4,115
 51e:	1ae78263          	beq	a5,a4,6c2 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 522:	02500713          	li	a4,37
 526:	04e79463          	bne	a5,a4,56e <vprintf+0xfa>
        putc(fd, '%');
 52a:	85ba                	mv	a1,a4
 52c:	855a                	mv	a0,s6
 52e:	e91ff0ef          	jal	3be <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 532:	4981                	li	s3,0
 534:	b769                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 536:	008b8493          	addi	s1,s7,8
 53a:	4685                	li	a3,1
 53c:	4629                	li	a2,10
 53e:	000ba583          	lw	a1,0(s7)
 542:	855a                	mv	a0,s6
 544:	e99ff0ef          	jal	3dc <printint>
 548:	8ba6                	mv	s7,s1
      state = 0;
 54a:	4981                	li	s3,0
 54c:	bf8d                	j	4be <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 54e:	06400793          	li	a5,100
 552:	02f68963          	beq	a3,a5,584 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 556:	06c00793          	li	a5,108
 55a:	04f68263          	beq	a3,a5,59e <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 55e:	07500793          	li	a5,117
 562:	0af68063          	beq	a3,a5,602 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 566:	07800793          	li	a5,120
 56a:	0ef68263          	beq	a3,a5,64e <vprintf+0x1da>
        putc(fd, '%');
 56e:	02500593          	li	a1,37
 572:	855a                	mv	a0,s6
 574:	e4bff0ef          	jal	3be <putc>
        putc(fd, c0);
 578:	85a6                	mv	a1,s1
 57a:	855a                	mv	a0,s6
 57c:	e43ff0ef          	jal	3be <putc>
      state = 0;
 580:	4981                	li	s3,0
 582:	bf35                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 584:	008b8493          	addi	s1,s7,8
 588:	4685                	li	a3,1
 58a:	4629                	li	a2,10
 58c:	000bb583          	ld	a1,0(s7)
 590:	855a                	mv	a0,s6
 592:	e4bff0ef          	jal	3dc <printint>
        i += 1;
 596:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 598:	8ba6                	mv	s7,s1
      state = 0;
 59a:	4981                	li	s3,0
        i += 1;
 59c:	b70d                	j	4be <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 59e:	06400793          	li	a5,100
 5a2:	02f60763          	beq	a2,a5,5d0 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5a6:	07500793          	li	a5,117
 5aa:	06f60963          	beq	a2,a5,61c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5ae:	07800793          	li	a5,120
 5b2:	faf61ee3          	bne	a2,a5,56e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5b6:	008b8493          	addi	s1,s7,8
 5ba:	4681                	li	a3,0
 5bc:	4641                	li	a2,16
 5be:	000bb583          	ld	a1,0(s7)
 5c2:	855a                	mv	a0,s6
 5c4:	e19ff0ef          	jal	3dc <printint>
        i += 2;
 5c8:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ca:	8ba6                	mv	s7,s1
      state = 0;
 5cc:	4981                	li	s3,0
        i += 2;
 5ce:	bdc5                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d0:	008b8493          	addi	s1,s7,8
 5d4:	4685                	li	a3,1
 5d6:	4629                	li	a2,10
 5d8:	000bb583          	ld	a1,0(s7)
 5dc:	855a                	mv	a0,s6
 5de:	dffff0ef          	jal	3dc <printint>
        i += 2;
 5e2:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5e4:	8ba6                	mv	s7,s1
      state = 0;
 5e6:	4981                	li	s3,0
        i += 2;
 5e8:	bdd9                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5ea:	008b8493          	addi	s1,s7,8
 5ee:	4681                	li	a3,0
 5f0:	4629                	li	a2,10
 5f2:	000be583          	lwu	a1,0(s7)
 5f6:	855a                	mv	a0,s6
 5f8:	de5ff0ef          	jal	3dc <printint>
 5fc:	8ba6                	mv	s7,s1
      state = 0;
 5fe:	4981                	li	s3,0
 600:	bd7d                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 602:	008b8493          	addi	s1,s7,8
 606:	4681                	li	a3,0
 608:	4629                	li	a2,10
 60a:	000bb583          	ld	a1,0(s7)
 60e:	855a                	mv	a0,s6
 610:	dcdff0ef          	jal	3dc <printint>
        i += 1;
 614:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 616:	8ba6                	mv	s7,s1
      state = 0;
 618:	4981                	li	s3,0
        i += 1;
 61a:	b555                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 61c:	008b8493          	addi	s1,s7,8
 620:	4681                	li	a3,0
 622:	4629                	li	a2,10
 624:	000bb583          	ld	a1,0(s7)
 628:	855a                	mv	a0,s6
 62a:	db3ff0ef          	jal	3dc <printint>
        i += 2;
 62e:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 630:	8ba6                	mv	s7,s1
      state = 0;
 632:	4981                	li	s3,0
        i += 2;
 634:	b569                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 636:	008b8493          	addi	s1,s7,8
 63a:	4681                	li	a3,0
 63c:	4641                	li	a2,16
 63e:	000be583          	lwu	a1,0(s7)
 642:	855a                	mv	a0,s6
 644:	d99ff0ef          	jal	3dc <printint>
 648:	8ba6                	mv	s7,s1
      state = 0;
 64a:	4981                	li	s3,0
 64c:	bd8d                	j	4be <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 64e:	008b8493          	addi	s1,s7,8
 652:	4681                	li	a3,0
 654:	4641                	li	a2,16
 656:	000bb583          	ld	a1,0(s7)
 65a:	855a                	mv	a0,s6
 65c:	d81ff0ef          	jal	3dc <printint>
        i += 1;
 660:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 662:	8ba6                	mv	s7,s1
      state = 0;
 664:	4981                	li	s3,0
        i += 1;
 666:	bda1                	j	4be <vprintf+0x4a>
 668:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 66a:	008b8d13          	addi	s10,s7,8
 66e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 672:	03000593          	li	a1,48
 676:	855a                	mv	a0,s6
 678:	d47ff0ef          	jal	3be <putc>
  putc(fd, 'x');
 67c:	07800593          	li	a1,120
 680:	855a                	mv	a0,s6
 682:	d3dff0ef          	jal	3be <putc>
 686:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 688:	00000b97          	auipc	s7,0x0
 68c:	288b8b93          	addi	s7,s7,648 # 910 <digits>
 690:	03c9d793          	srli	a5,s3,0x3c
 694:	97de                	add	a5,a5,s7
 696:	0007c583          	lbu	a1,0(a5)
 69a:	855a                	mv	a0,s6
 69c:	d23ff0ef          	jal	3be <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a0:	0992                	slli	s3,s3,0x4
 6a2:	34fd                	addiw	s1,s1,-1
 6a4:	f4f5                	bnez	s1,690 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 6a6:	8bea                	mv	s7,s10
      state = 0;
 6a8:	4981                	li	s3,0
 6aa:	6d02                	ld	s10,0(sp)
 6ac:	bd09                	j	4be <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6ae:	008b8493          	addi	s1,s7,8
 6b2:	000bc583          	lbu	a1,0(s7)
 6b6:	855a                	mv	a0,s6
 6b8:	d07ff0ef          	jal	3be <putc>
 6bc:	8ba6                	mv	s7,s1
      state = 0;
 6be:	4981                	li	s3,0
 6c0:	bbfd                	j	4be <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6c2:	008b8993          	addi	s3,s7,8
 6c6:	000bb483          	ld	s1,0(s7)
 6ca:	cc91                	beqz	s1,6e6 <vprintf+0x272>
        for(; *s; s++)
 6cc:	0004c583          	lbu	a1,0(s1)
 6d0:	c195                	beqz	a1,6f4 <vprintf+0x280>
          putc(fd, *s);
 6d2:	855a                	mv	a0,s6
 6d4:	cebff0ef          	jal	3be <putc>
        for(; *s; s++)
 6d8:	0485                	addi	s1,s1,1
 6da:	0004c583          	lbu	a1,0(s1)
 6de:	f9f5                	bnez	a1,6d2 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 6e0:	8bce                	mv	s7,s3
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	bbe9                	j	4be <vprintf+0x4a>
          s = "(null)";
 6e6:	00000497          	auipc	s1,0x0
 6ea:	22248493          	addi	s1,s1,546 # 908 <malloc+0x112>
        for(; *s; s++)
 6ee:	02800593          	li	a1,40
 6f2:	b7c5                	j	6d2 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 6f4:	8bce                	mv	s7,s3
      state = 0;
 6f6:	4981                	li	s3,0
 6f8:	b3d9                	j	4be <vprintf+0x4a>
 6fa:	6906                	ld	s2,64(sp)
 6fc:	79e2                	ld	s3,56(sp)
 6fe:	7a42                	ld	s4,48(sp)
 700:	7aa2                	ld	s5,40(sp)
 702:	7b02                	ld	s6,32(sp)
 704:	6be2                	ld	s7,24(sp)
 706:	6c42                	ld	s8,16(sp)
 708:	6ca2                	ld	s9,8(sp)
    }
  }
}
 70a:	60e6                	ld	ra,88(sp)
 70c:	6446                	ld	s0,80(sp)
 70e:	64a6                	ld	s1,72(sp)
 710:	6125                	addi	sp,sp,96
 712:	8082                	ret

0000000000000714 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 714:	715d                	addi	sp,sp,-80
 716:	ec06                	sd	ra,24(sp)
 718:	e822                	sd	s0,16(sp)
 71a:	1000                	addi	s0,sp,32
 71c:	e010                	sd	a2,0(s0)
 71e:	e414                	sd	a3,8(s0)
 720:	e818                	sd	a4,16(s0)
 722:	ec1c                	sd	a5,24(s0)
 724:	03043023          	sd	a6,32(s0)
 728:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 72c:	8622                	mv	a2,s0
 72e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 732:	d43ff0ef          	jal	474 <vprintf>
}
 736:	60e2                	ld	ra,24(sp)
 738:	6442                	ld	s0,16(sp)
 73a:	6161                	addi	sp,sp,80
 73c:	8082                	ret

000000000000073e <printf>:

void
printf(const char *fmt, ...)
{
 73e:	711d                	addi	sp,sp,-96
 740:	ec06                	sd	ra,24(sp)
 742:	e822                	sd	s0,16(sp)
 744:	1000                	addi	s0,sp,32
 746:	e40c                	sd	a1,8(s0)
 748:	e810                	sd	a2,16(s0)
 74a:	ec14                	sd	a3,24(s0)
 74c:	f018                	sd	a4,32(s0)
 74e:	f41c                	sd	a5,40(s0)
 750:	03043823          	sd	a6,48(s0)
 754:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 758:	00840613          	addi	a2,s0,8
 75c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 760:	85aa                	mv	a1,a0
 762:	4505                	li	a0,1
 764:	d11ff0ef          	jal	474 <vprintf>
}
 768:	60e2                	ld	ra,24(sp)
 76a:	6442                	ld	s0,16(sp)
 76c:	6125                	addi	sp,sp,96
 76e:	8082                	ret

0000000000000770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 770:	1141                	addi	sp,sp,-16
 772:	e406                	sd	ra,8(sp)
 774:	e022                	sd	s0,0(sp)
 776:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 778:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77c:	00001797          	auipc	a5,0x1
 780:	8847b783          	ld	a5,-1916(a5) # 1000 <freep>
 784:	a02d                	j	7ae <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 786:	4618                	lw	a4,8(a2)
 788:	9f2d                	addw	a4,a4,a1
 78a:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 78e:	6398                	ld	a4,0(a5)
 790:	6310                	ld	a2,0(a4)
 792:	a83d                	j	7d0 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 794:	ff852703          	lw	a4,-8(a0)
 798:	9f31                	addw	a4,a4,a2
 79a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 79c:	ff053683          	ld	a3,-16(a0)
 7a0:	a091                	j	7e4 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a2:	6398                	ld	a4,0(a5)
 7a4:	00e7e463          	bltu	a5,a4,7ac <free+0x3c>
 7a8:	00e6ea63          	bltu	a3,a4,7bc <free+0x4c>
{
 7ac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ae:	fed7fae3          	bgeu	a5,a3,7a2 <free+0x32>
 7b2:	6398                	ld	a4,0(a5)
 7b4:	00e6e463          	bltu	a3,a4,7bc <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	fee7eae3          	bltu	a5,a4,7ac <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7bc:	ff852583          	lw	a1,-8(a0)
 7c0:	6390                	ld	a2,0(a5)
 7c2:	02059813          	slli	a6,a1,0x20
 7c6:	01c85713          	srli	a4,a6,0x1c
 7ca:	9736                	add	a4,a4,a3
 7cc:	fae60de3          	beq	a2,a4,786 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7d0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7d4:	4790                	lw	a2,8(a5)
 7d6:	02061593          	slli	a1,a2,0x20
 7da:	01c5d713          	srli	a4,a1,0x1c
 7de:	973e                	add	a4,a4,a5
 7e0:	fae68ae3          	beq	a3,a4,794 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7e4:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7e6:	00001717          	auipc	a4,0x1
 7ea:	80f73d23          	sd	a5,-2022(a4) # 1000 <freep>
}
 7ee:	60a2                	ld	ra,8(sp)
 7f0:	6402                	ld	s0,0(sp)
 7f2:	0141                	addi	sp,sp,16
 7f4:	8082                	ret

00000000000007f6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f6:	7139                	addi	sp,sp,-64
 7f8:	fc06                	sd	ra,56(sp)
 7fa:	f822                	sd	s0,48(sp)
 7fc:	f04a                	sd	s2,32(sp)
 7fe:	ec4e                	sd	s3,24(sp)
 800:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	02051993          	slli	s3,a0,0x20
 806:	0209d993          	srli	s3,s3,0x20
 80a:	09bd                	addi	s3,s3,15
 80c:	0049d993          	srli	s3,s3,0x4
 810:	2985                	addiw	s3,s3,1
 812:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 814:	00000517          	auipc	a0,0x0
 818:	7ec53503          	ld	a0,2028(a0) # 1000 <freep>
 81c:	c905                	beqz	a0,84c <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 81e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 820:	4798                	lw	a4,8(a5)
 822:	09377663          	bgeu	a4,s3,8ae <malloc+0xb8>
 826:	f426                	sd	s1,40(sp)
 828:	e852                	sd	s4,16(sp)
 82a:	e456                	sd	s5,8(sp)
 82c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 82e:	8a4e                	mv	s4,s3
 830:	6705                	lui	a4,0x1
 832:	00e9f363          	bgeu	s3,a4,838 <malloc+0x42>
 836:	6a05                	lui	s4,0x1
 838:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 83c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 840:	00000497          	auipc	s1,0x0
 844:	7c048493          	addi	s1,s1,1984 # 1000 <freep>
  if(p == SBRK_ERROR)
 848:	5afd                	li	s5,-1
 84a:	a83d                	j	888 <malloc+0x92>
 84c:	f426                	sd	s1,40(sp)
 84e:	e852                	sd	s4,16(sp)
 850:	e456                	sd	s5,8(sp)
 852:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 854:	00000797          	auipc	a5,0x0
 858:	7bc78793          	addi	a5,a5,1980 # 1010 <base>
 85c:	00000717          	auipc	a4,0x0
 860:	7af73223          	sd	a5,1956(a4) # 1000 <freep>
 864:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 866:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 86a:	b7d1                	j	82e <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 86c:	6398                	ld	a4,0(a5)
 86e:	e118                	sd	a4,0(a0)
 870:	a899                	j	8c6 <malloc+0xd0>
  hp->s.size = nu;
 872:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 876:	0541                	addi	a0,a0,16
 878:	ef9ff0ef          	jal	770 <free>
  return freep;
 87c:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 87e:	c125                	beqz	a0,8de <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 880:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 882:	4798                	lw	a4,8(a5)
 884:	03277163          	bgeu	a4,s2,8a6 <malloc+0xb0>
    if(p == freep)
 888:	6098                	ld	a4,0(s1)
 88a:	853e                	mv	a0,a5
 88c:	fef71ae3          	bne	a4,a5,880 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 890:	8552                	mv	a0,s4
 892:	a59ff0ef          	jal	2ea <sbrk>
  if(p == SBRK_ERROR)
 896:	fd551ee3          	bne	a0,s5,872 <malloc+0x7c>
        return 0;
 89a:	4501                	li	a0,0
 89c:	74a2                	ld	s1,40(sp)
 89e:	6a42                	ld	s4,16(sp)
 8a0:	6aa2                	ld	s5,8(sp)
 8a2:	6b02                	ld	s6,0(sp)
 8a4:	a03d                	j	8d2 <malloc+0xdc>
 8a6:	74a2                	ld	s1,40(sp)
 8a8:	6a42                	ld	s4,16(sp)
 8aa:	6aa2                	ld	s5,8(sp)
 8ac:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8ae:	fae90fe3          	beq	s2,a4,86c <malloc+0x76>
        p->s.size -= nunits;
 8b2:	4137073b          	subw	a4,a4,s3
 8b6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8b8:	02071693          	slli	a3,a4,0x20
 8bc:	01c6d713          	srli	a4,a3,0x1c
 8c0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8c2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8c6:	00000717          	auipc	a4,0x0
 8ca:	72a73d23          	sd	a0,1850(a4) # 1000 <freep>
      return (void*)(p + 1);
 8ce:	01078513          	addi	a0,a5,16
  }
}
 8d2:	70e2                	ld	ra,56(sp)
 8d4:	7442                	ld	s0,48(sp)
 8d6:	7902                	ld	s2,32(sp)
 8d8:	69e2                	ld	s3,24(sp)
 8da:	6121                	addi	sp,sp,64
 8dc:	8082                	ret
 8de:	74a2                	ld	s1,40(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
 8e6:	b7f5                	j	8d2 <malloc+0xdc>
