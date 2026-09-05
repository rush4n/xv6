
user/_memdump:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <memdump>:
  exit(0);
}

void
memdump(char *fmt, char *data)
{
   0:	711d                	addi	sp,sp,-96
   2:	ec86                	sd	ra,88(sp)
   4:	e8a2                	sd	s0,80(sp)
   6:	e0ca                	sd	s2,64(sp)
   8:	1080                	addi	s0,sp,96
   a:	892e                	mv	s2,a1
  while(*fmt != '\0') {
   c:	00054583          	lbu	a1,0(a0)
  10:	c9e1                	beqz	a1,e0 <memdump+0xe0>
  12:	e4a6                	sd	s1,72(sp)
  14:	fc4e                	sd	s3,56(sp)
  16:	f852                	sd	s4,48(sp)
  18:	f456                	sd	s5,40(sp)
  1a:	f05a                	sd	s6,32(sp)
  1c:	ec5e                	sd	s7,24(sp)
  1e:	e862                	sd	s8,16(sp)
  20:	e466                	sd	s9,8(sp)
  22:	84aa                	mv	s1,a0
  24:	02000a13          	li	s4,32
      data += 8;
    }
    else if (*fmt == 'S') { 
      printf("%s\n", data); 
    } else {
      printf("memdump: undefined option %c\n", *fmt); 
  28:	00001c97          	auipc	s9,0x1
  2c:	af8c8c93          	addi	s9,s9,-1288 # b20 <malloc+0x11e>
  30:	00001997          	auipc	s3,0x1
  34:	bd898993          	addi	s3,s3,-1064 # c08 <malloc+0x206>
      printf("%s\n", data); 
  38:	00001b17          	auipc	s6,0x1
  3c:	ae0b0b13          	addi	s6,s6,-1312 # b18 <malloc+0x116>
      printf("%c\n", *(uint8 *) data); 
  40:	00001c17          	auipc	s8,0x1
  44:	ad0c0c13          	addi	s8,s8,-1328 # b10 <malloc+0x10e>
      printf("%d\n", *(uint16 *) data); 
  48:	00001a97          	auipc	s5,0x1
  4c:	ab8a8a93          	addi	s5,s5,-1352 # b00 <malloc+0xfe>
      printf("%lx\n", *(uint64 *) data); 
  50:	00001b97          	auipc	s7,0x1
  54:	ab8b8b93          	addi	s7,s7,-1352 # b08 <malloc+0x106>
  58:	a819                	j	6e <memdump+0x6e>
      printf("%d\n", *(uint32 *) data); 
  5a:	00092583          	lw	a1,0(s2)
  5e:	8556                	mv	a0,s5
  60:	0eb000ef          	jal	94a <printf>
      data += 4;
  64:	0911                	addi	s2,s2,4
    }

    fmt++;
  66:	0485                	addi	s1,s1,1
  while(*fmt != '\0') {
  68:	0004c583          	lbu	a1,0(s1)
  6c:	c1b5                	beqz	a1,d0 <memdump+0xd0>
    if (*fmt == 'i') { 
  6e:	fad5879b          	addiw	a5,a1,-83
  72:	0ff7f713          	zext.b	a4,a5
  76:	04ea6963          	bltu	s4,a4,c8 <memdump+0xc8>
  7a:	00271793          	slli	a5,a4,0x2
  7e:	97ce                	add	a5,a5,s3
  80:	439c                	lw	a5,0(a5)
  82:	97ce                	add	a5,a5,s3
  84:	8782                	jr	a5
      printf("%lx\n", *(uint64 *) data); 
  86:	00093583          	ld	a1,0(s2)
  8a:	855e                	mv	a0,s7
  8c:	0bf000ef          	jal	94a <printf>
      data += 8;
  90:	0921                	addi	s2,s2,8
  92:	bfd1                	j	66 <memdump+0x66>
      printf("%d\n", *(uint16 *) data); 
  94:	00095583          	lhu	a1,0(s2)
  98:	8556                	mv	a0,s5
  9a:	0b1000ef          	jal	94a <printf>
      data += 2;
  9e:	0909                	addi	s2,s2,2
  a0:	b7d9                	j	66 <memdump+0x66>
      printf("%c\n", *(uint8 *) data); 
  a2:	00094583          	lbu	a1,0(s2)
  a6:	8562                	mv	a0,s8
  a8:	0a3000ef          	jal	94a <printf>
      data += 1;
  ac:	0905                	addi	s2,s2,1
  ae:	bf65                	j	66 <memdump+0x66>
      printf("%s\n", *(char **) data); 
  b0:	00093583          	ld	a1,0(s2)
  b4:	855a                	mv	a0,s6
  b6:	095000ef          	jal	94a <printf>
      data += 8;
  ba:	0921                	addi	s2,s2,8
  bc:	b76d                	j	66 <memdump+0x66>
      printf("%s\n", data); 
  be:	85ca                	mv	a1,s2
  c0:	855a                	mv	a0,s6
  c2:	089000ef          	jal	94a <printf>
  c6:	b745                	j	66 <memdump+0x66>
      printf("memdump: undefined option %c\n", *fmt); 
  c8:	8566                	mv	a0,s9
  ca:	081000ef          	jal	94a <printf>
  ce:	bf61                	j	66 <memdump+0x66>
  d0:	64a6                	ld	s1,72(sp)
  d2:	79e2                	ld	s3,56(sp)
  d4:	7a42                	ld	s4,48(sp)
  d6:	7aa2                	ld	s5,40(sp)
  d8:	7b02                	ld	s6,32(sp)
  da:	6be2                	ld	s7,24(sp)
  dc:	6c42                	ld	s8,16(sp)
  de:	6ca2                	ld	s9,8(sp)
  }

}
  e0:	60e6                	ld	ra,88(sp)
  e2:	6446                	ld	s0,80(sp)
  e4:	6906                	ld	s2,64(sp)
  e6:	6125                	addi	sp,sp,96
  e8:	8082                	ret

00000000000000ea <main>:
{
  ea:	db010113          	addi	sp,sp,-592
  ee:	24113423          	sd	ra,584(sp)
  f2:	24813023          	sd	s0,576(sp)
  f6:	22913c23          	sd	s1,568(sp)
  fa:	23213823          	sd	s2,560(sp)
  fe:	23313423          	sd	s3,552(sp)
 102:	23413023          	sd	s4,544(sp)
 106:	21513c23          	sd	s5,536(sp)
 10a:	0c80                	addi	s0,sp,592
  if(argc == 1){
 10c:	4785                	li	a5,1
 10e:	00f50f63          	beq	a0,a5,12c <main+0x42>
 112:	8aae                	mv	s5,a1
  } else if(argc == 2){
 114:	4789                	li	a5,2
 116:	0ef50f63          	beq	a0,a5,214 <main+0x12a>
    printf("Usage: memdump [format]\n");
 11a:	00001517          	auipc	a0,0x1
 11e:	ac650513          	addi	a0,a0,-1338 # be0 <malloc+0x1de>
 122:	029000ef          	jal	94a <printf>
    exit(1);
 126:	4505                	li	a0,1
 128:	402000ef          	jal	52a <exit>
    printf("Example 1:\n");
 12c:	00001517          	auipc	a0,0x1
 130:	a1450513          	addi	a0,a0,-1516 # b40 <malloc+0x13e>
 134:	017000ef          	jal	94a <printf>
    int a[2] = { 61810, 2025 };
 138:	67bd                	lui	a5,0xf
 13a:	17278793          	addi	a5,a5,370 # f172 <base+0xd162>
 13e:	daf42823          	sw	a5,-592(s0)
 142:	7e900793          	li	a5,2025
 146:	daf42a23          	sw	a5,-588(s0)
    memdump("ii", (char*) a);
 14a:	db040593          	addi	a1,s0,-592
 14e:	00001517          	auipc	a0,0x1
 152:	a0250513          	addi	a0,a0,-1534 # b50 <malloc+0x14e>
 156:	eabff0ef          	jal	0 <memdump>
    printf("Example 2:\n");
 15a:	00001517          	auipc	a0,0x1
 15e:	9fe50513          	addi	a0,a0,-1538 # b58 <malloc+0x156>
 162:	7e8000ef          	jal	94a <printf>
    memdump("S", "a string");
 166:	00001597          	auipc	a1,0x1
 16a:	a0258593          	addi	a1,a1,-1534 # b68 <malloc+0x166>
 16e:	00001517          	auipc	a0,0x1
 172:	a0a50513          	addi	a0,a0,-1526 # b78 <malloc+0x176>
 176:	e8bff0ef          	jal	0 <memdump>
    printf("Example 3:\n");
 17a:	00001517          	auipc	a0,0x1
 17e:	a0650513          	addi	a0,a0,-1530 # b80 <malloc+0x17e>
 182:	7c8000ef          	jal	94a <printf>
    char *s = "another";
 186:	00001797          	auipc	a5,0x1
 18a:	a0a78793          	addi	a5,a5,-1526 # b90 <malloc+0x18e>
 18e:	daf43c23          	sd	a5,-584(s0)
    memdump("s", (char *) &s);
 192:	db840593          	addi	a1,s0,-584
 196:	00001517          	auipc	a0,0x1
 19a:	a0250513          	addi	a0,a0,-1534 # b98 <malloc+0x196>
 19e:	e63ff0ef          	jal	0 <memdump>
    example.ptr = "hello";
 1a2:	00001797          	auipc	a5,0x1
 1a6:	9fe78793          	addi	a5,a5,-1538 # ba0 <malloc+0x19e>
 1aa:	dcf43023          	sd	a5,-576(s0)
    example.num1 = 1819438967;
 1ae:	6c7277b7          	lui	a5,0x6c727
 1b2:	f7778793          	addi	a5,a5,-137 # 6c726f77 <base+0x6c724f67>
 1b6:	dcf42423          	sw	a5,-568(s0)
    example.num2 = 100;
 1ba:	06400793          	li	a5,100
 1be:	dcf41623          	sh	a5,-564(s0)
    example.byte = 'z';
 1c2:	07a00793          	li	a5,122
 1c6:	dcf40723          	sb	a5,-562(s0)
    strcpy(example.bytes, "xyzzy");
 1ca:	dc040493          	addi	s1,s0,-576
 1ce:	00001597          	auipc	a1,0x1
 1d2:	9da58593          	addi	a1,a1,-1574 # ba8 <malloc+0x1a6>
 1d6:	dcf40513          	addi	a0,s0,-561
 1da:	098000ef          	jal	272 <strcpy>
    printf("Example 4:\n");
 1de:	00001517          	auipc	a0,0x1
 1e2:	9d250513          	addi	a0,a0,-1582 # bb0 <malloc+0x1ae>
 1e6:	764000ef          	jal	94a <printf>
    memdump("pihcS", (char*) &example);
 1ea:	85a6                	mv	a1,s1
 1ec:	00001517          	auipc	a0,0x1
 1f0:	9d450513          	addi	a0,a0,-1580 # bc0 <malloc+0x1be>
 1f4:	e0dff0ef          	jal	0 <memdump>
    printf("Example 5:\n");
 1f8:	00001517          	auipc	a0,0x1
 1fc:	9d050513          	addi	a0,a0,-1584 # bc8 <malloc+0x1c6>
 200:	74a000ef          	jal	94a <printf>
    memdump("sccccc", (char*) &example);
 204:	85a6                	mv	a1,s1
 206:	00001517          	auipc	a0,0x1
 20a:	9d250513          	addi	a0,a0,-1582 # bd8 <malloc+0x1d6>
 20e:	df3ff0ef          	jal	0 <memdump>
 212:	a0a1                	j	25a <main+0x170>
    memset(data, '\0', sizeof(data));
 214:	20000613          	li	a2,512
 218:	4581                	li	a1,0
 21a:	dc040513          	addi	a0,s0,-576
 21e:	0d2000ef          	jal	2f0 <memset>
    int n = 0;
 222:	4481                	li	s1,0
    while(n < sizeof(data)){
 224:	4601                	li	a2,0
      int nn = read(0, data + n, sizeof(data) - n);
 226:	20000993          	li	s3,512
 22a:	dc040913          	addi	s2,s0,-576
    while(n < sizeof(data)){
 22e:	1ff00a13          	li	s4,511
      int nn = read(0, data + n, sizeof(data) - n);
 232:	40c9863b          	subw	a2,s3,a2
 236:	009905b3          	add	a1,s2,s1
 23a:	4501                	li	a0,0
 23c:	306000ef          	jal	542 <read>
      if(nn <= 0)
 240:	00a05763          	blez	a0,24e <main+0x164>
      n += nn;
 244:	0095063b          	addw	a2,a0,s1
 248:	84b2                	mv	s1,a2
    while(n < sizeof(data)){
 24a:	feca74e3          	bgeu	s4,a2,232 <main+0x148>
    memdump(argv[1], data);
 24e:	dc040593          	addi	a1,s0,-576
 252:	008ab503          	ld	a0,8(s5)
 256:	dabff0ef          	jal	0 <memdump>
  exit(0);
 25a:	4501                	li	a0,0
 25c:	2ce000ef          	jal	52a <exit>

0000000000000260 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 260:	1141                	addi	sp,sp,-16
 262:	e406                	sd	ra,8(sp)
 264:	e022                	sd	s0,0(sp)
 266:	0800                	addi	s0,sp,16
  extern int main();
  main();
 268:	e83ff0ef          	jal	ea <main>
  exit(0);
 26c:	4501                	li	a0,0
 26e:	2bc000ef          	jal	52a <exit>

0000000000000272 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 272:	1141                	addi	sp,sp,-16
 274:	e406                	sd	ra,8(sp)
 276:	e022                	sd	s0,0(sp)
 278:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27a:	87aa                	mv	a5,a0
 27c:	0585                	addi	a1,a1,1
 27e:	0785                	addi	a5,a5,1
 280:	fff5c703          	lbu	a4,-1(a1)
 284:	fee78fa3          	sb	a4,-1(a5)
 288:	fb75                	bnez	a4,27c <strcpy+0xa>
    ;
  return os;
}
 28a:	60a2                	ld	ra,8(sp)
 28c:	6402                	ld	s0,0(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret

0000000000000292 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 292:	1141                	addi	sp,sp,-16
 294:	e406                	sd	ra,8(sp)
 296:	e022                	sd	s0,0(sp)
 298:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 29a:	00054783          	lbu	a5,0(a0)
 29e:	cb91                	beqz	a5,2b2 <strcmp+0x20>
 2a0:	0005c703          	lbu	a4,0(a1)
 2a4:	00f71763          	bne	a4,a5,2b2 <strcmp+0x20>
    p++, q++;
 2a8:	0505                	addi	a0,a0,1
 2aa:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	fbe5                	bnez	a5,2a0 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2b2:	0005c503          	lbu	a0,0(a1)
}
 2b6:	40a7853b          	subw	a0,a5,a0
 2ba:	60a2                	ld	ra,8(sp)
 2bc:	6402                	ld	s0,0(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <strlen>:

uint
strlen(const char *s)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e406                	sd	ra,8(sp)
 2c6:	e022                	sd	s0,0(sp)
 2c8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ca:	00054783          	lbu	a5,0(a0)
 2ce:	cf99                	beqz	a5,2ec <strlen+0x2a>
 2d0:	0505                	addi	a0,a0,1
 2d2:	87aa                	mv	a5,a0
 2d4:	86be                	mv	a3,a5
 2d6:	0785                	addi	a5,a5,1
 2d8:	fff7c703          	lbu	a4,-1(a5)
 2dc:	ff65                	bnez	a4,2d4 <strlen+0x12>
 2de:	40a6853b          	subw	a0,a3,a0
 2e2:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 2e4:	60a2                	ld	ra,8(sp)
 2e6:	6402                	ld	s0,0(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
  for(n = 0; s[n]; n++)
 2ec:	4501                	li	a0,0
 2ee:	bfdd                	j	2e4 <strlen+0x22>

00000000000002f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e406                	sd	ra,8(sp)
 2f4:	e022                	sd	s0,0(sp)
 2f6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f8:	ca19                	beqz	a2,30e <memset+0x1e>
 2fa:	87aa                	mv	a5,a0
 2fc:	1602                	slli	a2,a2,0x20
 2fe:	9201                	srli	a2,a2,0x20
 300:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 304:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 308:	0785                	addi	a5,a5,1
 30a:	fee79de3          	bne	a5,a4,304 <memset+0x14>
  }
  return dst;
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <strchr>:

char*
strchr(const char *s, char c)
{
 316:	1141                	addi	sp,sp,-16
 318:	e406                	sd	ra,8(sp)
 31a:	e022                	sd	s0,0(sp)
 31c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 31e:	00054783          	lbu	a5,0(a0)
 322:	cf81                	beqz	a5,33a <strchr+0x24>
    if(*s == c)
 324:	00f58763          	beq	a1,a5,332 <strchr+0x1c>
  for(; *s; s++)
 328:	0505                	addi	a0,a0,1
 32a:	00054783          	lbu	a5,0(a0)
 32e:	fbfd                	bnez	a5,324 <strchr+0xe>
      return (char*)s;
  return 0;
 330:	4501                	li	a0,0
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret
  return 0;
 33a:	4501                	li	a0,0
 33c:	bfdd                	j	332 <strchr+0x1c>

000000000000033e <gets>:

char*
gets(char *buf, int max)
{
 33e:	7159                	addi	sp,sp,-112
 340:	f486                	sd	ra,104(sp)
 342:	f0a2                	sd	s0,96(sp)
 344:	eca6                	sd	s1,88(sp)
 346:	e8ca                	sd	s2,80(sp)
 348:	e4ce                	sd	s3,72(sp)
 34a:	e0d2                	sd	s4,64(sp)
 34c:	fc56                	sd	s5,56(sp)
 34e:	f85a                	sd	s6,48(sp)
 350:	f45e                	sd	s7,40(sp)
 352:	f062                	sd	s8,32(sp)
 354:	ec66                	sd	s9,24(sp)
 356:	e86a                	sd	s10,16(sp)
 358:	1880                	addi	s0,sp,112
 35a:	8caa                	mv	s9,a0
 35c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 35e:	892a                	mv	s2,a0
 360:	4481                	li	s1,0
    cc = read(0, &c, 1);
 362:	f9f40b13          	addi	s6,s0,-97
 366:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 368:	4ba9                	li	s7,10
 36a:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 36c:	8d26                	mv	s10,s1
 36e:	0014899b          	addiw	s3,s1,1
 372:	84ce                	mv	s1,s3
 374:	0349d563          	bge	s3,s4,39e <gets+0x60>
    cc = read(0, &c, 1);
 378:	8656                	mv	a2,s5
 37a:	85da                	mv	a1,s6
 37c:	4501                	li	a0,0
 37e:	1c4000ef          	jal	542 <read>
    if(cc < 1)
 382:	00a05e63          	blez	a0,39e <gets+0x60>
    buf[i++] = c;
 386:	f9f44783          	lbu	a5,-97(s0)
 38a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 38e:	01778763          	beq	a5,s7,39c <gets+0x5e>
 392:	0905                	addi	s2,s2,1
 394:	fd879ce3          	bne	a5,s8,36c <gets+0x2e>
    buf[i++] = c;
 398:	8d4e                	mv	s10,s3
 39a:	a011                	j	39e <gets+0x60>
 39c:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 39e:	9d66                	add	s10,s10,s9
 3a0:	000d0023          	sb	zero,0(s10)
  return buf;
}
 3a4:	8566                	mv	a0,s9
 3a6:	70a6                	ld	ra,104(sp)
 3a8:	7406                	ld	s0,96(sp)
 3aa:	64e6                	ld	s1,88(sp)
 3ac:	6946                	ld	s2,80(sp)
 3ae:	69a6                	ld	s3,72(sp)
 3b0:	6a06                	ld	s4,64(sp)
 3b2:	7ae2                	ld	s5,56(sp)
 3b4:	7b42                	ld	s6,48(sp)
 3b6:	7ba2                	ld	s7,40(sp)
 3b8:	7c02                	ld	s8,32(sp)
 3ba:	6ce2                	ld	s9,24(sp)
 3bc:	6d42                	ld	s10,16(sp)
 3be:	6165                	addi	sp,sp,112
 3c0:	8082                	ret

00000000000003c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c2:	1101                	addi	sp,sp,-32
 3c4:	ec06                	sd	ra,24(sp)
 3c6:	e822                	sd	s0,16(sp)
 3c8:	e04a                	sd	s2,0(sp)
 3ca:	1000                	addi	s0,sp,32
 3cc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3ce:	4581                	li	a1,0
 3d0:	19a000ef          	jal	56a <open>
  if(fd < 0)
 3d4:	02054263          	bltz	a0,3f8 <stat+0x36>
 3d8:	e426                	sd	s1,8(sp)
 3da:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3dc:	85ca                	mv	a1,s2
 3de:	1a4000ef          	jal	582 <fstat>
 3e2:	892a                	mv	s2,a0
  close(fd);
 3e4:	8526                	mv	a0,s1
 3e6:	16c000ef          	jal	552 <close>
  return r;
 3ea:	64a2                	ld	s1,8(sp)
}
 3ec:	854a                	mv	a0,s2
 3ee:	60e2                	ld	ra,24(sp)
 3f0:	6442                	ld	s0,16(sp)
 3f2:	6902                	ld	s2,0(sp)
 3f4:	6105                	addi	sp,sp,32
 3f6:	8082                	ret
    return -1;
 3f8:	597d                	li	s2,-1
 3fa:	bfcd                	j	3ec <stat+0x2a>

00000000000003fc <atoi>:

int
atoi(const char *s)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e406                	sd	ra,8(sp)
 400:	e022                	sd	s0,0(sp)
 402:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 404:	00054683          	lbu	a3,0(a0)
 408:	fd06879b          	addiw	a5,a3,-48
 40c:	0ff7f793          	zext.b	a5,a5
 410:	4625                	li	a2,9
 412:	02f66963          	bltu	a2,a5,444 <atoi+0x48>
 416:	872a                	mv	a4,a0
  n = 0;
 418:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 41a:	0705                	addi	a4,a4,1
 41c:	0025179b          	slliw	a5,a0,0x2
 420:	9fa9                	addw	a5,a5,a0
 422:	0017979b          	slliw	a5,a5,0x1
 426:	9fb5                	addw	a5,a5,a3
 428:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 42c:	00074683          	lbu	a3,0(a4)
 430:	fd06879b          	addiw	a5,a3,-48
 434:	0ff7f793          	zext.b	a5,a5
 438:	fef671e3          	bgeu	a2,a5,41a <atoi+0x1e>
  return n;
}
 43c:	60a2                	ld	ra,8(sp)
 43e:	6402                	ld	s0,0(sp)
 440:	0141                	addi	sp,sp,16
 442:	8082                	ret
  n = 0;
 444:	4501                	li	a0,0
 446:	bfdd                	j	43c <atoi+0x40>

0000000000000448 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 448:	1141                	addi	sp,sp,-16
 44a:	e406                	sd	ra,8(sp)
 44c:	e022                	sd	s0,0(sp)
 44e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 450:	02b57563          	bgeu	a0,a1,47a <memmove+0x32>
    while(n-- > 0)
 454:	00c05f63          	blez	a2,472 <memmove+0x2a>
 458:	1602                	slli	a2,a2,0x20
 45a:	9201                	srli	a2,a2,0x20
 45c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 460:	872a                	mv	a4,a0
      *dst++ = *src++;
 462:	0585                	addi	a1,a1,1
 464:	0705                	addi	a4,a4,1
 466:	fff5c683          	lbu	a3,-1(a1)
 46a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 46e:	fee79ae3          	bne	a5,a4,462 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 472:	60a2                	ld	ra,8(sp)
 474:	6402                	ld	s0,0(sp)
 476:	0141                	addi	sp,sp,16
 478:	8082                	ret
    dst += n;
 47a:	00c50733          	add	a4,a0,a2
    src += n;
 47e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 480:	fec059e3          	blez	a2,472 <memmove+0x2a>
 484:	fff6079b          	addiw	a5,a2,-1
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	fff7c793          	not	a5,a5
 490:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 492:	15fd                	addi	a1,a1,-1
 494:	177d                	addi	a4,a4,-1
 496:	0005c683          	lbu	a3,0(a1)
 49a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 49e:	fef71ae3          	bne	a4,a5,492 <memmove+0x4a>
 4a2:	bfc1                	j	472 <memmove+0x2a>

00000000000004a4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a4:	1141                	addi	sp,sp,-16
 4a6:	e406                	sd	ra,8(sp)
 4a8:	e022                	sd	s0,0(sp)
 4aa:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4ac:	ca0d                	beqz	a2,4de <memcmp+0x3a>
 4ae:	fff6069b          	addiw	a3,a2,-1
 4b2:	1682                	slli	a3,a3,0x20
 4b4:	9281                	srli	a3,a3,0x20
 4b6:	0685                	addi	a3,a3,1
 4b8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ba:	00054783          	lbu	a5,0(a0)
 4be:	0005c703          	lbu	a4,0(a1)
 4c2:	00e79863          	bne	a5,a4,4d2 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 4c6:	0505                	addi	a0,a0,1
    p2++;
 4c8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4ca:	fed518e3          	bne	a0,a3,4ba <memcmp+0x16>
  }
  return 0;
 4ce:	4501                	li	a0,0
 4d0:	a019                	j	4d6 <memcmp+0x32>
      return *p1 - *p2;
 4d2:	40e7853b          	subw	a0,a5,a4
}
 4d6:	60a2                	ld	ra,8(sp)
 4d8:	6402                	ld	s0,0(sp)
 4da:	0141                	addi	sp,sp,16
 4dc:	8082                	ret
  return 0;
 4de:	4501                	li	a0,0
 4e0:	bfdd                	j	4d6 <memcmp+0x32>

00000000000004e2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4e2:	1141                	addi	sp,sp,-16
 4e4:	e406                	sd	ra,8(sp)
 4e6:	e022                	sd	s0,0(sp)
 4e8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4ea:	f5fff0ef          	jal	448 <memmove>
}
 4ee:	60a2                	ld	ra,8(sp)
 4f0:	6402                	ld	s0,0(sp)
 4f2:	0141                	addi	sp,sp,16
 4f4:	8082                	ret

00000000000004f6 <sbrk>:

char *
sbrk(int n) {
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e406                	sd	ra,8(sp)
 4fa:	e022                	sd	s0,0(sp)
 4fc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 4fe:	4585                	li	a1,1
 500:	0b2000ef          	jal	5b2 <sys_sbrk>
}
 504:	60a2                	ld	ra,8(sp)
 506:	6402                	ld	s0,0(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret

000000000000050c <sbrklazy>:

char *
sbrklazy(int n) {
 50c:	1141                	addi	sp,sp,-16
 50e:	e406                	sd	ra,8(sp)
 510:	e022                	sd	s0,0(sp)
 512:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 514:	4589                	li	a1,2
 516:	09c000ef          	jal	5b2 <sys_sbrk>
}
 51a:	60a2                	ld	ra,8(sp)
 51c:	6402                	ld	s0,0(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret

0000000000000522 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 522:	4885                	li	a7,1
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <exit>:
.global exit
exit:
 li a7, SYS_exit
 52a:	4889                	li	a7,2
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <wait>:
.global wait
wait:
 li a7, SYS_wait
 532:	488d                	li	a7,3
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 53a:	4891                	li	a7,4
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <read>:
.global read
read:
 li a7, SYS_read
 542:	4895                	li	a7,5
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <write>:
.global write
write:
 li a7, SYS_write
 54a:	48c1                	li	a7,16
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <close>:
.global close
close:
 li a7, SYS_close
 552:	48d5                	li	a7,21
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <kill>:
.global kill
kill:
 li a7, SYS_kill
 55a:	4899                	li	a7,6
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <exec>:
.global exec
exec:
 li a7, SYS_exec
 562:	489d                	li	a7,7
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <open>:
.global open
open:
 li a7, SYS_open
 56a:	48bd                	li	a7,15
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 572:	48c5                	li	a7,17
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 57a:	48c9                	li	a7,18
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 582:	48a1                	li	a7,8
 ecall
 584:	00000073          	ecall
 ret
 588:	8082                	ret

000000000000058a <link>:
.global link
link:
 li a7, SYS_link
 58a:	48cd                	li	a7,19
 ecall
 58c:	00000073          	ecall
 ret
 590:	8082                	ret

0000000000000592 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 592:	48d1                	li	a7,20
 ecall
 594:	00000073          	ecall
 ret
 598:	8082                	ret

000000000000059a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 59a:	48a5                	li	a7,9
 ecall
 59c:	00000073          	ecall
 ret
 5a0:	8082                	ret

00000000000005a2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a2:	48a9                	li	a7,10
 ecall
 5a4:	00000073          	ecall
 ret
 5a8:	8082                	ret

00000000000005aa <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5aa:	48ad                	li	a7,11
 ecall
 5ac:	00000073          	ecall
 ret
 5b0:	8082                	ret

00000000000005b2 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5b2:	48b1                	li	a7,12
 ecall
 5b4:	00000073          	ecall
 ret
 5b8:	8082                	ret

00000000000005ba <pause>:
.global pause
pause:
 li a7, SYS_pause
 5ba:	48b5                	li	a7,13
 ecall
 5bc:	00000073          	ecall
 ret
 5c0:	8082                	ret

00000000000005c2 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c2:	48b9                	li	a7,14
 ecall
 5c4:	00000073          	ecall
 ret
 5c8:	8082                	ret

00000000000005ca <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5ca:	1101                	addi	sp,sp,-32
 5cc:	ec06                	sd	ra,24(sp)
 5ce:	e822                	sd	s0,16(sp)
 5d0:	1000                	addi	s0,sp,32
 5d2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d6:	4605                	li	a2,1
 5d8:	fef40593          	addi	a1,s0,-17
 5dc:	f6fff0ef          	jal	54a <write>
}
 5e0:	60e2                	ld	ra,24(sp)
 5e2:	6442                	ld	s0,16(sp)
 5e4:	6105                	addi	sp,sp,32
 5e6:	8082                	ret

00000000000005e8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5e8:	715d                	addi	sp,sp,-80
 5ea:	e486                	sd	ra,72(sp)
 5ec:	e0a2                	sd	s0,64(sp)
 5ee:	fc26                	sd	s1,56(sp)
 5f0:	f84a                	sd	s2,48(sp)
 5f2:	f44e                	sd	s3,40(sp)
 5f4:	0880                	addi	s0,sp,80
 5f6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f8:	c299                	beqz	a3,5fe <printint+0x16>
 5fa:	0605cf63          	bltz	a1,678 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fe:	2581                	sext.w	a1,a1
  neg = 0;
 600:	4e01                	li	t3,0
  }

  i = 0;
 602:	fb840313          	addi	t1,s0,-72
  neg = 0;
 606:	869a                	mv	a3,t1
  i = 0;
 608:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 60a:	00000817          	auipc	a6,0x0
 60e:	68680813          	addi	a6,a6,1670 # c90 <digits>
 612:	88be                	mv	a7,a5
 614:	0017851b          	addiw	a0,a5,1
 618:	87aa                	mv	a5,a0
 61a:	02c5f73b          	remuw	a4,a1,a2
 61e:	1702                	slli	a4,a4,0x20
 620:	9301                	srli	a4,a4,0x20
 622:	9742                	add	a4,a4,a6
 624:	00074703          	lbu	a4,0(a4)
 628:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 62c:	872e                	mv	a4,a1
 62e:	02c5d5bb          	divuw	a1,a1,a2
 632:	0685                	addi	a3,a3,1
 634:	fcc77fe3          	bgeu	a4,a2,612 <printint+0x2a>
  if(neg)
 638:	000e0c63          	beqz	t3,650 <printint+0x68>
    buf[i++] = '-';
 63c:	fd050793          	addi	a5,a0,-48
 640:	00878533          	add	a0,a5,s0
 644:	02d00793          	li	a5,45
 648:	fef50423          	sb	a5,-24(a0)
 64c:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 650:	fff7899b          	addiw	s3,a5,-1
 654:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 658:	fff4c583          	lbu	a1,-1(s1)
 65c:	854a                	mv	a0,s2
 65e:	f6dff0ef          	jal	5ca <putc>
  while(--i >= 0)
 662:	39fd                	addiw	s3,s3,-1
 664:	14fd                	addi	s1,s1,-1
 666:	fe09d9e3          	bgez	s3,658 <printint+0x70>
}
 66a:	60a6                	ld	ra,72(sp)
 66c:	6406                	ld	s0,64(sp)
 66e:	74e2                	ld	s1,56(sp)
 670:	7942                	ld	s2,48(sp)
 672:	79a2                	ld	s3,40(sp)
 674:	6161                	addi	sp,sp,80
 676:	8082                	ret
    x = -xx;
 678:	40b005bb          	negw	a1,a1
    neg = 1;
 67c:	4e05                	li	t3,1
    x = -xx;
 67e:	b751                	j	602 <printint+0x1a>

0000000000000680 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 680:	711d                	addi	sp,sp,-96
 682:	ec86                	sd	ra,88(sp)
 684:	e8a2                	sd	s0,80(sp)
 686:	e4a6                	sd	s1,72(sp)
 688:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 68a:	0005c483          	lbu	s1,0(a1)
 68e:	28048463          	beqz	s1,916 <vprintf+0x296>
 692:	e0ca                	sd	s2,64(sp)
 694:	fc4e                	sd	s3,56(sp)
 696:	f852                	sd	s4,48(sp)
 698:	f456                	sd	s5,40(sp)
 69a:	f05a                	sd	s6,32(sp)
 69c:	ec5e                	sd	s7,24(sp)
 69e:	e862                	sd	s8,16(sp)
 6a0:	e466                	sd	s9,8(sp)
 6a2:	8b2a                	mv	s6,a0
 6a4:	8a2e                	mv	s4,a1
 6a6:	8bb2                	mv	s7,a2
  state = 0;
 6a8:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6aa:	4901                	li	s2,0
 6ac:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6ae:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6b2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6b6:	06c00c93          	li	s9,108
 6ba:	a00d                	j	6dc <vprintf+0x5c>
        putc(fd, c0);
 6bc:	85a6                	mv	a1,s1
 6be:	855a                	mv	a0,s6
 6c0:	f0bff0ef          	jal	5ca <putc>
 6c4:	a019                	j	6ca <vprintf+0x4a>
    } else if(state == '%'){
 6c6:	03598363          	beq	s3,s5,6ec <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 6ca:	0019079b          	addiw	a5,s2,1
 6ce:	893e                	mv	s2,a5
 6d0:	873e                	mv	a4,a5
 6d2:	97d2                	add	a5,a5,s4
 6d4:	0007c483          	lbu	s1,0(a5)
 6d8:	22048763          	beqz	s1,906 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 6dc:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6e0:	fe0993e3          	bnez	s3,6c6 <vprintf+0x46>
      if(c0 == '%'){
 6e4:	fd579ce3          	bne	a5,s5,6bc <vprintf+0x3c>
        state = '%';
 6e8:	89be                	mv	s3,a5
 6ea:	b7c5                	j	6ca <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6ec:	00ea06b3          	add	a3,s4,a4
 6f0:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6f4:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6f6:	c681                	beqz	a3,6fe <vprintf+0x7e>
 6f8:	9752                	add	a4,a4,s4
 6fa:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 6fe:	05878263          	beq	a5,s8,742 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 702:	05978c63          	beq	a5,s9,75a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 706:	07500713          	li	a4,117
 70a:	0ee78663          	beq	a5,a4,7f6 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 70e:	07800713          	li	a4,120
 712:	12e78863          	beq	a5,a4,842 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 716:	07000713          	li	a4,112
 71a:	14e78d63          	beq	a5,a4,874 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 71e:	06300713          	li	a4,99
 722:	18e78c63          	beq	a5,a4,8ba <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 726:	07300713          	li	a4,115
 72a:	1ae78263          	beq	a5,a4,8ce <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 72e:	02500713          	li	a4,37
 732:	04e79463          	bne	a5,a4,77a <vprintf+0xfa>
        putc(fd, '%');
 736:	85ba                	mv	a1,a4
 738:	855a                	mv	a0,s6
 73a:	e91ff0ef          	jal	5ca <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 73e:	4981                	li	s3,0
 740:	b769                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 742:	008b8493          	addi	s1,s7,8
 746:	4685                	li	a3,1
 748:	4629                	li	a2,10
 74a:	000ba583          	lw	a1,0(s7)
 74e:	855a                	mv	a0,s6
 750:	e99ff0ef          	jal	5e8 <printint>
 754:	8ba6                	mv	s7,s1
      state = 0;
 756:	4981                	li	s3,0
 758:	bf8d                	j	6ca <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 75a:	06400793          	li	a5,100
 75e:	02f68963          	beq	a3,a5,790 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 762:	06c00793          	li	a5,108
 766:	04f68263          	beq	a3,a5,7aa <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 76a:	07500793          	li	a5,117
 76e:	0af68063          	beq	a3,a5,80e <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 772:	07800793          	li	a5,120
 776:	0ef68263          	beq	a3,a5,85a <vprintf+0x1da>
        putc(fd, '%');
 77a:	02500593          	li	a1,37
 77e:	855a                	mv	a0,s6
 780:	e4bff0ef          	jal	5ca <putc>
        putc(fd, c0);
 784:	85a6                	mv	a1,s1
 786:	855a                	mv	a0,s6
 788:	e43ff0ef          	jal	5ca <putc>
      state = 0;
 78c:	4981                	li	s3,0
 78e:	bf35                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 790:	008b8493          	addi	s1,s7,8
 794:	4685                	li	a3,1
 796:	4629                	li	a2,10
 798:	000bb583          	ld	a1,0(s7)
 79c:	855a                	mv	a0,s6
 79e:	e4bff0ef          	jal	5e8 <printint>
        i += 1;
 7a2:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7a4:	8ba6                	mv	s7,s1
      state = 0;
 7a6:	4981                	li	s3,0
        i += 1;
 7a8:	b70d                	j	6ca <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7aa:	06400793          	li	a5,100
 7ae:	02f60763          	beq	a2,a5,7dc <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7b2:	07500793          	li	a5,117
 7b6:	06f60963          	beq	a2,a5,828 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7ba:	07800793          	li	a5,120
 7be:	faf61ee3          	bne	a2,a5,77a <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7c2:	008b8493          	addi	s1,s7,8
 7c6:	4681                	li	a3,0
 7c8:	4641                	li	a2,16
 7ca:	000bb583          	ld	a1,0(s7)
 7ce:	855a                	mv	a0,s6
 7d0:	e19ff0ef          	jal	5e8 <printint>
        i += 2;
 7d4:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d6:	8ba6                	mv	s7,s1
      state = 0;
 7d8:	4981                	li	s3,0
        i += 2;
 7da:	bdc5                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7dc:	008b8493          	addi	s1,s7,8
 7e0:	4685                	li	a3,1
 7e2:	4629                	li	a2,10
 7e4:	000bb583          	ld	a1,0(s7)
 7e8:	855a                	mv	a0,s6
 7ea:	dffff0ef          	jal	5e8 <printint>
        i += 2;
 7ee:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f0:	8ba6                	mv	s7,s1
      state = 0;
 7f2:	4981                	li	s3,0
        i += 2;
 7f4:	bdd9                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7f6:	008b8493          	addi	s1,s7,8
 7fa:	4681                	li	a3,0
 7fc:	4629                	li	a2,10
 7fe:	000be583          	lwu	a1,0(s7)
 802:	855a                	mv	a0,s6
 804:	de5ff0ef          	jal	5e8 <printint>
 808:	8ba6                	mv	s7,s1
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bd7d                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 80e:	008b8493          	addi	s1,s7,8
 812:	4681                	li	a3,0
 814:	4629                	li	a2,10
 816:	000bb583          	ld	a1,0(s7)
 81a:	855a                	mv	a0,s6
 81c:	dcdff0ef          	jal	5e8 <printint>
        i += 1;
 820:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 822:	8ba6                	mv	s7,s1
      state = 0;
 824:	4981                	li	s3,0
        i += 1;
 826:	b555                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 828:	008b8493          	addi	s1,s7,8
 82c:	4681                	li	a3,0
 82e:	4629                	li	a2,10
 830:	000bb583          	ld	a1,0(s7)
 834:	855a                	mv	a0,s6
 836:	db3ff0ef          	jal	5e8 <printint>
        i += 2;
 83a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 83c:	8ba6                	mv	s7,s1
      state = 0;
 83e:	4981                	li	s3,0
        i += 2;
 840:	b569                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 842:	008b8493          	addi	s1,s7,8
 846:	4681                	li	a3,0
 848:	4641                	li	a2,16
 84a:	000be583          	lwu	a1,0(s7)
 84e:	855a                	mv	a0,s6
 850:	d99ff0ef          	jal	5e8 <printint>
 854:	8ba6                	mv	s7,s1
      state = 0;
 856:	4981                	li	s3,0
 858:	bd8d                	j	6ca <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 85a:	008b8493          	addi	s1,s7,8
 85e:	4681                	li	a3,0
 860:	4641                	li	a2,16
 862:	000bb583          	ld	a1,0(s7)
 866:	855a                	mv	a0,s6
 868:	d81ff0ef          	jal	5e8 <printint>
        i += 1;
 86c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 86e:	8ba6                	mv	s7,s1
      state = 0;
 870:	4981                	li	s3,0
        i += 1;
 872:	bda1                	j	6ca <vprintf+0x4a>
 874:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 876:	008b8d13          	addi	s10,s7,8
 87a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 87e:	03000593          	li	a1,48
 882:	855a                	mv	a0,s6
 884:	d47ff0ef          	jal	5ca <putc>
  putc(fd, 'x');
 888:	07800593          	li	a1,120
 88c:	855a                	mv	a0,s6
 88e:	d3dff0ef          	jal	5ca <putc>
 892:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 894:	00000b97          	auipc	s7,0x0
 898:	3fcb8b93          	addi	s7,s7,1020 # c90 <digits>
 89c:	03c9d793          	srli	a5,s3,0x3c
 8a0:	97de                	add	a5,a5,s7
 8a2:	0007c583          	lbu	a1,0(a5)
 8a6:	855a                	mv	a0,s6
 8a8:	d23ff0ef          	jal	5ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ac:	0992                	slli	s3,s3,0x4
 8ae:	34fd                	addiw	s1,s1,-1
 8b0:	f4f5                	bnez	s1,89c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 8b2:	8bea                	mv	s7,s10
      state = 0;
 8b4:	4981                	li	s3,0
 8b6:	6d02                	ld	s10,0(sp)
 8b8:	bd09                	j	6ca <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 8ba:	008b8493          	addi	s1,s7,8
 8be:	000bc583          	lbu	a1,0(s7)
 8c2:	855a                	mv	a0,s6
 8c4:	d07ff0ef          	jal	5ca <putc>
 8c8:	8ba6                	mv	s7,s1
      state = 0;
 8ca:	4981                	li	s3,0
 8cc:	bbfd                	j	6ca <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 8ce:	008b8993          	addi	s3,s7,8
 8d2:	000bb483          	ld	s1,0(s7)
 8d6:	cc91                	beqz	s1,8f2 <vprintf+0x272>
        for(; *s; s++)
 8d8:	0004c583          	lbu	a1,0(s1)
 8dc:	c195                	beqz	a1,900 <vprintf+0x280>
          putc(fd, *s);
 8de:	855a                	mv	a0,s6
 8e0:	cebff0ef          	jal	5ca <putc>
        for(; *s; s++)
 8e4:	0485                	addi	s1,s1,1
 8e6:	0004c583          	lbu	a1,0(s1)
 8ea:	f9f5                	bnez	a1,8de <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 8ec:	8bce                	mv	s7,s3
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	bbe9                	j	6ca <vprintf+0x4a>
          s = "(null)";
 8f2:	00000497          	auipc	s1,0x0
 8f6:	30e48493          	addi	s1,s1,782 # c00 <malloc+0x1fe>
        for(; *s; s++)
 8fa:	02800593          	li	a1,40
 8fe:	b7c5                	j	8de <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 900:	8bce                	mv	s7,s3
      state = 0;
 902:	4981                	li	s3,0
 904:	b3d9                	j	6ca <vprintf+0x4a>
 906:	6906                	ld	s2,64(sp)
 908:	79e2                	ld	s3,56(sp)
 90a:	7a42                	ld	s4,48(sp)
 90c:	7aa2                	ld	s5,40(sp)
 90e:	7b02                	ld	s6,32(sp)
 910:	6be2                	ld	s7,24(sp)
 912:	6c42                	ld	s8,16(sp)
 914:	6ca2                	ld	s9,8(sp)
    }
  }
}
 916:	60e6                	ld	ra,88(sp)
 918:	6446                	ld	s0,80(sp)
 91a:	64a6                	ld	s1,72(sp)
 91c:	6125                	addi	sp,sp,96
 91e:	8082                	ret

