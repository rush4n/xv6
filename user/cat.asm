
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  12:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  14:	00001917          	auipc	s2,0x1
  18:	ffc90913          	addi	s2,s2,-4 # 1010 <buf>
  1c:	20000a13          	li	s4,512
    if (write(1, buf, n) != n) {
  20:	4a85                	li	s5,1
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  22:	8652                	mv	a2,s4
  24:	85ca                	mv	a1,s2
  26:	854e                	mv	a0,s3
  28:	3b0000ef          	jal	3d8 <read>
  2c:	84aa                	mv	s1,a0
  2e:	02a05363          	blez	a0,54 <cat+0x54>
    if (write(1, buf, n) != n) {
  32:	8626                	mv	a2,s1
  34:	85ca                	mv	a1,s2
  36:	8556                	mv	a0,s5
  38:	3a8000ef          	jal	3e0 <write>
  3c:	fe9503e3          	beq	a0,s1,22 <cat+0x22>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	95058593          	addi	a1,a1,-1712 # 990 <malloc+0xf8>
  48:	4509                	li	a0,2
  4a:	76c000ef          	jal	7b6 <fprintf>
      exit(1);
  4e:	4505                	li	a0,1
  50:	370000ef          	jal	3c0 <exit>
    }
  }
  if(n < 0){
  54:	00054b63          	bltz	a0,6a <cat+0x6a>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  58:	70e2                	ld	ra,56(sp)
  5a:	7442                	ld	s0,48(sp)
  5c:	74a2                	ld	s1,40(sp)
  5e:	7902                	ld	s2,32(sp)
  60:	69e2                	ld	s3,24(sp)
  62:	6a42                	ld	s4,16(sp)
  64:	6aa2                	ld	s5,8(sp)
  66:	6121                	addi	sp,sp,64
  68:	8082                	ret
    fprintf(2, "cat: read error\n");
  6a:	00001597          	auipc	a1,0x1
  6e:	93e58593          	addi	a1,a1,-1730 # 9a8 <malloc+0x110>
  72:	4509                	li	a0,2
  74:	742000ef          	jal	7b6 <fprintf>
    exit(1);
  78:	4505                	li	a0,1
  7a:	346000ef          	jal	3c0 <exit>

000000000000007e <main>:

int
main(int argc, char *argv[])
{
  7e:	7179                	addi	sp,sp,-48
  80:	f406                	sd	ra,40(sp)
  82:	f022                	sd	s0,32(sp)
  84:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  86:	4785                	li	a5,1
  88:	04a7d263          	bge	a5,a0,cc <main+0x4e>
  8c:	ec26                	sd	s1,24(sp)
  8e:	e84a                	sd	s2,16(sp)
  90:	e44e                	sd	s3,8(sp)
  92:	00858913          	addi	s2,a1,8
  96:	ffe5099b          	addiw	s3,a0,-2
  9a:	02099793          	slli	a5,s3,0x20
  9e:	01d7d993          	srli	s3,a5,0x1d
  a2:	05c1                	addi	a1,a1,16
  a4:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], O_RDONLY)) < 0){
  a6:	4581                	li	a1,0
  a8:	00093503          	ld	a0,0(s2)
  ac:	354000ef          	jal	400 <open>
  b0:	84aa                	mv	s1,a0
  b2:	02054663          	bltz	a0,de <main+0x60>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  b6:	f4bff0ef          	jal	0 <cat>
    close(fd);
  ba:	8526                	mv	a0,s1
  bc:	32c000ef          	jal	3e8 <close>
  for(i = 1; i < argc; i++){
  c0:	0921                	addi	s2,s2,8
  c2:	ff3912e3          	bne	s2,s3,a6 <main+0x28>
  }
  exit(0);
  c6:	4501                	li	a0,0
  c8:	2f8000ef          	jal	3c0 <exit>
  cc:	ec26                	sd	s1,24(sp)
  ce:	e84a                	sd	s2,16(sp)
  d0:	e44e                	sd	s3,8(sp)
    cat(0);
  d2:	4501                	li	a0,0
  d4:	f2dff0ef          	jal	0 <cat>
    exit(0);
  d8:	4501                	li	a0,0
  da:	2e6000ef          	jal	3c0 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  de:	00093603          	ld	a2,0(s2)
  e2:	00001597          	auipc	a1,0x1
  e6:	8de58593          	addi	a1,a1,-1826 # 9c0 <malloc+0x128>
  ea:	4509                	li	a0,2
  ec:	6ca000ef          	jal	7b6 <fprintf>
      exit(1);
  f0:	4505                	li	a0,1
  f2:	2ce000ef          	jal	3c0 <exit>

00000000000000f6 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
  f6:	1141                	addi	sp,sp,-16
  f8:	e406                	sd	ra,8(sp)
  fa:	e022                	sd	s0,0(sp)
  fc:	0800                	addi	s0,sp,16
  extern int main();
  main();
  fe:	f81ff0ef          	jal	7e <main>
  exit(0);
 102:	4501                	li	a0,0
 104:	2bc000ef          	jal	3c0 <exit>

0000000000000108 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 108:	1141                	addi	sp,sp,-16
 10a:	e406                	sd	ra,8(sp)
 10c:	e022                	sd	s0,0(sp)
 10e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 110:	87aa                	mv	a5,a0
 112:	0585                	addi	a1,a1,1
 114:	0785                	addi	a5,a5,1
 116:	fff5c703          	lbu	a4,-1(a1)
 11a:	fee78fa3          	sb	a4,-1(a5)
 11e:	fb75                	bnez	a4,112 <strcpy+0xa>
    ;
  return os;
}
 120:	60a2                	ld	ra,8(sp)
 122:	6402                	ld	s0,0(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e406                	sd	ra,8(sp)
 12c:	e022                	sd	s0,0(sp)
 12e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 130:	00054783          	lbu	a5,0(a0)
 134:	cb91                	beqz	a5,148 <strcmp+0x20>
 136:	0005c703          	lbu	a4,0(a1)
 13a:	00f71763          	bne	a4,a5,148 <strcmp+0x20>
    p++, q++;
 13e:	0505                	addi	a0,a0,1
 140:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 142:	00054783          	lbu	a5,0(a0)
 146:	fbe5                	bnez	a5,136 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 148:	0005c503          	lbu	a0,0(a1)
}
 14c:	40a7853b          	subw	a0,a5,a0
 150:	60a2                	ld	ra,8(sp)
 152:	6402                	ld	s0,0(sp)
 154:	0141                	addi	sp,sp,16
 156:	8082                	ret

