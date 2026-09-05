
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4901                	li	s2,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  2e:	00001d97          	auipc	s11,0x1
  32:	fe2d8d93          	addi	s11,s11,-30 # 1010 <buf>
  36:	20000d13          	li	s10,512
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  3a:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  3c:	00001a17          	auipc	s4,0x1
  40:	9b4a0a13          	addi	s4,s4,-1612 # 9f0 <malloc+0xf2>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  44:	a035                	j	70 <wc+0x70>
      if(strchr(" \r\t\n\v", buf[i]))
  46:	8552                	mv	a0,s4
  48:	1ca000ef          	jal	212 <strchr>
  4c:	c919                	beqz	a0,62 <wc+0x62>
        inword = 0;
  4e:	4901                	li	s2,0
    for(i=0; i<n; i++){
  50:	0485                	addi	s1,s1,1
  52:	01348d63          	beq	s1,s3,6c <wc+0x6c>
      if(buf[i] == '\n')
  56:	0004c583          	lbu	a1,0(s1)
  5a:	ff5596e3          	bne	a1,s5,46 <wc+0x46>
        l++;
  5e:	2b85                	addiw	s7,s7,1
  60:	b7dd                	j	46 <wc+0x46>
      else if(!inword){
  62:	fe0917e3          	bnez	s2,50 <wc+0x50>
        w++;
  66:	2c05                	addiw	s8,s8,1
        inword = 1;
  68:	4905                	li	s2,1
  6a:	b7dd                	j	50 <wc+0x50>
  6c:	019b0cbb          	addw	s9,s6,s9
  while((n = read(fd, buf, sizeof(buf))) > 0){
  70:	866a                	mv	a2,s10
  72:	85ee                	mv	a1,s11
  74:	f8843503          	ld	a0,-120(s0)
  78:	3c6000ef          	jal	43e <read>
  7c:	8b2a                	mv	s6,a0
  7e:	00a05963          	blez	a0,90 <wc+0x90>
  82:	00001497          	auipc	s1,0x1
  86:	f8e48493          	addi	s1,s1,-114 # 1010 <buf>
  8a:	009b09b3          	add	s3,s6,s1
  8e:	b7e1                	j	56 <wc+0x56>
      }
    }
  }
  if(n < 0){
  90:	02054c63          	bltz	a0,c8 <wc+0xc8>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  94:	f8043703          	ld	a4,-128(s0)
  98:	86e6                	mv	a3,s9
  9a:	8662                	mv	a2,s8
  9c:	85de                	mv	a1,s7
  9e:	00001517          	auipc	a0,0x1
  a2:	97250513          	addi	a0,a0,-1678 # a10 <malloc+0x112>
  a6:	7a0000ef          	jal	846 <printf>
}
  aa:	70e6                	ld	ra,120(sp)
  ac:	7446                	ld	s0,112(sp)
  ae:	74a6                	ld	s1,104(sp)
  b0:	7906                	ld	s2,96(sp)
  b2:	69e6                	ld	s3,88(sp)
  b4:	6a46                	ld	s4,80(sp)
  b6:	6aa6                	ld	s5,72(sp)
  b8:	6b06                	ld	s6,64(sp)
  ba:	7be2                	ld	s7,56(sp)
  bc:	7c42                	ld	s8,48(sp)
  be:	7ca2                	ld	s9,40(sp)
  c0:	7d02                	ld	s10,32(sp)
  c2:	6de2                	ld	s11,24(sp)
  c4:	6109                	addi	sp,sp,128
  c6:	8082                	ret
    printf("wc: read error\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	93850513          	addi	a0,a0,-1736 # a00 <malloc+0x102>
  d0:	776000ef          	jal	846 <printf>
    exit(1);
  d4:	4505                	li	a0,1
  d6:	350000ef          	jal	426 <exit>

00000000000000da <main>:

int
main(int argc, char *argv[])
{
  da:	7179                	addi	sp,sp,-48
  dc:	f406                	sd	ra,40(sp)
  de:	f022                	sd	s0,32(sp)
  e0:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  e2:	4785                	li	a5,1
  e4:	04a7d463          	bge	a5,a0,12c <main+0x52>
  e8:	ec26                	sd	s1,24(sp)
  ea:	e84a                	sd	s2,16(sp)
  ec:	e44e                	sd	s3,8(sp)
  ee:	00858913          	addi	s2,a1,8
  f2:	ffe5099b          	addiw	s3,a0,-2
  f6:	02099793          	slli	a5,s3,0x20
  fa:	01d7d993          	srli	s3,a5,0x1d
  fe:	05c1                	addi	a1,a1,16
 100:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
 102:	4581                	li	a1,0
 104:	00093503          	ld	a0,0(s2)
 108:	35e000ef          	jal	466 <open>
 10c:	84aa                	mv	s1,a0
 10e:	02054c63          	bltz	a0,146 <main+0x6c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 112:	00093583          	ld	a1,0(s2)
 116:	eebff0ef          	jal	0 <wc>
    close(fd);
 11a:	8526                	mv	a0,s1
 11c:	332000ef          	jal	44e <close>
  for(i = 1; i < argc; i++){
 120:	0921                	addi	s2,s2,8
 122:	ff3910e3          	bne	s2,s3,102 <main+0x28>
  }
  exit(0);
 126:	4501                	li	a0,0
 128:	2fe000ef          	jal	426 <exit>
 12c:	ec26                	sd	s1,24(sp)
 12e:	e84a                	sd	s2,16(sp)
 130:	e44e                	sd	s3,8(sp)
    wc(0, "");
 132:	00001597          	auipc	a1,0x1
 136:	8c658593          	addi	a1,a1,-1850 # 9f8 <malloc+0xfa>
 13a:	4501                	li	a0,0
 13c:	ec5ff0ef          	jal	0 <wc>
    exit(0);
 140:	4501                	li	a0,0
 142:	2e4000ef          	jal	426 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 146:	00093583          	ld	a1,0(s2)
 14a:	00001517          	auipc	a0,0x1
 14e:	8d650513          	addi	a0,a0,-1834 # a20 <malloc+0x122>
 152:	6f4000ef          	jal	846 <printf>
      exit(1);
 156:	4505                	li	a0,1
 158:	2ce000ef          	jal	426 <exit>

000000000000015c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e406                	sd	ra,8(sp)
 160:	e022                	sd	s0,0(sp)
 162:	0800                	addi	s0,sp,16
  extern int main();
  main();
 164:	f77ff0ef          	jal	da <main>
  exit(0);
 168:	4501                	li	a0,0
 16a:	2bc000ef          	jal	426 <exit>

000000000000016e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 16e:	1141                	addi	sp,sp,-16
 170:	e406                	sd	ra,8(sp)
 172:	e022                	sd	s0,0(sp)
 174:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 176:	87aa                	mv	a5,a0
 178:	0585                	addi	a1,a1,1
 17a:	0785                	addi	a5,a5,1
 17c:	fff5c703          	lbu	a4,-1(a1)
 180:	fee78fa3          	sb	a4,-1(a5)
 184:	fb75                	bnez	a4,178 <strcpy+0xa>
    ;
  return os;
}
 186:	60a2                	ld	ra,8(sp)
 188:	6402                	ld	s0,0(sp)
 18a:	0141                	addi	sp,sp,16
 18c:	8082                	ret

000000000000018e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 18e:	1141                	addi	sp,sp,-16
 190:	e406                	sd	ra,8(sp)
 192:	e022                	sd	s0,0(sp)
 194:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 196:	00054783          	lbu	a5,0(a0)
 19a:	cb91                	beqz	a5,1ae <strcmp+0x20>
 19c:	0005c703          	lbu	a4,0(a1)
 1a0:	00f71763          	bne	a4,a5,1ae <strcmp+0x20>
    p++, q++;
 1a4:	0505                	addi	a0,a0,1
 1a6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 1a8:	00054783          	lbu	a5,0(a0)
 1ac:	fbe5                	bnez	a5,19c <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 1ae:	0005c503          	lbu	a0,0(a1)
}
 1b2:	40a7853b          	subw	a0,a5,a0
 1b6:	60a2                	ld	ra,8(sp)
 1b8:	6402                	ld	s0,0(sp)
 1ba:	0141                	addi	sp,sp,16
 1bc:	8082                	ret

