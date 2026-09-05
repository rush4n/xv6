
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)

  if(mkdir("dd") != 0){
   c:	00001517          	auipc	a0,0x1
  10:	91450513          	addi	a0,a0,-1772 # 920 <malloc+0xf2>
  14:	3aa000ef          	jal	3be <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	90c50513          	addi	a0,a0,-1780 # 928 <malloc+0xfa>
  24:	752000ef          	jal	776 <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	32c000ef          	jal	356 <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	8f250513          	addi	a0,a0,-1806 # 920 <malloc+0xf2>
  36:	390000ef          	jal	3c6 <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	90250513          	addi	a0,a0,-1790 # 940 <malloc+0x112>
  46:	730000ef          	jal	776 <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	30a000ef          	jal	356 <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	90850513          	addi	a0,a0,-1784 # 958 <malloc+0x12a>
  58:	34e000ef          	jal	3a6 <unlink>
  5c:	00054e63          	bltz	a0,78 <main+0x78>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	91850513          	addi	a0,a0,-1768 # 978 <malloc+0x14a>
  68:	70e000ef          	jal	776 <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800493          	li	s1,1000
  70:	8526                	mv	a0,s1
  72:	374000ef          	jal	3e6 <pause>
  76:	bfed                	j	70 <main+0x70>
    printf("%s: unlink failed\n", s);
  78:	85a6                	mv	a1,s1
  7a:	00001517          	auipc	a0,0x1
  7e:	8e650513          	addi	a0,a0,-1818 # 960 <malloc+0x132>
  82:	6f4000ef          	jal	776 <printf>
    exit(1);
  86:	4505                	li	a0,1
  88:	2ce000ef          	jal	356 <exit>

000000000000008c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  8c:	1141                	addi	sp,sp,-16
  8e:	e406                	sd	ra,8(sp)
  90:	e022                	sd	s0,0(sp)
  92:	0800                	addi	s0,sp,16
  extern int main();
  main();
  94:	f6dff0ef          	jal	0 <main>
  exit(0);
  98:	4501                	li	a0,0
  9a:	2bc000ef          	jal	356 <exit>

000000000000009e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9e:	1141                	addi	sp,sp,-16
  a0:	e406                	sd	ra,8(sp)
  a2:	e022                	sd	s0,0(sp)
  a4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a6:	87aa                	mv	a5,a0
  a8:	0585                	addi	a1,a1,1
  aa:	0785                	addi	a5,a5,1
  ac:	fff5c703          	lbu	a4,-1(a1)
  b0:	fee78fa3          	sb	a4,-1(a5)
  b4:	fb75                	bnez	a4,a8 <strcpy+0xa>
    ;
  return os;
}
  b6:	60a2                	ld	ra,8(sp)
  b8:	6402                	ld	s0,0(sp)
  ba:	0141                	addi	sp,sp,16
  bc:	8082                	ret

00000000000000be <strcmp>:

int
strcmp(const char *p, const char *q)
{
  be:	1141                	addi	sp,sp,-16
  c0:	e406                	sd	ra,8(sp)
  c2:	e022                	sd	s0,0(sp)
  c4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c6:	00054783          	lbu	a5,0(a0)
  ca:	cb91                	beqz	a5,de <strcmp+0x20>
  cc:	0005c703          	lbu	a4,0(a1)
  d0:	00f71763          	bne	a4,a5,de <strcmp+0x20>
    p++, q++;
  d4:	0505                	addi	a0,a0,1
  d6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d8:	00054783          	lbu	a5,0(a0)
  dc:	fbe5                	bnez	a5,cc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
  de:	0005c503          	lbu	a0,0(a1)
}
  e2:	40a7853b          	subw	a0,a5,a0
  e6:	60a2                	ld	ra,8(sp)
  e8:	6402                	ld	s0,0(sp)
  ea:	0141                	addi	sp,sp,16
  ec:	8082                	ret

00000000000000ee <strlen>:

uint
strlen(const char *s)
{
  ee:	1141                	addi	sp,sp,-16
  f0:	e406                	sd	ra,8(sp)
  f2:	e022                	sd	s0,0(sp)
  f4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cf99                	beqz	a5,118 <strlen+0x2a>
  fc:	0505                	addi	a0,a0,1
  fe:	87aa                	mv	a5,a0
 100:	86be                	mv	a3,a5
 102:	0785                	addi	a5,a5,1
 104:	fff7c703          	lbu	a4,-1(a5)
 108:	ff65                	bnez	a4,100 <strlen+0x12>
 10a:	40a6853b          	subw	a0,a3,a0
 10e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 110:	60a2                	ld	ra,8(sp)
 112:	6402                	ld	s0,0(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret
  for(n = 0; s[n]; n++)
 118:	4501                	li	a0,0
 11a:	bfdd                	j	110 <strlen+0x22>

000000000000011c <memset>:

void*
memset(void *dst, int c, uint n)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e406                	sd	ra,8(sp)
 120:	e022                	sd	s0,0(sp)
 122:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 124:	ca19                	beqz	a2,13a <memset+0x1e>
 126:	87aa                	mv	a5,a0
 128:	1602                	slli	a2,a2,0x20
 12a:	9201                	srli	a2,a2,0x20
 12c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 130:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 134:	0785                	addi	a5,a5,1
 136:	fee79de3          	bne	a5,a4,130 <memset+0x14>
  }
  return dst;
}
 13a:	60a2                	ld	ra,8(sp)
 13c:	6402                	ld	s0,0(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret

0000000000000142 <strchr>:

char*
strchr(const char *s, char c)
{
 142:	1141                	addi	sp,sp,-16
 144:	e406                	sd	ra,8(sp)
 146:	e022                	sd	s0,0(sp)
 148:	0800                	addi	s0,sp,16
  for(; *s; s++)
 14a:	00054783          	lbu	a5,0(a0)
 14e:	cf81                	beqz	a5,166 <strchr+0x24>
    if(*s == c)
 150:	00f58763          	beq	a1,a5,15e <strchr+0x1c>
  for(; *s; s++)
 154:	0505                	addi	a0,a0,1
 156:	00054783          	lbu	a5,0(a0)
 15a:	fbfd                	bnez	a5,150 <strchr+0xe>
      return (char*)s;
  return 0;
 15c:	4501                	li	a0,0
}
 15e:	60a2                	ld	ra,8(sp)
 160:	6402                	ld	s0,0(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret
  return 0;
 166:	4501                	li	a0,0
 168:	bfdd                	j	15e <strchr+0x1c>

000000000000016a <gets>:

char*
gets(char *buf, int max)
{
 16a:	7159                	addi	sp,sp,-112
 16c:	f486                	sd	ra,104(sp)
 16e:	f0a2                	sd	s0,96(sp)
 170:	eca6                	sd	s1,88(sp)
 172:	e8ca                	sd	s2,80(sp)
 174:	e4ce                	sd	s3,72(sp)
 176:	e0d2                	sd	s4,64(sp)
 178:	fc56                	sd	s5,56(sp)
 17a:	f85a                	sd	s6,48(sp)
 17c:	f45e                	sd	s7,40(sp)
 17e:	f062                	sd	s8,32(sp)
 180:	ec66                	sd	s9,24(sp)
 182:	e86a                	sd	s10,16(sp)
 184:	1880                	addi	s0,sp,112
 186:	8caa                	mv	s9,a0
 188:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 18a:	892a                	mv	s2,a0
 18c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 18e:	f9f40b13          	addi	s6,s0,-97
 192:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 194:	4ba9                	li	s7,10
 196:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 198:	8d26                	mv	s10,s1
 19a:	0014899b          	addiw	s3,s1,1
 19e:	84ce                	mv	s1,s3
 1a0:	0349d563          	bge	s3,s4,1ca <gets+0x60>
    cc = read(0, &c, 1);
 1a4:	8656                	mv	a2,s5
 1a6:	85da                	mv	a1,s6
 1a8:	4501                	li	a0,0
 1aa:	1c4000ef          	jal	36e <read>
    if(cc < 1)
 1ae:	00a05e63          	blez	a0,1ca <gets+0x60>
    buf[i++] = c;
 1b2:	f9f44783          	lbu	a5,-97(s0)
 1b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ba:	01778763          	beq	a5,s7,1c8 <gets+0x5e>
 1be:	0905                	addi	s2,s2,1
 1c0:	fd879ce3          	bne	a5,s8,198 <gets+0x2e>
    buf[i++] = c;
 1c4:	8d4e                	mv	s10,s3
 1c6:	a011                	j	1ca <gets+0x60>
 1c8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 1ca:	9d66                	add	s10,s10,s9
 1cc:	000d0023          	sb	zero,0(s10)
  return buf;
}
 1d0:	8566                	mv	a0,s9
 1d2:	70a6                	ld	ra,104(sp)
 1d4:	7406                	ld	s0,96(sp)
 1d6:	64e6                	ld	s1,88(sp)
 1d8:	6946                	ld	s2,80(sp)
 1da:	69a6                	ld	s3,72(sp)
 1dc:	6a06                	ld	s4,64(sp)
 1de:	7ae2                	ld	s5,56(sp)
 1e0:	7b42                	ld	s6,48(sp)
 1e2:	7ba2                	ld	s7,40(sp)
 1e4:	7c02                	ld	s8,32(sp)
 1e6:	6ce2                	ld	s9,24(sp)
 1e8:	6d42                	ld	s10,16(sp)
 1ea:	6165                	addi	sp,sp,112
 1ec:	8082                	ret

00000000000001ee <stat>:

int
stat(const char *n, struct stat *st)
{
 1ee:	1101                	addi	sp,sp,-32
 1f0:	ec06                	sd	ra,24(sp)
 1f2:	e822                	sd	s0,16(sp)
 1f4:	e04a                	sd	s2,0(sp)
 1f6:	1000                	addi	s0,sp,32
 1f8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1fa:	4581                	li	a1,0
 1fc:	19a000ef          	jal	396 <open>
  if(fd < 0)
 200:	02054263          	bltz	a0,224 <stat+0x36>
 204:	e426                	sd	s1,8(sp)
 206:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 208:	85ca                	mv	a1,s2
 20a:	1a4000ef          	jal	3ae <fstat>
 20e:	892a                	mv	s2,a0
  close(fd);
 210:	8526                	mv	a0,s1
 212:	16c000ef          	jal	37e <close>
  return r;
 216:	64a2                	ld	s1,8(sp)
}
 218:	854a                	mv	a0,s2
 21a:	60e2                	ld	ra,24(sp)
 21c:	6442                	ld	s0,16(sp)
 21e:	6902                	ld	s2,0(sp)
 220:	6105                	addi	sp,sp,32
 222:	8082                	ret
    return -1;
 224:	597d                	li	s2,-1
 226:	bfcd                	j	218 <stat+0x2a>

0000000000000228 <atoi>:

int
atoi(const char *s)
{
 228:	1141                	addi	sp,sp,-16
 22a:	e406                	sd	ra,8(sp)
 22c:	e022                	sd	s0,0(sp)
 22e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 230:	00054683          	lbu	a3,0(a0)
 234:	fd06879b          	addiw	a5,a3,-48
 238:	0ff7f793          	zext.b	a5,a5
 23c:	4625                	li	a2,9
 23e:	02f66963          	bltu	a2,a5,270 <atoi+0x48>
 242:	872a                	mv	a4,a0
  n = 0;
 244:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 246:	0705                	addi	a4,a4,1
 248:	0025179b          	slliw	a5,a0,0x2
 24c:	9fa9                	addw	a5,a5,a0
 24e:	0017979b          	slliw	a5,a5,0x1
 252:	9fb5                	addw	a5,a5,a3
 254:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 258:	00074683          	lbu	a3,0(a4)
 25c:	fd06879b          	addiw	a5,a3,-48
 260:	0ff7f793          	zext.b	a5,a5
 264:	fef671e3          	bgeu	a2,a5,246 <atoi+0x1e>
  return n;
}
 268:	60a2                	ld	ra,8(sp)
 26a:	6402                	ld	s0,0(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret
  n = 0;
 270:	4501                	li	a0,0
 272:	bfdd                	j	268 <atoi+0x40>

0000000000000274 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 274:	1141                	addi	sp,sp,-16
 276:	e406                	sd	ra,8(sp)
 278:	e022                	sd	s0,0(sp)
 27a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27c:	02b57563          	bgeu	a0,a1,2a6 <memmove+0x32>
    while(n-- > 0)
 280:	00c05f63          	blez	a2,29e <memmove+0x2a>
 284:	1602                	slli	a2,a2,0x20
 286:	9201                	srli	a2,a2,0x20
 288:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28c:	872a                	mv	a4,a0
      *dst++ = *src++;
 28e:	0585                	addi	a1,a1,1
 290:	0705                	addi	a4,a4,1
 292:	fff5c683          	lbu	a3,-1(a1)
 296:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29a:	fee79ae3          	bne	a5,a4,28e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret
    dst += n;
 2a6:	00c50733          	add	a4,a0,a2
    src += n;
 2aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2ac:	fec059e3          	blez	a2,29e <memmove+0x2a>
 2b0:	fff6079b          	addiw	a5,a2,-1
 2b4:	1782                	slli	a5,a5,0x20
 2b6:	9381                	srli	a5,a5,0x20
 2b8:	fff7c793          	not	a5,a5
 2bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2be:	15fd                	addi	a1,a1,-1
 2c0:	177d                	addi	a4,a4,-1
 2c2:	0005c683          	lbu	a3,0(a1)
 2c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2ca:	fef71ae3          	bne	a4,a5,2be <memmove+0x4a>
 2ce:	bfc1                	j	29e <memmove+0x2a>

00000000000002d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d8:	ca0d                	beqz	a2,30a <memcmp+0x3a>
 2da:	fff6069b          	addiw	a3,a2,-1
 2de:	1682                	slli	a3,a3,0x20
 2e0:	9281                	srli	a3,a3,0x20
 2e2:	0685                	addi	a3,a3,1
 2e4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e6:	00054783          	lbu	a5,0(a0)
 2ea:	0005c703          	lbu	a4,0(a1)
 2ee:	00e79863          	bne	a5,a4,2fe <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 2f2:	0505                	addi	a0,a0,1
    p2++;
 2f4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f6:	fed518e3          	bne	a0,a3,2e6 <memcmp+0x16>
  }
  return 0;
 2fa:	4501                	li	a0,0
 2fc:	a019                	j	302 <memcmp+0x32>
      return *p1 - *p2;
 2fe:	40e7853b          	subw	a0,a5,a4
}
 302:	60a2                	ld	ra,8(sp)
 304:	6402                	ld	s0,0(sp)
 306:	0141                	addi	sp,sp,16
 308:	8082                	ret
  return 0;
 30a:	4501                	li	a0,0
 30c:	bfdd                	j	302 <memcmp+0x32>

000000000000030e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e406                	sd	ra,8(sp)
 312:	e022                	sd	s0,0(sp)
 314:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 316:	f5fff0ef          	jal	274 <memmove>
}
 31a:	60a2                	ld	ra,8(sp)
 31c:	6402                	ld	s0,0(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret

0000000000000322 <sbrk>:

char *
sbrk(int n) {
 322:	1141                	addi	sp,sp,-16
 324:	e406                	sd	ra,8(sp)
 326:	e022                	sd	s0,0(sp)
 328:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 32a:	4585                	li	a1,1
 32c:	0b2000ef          	jal	3de <sys_sbrk>
}
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret

0000000000000338 <sbrklazy>:

char *
sbrklazy(int n) {
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 340:	4589                	li	a1,2
 342:	09c000ef          	jal	3de <sys_sbrk>
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 34e:	4885                	li	a7,1
 ecall
 350:	00000073          	ecall
 ret
 354:	8082                	ret

0000000000000356 <exit>:
.global exit
exit:
 li a7, SYS_exit
 356:	4889                	li	a7,2
 ecall
 358:	00000073          	ecall
 ret
 35c:	8082                	ret

000000000000035e <wait>:
.global wait
wait:
 li a7, SYS_wait
 35e:	488d                	li	a7,3
 ecall
 360:	00000073          	ecall
 ret
 364:	8082                	ret

0000000000000366 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 366:	4891                	li	a7,4
 ecall
 368:	00000073          	ecall
 ret
 36c:	8082                	ret

000000000000036e <read>:
.global read
read:
 li a7, SYS_read
 36e:	4895                	li	a7,5
 ecall
 370:	00000073          	ecall
 ret
 374:	8082                	ret

0000000000000376 <write>:
.global write
write:
 li a7, SYS_write
 376:	48c1                	li	a7,16
 ecall
 378:	00000073          	ecall
 ret
 37c:	8082                	ret

000000000000037e <close>:
.global close
close:
 li a7, SYS_close
 37e:	48d5                	li	a7,21
 ecall
 380:	00000073          	ecall
 ret
 384:	8082                	ret

0000000000000386 <kill>:
.global kill
kill:
 li a7, SYS_kill
 386:	4899                	li	a7,6
 ecall
 388:	00000073          	ecall
 ret
 38c:	8082                	ret

000000000000038e <exec>:
.global exec
exec:
 li a7, SYS_exec
 38e:	489d                	li	a7,7
 ecall
 390:	00000073          	ecall
 ret
 394:	8082                	ret

0000000000000396 <open>:
.global open
open:
 li a7, SYS_open
 396:	48bd                	li	a7,15
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 39e:	48c5                	li	a7,17
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3a6:	48c9                	li	a7,18
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ae:	48a1                	li	a7,8
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <link>:
.global link
link:
 li a7, SYS_link
 3b6:	48cd                	li	a7,19
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3be:	48d1                	li	a7,20
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3c6:	48a5                	li	a7,9
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ce:	48a9                	li	a7,10
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3d6:	48ad                	li	a7,11
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3de:	48b1                	li	a7,12
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3e6:	48b5                	li	a7,13
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ee:	48b9                	li	a7,14
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3f6:	1101                	addi	sp,sp,-32
 3f8:	ec06                	sd	ra,24(sp)
 3fa:	e822                	sd	s0,16(sp)
 3fc:	1000                	addi	s0,sp,32
 3fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 402:	4605                	li	a2,1
 404:	fef40593          	addi	a1,s0,-17
 408:	f6fff0ef          	jal	376 <write>
}
 40c:	60e2                	ld	ra,24(sp)
 40e:	6442                	ld	s0,16(sp)
 410:	6105                	addi	sp,sp,32
 412:	8082                	ret

0000000000000414 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 414:	715d                	addi	sp,sp,-80
 416:	e486                	sd	ra,72(sp)
 418:	e0a2                	sd	s0,64(sp)
 41a:	fc26                	sd	s1,56(sp)
 41c:	f84a                	sd	s2,48(sp)
 41e:	f44e                	sd	s3,40(sp)
 420:	0880                	addi	s0,sp,80
 422:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 424:	c299                	beqz	a3,42a <printint+0x16>
 426:	0605cf63          	bltz	a1,4a4 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 42a:	2581                	sext.w	a1,a1
  neg = 0;
 42c:	4e01                	li	t3,0
  }

  i = 0;
 42e:	fb840313          	addi	t1,s0,-72
  neg = 0;
 432:	869a                	mv	a3,t1
  i = 0;
 434:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 436:	00000817          	auipc	a6,0x0
 43a:	56a80813          	addi	a6,a6,1386 # 9a0 <digits>
 43e:	88be                	mv	a7,a5
 440:	0017851b          	addiw	a0,a5,1
 444:	87aa                	mv	a5,a0
 446:	02c5f73b          	remuw	a4,a1,a2
 44a:	1702                	slli	a4,a4,0x20
 44c:	9301                	srli	a4,a4,0x20
 44e:	9742                	add	a4,a4,a6
 450:	00074703          	lbu	a4,0(a4)
 454:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 458:	872e                	mv	a4,a1
 45a:	02c5d5bb          	divuw	a1,a1,a2
 45e:	0685                	addi	a3,a3,1
 460:	fcc77fe3          	bgeu	a4,a2,43e <printint+0x2a>
  if(neg)
 464:	000e0c63          	beqz	t3,47c <printint+0x68>
    buf[i++] = '-';
 468:	fd050793          	addi	a5,a0,-48
 46c:	00878533          	add	a0,a5,s0
 470:	02d00793          	li	a5,45
 474:	fef50423          	sb	a5,-24(a0)
 478:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 47c:	fff7899b          	addiw	s3,a5,-1
 480:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 484:	fff4c583          	lbu	a1,-1(s1)
 488:	854a                	mv	a0,s2
 48a:	f6dff0ef          	jal	3f6 <putc>
  while(--i >= 0)
 48e:	39fd                	addiw	s3,s3,-1
 490:	14fd                	addi	s1,s1,-1
 492:	fe09d9e3          	bgez	s3,484 <printint+0x70>
}
 496:	60a6                	ld	ra,72(sp)
 498:	6406                	ld	s0,64(sp)
 49a:	74e2                	ld	s1,56(sp)
 49c:	7942                	ld	s2,48(sp)
 49e:	79a2                	ld	s3,40(sp)
 4a0:	6161                	addi	sp,sp,80
 4a2:	8082                	ret
    x = -xx;
 4a4:	40b005bb          	negw	a1,a1
    neg = 1;
 4a8:	4e05                	li	t3,1
    x = -xx;
 4aa:	b751                	j	42e <printint+0x1a>

