
user/_forphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
  int fd = 0;
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)
  struct stat st;
  char *ff = "file0";
  
  if ((fd = open(ff, O_CREATE|O_WRONLY)) < 0) {
   c:	20100593          	li	a1,513
  10:	00001517          	auipc	a0,0x1
  14:	95050513          	addi	a0,a0,-1712 # 960 <malloc+0xf8>
  18:	3b8000ef          	jal	3d0 <open>
  1c:	04054463          	bltz	a0,64 <main+0x64>
    printf("%s: open failed\n", s);
    exit(1);
  }
  if(fstat(fd, &st) < 0){
  20:	fc840593          	addi	a1,s0,-56
  24:	3c4000ef          	jal	3e8 <fstat>
  28:	04054863          	bltz	a0,78 <main+0x78>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
    exit(1);
  }
  if (unlink(ff) < 0) {
  2c:	00001517          	auipc	a0,0x1
  30:	93450513          	addi	a0,a0,-1740 # 960 <malloc+0xf8>
  34:	3ac000ef          	jal	3e0 <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	92250513          	addi	a0,a0,-1758 # 960 <malloc+0xf8>
  46:	38a000ef          	jal	3d0 <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	96e50513          	addi	a0,a0,-1682 # 9c0 <malloc+0x158>
  5a:	756000ef          	jal	7b0 <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	330000ef          	jal	390 <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	90a50513          	addi	a0,a0,-1782 # 970 <malloc+0x108>
  6e:	742000ef          	jal	7b0 <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	31c000ef          	jal	390 <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	91068693          	addi	a3,a3,-1776 # 988 <malloc+0x120>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	90e58593          	addi	a1,a1,-1778 # 990 <malloc+0x128>
  8a:	4509                	li	a0,2
  8c:	6fa000ef          	jal	786 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	2fe000ef          	jal	390 <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	91050513          	addi	a0,a0,-1776 # 9a8 <malloc+0x140>
  a0:	710000ef          	jal	7b0 <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	2ea000ef          	jal	390 <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	92a50513          	addi	a0,a0,-1750 # 9d8 <malloc+0x170>
  b6:	6fa000ef          	jal	7b0 <printf>
  // sit around until killed
  for(;;) pause(1000);
  ba:	3e800493          	li	s1,1000
  be:	8526                	mv	a0,s1
  c0:	360000ef          	jal	420 <pause>
  c4:	bfed                	j	be <main+0xbe>

00000000000000c6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  c6:	1141                	addi	sp,sp,-16
  c8:	e406                	sd	ra,8(sp)
  ca:	e022                	sd	s0,0(sp)
  cc:	0800                	addi	s0,sp,16
  extern int main();
  main();
  ce:	f33ff0ef          	jal	0 <main>
  exit(0);
  d2:	4501                	li	a0,0
  d4:	2bc000ef          	jal	390 <exit>

00000000000000d8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  e0:	87aa                	mv	a5,a0
  e2:	0585                	addi	a1,a1,1
  e4:	0785                	addi	a5,a5,1
  e6:	fff5c703          	lbu	a4,-1(a1)
  ea:	fee78fa3          	sb	a4,-1(a5)
  ee:	fb75                	bnez	a4,e2 <strcpy+0xa>
    ;
  return os;
}
  f0:	60a2                	ld	ra,8(sp)
  f2:	6402                	ld	s0,0(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret

00000000000000f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e406                	sd	ra,8(sp)
  fc:	e022                	sd	s0,0(sp)
  fe:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	cb91                	beqz	a5,118 <strcmp+0x20>
 106:	0005c703          	lbu	a4,0(a1)
 10a:	00f71763          	bne	a4,a5,118 <strcmp+0x20>
    p++, q++;
 10e:	0505                	addi	a0,a0,1
 110:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 112:	00054783          	lbu	a5,0(a0)
 116:	fbe5                	bnez	a5,106 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 118:	0005c503          	lbu	a0,0(a1)
}
 11c:	40a7853b          	subw	a0,a5,a0
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strlen>:

uint
strlen(const char *s)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 130:	00054783          	lbu	a5,0(a0)
 134:	cf99                	beqz	a5,152 <strlen+0x2a>
 136:	0505                	addi	a0,a0,1
 138:	87aa                	mv	a5,a0
 13a:	86be                	mv	a3,a5
 13c:	0785                	addi	a5,a5,1
 13e:	fff7c703          	lbu	a4,-1(a5)
 142:	ff65                	bnez	a4,13a <strlen+0x12>
 144:	40a6853b          	subw	a0,a3,a0
 148:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 14a:	60a2                	ld	ra,8(sp)
 14c:	6402                	ld	s0,0(sp)
 14e:	0141                	addi	sp,sp,16
 150:	8082                	ret
  for(n = 0; s[n]; n++)
 152:	4501                	li	a0,0
 154:	bfdd                	j	14a <strlen+0x22>

0000000000000156 <memset>:

void*
memset(void *dst, int c, uint n)
{
 156:	1141                	addi	sp,sp,-16
 158:	e406                	sd	ra,8(sp)
 15a:	e022                	sd	s0,0(sp)
 15c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 15e:	ca19                	beqz	a2,174 <memset+0x1e>
 160:	87aa                	mv	a5,a0
 162:	1602                	slli	a2,a2,0x20
 164:	9201                	srli	a2,a2,0x20
 166:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 16e:	0785                	addi	a5,a5,1
 170:	fee79de3          	bne	a5,a4,16a <memset+0x14>
  }
  return dst;
}
 174:	60a2                	ld	ra,8(sp)
 176:	6402                	ld	s0,0(sp)
 178:	0141                	addi	sp,sp,16
 17a:	8082                	ret