0000000000000158 <strlen>:

uint
strlen(const char *s)
{
 158:	1141                	addi	sp,sp,-16
 15a:	e406                	sd	ra,8(sp)
 15c:	e022                	sd	s0,0(sp)
 15e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 160:	00054783          	lbu	a5,0(a0)
 164:	cf99                	beqz	a5,182 <strlen+0x2a>
 166:	0505                	addi	a0,a0,1
 168:	87aa                	mv	a5,a0
 16a:	86be                	mv	a3,a5
 16c:	0785                	addi	a5,a5,1
 16e:	fff7c703          	lbu	a4,-1(a5)
 172:	ff65                	bnez	a4,16a <strlen+0x12>
 174:	40a6853b          	subw	a0,a3,a0
 178:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 17a:	60a2                	ld	ra,8(sp)
 17c:	6402                	ld	s0,0(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  for(n = 0; s[n]; n++)
 182:	4501                	li	a0,0
 184:	bfdd                	j	17a <strlen+0x22>

0000000000000186 <memset>:

void*
memset(void *dst, int c, uint n)
{
 186:	1141                	addi	sp,sp,-16
 188:	e406                	sd	ra,8(sp)
 18a:	e022                	sd	s0,0(sp)
 18c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18e:	ca19                	beqz	a2,1a4 <memset+0x1e>
 190:	87aa                	mv	a5,a0
 192:	1602                	slli	a2,a2,0x20
 194:	9201                	srli	a2,a2,0x20
 196:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 19a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19e:	0785                	addi	a5,a5,1
 1a0:	fee79de3          	bne	a5,a4,19a <memset+0x14>
  }
  return dst;
}
 1a4:	60a2                	ld	ra,8(sp)
 1a6:	6402                	ld	s0,0(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <strchr>:

char*
strchr(const char *s, char c)
{
 1ac:	1141                	addi	sp,sp,-16
 1ae:	e406                	sd	ra,8(sp)
 1b0:	e022                	sd	s0,0(sp)
 1b2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1b4:	00054783          	lbu	a5,0(a0)
 1b8:	cf81                	beqz	a5,1d0 <strchr+0x24>
    if(*s == c)
 1ba:	00f58763          	beq	a1,a5,1c8 <strchr+0x1c>
  for(; *s; s++)
 1be:	0505                	addi	a0,a0,1
 1c0:	00054783          	lbu	a5,0(a0)
 1c4:	fbfd                	bnez	a5,1ba <strchr+0xe>
      return (char*)s;
  return 0;
 1c6:	4501                	li	a0,0
}
 1c8:	60a2                	ld	ra,8(sp)
 1ca:	6402                	ld	s0,0(sp)
 1cc:	0141                	addi	sp,sp,16
 1ce:	8082                	ret
  return 0;
 1d0:	4501                	li	a0,0
 1d2:	bfdd                	j	1c8 <strchr+0x1c>

00000000000001d4 <gets>:

char*
gets(char *buf, int max)
{
 1d4:	7159                	addi	sp,sp,-112
 1d6:	f486                	sd	ra,104(sp)
 1d8:	f0a2                	sd	s0,96(sp)
 1da:	eca6                	sd	s1,88(sp)
 1dc:	e8ca                	sd	s2,80(sp)
 1de:	e4ce                	sd	s3,72(sp)
 1e0:	e0d2                	sd	s4,64(sp)
 1e2:	fc56                	sd	s5,56(sp)
 1e4:	f85a                	sd	s6,48(sp)
 1e6:	f45e                	sd	s7,40(sp)
 1e8:	f062                	sd	s8,32(sp)
 1ea:	ec66                	sd	s9,24(sp)
 1ec:	e86a                	sd	s10,16(sp)
 1ee:	1880                	addi	s0,sp,112
 1f0:	8caa                	mv	s9,a0
 1f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f4:	892a                	mv	s2,a0
 1f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
 1f8:	f9f40b13          	addi	s6,s0,-97
 1fc:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1fe:	4ba9                	li	s7,10
 200:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 202:	8d26                	mv	s10,s1
 204:	0014899b          	addiw	s3,s1,1
 208:	84ce                	mv	s1,s3
 20a:	0349d563          	bge	s3,s4,234 <gets+0x60>
    cc = read(0, &c, 1);
 20e:	8656                	mv	a2,s5
 210:	85da                	mv	a1,s6
 212:	4501                	li	a0,0
 214:	1c4000ef          	jal	3d8 <read>
    if(cc < 1)
 218:	00a05e63          	blez	a0,234 <gets+0x60>
    buf[i++] = c;
 21c:	f9f44783          	lbu	a5,-97(s0)
 220:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 224:	01778763          	beq	a5,s7,232 <gets+0x5e>
 228:	0905                	addi	s2,s2,1
 22a:	fd879ce3          	bne	a5,s8,202 <gets+0x2e>
    buf[i++] = c;
 22e:	8d4e                	mv	s10,s3
 230:	a011                	j	234 <gets+0x60>
 232:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 234:	9d66                	add	s10,s10,s9
 236:	000d0023          	sb	zero,0(s10)
  return buf;
}
 23a:	8566                	mv	a0,s9
 23c:	70a6                	ld	ra,104(sp)
 23e:	7406                	ld	s0,96(sp)
 240:	64e6                	ld	s1,88(sp)
 242:	6946                	ld	s2,80(sp)
 244:	69a6                	ld	s3,72(sp)
 246:	6a06                	ld	s4,64(sp)
 248:	7ae2                	ld	s5,56(sp)
 24a:	7b42                	ld	s6,48(sp)
 24c:	7ba2                	ld	s7,40(sp)
 24e:	7c02                	ld	s8,32(sp)
 250:	6ce2                	ld	s9,24(sp)
 252:	6d42                	ld	s10,16(sp)
 254:	6165                	addi	sp,sp,112
 256:	8082                	ret

0000000000000258 <stat>:

int
stat(const char *n, struct stat *st)
{
 258:	1101                	addi	sp,sp,-32
 25a:	ec06                	sd	ra,24(sp)
 25c:	e822                	sd	s0,16(sp)
 25e:	e04a                	sd	s2,0(sp)
 260:	1000                	addi	s0,sp,32
 262:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 264:	4581                	li	a1,0
 266:	19a000ef          	jal	400 <open>
  if(fd < 0)
 26a:	02054263          	bltz	a0,28e <stat+0x36>
 26e:	e426                	sd	s1,8(sp)
 270:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 272:	85ca                	mv	a1,s2
 274:	1a4000ef          	jal	418 <fstat>
 278:	892a                	mv	s2,a0
  close(fd);
 27a:	8526                	mv	a0,s1
 27c:	16c000ef          	jal	3e8 <close>
  return r;
 280:	64a2                	ld	s1,8(sp)
}
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	6902                	ld	s2,0(sp)
 28a:	6105                	addi	sp,sp,32
 28c:	8082                	ret
    return -1;
 28e:	597d                	li	s2,-1
 290:	bfcd                	j	282 <stat+0x2a>

0000000000000292 <atoi>:

int
atoi(const char *s)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	00054683          	lbu	a3,0(a0)
 29e:	fd06879b          	addiw	a5,a3,-48
 2a2:	0ff7f793          	zext.b	a5,a5
 2a6:	4625                	li	a2,9
 2a8:	02f66963          	bltu	a2,a5,2da <atoi+0x48>
 2ac:	872a                	mv	a4,a0
  n = 0;
 2ae:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 2b0:	0705                	addi	a4,a4,1
 2b2:	0025179b          	slliw	a5,a0,0x2
 2b6:	9fa9                	addw	a5,a5,a0
 2b8:	0017979b          	slliw	a5,a5,0x1
 2bc:	9fb5                	addw	a5,a5,a3
 2be:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c2:	00074683          	lbu	a3,0(a4)
 2c6:	fd06879b          	addiw	a5,a3,-48
 2ca:	0ff7f793          	zext.b	a5,a5
 2ce:	fef671e3          	bgeu	a2,a5,2b0 <atoi+0x1e>
  return n;
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  n = 0;
 2da:	4501                	li	a0,0
 2dc:	bfdd                	j	2d2 <atoi+0x40>

00000000000002de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e406                	sd	ra,8(sp)
 2e2:	e022                	sd	s0,0(sp)
 2e4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e6:	02b57563          	bgeu	a0,a1,310 <memmove+0x32>
    while(n-- > 0)
 2ea:	00c05f63          	blez	a2,308 <memmove+0x2a>
 2ee:	1602                	slli	a2,a2,0x20
 2f0:	9201                	srli	a2,a2,0x20
 2f2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2f6:	872a                	mv	a4,a0
      *dst++ = *src++;
 2f8:	0585                	addi	a1,a1,1
 2fa:	0705                	addi	a4,a4,1
 2fc:	fff5c683          	lbu	a3,-1(a1)
 300:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 304:	fee79ae3          	bne	a5,a4,2f8 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 316:	fec059e3          	blez	a2,308 <memmove+0x2a>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 334:	fef71ae3          	bne	a4,a5,328 <memmove+0x4a>
 338:	bfc1                	j	308 <memmove+0x2a>

000000000000033a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 342:	ca0d                	beqz	a2,374 <memcmp+0x3a>
 344:	fff6069b          	addiw	a3,a2,-1
 348:	1682                	slli	a3,a3,0x20
 34a:	9281                	srli	a3,a3,0x20
 34c:	0685                	addi	a3,a3,1
 34e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 350:	00054783          	lbu	a5,0(a0)
 354:	0005c703          	lbu	a4,0(a1)
 358:	00e79863          	bne	a5,a4,368 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 35c:	0505                	addi	a0,a0,1
    p2++;
 35e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 360:	fed518e3          	bne	a0,a3,350 <memcmp+0x16>
  }
  return 0;
 364:	4501                	li	a0,0
 366:	a019                	j	36c <memcmp+0x32>
      return *p1 - *p2;
 368:	40e7853b          	subw	a0,a5,a4
}
 36c:	60a2                	ld	ra,8(sp)
 36e:	6402                	ld	s0,0(sp)
 370:	0141                	addi	sp,sp,16
 372:	8082                	ret
  return 0;
 374:	4501                	li	a0,0
 376:	bfdd                	j	36c <memcmp+0x32>

