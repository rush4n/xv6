
user/_mytest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main(void) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	1800                	addi	s0,sp,48
    
    char *argv[3];
    argv[0] = "echo";
   8:	00001797          	auipc	a5,0x1
   c:	8d878793          	addi	a5,a5,-1832 # 8e0 <malloc+0xf8>
  10:	fcf43c23          	sd	a5,-40(s0)
    argv[1] = "hello";
  14:	00001797          	auipc	a5,0x1
  18:	8dc78793          	addi	a5,a5,-1828 # 8f0 <malloc+0x108>
  1c:	fef43023          	sd	a5,-32(s0)
    argv[2] = 0;
  20:	fe043423          	sd	zero,-24(s0)

    exec("/bin/echo", argv);
  24:	fd840593          	addi	a1,s0,-40
  28:	00001517          	auipc	a0,0x1
  2c:	8d050513          	addi	a0,a0,-1840 # 8f8 <malloc+0x110>
  30:	318000ef          	jal	348 <exec>
    printf("exec error\n");
  34:	00001517          	auipc	a0,0x1
  38:	8d450513          	addi	a0,a0,-1836 # 908 <malloc+0x120>
  3c:	6f4000ef          	jal	730 <printf>

    exit(0);
  40:	4501                	li	a0,0
  42:	2ce000ef          	jal	310 <exit>

0000000000000046 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  46:	1141                	addi	sp,sp,-16
  48:	e406                	sd	ra,8(sp)
  4a:	e022                	sd	s0,0(sp)
  4c:	0800                	addi	s0,sp,16
  extern int main();
  main();
  4e:	fb3ff0ef          	jal	0 <main>
  exit(0);
  52:	4501                	li	a0,0
  54:	2bc000ef          	jal	310 <exit>

0000000000000058 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  58:	1141                	addi	sp,sp,-16
  5a:	e406                	sd	ra,8(sp)
  5c:	e022                	sd	s0,0(sp)
  5e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  60:	87aa                	mv	a5,a0
  62:	0585                	addi	a1,a1,1
  64:	0785                	addi	a5,a5,1
  66:	fff5c703          	lbu	a4,-1(a1)
  6a:	fee78fa3          	sb	a4,-1(a5)
  6e:	fb75                	bnez	a4,62 <strcpy+0xa>
    ;
  return os;
}
  70:	60a2                	ld	ra,8(sp)
  72:	6402                	ld	s0,0(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  78:	1141                	addi	sp,sp,-16
  7a:	e406                	sd	ra,8(sp)
  7c:	e022                	sd	s0,0(sp)
  7e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  80:	00054783          	lbu	a5,0(a0)
  84:	cb91                	beqz	a5,98 <strcmp+0x20>
  86:	0005c703          	lbu	a4,0(a1)
  8a:	00f71763          	bne	a4,a5,98 <strcmp+0x20>
    p++, q++;
  8e:	0505                	addi	a0,a0,1
  90:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  92:	00054783          	lbu	a5,0(a0)
  96:	fbe5                	bnez	a5,86 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  98:	0005c503          	lbu	a0,0(a1)
}
  9c:	40a7853b          	subw	a0,a5,a0
  a0:	60a2                	ld	ra,8(sp)
  a2:	6402                	ld	s0,0(sp)
  a4:	0141                	addi	sp,sp,16
  a6:	8082                	ret

00000000000000a8 <strlen>:

uint
strlen(const char *s)
{
  a8:	1141                	addi	sp,sp,-16
  aa:	e406                	sd	ra,8(sp)
  ac:	e022                	sd	s0,0(sp)
  ae:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cf99                	beqz	a5,d2 <strlen+0x2a>
  b6:	0505                	addi	a0,a0,1
  b8:	87aa                	mv	a5,a0
  ba:	86be                	mv	a3,a5
  bc:	0785                	addi	a5,a5,1
  be:	fff7c703          	lbu	a4,-1(a5)
  c2:	ff65                	bnez	a4,ba <strlen+0x12>
  c4:	40a6853b          	subw	a0,a3,a0
  c8:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  ca:	60a2                	ld	ra,8(sp)
  cc:	6402                	ld	s0,0(sp)
  ce:	0141                	addi	sp,sp,16
  d0:	8082                	ret
  for(n = 0; s[n]; n++)
  d2:	4501                	li	a0,0
  d4:	bfdd                	j	ca <strlen+0x22>

00000000000000d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e406                	sd	ra,8(sp)
  da:	e022                	sd	s0,0(sp)
  dc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  de:	ca19                	beqz	a2,f4 <memset+0x1e>
  e0:	87aa                	mv	a5,a0
  e2:	1602                	slli	a2,a2,0x20
  e4:	9201                	srli	a2,a2,0x20
  e6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  ea:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ee:	0785                	addi	a5,a5,1
  f0:	fee79de3          	bne	a5,a4,ea <memset+0x14>
  }
  return dst;
}
  f4:	60a2                	ld	ra,8(sp)
  f6:	6402                	ld	s0,0(sp)
  f8:	0141                	addi	sp,sp,16
  fa:	8082                	ret

00000000000000fc <strchr>:

char*
strchr(const char *s, char c)
{
  fc:	1141                	addi	sp,sp,-16
  fe:	e406                	sd	ra,8(sp)
 100:	e022                	sd	s0,0(sp)
 102:	0800                	addi	s0,sp,16
  for(; *s; s++)
 104:	00054783          	lbu	a5,0(a0)
 108:	cf81                	beqz	a5,120 <strchr+0x24>
    if(*s == c)
 10a:	00f58763          	beq	a1,a5,118 <strchr+0x1c>
  for(; *s; s++)
 10e:	0505                	addi	a0,a0,1
 110:	00054783          	lbu	a5,0(a0)
 114:	fbfd                	bnez	a5,10a <strchr+0xe>
      return (char*)s;
  return 0;
 116:	4501                	li	a0,0
}
 118:	60a2                	ld	ra,8(sp)
 11a:	6402                	ld	s0,0(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret
  return 0;
 120:	4501                	li	a0,0
 122:	bfdd                	j	118 <strchr+0x1c>

0000000000000124 <gets>:

char*
gets(char *buf, int max)
{
 124:	7159                	addi	sp,sp,-112
 126:	f486                	sd	ra,104(sp)
 128:	f0a2                	sd	s0,96(sp)
 12a:	eca6                	sd	s1,88(sp)
 12c:	e8ca                	sd	s2,80(sp)
 12e:	e4ce                	sd	s3,72(sp)
 130:	e0d2                	sd	s4,64(sp)
 132:	fc56                	sd	s5,56(sp)
 134:	f85a                	sd	s6,48(sp)
 136:	f45e                	sd	s7,40(sp)
 138:	f062                	sd	s8,32(sp)
 13a:	ec66                	sd	s9,24(sp)
 13c:	e86a                	sd	s10,16(sp)
 13e:	1880                	addi	s0,sp,112
 140:	8caa                	mv	s9,a0
 142:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 144:	892a                	mv	s2,a0
 146:	4481                	li	s1,0
    cc = read(0, &c, 1);
 148:	f9f40b13          	addi	s6,s0,-97
 14c:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14e:	4ba9                	li	s7,10
 150:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 152:	8d26                	mv	s10,s1
 154:	0014899b          	addiw	s3,s1,1
 158:	84ce                	mv	s1,s3
 15a:	0349d563          	bge	s3,s4,184 <gets+0x60>
    cc = read(0, &c, 1);
 15e:	8656                	mv	a2,s5
 160:	85da                	mv	a1,s6
 162:	4501                	li	a0,0
 164:	1c4000ef          	jal	328 <read>
    if(cc < 1)
 168:	00a05e63          	blez	a0,184 <gets+0x60>
    buf[i++] = c;
 16c:	f9f44783          	lbu	a5,-97(s0)
 170:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 174:	01778763          	beq	a5,s7,182 <gets+0x5e>
 178:	0905                	addi	s2,s2,1
 17a:	fd879ce3          	bne	a5,s8,152 <gets+0x2e>
    buf[i++] = c;
 17e:	8d4e                	mv	s10,s3
 180:	a011                	j	184 <gets+0x60>
 182:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 184:	9d66                	add	s10,s10,s9
 186:	000d0023          	sb	zero,0(s10)
  return buf;
}
 18a:	8566                	mv	a0,s9
 18c:	70a6                	ld	ra,104(sp)
 18e:	7406                	ld	s0,96(sp)
 190:	64e6                	ld	s1,88(sp)
 192:	6946                	ld	s2,80(sp)
 194:	69a6                	ld	s3,72(sp)
 196:	6a06                	ld	s4,64(sp)
 198:	7ae2                	ld	s5,56(sp)
 19a:	7b42                	ld	s6,48(sp)
 19c:	7ba2                	ld	s7,40(sp)
 19e:	7c02                	ld	s8,32(sp)
 1a0:	6ce2                	ld	s9,24(sp)
 1a2:	6d42                	ld	s10,16(sp)
 1a4:	6165                	addi	sp,sp,112
 1a6:	8082                	ret

00000000000001a8 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a8:	1101                	addi	sp,sp,-32
 1aa:	ec06                	sd	ra,24(sp)
 1ac:	e822                	sd	s0,16(sp)
 1ae:	e04a                	sd	s2,0(sp)
 1b0:	1000                	addi	s0,sp,32
 1b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b4:	4581                	li	a1,0
 1b6:	19a000ef          	jal	350 <open>
  if(fd < 0)
 1ba:	02054263          	bltz	a0,1de <stat+0x36>
 1be:	e426                	sd	s1,8(sp)
 1c0:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1c2:	85ca                	mv	a1,s2
 1c4:	1a4000ef          	jal	368 <fstat>
 1c8:	892a                	mv	s2,a0
  close(fd);
 1ca:	8526                	mv	a0,s1
 1cc:	16c000ef          	jal	338 <close>
  return r;
 1d0:	64a2                	ld	s1,8(sp)
}
 1d2:	854a                	mv	a0,s2
 1d4:	60e2                	ld	ra,24(sp)
 1d6:	6442                	ld	s0,16(sp)
 1d8:	6902                	ld	s2,0(sp)
 1da:	6105                	addi	sp,sp,32
 1dc:	8082                	ret
    return -1;
 1de:	597d                	li	s2,-1
 1e0:	bfcd                	j	1d2 <stat+0x2a>

00000000000001e2 <atoi>:

int
atoi(const char *s)
{
 1e2:	1141                	addi	sp,sp,-16
 1e4:	e406                	sd	ra,8(sp)
 1e6:	e022                	sd	s0,0(sp)
 1e8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ea:	00054683          	lbu	a3,0(a0)
 1ee:	fd06879b          	addiw	a5,a3,-48
 1f2:	0ff7f793          	zext.b	a5,a5
 1f6:	4625                	li	a2,9
 1f8:	02f66963          	bltu	a2,a5,22a <atoi+0x48>
 1fc:	872a                	mv	a4,a0
  n = 0;
 1fe:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 200:	0705                	addi	a4,a4,1
 202:	0025179b          	slliw	a5,a0,0x2
 206:	9fa9                	addw	a5,a5,a0
 208:	0017979b          	slliw	a5,a5,0x1
 20c:	9fb5                	addw	a5,a5,a3
 20e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 212:	00074683          	lbu	a3,0(a4)
 216:	fd06879b          	addiw	a5,a3,-48
 21a:	0ff7f793          	zext.b	a5,a5
 21e:	fef671e3          	bgeu	a2,a5,200 <atoi+0x1e>
  return n;
}
 222:	60a2                	ld	ra,8(sp)
 224:	6402                	ld	s0,0(sp)
 226:	0141                	addi	sp,sp,16
 228:	8082                	ret
  n = 0;
 22a:	4501                	li	a0,0
 22c:	bfdd                	j	222 <atoi+0x40>