000000000000017c <strchr>:

char*
strchr(const char *s, char c)
{
 17c:	1141                	addi	sp,sp,-16
 17e:	e406                	sd	ra,8(sp)
 180:	e022                	sd	s0,0(sp)
 182:	0800                	addi	s0,sp,16
  for(; *s; s++)
 184:	00054783          	lbu	a5,0(a0)
 188:	cf81                	beqz	a5,1a0 <strchr+0x24>
    if(*s == c)
 18a:	00f58763          	beq	a1,a5,198 <strchr+0x1c>
  for(; *s; s++)
 18e:	0505                	addi	a0,a0,1
 190:	00054783          	lbu	a5,0(a0)
 194:	fbfd                	bnez	a5,18a <strchr+0xe>
      return (char*)s;
  return 0;
 196:	4501                	li	a0,0
}
 198:	60a2                	ld	ra,8(sp)
 19a:	6402                	ld	s0,0(sp)
 19c:	0141                	addi	sp,sp,16
 19e:	8082                	ret
  return 0;
 1a0:	4501                	li	a0,0
 1a2:	bfdd                	j	198 <strchr+0x1c>

00000000000001a4 <gets>:

char*
gets(char *buf, int max)
{
 1a4:	7159                	addi	sp,sp,-112
 1a6:	f486                	sd	ra,104(sp)
 1a8:	f0a2                	sd	s0,96(sp)
 1aa:	eca6                	sd	s1,88(sp)
 1ac:	e8ca                	sd	s2,80(sp)
 1ae:	e4ce                	sd	s3,72(sp)
 1b0:	e0d2                	sd	s4,64(sp)
 1b2:	fc56                	sd	s5,56(sp)
 1b4:	f85a                	sd	s6,48(sp)
 1b6:	f45e                	sd	s7,40(sp)
 1b8:	f062                	sd	s8,32(sp)
 1ba:	ec66                	sd	s9,24(sp)
 1bc:	e86a                	sd	s10,16(sp)
 1be:	1880                	addi	s0,sp,112
 1c0:	8caa                	mv	s9,a0
 1c2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c4:	892a                	mv	s2,a0
 1c6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1c8:	f9f40b13          	addi	s6,s0,-97
 1cc:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ce:	4ba9                	li	s7,10
 1d0:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 1d2:	8d26                	mv	s10,s1
 1d4:	0014899b          	addiw	s3,s1,1
 1d8:	84ce                	mv	s1,s3
 1da:	0349d563          	bge	s3,s4,204 <gets+0x60>
    cc = read(0, &c, 1);
 1de:	8656                	mv	a2,s5
 1e0:	85da                	mv	a1,s6
 1e2:	4501                	li	a0,0
 1e4:	1c4000ef          	jal	3a8 <read>
    if(cc < 1)
 1e8:	00a05e63          	blez	a0,204 <gets+0x60>
    buf[i++] = c;
 1ec:	f9f44783          	lbu	a5,-97(s0)
 1f0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1f4:	01778763          	beq	a5,s7,202 <gets+0x5e>
 1f8:	0905                	addi	s2,s2,1
 1fa:	fd879ce3          	bne	a5,s8,1d2 <gets+0x2e>
    buf[i++] = c;
 1fe:	8d4e                	mv	s10,s3
 200:	a011                	j	204 <gets+0x60>
 202:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 204:	9d66                	add	s10,s10,s9
 206:	000d0023          	sb	zero,0(s10)
  return buf;
}
 20a:	8566                	mv	a0,s9
 20c:	70a6                	ld	ra,104(sp)
 20e:	7406                	ld	s0,96(sp)
 210:	64e6                	ld	s1,88(sp)
 212:	6946                	ld	s2,80(sp)
 214:	69a6                	ld	s3,72(sp)
 216:	6a06                	ld	s4,64(sp)
 218:	7ae2                	ld	s5,56(sp)
 21a:	7b42                	ld	s6,48(sp)
 21c:	7ba2                	ld	s7,40(sp)
 21e:	7c02                	ld	s8,32(sp)
 220:	6ce2                	ld	s9,24(sp)
 222:	6d42                	ld	s10,16(sp)
 224:	6165                	addi	sp,sp,112
 226:	8082                	ret

0000000000000228 <stat>:

int
stat(const char *n, struct stat *st)
{
 228:	1101                	addi	sp,sp,-32
 22a:	ec06                	sd	ra,24(sp)
 22c:	e822                	sd	s0,16(sp)
 22e:	e04a                	sd	s2,0(sp)
 230:	1000                	addi	s0,sp,32
 232:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 234:	4581                	li	a1,0
 236:	19a000ef          	jal	3d0 <open>
  if(fd < 0)
 23a:	02054263          	bltz	a0,25e <stat+0x36>
 23e:	e426                	sd	s1,8(sp)
 240:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 242:	85ca                	mv	a1,s2
 244:	1a4000ef          	jal	3e8 <fstat>
 248:	892a                	mv	s2,a0
  close(fd);
 24a:	8526                	mv	a0,s1
 24c:	16c000ef          	jal	3b8 <close>
  return r;
 250:	64a2                	ld	s1,8(sp)
}
 252:	854a                	mv	a0,s2
 254:	60e2                	ld	ra,24(sp)
 256:	6442                	ld	s0,16(sp)
 258:	6902                	ld	s2,0(sp)
 25a:	6105                	addi	sp,sp,32
 25c:	8082                	ret
    return -1;
 25e:	597d                	li	s2,-1
 260:	bfcd                	j	252 <stat+0x2a>