00000000000001be <strlen>:

uint
strlen(const char *s)
{
 1be:	1141                	addi	sp,sp,-16
 1c0:	e406                	sd	ra,8(sp)
 1c2:	e022                	sd	s0,0(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 1c6:	00054783          	lbu	a5,0(a0)
 1ca:	cf99                	beqz	a5,1e8 <strlen+0x2a>
 1cc:	0505                	addi	a0,a0,1
 1ce:	87aa                	mv	a5,a0
 1d0:	86be                	mv	a3,a5
 1d2:	0785                	addi	a5,a5,1
 1d4:	fff7c703          	lbu	a4,-1(a5)
 1d8:	ff65                	bnez	a4,1d0 <strlen+0x12>
 1da:	40a6853b          	subw	a0,a3,a0
 1de:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 1e0:	60a2                	ld	ra,8(sp)
 1e2:	6402                	ld	s0,0(sp)
 1e4:	0141                	addi	sp,sp,16
 1e6:	8082                	ret
  for(n = 0; s[n]; n++)
 1e8:	4501                	li	a0,0
 1ea:	bfdd                	j	1e0 <strlen+0x22>

00000000000001ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e406                	sd	ra,8(sp)
 1f0:	e022                	sd	s0,0(sp)
 1f2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 1f4:	ca19                	beqz	a2,20a <memset+0x1e>
 1f6:	87aa                	mv	a5,a0
 1f8:	1602                	slli	a2,a2,0x20
 1fa:	9201                	srli	a2,a2,0x20
 1fc:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 200:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 204:	0785                	addi	a5,a5,1
 206:	fee79de3          	bne	a5,a4,200 <memset+0x14>
  }
  return dst;
}
 20a:	60a2                	ld	ra,8(sp)
 20c:	6402                	ld	s0,0(sp)
 20e:	0141                	addi	sp,sp,16
 210:	8082                	ret

0000000000000212 <strchr>:

char*
strchr(const char *s, char c)
{
 212:	1141                	addi	sp,sp,-16
 214:	e406                	sd	ra,8(sp)
 216:	e022                	sd	s0,0(sp)
 218:	0800                	addi	s0,sp,16
  for(; *s; s++)
 21a:	00054783          	lbu	a5,0(a0)
 21e:	cf81                	beqz	a5,236 <strchr+0x24>
    if(*s == c)
 220:	00f58763          	beq	a1,a5,22e <strchr+0x1c>
  for(; *s; s++)
 224:	0505                	addi	a0,a0,1
 226:	00054783          	lbu	a5,0(a0)
 22a:	fbfd                	bnez	a5,220 <strchr+0xe>
      return (char*)s;
  return 0;
 22c:	4501                	li	a0,0
}
 22e:	60a2                	ld	ra,8(sp)
 230:	6402                	ld	s0,0(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret
  return 0;
 236:	4501                	li	a0,0
 238:	bfdd                	j	22e <strchr+0x1c>

000000000000023a <gets>:

char*
gets(char *buf, int max)
{
 23a:	7159                	addi	sp,sp,-112
 23c:	f486                	sd	ra,104(sp)
 23e:	f0a2                	sd	s0,96(sp)
 240:	eca6                	sd	s1,88(sp)
 242:	e8ca                	sd	s2,80(sp)
 244:	e4ce                	sd	s3,72(sp)
 246:	e0d2                	sd	s4,64(sp)
 248:	fc56                	sd	s5,56(sp)
 24a:	f85a                	sd	s6,48(sp)
 24c:	f45e                	sd	s7,40(sp)
 24e:	f062                	sd	s8,32(sp)
 250:	ec66                	sd	s9,24(sp)
 252:	e86a                	sd	s10,16(sp)
 254:	1880                	addi	s0,sp,112
 256:	8caa                	mv	s9,a0
 258:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25a:	892a                	mv	s2,a0
 25c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 25e:	f9f40b13          	addi	s6,s0,-97
 262:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 264:	4ba9                	li	s7,10
 266:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 268:	8d26                	mv	s10,s1
 26a:	0014899b          	addiw	s3,s1,1
 26e:	84ce                	mv	s1,s3
 270:	0349d563          	bge	s3,s4,29a <gets+0x60>
    cc = read(0, &c, 1);
 274:	8656                	mv	a2,s5
 276:	85da                	mv	a1,s6
 278:	4501                	li	a0,0
 27a:	1c4000ef          	jal	43e <read>
    if(cc < 1)
 27e:	00a05e63          	blez	a0,29a <gets+0x60>
    buf[i++] = c;
 282:	f9f44783          	lbu	a5,-97(s0)
 286:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 28a:	01778763          	beq	a5,s7,298 <gets+0x5e>
 28e:	0905                	addi	s2,s2,1
 290:	fd879ce3          	bne	a5,s8,268 <gets+0x2e>
    buf[i++] = c;
 294:	8d4e                	mv	s10,s3
 296:	a011                	j	29a <gets+0x60>
 298:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 29a:	9d66                	add	s10,s10,s9
 29c:	000d0023          	sb	zero,0(s10)
  return buf;
}
 2a0:	8566                	mv	a0,s9
 2a2:	70a6                	ld	ra,104(sp)
 2a4:	7406                	ld	s0,96(sp)
 2a6:	64e6                	ld	s1,88(sp)
 2a8:	6946                	ld	s2,80(sp)
 2aa:	69a6                	ld	s3,72(sp)
 2ac:	6a06                	ld	s4,64(sp)
 2ae:	7ae2                	ld	s5,56(sp)
 2b0:	7b42                	ld	s6,48(sp)
 2b2:	7ba2                	ld	s7,40(sp)
 2b4:	7c02                	ld	s8,32(sp)
 2b6:	6ce2                	ld	s9,24(sp)
 2b8:	6d42                	ld	s10,16(sp)
 2ba:	6165                	addi	sp,sp,112
 2bc:	8082                	ret

00000000000002be <stat>:

int
stat(const char *n, struct stat *st)
{
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e04a                	sd	s2,0(sp)
 2c6:	1000                	addi	s0,sp,32
 2c8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2ca:	4581                	li	a1,0
 2cc:	19a000ef          	jal	466 <open>
  if(fd < 0)
 2d0:	02054263          	bltz	a0,2f4 <stat+0x36>
 2d4:	e426                	sd	s1,8(sp)
 2d6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 2d8:	85ca                	mv	a1,s2
 2da:	1a4000ef          	jal	47e <fstat>
 2de:	892a                	mv	s2,a0
  close(fd);
 2e0:	8526                	mv	a0,s1
 2e2:	16c000ef          	jal	44e <close>
  return r;
 2e6:	64a2                	ld	s1,8(sp)
}
 2e8:	854a                	mv	a0,s2
 2ea:	60e2                	ld	ra,24(sp)
 2ec:	6442                	ld	s0,16(sp)
 2ee:	6902                	ld	s2,0(sp)
 2f0:	6105                	addi	sp,sp,32
 2f2:	8082                	ret
    return -1;
 2f4:	597d                	li	s2,-1
 2f6:	bfcd                	j	2e8 <stat+0x2a>

00000000000002f8 <atoi>:

int
atoi(const char *s)
{
 2f8:	1141                	addi	sp,sp,-16
 2fa:	e406                	sd	ra,8(sp)
 2fc:	e022                	sd	s0,0(sp)
 2fe:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 300:	00054683          	lbu	a3,0(a0)
 304:	fd06879b          	addiw	a5,a3,-48
 308:	0ff7f793          	zext.b	a5,a5
 30c:	4625                	li	a2,9
 30e:	02f66963          	bltu	a2,a5,340 <atoi+0x48>
 312:	872a                	mv	a4,a0
  n = 0;
 314:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 316:	0705                	addi	a4,a4,1
 318:	0025179b          	slliw	a5,a0,0x2
 31c:	9fa9                	addw	a5,a5,a0
 31e:	0017979b          	slliw	a5,a5,0x1
 322:	9fb5                	addw	a5,a5,a3
 324:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 328:	00074683          	lbu	a3,0(a4)
 32c:	fd06879b          	addiw	a5,a3,-48
 330:	0ff7f793          	zext.b	a5,a5
 334:	fef671e3          	bgeu	a2,a5,316 <atoi+0x1e>
  return n;
}
 338:	60a2                	ld	ra,8(sp)
 33a:	6402                	ld	s0,0(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret
  n = 0;
 340:	4501                	li	a0,0
 342:	bfdd                	j	338 <atoi+0x40>

0000000000000344 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 344:	1141                	addi	sp,sp,-16
 346:	e406                	sd	ra,8(sp)
 348:	e022                	sd	s0,0(sp)
 34a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 34c:	02b57563          	bgeu	a0,a1,376 <memmove+0x32>
    while(n-- > 0)
 350:	00c05f63          	blez	a2,36e <memmove+0x2a>
 354:	1602                	slli	a2,a2,0x20
 356:	9201                	srli	a2,a2,0x20
 358:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 35c:	872a                	mv	a4,a0
      *dst++ = *src++;
 35e:	0585                	addi	a1,a1,1
 360:	0705                	addi	a4,a4,1
 362:	fff5c683          	lbu	a3,-1(a1)
 366:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 36a:	fee79ae3          	bne	a5,a4,35e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 36e:	60a2                	ld	ra,8(sp)
 370:	6402                	ld	s0,0(sp)
 372:	0141                	addi	sp,sp,16
 374:	8082                	ret
    dst += n;
 376:	00c50733          	add	a4,a0,a2
    src += n;
 37a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 37c:	fec059e3          	blez	a2,36e <memmove+0x2a>
 380:	fff6079b          	addiw	a5,a2,-1
 384:	1782                	slli	a5,a5,0x20
 386:	9381                	srli	a5,a5,0x20
 388:	fff7c793          	not	a5,a5
 38c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 38e:	15fd                	addi	a1,a1,-1
 390:	177d                	addi	a4,a4,-1
 392:	0005c683          	lbu	a3,0(a1)
 396:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 39a:	fef71ae3          	bne	a4,a5,38e <memmove+0x4a>
 39e:	bfc1                	j	36e <memmove+0x2a>

00000000000003a0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 3a0:	1141                	addi	sp,sp,-16
 3a2:	e406                	sd	ra,8(sp)
 3a4:	e022                	sd	s0,0(sp)
 3a6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 3a8:	ca0d                	beqz	a2,3da <memcmp+0x3a>
 3aa:	fff6069b          	addiw	a3,a2,-1
 3ae:	1682                	slli	a3,a3,0x20
 3b0:	9281                	srli	a3,a3,0x20
 3b2:	0685                	addi	a3,a3,1
 3b4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 3b6:	00054783          	lbu	a5,0(a0)
 3ba:	0005c703          	lbu	a4,0(a1)
 3be:	00e79863          	bne	a5,a4,3ce <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 3c2:	0505                	addi	a0,a0,1
    p2++;
 3c4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 3c6:	fed518e3          	bne	a0,a3,3b6 <memcmp+0x16>
  }
  return 0;
 3ca:	4501                	li	a0,0
 3cc:	a019                	j	3d2 <memcmp+0x32>
      return *p1 - *p2;
 3ce:	40e7853b          	subw	a0,a5,a4
}
 3d2:	60a2                	ld	ra,8(sp)
 3d4:	6402                	ld	s0,0(sp)
 3d6:	0141                	addi	sp,sp,16
 3d8:	8082                	ret
  return 0;
 3da:	4501                	li	a0,0
 3dc:	bfdd                	j	3d2 <memcmp+0x32>

