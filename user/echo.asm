
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	e05a                	sd	s6,0(sp)
  12:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  14:	4785                	li	a5,1
  16:	06a7d063          	bge	a5,a0,76 <main+0x76>
  1a:	00858493          	addi	s1,a1,8
  1e:	3579                	addiw	a0,a0,-2
  20:	02051793          	slli	a5,a0,0x20
  24:	01d7d513          	srli	a0,a5,0x1d
  28:	00a48ab3          	add	s5,s1,a0
  2c:	05c1                	addi	a1,a1,16
  2e:	00a58a33          	add	s4,a1,a0
    write(1, argv[i], strlen(argv[i]));
  32:	4985                	li	s3,1
    if(i + 1 < argc){
      write(1, " ", 1);
  34:	00001b17          	auipc	s6,0x1
  38:	8dcb0b13          	addi	s6,s6,-1828 # 910 <malloc+0xf2>
  3c:	a809                	j	4e <main+0x4e>
  3e:	864e                	mv	a2,s3
  40:	85da                	mv	a1,s6
  42:	854e                	mv	a0,s3
  44:	322000ef          	jal	366 <write>
  for(i = 1; i < argc; i++){
  48:	04a1                	addi	s1,s1,8
  4a:	03448663          	beq	s1,s4,76 <main+0x76>
    write(1, argv[i], strlen(argv[i]));
  4e:	0004b903          	ld	s2,0(s1)
  52:	854a                	mv	a0,s2
  54:	08a000ef          	jal	de <strlen>
  58:	862a                	mv	a2,a0
  5a:	85ca                	mv	a1,s2
  5c:	854e                	mv	a0,s3
  5e:	308000ef          	jal	366 <write>
    if(i + 1 < argc){
  62:	fd549ee3          	bne	s1,s5,3e <main+0x3e>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	8b058593          	addi	a1,a1,-1872 # 918 <malloc+0xfa>
  70:	8532                	mv	a0,a2
  72:	2f4000ef          	jal	366 <write>
    }
  }
  exit(0);
  76:	4501                	li	a0,0
  78:	2ce000ef          	jal	346 <exit>

000000000000007c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  7c:	1141                	addi	sp,sp,-16
  7e:	e406                	sd	ra,8(sp)
  80:	e022                	sd	s0,0(sp)
  82:	0800                	addi	s0,sp,16
  extern int main();
  main();
  84:	f7dff0ef          	jal	0 <main>
  exit(0);
  88:	4501                	li	a0,0
  8a:	2bc000ef          	jal	346 <exit>

000000000000008e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  8e:	1141                	addi	sp,sp,-16
  90:	e406                	sd	ra,8(sp)
  92:	e022                	sd	s0,0(sp)
  94:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  96:	87aa                	mv	a5,a0
  98:	0585                	addi	a1,a1,1
  9a:	0785                	addi	a5,a5,1
  9c:	fff5c703          	lbu	a4,-1(a1)
  a0:	fee78fa3          	sb	a4,-1(a5)
  a4:	fb75                	bnez	a4,98 <strcpy+0xa>
    ;
  return os;
}
  a6:	60a2                	ld	ra,8(sp)
  a8:	6402                	ld	s0,0(sp)
  aa:	0141                	addi	sp,sp,16
  ac:	8082                	ret

00000000000000ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ae:	1141                	addi	sp,sp,-16
  b0:	e406                	sd	ra,8(sp)
  b2:	e022                	sd	s0,0(sp)
  b4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cb91                	beqz	a5,ce <strcmp+0x20>
  bc:	0005c703          	lbu	a4,0(a1)
  c0:	00f71763          	bne	a4,a5,ce <strcmp+0x20>
    p++, q++;
  c4:	0505                	addi	a0,a0,1
  c6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	fbe5                	bnez	a5,bc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  ce:	0005c503          	lbu	a0,0(a1)
}
  d2:	40a7853b          	subw	a0,a5,a0
  d6:	60a2                	ld	ra,8(sp)
  d8:	6402                	ld	s0,0(sp)
  da:	0141                	addi	sp,sp,16
  dc:	8082                	ret

00000000000000de <strlen>:

uint
strlen(const char *s)
{
  de:	1141                	addi	sp,sp,-16
  e0:	e406                	sd	ra,8(sp)
  e2:	e022                	sd	s0,0(sp)
  e4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e6:	00054783          	lbu	a5,0(a0)
  ea:	cf99                	beqz	a5,108 <strlen+0x2a>
  ec:	0505                	addi	a0,a0,1
  ee:	87aa                	mv	a5,a0
  f0:	86be                	mv	a3,a5
  f2:	0785                	addi	a5,a5,1
  f4:	fff7c703          	lbu	a4,-1(a5)
  f8:	ff65                	bnez	a4,f0 <strlen+0x12>
  fa:	40a6853b          	subw	a0,a3,a0
  fe:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 100:	60a2                	ld	ra,8(sp)
 102:	6402                	ld	s0,0(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  for(n = 0; s[n]; n++)
 108:	4501                	li	a0,0
 10a:	bfdd                	j	100 <strlen+0x22>

000000000000010c <memset>:

void*
memset(void *dst, int c, uint n)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e406                	sd	ra,8(sp)
 110:	e022                	sd	s0,0(sp)
 112:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 114:	ca19                	beqz	a2,12a <memset+0x1e>
 116:	87aa                	mv	a5,a0
 118:	1602                	slli	a2,a2,0x20
 11a:	9201                	srli	a2,a2,0x20
 11c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 120:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 124:	0785                	addi	a5,a5,1
 126:	fee79de3          	bne	a5,a4,120 <memset+0x14>
  }
  return dst;
}
 12a:	60a2                	ld	ra,8(sp)
 12c:	6402                	ld	s0,0(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <strchr>:

char*
strchr(const char *s, char c)
{
 132:	1141                	addi	sp,sp,-16
 134:	e406                	sd	ra,8(sp)
 136:	e022                	sd	s0,0(sp)
 138:	0800                	addi	s0,sp,16
  for(; *s; s++)
 13a:	00054783          	lbu	a5,0(a0)
 13e:	cf81                	beqz	a5,156 <strchr+0x24>
    if(*s == c)
 140:	00f58763          	beq	a1,a5,14e <strchr+0x1c>
  for(; *s; s++)
 144:	0505                	addi	a0,a0,1
 146:	00054783          	lbu	a5,0(a0)
 14a:	fbfd                	bnez	a5,140 <strchr+0xe>
      return (char*)s;
  return 0;
 14c:	4501                	li	a0,0
}
 14e:	60a2                	ld	ra,8(sp)
 150:	6402                	ld	s0,0(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
  return 0;
 156:	4501                	li	a0,0
 158:	bfdd                	j	14e <strchr+0x1c>

000000000000015a <gets>:

char*
gets(char *buf, int max)
{
 15a:	7159                	addi	sp,sp,-112
 15c:	f486                	sd	ra,104(sp)
 15e:	f0a2                	sd	s0,96(sp)
 160:	eca6                	sd	s1,88(sp)
 162:	e8ca                	sd	s2,80(sp)
 164:	e4ce                	sd	s3,72(sp)
 166:	e0d2                	sd	s4,64(sp)
 168:	fc56                	sd	s5,56(sp)
 16a:	f85a                	sd	s6,48(sp)
 16c:	f45e                	sd	s7,40(sp)
 16e:	f062                	sd	s8,32(sp)
 170:	ec66                	sd	s9,24(sp)
 172:	e86a                	sd	s10,16(sp)
 174:	1880                	addi	s0,sp,112
 176:	8caa                	mv	s9,a0
 178:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17a:	892a                	mv	s2,a0
 17c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 17e:	f9f40b13          	addi	s6,s0,-97
 182:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 184:	4ba9                	li	s7,10
 186:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 188:	8d26                	mv	s10,s1
 18a:	0014899b          	addiw	s3,s1,1
 18e:	84ce                	mv	s1,s3
 190:	0349d563          	bge	s3,s4,1ba <gets+0x60>
    cc = read(0, &c, 1);
 194:	8656                	mv	a2,s5
 196:	85da                	mv	a1,s6
 198:	4501                	li	a0,0
 19a:	1c4000ef          	jal	35e <read>
    if(cc < 1)
 19e:	00a05e63          	blez	a0,1ba <gets+0x60>
    buf[i++] = c;
 1a2:	f9f44783          	lbu	a5,-97(s0)
 1a6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1aa:	01778763          	beq	a5,s7,1b8 <gets+0x5e>
 1ae:	0905                	addi	s2,s2,1
 1b0:	fd879ce3          	bne	a5,s8,188 <gets+0x2e>
    buf[i++] = c;
 1b4:	8d4e                	mv	s10,s3
 1b6:	a011                	j	1ba <gets+0x60>
 1b8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1ba:	9d66                	add	s10,s10,s9
 1bc:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1c0:	8566                	mv	a0,s9
 1c2:	70a6                	ld	ra,104(sp)
 1c4:	7406                	ld	s0,96(sp)
 1c6:	64e6                	ld	s1,88(sp)
 1c8:	6946                	ld	s2,80(sp)
 1ca:	69a6                	ld	s3,72(sp)
 1cc:	6a06                	ld	s4,64(sp)
 1ce:	7ae2                	ld	s5,56(sp)
 1d0:	7b42                	ld	s6,48(sp)
 1d2:	7ba2                	ld	s7,40(sp)
 1d4:	7c02                	ld	s8,32(sp)
 1d6:	6ce2                	ld	s9,24(sp)
 1d8:	6d42                	ld	s10,16(sp)
 1da:	6165                	addi	sp,sp,112
 1dc:	8082                	ret

00000000000001de <stat>:

int
stat(const char *n, struct stat *st)
{
 1de:	1101                	addi	sp,sp,-32
 1e0:	ec06                	sd	ra,24(sp)
 1e2:	e822                	sd	s0,16(sp)
 1e4:	e04a                	sd	s2,0(sp)
 1e6:	1000                	addi	s0,sp,32
 1e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ea:	4581                	li	a1,0
 1ec:	19a000ef          	jal	386 <open>
  if(fd < 0)
 1f0:	02054263          	bltz	a0,214 <stat+0x36>
 1f4:	e426                	sd	s1,8(sp)
 1f6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1f8:	85ca                	mv	a1,s2
 1fa:	1a4000ef          	jal	39e <fstat>
 1fe:	892a                	mv	s2,a0
  close(fd);
 200:	8526                	mv	a0,s1
 202:	16c000ef          	jal	36e <close>
  return r;
 206:	64a2                	ld	s1,8(sp)
}
 208:	854a                	mv	a0,s2
 20a:	60e2                	ld	ra,24(sp)
 20c:	6442                	ld	s0,16(sp)
 20e:	6902                	ld	s2,0(sp)
 210:	6105                	addi	sp,sp,32
 212:	8082                	ret
    return -1;
 214:	597d                	li	s2,-1
 216:	bfcd                	j	208 <stat+0x2a>

0000000000000218 <atoi>:

int
atoi(const char *s)
{
 218:	1141                	addi	sp,sp,-16
 21a:	e406                	sd	ra,8(sp)
 21c:	e022                	sd	s0,0(sp)
 21e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 220:	00054683          	lbu	a3,0(a0)
 224:	fd06879b          	addiw	a5,a3,-48
 228:	0ff7f793          	zext.b	a5,a5
 22c:	4625                	li	a2,9
 22e:	02f66963          	bltu	a2,a5,260 <atoi+0x48>
 232:	872a                	mv	a4,a0
  n = 0;
 234:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 236:	0705                	addi	a4,a4,1
 238:	0025179b          	slliw	a5,a0,0x2
 23c:	9fa9                	addw	a5,a5,a0
 23e:	0017979b          	slliw	a5,a5,0x1
 242:	9fb5                	addw	a5,a5,a3
 244:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 248:	00074683          	lbu	a3,0(a4)
 24c:	fd06879b          	addiw	a5,a3,-48
 250:	0ff7f793          	zext.b	a5,a5
 254:	fef671e3          	bgeu	a2,a5,236 <atoi+0x1e>
  return n;
}
 258:	60a2                	ld	ra,8(sp)
 25a:	6402                	ld	s0,0(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
  n = 0;
 260:	4501                	li	a0,0
 262:	bfdd                	j	258 <atoi+0x40>

0000000000000264 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 264:	1141                	addi	sp,sp,-16
 266:	e406                	sd	ra,8(sp)
 268:	e022                	sd	s0,0(sp)
 26a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 26c:	02b57563          	bgeu	a0,a1,296 <memmove+0x32>
    while(n-- > 0)
 270:	00c05f63          	blez	a2,28e <memmove+0x2a>
 274:	1602                	slli	a2,a2,0x20
 276:	9201                	srli	a2,a2,0x20
 278:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 27c:	872a                	mv	a4,a0
      *dst++ = *src++;
 27e:	0585                	addi	a1,a1,1
 280:	0705                	addi	a4,a4,1
 282:	fff5c683          	lbu	a3,-1(a1)
 286:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 28a:	fee79ae3          	bne	a5,a4,27e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28e:	60a2                	ld	ra,8(sp)
 290:	6402                	ld	s0,0(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
    dst += n;
 296:	00c50733          	add	a4,a0,a2
    src += n;
 29a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 29c:	fec059e3          	blez	a2,28e <memmove+0x2a>
 2a0:	fff6079b          	addiw	a5,a2,-1
 2a4:	1782                	slli	a5,a5,0x20
 2a6:	9381                	srli	a5,a5,0x20
 2a8:	fff7c793          	not	a5,a5
 2ac:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2ae:	15fd                	addi	a1,a1,-1
 2b0:	177d                	addi	a4,a4,-1
 2b2:	0005c683          	lbu	a3,0(a1)
 2b6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ba:	fef71ae3          	bne	a4,a5,2ae <memmove+0x4a>
 2be:	bfc1                	j	28e <memmove+0x2a>

00000000000002c0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2c0:	1141                	addi	sp,sp,-16
 2c2:	e406                	sd	ra,8(sp)
 2c4:	e022                	sd	s0,0(sp)
 2c6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c8:	ca0d                	beqz	a2,2fa <memcmp+0x3a>
 2ca:	fff6069b          	addiw	a3,a2,-1
 2ce:	1682                	slli	a3,a3,0x20
 2d0:	9281                	srli	a3,a3,0x20
 2d2:	0685                	addi	a3,a3,1
 2d4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2d6:	00054783          	lbu	a5,0(a0)
 2da:	0005c703          	lbu	a4,0(a1)
 2de:	00e79863          	bne	a5,a4,2ee <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2e2:	0505                	addi	a0,a0,1
    p2++;
 2e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2e6:	fed518e3          	bne	a0,a3,2d6 <memcmp+0x16>
  }
  return 0;
 2ea:	4501                	li	a0,0
 2ec:	a019                	j	2f2 <memcmp+0x32>
      return *p1 - *p2;
 2ee:	40e7853b          	subw	a0,a5,a4
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret
  return 0;
 2fa:	4501                	li	a0,0
 2fc:	bfdd                	j	2f2 <memcmp+0x32>

00000000000002fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2fe:	1141                	addi	sp,sp,-16
 300:	e406                	sd	ra,8(sp)
 302:	e022                	sd	s0,0(sp)
 304:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 306:	f5fff0ef          	jal	264 <memmove>
}
 30a:	60a2                	ld	ra,8(sp)
 30c:	6402                	ld	s0,0(sp)
 30e:	0141                	addi	sp,sp,16
 310:	8082                	ret

0000000000000312 <sbrk>:

char *
sbrk(int n) {
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 31a:	4585                	li	a1,1
 31c:	0b2000ef          	jal	3ce <sys_sbrk>
}
 320:	60a2                	ld	ra,8(sp)
 322:	6402                	ld	s0,0(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret

0000000000000328 <sbrklazy>:

char *
sbrklazy(int n) {
 328:	1141                	addi	sp,sp,-16
 32a:	e406                	sd	ra,8(sp)
 32c:	e022                	sd	s0,0(sp)
 32e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 330:	4589                	li	a1,2
 332:	09c000ef          	jal	3ce <sys_sbrk>
}
 336:	60a2                	ld	ra,8(sp)
 338:	6402                	ld	s0,0(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret

000000000000033e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33e:	4885                	li	a7,1
 ecall
 340:	00000073          	ecall
 ret
 344:	8082                	ret

0000000000000346 <exit>:
.global exit
exit:
 li a7, SYS_exit
 346:	4889                	li	a7,2
 ecall
 348:	00000073          	ecall
 ret
 34c:	8082                	ret

000000000000034e <wait>:
.global wait
wait:
 li a7, SYS_wait
 34e:	488d                	li	a7,3
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 356:	4891                	li	a7,4
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <read>:
.global read
read:
 li a7, SYS_read
 35e:	4895                	li	a7,5
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <write>:
.global write
write:
 li a7, SYS_write
 366:	48c1                	li	a7,16
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <close>:
.global close
close:
 li a7, SYS_close
 36e:	48d5                	li	a7,21
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <kill>:
.global kill
kill:
 li a7, SYS_kill
 376:	4899                	li	a7,6
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <exec>:
.global exec
exec:
 li a7, SYS_exec
 37e:	489d                	li	a7,7
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <open>:
.global open
open:
 li a7, SYS_open
 386:	48bd                	li	a7,15
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38e:	48c5                	li	a7,17
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 396:	48c9                	li	a7,18
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39e:	48a1                	li	a7,8
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <link>:
.global link
link:
 li a7, SYS_link
 3a6:	48cd                	li	a7,19
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3ae:	48d1                	li	a7,20
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b6:	48a5                	li	a7,9
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <dup>:
.global dup
dup:
 li a7, SYS_dup
 3be:	48a9                	li	a7,10
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c6:	48ad                	li	a7,11
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ce:	48b1                	li	a7,12
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3d6:	48b5                	li	a7,13
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3de:	48b9                	li	a7,14
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3e6:	1101                	addi	sp,sp,-32
 3e8:	ec06                	sd	ra,24(sp)
 3ea:	e822                	sd	s0,16(sp)
 3ec:	1000                	addi	s0,sp,32
 3ee:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3f2:	4605                	li	a2,1
 3f4:	fef40593          	addi	a1,s0,-17
 3f8:	f6fff0ef          	jal	366 <write>
}
 3fc:	60e2                	ld	ra,24(sp)
 3fe:	6442                	ld	s0,16(sp)
 400:	6105                	addi	sp,sp,32
 402:	8082                	ret

0000000000000404 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 404:	715d                	addi	sp,sp,-80
 406:	e486                	sd	ra,72(sp)
 408:	e0a2                	sd	s0,64(sp)
 40a:	fc26                	sd	s1,56(sp)
 40c:	f84a                	sd	s2,48(sp)
 40e:	f44e                	sd	s3,40(sp)
 410:	0880                	addi	s0,sp,80
 412:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 414:	c299                	beqz	a3,41a <printint+0x16>
 416:	0605cf63          	bltz	a1,494 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 41a:	2581                	sext.w	a1,a1
  neg = 0;
 41c:	4e01                	li	t3,0
  }

  i = 0;
 41e:	fb840313          	addi	t1,s0,-72
  neg = 0;
 422:	869a                	mv	a3,t1
  i = 0;
 424:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 426:	00000817          	auipc	a6,0x0
 42a:	50280813          	addi	a6,a6,1282 # 928 <digits>
 42e:	88be                	mv	a7,a5
 430:	0017851b          	addiw	a0,a5,1
 434:	87aa                	mv	a5,a0
 436:	02c5f73b          	remuw	a4,a1,a2
 43a:	1702                	slli	a4,a4,0x20
 43c:	9301                	srli	a4,a4,0x20
 43e:	9742                	add	a4,a4,a6
 440:	00074703          	lbu	a4,0(a4)
 444:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 448:	872e                	mv	a4,a1
 44a:	02c5d5bb          	divuw	a1,a1,a2
 44e:	0685                	addi	a3,a3,1
 450:	fcc77fe3          	bgeu	a4,a2,42e <printint+0x2a>
  if(neg)
 454:	000e0c63          	beqz	t3,46c <printint+0x68>
    buf[i++] = '-';
 458:	fd050793          	addi	a5,a0,-48
 45c:	00878533          	add	a0,a5,s0
 460:	02d00793          	li	a5,45
 464:	fef50423          	sb	a5,-24(a0)
 468:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 46c:	fff7899b          	addiw	s3,a5,-1
 470:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 474:	fff4c583          	lbu	a1,-1(s1)
 478:	854a                	mv	a0,s2
 47a:	f6dff0ef          	jal	3e6 <putc>
  while(--i >= 0)
 47e:	39fd                	addiw	s3,s3,-1
 480:	14fd                	addi	s1,s1,-1
 482:	fe09d9e3          	bgez	s3,474 <printint+0x70>
}
 486:	60a6                	ld	ra,72(sp)
 488:	6406                	ld	s0,64(sp)
 48a:	74e2                	ld	s1,56(sp)
 48c:	7942                	ld	s2,48(sp)
 48e:	79a2                	ld	s3,40(sp)
 490:	6161                	addi	sp,sp,80
 492:	8082                	ret
    x = -xx;
 494:	40b005bb          	negw	a1,a1
    neg = 1;
 498:	4e05                	li	t3,1
    x = -xx;
 49a:	b751                	j	41e <printint+0x1a>

000000000000049c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 49c:	711d                	addi	sp,sp,-96
 49e:	ec86                	sd	ra,88(sp)
 4a0:	e8a2                	sd	s0,80(sp)
 4a2:	e4a6                	sd	s1,72(sp)
 4a4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4a6:	0005c483          	lbu	s1,0(a1)
 4aa:	28048463          	beqz	s1,732 <vprintf+0x296>
 4ae:	e0ca                	sd	s2,64(sp)
 4b0:	fc4e                	sd	s3,56(sp)
 4b2:	f852                	sd	s4,48(sp)
 4b4:	f456                	sd	s5,40(sp)
 4b6:	f05a                	sd	s6,32(sp)
 4b8:	ec5e                	sd	s7,24(sp)
 4ba:	e862                	sd	s8,16(sp)
 4bc:	e466                	sd	s9,8(sp)
 4be:	8b2a                	mv	s6,a0
 4c0:	8a2e                	mv	s4,a1
 4c2:	8bb2                	mv	s7,a2
  state = 0;
 4c4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4c6:	4901                	li	s2,0
 4c8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4ca:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4ce:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4d2:	06c00c93          	li	s9,108
 4d6:	a00d                	j	4f8 <vprintf+0x5c>
        putc(fd, c0);
 4d8:	85a6                	mv	a1,s1
 4da:	855a                	mv	a0,s6
 4dc:	f0bff0ef          	jal	3e6 <putc>
 4e0:	a019                	j	4e6 <vprintf+0x4a>
    } else if(state == '%'){
 4e2:	03598363          	beq	s3,s5,508 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 4e6:	0019079b          	addiw	a5,s2,1
 4ea:	893e                	mv	s2,a5
 4ec:	873e                	mv	a4,a5
 4ee:	97d2                	add	a5,a5,s4
 4f0:	0007c483          	lbu	s1,0(a5)
 4f4:	22048763          	beqz	s1,722 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 4f8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 4fc:	fe0993e3          	bnez	s3,4e2 <vprintf+0x46>
      if(c0 == '%'){
 500:	fd579ce3          	bne	a5,s5,4d8 <vprintf+0x3c>
        state = '%';
 504:	89be                	mv	s3,a5
 506:	b7c5                	j	4e6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 508:	00ea06b3          	add	a3,s4,a4
 50c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 510:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 512:	c681                	beqz	a3,51a <vprintf+0x7e>
 514:	9752                	add	a4,a4,s4
 516:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 51a:	05878263          	beq	a5,s8,55e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 51e:	05978c63          	beq	a5,s9,576 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 522:	07500713          	li	a4,117
 526:	0ee78663          	beq	a5,a4,612 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 52a:	07800713          	li	a4,120
 52e:	12e78863          	beq	a5,a4,65e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 532:	07000713          	li	a4,112
 536:	14e78d63          	beq	a5,a4,690 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 53a:	06300713          	li	a4,99
 53e:	18e78c63          	beq	a5,a4,6d6 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 542:	07300713          	li	a4,115
 546:	1ae78263          	beq	a5,a4,6ea <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 54a:	02500713          	li	a4,37
 54e:	04e79463          	bne	a5,a4,596 <vprintf+0xfa>
        putc(fd, '%');
 552:	85ba                	mv	a1,a4
 554:	855a                	mv	a0,s6
 556:	e91ff0ef          	jal	3e6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 55a:	4981                	li	s3,0
 55c:	b769                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 55e:	008b8493          	addi	s1,s7,8
 562:	4685                	li	a3,1
 564:	4629                	li	a2,10
 566:	000ba583          	lw	a1,0(s7)
 56a:	855a                	mv	a0,s6
 56c:	e99ff0ef          	jal	404 <printint>
 570:	8ba6                	mv	s7,s1
      state = 0;
 572:	4981                	li	s3,0
 574:	bf8d                	j	4e6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 576:	06400793          	li	a5,100
 57a:	02f68963          	beq	a3,a5,5ac <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 57e:	06c00793          	li	a5,108
 582:	04f68263          	beq	a3,a5,5c6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 586:	07500793          	li	a5,117
 58a:	0af68063          	beq	a3,a5,62a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 58e:	07800793          	li	a5,120
 592:	0ef68263          	beq	a3,a5,676 <vprintf+0x1da>
        putc(fd, '%');
 596:	02500593          	li	a1,37
 59a:	855a                	mv	a0,s6
 59c:	e4bff0ef          	jal	3e6 <putc>
        putc(fd, c0);
 5a0:	85a6                	mv	a1,s1
 5a2:	855a                	mv	a0,s6
 5a4:	e43ff0ef          	jal	3e6 <putc>
      state = 0;
 5a8:	4981                	li	s3,0
 5aa:	bf35                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ac:	008b8493          	addi	s1,s7,8
 5b0:	4685                	li	a3,1
 5b2:	4629                	li	a2,10
 5b4:	000bb583          	ld	a1,0(s7)
 5b8:	855a                	mv	a0,s6
 5ba:	e4bff0ef          	jal	404 <printint>
        i += 1;
 5be:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5c0:	8ba6                	mv	s7,s1
      state = 0;
 5c2:	4981                	li	s3,0
        i += 1;
 5c4:	b70d                	j	4e6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5c6:	06400793          	li	a5,100
 5ca:	02f60763          	beq	a2,a5,5f8 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5ce:	07500793          	li	a5,117
 5d2:	06f60963          	beq	a2,a5,644 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5d6:	07800793          	li	a5,120
 5da:	faf61ee3          	bne	a2,a5,596 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5de:	008b8493          	addi	s1,s7,8
 5e2:	4681                	li	a3,0
 5e4:	4641                	li	a2,16
 5e6:	000bb583          	ld	a1,0(s7)
 5ea:	855a                	mv	a0,s6
 5ec:	e19ff0ef          	jal	404 <printint>
        i += 2;
 5f0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5f2:	8ba6                	mv	s7,s1
      state = 0;
 5f4:	4981                	li	s3,0
        i += 2;
 5f6:	bdc5                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f8:	008b8493          	addi	s1,s7,8
 5fc:	4685                	li	a3,1
 5fe:	4629                	li	a2,10
 600:	000bb583          	ld	a1,0(s7)
 604:	855a                	mv	a0,s6
 606:	dffff0ef          	jal	404 <printint>
        i += 2;
 60a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 60c:	8ba6                	mv	s7,s1
      state = 0;
 60e:	4981                	li	s3,0
        i += 2;
 610:	bdd9                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 612:	008b8493          	addi	s1,s7,8
 616:	4681                	li	a3,0
 618:	4629                	li	a2,10
 61a:	000be583          	lwu	a1,0(s7)
 61e:	855a                	mv	a0,s6
 620:	de5ff0ef          	jal	404 <printint>
 624:	8ba6                	mv	s7,s1
      state = 0;
 626:	4981                	li	s3,0
 628:	bd7d                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 62a:	008b8493          	addi	s1,s7,8
 62e:	4681                	li	a3,0
 630:	4629                	li	a2,10
 632:	000bb583          	ld	a1,0(s7)
 636:	855a                	mv	a0,s6
 638:	dcdff0ef          	jal	404 <printint>
        i += 1;
 63c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 63e:	8ba6                	mv	s7,s1
      state = 0;
 640:	4981                	li	s3,0
        i += 1;
 642:	b555                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 644:	008b8493          	addi	s1,s7,8
 648:	4681                	li	a3,0
 64a:	4629                	li	a2,10
 64c:	000bb583          	ld	a1,0(s7)
 650:	855a                	mv	a0,s6
 652:	db3ff0ef          	jal	404 <printint>
        i += 2;
 656:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 658:	8ba6                	mv	s7,s1
      state = 0;
 65a:	4981                	li	s3,0
        i += 2;
 65c:	b569                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 65e:	008b8493          	addi	s1,s7,8
 662:	4681                	li	a3,0
 664:	4641                	li	a2,16
 666:	000be583          	lwu	a1,0(s7)
 66a:	855a                	mv	a0,s6
 66c:	d99ff0ef          	jal	404 <printint>
 670:	8ba6                	mv	s7,s1
      state = 0;
 672:	4981                	li	s3,0
 674:	bd8d                	j	4e6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 676:	008b8493          	addi	s1,s7,8
 67a:	4681                	li	a3,0
 67c:	4641                	li	a2,16
 67e:	000bb583          	ld	a1,0(s7)
 682:	855a                	mv	a0,s6
 684:	d81ff0ef          	jal	404 <printint>
        i += 1;
 688:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 68a:	8ba6                	mv	s7,s1
      state = 0;
 68c:	4981                	li	s3,0
        i += 1;
 68e:	bda1                	j	4e6 <vprintf+0x4a>
 690:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 692:	008b8d13          	addi	s10,s7,8
 696:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 69a:	03000593          	li	a1,48
 69e:	855a                	mv	a0,s6
 6a0:	d47ff0ef          	jal	3e6 <putc>
  putc(fd, 'x');
 6a4:	07800593          	li	a1,120
 6a8:	855a                	mv	a0,s6
 6aa:	d3dff0ef          	jal	3e6 <putc>
 6ae:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b0:	00000b97          	auipc	s7,0x0
 6b4:	278b8b93          	addi	s7,s7,632 # 928 <digits>
 6b8:	03c9d793          	srli	a5,s3,0x3c
 6bc:	97de                	add	a5,a5,s7
 6be:	0007c583          	lbu	a1,0(a5)
 6c2:	855a                	mv	a0,s6
 6c4:	d23ff0ef          	jal	3e6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6c8:	0992                	slli	s3,s3,0x4
 6ca:	34fd                	addiw	s1,s1,-1
 6cc:	f4f5                	bnez	s1,6b8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 6ce:	8bea                	mv	s7,s10
      state = 0;
 6d0:	4981                	li	s3,0
 6d2:	6d02                	ld	s10,0(sp)
 6d4:	bd09                	j	4e6 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6d6:	008b8493          	addi	s1,s7,8
 6da:	000bc583          	lbu	a1,0(s7)
 6de:	855a                	mv	a0,s6
 6e0:	d07ff0ef          	jal	3e6 <putc>
 6e4:	8ba6                	mv	s7,s1
      state = 0;
 6e6:	4981                	li	s3,0
 6e8:	bbfd                	j	4e6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6ea:	008b8993          	addi	s3,s7,8
 6ee:	000bb483          	ld	s1,0(s7)
 6f2:	cc91                	beqz	s1,70e <vprintf+0x272>
        for(; *s; s++)
 6f4:	0004c583          	lbu	a1,0(s1)
 6f8:	c195                	beqz	a1,71c <vprintf+0x280>
          putc(fd, *s);
 6fa:	855a                	mv	a0,s6
 6fc:	cebff0ef          	jal	3e6 <putc>
        for(; *s; s++)
 700:	0485                	addi	s1,s1,1
 702:	0004c583          	lbu	a1,0(s1)
 706:	f9f5                	bnez	a1,6fa <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 708:	8bce                	mv	s7,s3
      state = 0;
 70a:	4981                	li	s3,0
 70c:	bbe9                	j	4e6 <vprintf+0x4a>
          s = "(null)";
 70e:	00000497          	auipc	s1,0x0
 712:	21248493          	addi	s1,s1,530 # 920 <malloc+0x102>
        for(; *s; s++)
 716:	02800593          	li	a1,40
 71a:	b7c5                	j	6fa <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 71c:	8bce                	mv	s7,s3
      state = 0;
 71e:	4981                	li	s3,0
 720:	b3d9                	j	4e6 <vprintf+0x4a>
 722:	6906                	ld	s2,64(sp)
 724:	79e2                	ld	s3,56(sp)
 726:	7a42                	ld	s4,48(sp)
 728:	7aa2                	ld	s5,40(sp)
 72a:	7b02                	ld	s6,32(sp)
 72c:	6be2                	ld	s7,24(sp)
 72e:	6c42                	ld	s8,16(sp)
 730:	6ca2                	ld	s9,8(sp)
    }
  }
}
 732:	60e6                	ld	ra,88(sp)
 734:	6446                	ld	s0,80(sp)
 736:	64a6                	ld	s1,72(sp)
 738:	6125                	addi	sp,sp,96
 73a:	8082                	ret