0000000000000378 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 378:	1141                	addi	sp,sp,-16
 37a:	e406                	sd	ra,8(sp)
 37c:	e022                	sd	s0,0(sp)
 37e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 380:	f5fff0ef          	jal	2de <memmove>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <sbrk>:

char *
sbrk(int n) {
 38c:	1141                	addi	sp,sp,-16
 38e:	e406                	sd	ra,8(sp)
 390:	e022                	sd	s0,0(sp)
 392:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 394:	4585                	li	a1,1
 396:	0b2000ef          	jal	448 <sys_sbrk>
}
 39a:	60a2                	ld	ra,8(sp)
 39c:	6402                	ld	s0,0(sp)
 39e:	0141                	addi	sp,sp,16
 3a0:	8082                	ret

00000000000003a2 <sbrklazy>:

char *
sbrklazy(int n) {
 3a2:	1141                	addi	sp,sp,-16
 3a4:	e406                	sd	ra,8(sp)
 3a6:	e022                	sd	s0,0(sp)
 3a8:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 3aa:	4589                	li	a1,2
 3ac:	09c000ef          	jal	448 <sys_sbrk>
}
 3b0:	60a2                	ld	ra,8(sp)
 3b2:	6402                	ld	s0,0(sp)
 3b4:	0141                	addi	sp,sp,16
 3b6:	8082                	ret