000000000000022e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e406                	sd	ra,8(sp)
 232:	e022                	sd	s0,0(sp)
 234:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 236:	02b57563          	bgeu	a0,a1,260 <memmove+0x32>
    while(n-- > 0)
 23a:	00c05f63          	blez	a2,258 <memmove+0x2a>
 23e:	1602                	slli	a2,a2,0x20
 240:	9201                	srli	a2,a2,0x20
 242:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 246:	872a                	mv	a4,a0
      *dst++ = *src++;
 248:	0585                	addi	a1,a1,1
 24a:	0705                	addi	a4,a4,1
 24c:	fff5c683          	lbu	a3,-1(a1)
 250:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 254:	fee79ae3          	bne	a5,a4,248 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 258:	60a2                	ld	ra,8(sp)
 25a:	6402                	ld	s0,0(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
    dst += n;
 260:	00c50733          	add	a4,a0,a2
    src += n;
 264:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 266:	fec059e3          	blez	a2,258 <memmove+0x2a>
 26a:	fff6079b          	addiw	a5,a2,-1
 26e:	1782                	slli	a5,a5,0x20
 270:	9381                	srli	a5,a5,0x20
 272:	fff7c793          	not	a5,a5
 276:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 278:	15fd                	addi	a1,a1,-1
 27a:	177d                	addi	a4,a4,-1
 27c:	0005c683          	lbu	a3,0(a1)
 280:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 284:	fef71ae3          	bne	a4,a5,278 <memmove+0x4a>
 288:	bfc1                	j	258 <memmove+0x2a>

000000000000028a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 292:	ca0d                	beqz	a2,2c4 <memcmp+0x3a>
 294:	fff6069b          	addiw	a3,a2,-1
 298:	1682                	slli	a3,a3,0x20
 29a:	9281                	srli	a3,a3,0x20
 29c:	0685                	addi	a3,a3,1
 29e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00e79863          	bne	a5,a4,2b8 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2ac:	0505                	addi	a0,a0,1
    p2++;
 2ae:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b0:	fed518e3          	bne	a0,a3,2a0 <memcmp+0x16>
  }
  return 0;
 2b4:	4501                	li	a0,0
 2b6:	a019                	j	2bc <memcmp+0x32>
      return *p1 - *p2;
 2b8:	40e7853b          	subw	a0,a5,a4
}
 2bc:	60a2                	ld	ra,8(sp)
 2be:	6402                	ld	s0,0(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	bfdd                	j	2bc <memcmp+0x32>

00000000000002c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c8:	1141                	addi	sp,sp,-16
 2ca:	e406                	sd	ra,8(sp)
 2cc:	e022                	sd	s0,0(sp)
 2ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d0:	f5fff0ef          	jal	22e <memmove>
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <sbrk>:

char *
sbrk(int n) {
 2dc:	1141                	addi	sp,sp,-16
 2de:	e406                	sd	ra,8(sp)
 2e0:	e022                	sd	s0,0(sp)
 2e2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2e4:	4585                	li	a1,1
 2e6:	0b2000ef          	jal	398 <sys_sbrk>
}
 2ea:	60a2                	ld	ra,8(sp)
 2ec:	6402                	ld	s0,0(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <sbrklazy>:

char *
sbrklazy(int n) {
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e406                	sd	ra,8(sp)
 2f6:	e022                	sd	s0,0(sp)
 2f8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2fa:	4589                	li	a1,2
 2fc:	09c000ef          	jal	398 <sys_sbrk>
}
 300:	60a2                	ld	ra,8(sp)
 302:	6402                	ld	s0,0(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret

0000000000000308 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 308:	4885                	li	a7,1
 ecall
 30a:	00000073          	ecall
 ret
 30e:	8082                	ret

0000000000000310 <exit>:
.global exit
exit:
 li a7, SYS_exit
 310:	4889                	li	a7,2
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <wait>:
.global wait
wait:
 li a7, SYS_wait
 318:	488d                	li	a7,3
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 320:	4891                	li	a7,4
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <read>:
.global read
read:
 li a7, SYS_read
 328:	4895                	li	a7,5
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <write>:
.global write
write:
 li a7, SYS_write
 330:	48c1                	li	a7,16
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <close>:
.global close
close:
 li a7, SYS_close
 338:	48d5                	li	a7,21
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <kill>:
.global kill
kill:
 li a7, SYS_kill
 340:	4899                	li	a7,6
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <exec>:
.global exec
exec:
 li a7, SYS_exec
 348:	489d                	li	a7,7
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <open>:
.global open
open:
 li a7, SYS_open
 350:	48bd                	li	a7,15
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 358:	48c5                	li	a7,17
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 360:	48c9                	li	a7,18
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 368:	48a1                	li	a7,8
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <link>:
.global link
link:
 li a7, SYS_link
 370:	48cd                	li	a7,19
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 378:	48d1                	li	a7,20
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 380:	48a5                	li	a7,9
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <dup>:
.global dup
dup:
 li a7, SYS_dup
 388:	48a9                	li	a7,10
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 390:	48ad                	li	a7,11
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 398:	48b1                	li	a7,12
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3a0:	48b5                	li	a7,13
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3a8:	48b9                	li	a7,14
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3b0:	1101                	addi	sp,sp,-32
 3b2:	ec06                	sd	ra,24(sp)
 3b4:	e822                	sd	s0,16(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3bc:	4605                	li	a2,1
 3be:	fef40593          	addi	a1,s0,-17
 3c2:	f6fff0ef          	jal	330 <write>
}
 3c6:	60e2                	ld	ra,24(sp)
 3c8:	6442                	ld	s0,16(sp)
 3ca:	6105                	addi	sp,sp,32
 3cc:	8082                	ret

00000000000003ce <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3ce:	715d                	addi	sp,sp,-80
 3d0:	e486                	sd	ra,72(sp)
 3d2:	e0a2                	sd	s0,64(sp)
 3d4:	fc26                	sd	s1,56(sp)
 3d6:	f84a                	sd	s2,48(sp)
 3d8:	f44e                	sd	s3,40(sp)
 3da:	0880                	addi	s0,sp,80
 3dc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3de:	c299                	beqz	a3,3e4 <printint+0x16>
 3e0:	0605cf63          	bltz	a1,45e <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3e4:	2581                	sext.w	a1,a1
  neg = 0;
 3e6:	4e01                	li	t3,0
  }

  i = 0;
 3e8:	fb840313          	addi	t1,s0,-72
  neg = 0;
 3ec:	869a                	mv	a3,t1
  i = 0;
 3ee:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3f0:	00000817          	auipc	a6,0x0
 3f4:	53080813          	addi	a6,a6,1328 # 920 <digits>
 3f8:	88be                	mv	a7,a5
 3fa:	0017851b          	addiw	a0,a5,1
 3fe:	87aa                	mv	a5,a0
 400:	02c5f73b          	remuw	a4,a1,a2
 404:	1702                	slli	a4,a4,0x20
 406:	9301                	srli	a4,a4,0x20
 408:	9742                	add	a4,a4,a6
 40a:	00074703          	lbu	a4,0(a4)
 40e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 412:	872e                	mv	a4,a1
 414:	02c5d5bb          	divuw	a1,a1,a2
 418:	0685                	addi	a3,a3,1
 41a:	fcc77fe3          	bgeu	a4,a2,3f8 <printint+0x2a>
  if(neg)
 41e:	000e0c63          	beqz	t3,436 <printint+0x68>
    buf[i++] = '-';
 422:	fd050793          	addi	a5,a0,-48
 426:	00878533          	add	a0,a5,s0
 42a:	02d00793          	li	a5,45
 42e:	fef50423          	sb	a5,-24(a0)
 432:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 436:	fff7899b          	addiw	s3,a5,-1
 43a:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 43e:	fff4c583          	lbu	a1,-1(s1)
 442:	854a                	mv	a0,s2
 444:	f6dff0ef          	jal	3b0 <putc>
  while(--i >= 0)
 448:	39fd                	addiw	s3,s3,-1
 44a:	14fd                	addi	s1,s1,-1
 44c:	fe09d9e3          	bgez	s3,43e <printint+0x70>
}
 450:	60a6                	ld	ra,72(sp)
 452:	6406                	ld	s0,64(sp)
 454:	74e2                	ld	s1,56(sp)
 456:	7942                	ld	s2,48(sp)
 458:	79a2                	ld	s3,40(sp)
 45a:	6161                	addi	sp,sp,80
 45c:	8082                	ret
    x = -xx;
 45e:	40b005bb          	negw	a1,a1
    neg = 1;
 462:	4e05                	li	t3,1
    x = -xx;
 464:	b751                	j	3e8 <printint+0x1a>

0000000000000466 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 466:	711d                	addi	sp,sp,-96
 468:	ec86                	sd	ra,88(sp)
 46a:	e8a2                	sd	s0,80(sp)
 46c:	e4a6                	sd	s1,72(sp)
 46e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 470:	0005c483          	lbu	s1,0(a1)
 474:	28048463          	beqz	s1,6fc <vprintf+0x296>
 478:	e0ca                	sd	s2,64(sp)
 47a:	fc4e                	sd	s3,56(sp)
 47c:	f852                	sd	s4,48(sp)
 47e:	f456                	sd	s5,40(sp)
 480:	f05a                	sd	s6,32(sp)
 482:	ec5e                	sd	s7,24(sp)
 484:	e862                	sd	s8,16(sp)
 486:	e466                	sd	s9,8(sp)
 488:	8b2a                	mv	s6,a0
 48a:	8a2e                	mv	s4,a1
 48c:	8bb2                	mv	s7,a2
  state = 0;
 48e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 490:	4901                	li	s2,0
 492:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 494:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 498:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 49c:	06c00c93          	li	s9,108
 4a0:	a00d                	j	4c2 <vprintf+0x5c>
        putc(fd, c0);
 4a2:	85a6                	mv	a1,s1
 4a4:	855a                	mv	a0,s6
 4a6:	f0bff0ef          	jal	3b0 <putc>
 4aa:	a019                	j	4b0 <vprintf+0x4a>
    } else if(state == '%'){
 4ac:	03598363          	beq	s3,s5,4d2 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 4b0:	0019079b          	addiw	a5,s2,1
 4b4:	893e                	mv	s2,a5
 4b6:	873e                	mv	a4,a5
 4b8:	97d2                	add	a5,a5,s4
 4ba:	0007c483          	lbu	s1,0(a5)
 4be:	22048763          	beqz	s1,6ec <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 4c2:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4c6:	fe0993e3          	bnez	s3,4ac <vprintf+0x46>
      if(c0 == '%'){
 4ca:	fd579ce3          	bne	a5,s5,4a2 <vprintf+0x3c>
        state = '%';
 4ce:	89be                	mv	s3,a5
 4d0:	b7c5                	j	4b0 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4d2:	00ea06b3          	add	a3,s4,a4
 4d6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4da:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4dc:	c681                	beqz	a3,4e4 <vprintf+0x7e>
 4de:	9752                	add	a4,a4,s4
 4e0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4e4:	05878263          	beq	a5,s8,528 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 4e8:	05978c63          	beq	a5,s9,540 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4ec:	07500713          	li	a4,117
 4f0:	0ee78663          	beq	a5,a4,5dc <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 4f4:	07800713          	li	a4,120
 4f8:	12e78863          	beq	a5,a4,628 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 4fc:	07000713          	li	a4,112
 500:	14e78d63          	beq	a5,a4,65a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 504:	06300713          	li	a4,99
 508:	18e78c63          	beq	a5,a4,6a0 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 50c:	07300713          	li	a4,115
 510:	1ae78263          	beq	a5,a4,6b4 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 514:	02500713          	li	a4,37
 518:	04e79463          	bne	a5,a4,560 <vprintf+0xfa>
        putc(fd, '%');
 51c:	85ba                	mv	a1,a4
 51e:	855a                	mv	a0,s6
 520:	e91ff0ef          	jal	3b0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 524:	4981                	li	s3,0
 526:	b769                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 528:	008b8493          	addi	s1,s7,8
 52c:	4685                	li	a3,1
 52e:	4629                	li	a2,10
 530:	000ba583          	lw	a1,0(s7)
 534:	855a                	mv	a0,s6
 536:	e99ff0ef          	jal	3ce <printint>
 53a:	8ba6                	mv	s7,s1
      state = 0;
 53c:	4981                	li	s3,0
 53e:	bf8d                	j	4b0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 540:	06400793          	li	a5,100
 544:	02f68963          	beq	a3,a5,576 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 548:	06c00793          	li	a5,108
 54c:	04f68263          	beq	a3,a5,590 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 550:	07500793          	li	a5,117
 554:	0af68063          	beq	a3,a5,5f4 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 558:	07800793          	li	a5,120
 55c:	0ef68263          	beq	a3,a5,640 <vprintf+0x1da>
        putc(fd, '%');
 560:	02500593          	li	a1,37
 564:	855a                	mv	a0,s6
 566:	e4bff0ef          	jal	3b0 <putc>
        putc(fd, c0);
 56a:	85a6                	mv	a1,s1
 56c:	855a                	mv	a0,s6
 56e:	e43ff0ef          	jal	3b0 <putc>
      state = 0;
 572:	4981                	li	s3,0
 574:	bf35                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 576:	008b8493          	addi	s1,s7,8
 57a:	4685                	li	a3,1
 57c:	4629                	li	a2,10
 57e:	000bb583          	ld	a1,0(s7)
 582:	855a                	mv	a0,s6
 584:	e4bff0ef          	jal	3ce <printint>
        i += 1;
 588:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 58a:	8ba6                	mv	s7,s1
      state = 0;
 58c:	4981                	li	s3,0
        i += 1;
 58e:	b70d                	j	4b0 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 590:	06400793          	li	a5,100
 594:	02f60763          	beq	a2,a5,5c2 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 598:	07500793          	li	a5,117
 59c:	06f60963          	beq	a2,a5,60e <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5a0:	07800793          	li	a5,120
 5a4:	faf61ee3          	bne	a2,a5,560 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5a8:	008b8493          	addi	s1,s7,8
 5ac:	4681                	li	a3,0
 5ae:	4641                	li	a2,16
 5b0:	000bb583          	ld	a1,0(s7)
 5b4:	855a                	mv	a0,s6
 5b6:	e19ff0ef          	jal	3ce <printint>
        i += 2;
 5ba:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5bc:	8ba6                	mv	s7,s1
      state = 0;
 5be:	4981                	li	s3,0
        i += 2;
 5c0:	bdc5                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c2:	008b8493          	addi	s1,s7,8
 5c6:	4685                	li	a3,1
 5c8:	4629                	li	a2,10
 5ca:	000bb583          	ld	a1,0(s7)
 5ce:	855a                	mv	a0,s6
 5d0:	dffff0ef          	jal	3ce <printint>
        i += 2;
 5d4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d6:	8ba6                	mv	s7,s1
      state = 0;
 5d8:	4981                	li	s3,0
        i += 2;
 5da:	bdd9                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5dc:	008b8493          	addi	s1,s7,8
 5e0:	4681                	li	a3,0
 5e2:	4629                	li	a2,10
 5e4:	000be583          	lwu	a1,0(s7)
 5e8:	855a                	mv	a0,s6
 5ea:	de5ff0ef          	jal	3ce <printint>
 5ee:	8ba6                	mv	s7,s1
      state = 0;
 5f0:	4981                	li	s3,0
 5f2:	bd7d                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5f4:	008b8493          	addi	s1,s7,8
 5f8:	4681                	li	a3,0
 5fa:	4629                	li	a2,10
 5fc:	000bb583          	ld	a1,0(s7)
 600:	855a                	mv	a0,s6
 602:	dcdff0ef          	jal	3ce <printint>
        i += 1;
 606:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 608:	8ba6                	mv	s7,s1
      state = 0;
 60a:	4981                	li	s3,0
        i += 1;
 60c:	b555                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 60e:	008b8493          	addi	s1,s7,8
 612:	4681                	li	a3,0
 614:	4629                	li	a2,10
 616:	000bb583          	ld	a1,0(s7)
 61a:	855a                	mv	a0,s6
 61c:	db3ff0ef          	jal	3ce <printint>
        i += 2;
 620:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 622:	8ba6                	mv	s7,s1
      state = 0;
 624:	4981                	li	s3,0
        i += 2;
 626:	b569                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 628:	008b8493          	addi	s1,s7,8
 62c:	4681                	li	a3,0
 62e:	4641                	li	a2,16
 630:	000be583          	lwu	a1,0(s7)
 634:	855a                	mv	a0,s6
 636:	d99ff0ef          	jal	3ce <printint>
 63a:	8ba6                	mv	s7,s1
      state = 0;
 63c:	4981                	li	s3,0
 63e:	bd8d                	j	4b0 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 640:	008b8493          	addi	s1,s7,8
 644:	4681                	li	a3,0
 646:	4641                	li	a2,16
 648:	000bb583          	ld	a1,0(s7)
 64c:	855a                	mv	a0,s6
 64e:	d81ff0ef          	jal	3ce <printint>
        i += 1;
 652:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 654:	8ba6                	mv	s7,s1
      state = 0;
 656:	4981                	li	s3,0
        i += 1;
 658:	bda1                	j	4b0 <vprintf+0x4a>
 65a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 65c:	008b8d13          	addi	s10,s7,8
 660:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 664:	03000593          	li	a1,48
 668:	855a                	mv	a0,s6
 66a:	d47ff0ef          	jal	3b0 <putc>
  putc(fd, 'x');
 66e:	07800593          	li	a1,120
 672:	855a                	mv	a0,s6
 674:	d3dff0ef          	jal	3b0 <putc>
 678:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67a:	00000b97          	auipc	s7,0x0
 67e:	2a6b8b93          	addi	s7,s7,678 # 920 <digits>
 682:	03c9d793          	srli	a5,s3,0x3c
 686:	97de                	add	a5,a5,s7
 688:	0007c583          	lbu	a1,0(a5)
 68c:	855a                	mv	a0,s6
 68e:	d23ff0ef          	jal	3b0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 692:	0992                	slli	s3,s3,0x4
 694:	34fd                	addiw	s1,s1,-1
 696:	f4f5                	bnez	s1,682 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 698:	8bea                	mv	s7,s10
      state = 0;
 69a:	4981                	li	s3,0
 69c:	6d02                	ld	s10,0(sp)
 69e:	bd09                	j	4b0 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6a0:	008b8493          	addi	s1,s7,8
 6a4:	000bc583          	lbu	a1,0(s7)
 6a8:	855a                	mv	a0,s6
 6aa:	d07ff0ef          	jal	3b0 <putc>
 6ae:	8ba6                	mv	s7,s1
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	bbfd                	j	4b0 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6b4:	008b8993          	addi	s3,s7,8
 6b8:	000bb483          	ld	s1,0(s7)
 6bc:	cc91                	beqz	s1,6d8 <vprintf+0x272>
        for(; *s; s++)
 6be:	0004c583          	lbu	a1,0(s1)
 6c2:	c195                	beqz	a1,6e6 <vprintf+0x280>
          putc(fd, *s);
 6c4:	855a                	mv	a0,s6
 6c6:	cebff0ef          	jal	3b0 <putc>
        for(; *s; s++)
 6ca:	0485                	addi	s1,s1,1
 6cc:	0004c583          	lbu	a1,0(s1)
 6d0:	f9f5                	bnez	a1,6c4 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 6d2:	8bce                	mv	s7,s3
      state = 0;
 6d4:	4981                	li	s3,0
 6d6:	bbe9                	j	4b0 <vprintf+0x4a>
          s = "(null)";
 6d8:	00000497          	auipc	s1,0x0
 6dc:	24048493          	addi	s1,s1,576 # 918 <malloc+0x130>
        for(; *s; s++)
 6e0:	02800593          	li	a1,40
 6e4:	b7c5                	j	6c4 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 6e6:	8bce                	mv	s7,s3
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	b3d9                	j	4b0 <vprintf+0x4a>
 6ec:	6906                	ld	s2,64(sp)
 6ee:	79e2                	ld	s3,56(sp)
 6f0:	7a42                	ld	s4,48(sp)
 6f2:	7aa2                	ld	s5,40(sp)
 6f4:	7b02                	ld	s6,32(sp)
 6f6:	6be2                	ld	s7,24(sp)
 6f8:	6c42                	ld	s8,16(sp)
 6fa:	6ca2                	ld	s9,8(sp)
    }
  }
}
 6fc:	60e6                	ld	ra,88(sp)
 6fe:	6446                	ld	s0,80(sp)
 700:	64a6                	ld	s1,72(sp)
 702:	6125                	addi	sp,sp,96
 704:	8082                	ret