00000000000003de <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e406                	sd	ra,8(sp)
 3e2:	e022                	sd	s0,0(sp)
 3e4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 3e6:	f5fff0ef          	jal	344 <memmove>
}
 3ea:	60a2                	ld	ra,8(sp)
 3ec:	6402                	ld	s0,0(sp)
 3ee:	0141                	addi	sp,sp,16
 3f0:	8082                	ret

00000000000003f2 <sbrk>:

char *
sbrk(int n) {
 3f2:	1141                	addi	sp,sp,-16
 3f4:	e406                	sd	ra,8(sp)
 3f6:	e022                	sd	s0,0(sp)
 3f8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 3fa:	4585                	li	a1,1
 3fc:	0b2000ef          	jal	4ae <sys_sbrk>
}
 400:	60a2                	ld	ra,8(sp)
 402:	6402                	ld	s0,0(sp)
 404:	0141                	addi	sp,sp,16
 406:	8082                	ret

0000000000000408 <sbrklazy>:

char *
sbrklazy(int n) {
 408:	1141                	addi	sp,sp,-16
 40a:	e406                	sd	ra,8(sp)
 40c:	e022                	sd	s0,0(sp)
 40e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 410:	4589                	li	a1,2
 412:	09c000ef          	jal	4ae <sys_sbrk>
}
 416:	60a2                	ld	ra,8(sp)
 418:	6402                	ld	s0,0(sp)
 41a:	0141                	addi	sp,sp,16
 41c:	8082                	ret

000000000000041e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 41e:	4885                	li	a7,1
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <exit>:
.global exit
exit:
 li a7, SYS_exit
 426:	4889                	li	a7,2
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <wait>:
.global wait
wait:
 li a7, SYS_wait
 42e:	488d                	li	a7,3
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 436:	4891                	li	a7,4
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <read>:
.global read
read:
 li a7, SYS_read
 43e:	4895                	li	a7,5
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <write>:
.global write
write:
 li a7, SYS_write
 446:	48c1                	li	a7,16
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <close>:
.global close
close:
 li a7, SYS_close
 44e:	48d5                	li	a7,21
 ecall
 450:	00000073          	ecall
 ret
 454:	8082                	ret

0000000000000456 <kill>:
.global kill
kill:
 li a7, SYS_kill
 456:	4899                	li	a7,6
 ecall
 458:	00000073          	ecall
 ret
 45c:	8082                	ret

000000000000045e <exec>:
.global exec
exec:
 li a7, SYS_exec
 45e:	489d                	li	a7,7
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <open>:
.global open
open:
 li a7, SYS_open
 466:	48bd                	li	a7,15
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 46e:	48c5                	li	a7,17
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 476:	48c9                	li	a7,18
 ecall
 478:	00000073          	ecall
 ret
 47c:	8082                	ret

000000000000047e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 47e:	48a1                	li	a7,8
 ecall
 480:	00000073          	ecall
 ret
 484:	8082                	ret

0000000000000486 <link>:
.global link
link:
 li a7, SYS_link
 486:	48cd                	li	a7,19
 ecall
 488:	00000073          	ecall
 ret
 48c:	8082                	ret

000000000000048e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 48e:	48d1                	li	a7,20
 ecall
 490:	00000073          	ecall
 ret
 494:	8082                	ret

0000000000000496 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 496:	48a5                	li	a7,9
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <dup>:
.global dup
dup:
 li a7, SYS_dup
 49e:	48a9                	li	a7,10
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a6:	48ad                	li	a7,11
 ecall
 4a8:	00000073          	ecall
 ret
 4ac:	8082                	ret

00000000000004ae <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4ae:	48b1                	li	a7,12
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4b6:	48b5                	li	a7,13
 ecall
 4b8:	00000073          	ecall
 ret
 4bc:	8082                	ret

00000000000004be <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4be:	48b9                	li	a7,14
 ecall
 4c0:	00000073          	ecall
 ret
 4c4:	8082                	ret