00000000000003b8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3b8:	4885                	li	a7,1
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3c0:	4889                	li	a7,2
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3c8:	488d                	li	a7,3
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3d0:	4891                	li	a7,4
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <read>:
.global read
read:
 li a7, SYS_read
 3d8:	4895                	li	a7,5
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <write>:
.global write
write:
 li a7, SYS_write
 3e0:	48c1                	li	a7,16
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <close>:
.global close
close:
 li a7, SYS_close
 3e8:	48d5                	li	a7,21
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3f0:	4899                	li	a7,6
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3f8:	489d                	li	a7,7
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <open>:
.global open
open:
 li a7, SYS_open
 400:	48bd                	li	a7,15
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 408:	48c5                	li	a7,17
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 410:	48c9                	li	a7,18
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 418:	48a1                	li	a7,8
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <link>:
.global link
link:
 li a7, SYS_link
 420:	48cd                	li	a7,19
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 428:	48d1                	li	a7,20
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 430:	48a5                	li	a7,9
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <dup>:
.global dup
dup:
 li a7, SYS_dup
 438:	48a9                	li	a7,10
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 440:	48ad                	li	a7,11
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 448:	48b1                	li	a7,12
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <pause>:
.global pause
pause:
 li a7, SYS_pause
 450:	48b5                	li	a7,13
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 458:	48b9                	li	a7,14
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 460:	1101                	addi	sp,sp,-32
 462:	ec06                	sd	ra,24(sp)
 464:	e822                	sd	s0,16(sp)
 466:	1000                	addi	s0,sp,32
 468:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 46c:	4605                	li	a2,1
 46e:	fef40593          	addi	a1,s0,-17
 472:	f6fff0ef          	jal	3e0 <write>
}
 476:	60e2                	ld	ra,24(sp)
 478:	6442                	ld	s0,16(sp)
 47a:	6105                	addi	sp,sp,32
 47c:	8082                	ret

000000000000047e <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 47e:	715d                	addi	sp,sp,-80
 480:	e486                	sd	ra,72(sp)
 482:	e0a2                	sd	s0,64(sp)
 484:	fc26                	sd	s1,56(sp)
 486:	f84a                	sd	s2,48(sp)
 488:	f44e                	sd	s3,40(sp)
 48a:	0880                	addi	s0,sp,80
 48c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48e:	c299                	beqz	a3,494 <printint+0x16>
 490:	0605cf63          	bltz	a1,50e <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 494:	2581                	sext.w	a1,a1
  neg = 0;
 496:	4e01                	li	t3,0
  }

  i = 0;
 498:	fb840313          	addi	t1,s0,-72
  neg = 0;
 49c:	869a                	mv	a3,t1
  i = 0;
 49e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4a0:	00000817          	auipc	a6,0x0
 4a4:	54080813          	addi	a6,a6,1344 # 9e0 <digits>
 4a8:	88be                	mv	a7,a5
 4aa:	0017851b          	addiw	a0,a5,1
 4ae:	87aa                	mv	a5,a0
 4b0:	02c5f73b          	remuw	a4,a1,a2
 4b4:	1702                	slli	a4,a4,0x20
 4b6:	9301                	srli	a4,a4,0x20
 4b8:	9742                	add	a4,a4,a6
 4ba:	00074703          	lbu	a4,0(a4)
 4be:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4c2:	872e                	mv	a4,a1
 4c4:	02c5d5bb          	divuw	a1,a1,a2
 4c8:	0685                	addi	a3,a3,1
 4ca:	fcc77fe3          	bgeu	a4,a2,4a8 <printint+0x2a>
  if(neg)
 4ce:	000e0c63          	beqz	t3,4e6 <printint+0x68>
    buf[i++] = '-';
 4d2:	fd050793          	addi	a5,a0,-48
 4d6:	00878533          	add	a0,a5,s0
 4da:	02d00793          	li	a5,45
 4de:	fef50423          	sb	a5,-24(a0)
 4e2:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 4e6:	fff7899b          	addiw	s3,a5,-1
 4ea:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 4ee:	fff4c583          	lbu	a1,-1(s1)
 4f2:	854a                	mv	a0,s2
 4f4:	f6dff0ef          	jal	460 <putc>
  while(--i >= 0)
 4f8:	39fd                	addiw	s3,s3,-1
 4fa:	14fd                	addi	s1,s1,-1
 4fc:	fe09d9e3          	bgez	s3,4ee <printint+0x70>
}
 500:	60a6                	ld	ra,72(sp)
 502:	6406                	ld	s0,64(sp)
 504:	74e2                	ld	s1,56(sp)
 506:	7942                	ld	s2,48(sp)
 508:	79a2                	ld	s3,40(sp)
 50a:	6161                	addi	sp,sp,80
 50c:	8082                	ret
    x = -xx;
 50e:	40b005bb          	negw	a1,a1
    neg = 1;
 512:	4e05                	li	t3,1
    x = -xx;
 514:	b751                	j	498 <printint+0x1a>