00000000000004ac <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4ac:	711d                	addi	sp,sp,-96
 4ae:	ec86                	sd	ra,88(sp)
 4b0:	e8a2                	sd	s0,80(sp)
 4b2:	e4a6                	sd	s1,72(sp)
 4b4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4b6:	0005c483          	lbu	s1,0(a1)
 4ba:	28048463          	beqz	s1,742 <vprintf+0x296>
 4be:	e0ca                	sd	s2,64(sp)
 4c0:	fc4e                	sd	s3,56(sp)
 4c2:	f852                	sd	s4,48(sp)
 4c4:	f456                	sd	s5,40(sp)
 4c6:	f05a                	sd	s6,32(sp)
 4c8:	ec5e                	sd	s7,24(sp)
 4ca:	e862                	sd	s8,16(sp)
 4cc:	e466                	sd	s9,8(sp)
 4ce:	8b2a                	mv	s6,a0
 4d0:	8a2e                	mv	s4,a1
 4d2:	8bb2                	mv	s7,a2
  state = 0;
 4d4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4d6:	4901                	li	s2,0
 4d8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4da:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4de:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4e2:	06c00c93          	li	s9,108
 4e6:	a00d                	j	508 <vprintf+0x5c>
        putc(fd, c0);
 4e8:	85a6                	mv	a1,s1
 4ea:	855a                	mv	a0,s6
 4ec:	f0bff0ef          	jal	3f6 <putc>
 4f0:	a019                	j	4f6 <vprintf+0x4a>
    } else if(state == '%'){
 4f2:	03598363          	beq	s3,s5,518 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 4f6:	0019079b          	addiw	a5,s2,1
 4fa:	893e                	mv	s2,a5
 4fc:	873e                	mv	a4,a5
 4fe:	97d2                	add	a5,a5,s4
 500:	0007c483          	lbu	s1,0(a5)
 504:	22048763          	beqz	s1,732 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 508:	0004879b          	sext.w	a5,s1
    if(state == 0){
 50c:	fe0993e3          	bnez	s3,4f2 <vprintf+0x46>
      if(c0 == '%'){
 510:	fd579ce3          	bne	a5,s5,4e8 <vprintf+0x3c>
        state = '%';
 514:	89be                	mv	s3,a5
 516:	b7c5                	j	4f6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 518:	00ea06b3          	add	a3,s4,a4
 51c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 520:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 522:	c681                	beqz	a3,52a <vprintf+0x7e>
 524:	9752                	add	a4,a4,s4
 526:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 52a:	05878263          	beq	a5,s8,56e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 52e:	05978c63          	beq	a5,s9,586 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 532:	07500713          	li	a4,117
 536:	0ee78663          	beq	a5,a4,622 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 53a:	07800713          	li	a4,120
 53e:	12e78863          	beq	a5,a4,66e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 542:	07000713          	li	a4,112
 546:	14e78d63          	beq	a5,a4,6a0 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 54a:	06300713          	li	a4,99
 54e:	18e78c63          	beq	a5,a4,6e6 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 552:	07300713          	li	a4,115
 556:	1ae78263          	beq	a5,a4,6fa <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 55a:	02500713          	li	a4,37
 55e:	04e79463          	bne	a5,a4,5a6 <vprintf+0xfa>
        putc(fd, '%');
 562:	85ba                	mv	a1,a4
 564:	855a                	mv	a0,s6
 566:	e91ff0ef          	jal	3f6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 56a:	4981                	li	s3,0
 56c:	b769                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 56e:	008b8493          	addi	s1,s7,8
 572:	4685                	li	a3,1
 574:	4629                	li	a2,10
 576:	000ba583          	lw	a1,0(s7)
 57a:	855a                	mv	a0,s6
 57c:	e99ff0ef          	jal	414 <printint>
 580:	8ba6                	mv	s7,s1
      state = 0;
 582:	4981                	li	s3,0
 584:	bf8d                	j	4f6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 586:	06400793          	li	a5,100
 58a:	02f68963          	beq	a3,a5,5bc <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 58e:	06c00793          	li	a5,108
 592:	04f68263          	beq	a3,a5,5d6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 596:	07500793          	li	a5,117
 59a:	0af68063          	beq	a3,a5,63a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 59e:	07800793          	li	a5,120
 5a2:	0ef68263          	beq	a3,a5,686 <vprintf+0x1da>
        putc(fd, '%');
 5a6:	02500593          	li	a1,37
 5aa:	855a                	mv	a0,s6
 5ac:	e4bff0ef          	jal	3f6 <putc>
        putc(fd, c0);
 5b0:	85a6                	mv	a1,s1
 5b2:	855a                	mv	a0,s6
 5b4:	e43ff0ef          	jal	3f6 <putc>
      state = 0;
 5b8:	4981                	li	s3,0
 5ba:	bf35                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5bc:	008b8493          	addi	s1,s7,8
 5c0:	4685                	li	a3,1
 5c2:	4629                	li	a2,10
 5c4:	000bb583          	ld	a1,0(s7)
 5c8:	855a                	mv	a0,s6
 5ca:	e4bff0ef          	jal	414 <printint>
        i += 1;
 5ce:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d0:	8ba6                	mv	s7,s1
      state = 0;
 5d2:	4981                	li	s3,0
        i += 1;
 5d4:	b70d                	j	4f6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5d6:	06400793          	li	a5,100
 5da:	02f60763          	beq	a2,a5,608 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5de:	07500793          	li	a5,117
 5e2:	06f60963          	beq	a2,a5,654 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5e6:	07800793          	li	a5,120
 5ea:	faf61ee3          	bne	a2,a5,5a6 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5ee:	008b8493          	addi	s1,s7,8
 5f2:	4681                	li	a3,0
 5f4:	4641                	li	a2,16
 5f6:	000bb583          	ld	a1,0(s7)
 5fa:	855a                	mv	a0,s6
 5fc:	e19ff0ef          	jal	414 <printint>
        i += 2;
 600:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 602:	8ba6                	mv	s7,s1
      state = 0;
 604:	4981                	li	s3,0
        i += 2;
 606:	bdc5                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 608:	008b8493          	addi	s1,s7,8
 60c:	4685                	li	a3,1
 60e:	4629                	li	a2,10
 610:	000bb583          	ld	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	dffff0ef          	jal	414 <printint>
        i += 2;
 61a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 61c:	8ba6                	mv	s7,s1
      state = 0;
 61e:	4981                	li	s3,0
        i += 2;
 620:	bdd9                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 622:	008b8493          	addi	s1,s7,8
 626:	4681                	li	a3,0
 628:	4629                	li	a2,10
 62a:	000be583          	lwu	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	de5ff0ef          	jal	414 <printint>
 634:	8ba6                	mv	s7,s1
      state = 0;
 636:	4981                	li	s3,0
 638:	bd7d                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 63a:	008b8493          	addi	s1,s7,8
 63e:	4681                	li	a3,0
 640:	4629                	li	a2,10
 642:	000bb583          	ld	a1,0(s7)
 646:	855a                	mv	a0,s6
 648:	dcdff0ef          	jal	414 <printint>
        i += 1;
 64c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 64e:	8ba6                	mv	s7,s1
      state = 0;
 650:	4981                	li	s3,0
        i += 1;
 652:	b555                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 654:	008b8493          	addi	s1,s7,8
 658:	4681                	li	a3,0
 65a:	4629                	li	a2,10
 65c:	000bb583          	ld	a1,0(s7)
 660:	855a                	mv	a0,s6
 662:	db3ff0ef          	jal	414 <printint>
        i += 2;
 666:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 668:	8ba6                	mv	s7,s1
      state = 0;
 66a:	4981                	li	s3,0
        i += 2;
 66c:	b569                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 66e:	008b8493          	addi	s1,s7,8
 672:	4681                	li	a3,0
 674:	4641                	li	a2,16
 676:	000be583          	lwu	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	d99ff0ef          	jal	414 <printint>
 680:	8ba6                	mv	s7,s1
      state = 0;
 682:	4981                	li	s3,0
 684:	bd8d                	j	4f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 686:	008b8493          	addi	s1,s7,8
 68a:	4681                	li	a3,0
 68c:	4641                	li	a2,16
 68e:	000bb583          	ld	a1,0(s7)
 692:	855a                	mv	a0,s6
 694:	d81ff0ef          	jal	414 <printint>
        i += 1;
 698:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 69a:	8ba6                	mv	s7,s1
      state = 0;
 69c:	4981                	li	s3,0
        i += 1;
 69e:	bda1                	j	4f6 <vprintf+0x4a>
 6a0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6a2:	008b8d13          	addi	s10,s7,8
 6a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6aa:	03000593          	li	a1,48
 6ae:	855a                	mv	a0,s6
 6b0:	d47ff0ef          	jal	3f6 <putc>
  putc(fd, 'x');
 6b4:	07800593          	li	a1,120
 6b8:	855a                	mv	a0,s6
 6ba:	d3dff0ef          	jal	3f6 <putc>
 6be:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c0:	00000b97          	auipc	s7,0x0
 6c4:	2e0b8b93          	addi	s7,s7,736 # 9a0 <digits>
 6c8:	03c9d793          	srli	a5,s3,0x3c
 6cc:	97de                	add	a5,a5,s7
 6ce:	0007c583          	lbu	a1,0(a5)
 6d2:	855a                	mv	a0,s6
 6d4:	d23ff0ef          	jal	3f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6d8:	0992                	slli	s3,s3,0x4
 6da:	34fd                	addiw	s1,s1,-1
 6dc:	f4f5                	bnez	s1,6c8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 6de:	8bea                	mv	s7,s10
      state = 0;
 6e0:	4981                	li	s3,0
 6e2:	6d02                	ld	s10,0(sp)
 6e4:	bd09                	j	4f6 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6e6:	008b8493          	addi	s1,s7,8
 6ea:	000bc583          	lbu	a1,0(s7)
 6ee:	855a                	mv	a0,s6
 6f0:	d07ff0ef          	jal	3f6 <putc>
 6f4:	8ba6                	mv	s7,s1
      state = 0;
 6f6:	4981                	li	s3,0
 6f8:	bbfd                	j	4f6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6fa:	008b8993          	addi	s3,s7,8
 6fe:	000bb483          	ld	s1,0(s7)
 702:	cc91                	beqz	s1,71e <vprintf+0x272>
        for(; *s; s++)
 704:	0004c583          	lbu	a1,0(s1)
 708:	c195                	beqz	a1,72c <vprintf+0x280>
          putc(fd, *s);
 70a:	855a                	mv	a0,s6
 70c:	cebff0ef          	jal	3f6 <putc>
        for(; *s; s++)
 710:	0485                	addi	s1,s1,1
 712:	0004c583          	lbu	a1,0(s1)
 716:	f9f5                	bnez	a1,70a <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 718:	8bce                	mv	s7,s3
      state = 0;
 71a:	4981                	li	s3,0
 71c:	bbe9                	j	4f6 <vprintf+0x4a>
          s = "(null)";
 71e:	00000497          	auipc	s1,0x0
 722:	27a48493          	addi	s1,s1,634 # 998 <malloc+0x16a>
        for(; *s; s++)
 726:	02800593          	li	a1,40
 72a:	b7c5                	j	70a <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 72c:	8bce                	mv	s7,s3
      state = 0;
 72e:	4981                	li	s3,0
 730:	b3d9                	j	4f6 <vprintf+0x4a>
 732:	6906                	ld	s2,64(sp)
 734:	79e2                	ld	s3,56(sp)
 736:	7a42                	ld	s4,48(sp)
 738:	7aa2                	ld	s5,40(sp)
 73a:	7b02                	ld	s6,32(sp)
 73c:	6be2                	ld	s7,24(sp)
 73e:	6c42                	ld	s8,16(sp)
 740:	6ca2                	ld	s9,8(sp)
    }
  }
}
 742:	60e6                	ld	ra,88(sp)
 744:	6446                	ld	s0,80(sp)
 746:	64a6                	ld	s1,72(sp)
 748:	6125                	addi	sp,sp,96
 74a:	8082                	ret