0000000000000706 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 706:	715d                	addi	sp,sp,-80
 708:	ec06                	sd	ra,24(sp)
 70a:	e822                	sd	s0,16(sp)
 70c:	1000                	addi	s0,sp,32
 70e:	e010                	sd	a2,0(s0)
 710:	e414                	sd	a3,8(s0)
 712:	e818                	sd	a4,16(s0)
 714:	ec1c                	sd	a5,24(s0)
 716:	03043023          	sd	a6,32(s0)
 71a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 71e:	8622                	mv	a2,s0
 720:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 724:	d43ff0ef          	jal	466 <vprintf>
}
 728:	60e2                	ld	ra,24(sp)
 72a:	6442                	ld	s0,16(sp)
 72c:	6161                	addi	sp,sp,80
 72e:	8082                	ret

0000000000000730 <printf>:

void
printf(const char *fmt, ...)
{
 730:	711d                	addi	sp,sp,-96
 732:	ec06                	sd	ra,24(sp)
 734:	e822                	sd	s0,16(sp)
 736:	1000                	addi	s0,sp,32
 738:	e40c                	sd	a1,8(s0)
 73a:	e810                	sd	a2,16(s0)
 73c:	ec14                	sd	a3,24(s0)
 73e:	f018                	sd	a4,32(s0)
 740:	f41c                	sd	a5,40(s0)
 742:	03043823          	sd	a6,48(s0)
 746:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 74a:	00840613          	addi	a2,s0,8
 74e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 752:	85aa                	mv	a1,a0
 754:	4505                	li	a0,1
 756:	d11ff0ef          	jal	466 <vprintf>
}
 75a:	60e2                	ld	ra,24(sp)
 75c:	6442                	ld	s0,16(sp)
 75e:	6125                	addi	sp,sp,96
 760:	8082                	ret