0000000000000516 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 516:	711d                	addi	sp,sp,-96
 518:	ec86                	sd	ra,88(sp)
 51a:	e8a2                	sd	s0,80(sp)
 51c:	e4a6                	sd	s1,72(sp)
 51e:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 520:	0005c483          	lbu	s1,0(a1)
 524:	28048463          	beqz	s1,7ac <vprintf+0x296>
 528:	e0ca                	sd	s2,64(sp)
 52a:	fc4e                	sd	s3,56(sp)
 52c:	f852                	sd	s4,48(sp)
 52e:	f456                	sd	s5,40(sp)
 530:	f05a                	sd	s6,32(sp)
 532:	ec5e                	sd	s7,24(sp)
 534:	e862                	sd	s8,16(sp)
 536:	e466                	sd	s9,8(sp)
 538:	8b2a                	mv	s6,a0
 53a:	8a2e                	mv	s4,a1
 53c:	8bb2                	mv	s7,a2
  state = 0;
 53e:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 540:	4901                	li	s2,0
 542:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 544:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 548:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 54c:	06c00c93          	li	s9,108
 550:	a00d                	j	572 <vprintf+0x5c>
        putc(fd, c0);
 552:	85a6                	mv	a1,s1
 554:	855a                	mv	a0,s6
 556:	f0bff0ef          	jal	460 <putc>
 55a:	a019                	j	560 <vprintf+0x4a>
    } else if(state == '%'){
 55c:	03598363          	beq	s3,s5,582 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 560:	0019079b          	addiw	a5,s2,1
 564:	893e                	mv	s2,a5
 566:	873e                	mv	a4,a5
 568:	97d2                	add	a5,a5,s4
 56a:	0007c483          	lbu	s1,0(a5)
 56e:	22048763          	beqz	s1,79c <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 572:	0004879b          	sext.w	a5,s1
    if(state == 0){
 576:	fe0993e3          	bnez	s3,55c <vprintf+0x46>
      if(c0 == '%'){
 57a:	fd579ce3          	bne	a5,s5,552 <vprintf+0x3c>
        state = '%';
 57e:	89be                	mv	s3,a5
 580:	b7c5                	j	560 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 582:	00ea06b3          	add	a3,s4,a4
 586:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 58a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 58c:	c681                	beqz	a3,594 <vprintf+0x7e>
 58e:	9752                	add	a4,a4,s4
 590:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 594:	05878263          	beq	a5,s8,5d8 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 598:	05978c63          	beq	a5,s9,5f0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 59c:	07500713          	li	a4,117
 5a0:	0ee78663          	beq	a5,a4,68c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5a4:	07800713          	li	a4,120
 5a8:	12e78863          	beq	a5,a4,6d8 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5ac:	07000713          	li	a4,112
 5b0:	14e78d63          	beq	a5,a4,70a <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5b4:	06300713          	li	a4,99
 5b8:	18e78c63          	beq	a5,a4,750 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5bc:	07300713          	li	a4,115
 5c0:	1ae78263          	beq	a5,a4,764 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5c4:	02500713          	li	a4,37
 5c8:	04e79463          	bne	a5,a4,610 <vprintf+0xfa>
        putc(fd, '%');
 5cc:	85ba                	mv	a1,a4
 5ce:	855a                	mv	a0,s6
 5d0:	e91ff0ef          	jal	460 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5d4:	4981                	li	s3,0
 5d6:	b769                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5d8:	008b8493          	addi	s1,s7,8
 5dc:	4685                	li	a3,1
 5de:	4629                	li	a2,10
 5e0:	000ba583          	lw	a1,0(s7)
 5e4:	855a                	mv	a0,s6
 5e6:	e99ff0ef          	jal	47e <printint>
 5ea:	8ba6                	mv	s7,s1
      state = 0;
 5ec:	4981                	li	s3,0
 5ee:	bf8d                	j	560 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 5f0:	06400793          	li	a5,100
 5f4:	02f68963          	beq	a3,a5,626 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5f8:	06c00793          	li	a5,108
 5fc:	04f68263          	beq	a3,a5,640 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 600:	07500793          	li	a5,117
 604:	0af68063          	beq	a3,a5,6a4 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 608:	07800793          	li	a5,120
 60c:	0ef68263          	beq	a3,a5,6f0 <vprintf+0x1da>
        putc(fd, '%');
 610:	02500593          	li	a1,37
 614:	855a                	mv	a0,s6
 616:	e4bff0ef          	jal	460 <putc>
        putc(fd, c0);
 61a:	85a6                	mv	a1,s1
 61c:	855a                	mv	a0,s6
 61e:	e43ff0ef          	jal	460 <putc>
      state = 0;
 622:	4981                	li	s3,0
 624:	bf35                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 626:	008b8493          	addi	s1,s7,8
 62a:	4685                	li	a3,1
 62c:	4629                	li	a2,10
 62e:	000bb583          	ld	a1,0(s7)
 632:	855a                	mv	a0,s6
 634:	e4bff0ef          	jal	47e <printint>
        i += 1;
 638:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 63a:	8ba6                	mv	s7,s1
      state = 0;
 63c:	4981                	li	s3,0
        i += 1;
 63e:	b70d                	j	560 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 640:	06400793          	li	a5,100
 644:	02f60763          	beq	a2,a5,672 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 648:	07500793          	li	a5,117
 64c:	06f60963          	beq	a2,a5,6be <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 650:	07800793          	li	a5,120
 654:	faf61ee3          	bne	a2,a5,610 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 658:	008b8493          	addi	s1,s7,8
 65c:	4681                	li	a3,0
 65e:	4641                	li	a2,16
 660:	000bb583          	ld	a1,0(s7)
 664:	855a                	mv	a0,s6
 666:	e19ff0ef          	jal	47e <printint>
        i += 2;
 66a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 66c:	8ba6                	mv	s7,s1
      state = 0;
 66e:	4981                	li	s3,0
        i += 2;
 670:	bdc5                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 672:	008b8493          	addi	s1,s7,8
 676:	4685                	li	a3,1
 678:	4629                	li	a2,10
 67a:	000bb583          	ld	a1,0(s7)
 67e:	855a                	mv	a0,s6
 680:	dffff0ef          	jal	47e <printint>
        i += 2;
 684:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 686:	8ba6                	mv	s7,s1
      state = 0;
 688:	4981                	li	s3,0
        i += 2;
 68a:	bdd9                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 68c:	008b8493          	addi	s1,s7,8
 690:	4681                	li	a3,0
 692:	4629                	li	a2,10
 694:	000be583          	lwu	a1,0(s7)
 698:	855a                	mv	a0,s6
 69a:	de5ff0ef          	jal	47e <printint>
 69e:	8ba6                	mv	s7,s1
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bd7d                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6a4:	008b8493          	addi	s1,s7,8
 6a8:	4681                	li	a3,0
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	dcdff0ef          	jal	47e <printint>
        i += 1;
 6b6:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b8:	8ba6                	mv	s7,s1
      state = 0;
 6ba:	4981                	li	s3,0
        i += 1;
 6bc:	b555                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6be:	008b8493          	addi	s1,s7,8
 6c2:	4681                	li	a3,0
 6c4:	4629                	li	a2,10
 6c6:	000bb583          	ld	a1,0(s7)
 6ca:	855a                	mv	a0,s6
 6cc:	db3ff0ef          	jal	47e <printint>
        i += 2;
 6d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d2:	8ba6                	mv	s7,s1
      state = 0;
 6d4:	4981                	li	s3,0
        i += 2;
 6d6:	b569                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6d8:	008b8493          	addi	s1,s7,8
 6dc:	4681                	li	a3,0
 6de:	4641                	li	a2,16
 6e0:	000be583          	lwu	a1,0(s7)
 6e4:	855a                	mv	a0,s6
 6e6:	d99ff0ef          	jal	47e <printint>
 6ea:	8ba6                	mv	s7,s1
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bd8d                	j	560 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6f0:	008b8493          	addi	s1,s7,8
 6f4:	4681                	li	a3,0
 6f6:	4641                	li	a2,16
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	d81ff0ef          	jal	47e <printint>
        i += 1;
 702:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 704:	8ba6                	mv	s7,s1
      state = 0;
 706:	4981                	li	s3,0
        i += 1;
 708:	bda1                	j	560 <vprintf+0x4a>
 70a:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 70c:	008b8d13          	addi	s10,s7,8
 710:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 714:	03000593          	li	a1,48
 718:	855a                	mv	a0,s6
 71a:	d47ff0ef          	jal	460 <putc>
  putc(fd, 'x');
 71e:	07800593          	li	a1,120
 722:	855a                	mv	a0,s6
 724:	d3dff0ef          	jal	460 <putc>
 728:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 72a:	00000b97          	auipc	s7,0x0
 72e:	2b6b8b93          	addi	s7,s7,694 # 9e0 <digits>
 732:	03c9d793          	srli	a5,s3,0x3c
 736:	97de                	add	a5,a5,s7
 738:	0007c583          	lbu	a1,0(a5)
 73c:	855a                	mv	a0,s6
 73e:	d23ff0ef          	jal	460 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 742:	0992                	slli	s3,s3,0x4
 744:	34fd                	addiw	s1,s1,-1
 746:	f4f5                	bnez	s1,732 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 748:	8bea                	mv	s7,s10
      state = 0;
 74a:	4981                	li	s3,0
 74c:	6d02                	ld	s10,0(sp)
 74e:	bd09                	j	560 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 750:	008b8493          	addi	s1,s7,8
 754:	000bc583          	lbu	a1,0(s7)
 758:	855a                	mv	a0,s6
 75a:	d07ff0ef          	jal	460 <putc>
 75e:	8ba6                	mv	s7,s1
      state = 0;
 760:	4981                	li	s3,0
 762:	bbfd                	j	560 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 764:	008b8993          	addi	s3,s7,8
 768:	000bb483          	ld	s1,0(s7)
 76c:	cc91                	beqz	s1,788 <vprintf+0x272>
        for(; *s; s++)
 76e:	0004c583          	lbu	a1,0(s1)
 772:	c195                	beqz	a1,796 <vprintf+0x280>
          putc(fd, *s);
 774:	855a                	mv	a0,s6
 776:	cebff0ef          	jal	460 <putc>
        for(; *s; s++)
 77a:	0485                	addi	s1,s1,1
 77c:	0004c583          	lbu	a1,0(s1)
 780:	f9f5                	bnez	a1,774 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 782:	8bce                	mv	s7,s3
      state = 0;
 784:	4981                	li	s3,0
 786:	bbe9                	j	560 <vprintf+0x4a>
          s = "(null)";
 788:	00000497          	auipc	s1,0x0
 78c:	25048493          	addi	s1,s1,592 # 9d8 <malloc+0x140>
        for(; *s; s++)
 790:	02800593          	li	a1,40
 794:	b7c5                	j	774 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 796:	8bce                	mv	s7,s3
      state = 0;
 798:	4981                	li	s3,0
 79a:	b3d9                	j	560 <vprintf+0x4a>
 79c:	6906                	ld	s2,64(sp)
 79e:	79e2                	ld	s3,56(sp)
 7a0:	7a42                	ld	s4,48(sp)
 7a2:	7aa2                	ld	s5,40(sp)
 7a4:	7b02                	ld	s6,32(sp)
 7a6:	6be2                	ld	s7,24(sp)
 7a8:	6c42                	ld	s8,16(sp)
 7aa:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7ac:	60e6                	ld	ra,88(sp)
 7ae:	6446                	ld	s0,80(sp)
 7b0:	64a6                	ld	s1,72(sp)
 7b2:	6125                	addi	sp,sp,96
 7b4:	8082                	ret

00000000000007b6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7b6:	715d                	addi	sp,sp,-80
 7b8:	ec06                	sd	ra,24(sp)
 7ba:	e822                	sd	s0,16(sp)
 7bc:	1000                	addi	s0,sp,32
 7be:	e010                	sd	a2,0(s0)
 7c0:	e414                	sd	a3,8(s0)
 7c2:	e818                	sd	a4,16(s0)
 7c4:	ec1c                	sd	a5,24(s0)
 7c6:	03043023          	sd	a6,32(s0)
 7ca:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7ce:	8622                	mv	a2,s0
 7d0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7d4:	d43ff0ef          	jal	516 <vprintf>
}
 7d8:	60e2                	ld	ra,24(sp)
 7da:	6442                	ld	s0,16(sp)
 7dc:	6161                	addi	sp,sp,80
 7de:	8082                	ret

00000000000007e0 <printf>:

void
printf(const char *fmt, ...)
{
 7e0:	711d                	addi	sp,sp,-96
 7e2:	ec06                	sd	ra,24(sp)
 7e4:	e822                	sd	s0,16(sp)
 7e6:	1000                	addi	s0,sp,32
 7e8:	e40c                	sd	a1,8(s0)
 7ea:	e810                	sd	a2,16(s0)
 7ec:	ec14                	sd	a3,24(s0)
 7ee:	f018                	sd	a4,32(s0)
 7f0:	f41c                	sd	a5,40(s0)
 7f2:	03043823          	sd	a6,48(s0)
 7f6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 7fa:	00840613          	addi	a2,s0,8
 7fe:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 802:	85aa                	mv	a1,a0
 804:	4505                	li	a0,1
 806:	d11ff0ef          	jal	516 <vprintf>
}
 80a:	60e2                	ld	ra,24(sp)
 80c:	6442                	ld	s0,16(sp)
 80e:	6125                	addi	sp,sp,96
 810:	8082                	ret

0000000000000812 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 812:	1141                	addi	sp,sp,-16
 814:	e406                	sd	ra,8(sp)
 816:	e022                	sd	s0,0(sp)
 818:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 81a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 81e:	00000797          	auipc	a5,0x0
 822:	7e27b783          	ld	a5,2018(a5) # 1000 <freep>
 826:	a02d                	j	850 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 828:	4618                	lw	a4,8(a2)
 82a:	9f2d                	addw	a4,a4,a1
 82c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 830:	6398                	ld	a4,0(a5)
 832:	6310                	ld	a2,0(a4)
 834:	a83d                	j	872 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 836:	ff852703          	lw	a4,-8(a0)
 83a:	9f31                	addw	a4,a4,a2
 83c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 83e:	ff053683          	ld	a3,-16(a0)
 842:	a091                	j	886 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 844:	6398                	ld	a4,0(a5)
 846:	00e7e463          	bltu	a5,a4,84e <free+0x3c>
 84a:	00e6ea63          	bltu	a3,a4,85e <free+0x4c>
{
 84e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 850:	fed7fae3          	bgeu	a5,a3,844 <free+0x32>
 854:	6398                	ld	a4,0(a5)
 856:	00e6e463          	bltu	a3,a4,85e <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85a:	fee7eae3          	bltu	a5,a4,84e <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 85e:	ff852583          	lw	a1,-8(a0)
 862:	6390                	ld	a2,0(a5)
 864:	02059813          	slli	a6,a1,0x20
 868:	01c85713          	srli	a4,a6,0x1c
 86c:	9736                	add	a4,a4,a3
 86e:	fae60de3          	beq	a2,a4,828 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 872:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 876:	4790                	lw	a2,8(a5)
 878:	02061593          	slli	a1,a2,0x20
 87c:	01c5d713          	srli	a4,a1,0x1c
 880:	973e                	add	a4,a4,a5
 882:	fae68ae3          	beq	a3,a4,836 <free+0x24>
    p->s.ptr = bp->s.ptr;
 886:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 888:	00000717          	auipc	a4,0x0
 88c:	76f73c23          	sd	a5,1912(a4) # 1000 <freep>
}
 890:	60a2                	ld	ra,8(sp)
 892:	6402                	ld	s0,0(sp)
 894:	0141                	addi	sp,sp,16
 896:	8082                	ret

0000000000000898 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 898:	7139                	addi	sp,sp,-64
 89a:	fc06                	sd	ra,56(sp)
 89c:	f822                	sd	s0,48(sp)
 89e:	f04a                	sd	s2,32(sp)
 8a0:	ec4e                	sd	s3,24(sp)
 8a2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8a4:	02051993          	slli	s3,a0,0x20
 8a8:	0209d993          	srli	s3,s3,0x20
 8ac:	09bd                	addi	s3,s3,15
 8ae:	0049d993          	srli	s3,s3,0x4
 8b2:	2985                	addiw	s3,s3,1
 8b4:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 8b6:	00000517          	auipc	a0,0x0
 8ba:	74a53503          	ld	a0,1866(a0) # 1000 <freep>
 8be:	c905                	beqz	a0,8ee <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8c2:	4798                	lw	a4,8(a5)
 8c4:	09377663          	bgeu	a4,s3,950 <malloc+0xb8>
 8c8:	f426                	sd	s1,40(sp)
 8ca:	e852                	sd	s4,16(sp)
 8cc:	e456                	sd	s5,8(sp)
 8ce:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8d0:	8a4e                	mv	s4,s3
 8d2:	6705                	lui	a4,0x1
 8d4:	00e9f363          	bgeu	s3,a4,8da <malloc+0x42>
 8d8:	6a05                	lui	s4,0x1
 8da:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8de:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8e2:	00000497          	auipc	s1,0x0
 8e6:	71e48493          	addi	s1,s1,1822 # 1000 <freep>
  if(p == SBRK_ERROR)
 8ea:	5afd                	li	s5,-1
 8ec:	a83d                	j	92a <malloc+0x92>
 8ee:	f426                	sd	s1,40(sp)
 8f0:	e852                	sd	s4,16(sp)
 8f2:	e456                	sd	s5,8(sp)
 8f4:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 8f6:	00001797          	auipc	a5,0x1
 8fa:	91a78793          	addi	a5,a5,-1766 # 1210 <base>
 8fe:	00000717          	auipc	a4,0x0
 902:	70f73123          	sd	a5,1794(a4) # 1000 <freep>
 906:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 908:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 90c:	b7d1                	j	8d0 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 90e:	6398                	ld	a4,0(a5)
 910:	e118                	sd	a4,0(a0)
 912:	a899                	j	968 <malloc+0xd0>
  hp->s.size = nu;
 914:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 918:	0541                	addi	a0,a0,16
 91a:	ef9ff0ef          	jal	812 <free>
  return freep;
 91e:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 920:	c125                	beqz	a0,980 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 922:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 924:	4798                	lw	a4,8(a5)
 926:	03277163          	bgeu	a4,s2,948 <malloc+0xb0>
    if(p == freep)
 92a:	6098                	ld	a4,0(s1)
 92c:	853e                	mv	a0,a5
 92e:	fef71ae3          	bne	a4,a5,922 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 932:	8552                	mv	a0,s4
 934:	a59ff0ef          	jal	38c <sbrk>
  if(p == SBRK_ERROR)
 938:	fd551ee3          	bne	a0,s5,914 <malloc+0x7c>
        return 0;
 93c:	4501                	li	a0,0
 93e:	74a2                	ld	s1,40(sp)
 940:	6a42                	ld	s4,16(sp)
 942:	6aa2                	ld	s5,8(sp)
 944:	6b02                	ld	s6,0(sp)
 946:	a03d                	j	974 <malloc+0xdc>
 948:	74a2                	ld	s1,40(sp)
 94a:	6a42                	ld	s4,16(sp)
 94c:	6aa2                	ld	s5,8(sp)
 94e:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 950:	fae90fe3          	beq	s2,a4,90e <malloc+0x76>
        p->s.size -= nunits;
 954:	4137073b          	subw	a4,a4,s3
 958:	c798                	sw	a4,8(a5)
        p += p->s.size;
 95a:	02071693          	slli	a3,a4,0x20
 95e:	01c6d713          	srli	a4,a3,0x1c
 962:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 964:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 968:	00000717          	auipc	a4,0x0
 96c:	68a73c23          	sd	a0,1688(a4) # 1000 <freep>
      return (void*)(p + 1);
 970:	01078513          	addi	a0,a5,16
  }
}
 974:	70e2                	ld	ra,56(sp)
 976:	7442                	ld	s0,48(sp)
 978:	7902                	ld	s2,32(sp)
 97a:	69e2                	ld	s3,24(sp)
 97c:	6121                	addi	sp,sp,64
 97e:	8082                	ret
 980:	74a2                	ld	s1,40(sp)
 982:	6a42                	ld	s4,16(sp)
 984:	6aa2                	ld	s5,8(sp)
 986:	6b02                	ld	s6,0(sp)
 988:	b7f5                	j	974 <malloc+0xdc>