000000000000073c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 73c:	715d                	addi	sp,sp,-80
 73e:	ec06                	sd	ra,24(sp)
 740:	e822                	sd	s0,16(sp)
 742:	1000                	addi	s0,sp,32
 744:	e010                	sd	a2,0(s0)
 746:	e414                	sd	a3,8(s0)
 748:	e818                	sd	a4,16(s0)
 74a:	ec1c                	sd	a5,24(s0)
 74c:	03043023          	sd	a6,32(s0)
 750:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 754:	8622                	mv	a2,s0
 756:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 75a:	d43ff0ef          	jal	49c <vprintf>
}
 75e:	60e2                	ld	ra,24(sp)
 760:	6442                	ld	s0,16(sp)
 762:	6161                	addi	sp,sp,80
 764:	8082                	ret

0000000000000766 <printf>:

void
printf(const char *fmt, ...)
{
 766:	711d                	addi	sp,sp,-96
 768:	ec06                	sd	ra,24(sp)
 76a:	e822                	sd	s0,16(sp)
 76c:	1000                	addi	s0,sp,32
 76e:	e40c                	sd	a1,8(s0)
 770:	e810                	sd	a2,16(s0)
 772:	ec14                	sd	a3,24(s0)
 774:	f018                	sd	a4,32(s0)
 776:	f41c                	sd	a5,40(s0)
 778:	03043823          	sd	a6,48(s0)
 77c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 780:	00840613          	addi	a2,s0,8
 784:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 788:	85aa                	mv	a1,a0
 78a:	4505                	li	a0,1
 78c:	d11ff0ef          	jal	49c <vprintf>
}
 790:	60e2                	ld	ra,24(sp)
 792:	6442                	ld	s0,16(sp)
 794:	6125                	addi	sp,sp,96
 796:	8082                	ret