0000000000000920 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 920:	715d                	addi	sp,sp,-80
 922:	ec06                	sd	ra,24(sp)
 924:	e822                	sd	s0,16(sp)
 926:	1000                	addi	s0,sp,32
 928:	e010                	sd	a2,0(s0)
 92a:	e414                	sd	a3,8(s0)
 92c:	e818                	sd	a4,16(s0)
 92e:	ec1c                	sd	a5,24(s0)
 930:	03043023          	sd	a6,32(s0)
 934:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 938:	8622                	mv	a2,s0
 93a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 93e:	d43ff0ef          	jal	680 <vprintf>
}
 942:	60e2                	ld	ra,24(sp)
 944:	6442                	ld	s0,16(sp)
 946:	6161                	addi	sp,sp,80
 948:	8082                	ret

000000000000094a <printf>:

void
printf(const char *fmt, ...)
{
 94a:	711d                	addi	sp,sp,-96
 94c:	ec06                	sd	ra,24(sp)
 94e:	e822                	sd	s0,16(sp)
 950:	1000                	addi	s0,sp,32
 952:	e40c                	sd	a1,8(s0)
 954:	e810                	sd	a2,16(s0)
 956:	ec14                	sd	a3,24(s0)
 958:	f018                	sd	a4,32(s0)
 95a:	f41c                	sd	a5,40(s0)
 95c:	03043823          	sd	a6,48(s0)
 960:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 964:	00840613          	addi	a2,s0,8
 968:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 96c:	85aa                	mv	a1,a0
 96e:	4505                	li	a0,1
 970:	d11ff0ef          	jal	680 <vprintf>
}
 974:	60e2                	ld	ra,24(sp)
 976:	6442                	ld	s0,16(sp)
 978:	6125                	addi	sp,sp,96
 97a:	8082                	ret