0000000000000762 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 762:	1141                	addi	sp,sp,-16
 764:	e406                	sd	ra,8(sp)
 766:	e022                	sd	s0,0(sp)
 768:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 76a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76e:	00001797          	auipc	a5,0x1
 772:	8927b783          	ld	a5,-1902(a5) # 1000 <freep>
 776:	a02d                	j	7a0 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 778:	4618                	lw	a4,8(a2)
 77a:	9f2d                	addw	a4,a4,a1
 77c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 780:	6398                	ld	a4,0(a5)
 782:	6310                	ld	a2,0(a4)
 784:	a83d                	j	7c2 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 786:	ff852703          	lw	a4,-8(a0)
 78a:	9f31                	addw	a4,a4,a2
 78c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 78e:	ff053683          	ld	a3,-16(a0)
 792:	a091                	j	7d6 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 794:	6398                	ld	a4,0(a5)
 796:	00e7e463          	bltu	a5,a4,79e <free+0x3c>
 79a:	00e6ea63          	bltu	a3,a4,7ae <free+0x4c>
{
 79e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a0:	fed7fae3          	bgeu	a5,a3,794 <free+0x32>
 7a4:	6398                	ld	a4,0(a5)
 7a6:	00e6e463          	bltu	a3,a4,7ae <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7aa:	fee7eae3          	bltu	a5,a4,79e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7ae:	ff852583          	lw	a1,-8(a0)
 7b2:	6390                	ld	a2,0(a5)
 7b4:	02059813          	slli	a6,a1,0x20
 7b8:	01c85713          	srli	a4,a6,0x1c
 7bc:	9736                	add	a4,a4,a3
 7be:	fae60de3          	beq	a2,a4,778 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7c2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7c6:	4790                	lw	a2,8(a5)
 7c8:	02061593          	slli	a1,a2,0x20
 7cc:	01c5d713          	srli	a4,a1,0x1c
 7d0:	973e                	add	a4,a4,a5
 7d2:	fae68ae3          	beq	a3,a4,786 <free+0x24>
    p->s.ptr = bp->s.ptr;
 7d6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7d8:	00001717          	auipc	a4,0x1
 7dc:	82f73423          	sd	a5,-2008(a4) # 1000 <freep>
}
 7e0:	60a2                	ld	ra,8(sp)
 7e2:	6402                	ld	s0,0(sp)
 7e4:	0141                	addi	sp,sp,16
 7e6:	8082                	ret