00000000000004c6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4c6:	1101                	addi	sp,sp,-32
 4c8:	ec06                	sd	ra,24(sp)
 4ca:	e822                	sd	s0,16(sp)
 4cc:	1000                	addi	s0,sp,32
 4ce:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4d2:	4605                	li	a2,1
 4d4:	fef40593          	addi	a1,s0,-17
 4d8:	f6fff0ef          	jal	446 <write>
}
 4dc:	60e2                	ld	ra,24(sp)
 4de:	6442                	ld	s0,16(sp)
 4e0:	6105                	addi	sp,sp,32
 4e2:	8082                	ret

00000000000004e4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4e4:	715d                	addi	sp,sp,-80
 4e6:	e486                	sd	ra,72(sp)
 4e8:	e0a2                	sd	s0,64(sp)
 4ea:	fc26                	sd	s1,56(sp)
 4ec:	f84a                	sd	s2,48(sp)
 4ee:	f44e                	sd	s3,40(sp)
 4f0:	0880                	addi	s0,sp,80
 4f2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4f4:	c299                	beqz	a3,4fa <printint+0x16>
 4f6:	0605cf63          	bltz	a1,574 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4fa:	2581                	sext.w	a1,a1
  neg = 0;
 4fc:	4e01                	li	t3,0
  }

  i = 0;
 4fe:	fb840313          	addi	t1,s0,-72
  neg = 0;
 502:	869a                	mv	a3,t1
  i = 0;
 504:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 506:	00000817          	auipc	a6,0x0
 50a:	53a80813          	addi	a6,a6,1338 # a40 <digits>
 50e:	88be                	mv	a7,a5
 510:	0017851b          	addiw	a0,a5,1
 514:	87aa                	mv	a5,a0
 516:	02c5f73b          	remuw	a4,a1,a2
 51a:	1702                	slli	a4,a4,0x20
 51c:	9301                	srli	a4,a4,0x20
 51e:	9742                	add	a4,a4,a6
 520:	00074703          	lbu	a4,0(a4)
 524:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 528:	872e                	mv	a4,a1
 52a:	02c5d5bb          	divuw	a1,a1,a2
 52e:	0685                	addi	a3,a3,1
 530:	fcc77fe3          	bgeu	a4,a2,50e <printint+0x2a>
  if(neg)
 534:	000e0c63          	beqz	t3,54c <printint+0x68>
    buf[i++] = '-';
 538:	fd050793          	addi	a5,a0,-48
 53c:	00878533          	add	a0,a5,s0
 540:	02d00793          	li	a5,45
 544:	fef50423          	sb	a5,-24(a0)
 548:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 54c:	fff7899b          	addiw	s3,a5,-1
 550:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 554:	fff4c583          	lbu	a1,-1(s1)
 558:	854a                	mv	a0,s2
 55a:	f6dff0ef          	jal	4c6 <putc>
  while(--i >= 0)
 55e:	39fd                	addiw	s3,s3,-1
 560:	14fd                	addi	s1,s1,-1
 562:	fe09d9e3          	bgez	s3,554 <printint+0x70>
}
 566:	60a6                	ld	ra,72(sp)
 568:	6406                	ld	s0,64(sp)
 56a:	74e2                	ld	s1,56(sp)
 56c:	7942                	ld	s2,48(sp)
 56e:	79a2                	ld	s3,40(sp)
 570:	6161                	addi	sp,sp,80
 572:	8082                	ret
    x = -xx;
 574:	40b005bb          	negw	a1,a1
    neg = 1;
 578:	4e05                	li	t3,1
    x = -xx;
 57a:	b751                	j	4fe <printint+0x1a>

