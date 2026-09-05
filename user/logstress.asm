
user/_logstress:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
main(int argc, char **argv)
{
  int fd, n;
  enum { N = 250, SZ=2000 };
  
  for (int i = 1; i < argc; i++){
   0:	4785                	li	a5,1
   2:	0ea7de63          	bge	a5,a0,fe <main+0xfe>
{
   6:	7139                	addi	sp,sp,-64
   8:	fc06                	sd	ra,56(sp)
   a:	f822                	sd	s0,48(sp)
   c:	f426                	sd	s1,40(sp)
   e:	f04a                	sd	s2,32(sp)
  10:	ec4e                	sd	s3,24(sp)
  12:	e852                	sd	s4,16(sp)
  14:	0080                	addi	s0,sp,64
  16:	892a                	mv	s2,a0
  18:	8a2e                	mv	s4,a1
  for (int i = 1; i < argc; i++){
  1a:	84be                	mv	s1,a5
  1c:	a011                	j	20 <main+0x20>
  1e:	84be                	mv	s1,a5
    int pid1 = fork();
  20:	3a4000ef          	jal	3c4 <fork>
    if(pid1 < 0){
  24:	00054b63          	bltz	a0,3a <main+0x3a>
      printf("%s: fork failed\n", argv[0]);
      exit(1);
    }
    if(pid1 == 0) {
  28:	c505                	beqz	a0,50 <main+0x50>
  for (int i = 1; i < argc; i++){
  2a:	0014879b          	addiw	a5,s1,1
  2e:	fef918e3          	bne	s2,a5,1e <main+0x1e>
      }
      exit(0);
    }
  }
  int xstatus;
  for(int i = 1; i < argc; i++){
  32:	4905                	li	s2,1
    wait(&xstatus);
  34:	fcc40993          	addi	s3,s0,-52
  38:	a871                	j	d4 <main+0xd4>
      printf("%s: fork failed\n", argv[0]);
  3a:	000a3583          	ld	a1,0(s4)
  3e:	00001517          	auipc	a0,0x1
  42:	96250513          	addi	a0,a0,-1694 # 9a0 <malloc+0xfc>
  46:	7a6000ef          	jal	7ec <printf>
      exit(1);
  4a:	4505                	li	a0,1
  4c:	380000ef          	jal	3cc <exit>
      fd = open(argv[i], O_CREATE | O_RDWR);
  50:	00349913          	slli	s2,s1,0x3
  54:	9952                	add	s2,s2,s4
  56:	20200593          	li	a1,514
  5a:	00093503          	ld	a0,0(s2)
  5e:	3ae000ef          	jal	40c <open>
  62:	89aa                	mv	s3,a0
      if(fd < 0){
  64:	04054063          	bltz	a0,a4 <main+0xa4>
      memset(buf, '0'+i, SZ);
  68:	7d000613          	li	a2,2000
  6c:	0304859b          	addiw	a1,s1,48
  70:	00001517          	auipc	a0,0x1
  74:	fa050513          	addi	a0,a0,-96 # 1010 <buf>
  78:	11a000ef          	jal	192 <memset>
  7c:	0fa00493          	li	s1,250
        if((n = write(fd, buf, SZ)) != SZ){
  80:	00001a17          	auipc	s4,0x1
  84:	f90a0a13          	addi	s4,s4,-112 # 1010 <buf>
  88:	7d000913          	li	s2,2000
  8c:	864a                	mv	a2,s2
  8e:	85d2                	mv	a1,s4
  90:	854e                	mv	a0,s3
  92:	35a000ef          	jal	3ec <write>
  96:	03251463          	bne	a0,s2,be <main+0xbe>
      for(i = 0; i < N; i++){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f8e5                	bnez	s1,8c <main+0x8c>
      exit(0);
  9e:	4501                	li	a0,0
  a0:	32c000ef          	jal	3cc <exit>
        printf("%s: create %s failed\n", argv[0], argv[i]);
  a4:	00093603          	ld	a2,0(s2)
  a8:	000a3583          	ld	a1,0(s4)
  ac:	00001517          	auipc	a0,0x1
  b0:	90c50513          	addi	a0,a0,-1780 # 9b8 <malloc+0x114>
  b4:	738000ef          	jal	7ec <printf>
        exit(1);
  b8:	4505                	li	a0,1
  ba:	312000ef          	jal	3cc <exit>
          printf("write failed %d\n", n);
  be:	85aa                	mv	a1,a0
  c0:	00001517          	auipc	a0,0x1
  c4:	91050513          	addi	a0,a0,-1776 # 9d0 <malloc+0x12c>
  c8:	724000ef          	jal	7ec <printf>
          exit(1);
  cc:	4505                	li	a0,1
  ce:	2fe000ef          	jal	3cc <exit>
  d2:	893e                	mv	s2,a5
    wait(&xstatus);
  d4:	854e                	mv	a0,s3
  d6:	2fe000ef          	jal	3d4 <wait>
    if(xstatus != 0)
  da:	fcc42503          	lw	a0,-52(s0)
  de:	ed11                	bnez	a0,fa <main+0xfa>
  for(int i = 1; i < argc; i++){
  e0:	0019079b          	addiw	a5,s2,1
  e4:	ff2497e3          	bne	s1,s2,d2 <main+0xd2>
      exit(xstatus);
  }
  return 0;
}
  e8:	4501                	li	a0,0
  ea:	70e2                	ld	ra,56(sp)
  ec:	7442                	ld	s0,48(sp)
  ee:	74a2                	ld	s1,40(sp)
  f0:	7902                	ld	s2,32(sp)
  f2:	69e2                	ld	s3,24(sp)
  f4:	6a42                	ld	s4,16(sp)
  f6:	6121                	addi	sp,sp,64
  f8:	8082                	ret
      exit(xstatus);
  fa:	2d2000ef          	jal	3cc <exit>
}
  fe:	4501                	li	a0,0
 100:	8082                	ret

0000000000000102 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 102:	1141                	addi	sp,sp,-16
 104:	e406                	sd	ra,8(sp)
 106:	e022                	sd	s0,0(sp)
 108:	0800                	addi	s0,sp,16
  extern int main();
  main();
 10a:	ef7ff0ef          	jal	0 <main>
  exit(0);
 10e:	4501                	li	a0,0
 110:	2bc000ef          	jal	3cc <exit>

0000000000000114 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e406                	sd	ra,8(sp)
 118:	e022                	sd	s0,0(sp)
 11a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11c:	87aa                	mv	a5,a0
 11e:	0585                	addi	a1,a1,1
 120:	0785                	addi	a5,a5,1
 122:	fff5c703          	lbu	a4,-1(a1)
 126:	fee78fa3          	sb	a4,-1(a5)
 12a:	fb75                	bnez	a4,11e <strcpy+0xa>
    ;
  return os;
}
 12c:	60a2                	ld	ra,8(sp)
 12e:	6402                	ld	s0,0(sp)
 130:	0141                	addi	sp,sp,16
 132:	8082                	ret

0000000000000134 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 134:	1141                	addi	sp,sp,-16
 136:	e406                	sd	ra,8(sp)
 138:	e022                	sd	s0,0(sp)
 13a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 13c:	00054783          	lbu	a5,0(a0)
 140:	cb91                	beqz	a5,154 <strcmp+0x20>
 142:	0005c703          	lbu	a4,0(a1)
 146:	00f71763          	bne	a4,a5,154 <strcmp+0x20>
    p++, q++;
 14a:	0505                	addi	a0,a0,1
 14c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 14e:	00054783          	lbu	a5,0(a0)
 152:	fbe5                	bnez	a5,142 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 154:	0005c503          	lbu	a0,0(a1)
}
 158:	40a7853b          	subw	a0,a5,a0
 15c:	60a2                	ld	ra,8(sp)
 15e:	6402                	ld	s0,0(sp)
 160:	0141                	addi	sp,sp,16
 162:	8082                	ret

0000000000000164 <strlen>:

uint
strlen(const char *s)
{
 164:	1141                	addi	sp,sp,-16
 166:	e406                	sd	ra,8(sp)
 168:	e022                	sd	s0,0(sp)
 16a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cf99                	beqz	a5,18e <strlen+0x2a>
 172:	0505                	addi	a0,a0,1
 174:	87aa                	mv	a5,a0
 176:	86be                	mv	a3,a5
 178:	0785                	addi	a5,a5,1
 17a:	fff7c703          	lbu	a4,-1(a5)
 17e:	ff65                	bnez	a4,176 <strlen+0x12>
 180:	40a6853b          	subw	a0,a3,a0
 184:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 186:	60a2                	ld	ra,8(sp)
 188:	6402                	ld	s0,0(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret
  for(n = 0; s[n]; n++)
 18e:	4501                	li	a0,0
 190:	bfdd                	j	186 <strlen+0x22>

0000000000000192 <memset>:

void*
memset(void *dst, int c, uint n)
{
 192:	1141                	addi	sp,sp,-16
 194:	e406                	sd	ra,8(sp)
 196:	e022                	sd	s0,0(sp)
 198:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 19a:	ca19                	beqz	a2,1b0 <memset+0x1e>
 19c:	87aa                	mv	a5,a0
 19e:	1602                	slli	a2,a2,0x20
 1a0:	9201                	srli	a2,a2,0x20
 1a2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 1a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1aa:	0785                	addi	a5,a5,1
 1ac:	fee79de3          	bne	a5,a4,1a6 <memset+0x14>
  }
  return dst;
}
 1b0:	60a2                	ld	ra,8(sp)
 1b2:	6402                	ld	s0,0(sp)
 1b4:	0141                	addi	sp,sp,16
 1b6:	8082                	ret

00000000000001b8 <strchr>:

char*
strchr(const char *s, char c)
{
 1b8:	1141                	addi	sp,sp,-16
 1ba:	e406                	sd	ra,8(sp)
 1bc:	e022                	sd	s0,0(sp)
 1be:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	cf81                	beqz	a5,1dc <strchr+0x24>
    if(*s == c)
 1c6:	00f58763          	beq	a1,a5,1d4 <strchr+0x1c>
  for(; *s; s++)
 1ca:	0505                	addi	a0,a0,1
 1cc:	00054783          	lbu	a5,0(a0)
 1d0:	fbfd                	bnez	a5,1c6 <strchr+0xe>
      return (char*)s;
  return 0;
 1d2:	4501                	li	a0,0
}
 1d4:	60a2                	ld	ra,8(sp)
 1d6:	6402                	ld	s0,0(sp)
 1d8:	0141                	addi	sp,sp,16
 1da:	8082                	ret
  return 0;
 1dc:	4501                	li	a0,0
 1de:	bfdd                	j	1d4 <strchr+0x1c>

00000000000001e0 <gets>:

char*
gets(char *buf, int max)
{
 1e0:	7159                	addi	sp,sp,-112
 1e2:	f486                	sd	ra,104(sp)
 1e4:	f0a2                	sd	s0,96(sp)
 1e6:	eca6                	sd	s1,88(sp)
 1e8:	e8ca                	sd	s2,80(sp)
 1ea:	e4ce                	sd	s3,72(sp)
 1ec:	e0d2                	sd	s4,64(sp)
 1ee:	fc56                	sd	s5,56(sp)
 1f0:	f85a                	sd	s6,48(sp)
 1f2:	f45e                	sd	s7,40(sp)
 1f4:	f062                	sd	s8,32(sp)
 1f6:	ec66                	sd	s9,24(sp)
 1f8:	e86a                	sd	s10,16(sp)
 1fa:	1880                	addi	s0,sp,112
 1fc:	8caa                	mv	s9,a0
 1fe:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 200:	892a                	mv	s2,a0
 202:	4481                	li	s1,0
    cc = read(0, &c, 1);
 204:	f9f40b13          	addi	s6,s0,-97
 208:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 20a:	4ba9                	li	s7,10
 20c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 20e:	8d26                	mv	s10,s1
 210:	0014899b          	addiw	s3,s1,1
 214:	84ce                	mv	s1,s3
 216:	0349d563          	bge	s3,s4,240 <gets+0x60>
    cc = read(0, &c, 1);
 21a:	8656                	mv	a2,s5
 21c:	85da                	mv	a1,s6
 21e:	4501                	li	a0,0
 220:	1c4000ef          	jal	3e4 <read>
    if(cc < 1)
 224:	00a05e63          	blez	a0,240 <gets+0x60>
    buf[i++] = c;
 228:	f9f44783          	lbu	a5,-97(s0)
 22c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 230:	01778763          	beq	a5,s7,23e <gets+0x5e>
 234:	0905                	addi	s2,s2,1
 236:	fd879ce3          	bne	a5,s8,20e <gets+0x2e>
    buf[i++] = c;
 23a:	8d4e                	mv	s10,s3
 23c:	a011                	j	240 <gets+0x60>
 23e:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 240:	9d66                	add	s10,s10,s9
 242:	000d0023          	sb	zero,0(s10)
  return buf;
}
 246:	8566                	mv	a0,s9
 248:	70a6                	ld	ra,104(sp)
 24a:	7406                	ld	s0,96(sp)
 24c:	64e6                	ld	s1,88(sp)
 24e:	6946                	ld	s2,80(sp)
 250:	69a6                	ld	s3,72(sp)
 252:	6a06                	ld	s4,64(sp)
 254:	7ae2                	ld	s5,56(sp)
 256:	7b42                	ld	s6,48(sp)
 258:	7ba2                	ld	s7,40(sp)
 25a:	7c02                	ld	s8,32(sp)
 25c:	6ce2                	ld	s9,24(sp)
 25e:	6d42                	ld	s10,16(sp)
 260:	6165                	addi	sp,sp,112
 262:	8082                	ret

0000000000000264 <stat>:

int
stat(const char *n, struct stat *st)
{
 264:	1101                	addi	sp,sp,-32
 266:	ec06                	sd	ra,24(sp)
 268:	e822                	sd	s0,16(sp)
 26a:	e04a                	sd	s2,0(sp)
 26c:	1000                	addi	s0,sp,32
 26e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 270:	4581                	li	a1,0
 272:	19a000ef          	jal	40c <open>
  if(fd < 0)
 276:	02054263          	bltz	a0,29a <stat+0x36>
 27a:	e426                	sd	s1,8(sp)
 27c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 27e:	85ca                	mv	a1,s2
 280:	1a4000ef          	jal	424 <fstat>
 284:	892a                	mv	s2,a0
  close(fd);
 286:	8526                	mv	a0,s1
 288:	16c000ef          	jal	3f4 <close>
  return r;
 28c:	64a2                	ld	s1,8(sp)
}
 28e:	854a                	mv	a0,s2
 290:	60e2                	ld	ra,24(sp)
 292:	6442                	ld	s0,16(sp)
 294:	6902                	ld	s2,0(sp)
 296:	6105                	addi	sp,sp,32
 298:	8082                	ret
    return -1;
 29a:	597d                	li	s2,-1
 29c:	bfcd                	j	28e <stat+0x2a>

000000000000029e <atoi>:

int
atoi(const char *s)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e406                	sd	ra,8(sp)
 2a2:	e022                	sd	s0,0(sp)
 2a4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2a6:	00054683          	lbu	a3,0(a0)
 2aa:	fd06879b          	addiw	a5,a3,-48
 2ae:	0ff7f793          	zext.b	a5,a5
 2b2:	4625                	li	a2,9
 2b4:	02f66963          	bltu	a2,a5,2e6 <atoi+0x48>
 2b8:	872a                	mv	a4,a0
  n = 0;
 2ba:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2bc:	0705                	addi	a4,a4,1
 2be:	0025179b          	slliw	a5,a0,0x2
 2c2:	9fa9                	addw	a5,a5,a0
 2c4:	0017979b          	slliw	a5,a5,0x1
 2c8:	9fb5                	addw	a5,a5,a3
 2ca:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2ce:	00074683          	lbu	a3,0(a4)
 2d2:	fd06879b          	addiw	a5,a3,-48
 2d6:	0ff7f793          	zext.b	a5,a5
 2da:	fef671e3          	bgeu	a2,a5,2bc <atoi+0x1e>
  return n;
}
 2de:	60a2                	ld	ra,8(sp)
 2e0:	6402                	ld	s0,0(sp)
 2e2:	0141                	addi	sp,sp,16
 2e4:	8082                	ret
  n = 0;
 2e6:	4501                	li	a0,0
 2e8:	bfdd                	j	2de <atoi+0x40>

00000000000002ea <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2f2:	02b57563          	bgeu	a0,a1,31c <memmove+0x32>
    while(n-- > 0)
 2f6:	00c05f63          	blez	a2,314 <memmove+0x2a>
 2fa:	1602                	slli	a2,a2,0x20
 2fc:	9201                	srli	a2,a2,0x20
 2fe:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 302:	872a                	mv	a4,a0
      *dst++ = *src++;
 304:	0585                	addi	a1,a1,1
 306:	0705                	addi	a4,a4,1
 308:	fff5c683          	lbu	a3,-1(a1)
 30c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 310:	fee79ae3          	bne	a5,a4,304 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
    dst += n;
 31c:	00c50733          	add	a4,a0,a2
    src += n;
 320:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 322:	fec059e3          	blez	a2,314 <memmove+0x2a>
 326:	fff6079b          	addiw	a5,a2,-1
 32a:	1782                	slli	a5,a5,0x20
 32c:	9381                	srli	a5,a5,0x20
 32e:	fff7c793          	not	a5,a5
 332:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 334:	15fd                	addi	a1,a1,-1
 336:	177d                	addi	a4,a4,-1
 338:	0005c683          	lbu	a3,0(a1)
 33c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 340:	fef71ae3          	bne	a4,a5,334 <memmove+0x4a>
 344:	bfc1                	j	314 <memmove+0x2a>

0000000000000346 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 346:	1141                	addi	sp,sp,-16
 348:	e406                	sd	ra,8(sp)
 34a:	e022                	sd	s0,0(sp)
 34c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 34e:	ca0d                	beqz	a2,380 <memcmp+0x3a>
 350:	fff6069b          	addiw	a3,a2,-1
 354:	1682                	slli	a3,a3,0x20
 356:	9281                	srli	a3,a3,0x20
 358:	0685                	addi	a3,a3,1
 35a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 35c:	00054783          	lbu	a5,0(a0)
 360:	0005c703          	lbu	a4,0(a1)
 364:	00e79863          	bne	a5,a4,374 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 368:	0505                	addi	a0,a0,1
    p2++;
 36a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 36c:	fed518e3          	bne	a0,a3,35c <memcmp+0x16>
  }
  return 0;
 370:	4501                	li	a0,0
 372:	a019                	j	378 <memcmp+0x32>
      return *p1 - *p2;
 374:	40e7853b          	subw	a0,a5,a4
}
 378:	60a2                	ld	ra,8(sp)
 37a:	6402                	ld	s0,0(sp)
 37c:	0141                	addi	sp,sp,16
 37e:	8082                	ret
  return 0;
 380:	4501                	li	a0,0
 382:	bfdd                	j	378 <memcmp+0x32>

0000000000000384 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 384:	1141                	addi	sp,sp,-16
 386:	e406                	sd	ra,8(sp)
 388:	e022                	sd	s0,0(sp)
 38a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 38c:	f5fff0ef          	jal	2ea <memmove>
}
 390:	60a2                	ld	ra,8(sp)
 392:	6402                	ld	s0,0(sp)
 394:	0141                	addi	sp,sp,16
 396:	8082                	ret