00000000000007e8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e8:	7139                	addi	sp,sp,-64
 7ea:	fc06                	sd	ra,56(sp)
 7ec:	f822                	sd	s0,48(sp)
 7ee:	f04a                	sd	s2,32(sp)
 7f0:	ec4e                	sd	s3,24(sp)
 7f2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f4:	02051993          	slli	s3,a0,0x20
 7f8:	0209d993          	srli	s3,s3,0x20
 7fc:	09bd                	addi	s3,s3,15
 7fe:	0049d993          	srli	s3,s3,0x4
 802:	2985                	addiw	s3,s3,1
 804:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 806:	00000517          	auipc	a0,0x0
 80a:	7fa53503          	ld	a0,2042(a0) # 1000 <freep>
 80e:	c905                	beqz	a0,83e <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 812:	4798                	lw	a4,8(a5)
 814:	09377663          	bgeu	a4,s3,8a0 <malloc+0xb8>
 818:	f426                	sd	s1,40(sp)
 81a:	e852                	sd	s4,16(sp)
 81c:	e456                	sd	s5,8(sp)
 81e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 820:	8a4e                	mv	s4,s3
 822:	6705                	lui	a4,0x1
 824:	00e9f363          	bgeu	s3,a4,82a <malloc+0x42>
 828:	6a05                	lui	s4,0x1
 82a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 82e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 832:	00000497          	auipc	s1,0x0
 836:	7ce48493          	addi	s1,s1,1998 # 1000 <freep>
  if(p == SBRK_ERROR)
 83a:	5afd                	li	s5,-1
 83c:	a83d                	j	87a <malloc+0x92>
 83e:	f426                	sd	s1,40(sp)
 840:	e852                	sd	s4,16(sp)
 842:	e456                	sd	s5,8(sp)
 844:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 846:	00000797          	auipc	a5,0x0
 84a:	7ca78793          	addi	a5,a5,1994 # 1010 <base>
 84e:	00000717          	auipc	a4,0x0
 852:	7af73923          	sd	a5,1970(a4) # 1000 <freep>
 856:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 858:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 85c:	b7d1                	j	820 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 85e:	6398                	ld	a4,0(a5)
 860:	e118                	sd	a4,0(a0)
 862:	a899                	j	8b8 <malloc+0xd0>
  hp->s.size = nu;
 864:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 868:	0541                	addi	a0,a0,16
 86a:	ef9ff0ef          	jal	762 <free>
  return freep;
 86e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 870:	c125                	beqz	a0,8d0 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 872:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 874:	4798                	lw	a4,8(a5)
 876:	03277163          	bgeu	a4,s2,898 <malloc+0xb0>
    if(p == freep)
 87a:	6098                	ld	a4,0(s1)
 87c:	853e                	mv	a0,a5
 87e:	fef71ae3          	bne	a4,a5,872 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 882:	8552                	mv	a0,s4
 884:	a59ff0ef          	jal	2dc <sbrk>
  if(p == SBRK_ERROR)
 888:	fd551ee3          	bne	a0,s5,864 <malloc+0x7c>
        return 0;
 88c:	4501                	li	a0,0
 88e:	74a2                	ld	s1,40(sp)
 890:	6a42                	ld	s4,16(sp)
 892:	6aa2                	ld	s5,8(sp)
 894:	6b02                	ld	s6,0(sp)
 896:	a03d                	j	8c4 <malloc+0xdc>
 898:	74a2                	ld	s1,40(sp)
 89a:	6a42                	ld	s4,16(sp)
 89c:	6aa2                	ld	s5,8(sp)
 89e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8a0:	fae90fe3          	beq	s2,a4,85e <malloc+0x76>
        p->s.size -= nunits;
 8a4:	4137073b          	subw	a4,a4,s3
 8a8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8aa:	02071693          	slli	a3,a4,0x20
 8ae:	01c6d713          	srli	a4,a3,0x1c
 8b2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8b4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8b8:	00000717          	auipc	a4,0x0
 8bc:	74a73423          	sd	a0,1864(a4) # 1000 <freep>
      return (void*)(p + 1);
 8c0:	01078513          	addi	a0,a5,16
  }
}
 8c4:	70e2                	ld	ra,56(sp)
 8c6:	7442                	ld	s0,48(sp)
 8c8:	7902                	ld	s2,32(sp)
 8ca:	69e2                	ld	s3,24(sp)
 8cc:	6121                	addi	sp,sp,64
 8ce:	8082                	ret
 8d0:	74a2                	ld	s1,40(sp)
 8d2:	6a42                	ld	s4,16(sp)
 8d4:	6aa2                	ld	s5,8(sp)
 8d6:	6b02                	ld	s6,0(sp)
 8d8:	b7f5                	j	8c4 <malloc+0xdc>