000000000000057c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 57c:	711d                	addi	sp,sp,-96
 57e:	ec86                	sd	ra,88(sp)
 580:	e8a2                	sd	s0,80(sp)
 582:	e4a6                	sd	s1,72(sp)
 584:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 586:	0005c483          	lbu	s1,0(a1)
 58a:	28048463          	beqz	s1,812 <vprintf+0x296>
 58e:	e0ca                	sd	s2,64(sp)
 590:	fc4e                	sd	s3,56(sp)
 592:	f852                	sd	s4,48(sp)
 594:	f456                	sd	s5,40(sp)
 596:	f05a                	sd	s6,32(sp)
 598:	ec5e                	sd	s7,24(sp)
 59a:	e862                	sd	s8,16(sp)
 59c:	e466                	sd	s9,8(sp)
 59e:	8b2a                	mv	s6,a0
 5a0:	8a2e                	mv	s4,a1
 5a2:	8bb2                	mv	s7,a2
  state = 0;
 5a4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5a6:	4901                	li	s2,0
 5a8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5aa:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5ae:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5b2:	06c00c93          	li	s9,108
 5b6:	a00d                	j	5d8 <vprintf+0x5c>
        putc(fd, c0);
 5b8:	85a6                	mv	a1,s1
 5ba:	855a                	mv	a0,s6
 5bc:	f0bff0ef          	jal	4c6 <putc>
 5c0:	a019                	j	5c6 <vprintf+0x4a>
    } else if(state == '%'){
 5c2:	03598363          	beq	s3,s5,5e8 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 5c6:	0019079b          	addiw	a5,s2,1
 5ca:	893e                	mv	s2,a5
 5cc:	873e                	mv	a4,a5
 5ce:	97d2                	add	a5,a5,s4
 5d0:	0007c483          	lbu	s1,0(a5)
 5d4:	22048763          	beqz	s1,802 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 5d8:	0004879b          	sext.w	a5,s1
    if(state == 0){
 5dc:	fe0993e3          	bnez	s3,5c2 <vprintf+0x46>
      if(c0 == '%'){
 5e0:	fd579ce3          	bne	a5,s5,5b8 <vprintf+0x3c>
        state = '%';
 5e4:	89be                	mv	s3,a5
 5e6:	b7c5                	j	5c6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5e8:	00ea06b3          	add	a3,s4,a4
 5ec:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5f0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5f2:	c681                	beqz	a3,5fa <vprintf+0x7e>
 5f4:	9752                	add	a4,a4,s4
 5f6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5fa:	05878263          	beq	a5,s8,63e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5fe:	05978c63          	beq	a5,s9,656 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 602:	07500713          	li	a4,117
 606:	0ee78663          	beq	a5,a4,6f2 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 60a:	07800713          	li	a4,120
 60e:	12e78863          	beq	a5,a4,73e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 612:	07000713          	li	a4,112
 616:	14e78d63          	beq	a5,a4,770 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 61a:	06300713          	li	a4,99
 61e:	18e78c63          	beq	a5,a4,7b6 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 622:	07300713          	li	a4,115
 626:	1ae78263          	beq	a5,a4,7ca <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 62a:	02500713          	li	a4,37
 62e:	04e79463          	bne	a5,a4,676 <vprintf+0xfa>
        putc(fd, '%');
 632:	85ba                	mv	a1,a4
 634:	855a                	mv	a0,s6
 636:	e91ff0ef          	jal	4c6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 63a:	4981                	li	s3,0
 63c:	b769                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 63e:	008b8493          	addi	s1,s7,8
 642:	4685                	li	a3,1
 644:	4629                	li	a2,10
 646:	000ba583          	lw	a1,0(s7)
 64a:	855a                	mv	a0,s6
 64c:	e99ff0ef          	jal	4e4 <printint>
 650:	8ba6                	mv	s7,s1
      state = 0;
 652:	4981                	li	s3,0
 654:	bf8d                	j	5c6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 656:	06400793          	li	a5,100
 65a:	02f68963          	beq	a3,a5,68c <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 65e:	06c00793          	li	a5,108
 662:	04f68263          	beq	a3,a5,6a6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 666:	07500793          	li	a5,117
 66a:	0af68063          	beq	a3,a5,70a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 66e:	07800793          	li	a5,120
 672:	0ef68263          	beq	a3,a5,756 <vprintf+0x1da>
        putc(fd, '%');
 676:	02500593          	li	a1,37
 67a:	855a                	mv	a0,s6
 67c:	e4bff0ef          	jal	4c6 <putc>
        putc(fd, c0);
 680:	85a6                	mv	a1,s1
 682:	855a                	mv	a0,s6
 684:	e43ff0ef          	jal	4c6 <putc>
      state = 0;
 688:	4981                	li	s3,0
 68a:	bf35                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 68c:	008b8493          	addi	s1,s7,8
 690:	4685                	li	a3,1
 692:	4629                	li	a2,10
 694:	000bb583          	ld	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	e4bff0ef          	jal	4e4 <printint>
        i += 1;
 69e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a0:	8ba6                	mv	s7,s1
      state = 0;
 6a2:	4981                	li	s3,0
        i += 1;
 6a4:	b70d                	j	5c6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6a6:	06400793          	li	a5,100
 6aa:	02f60763          	beq	a2,a5,6d8 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6ae:	07500793          	li	a5,117
 6b2:	06f60963          	beq	a2,a5,724 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6b6:	07800793          	li	a5,120
 6ba:	faf61ee3          	bne	a2,a5,676 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4641                	li	a2,16
 6c6:	000bb583          	ld	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	e19ff0ef          	jal	4e4 <printint>
        i += 2;
 6d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
        i += 2;
 6d6:	bdc5                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d8:	008b8493          	addi	s1,s7,8
 6dc:	4685                	li	a3,1
 6de:	4629                	li	a2,10
 6e0:	000bb583          	ld	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	dffff0ef          	jal	4e4 <printint>
        i += 2;
 6ea:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ec:	8ba6                	mv	s7,s1
      state = 0;
 6ee:	4981                	li	s3,0
        i += 2;
 6f0:	bdd9                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6f2:	008b8493          	addi	s1,s7,8
 6f6:	4681                	li	a3,0
 6f8:	4629                	li	a2,10
 6fa:	000be583          	lwu	a1,0(s7)
 6fe:	855a                	mv	a0,s6
 700:	de5ff0ef          	jal	4e4 <printint>
 704:	8ba6                	mv	s7,s1
      state = 0;
 706:	4981                	li	s3,0
 708:	bd7d                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 70a:	008b8493          	addi	s1,s7,8
 70e:	4681                	li	a3,0
 710:	4629                	li	a2,10
 712:	000bb583          	ld	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	dcdff0ef          	jal	4e4 <printint>
        i += 1;
 71c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 71e:	8ba6                	mv	s7,s1
      state = 0;
 720:	4981                	li	s3,0
        i += 1;
 722:	b555                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	008b8493          	addi	s1,s7,8
 728:	4681                	li	a3,0
 72a:	4629                	li	a2,10
 72c:	000bb583          	ld	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	db3ff0ef          	jal	4e4 <printint>
        i += 2;
 736:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 738:	8ba6                	mv	s7,s1
      state = 0;
 73a:	4981                	li	s3,0
        i += 2;
 73c:	b569                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 73e:	008b8493          	addi	s1,s7,8
 742:	4681                	li	a3,0
 744:	4641                	li	a2,16
 746:	000be583          	lwu	a1,0(s7)
 74a:	855a                	mv	a0,s6
 74c:	d99ff0ef          	jal	4e4 <printint>
 750:	8ba6                	mv	s7,s1
      state = 0;
 752:	4981                	li	s3,0
 754:	bd8d                	j	5c6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 756:	008b8493          	addi	s1,s7,8
 75a:	4681                	li	a3,0
 75c:	4641                	li	a2,16
 75e:	000bb583          	ld	a1,0(s7)
 762:	855a                	mv	a0,s6
 764:	d81ff0ef          	jal	4e4 <printint>
        i += 1;
 768:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 76a:	8ba6                	mv	s7,s1
      state = 0;
 76c:	4981                	li	s3,0
        i += 1;
 76e:	bda1                	j	5c6 <vprintf+0x4a>
 770:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 772:	008b8d13          	addi	s10,s7,8
 776:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 77a:	03000593          	li	a1,48
 77e:	855a                	mv	a0,s6
 780:	d47ff0ef          	jal	4c6 <putc>
  putc(fd, 'x');
 784:	07800593          	li	a1,120
 788:	855a                	mv	a0,s6
 78a:	d3dff0ef          	jal	4c6 <putc>
 78e:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 790:	00000b97          	auipc	s7,0x0
 794:	2b0b8b93          	addi	s7,s7,688 # a40 <digits>
 798:	03c9d793          	srli	a5,s3,0x3c
 79c:	97de                	add	a5,a5,s7
 79e:	0007c583          	lbu	a1,0(a5)
 7a2:	855a                	mv	a0,s6
 7a4:	d23ff0ef          	jal	4c6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a8:	0992                	slli	s3,s3,0x4
 7aa:	34fd                	addiw	s1,s1,-1
 7ac:	f4f5                	bnez	s1,798 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7ae:	8bea                	mv	s7,s10
      state = 0;
 7b0:	4981                	li	s3,0
 7b2:	6d02                	ld	s10,0(sp)
 7b4:	bd09                	j	5c6 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7b6:	008b8493          	addi	s1,s7,8
 7ba:	000bc583          	lbu	a1,0(s7)
 7be:	855a                	mv	a0,s6
 7c0:	d07ff0ef          	jal	4c6 <putc>
 7c4:	8ba6                	mv	s7,s1
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	bbfd                	j	5c6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7ca:	008b8993          	addi	s3,s7,8
 7ce:	000bb483          	ld	s1,0(s7)
 7d2:	cc91                	beqz	s1,7ee <vprintf+0x272>
        for(; *s; s++)
 7d4:	0004c583          	lbu	a1,0(s1)
 7d8:	c195                	beqz	a1,7fc <vprintf+0x280>
          putc(fd, *s);
 7da:	855a                	mv	a0,s6
 7dc:	cebff0ef          	jal	4c6 <putc>
        for(; *s; s++)
 7e0:	0485                	addi	s1,s1,1
 7e2:	0004c583          	lbu	a1,0(s1)
 7e6:	f9f5                	bnez	a1,7da <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 7e8:	8bce                	mv	s7,s3
      state = 0;
 7ea:	4981                	li	s3,0
 7ec:	bbe9                	j	5c6 <vprintf+0x4a>
          s = "(null)";
 7ee:	00000497          	auipc	s1,0x0
 7f2:	24a48493          	addi	s1,s1,586 # a38 <malloc+0x13a>
        for(; *s; s++)
 7f6:	02800593          	li	a1,40
 7fa:	b7c5                	j	7da <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 7fc:	8bce                	mv	s7,s3
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b3d9                	j	5c6 <vprintf+0x4a>
 802:	6906                	ld	s2,64(sp)
 804:	79e2                	ld	s3,56(sp)
 806:	7a42                	ld	s4,48(sp)
 808:	7aa2                	ld	s5,40(sp)
 80a:	7b02                	ld	s6,32(sp)
 80c:	6be2                	ld	s7,24(sp)
 80e:	6c42                	ld	s8,16(sp)
 810:	6ca2                	ld	s9,8(sp)
    }
  }
}
 812:	60e6                	ld	ra,88(sp)
 814:	6446                	ld	s0,80(sp)
 816:	64a6                	ld	s1,72(sp)
 818:	6125                	addi	sp,sp,96
 81a:	8082                	ret