0000000000000398 <sbrk>:

char *
sbrk(int n) {
 398:	1141                	addi	sp,sp,-16
 39a:	e406                	sd	ra,8(sp)
 39c:	e022                	sd	s0,0(sp)
 39e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3a0:	4585                	li	a1,1
 3a2:	0b2000ef          	jal	454 <sys_sbrk>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <sbrklazy>:

char *
sbrklazy(int n) {
 3ae:	1141                	addi	sp,sp,-16
 3b0:	e406                	sd	ra,8(sp)
 3b2:	e022                	sd	s0,0(sp)
 3b4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3b6:	4589                	li	a1,2
 3b8:	09c000ef          	jal	454 <sys_sbrk>
}
 3bc:	60a2                	ld	ra,8(sp)
 3be:	6402                	ld	s0,0(sp)
 3c0:	0141                	addi	sp,sp,16
 3c2:	8082                	ret

00000000000003c4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3c4:	4885                	li	a7,1
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3cc:	4889                	li	a7,2
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3d4:	488d                	li	a7,3
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3dc:	4891                	li	a7,4
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <read>:
.global read
read:
 li a7, SYS_read
 3e4:	4895                	li	a7,5
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <write>:
.global write
write:
 li a7, SYS_write
 3ec:	48c1                	li	a7,16
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <close>:
.global close
close:
 li a7, SYS_close
 3f4:	48d5                	li	a7,21
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <kill>:
.global kill
kill:
 li a7, SYS_kill
 3fc:	4899                	li	a7,6
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <exec>:
.global exec
exec:
 li a7, SYS_exec
 404:	489d                	li	a7,7
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <open>:
.global open
open:
 li a7, SYS_open
 40c:	48bd                	li	a7,15
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 414:	48c5                	li	a7,17
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 41c:	48c9                	li	a7,18
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 424:	48a1                	li	a7,8
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <link>:
.global link
link:
 li a7, SYS_link
 42c:	48cd                	li	a7,19
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 434:	48d1                	li	a7,20
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 43c:	48a5                	li	a7,9
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <dup>:
.global dup
dup:
 li a7, SYS_dup
 444:	48a9                	li	a7,10
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 44c:	48ad                	li	a7,11
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 454:	48b1                	li	a7,12
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <pause>:
.global pause
pause:
 li a7, SYS_pause
 45c:	48b5                	li	a7,13
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 464:	48b9                	li	a7,14
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 46c:	1101                	addi	sp,sp,-32
 46e:	ec06                	sd	ra,24(sp)
 470:	e822                	sd	s0,16(sp)
 472:	1000                	addi	s0,sp,32
 474:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 478:	4605                	li	a2,1
 47a:	fef40593          	addi	a1,s0,-17
 47e:	f6fff0ef          	jal	3ec <write>
}
 482:	60e2                	ld	ra,24(sp)
 484:	6442                	ld	s0,16(sp)
 486:	6105                	addi	sp,sp,32
 488:	8082                	ret