000000000000097c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 97c:	1141                	addi	sp,sp,-16
 97e:	e406                	sd	ra,8(sp)
 980:	e022                	sd	s0,0(sp)
 982:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 984:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 988:	00001797          	auipc	a5,0x1
 98c:	6787b783          	ld	a5,1656(a5) # 2000 <freep>
 990:	a02d                	j	9ba <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 992:	4618                	lw	a4,8(a2)
 994:	9f2d                	addw	a4,a4,a1
 996:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 99a:	6398                	ld	a4,0(a5)
 99c:	6310                	ld	a2,0(a4)
 99e:	a83d                	j	9dc <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a0:	ff852703          	lw	a4,-8(a0)
 9a4:	9f31                	addw	a4,a4,a2
 9a6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9a8:	ff053683          	ld	a3,-16(a0)
 9ac:	a091                	j	9f0 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ae:	6398                	ld	a4,0(a5)
 9b0:	00e7e463          	bltu	a5,a4,9b8 <free+0x3c>
 9b4:	00e6ea63          	bltu	a3,a4,9c8 <free+0x4c>
{
 9b8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ba:	fed7fae3          	bgeu	a5,a3,9ae <free+0x32>
 9be:	6398                	ld	a4,0(a5)
 9c0:	00e6e463          	bltu	a3,a4,9c8 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c4:	fee7eae3          	bltu	a5,a4,9b8 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 9c8:	ff852583          	lw	a1,-8(a0)
 9cc:	6390                	ld	a2,0(a5)
 9ce:	02059813          	slli	a6,a1,0x20
 9d2:	01c85713          	srli	a4,a6,0x1c
 9d6:	9736                	add	a4,a4,a3
 9d8:	fae60de3          	beq	a2,a4,992 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 9dc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9e0:	4790                	lw	a2,8(a5)
 9e2:	02061593          	slli	a1,a2,0x20
 9e6:	01c5d713          	srli	a4,a1,0x1c
 9ea:	973e                	add	a4,a4,a5
 9ec:	fae68ae3          	beq	a3,a4,9a0 <free+0x24>
    p->s.ptr = bp->s.ptr;
 9f0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9f2:	00001717          	auipc	a4,0x1
 9f6:	60f73723          	sd	a5,1550(a4) # 2000 <freep>
}
 9fa:	60a2                	ld	ra,8(sp)
 9fc:	6402                	ld	s0,0(sp)
 9fe:	0141                	addi	sp,sp,16
 a00:	8082                	ret