000000000000081c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 81c:	715d                	addi	sp,sp,-80
 81e:	ec06                	sd	ra,24(sp)
 820:	e822                	sd	s0,16(sp)
 822:	1000                	addi	s0,sp,32
 824:	e010                	sd	a2,0(s0)
 826:	e414                	sd	a3,8(s0)
 828:	e818                	sd	a4,16(s0)
 82a:	ec1c                	sd	a5,24(s0)
 82c:	03043023          	sd	a6,32(s0)
 830:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 834:	8622                	mv	a2,s0
 836:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 83a:	d43ff0ef          	jal	57c <vprintf>
}
 83e:	60e2                	ld	ra,24(sp)
 840:	6442                	ld	s0,16(sp)
 842:	6161                	addi	sp,sp,80
 844:	8082                	ret

0000000000000846 <printf>:

void
printf(const char *fmt, ...)
{
 846:	711d                	addi	sp,sp,-96
 848:	ec06                	sd	ra,24(sp)
 84a:	e822                	sd	s0,16(sp)
 84c:	1000                	addi	s0,sp,32
 84e:	e40c                	sd	a1,8(s0)
 850:	e810                	sd	a2,16(s0)
 852:	ec14                	sd	a3,24(s0)
 854:	f018                	sd	a4,32(s0)
 856:	f41c                	sd	a5,40(s0)
 858:	03043823          	sd	a6,48(s0)
 85c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 860:	00840613          	addi	a2,s0,8
 864:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 868:	85aa                	mv	a1,a0
 86a:	4505                	li	a0,1
 86c:	d11ff0ef          	jal	57c <vprintf>
}
 870:	60e2                	ld	ra,24(sp)
 872:	6442                	ld	s0,16(sp)
 874:	6125                	addi	sp,sp,96
 876:	8082                	ret