000000000000048a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 48a:	715d                	addi	sp,sp,-80
 48c:	e486                	sd	ra,72(sp)
 48e:	e0a2                	sd	s0,64(sp)
 490:	fc26                	sd	s1,56(sp)
 492:	f84a                	sd	s2,48(sp)
 494:	f44e                	sd	s3,40(sp)
 496:	0880                	addi	s0,sp,80
 498:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 49a:	c299                	beqz	a3,4a0 <printint+0x16>
 49c:	0605cf63          	bltz	a1,51a <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4a0:	2581                	sext.w	a1,a1
  neg = 0;
 4a2:	4e01                	li	t3,0
  }

  i = 0;
 4a4:	fb840313          	addi	t1,s0,-72
  neg = 0;
 4a8:	869a                	mv	a3,t1
  i = 0;
 4aa:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4ac:	00000817          	auipc	a6,0x0
 4b0:	54480813          	addi	a6,a6,1348 # 9f0 <digits>
 4b4:	88be                	mv	a7,a5
 4b6:	0017851b          	addiw	a0,a5,1
 4ba:	87aa                	mv	a5,a0
 4bc:	02c5f73b          	remuw	a4,a1,a2
 4c0:	1702                	slli	a4,a4,0x20
 4c2:	9301                	srli	a4,a4,0x20
 4c4:	9742                	add	a4,a4,a6
 4c6:	00074703          	lbu	a4,0(a4)
 4ca:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4ce:	872e                	mv	a4,a1
 4d0:	02c5d5bb          	divuw	a1,a1,a2
 4d4:	0685                	addi	a3,a3,1
 4d6:	fcc77fe3          	bgeu	a4,a2,4b4 <printint+0x2a>
  if(neg)
 4da:	000e0c63          	beqz	t3,4f2 <printint+0x68>
    buf[i++] = '-';
 4de:	fd050793          	addi	a5,a0,-48
 4e2:	00878533          	add	a0,a5,s0
 4e6:	02d00793          	li	a5,45
 4ea:	fef50423          	sb	a5,-24(a0)
 4ee:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4f2:	fff7899b          	addiw	s3,a5,-1
 4f6:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4fa:	fff4c583          	lbu	a1,-1(s1)
 4fe:	854a                	mv	a0,s2
 500:	f6dff0ef          	jal	46c <putc>
  while(--i >= 0)
 504:	39fd                	addiw	s3,s3,-1
 506:	14fd                	addi	s1,s1,-1
 508:	fe09d9e3          	bgez	s3,4fa <printint+0x70>
}
 50c:	60a6                	ld	ra,72(sp)
 50e:	6406                	ld	s0,64(sp)
 510:	74e2                	ld	s1,56(sp)
 512:	7942                	ld	s2,48(sp)
 514:	79a2                	ld	s3,40(sp)
 516:	6161                	addi	sp,sp,80
 518:	8082                	ret
    x = -xx;
 51a:	40b005bb          	negw	a1,a1
    neg = 1;
 51e:	4e05                	li	t3,1
    x = -xx;
 520:	b751                	j	4a4 <printint+0x1a>