0000000000000262 <atoi>:

int
atoi(const char *s)
{
 262:	1141                	addi	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26a:	00054683          	lbu	a3,0(a0)
 26e:	fd06879b          	addiw	a5,a3,-48
 272:	0ff7f793          	zext.b	a5,a5
 276:	4625                	li	a2,9
 278:	02f66963          	bltu	a2,a5,2aa <atoi+0x48>
 27c:	872a                	mv	a4,a0
  n = 0;
 27e:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 280:	0705                	addi	a4,a4,1
 282:	0025179b          	slliw	a5,a0,0x2
 286:	9fa9                	addw	a5,a5,a0
 288:	0017979b          	slliw	a5,a5,0x1
 28c:	9fb5                	addw	a5,a5,a3
 28e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 292:	00074683          	lbu	a3,0(a4)
 296:	fd06879b          	addiw	a5,a3,-48
 29a:	0ff7f793          	zext.b	a5,a5
 29e:	fef671e3          	bgeu	a2,a5,280 <atoi+0x1e>
  return n;
}
 2a2:	60a2                	ld	ra,8(sp)
 2a4:	6402                	ld	s0,0(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret
  n = 0;
 2aa:	4501                	li	a0,0
 2ac:	bfdd                	j	2a2 <atoi+0x40>

00000000000002ae <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2b6:	02b57563          	bgeu	a0,a1,2e0 <memmove+0x32>
    while(n-- > 0)
 2ba:	00c05f63          	blez	a2,2d8 <memmove+0x2a>
 2be:	1602                	slli	a2,a2,0x20
 2c0:	9201                	srli	a2,a2,0x20
 2c2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2c6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2c8:	0585                	addi	a1,a1,1
 2ca:	0705                	addi	a4,a4,1
 2cc:	fff5c683          	lbu	a3,-1(a1)
 2d0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2d4:	fee79ae3          	bne	a5,a4,2c8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2d8:	60a2                	ld	ra,8(sp)
 2da:	6402                	ld	s0,0(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret
    dst += n;
 2e0:	00c50733          	add	a4,a0,a2
    src += n;
 2e4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2e6:	fec059e3          	blez	a2,2d8 <memmove+0x2a>
 2ea:	fff6079b          	addiw	a5,a2,-1
 2ee:	1782                	slli	a5,a5,0x20
 2f0:	9381                	srli	a5,a5,0x20
 2f2:	fff7c793          	not	a5,a5
 2f6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2f8:	15fd                	addi	a1,a1,-1
 2fa:	177d                	addi	a4,a4,-1
 2fc:	0005c683          	lbu	a3,0(a1)
 300:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 304:	fef71ae3          	bne	a4,a5,2f8 <memmove+0x4a>
 308:	bfc1                	j	2d8 <memmove+0x2a>

000000000000030a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 30a:	1141                	addi	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 312:	ca0d                	beqz	a2,344 <memcmp+0x3a>
 314:	fff6069b          	addiw	a3,a2,-1
 318:	1682                	slli	a3,a3,0x20
 31a:	9281                	srli	a3,a3,0x20
 31c:	0685                	addi	a3,a3,1
 31e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 320:	00054783          	lbu	a5,0(a0)
 324:	0005c703          	lbu	a4,0(a1)
 328:	00e79863          	bne	a5,a4,338 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 32c:	0505                	addi	a0,a0,1
    p2++;
 32e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 330:	fed518e3          	bne	a0,a3,320 <memcmp+0x16>
  }
  return 0;
 334:	4501                	li	a0,0
 336:	a019                	j	33c <memcmp+0x32>
      return *p1 - *p2;
 338:	40e7853b          	subw	a0,a5,a4
}
 33c:	60a2                	ld	ra,8(sp)
 33e:	6402                	ld	s0,0(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret
  return 0;
 344:	4501                	li	a0,0
 346:	bfdd                	j	33c <memcmp+0x32>

0000000000000348 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 350:	f5fff0ef          	jal	2ae <memmove>
}
 354:	60a2                	ld	ra,8(sp)
 356:	6402                	ld	s0,0(sp)
 358:	0141                	addi	sp,sp,16
 35a:	8082                	ret

000000000000035c <sbrk>:

char *
sbrk(int n) {
 35c:	1141                	addi	sp,sp,-16
 35e:	e406                	sd	ra,8(sp)
 360:	e022                	sd	s0,0(sp)
 362:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 364:	4585                	li	a1,1
 366:	0b2000ef          	jal	418 <sys_sbrk>
}
 36a:	60a2                	ld	ra,8(sp)
 36c:	6402                	ld	s0,0(sp)
 36e:	0141                	addi	sp,sp,16
 370:	8082                	ret

0000000000000372 <sbrklazy>:

char *
sbrklazy(int n) {
 372:	1141                	addi	sp,sp,-16
 374:	e406                	sd	ra,8(sp)
 376:	e022                	sd	s0,0(sp)
 378:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 37a:	4589                	li	a1,2
 37c:	09c000ef          	jal	418 <sys_sbrk>
}
 380:	60a2                	ld	ra,8(sp)
 382:	6402                	ld	s0,0(sp)
 384:	0141                	addi	sp,sp,16
 386:	8082                	ret

0000000000000388 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 388:	4885                	li	a7,1
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <exit>:
.global exit
exit:
 li a7, SYS_exit
 390:	4889                	li	a7,2
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <wait>:
.global wait
wait:
 li a7, SYS_wait
 398:	488d                	li	a7,3
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a0:	4891                	li	a7,4
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <read>:
.global read
read:
 li a7, SYS_read
 3a8:	4895                	li	a7,5
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <write>:
.global write
write:
 li a7, SYS_write
 3b0:	48c1                	li	a7,16
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <close>:
.global close
close:
 li a7, SYS_close
 3b8:	48d5                	li	a7,21
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c0:	4899                	li	a7,6
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c8:	489d                	li	a7,7
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <open>:
.global open
open:
 li a7, SYS_open
 3d0:	48bd                	li	a7,15
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d8:	48c5                	li	a7,17
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e0:	48c9                	li	a7,18
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e8:	48a1                	li	a7,8
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <link>:
.global link
link:
 li a7, SYS_link
 3f0:	48cd                	li	a7,19
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f8:	48d1                	li	a7,20
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 400:	48a5                	li	a7,9
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <dup>:
.global dup
dup:
 li a7, SYS_dup
 408:	48a9                	li	a7,10
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 410:	48ad                	li	a7,11
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 418:	48b1                	li	a7,12
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <pause>:
.global pause
pause:
 li a7, SYS_pause
 420:	48b5                	li	a7,13
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 428:	48b9                	li	a7,14
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 430:	1101                	addi	sp,sp,-32
 432:	ec06                	sd	ra,24(sp)
 434:	e822                	sd	s0,16(sp)
 436:	1000                	addi	s0,sp,32
 438:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 43c:	4605                	li	a2,1
 43e:	fef40593          	addi	a1,s0,-17
 442:	f6fff0ef          	jal	3b0 <write>
}
 446:	60e2                	ld	ra,24(sp)
 448:	6442                	ld	s0,16(sp)
 44a:	6105                	addi	sp,sp,32
 44c:	8082                	ret

000000000000044e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 44e:	715d                	addi	sp,sp,-80
 450:	e486                	sd	ra,72(sp)
 452:	e0a2                	sd	s0,64(sp)
 454:	fc26                	sd	s1,56(sp)
 456:	f84a                	sd	s2,48(sp)
 458:	f44e                	sd	s3,40(sp)
 45a:	0880                	addi	s0,sp,80
 45c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 45e:	c299                	beqz	a3,464 <printint+0x16>
 460:	0605cf63          	bltz	a1,4de <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 464:	2581                	sext.w	a1,a1
  neg = 0;
 466:	4e01                	li	t3,0
  }

  i = 0;
 468:	fb840313          	addi	t1,s0,-72
  neg = 0;
 46c:	869a                	mv	a3,t1
  i = 0;
 46e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 470:	00000817          	auipc	a6,0x0
 474:	59080813          	addi	a6,a6,1424 # a00 <digits>
 478:	88be                	mv	a7,a5
 47a:	0017851b          	addiw	a0,a5,1
 47e:	87aa                	mv	a5,a0
 480:	02c5f73b          	remuw	a4,a1,a2
 484:	1702                	slli	a4,a4,0x20
 486:	9301                	srli	a4,a4,0x20
 488:	9742                	add	a4,a4,a6
 48a:	00074703          	lbu	a4,0(a4)
 48e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 492:	872e                	mv	a4,a1
 494:	02c5d5bb          	divuw	a1,a1,a2
 498:	0685                	addi	a3,a3,1
 49a:	fcc77fe3          	bgeu	a4,a2,478 <printint+0x2a>
  if(neg)
 49e:	000e0c63          	beqz	t3,4b6 <printint+0x68>
    buf[i++] = '-';
 4a2:	fd050793          	addi	a5,a0,-48
 4a6:	00878533          	add	a0,a5,s0
 4aa:	02d00793          	li	a5,45
 4ae:	fef50423          	sb	a5,-24(a0)
 4b2:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4b6:	fff7899b          	addiw	s3,a5,-1
 4ba:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4be:	fff4c583          	lbu	a1,-1(s1)
 4c2:	854a                	mv	a0,s2
 4c4:	f6dff0ef          	jal	430 <putc>
  while(--i >= 0)
 4c8:	39fd                	addiw	s3,s3,-1
 4ca:	14fd                	addi	s1,s1,-1
 4cc:	fe09d9e3          	bgez	s3,4be <printint+0x70>
}
 4d0:	60a6                	ld	ra,72(sp)
 4d2:	6406                	ld	s0,64(sp)
 4d4:	74e2                	ld	s1,56(sp)
 4d6:	7942                	ld	s2,48(sp)
 4d8:	79a2                	ld	s3,40(sp)
 4da:	6161                	addi	sp,sp,80
 4dc:	8082                	ret
    x = -xx;
 4de:	40b005bb          	negw	a1,a1
    neg = 1;
 4e2:	4e05                	li	t3,1
    x = -xx;
 4e4:	b751                	j	468 <printint+0x1a>