000000000000074c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 74c:	715d                	addi	sp,sp,-80
 74e:	ec06                	sd	ra,24(sp)
 750:	e822                	sd	s0,16(sp)
 752:	1000                	addi	s0,sp,32
 754:	e010                	sd	a2,0(s0)
 756:	e414                	sd	a3,8(s0)
 758:	e818                	sd	a4,16(s0)
 75a:	ec1c                	sd	a5,24(s0)
 75c:	03043023          	sd	a6,32(s0)
 760:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 764:	8622                	mv	a2,s0
 766:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 76a:	d43ff0ef          	jal	4ac <vprintf>
}
 76e:	60e2                	ld	ra,24(sp)
 770:	6442                	ld	s0,16(sp)
 772:	6161                	addi	sp,sp,80
 774:	8082                	ret

0000000000000776 <printf>:

void
printf(const char *fmt, ...)
{
 776:	711d                	addi	sp,sp,-96
 778:	ec06                	sd	ra,24(sp)
 77a:	e822                	sd	s0,16(sp)
 77c:	1000                	addi	s0,sp,32
 77e:	e40c                	sd	a1,8(s0)
 780:	e810                	sd	a2,16(s0)
 782:	ec14                	sd	a3,24(s0)
 784:	f018                	sd	a4,32(s0)
 786:	f41c                	sd	a5,40(s0)
 788:	03043823          	sd	a6,48(s0)
 78c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 790:	00840613          	addi	a2,s0,8
 794:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 798:	85aa                	mv	a1,a0
 79a:	4505                	li	a0,1
 79c:	d11ff0ef          	jal	4ac <vprintf>
}
 7a0:	60e2                	ld	ra,24(sp)
 7a2:	6442                	ld	s0,16(sp)
 7a4:	6125                	addi	sp,sp,96
 7a6:	8082                	ret