0000000000000a02 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a02:	7139                	addi	sp,sp,-64
 a04:	fc06                	sd	ra,56(sp)
 a06:	f822                	sd	s0,48(sp)
 a08:	f04a                	sd	s2,32(sp)
 a0a:	ec4e                	sd	s3,24(sp)
 a0c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0e:	02051993          	slli	s3,a0,0x20
 a12:	0209d993          	srli	s3,s3,0x20
 a16:	09bd                	addi	s3,s3,15
 a18:	0049d993          	srli	s3,s3,0x4
 a1c:	2985                	addiw	s3,s3,1
 a1e:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a20:	00001517          	auipc	a0,0x1
 a24:	5e053503          	ld	a0,1504(a0) # 2000 <freep>
 a28:	c905                	beqz	a0,a58 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a2a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a2c:	4798                	lw	a4,8(a5)
 a2e:	09377663          	bgeu	a4,s3,aba <malloc+0xb8>
 a32:	f426                	sd	s1,40(sp)
 a34:	e852                	sd	s4,16(sp)
 a36:	e456                	sd	s5,8(sp)
 a38:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a3a:	8a4e                	mv	s4,s3
 a3c:	6705                	lui	a4,0x1
 a3e:	00e9f363          	bgeu	s3,a4,a44 <malloc+0x42>
 a42:	6a05                	lui	s4,0x1
 a44:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a48:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a4c:	00001497          	auipc	s1,0x1
 a50:	5b448493          	addi	s1,s1,1460 # 2000 <freep>
  if(p == SBRK_ERROR)
 a54:	5afd                	li	s5,-1
 a56:	a83d                	j	a94 <malloc+0x92>
 a58:	f426                	sd	s1,40(sp)
 a5a:	e852                	sd	s4,16(sp)
 a5c:	e456                	sd	s5,8(sp)
 a5e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a60:	00001797          	auipc	a5,0x1
 a64:	5b078793          	addi	a5,a5,1456 # 2010 <base>
 a68:	00001717          	auipc	a4,0x1
 a6c:	58f73c23          	sd	a5,1432(a4) # 2000 <freep>
 a70:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a72:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a76:	b7d1                	j	a3a <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a78:	6398                	ld	a4,0(a5)
 a7a:	e118                	sd	a4,0(a0)
 a7c:	a899                	j	ad2 <malloc+0xd0>
  hp->s.size = nu;
 a7e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a82:	0541                	addi	a0,a0,16
 a84:	ef9ff0ef          	jal	97c <free>
  return freep;
 a88:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a8a:	c125                	beqz	a0,aea <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a8e:	4798                	lw	a4,8(a5)
 a90:	03277163          	bgeu	a4,s2,ab2 <malloc+0xb0>
    if(p == freep)
 a94:	6098                	ld	a4,0(s1)
 a96:	853e                	mv	a0,a5
 a98:	fef71ae3          	bne	a4,a5,a8c <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 a9c:	8552                	mv	a0,s4
 a9e:	a59ff0ef          	jal	4f6 <sbrk>
  if(p == SBRK_ERROR)
 aa2:	fd551ee3          	bne	a0,s5,a7e <malloc+0x7c>
        return 0;
 aa6:	4501                	li	a0,0
 aa8:	74a2                	ld	s1,40(sp)
 aaa:	6a42                	ld	s4,16(sp)
 aac:	6aa2                	ld	s5,8(sp)
 aae:	6b02                	ld	s6,0(sp)
 ab0:	a03d                	j	ade <malloc+0xdc>
 ab2:	74a2                	ld	s1,40(sp)
 ab4:	6a42                	ld	s4,16(sp)
 ab6:	6aa2                	ld	s5,8(sp)
 ab8:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 aba:	fae90fe3          	beq	s2,a4,a78 <malloc+0x76>
        p->s.size -= nunits;
 abe:	4137073b          	subw	a4,a4,s3
 ac2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ac4:	02071693          	slli	a3,a4,0x20
 ac8:	01c6d713          	srli	a4,a3,0x1c
 acc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ace:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ad2:	00001717          	auipc	a4,0x1
 ad6:	52a73723          	sd	a0,1326(a4) # 2000 <freep>
      return (void*)(p + 1);
 ada:	01078513          	addi	a0,a5,16
  }
}
 ade:	70e2                	ld	ra,56(sp)
 ae0:	7442                	ld	s0,48(sp)
 ae2:	7902                	ld	s2,32(sp)
 ae4:	69e2                	ld	s3,24(sp)
 ae6:	6121                	addi	sp,sp,64
 ae8:	8082                	ret
 aea:	74a2                	ld	s1,40(sp)
 aec:	6a42                	ld	s4,16(sp)
 aee:	6aa2                	ld	s5,8(sp)
 af0:	6b02                	ld	s6,0(sp)
 af2:	b7f5                	j	ade <malloc+0xdc>