0000000000000878 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 878:	1141                	addi	sp,sp,-16
 87a:	e406                	sd	ra,8(sp)
 87c:	e022                	sd	s0,0(sp)
 87e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 880:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 884:	00000797          	auipc	a5,0x0
 888:	77c7b783          	ld	a5,1916(a5) # 1000 <freep>
 88c:	a02d                	j	8b6 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 88e:	4618                	lw	a4,8(a2)
 890:	9f2d                	addw	a4,a4,a1
 892:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 896:	6398                	ld	a4,0(a5)
 898:	6310                	ld	a2,0(a4)
 89a:	a83d                	j	8d8 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 89c:	ff852703          	lw	a4,-8(a0)
 8a0:	9f31                	addw	a4,a4,a2
 8a2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8a4:	ff053683          	ld	a3,-16(a0)
 8a8:	a091                	j	8ec <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8aa:	6398                	ld	a4,0(a5)
 8ac:	00e7e463          	bltu	a5,a4,8b4 <free+0x3c>
 8b0:	00e6ea63          	bltu	a3,a4,8c4 <free+0x4c>
{
 8b4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b6:	fed7fae3          	bgeu	a5,a3,8aa <free+0x32>
 8ba:	6398                	ld	a4,0(a5)
 8bc:	00e6e463          	bltu	a3,a4,8c4 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c0:	fee7eae3          	bltu	a5,a4,8b4 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 8c4:	ff852583          	lw	a1,-8(a0)
 8c8:	6390                	ld	a2,0(a5)
 8ca:	02059813          	slli	a6,a1,0x20
 8ce:	01c85713          	srli	a4,a6,0x1c
 8d2:	9736                	add	a4,a4,a3
 8d4:	fae60de3          	beq	a2,a4,88e <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 8d8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8dc:	4790                	lw	a2,8(a5)
 8de:	02061593          	slli	a1,a2,0x20
 8e2:	01c5d713          	srli	a4,a1,0x1c
 8e6:	973e                	add	a4,a4,a5
 8e8:	fae68ae3          	beq	a3,a4,89c <free+0x24>
    p->s.ptr = bp->s.ptr;
 8ec:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8ee:	00000717          	auipc	a4,0x0
 8f2:	70f73923          	sd	a5,1810(a4) # 1000 <freep>
}
 8f6:	60a2                	ld	ra,8(sp)
 8f8:	6402                	ld	s0,0(sp)
 8fa:	0141                	addi	sp,sp,16
 8fc:	8082                	ret

00000000000008fe <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8fe:	7139                	addi	sp,sp,-64
 900:	fc06                	sd	ra,56(sp)
 902:	f822                	sd	s0,48(sp)
 904:	f04a                	sd	s2,32(sp)
 906:	ec4e                	sd	s3,24(sp)
 908:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 90a:	02051993          	slli	s3,a0,0x20
 90e:	0209d993          	srli	s3,s3,0x20
 912:	09bd                	addi	s3,s3,15
 914:	0049d993          	srli	s3,s3,0x4
 918:	2985                	addiw	s3,s3,1
 91a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 91c:	00000517          	auipc	a0,0x0
 920:	6e453503          	ld	a0,1764(a0) # 1000 <freep>
 924:	c905                	beqz	a0,954 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 926:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 928:	4798                	lw	a4,8(a5)
 92a:	09377663          	bgeu	a4,s3,9b6 <malloc+0xb8>
 92e:	f426                	sd	s1,40(sp)
 930:	e852                	sd	s4,16(sp)
 932:	e456                	sd	s5,8(sp)
 934:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 936:	8a4e                	mv	s4,s3
 938:	6705                	lui	a4,0x1
 93a:	00e9f363          	bgeu	s3,a4,940 <malloc+0x42>
 93e:	6a05                	lui	s4,0x1
 940:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 944:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 948:	00000497          	auipc	s1,0x0
 94c:	6b848493          	addi	s1,s1,1720 # 1000 <freep>
  if(p == SBRK_ERROR)
 950:	5afd                	li	s5,-1
 952:	a83d                	j	990 <malloc+0x92>
 954:	f426                	sd	s1,40(sp)
 956:	e852                	sd	s4,16(sp)
 958:	e456                	sd	s5,8(sp)
 95a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 95c:	00001797          	auipc	a5,0x1
 960:	8b478793          	addi	a5,a5,-1868 # 1210 <base>
 964:	00000717          	auipc	a4,0x0
 968:	68f73e23          	sd	a5,1692(a4) # 1000 <freep>
 96c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 96e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 972:	b7d1                	j	936 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 974:	6398                	ld	a4,0(a5)
 976:	e118                	sd	a4,0(a0)
 978:	a899                	j	9ce <malloc+0xd0>
  hp->s.size = nu;
 97a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 97e:	0541                	addi	a0,a0,16
 980:	ef9ff0ef          	jal	878 <free>
  return freep;
 984:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 986:	c125                	beqz	a0,9e6 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 988:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98a:	4798                	lw	a4,8(a5)
 98c:	03277163          	bgeu	a4,s2,9ae <malloc+0xb0>
    if(p == freep)
 990:	6098                	ld	a4,0(s1)
 992:	853e                	mv	a0,a5
 994:	fef71ae3          	bne	a4,a5,988 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 998:	8552                	mv	a0,s4
 99a:	a59ff0ef          	jal	3f2 <sbrk>
  if(p == SBRK_ERROR)
 99e:	fd551ee3          	bne	a0,s5,97a <malloc+0x7c>
        return 0;
 9a2:	4501                	li	a0,0
 9a4:	74a2                	ld	s1,40(sp)
 9a6:	6a42                	ld	s4,16(sp)
 9a8:	6aa2                	ld	s5,8(sp)
 9aa:	6b02                	ld	s6,0(sp)
 9ac:	a03d                	j	9da <malloc+0xdc>
 9ae:	74a2                	ld	s1,40(sp)
 9b0:	6a42                	ld	s4,16(sp)
 9b2:	6aa2                	ld	s5,8(sp)
 9b4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9b6:	fae90fe3          	beq	s2,a4,974 <malloc+0x76>
        p->s.size -= nunits;
 9ba:	4137073b          	subw	a4,a4,s3
 9be:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9c0:	02071693          	slli	a3,a4,0x20
 9c4:	01c6d713          	srli	a4,a3,0x1c
 9c8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ca:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ce:	00000717          	auipc	a4,0x0
 9d2:	62a73923          	sd	a0,1586(a4) # 1000 <freep>
      return (void*)(p + 1);
 9d6:	01078513          	addi	a0,a5,16
  }
}
 9da:	70e2                	ld	ra,56(sp)
 9dc:	7442                	ld	s0,48(sp)
 9de:	7902                	ld	s2,32(sp)
 9e0:	69e2                	ld	s3,24(sp)
 9e2:	6121                	addi	sp,sp,64
 9e4:	8082                	ret
 9e6:	74a2                	ld	s1,40(sp)
 9e8:	6a42                	ld	s4,16(sp)
 9ea:	6aa2                	ld	s5,8(sp)
 9ec:	6b02                	ld	s6,0(sp)
 9ee:	b7f5                	j	9da <malloc+0xdc>