00000000000007a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a8:	1141                	addi	sp,sp,-16
 7aa:	e406                	sd	ra,8(sp)
 7ac:	e022                	sd	s0,0(sp)
 7ae:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b4:	00001797          	auipc	a5,0x1
 7b8:	84c7b783          	ld	a5,-1972(a5) # 1000 <freep>
 7bc:	a02d                	j	7e6 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7be:	4618                	lw	a4,8(a2)
 7c0:	9f2d                	addw	a4,a4,a1
 7c2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	6398                	ld	a4,0(a5)
 7c8:	6310                	ld	a2,0(a4)
 7ca:	a83d                	j	808 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7cc:	ff852703          	lw	a4,-8(a0)
 7d0:	9f31                	addw	a4,a4,a2
 7d2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7d4:	ff053683          	ld	a3,-16(a0)
 7d8:	a091                	j	81c <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7da:	6398                	ld	a4,0(a5)
 7dc:	00e7e463          	bltu	a5,a4,7e4 <free+0x3c>
 7e0:	00e6ea63          	bltu	a3,a4,7f4 <free+0x4c>
{
 7e4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e6:	fed7fae3          	bgeu	a5,a3,7da <free+0x32>
 7ea:	6398                	ld	a4,0(a5)
 7ec:	00e6e463          	bltu	a3,a4,7f4 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f0:	fee7eae3          	bltu	a5,a4,7e4 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 7f4:	ff852583          	lw	a1,-8(a0)
 7f8:	6390                	ld	a2,0(a5)
 7fa:	02059813          	slli	a6,a1,0x20
 7fe:	01c85713          	srli	a4,a6,0x1c
 802:	9736                	add	a4,a4,a3
 804:	fae60de3          	beq	a2,a4,7be <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 808:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 80c:	4790                	lw	a2,8(a5)
 80e:	02061593          	slli	a1,a2,0x20
 812:	01c5d713          	srli	a4,a1,0x1c
 816:	973e                	add	a4,a4,a5
 818:	fae68ae3          	beq	a3,a4,7cc <free+0x24>
    p->s.ptr = bp->s.ptr;
 81c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 81e:	00000717          	auipc	a4,0x0
 822:	7ef73123          	sd	a5,2018(a4) # 1000 <freep>
}
 826:	60a2                	ld	ra,8(sp)
 828:	6402                	ld	s0,0(sp)
 82a:	0141                	addi	sp,sp,16
 82c:	8082                	ret