0000000000000798 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 798:	1141                	addi	sp,sp,-16
 79a:	e406                	sd	ra,8(sp)
 79c:	e022                	sd	s0,0(sp)
 79e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a4:	00001797          	auipc	a5,0x1
 7a8:	85c7b783          	ld	a5,-1956(a5) # 1000 <freep>
 7ac:	a02d                	j	7d6 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7ae:	4618                	lw	a4,8(a2)
 7b0:	9f2d                	addw	a4,a4,a1
 7b2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7b6:	6398                	ld	a4,0(a5)
 7b8:	6310                	ld	a2,0(a4)
 7ba:	a83d                	j	7f8 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7bc:	ff852703          	lw	a4,-8(a0)
 7c0:	9f31                	addw	a4,a4,a2
 7c2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7c4:	ff053683          	ld	a3,-16(a0)
 7c8:	a091                	j	80c <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ca:	6398                	ld	a4,0(a5)
 7cc:	00e7e463          	bltu	a5,a4,7d4 <free+0x3c>
 7d0:	00e6ea63          	bltu	a3,a4,7e4 <free+0x4c>
{
 7d4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d6:	fed7fae3          	bgeu	a5,a3,7ca <free+0x32>
 7da:	6398                	ld	a4,0(a5)
 7dc:	00e6e463          	bltu	a3,a4,7e4 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7e0:	fee7eae3          	bltu	a5,a4,7d4 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7e4:	ff852583          	lw	a1,-8(a0)
 7e8:	6390                	ld	a2,0(a5)
 7ea:	02059813          	slli	a6,a1,0x20
 7ee:	01c85713          	srli	a4,a6,0x1c
 7f2:	9736                	add	a4,a4,a3
 7f4:	fae60de3          	beq	a2,a4,7ae <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 7f8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7fc:	4790                	lw	a2,8(a5)
 7fe:	02061593          	slli	a1,a2,0x20
 802:	01c5d713          	srli	a4,a1,0x1c
 806:	973e                	add	a4,a4,a5
 808:	fae68ae3          	beq	a3,a4,7bc <free+0x24>
    p->s.ptr = bp->s.ptr;
 80c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 80e:	00000717          	auipc	a4,0x0
 812:	7ef73923          	sd	a5,2034(a4) # 1000 <freep>
}
 816:	60a2                	ld	ra,8(sp)
 818:	6402                	ld	s0,0(sp)
 81a:	0141                	addi	sp,sp,16
 81c:	8082                	ret