0000000000000522 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 522:	711d                	addi	sp,sp,-96
 524:	ec86                	sd	ra,88(sp)
 526:	e8a2                	sd	s0,80(sp)
 528:	e4a6                	sd	s1,72(sp)
 52a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 52c:	0005c483          	lbu	s1,0(a1)
 530:	28048463          	beqz	s1,7b8 <vprintf+0x296>
 534:	e0ca                	sd	s2,64(sp)
 536:	fc4e                	sd	s3,56(sp)
 538:	f852                	sd	s4,48(sp)
 53a:	f456                	sd	s5,40(sp)
 53c:	f05a                	sd	s6,32(sp)
 53e:	ec5e                	sd	s7,24(sp)
 540:	e862                	sd	s8,16(sp)
 542:	e466                	sd	s9,8(sp)
 544:	8b2a                	mv	s6,a0
 546:	8a2e                	mv	s4,a1
 548:	8bb2                	mv	s7,a2
  state = 0;
 54a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 54c:	4901                	li	s2,0
 54e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 550:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 554:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 558:	06c00c93          	li	s9,108
 55c:	a00d                	j	57e <vprintf+0x5c>
        putc(fd, c0);
 55e:	85a6                	mv	a1,s1
 560:	855a                	mv	a0,s6
 562:	f0bff0ef          	jal	46c <putc>
 566:	a019                	j	56c <vprintf+0x4a>
    } else if(state == '%'){
 568:	03598363          	beq	s3,s5,58e <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 56c:	0019079b          	addiw	a5,s2,1
 570:	893e                	mv	s2,a5
 572:	873e                	mv	a4,a5
 574:	97d2                	add	a5,a5,s4
 576:	0007c483          	lbu	s1,0(a5)
 57a:	22048763          	beqz	s1,7a8 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 57e:	0004879b          	sext.w	a5,s1
    if(state == 0){
 582:	fe0993e3          	bnez	s3,568 <vprintf+0x46>
      if(c0 == '%'){
 586:	fd579ce3          	bne	a5,s5,55e <vprintf+0x3c>
        state = '%';
 58a:	89be                	mv	s3,a5
 58c:	b7c5                	j	56c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 58e:	00ea06b3          	add	a3,s4,a4
 592:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 596:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 598:	c681                	beqz	a3,5a0 <vprintf+0x7e>
 59a:	9752                	add	a4,a4,s4
 59c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5a0:	05878263          	beq	a5,s8,5e4 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5a4:	05978c63          	beq	a5,s9,5fc <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5a8:	07500713          	li	a4,117
 5ac:	0ee78663          	beq	a5,a4,698 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5b0:	07800713          	li	a4,120
 5b4:	12e78863          	beq	a5,a4,6e4 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5b8:	07000713          	li	a4,112
 5bc:	14e78d63          	beq	a5,a4,716 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5c0:	06300713          	li	a4,99
 5c4:	18e78c63          	beq	a5,a4,75c <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5c8:	07300713          	li	a4,115
 5cc:	1ae78263          	beq	a5,a4,770 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5d0:	02500713          	li	a4,37
 5d4:	04e79463          	bne	a5,a4,61c <vprintf+0xfa>
        putc(fd, '%');
 5d8:	85ba                	mv	a1,a4
 5da:	855a                	mv	a0,s6
 5dc:	e91ff0ef          	jal	46c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5e0:	4981                	li	s3,0
 5e2:	b769                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5e4:	008b8493          	addi	s1,s7,8
 5e8:	4685                	li	a3,1
 5ea:	4629                	li	a2,10
 5ec:	000ba583          	lw	a1,0(s7)
 5f0:	855a                	mv	a0,s6
 5f2:	e99ff0ef          	jal	48a <printint>
 5f6:	8ba6                	mv	s7,s1
      state = 0;
 5f8:	4981                	li	s3,0
 5fa:	bf8d                	j	56c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5fc:	06400793          	li	a5,100
 600:	02f68963          	beq	a3,a5,632 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 604:	06c00793          	li	a5,108
 608:	04f68263          	beq	a3,a5,64c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 60c:	07500793          	li	a5,117
 610:	0af68063          	beq	a3,a5,6b0 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 614:	07800793          	li	a5,120
 618:	0ef68263          	beq	a3,a5,6fc <vprintf+0x1da>
        putc(fd, '%');
 61c:	02500593          	li	a1,37
 620:	855a                	mv	a0,s6
 622:	e4bff0ef          	jal	46c <putc>
        putc(fd, c0);
 626:	85a6                	mv	a1,s1
 628:	855a                	mv	a0,s6
 62a:	e43ff0ef          	jal	46c <putc>
      state = 0;
 62e:	4981                	li	s3,0
 630:	bf35                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 632:	008b8493          	addi	s1,s7,8
 636:	4685                	li	a3,1
 638:	4629                	li	a2,10
 63a:	000bb583          	ld	a1,0(s7)
 63e:	855a                	mv	a0,s6
 640:	e4bff0ef          	jal	48a <printint>
        i += 1;
 644:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 646:	8ba6                	mv	s7,s1
      state = 0;
 648:	4981                	li	s3,0
        i += 1;
 64a:	b70d                	j	56c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 64c:	06400793          	li	a5,100
 650:	02f60763          	beq	a2,a5,67e <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 654:	07500793          	li	a5,117
 658:	06f60963          	beq	a2,a5,6ca <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 65c:	07800793          	li	a5,120
 660:	faf61ee3          	bne	a2,a5,61c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 664:	008b8493          	addi	s1,s7,8
 668:	4681                	li	a3,0
 66a:	4641                	li	a2,16
 66c:	000bb583          	ld	a1,0(s7)
 670:	855a                	mv	a0,s6
 672:	e19ff0ef          	jal	48a <printint>
        i += 2;
 676:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 678:	8ba6                	mv	s7,s1
      state = 0;
 67a:	4981                	li	s3,0
        i += 2;
 67c:	bdc5                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 67e:	008b8493          	addi	s1,s7,8
 682:	4685                	li	a3,1
 684:	4629                	li	a2,10
 686:	000bb583          	ld	a1,0(s7)
 68a:	855a                	mv	a0,s6
 68c:	dffff0ef          	jal	48a <printint>
        i += 2;
 690:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 692:	8ba6                	mv	s7,s1
      state = 0;
 694:	4981                	li	s3,0
        i += 2;
 696:	bdd9                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 698:	008b8493          	addi	s1,s7,8
 69c:	4681                	li	a3,0
 69e:	4629                	li	a2,10
 6a0:	000be583          	lwu	a1,0(s7)
 6a4:	855a                	mv	a0,s6
 6a6:	de5ff0ef          	jal	48a <printint>
 6aa:	8ba6                	mv	s7,s1
      state = 0;
 6ac:	4981                	li	s3,0
 6ae:	bd7d                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b0:	008b8493          	addi	s1,s7,8
 6b4:	4681                	li	a3,0
 6b6:	4629                	li	a2,10
 6b8:	000bb583          	ld	a1,0(s7)
 6bc:	855a                	mv	a0,s6
 6be:	dcdff0ef          	jal	48a <printint>
        i += 1;
 6c2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6c4:	8ba6                	mv	s7,s1
      state = 0;
 6c6:	4981                	li	s3,0
        i += 1;
 6c8:	b555                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ca:	008b8493          	addi	s1,s7,8
 6ce:	4681                	li	a3,0
 6d0:	4629                	li	a2,10
 6d2:	000bb583          	ld	a1,0(s7)
 6d6:	855a                	mv	a0,s6
 6d8:	db3ff0ef          	jal	48a <printint>
        i += 2;
 6dc:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6de:	8ba6                	mv	s7,s1
      state = 0;
 6e0:	4981                	li	s3,0
        i += 2;
 6e2:	b569                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6e4:	008b8493          	addi	s1,s7,8
 6e8:	4681                	li	a3,0
 6ea:	4641                	li	a2,16
 6ec:	000be583          	lwu	a1,0(s7)
 6f0:	855a                	mv	a0,s6
 6f2:	d99ff0ef          	jal	48a <printint>
 6f6:	8ba6                	mv	s7,s1
      state = 0;
 6f8:	4981                	li	s3,0
 6fa:	bd8d                	j	56c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6fc:	008b8493          	addi	s1,s7,8
 700:	4681                	li	a3,0
 702:	4641                	li	a2,16
 704:	000bb583          	ld	a1,0(s7)
 708:	855a                	mv	a0,s6
 70a:	d81ff0ef          	jal	48a <printint>
        i += 1;
 70e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 710:	8ba6                	mv	s7,s1
      state = 0;
 712:	4981                	li	s3,0
        i += 1;
 714:	bda1                	j	56c <vprintf+0x4a>
 716:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 718:	008b8d13          	addi	s10,s7,8
 71c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 720:	03000593          	li	a1,48
 724:	855a                	mv	a0,s6
 726:	d47ff0ef          	jal	46c <putc>
  putc(fd, 'x');
 72a:	07800593          	li	a1,120
 72e:	855a                	mv	a0,s6
 730:	d3dff0ef          	jal	46c <putc>
 734:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 736:	00000b97          	auipc	s7,0x0
 73a:	2bab8b93          	addi	s7,s7,698 # 9f0 <digits>
 73e:	03c9d793          	srli	a5,s3,0x3c
 742:	97de                	add	a5,a5,s7
 744:	0007c583          	lbu	a1,0(a5)
 748:	855a                	mv	a0,s6
 74a:	d23ff0ef          	jal	46c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 74e:	0992                	slli	s3,s3,0x4
 750:	34fd                	addiw	s1,s1,-1
 752:	f4f5                	bnez	s1,73e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 754:	8bea                	mv	s7,s10
      state = 0;
 756:	4981                	li	s3,0
 758:	6d02                	ld	s10,0(sp)
 75a:	bd09                	j	56c <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 75c:	008b8493          	addi	s1,s7,8
 760:	000bc583          	lbu	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	d07ff0ef          	jal	46c <putc>
 76a:	8ba6                	mv	s7,s1
      state = 0;
 76c:	4981                	li	s3,0
 76e:	bbfd                	j	56c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 770:	008b8993          	addi	s3,s7,8
 774:	000bb483          	ld	s1,0(s7)
 778:	cc91                	beqz	s1,794 <vprintf+0x272>
        for(; *s; s++)
 77a:	0004c583          	lbu	a1,0(s1)
 77e:	c195                	beqz	a1,7a2 <vprintf+0x280>
          putc(fd, *s);
 780:	855a                	mv	a0,s6
 782:	cebff0ef          	jal	46c <putc>
        for(; *s; s++)
 786:	0485                	addi	s1,s1,1
 788:	0004c583          	lbu	a1,0(s1)
 78c:	f9f5                	bnez	a1,780 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 78e:	8bce                	mv	s7,s3
      state = 0;
 790:	4981                	li	s3,0
 792:	bbe9                	j	56c <vprintf+0x4a>
          s = "(null)";
 794:	00000497          	auipc	s1,0x0
 798:	25448493          	addi	s1,s1,596 # 9e8 <malloc+0x144>
        for(; *s; s++)
 79c:	02800593          	li	a1,40
 7a0:	b7c5                	j	780 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 7a2:	8bce                	mv	s7,s3
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	b3d9                	j	56c <vprintf+0x4a>
 7a8:	6906                	ld	s2,64(sp)
 7aa:	79e2                	ld	s3,56(sp)
 7ac:	7a42                	ld	s4,48(sp)
 7ae:	7aa2                	ld	s5,40(sp)
 7b0:	7b02                	ld	s6,32(sp)
 7b2:	6be2                	ld	s7,24(sp)
 7b4:	6c42                	ld	s8,16(sp)
 7b6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7b8:	60e6                	ld	ra,88(sp)
 7ba:	6446                	ld	s0,80(sp)
 7bc:	64a6                	ld	s1,72(sp)
 7be:	6125                	addi	sp,sp,96
 7c0:	8082                	ret

00000000000007c2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7c2:	715d                	addi	sp,sp,-80
 7c4:	ec06                	sd	ra,24(sp)
 7c6:	e822                	sd	s0,16(sp)
 7c8:	1000                	addi	s0,sp,32
 7ca:	e010                	sd	a2,0(s0)
 7cc:	e414                	sd	a3,8(s0)
 7ce:	e818                	sd	a4,16(s0)
 7d0:	ec1c                	sd	a5,24(s0)
 7d2:	03043023          	sd	a6,32(s0)
 7d6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7da:	8622                	mv	a2,s0
 7dc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e0:	d43ff0ef          	jal	522 <vprintf>
}
 7e4:	60e2                	ld	ra,24(sp)
 7e6:	6442                	ld	s0,16(sp)
 7e8:	6161                	addi	sp,sp,80
 7ea:	8082                	ret

00000000000007ec <printf>:

void
printf(const char *fmt, ...)
{
 7ec:	711d                	addi	sp,sp,-96
 7ee:	ec06                	sd	ra,24(sp)
 7f0:	e822                	sd	s0,16(sp)
 7f2:	1000                	addi	s0,sp,32
 7f4:	e40c                	sd	a1,8(s0)
 7f6:	e810                	sd	a2,16(s0)
 7f8:	ec14                	sd	a3,24(s0)
 7fa:	f018                	sd	a4,32(s0)
 7fc:	f41c                	sd	a5,40(s0)
 7fe:	03043823          	sd	a6,48(s0)
 802:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 806:	00840613          	addi	a2,s0,8
 80a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 80e:	85aa                	mv	a1,a0
 810:	4505                	li	a0,1
 812:	d11ff0ef          	jal	522 <vprintf>
}
 816:	60e2                	ld	ra,24(sp)
 818:	6442                	ld	s0,16(sp)
 81a:	6125                	addi	sp,sp,96
 81c:	8082                	ret

000000000000081e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 81e:	1141                	addi	sp,sp,-16
 820:	e406                	sd	ra,8(sp)
 822:	e022                	sd	s0,0(sp)
 824:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 826:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 82a:	00000797          	auipc	a5,0x0
 82e:	7d67b783          	ld	a5,2006(a5) # 1000 <freep>
 832:	a02d                	j	85c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 834:	4618                	lw	a4,8(a2)
 836:	9f2d                	addw	a4,a4,a1
 838:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 83c:	6398                	ld	a4,0(a5)
 83e:	6310                	ld	a2,0(a4)
 840:	a83d                	j	87e <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 842:	ff852703          	lw	a4,-8(a0)
 846:	9f31                	addw	a4,a4,a2
 848:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 84a:	ff053683          	ld	a3,-16(a0)
 84e:	a091                	j	892 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 850:	6398                	ld	a4,0(a5)
 852:	00e7e463          	bltu	a5,a4,85a <free+0x3c>
 856:	00e6ea63          	bltu	a3,a4,86a <free+0x4c>
{
 85a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 85c:	fed7fae3          	bgeu	a5,a3,850 <free+0x32>
 860:	6398                	ld	a4,0(a5)
 862:	00e6e463          	bltu	a3,a4,86a <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 866:	fee7eae3          	bltu	a5,a4,85a <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 86a:	ff852583          	lw	a1,-8(a0)
 86e:	6390                	ld	a2,0(a5)
 870:	02059813          	slli	a6,a1,0x20
 874:	01c85713          	srli	a4,a6,0x1c
 878:	9736                	add	a4,a4,a3
 87a:	fae60de3          	beq	a2,a4,834 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 87e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 882:	4790                	lw	a2,8(a5)
 884:	02061593          	slli	a1,a2,0x20
 888:	01c5d713          	srli	a4,a1,0x1c
 88c:	973e                	add	a4,a4,a5
 88e:	fae68ae3          	beq	a3,a4,842 <free+0x24>
    p->s.ptr = bp->s.ptr;
 892:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 894:	00000717          	auipc	a4,0x0
 898:	76f73623          	sd	a5,1900(a4) # 1000 <freep>
}
 89c:	60a2                	ld	ra,8(sp)
 89e:	6402                	ld	s0,0(sp)
 8a0:	0141                	addi	sp,sp,16
 8a2:	8082                	ret

00000000000008a4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8a4:	7139                	addi	sp,sp,-64
 8a6:	fc06                	sd	ra,56(sp)
 8a8:	f822                	sd	s0,48(sp)
 8aa:	f04a                	sd	s2,32(sp)
 8ac:	ec4e                	sd	s3,24(sp)
 8ae:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b0:	02051993          	slli	s3,a0,0x20
 8b4:	0209d993          	srli	s3,s3,0x20
 8b8:	09bd                	addi	s3,s3,15
 8ba:	0049d993          	srli	s3,s3,0x4
 8be:	2985                	addiw	s3,s3,1
 8c0:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8c2:	00000517          	auipc	a0,0x0
 8c6:	73e53503          	ld	a0,1854(a0) # 1000 <freep>
 8ca:	c905                	beqz	a0,8fa <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8cc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8ce:	4798                	lw	a4,8(a5)
 8d0:	09377663          	bgeu	a4,s3,95c <malloc+0xb8>
 8d4:	f426                	sd	s1,40(sp)
 8d6:	e852                	sd	s4,16(sp)
 8d8:	e456                	sd	s5,8(sp)
 8da:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8dc:	8a4e                	mv	s4,s3
 8de:	6705                	lui	a4,0x1
 8e0:	00e9f363          	bgeu	s3,a4,8e6 <malloc+0x42>
 8e4:	6a05                	lui	s4,0x1
 8e6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8ea:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8ee:	00000497          	auipc	s1,0x0
 8f2:	71248493          	addi	s1,s1,1810 # 1000 <freep>
  if(p == SBRK_ERROR)
 8f6:	5afd                	li	s5,-1
 8f8:	a83d                	j	936 <malloc+0x92>
 8fa:	f426                	sd	s1,40(sp)
 8fc:	e852                	sd	s4,16(sp)
 8fe:	e456                	sd	s5,8(sp)
 900:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 902:	00001797          	auipc	a5,0x1
 906:	90678793          	addi	a5,a5,-1786 # 1208 <base>
 90a:	00000717          	auipc	a4,0x0
 90e:	6ef73b23          	sd	a5,1782(a4) # 1000 <freep>
 912:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 914:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 918:	b7d1                	j	8dc <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 91a:	6398                	ld	a4,0(a5)
 91c:	e118                	sd	a4,0(a0)
 91e:	a899                	j	974 <malloc+0xd0>
  hp->s.size = nu;
 920:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 924:	0541                	addi	a0,a0,16
 926:	ef9ff0ef          	jal	81e <free>
  return freep;
 92a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 92c:	c125                	beqz	a0,98c <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 930:	4798                	lw	a4,8(a5)
 932:	03277163          	bgeu	a4,s2,954 <malloc+0xb0>
    if(p == freep)
 936:	6098                	ld	a4,0(s1)
 938:	853e                	mv	a0,a5
 93a:	fef71ae3          	bne	a4,a5,92e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 93e:	8552                	mv	a0,s4
 940:	a59ff0ef          	jal	398 <sbrk>
  if(p == SBRK_ERROR)
 944:	fd551ee3          	bne	a0,s5,920 <malloc+0x7c>
        return 0;
 948:	4501                	li	a0,0
 94a:	74a2                	ld	s1,40(sp)
 94c:	6a42                	ld	s4,16(sp)
 94e:	6aa2                	ld	s5,8(sp)
 950:	6b02                	ld	s6,0(sp)
 952:	a03d                	j	980 <malloc+0xdc>
 954:	74a2                	ld	s1,40(sp)
 956:	6a42                	ld	s4,16(sp)
 958:	6aa2                	ld	s5,8(sp)
 95a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 95c:	fae90fe3          	beq	s2,a4,91a <malloc+0x76>
        p->s.size -= nunits;
 960:	4137073b          	subw	a4,a4,s3
 964:	c798                	sw	a4,8(a5)
        p += p->s.size;
 966:	02071693          	slli	a3,a4,0x20
 96a:	01c6d713          	srli	a4,a3,0x1c
 96e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 970:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 974:	00000717          	auipc	a4,0x0
 978:	68a73623          	sd	a0,1676(a4) # 1000 <freep>
      return (void*)(p + 1);
 97c:	01078513          	addi	a0,a5,16
  }
}
 980:	70e2                	ld	ra,56(sp)
 982:	7442                	ld	s0,48(sp)
 984:	7902                	ld	s2,32(sp)
 986:	69e2                	ld	s3,24(sp)
 988:	6121                	addi	sp,sp,64
 98a:	8082                	ret
 98c:	74a2                	ld	s1,40(sp)
 98e:	6a42                	ld	s4,16(sp)
 990:	6aa2                	ld	s5,8(sp)
 992:	6b02                	ld	s6,0(sp)
 994:	b7f5                	j	980 <malloc+0xdc>