000000000000082e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 82e:	7139                	addi	sp,sp,-64
 830:	fc06                	sd	ra,56(sp)
 832:	f822                	sd	s0,48(sp)
 834:	f04a                	sd	s2,32(sp)
 836:	ec4e                	sd	s3,24(sp)
 838:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 83a:	02051993          	slli	s3,a0,0x20
 83e:	0209d993          	srli	s3,s3,0x20
 842:	09bd                	addi	s3,s3,15
 844:	0049d993          	srli	s3,s3,0x4
 848:	2985                	addiw	s3,s3,1
 84a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 84c:	00000517          	auipc	a0,0x0
 850:	7b453503          	ld	a0,1972(a0) # 1000 <freep>
 854:	c905                	beqz	a0,884 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 856:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 858:	4798                	lw	a4,8(a5)
 85a:	09377663          	bgeu	a4,s3,8e6 <malloc+0xb8>
 85e:	f426                	sd	s1,40(sp)
 860:	e852                	sd	s4,16(sp)
 862:	e456                	sd	s5,8(sp)
 864:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 866:	8a4e                	mv	s4,s3
 868:	6705                	lui	a4,0x1
 86a:	00e9f363          	bgeu	s3,a4,870 <malloc+0x42>
 86e:	6a05                	lui	s4,0x1
 870:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 874:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 878:	00000497          	auipc	s1,0x0
 87c:	78848493          	addi	s1,s1,1928 # 1000 <freep>
  if(p == SBRK_ERROR)
 880:	5afd                	li	s5,-1
 882:	a83d                	j	8c0 <malloc+0x92>
 884:	f426                	sd	s1,40(sp)
 886:	e852                	sd	s4,16(sp)
 888:	e456                	sd	s5,8(sp)
 88a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 88c:	00001797          	auipc	a5,0x1
 890:	97c78793          	addi	a5,a5,-1668 # 1208 <base>
 894:	00000717          	auipc	a4,0x0
 898:	76f73623          	sd	a5,1900(a4) # 1000 <freep>
 89c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 89e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8a2:	b7d1                	j	866 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8a4:	6398                	ld	a4,0(a5)
 8a6:	e118                	sd	a4,0(a0)
 8a8:	a899                	j	8fe <malloc+0xd0>
  hp->s.size = nu;
 8aa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8ae:	0541                	addi	a0,a0,16
 8b0:	ef9ff0ef          	jal	7a8 <free>
  return freep;
 8b4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8b6:	c125                	beqz	a0,916 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ba:	4798                	lw	a4,8(a5)
 8bc:	03277163          	bgeu	a4,s2,8de <malloc+0xb0>
    if(p == freep)
 8c0:	6098                	ld	a4,0(s1)
 8c2:	853e                	mv	a0,a5
 8c4:	fef71ae3          	bne	a4,a5,8b8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 8c8:	8552                	mv	a0,s4
 8ca:	a59ff0ef          	jal	322 <sbrk>
  if(p == SBRK_ERROR)
 8ce:	fd551ee3          	bne	a0,s5,8aa <malloc+0x7c>
        return 0;
 8d2:	4501                	li	a0,0
 8d4:	74a2                	ld	s1,40(sp)
 8d6:	6a42                	ld	s4,16(sp)
 8d8:	6aa2                	ld	s5,8(sp)
 8da:	6b02                	ld	s6,0(sp)
 8dc:	a03d                	j	90a <malloc+0xdc>
 8de:	74a2                	ld	s1,40(sp)
 8e0:	6a42                	ld	s4,16(sp)
 8e2:	6aa2                	ld	s5,8(sp)
 8e4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8e6:	fae90fe3          	beq	s2,a4,8a4 <malloc+0x76>
        p->s.size -= nunits;
 8ea:	4137073b          	subw	a4,a4,s3
 8ee:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8f0:	02071693          	slli	a3,a4,0x20
 8f4:	01c6d713          	srli	a4,a3,0x1c
 8f8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8fa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8fe:	00000717          	auipc	a4,0x0
 902:	70a73123          	sd	a0,1794(a4) # 1000 <freep>
      return (void*)(p + 1);
 906:	01078513          	addi	a0,a5,16
  }
}
 90a:	70e2                	ld	ra,56(sp)
 90c:	7442                	ld	s0,48(sp)
 90e:	7902                	ld	s2,32(sp)
 910:	69e2                	ld	s3,24(sp)
 912:	6121                	addi	sp,sp,64
 914:	8082                	ret
 916:	74a2                	ld	s1,40(sp)
 918:	6a42                	ld	s4,16(sp)
 91a:	6aa2                	ld	s5,8(sp)
 91c:	6b02                	ld	s6,0(sp)
 91e:	b7f5                	j	90a <malloc+0xdc>