000000000000081e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 81e:	7139                	addi	sp,sp,-64
 820:	fc06                	sd	ra,56(sp)
 822:	f822                	sd	s0,48(sp)
 824:	f04a                	sd	s2,32(sp)
 826:	ec4e                	sd	s3,24(sp)
 828:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82a:	02051993          	slli	s3,a0,0x20
 82e:	0209d993          	srli	s3,s3,0x20
 832:	09bd                	addi	s3,s3,15
 834:	0049d993          	srli	s3,s3,0x4
 838:	2985                	addiw	s3,s3,1
 83a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 83c:	00000517          	auipc	a0,0x0
 840:	7c453503          	ld	a0,1988(a0) # 1000 <freep>
 844:	c905                	beqz	a0,874 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 848:	4798                	lw	a4,8(a5)
 84a:	09377663          	bgeu	a4,s3,8d6 <malloc+0xb8>
 84e:	f426                	sd	s1,40(sp)
 850:	e852                	sd	s4,16(sp)
 852:	e456                	sd	s5,8(sp)
 854:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 856:	8a4e                	mv	s4,s3
 858:	6705                	lui	a4,0x1
 85a:	00e9f363          	bgeu	s3,a4,860 <malloc+0x42>
 85e:	6a05                	lui	s4,0x1
 860:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 864:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 868:	00000497          	auipc	s1,0x0
 86c:	79848493          	addi	s1,s1,1944 # 1000 <freep>
  if(p == SBRK_ERROR)
 870:	5afd                	li	s5,-1
 872:	a83d                	j	8b0 <malloc+0x92>
 874:	f426                	sd	s1,40(sp)
 876:	e852                	sd	s4,16(sp)
 878:	e456                	sd	s5,8(sp)
 87a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 87c:	00000797          	auipc	a5,0x0
 880:	79478793          	addi	a5,a5,1940 # 1010 <base>
 884:	00000717          	auipc	a4,0x0
 888:	76f73e23          	sd	a5,1916(a4) # 1000 <freep>
 88c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 88e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 892:	b7d1                	j	856 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 894:	6398                	ld	a4,0(a5)
 896:	e118                	sd	a4,0(a0)
 898:	a899                	j	8ee <malloc+0xd0>
  hp->s.size = nu;
 89a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 89e:	0541                	addi	a0,a0,16
 8a0:	ef9ff0ef          	jal	798 <free>
  return freep;
 8a4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8a6:	c125                	beqz	a0,906 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8aa:	4798                	lw	a4,8(a5)
 8ac:	03277163          	bgeu	a4,s2,8ce <malloc+0xb0>
    if(p == freep)
 8b0:	6098                	ld	a4,0(s1)
 8b2:	853e                	mv	a0,a5
 8b4:	fef71ae3          	bne	a4,a5,8a8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8b8:	8552                	mv	a0,s4
 8ba:	a59ff0ef          	jal	312 <sbrk>
  if(p == SBRK_ERROR)
 8be:	fd551ee3          	bne	a0,s5,89a <malloc+0x7c>
        return 0;
 8c2:	4501                	li	a0,0
 8c4:	74a2                	ld	s1,40(sp)
 8c6:	6a42                	ld	s4,16(sp)
 8c8:	6aa2                	ld	s5,8(sp)
 8ca:	6b02                	ld	s6,0(sp)
 8cc:	a03d                	j	8fa <malloc+0xdc>
 8ce:	74a2                	ld	s1,40(sp)
 8d0:	6a42                	ld	s4,16(sp)
 8d2:	6aa2                	ld	s5,8(sp)
 8d4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8d6:	fae90fe3          	beq	s2,a4,894 <malloc+0x76>
        p->s.size -= nunits;
 8da:	4137073b          	subw	a4,a4,s3
 8de:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8e0:	02071693          	slli	a3,a4,0x20
 8e4:	01c6d713          	srli	a4,a3,0x1c
 8e8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ea:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8ee:	00000717          	auipc	a4,0x0
 8f2:	70a73923          	sd	a0,1810(a4) # 1000 <freep>
      return (void*)(p + 1);
 8f6:	01078513          	addi	a0,a5,16
  }
}
 8fa:	70e2                	ld	ra,56(sp)
 8fc:	7442                	ld	s0,48(sp)
 8fe:	7902                	ld	s2,32(sp)
 900:	69e2                	ld	s3,24(sp)
 902:	6121                	addi	sp,sp,64
 904:	8082                	ret
 906:	74a2                	ld	s1,40(sp)
 908:	6a42                	ld	s4,16(sp)
 90a:	6aa2                	ld	s5,8(sp)
 90c:	6b02                	ld	s6,0(sp)
 90e:	b7f5                	j	8fa <malloc+0xdc>