00000000000004e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 4e6:	711d                	addi	sp,sp,-96
 4e8:	ec86                	sd	ra,88(sp)
 4ea:	e8a2                	sd	s0,80(sp)
 4ec:	e4a6                	sd	s1,72(sp)
 4ee:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 4f0:	0005c483          	lbu	s1,0(a1)
 4f4:	28048463          	beqz	s1,77c <vprintf+0x296>
 4f8:	e0ca                	sd	s2,64(sp)
 4fa:	fc4e                	sd	s3,56(sp)
 4fc:	f852                	sd	s4,48(sp)
 4fe:	f456                	sd	s5,40(sp)
 500:	f05a                	sd	s6,32(sp)
 502:	ec5e                	sd	s7,24(sp)
 504:	e862                	sd	s8,16(sp)
 506:	e466                	sd	s9,8(sp)
 508:	8b2a                	mv	s6,a0
 50a:	8a2e                	mv	s4,a1
 50c:	8bb2                	mv	s7,a2
  state = 0;
 50e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 510:	4901                	li	s2,0
 512:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 514:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 518:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 51c:	06c00c93          	li	s9,108
 520:	a00d                	j	542 <vprintf+0x5c>
        putc(fd, c0);
 522:	85a6                	mv	a1,s1
 524:	855a                	mv	a0,s6
 526:	f0bff0ef          	jal	430 <putc>
 52a:	a019                	j	530 <vprintf+0x4a>
    } else if(state == '%'){
 52c:	03598363          	beq	s3,s5,552 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 530:	0019079b          	addiw	a5,s2,1
 534:	893e                	mv	s2,a5
 536:	873e                	mv	a4,a5
 538:	97d2                	add	a5,a5,s4
 53a:	0007c483          	lbu	s1,0(a5)
 53e:	22048763          	beqz	s1,76c <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 542:	0004879b          	sext.w	a5,s1
    if(state == 0){
 546:	fe0993e3          	bnez	s3,52c <vprintf+0x46>
      if(c0 == '%'){
 54a:	fd579ce3          	bne	a5,s5,522 <vprintf+0x3c>
        state = '%';
 54e:	89be                	mv	s3,a5
 550:	b7c5                	j	530 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 552:	00ea06b3          	add	a3,s4,a4
 556:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 55a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 55c:	c681                	beqz	a3,564 <vprintf+0x7e>
 55e:	9752                	add	a4,a4,s4
 560:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 564:	05878263          	beq	a5,s8,5a8 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 568:	05978c63          	beq	a5,s9,5c0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 56c:	07500713          	li	a4,117
 570:	0ee78663          	beq	a5,a4,65c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 574:	07800713          	li	a4,120
 578:	12e78863          	beq	a5,a4,6a8 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 57c:	07000713          	li	a4,112
 580:	14e78d63          	beq	a5,a4,6da <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 584:	06300713          	li	a4,99
 588:	18e78c63          	beq	a5,a4,720 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 58c:	07300713          	li	a4,115
 590:	1ae78263          	beq	a5,a4,734 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 594:	02500713          	li	a4,37
 598:	04e79463          	bne	a5,a4,5e0 <vprintf+0xfa>
        putc(fd, '%');
 59c:	85ba                	mv	a1,a4
 59e:	855a                	mv	a0,s6
 5a0:	e91ff0ef          	jal	430 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5a4:	4981                	li	s3,0
 5a6:	b769                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5a8:	008b8493          	addi	s1,s7,8
 5ac:	4685                	li	a3,1
 5ae:	4629                	li	a2,10
 5b0:	000ba583          	lw	a1,0(s7)
 5b4:	855a                	mv	a0,s6
 5b6:	e99ff0ef          	jal	44e <printint>
 5ba:	8ba6                	mv	s7,s1
      state = 0;
 5bc:	4981                	li	s3,0
 5be:	bf8d                	j	530 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5c0:	06400793          	li	a5,100
 5c4:	02f68963          	beq	a3,a5,5f6 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5c8:	06c00793          	li	a5,108
 5cc:	04f68263          	beq	a3,a5,610 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 5d0:	07500793          	li	a5,117
 5d4:	0af68063          	beq	a3,a5,674 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 5d8:	07800793          	li	a5,120
 5dc:	0ef68263          	beq	a3,a5,6c0 <vprintf+0x1da>
        putc(fd, '%');
 5e0:	02500593          	li	a1,37
 5e4:	855a                	mv	a0,s6
 5e6:	e4bff0ef          	jal	430 <putc>
        putc(fd, c0);
 5ea:	85a6                	mv	a1,s1
 5ec:	855a                	mv	a0,s6
 5ee:	e43ff0ef          	jal	430 <putc>
      state = 0;
 5f2:	4981                	li	s3,0
 5f4:	bf35                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5f6:	008b8493          	addi	s1,s7,8
 5fa:	4685                	li	a3,1
 5fc:	4629                	li	a2,10
 5fe:	000bb583          	ld	a1,0(s7)
 602:	855a                	mv	a0,s6
 604:	e4bff0ef          	jal	44e <printint>
        i += 1;
 608:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 60a:	8ba6                	mv	s7,s1
      state = 0;
 60c:	4981                	li	s3,0
        i += 1;
 60e:	b70d                	j	530 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 610:	06400793          	li	a5,100
 614:	02f60763          	beq	a2,a5,642 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 618:	07500793          	li	a5,117
 61c:	06f60963          	beq	a2,a5,68e <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 620:	07800793          	li	a5,120
 624:	faf61ee3          	bne	a2,a5,5e0 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 628:	008b8493          	addi	s1,s7,8
 62c:	4681                	li	a3,0
 62e:	4641                	li	a2,16
 630:	000bb583          	ld	a1,0(s7)
 634:	855a                	mv	a0,s6
 636:	e19ff0ef          	jal	44e <printint>
        i += 2;
 63a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 63c:	8ba6                	mv	s7,s1
      state = 0;
 63e:	4981                	li	s3,0
        i += 2;
 640:	bdc5                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 642:	008b8493          	addi	s1,s7,8
 646:	4685                	li	a3,1
 648:	4629                	li	a2,10
 64a:	000bb583          	ld	a1,0(s7)
 64e:	855a                	mv	a0,s6
 650:	dffff0ef          	jal	44e <printint>
        i += 2;
 654:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 656:	8ba6                	mv	s7,s1
      state = 0;
 658:	4981                	li	s3,0
        i += 2;
 65a:	bdd9                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 65c:	008b8493          	addi	s1,s7,8
 660:	4681                	li	a3,0
 662:	4629                	li	a2,10
 664:	000be583          	lwu	a1,0(s7)
 668:	855a                	mv	a0,s6
 66a:	de5ff0ef          	jal	44e <printint>
 66e:	8ba6                	mv	s7,s1
      state = 0;
 670:	4981                	li	s3,0
 672:	bd7d                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 674:	008b8493          	addi	s1,s7,8
 678:	4681                	li	a3,0
 67a:	4629                	li	a2,10
 67c:	000bb583          	ld	a1,0(s7)
 680:	855a                	mv	a0,s6
 682:	dcdff0ef          	jal	44e <printint>
        i += 1;
 686:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 688:	8ba6                	mv	s7,s1
      state = 0;
 68a:	4981                	li	s3,0
        i += 1;
 68c:	b555                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 68e:	008b8493          	addi	s1,s7,8
 692:	4681                	li	a3,0
 694:	4629                	li	a2,10
 696:	000bb583          	ld	a1,0(s7)
 69a:	855a                	mv	a0,s6
 69c:	db3ff0ef          	jal	44e <printint>
        i += 2;
 6a0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a2:	8ba6                	mv	s7,s1
      state = 0;
 6a4:	4981                	li	s3,0
        i += 2;
 6a6:	b569                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6a8:	008b8493          	addi	s1,s7,8
 6ac:	4681                	li	a3,0
 6ae:	4641                	li	a2,16
 6b0:	000be583          	lwu	a1,0(s7)
 6b4:	855a                	mv	a0,s6
 6b6:	d99ff0ef          	jal	44e <printint>
 6ba:	8ba6                	mv	s7,s1
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	bd8d                	j	530 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c0:	008b8493          	addi	s1,s7,8
 6c4:	4681                	li	a3,0
 6c6:	4641                	li	a2,16
 6c8:	000bb583          	ld	a1,0(s7)
 6cc:	855a                	mv	a0,s6
 6ce:	d81ff0ef          	jal	44e <printint>
        i += 1;
 6d2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d4:	8ba6                	mv	s7,s1
      state = 0;
 6d6:	4981                	li	s3,0
        i += 1;
 6d8:	bda1                	j	530 <vprintf+0x4a>
 6da:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 6dc:	008b8d13          	addi	s10,s7,8
 6e0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 6e4:	03000593          	li	a1,48
 6e8:	855a                	mv	a0,s6
 6ea:	d47ff0ef          	jal	430 <putc>
  putc(fd, 'x');
 6ee:	07800593          	li	a1,120
 6f2:	855a                	mv	a0,s6
 6f4:	d3dff0ef          	jal	430 <putc>
 6f8:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6fa:	00000b97          	auipc	s7,0x0
 6fe:	306b8b93          	addi	s7,s7,774 # a00 <digits>
 702:	03c9d793          	srli	a5,s3,0x3c
 706:	97de                	add	a5,a5,s7
 708:	0007c583          	lbu	a1,0(a5)
 70c:	855a                	mv	a0,s6
 70e:	d23ff0ef          	jal	430 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 712:	0992                	slli	s3,s3,0x4
 714:	34fd                	addiw	s1,s1,-1
 716:	f4f5                	bnez	s1,702 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 718:	8bea                	mv	s7,s10
      state = 0;
 71a:	4981                	li	s3,0
 71c:	6d02                	ld	s10,0(sp)
 71e:	bd09                	j	530 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 720:	008b8493          	addi	s1,s7,8
 724:	000bc583          	lbu	a1,0(s7)
 728:	855a                	mv	a0,s6
 72a:	d07ff0ef          	jal	430 <putc>
 72e:	8ba6                	mv	s7,s1
      state = 0;
 730:	4981                	li	s3,0
 732:	bbfd                	j	530 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 734:	008b8993          	addi	s3,s7,8
 738:	000bb483          	ld	s1,0(s7)
 73c:	cc91                	beqz	s1,758 <vprintf+0x272>
        for(; *s; s++)
 73e:	0004c583          	lbu	a1,0(s1)
 742:	c195                	beqz	a1,766 <vprintf+0x280>
          putc(fd, *s);
 744:	855a                	mv	a0,s6
 746:	cebff0ef          	jal	430 <putc>
        for(; *s; s++)
 74a:	0485                	addi	s1,s1,1
 74c:	0004c583          	lbu	a1,0(s1)
 750:	f9f5                	bnez	a1,744 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 752:	8bce                	mv	s7,s3
      state = 0;
 754:	4981                	li	s3,0
 756:	bbe9                	j	530 <vprintf+0x4a>
          s = "(null)";
 758:	00000497          	auipc	s1,0x0
 75c:	2a048493          	addi	s1,s1,672 # 9f8 <malloc+0x190>
        for(; *s; s++)
 760:	02800593          	li	a1,40
 764:	b7c5                	j	744 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 766:	8bce                	mv	s7,s3
      state = 0;
 768:	4981                	li	s3,0
 76a:	b3d9                	j	530 <vprintf+0x4a>
 76c:	6906                	ld	s2,64(sp)
 76e:	79e2                	ld	s3,56(sp)
 770:	7a42                	ld	s4,48(sp)
 772:	7aa2                	ld	s5,40(sp)
 774:	7b02                	ld	s6,32(sp)
 776:	6be2                	ld	s7,24(sp)
 778:	6c42                	ld	s8,16(sp)
 77a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 77c:	60e6                	ld	ra,88(sp)
 77e:	6446                	ld	s0,80(sp)
 780:	64a6                	ld	s1,72(sp)
 782:	6125                	addi	sp,sp,96
 784:	8082                	ret

0000000000000786 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 786:	715d                	addi	sp,sp,-80
 788:	ec06                	sd	ra,24(sp)
 78a:	e822                	sd	s0,16(sp)
 78c:	1000                	addi	s0,sp,32
 78e:	e010                	sd	a2,0(s0)
 790:	e414                	sd	a3,8(s0)
 792:	e818                	sd	a4,16(s0)
 794:	ec1c                	sd	a5,24(s0)
 796:	03043023          	sd	a6,32(s0)
 79a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 79e:	8622                	mv	a2,s0
 7a0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7a4:	d43ff0ef          	jal	4e6 <vprintf>
}
 7a8:	60e2                	ld	ra,24(sp)
 7aa:	6442                	ld	s0,16(sp)
 7ac:	6161                	addi	sp,sp,80
 7ae:	8082                	ret

00000000000007b0 <printf>:

void
printf(const char *fmt, ...)
{
 7b0:	711d                	addi	sp,sp,-96
 7b2:	ec06                	sd	ra,24(sp)
 7b4:	e822                	sd	s0,16(sp)
 7b6:	1000                	addi	s0,sp,32
 7b8:	e40c                	sd	a1,8(s0)
 7ba:	e810                	sd	a2,16(s0)
 7bc:	ec14                	sd	a3,24(s0)
 7be:	f018                	sd	a4,32(s0)
 7c0:	f41c                	sd	a5,40(s0)
 7c2:	03043823          	sd	a6,48(s0)
 7c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7ca:	00840613          	addi	a2,s0,8
 7ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 7d2:	85aa                	mv	a1,a0
 7d4:	4505                	li	a0,1
 7d6:	d11ff0ef          	jal	4e6 <vprintf>
}
 7da:	60e2                	ld	ra,24(sp)
 7dc:	6442                	ld	s0,16(sp)
 7de:	6125                	addi	sp,sp,96
 7e0:	8082                	ret

00000000000007e2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e2:	1141                	addi	sp,sp,-16
 7e4:	e406                	sd	ra,8(sp)
 7e6:	e022                	sd	s0,0(sp)
 7e8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7ea:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ee:	00001797          	auipc	a5,0x1
 7f2:	8127b783          	ld	a5,-2030(a5) # 1000 <freep>
 7f6:	a02d                	j	820 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7f8:	4618                	lw	a4,8(a2)
 7fa:	9f2d                	addw	a4,a4,a1
 7fc:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 800:	6398                	ld	a4,0(a5)
 802:	6310                	ld	a2,0(a4)
 804:	a83d                	j	842 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 806:	ff852703          	lw	a4,-8(a0)
 80a:	9f31                	addw	a4,a4,a2
 80c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 80e:	ff053683          	ld	a3,-16(a0)
 812:	a091                	j	856 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	6398                	ld	a4,0(a5)
 816:	00e7e463          	bltu	a5,a4,81e <free+0x3c>
 81a:	00e6ea63          	bltu	a3,a4,82e <free+0x4c>
{
 81e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 820:	fed7fae3          	bgeu	a5,a3,814 <free+0x32>
 824:	6398                	ld	a4,0(a5)
 826:	00e6e463          	bltu	a3,a4,82e <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 82a:	fee7eae3          	bltu	a5,a4,81e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 82e:	ff852583          	lw	a1,-8(a0)
 832:	6390                	ld	a2,0(a5)
 834:	02059813          	slli	a6,a1,0x20
 838:	01c85713          	srli	a4,a6,0x1c
 83c:	9736                	add	a4,a4,a3
 83e:	fae60de3          	beq	a2,a4,7f8 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 842:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 846:	4790                	lw	a2,8(a5)
 848:	02061593          	slli	a1,a2,0x20
 84c:	01c5d713          	srli	a4,a1,0x1c
 850:	973e                	add	a4,a4,a5
 852:	fae68ae3          	beq	a3,a4,806 <free+0x24>
    p->s.ptr = bp->s.ptr;
 856:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 858:	00000717          	auipc	a4,0x0
 85c:	7af73423          	sd	a5,1960(a4) # 1000 <freep>
}
 860:	60a2                	ld	ra,8(sp)
 862:	6402                	ld	s0,0(sp)
 864:	0141                	addi	sp,sp,16
 866:	8082                	ret

0000000000000868 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 868:	7139                	addi	sp,sp,-64
 86a:	fc06                	sd	ra,56(sp)
 86c:	f822                	sd	s0,48(sp)
 86e:	f04a                	sd	s2,32(sp)
 870:	ec4e                	sd	s3,24(sp)
 872:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 874:	02051993          	slli	s3,a0,0x20
 878:	0209d993          	srli	s3,s3,0x20
 87c:	09bd                	addi	s3,s3,15
 87e:	0049d993          	srli	s3,s3,0x4
 882:	2985                	addiw	s3,s3,1
 884:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 886:	00000517          	auipc	a0,0x0
 88a:	77a53503          	ld	a0,1914(a0) # 1000 <freep>
 88e:	c905                	beqz	a0,8be <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 890:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 892:	4798                	lw	a4,8(a5)
 894:	09377663          	bgeu	a4,s3,920 <malloc+0xb8>
 898:	f426                	sd	s1,40(sp)
 89a:	e852                	sd	s4,16(sp)
 89c:	e456                	sd	s5,8(sp)
 89e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8a0:	8a4e                	mv	s4,s3
 8a2:	6705                	lui	a4,0x1
 8a4:	00e9f363          	bgeu	s3,a4,8aa <malloc+0x42>
 8a8:	6a05                	lui	s4,0x1
 8aa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ae:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8b2:	00000497          	auipc	s1,0x0
 8b6:	74e48493          	addi	s1,s1,1870 # 1000 <freep>
  if(p == SBRK_ERROR)
 8ba:	5afd                	li	s5,-1
 8bc:	a83d                	j	8fa <malloc+0x92>
 8be:	f426                	sd	s1,40(sp)
 8c0:	e852                	sd	s4,16(sp)
 8c2:	e456                	sd	s5,8(sp)
 8c4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8c6:	00001797          	auipc	a5,0x1
 8ca:	94278793          	addi	a5,a5,-1726 # 1208 <base>
 8ce:	00000717          	auipc	a4,0x0
 8d2:	72f73923          	sd	a5,1842(a4) # 1000 <freep>
 8d6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 8d8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 8dc:	b7d1                	j	8a0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 8de:	6398                	ld	a4,0(a5)
 8e0:	e118                	sd	a4,0(a0)
 8e2:	a899                	j	938 <malloc+0xd0>
  hp->s.size = nu;
 8e4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 8e8:	0541                	addi	a0,a0,16
 8ea:	ef9ff0ef          	jal	7e2 <free>
  return freep;
 8ee:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 8f0:	c125                	beqz	a0,950 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8f4:	4798                	lw	a4,8(a5)
 8f6:	03277163          	bgeu	a4,s2,918 <malloc+0xb0>
    if(p == freep)
 8fa:	6098                	ld	a4,0(s1)
 8fc:	853e                	mv	a0,a5
 8fe:	fef71ae3          	bne	a4,a5,8f2 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 902:	8552                	mv	a0,s4
 904:	a59ff0ef          	jal	35c <sbrk>
  if(p == SBRK_ERROR)
 908:	fd551ee3          	bne	a0,s5,8e4 <malloc+0x7c>
        return 0;
 90c:	4501                	li	a0,0
 90e:	74a2                	ld	s1,40(sp)
 910:	6a42                	ld	s4,16(sp)
 912:	6aa2                	ld	s5,8(sp)
 914:	6b02                	ld	s6,0(sp)
 916:	a03d                	j	944 <malloc+0xdc>
 918:	74a2                	ld	s1,40(sp)
 91a:	6a42                	ld	s4,16(sp)
 91c:	6aa2                	ld	s5,8(sp)
 91e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 920:	fae90fe3          	beq	s2,a4,8de <malloc+0x76>
        p->s.size -= nunits;
 924:	4137073b          	subw	a4,a4,s3
 928:	c798                	sw	a4,8(a5)
        p += p->s.size;
 92a:	02071693          	slli	a3,a4,0x20
 92e:	01c6d713          	srli	a4,a3,0x1c
 932:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 934:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 938:	00000717          	auipc	a4,0x0
 93c:	6ca73423          	sd	a0,1736(a4) # 1000 <freep>
      return (void*)(p + 1);
 940:	01078513          	addi	a0,a5,16
  }
}
 944:	70e2                	ld	ra,56(sp)
 946:	7442                	ld	s0,48(sp)
 948:	7902                	ld	s2,32(sp)
 94a:	69e2                	ld	s3,24(sp)
 94c:	6121                	addi	sp,sp,64
 94e:	8082                	ret
 950:	74a2                	ld	s1,40(sp)
 952:	6a42                	ld	s4,16(sp)
 954:	6aa2                	ld	s5,8(sp)
 956:	6b02                	ld	s6,0(sp)
 958:	b7f5                	j	944 <malloc+0xdc>
