
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	02c000ef          	jal	4a <matchhere>
  22:	e919                	bnez	a0,38 <matchstar+0x38>
  }while(*text!='\0' && (*text++==c || c=='.'));
  24:	0004c783          	lbu	a5,0(s1)
  28:	cb89                	beqz	a5,3a <matchstar+0x3a>
  2a:	0485                	addi	s1,s1,1
  2c:	2781                	sext.w	a5,a5
  2e:	ff2786e3          	beq	a5,s2,1a <matchstar+0x1a>
  32:	ff4904e3          	beq	s2,s4,1a <matchstar+0x1a>
  36:	a011                	j	3a <matchstar+0x3a>
      return 1;
  38:	4505                	li	a0,1
  return 0;
}
  3a:	70a2                	ld	ra,40(sp)
  3c:	7402                	ld	s0,32(sp)
  3e:	64e2                	ld	s1,24(sp)
  40:	6942                	ld	s2,16(sp)
  42:	69a2                	ld	s3,8(sp)
  44:	6a02                	ld	s4,0(sp)
  46:	6145                	addi	sp,sp,48
  48:	8082                	ret

000000000000004a <matchhere>:
  if(re[0] == '\0')
  4a:	00054703          	lbu	a4,0(a0)
  4e:	c73d                	beqz	a4,bc <matchhere+0x72>
{
  50:	1141                	addi	sp,sp,-16
  52:	e406                	sd	ra,8(sp)
  54:	e022                	sd	s0,0(sp)
  56:	0800                	addi	s0,sp,16
  58:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5a:	00154683          	lbu	a3,1(a0)
  5e:	02a00613          	li	a2,42
  62:	02c68563          	beq	a3,a2,8c <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  66:	02400613          	li	a2,36
  6a:	02c70863          	beq	a4,a2,9a <matchhere+0x50>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  6e:	0005c683          	lbu	a3,0(a1)
  return 0;
  72:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  74:	ca81                	beqz	a3,84 <matchhere+0x3a>
  76:	02e00613          	li	a2,46
  7a:	02c70b63          	beq	a4,a2,b0 <matchhere+0x66>
  return 0;
  7e:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  80:	02d70863          	beq	a4,a3,b0 <matchhere+0x66>
}
  84:	60a2                	ld	ra,8(sp)
  86:	6402                	ld	s0,0(sp)
  88:	0141                	addi	sp,sp,16
  8a:	8082                	ret
    return matchstar(re[0], re+2, text);
  8c:	862e                	mv	a2,a1
  8e:	00250593          	addi	a1,a0,2
  92:	853a                	mv	a0,a4
  94:	f6dff0ef          	jal	0 <matchstar>
  98:	b7f5                	j	84 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  9a:	c691                	beqz	a3,a6 <matchhere+0x5c>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  9c:	0005c683          	lbu	a3,0(a1)
  a0:	fef9                	bnez	a3,7e <matchhere+0x34>
  return 0;
  a2:	4501                	li	a0,0
  a4:	b7c5                	j	84 <matchhere+0x3a>
    return *text == '\0';
  a6:	0005c503          	lbu	a0,0(a1)
  aa:	00153513          	seqz	a0,a0
  ae:	bfd9                	j	84 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b0:	0585                	addi	a1,a1,1
  b2:	00178513          	addi	a0,a5,1
  b6:	f95ff0ef          	jal	4a <matchhere>
  ba:	b7e9                	j	84 <matchhere+0x3a>
    return 1;
  bc:	4505                	li	a0,1
}
  be:	8082                	ret

00000000000000c0 <match>:
{
  c0:	1101                	addi	sp,sp,-32
  c2:	ec06                	sd	ra,24(sp)
  c4:	e822                	sd	s0,16(sp)
  c6:	e426                	sd	s1,8(sp)
  c8:	e04a                	sd	s2,0(sp)
  ca:	1000                	addi	s0,sp,32
  cc:	892a                	mv	s2,a0
  ce:	84ae                	mv	s1,a1
  if(re[0] == '^')
  d0:	00054703          	lbu	a4,0(a0)
  d4:	05e00793          	li	a5,94
  d8:	00f70c63          	beq	a4,a5,f0 <match+0x30>
    if(matchhere(re, text))
  dc:	85a6                	mv	a1,s1
  de:	854a                	mv	a0,s2
  e0:	f6bff0ef          	jal	4a <matchhere>
  e4:	e911                	bnez	a0,f8 <match+0x38>
  }while(*text++ != '\0');
  e6:	0485                	addi	s1,s1,1
  e8:	fff4c783          	lbu	a5,-1(s1)
  ec:	fbe5                	bnez	a5,dc <match+0x1c>
  ee:	a031                	j	fa <match+0x3a>
    return matchhere(re+1, text);
  f0:	0505                	addi	a0,a0,1
  f2:	f59ff0ef          	jal	4a <matchhere>
  f6:	a011                	j	fa <match+0x3a>
      return 1;
  f8:	4505                	li	a0,1
}
  fa:	60e2                	ld	ra,24(sp)
  fc:	6442                	ld	s0,16(sp)
  fe:	64a2                	ld	s1,8(sp)
 100:	6902                	ld	s2,0(sp)
 102:	6105                	addi	sp,sp,32
 104:	8082                	ret

0000000000000106 <grep>:
{
 106:	711d                	addi	sp,sp,-96
 108:	ec86                	sd	ra,88(sp)
 10a:	e8a2                	sd	s0,80(sp)
 10c:	e4a6                	sd	s1,72(sp)
 10e:	e0ca                	sd	s2,64(sp)
 110:	fc4e                	sd	s3,56(sp)
 112:	f852                	sd	s4,48(sp)
 114:	f456                	sd	s5,40(sp)
 116:	f05a                	sd	s6,32(sp)
 118:	ec5e                	sd	s7,24(sp)
 11a:	e862                	sd	s8,16(sp)
 11c:	e466                	sd	s9,8(sp)
 11e:	e06a                	sd	s10,0(sp)
 120:	1080                	addi	s0,sp,96
 122:	8aaa                	mv	s5,a0
 124:	8cae                	mv	s9,a1
  m = 0;
 126:	4b01                	li	s6,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 128:	3ff00d13          	li	s10,1023
 12c:	00002b97          	auipc	s7,0x2
 130:	ee4b8b93          	addi	s7,s7,-284 # 2010 <buf>
    while((q = strchr(p, '\n')) != 0){
 134:	49a9                	li	s3,10
        write(1, p, q+1 - p);
 136:	4c05                	li	s8,1
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 138:	a82d                	j	172 <grep+0x6c>
      p = q+1;
 13a:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 13e:	85ce                	mv	a1,s3
 140:	854a                	mv	a0,s2
 142:	1d6000ef          	jal	318 <strchr>
 146:	84aa                	mv	s1,a0
 148:	c11d                	beqz	a0,16e <grep+0x68>
      *q = 0;
 14a:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 14e:	85ca                	mv	a1,s2
 150:	8556                	mv	a0,s5
 152:	f6fff0ef          	jal	c0 <match>
 156:	d175                	beqz	a0,13a <grep+0x34>
        *q = '\n';
 158:	01348023          	sb	s3,0(s1)
        write(1, p, q+1 - p);
 15c:	00148613          	addi	a2,s1,1
 160:	4126063b          	subw	a2,a2,s2
 164:	85ca                	mv	a1,s2
 166:	8562                	mv	a0,s8
 168:	3e4000ef          	jal	54c <write>
 16c:	b7f9                	j	13a <grep+0x34>
    if(m > 0){
 16e:	03604463          	bgtz	s6,196 <grep+0x90>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 172:	416d063b          	subw	a2,s10,s6
 176:	016b85b3          	add	a1,s7,s6
 17a:	8566                	mv	a0,s9
 17c:	3c8000ef          	jal	544 <read>
 180:	02a05863          	blez	a0,1b0 <grep+0xaa>
    m += n;
 184:	00ab0a3b          	addw	s4,s6,a0
 188:	8b52                	mv	s6,s4
    buf[m] = '\0';
 18a:	014b87b3          	add	a5,s7,s4
 18e:	00078023          	sb	zero,0(a5)
    p = buf;
 192:	895e                	mv	s2,s7
    while((q = strchr(p, '\n')) != 0){
 194:	b76d                	j	13e <grep+0x38>
      m -= p - buf;
 196:	00002517          	auipc	a0,0x2
 19a:	e7a50513          	addi	a0,a0,-390 # 2010 <buf>
 19e:	40a907b3          	sub	a5,s2,a0
 1a2:	40fa063b          	subw	a2,s4,a5
 1a6:	8b32                	mv	s6,a2
      memmove(buf, p, m);
 1a8:	85ca                	mv	a1,s2
 1aa:	2a0000ef          	jal	44a <memmove>
 1ae:	b7d1                	j	172 <grep+0x6c>
}
 1b0:	60e6                	ld	ra,88(sp)
 1b2:	6446                	ld	s0,80(sp)
 1b4:	64a6                	ld	s1,72(sp)
 1b6:	6906                	ld	s2,64(sp)
 1b8:	79e2                	ld	s3,56(sp)
 1ba:	7a42                	ld	s4,48(sp)
 1bc:	7aa2                	ld	s5,40(sp)
 1be:	7b02                	ld	s6,32(sp)
 1c0:	6be2                	ld	s7,24(sp)
 1c2:	6c42                	ld	s8,16(sp)
 1c4:	6ca2                	ld	s9,8(sp)
 1c6:	6d02                	ld	s10,0(sp)
 1c8:	6125                	addi	sp,sp,96
 1ca:	8082                	ret

00000000000001cc <main>:
{
 1cc:	7179                	addi	sp,sp,-48
 1ce:	f406                	sd	ra,40(sp)
 1d0:	f022                	sd	s0,32(sp)
 1d2:	ec26                	sd	s1,24(sp)
 1d4:	e84a                	sd	s2,16(sp)
 1d6:	e44e                	sd	s3,8(sp)
 1d8:	e052                	sd	s4,0(sp)
 1da:	1800                	addi	s0,sp,48
  if(argc <= 1){
 1dc:	4785                	li	a5,1
 1de:	04a7d663          	bge	a5,a0,22a <main+0x5e>
  pattern = argv[1];
 1e2:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1e6:	4789                	li	a5,2
 1e8:	04a7db63          	bge	a5,a0,23e <main+0x72>
 1ec:	01058913          	addi	s2,a1,16
 1f0:	ffd5099b          	addiw	s3,a0,-3
 1f4:	02099793          	slli	a5,s3,0x20
 1f8:	01d7d993          	srli	s3,a5,0x1d
 1fc:	05e1                	addi	a1,a1,24
 1fe:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], O_RDONLY)) < 0){
 200:	4581                	li	a1,0
 202:	00093503          	ld	a0,0(s2)
 206:	366000ef          	jal	56c <open>
 20a:	84aa                	mv	s1,a0
 20c:	04054063          	bltz	a0,24c <main+0x80>
    grep(pattern, fd);
 210:	85aa                	mv	a1,a0
 212:	8552                	mv	a0,s4
 214:	ef3ff0ef          	jal	106 <grep>
    close(fd);
 218:	8526                	mv	a0,s1
 21a:	33a000ef          	jal	554 <close>
  for(i = 2; i < argc; i++){
 21e:	0921                	addi	s2,s2,8
 220:	ff3910e3          	bne	s2,s3,200 <main+0x34>
  exit(0);
 224:	4501                	li	a0,0
 226:	306000ef          	jal	52c <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 22a:	00001597          	auipc	a1,0x1
 22e:	8d658593          	addi	a1,a1,-1834 # b00 <malloc+0xfc>
 232:	4509                	li	a0,2
 234:	6ee000ef          	jal	922 <fprintf>
    exit(1);
 238:	4505                	li	a0,1
 23a:	2f2000ef          	jal	52c <exit>
    grep(pattern, 0);
 23e:	4581                	li	a1,0
 240:	8552                	mv	a0,s4
 242:	ec5ff0ef          	jal	106 <grep>
    exit(0);
 246:	4501                	li	a0,0
 248:	2e4000ef          	jal	52c <exit>
      printf("grep: cannot open %s\n", argv[i]);
 24c:	00093583          	ld	a1,0(s2)
 250:	00001517          	auipc	a0,0x1
 254:	8d050513          	addi	a0,a0,-1840 # b20 <malloc+0x11c>
 258:	6f4000ef          	jal	94c <printf>
      exit(1);
 25c:	4505                	li	a0,1
 25e:	2ce000ef          	jal	52c <exit>

0000000000000262 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 262:	1141                	addi	sp,sp,-16
 264:	e406                	sd	ra,8(sp)
 266:	e022                	sd	s0,0(sp)
 268:	0800                	addi	s0,sp,16
  extern int main();
  main();
 26a:	f63ff0ef          	jal	1cc <main>
  exit(0);
 26e:	4501                	li	a0,0
 270:	2bc000ef          	jal	52c <exit>

0000000000000274 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 274:	1141                	addi	sp,sp,-16
 276:	e406                	sd	ra,8(sp)
 278:	e022                	sd	s0,0(sp)
 27a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 27c:	87aa                	mv	a5,a0
 27e:	0585                	addi	a1,a1,1
 280:	0785                	addi	a5,a5,1
 282:	fff5c703          	lbu	a4,-1(a1)
 286:	fee78fa3          	sb	a4,-1(a5)
 28a:	fb75                	bnez	a4,27e <strcpy+0xa>
    ;
  return os;
}
 28c:	60a2                	ld	ra,8(sp)
 28e:	6402                	ld	s0,0(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	cb91                	beqz	a5,2b4 <strcmp+0x20>
 2a2:	0005c703          	lbu	a4,0(a1)
 2a6:	00f71763          	bne	a4,a5,2b4 <strcmp+0x20>
    p++, q++;
 2aa:	0505                	addi	a0,a0,1
 2ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	fbe5                	bnez	a5,2a2 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2b4:	0005c503          	lbu	a0,0(a1)
}
 2b8:	40a7853b          	subw	a0,a5,a0
 2bc:	60a2                	ld	ra,8(sp)
 2be:	6402                	ld	s0,0(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <strlen>:

uint
strlen(const char *s)
{
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2cc:	00054783          	lbu	a5,0(a0)
 2d0:	cf99                	beqz	a5,2ee <strlen+0x2a>
 2d2:	0505                	addi	a0,a0,1
 2d4:	87aa                	mv	a5,a0
 2d6:	86be                	mv	a3,a5
 2d8:	0785                	addi	a5,a5,1
 2da:	fff7c703          	lbu	a4,-1(a5)
 2de:	ff65                	bnez	a4,2d6 <strlen+0x12>
 2e0:	40a6853b          	subw	a0,a3,a0
 2e4:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 2e6:	60a2                	ld	ra,8(sp)
 2e8:	6402                	ld	s0,0(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret
  for(n = 0; s[n]; n++)
 2ee:	4501                	li	a0,0
 2f0:	bfdd                	j	2e6 <strlen+0x22>

00000000000002f2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2f2:	1141                	addi	sp,sp,-16
 2f4:	e406                	sd	ra,8(sp)
 2f6:	e022                	sd	s0,0(sp)
 2f8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2fa:	ca19                	beqz	a2,310 <memset+0x1e>
 2fc:	87aa                	mv	a5,a0
 2fe:	1602                	slli	a2,a2,0x20
 300:	9201                	srli	a2,a2,0x20
 302:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 306:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 30a:	0785                	addi	a5,a5,1
 30c:	fee79de3          	bne	a5,a4,306 <memset+0x14>
  }
  return dst;
}
 310:	60a2                	ld	ra,8(sp)
 312:	6402                	ld	s0,0(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret

0000000000000318 <strchr>:

char*
strchr(const char *s, char c)
{
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 320:	00054783          	lbu	a5,0(a0)
 324:	cf81                	beqz	a5,33c <strchr+0x24>
    if(*s == c)
 326:	00f58763          	beq	a1,a5,334 <strchr+0x1c>
  for(; *s; s++)
 32a:	0505                	addi	a0,a0,1
 32c:	00054783          	lbu	a5,0(a0)
 330:	fbfd                	bnez	a5,326 <strchr+0xe>
      return (char*)s;
  return 0;
 332:	4501                	li	a0,0
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret
  return 0;
 33c:	4501                	li	a0,0
 33e:	bfdd                	j	334 <strchr+0x1c>

0000000000000340 <gets>:

char*
gets(char *buf, int max)
{
 340:	7159                	addi	sp,sp,-112
 342:	f486                	sd	ra,104(sp)
 344:	f0a2                	sd	s0,96(sp)
 346:	eca6                	sd	s1,88(sp)
 348:	e8ca                	sd	s2,80(sp)
 34a:	e4ce                	sd	s3,72(sp)
 34c:	e0d2                	sd	s4,64(sp)
 34e:	fc56                	sd	s5,56(sp)
 350:	f85a                	sd	s6,48(sp)
 352:	f45e                	sd	s7,40(sp)
 354:	f062                	sd	s8,32(sp)
 356:	ec66                	sd	s9,24(sp)
 358:	e86a                	sd	s10,16(sp)
 35a:	1880                	addi	s0,sp,112
 35c:	8caa                	mv	s9,a0
 35e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 360:	892a                	mv	s2,a0
 362:	4481                	li	s1,0
    cc = read(0, &c, 1);
 364:	f9f40b13          	addi	s6,s0,-97
 368:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 36a:	4ba9                	li	s7,10
 36c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 36e:	8d26                	mv	s10,s1
 370:	0014899b          	addiw	s3,s1,1
 374:	84ce                	mv	s1,s3
 376:	0349d563          	bge	s3,s4,3a0 <gets+0x60>
    cc = read(0, &c, 1);
 37a:	8656                	mv	a2,s5
 37c:	85da                	mv	a1,s6
 37e:	4501                	li	a0,0
 380:	1c4000ef          	jal	544 <read>
    if(cc < 1)
 384:	00a05e63          	blez	a0,3a0 <gets+0x60>
    buf[i++] = c;
 388:	f9f44783          	lbu	a5,-97(s0)
 38c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 390:	01778763          	beq	a5,s7,39e <gets+0x5e>
 394:	0905                	addi	s2,s2,1
 396:	fd879ce3          	bne	a5,s8,36e <gets+0x2e>
    buf[i++] = c;
 39a:	8d4e                	mv	s10,s3
 39c:	a011                	j	3a0 <gets+0x60>
 39e:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 3a0:	9d66                	add	s10,s10,s9
 3a2:	000d0023          	sb	zero,0(s10)
  return buf;
}
 3a6:	8566                	mv	a0,s9
 3a8:	70a6                	ld	ra,104(sp)
 3aa:	7406                	ld	s0,96(sp)
 3ac:	64e6                	ld	s1,88(sp)
 3ae:	6946                	ld	s2,80(sp)
 3b0:	69a6                	ld	s3,72(sp)
 3b2:	6a06                	ld	s4,64(sp)
 3b4:	7ae2                	ld	s5,56(sp)
 3b6:	7b42                	ld	s6,48(sp)
 3b8:	7ba2                	ld	s7,40(sp)
 3ba:	7c02                	ld	s8,32(sp)
 3bc:	6ce2                	ld	s9,24(sp)
 3be:	6d42                	ld	s10,16(sp)
 3c0:	6165                	addi	sp,sp,112
 3c2:	8082                	ret

00000000000003c4 <stat>:

int
stat(const char *n, struct stat *st)
{
 3c4:	1101                	addi	sp,sp,-32
 3c6:	ec06                	sd	ra,24(sp)
 3c8:	e822                	sd	s0,16(sp)
 3ca:	e04a                	sd	s2,0(sp)
 3cc:	1000                	addi	s0,sp,32
 3ce:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d0:	4581                	li	a1,0
 3d2:	19a000ef          	jal	56c <open>
  if(fd < 0)
 3d6:	02054263          	bltz	a0,3fa <stat+0x36>
 3da:	e426                	sd	s1,8(sp)
 3dc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3de:	85ca                	mv	a1,s2
 3e0:	1a4000ef          	jal	584 <fstat>
 3e4:	892a                	mv	s2,a0
  close(fd);
 3e6:	8526                	mv	a0,s1
 3e8:	16c000ef          	jal	554 <close>
  return r;
 3ec:	64a2                	ld	s1,8(sp)
}
 3ee:	854a                	mv	a0,s2
 3f0:	60e2                	ld	ra,24(sp)
 3f2:	6442                	ld	s0,16(sp)
 3f4:	6902                	ld	s2,0(sp)
 3f6:	6105                	addi	sp,sp,32
 3f8:	8082                	ret
    return -1;
 3fa:	597d                	li	s2,-1
 3fc:	bfcd                	j	3ee <stat+0x2a>

00000000000003fe <atoi>:

int
atoi(const char *s)
{
 3fe:	1141                	addi	sp,sp,-16
 400:	e406                	sd	ra,8(sp)
 402:	e022                	sd	s0,0(sp)
 404:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 406:	00054683          	lbu	a3,0(a0)
 40a:	fd06879b          	addiw	a5,a3,-48
 40e:	0ff7f793          	zext.b	a5,a5
 412:	4625                	li	a2,9
 414:	02f66963          	bltu	a2,a5,446 <atoi+0x48>
 418:	872a                	mv	a4,a0
  n = 0;
 41a:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 41c:	0705                	addi	a4,a4,1
 41e:	0025179b          	slliw	a5,a0,0x2
 422:	9fa9                	addw	a5,a5,a0
 424:	0017979b          	slliw	a5,a5,0x1
 428:	9fb5                	addw	a5,a5,a3
 42a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 42e:	00074683          	lbu	a3,0(a4)
 432:	fd06879b          	addiw	a5,a3,-48
 436:	0ff7f793          	zext.b	a5,a5
 43a:	fef671e3          	bgeu	a2,a5,41c <atoi+0x1e>
  return n;
}
 43e:	60a2                	ld	ra,8(sp)
 440:	6402                	ld	s0,0(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret
  n = 0;
 446:	4501                	li	a0,0
 448:	bfdd                	j	43e <atoi+0x40>

000000000000044a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e406                	sd	ra,8(sp)
 44e:	e022                	sd	s0,0(sp)
 450:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 452:	02b57563          	bgeu	a0,a1,47c <memmove+0x32>
    while(n-- > 0)
 456:	00c05f63          	blez	a2,474 <memmove+0x2a>
 45a:	1602                	slli	a2,a2,0x20
 45c:	9201                	srli	a2,a2,0x20
 45e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 462:	872a                	mv	a4,a0
      *dst++ = *src++;
 464:	0585                	addi	a1,a1,1
 466:	0705                	addi	a4,a4,1
 468:	fff5c683          	lbu	a3,-1(a1)
 46c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 470:	fee79ae3          	bne	a5,a4,464 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 474:	60a2                	ld	ra,8(sp)
 476:	6402                	ld	s0,0(sp)
 478:	0141                	addi	sp,sp,16
 47a:	8082                	ret
    dst += n;
 47c:	00c50733          	add	a4,a0,a2
    src += n;
 480:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 482:	fec059e3          	blez	a2,474 <memmove+0x2a>
 486:	fff6079b          	addiw	a5,a2,-1
 48a:	1782                	slli	a5,a5,0x20
 48c:	9381                	srli	a5,a5,0x20
 48e:	fff7c793          	not	a5,a5
 492:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 494:	15fd                	addi	a1,a1,-1
 496:	177d                	addi	a4,a4,-1
 498:	0005c683          	lbu	a3,0(a1)
 49c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4a0:	fef71ae3          	bne	a4,a5,494 <memmove+0x4a>
 4a4:	bfc1                	j	474 <memmove+0x2a>

00000000000004a6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a6:	1141                	addi	sp,sp,-16
 4a8:	e406                	sd	ra,8(sp)
 4aa:	e022                	sd	s0,0(sp)
 4ac:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4ae:	ca0d                	beqz	a2,4e0 <memcmp+0x3a>
 4b0:	fff6069b          	addiw	a3,a2,-1
 4b4:	1682                	slli	a3,a3,0x20
 4b6:	9281                	srli	a3,a3,0x20
 4b8:	0685                	addi	a3,a3,1
 4ba:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4bc:	00054783          	lbu	a5,0(a0)
 4c0:	0005c703          	lbu	a4,0(a1)
 4c4:	00e79863          	bne	a5,a4,4d4 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 4c8:	0505                	addi	a0,a0,1
    p2++;
 4ca:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4cc:	fed518e3          	bne	a0,a3,4bc <memcmp+0x16>
  }
  return 0;
 4d0:	4501                	li	a0,0
 4d2:	a019                	j	4d8 <memcmp+0x32>
      return *p1 - *p2;
 4d4:	40e7853b          	subw	a0,a5,a4
}
 4d8:	60a2                	ld	ra,8(sp)
 4da:	6402                	ld	s0,0(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret
  return 0;
 4e0:	4501                	li	a0,0
 4e2:	bfdd                	j	4d8 <memcmp+0x32>

00000000000004e4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4e4:	1141                	addi	sp,sp,-16
 4e6:	e406                	sd	ra,8(sp)
 4e8:	e022                	sd	s0,0(sp)
 4ea:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4ec:	f5fff0ef          	jal	44a <memmove>
}
 4f0:	60a2                	ld	ra,8(sp)
 4f2:	6402                	ld	s0,0(sp)
 4f4:	0141                	addi	sp,sp,16
 4f6:	8082                	ret

00000000000004f8 <sbrk>:

char *
sbrk(int n) {
 4f8:	1141                	addi	sp,sp,-16
 4fa:	e406                	sd	ra,8(sp)
 4fc:	e022                	sd	s0,0(sp)
 4fe:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 500:	4585                	li	a1,1
 502:	0b2000ef          	jal	5b4 <sys_sbrk>
}
 506:	60a2                	ld	ra,8(sp)
 508:	6402                	ld	s0,0(sp)
 50a:	0141                	addi	sp,sp,16
 50c:	8082                	ret

000000000000050e <sbrklazy>:

char *
sbrklazy(int n) {
 50e:	1141                	addi	sp,sp,-16
 510:	e406                	sd	ra,8(sp)
 512:	e022                	sd	s0,0(sp)
 514:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 516:	4589                	li	a1,2
 518:	09c000ef          	jal	5b4 <sys_sbrk>
}
 51c:	60a2                	ld	ra,8(sp)
 51e:	6402                	ld	s0,0(sp)
 520:	0141                	addi	sp,sp,16
 522:	8082                	ret

0000000000000524 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 524:	4885                	li	a7,1
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <exit>:
.global exit
exit:
 li a7, SYS_exit
 52c:	4889                	li	a7,2
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <wait>:
.global wait
wait:
 li a7, SYS_wait
 534:	488d                	li	a7,3
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 53c:	4891                	li	a7,4
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <read>:
.global read
read:
 li a7, SYS_read
 544:	4895                	li	a7,5
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <write>:
.global write
write:
 li a7, SYS_write
 54c:	48c1                	li	a7,16
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <close>:
.global close
close:
 li a7, SYS_close
 554:	48d5                	li	a7,21
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <kill>:
.global kill
kill:
 li a7, SYS_kill
 55c:	4899                	li	a7,6
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <exec>:
.global exec
exec:
 li a7, SYS_exec
 564:	489d                	li	a7,7
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <open>:
.global open
open:
 li a7, SYS_open
 56c:	48bd                	li	a7,15
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 574:	48c5                	li	a7,17
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 57c:	48c9                	li	a7,18
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 584:	48a1                	li	a7,8
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <link>:
.global link
link:
 li a7, SYS_link
 58c:	48cd                	li	a7,19
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 594:	48d1                	li	a7,20
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 59c:	48a5                	li	a7,9
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a4:	48a9                	li	a7,10
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5ac:	48ad                	li	a7,11
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5b4:	48b1                	li	a7,12
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <pause>:
.global pause
pause:
 li a7, SYS_pause
 5bc:	48b5                	li	a7,13
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c4:	48b9                	li	a7,14
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5cc:	1101                	addi	sp,sp,-32
 5ce:	ec06                	sd	ra,24(sp)
 5d0:	e822                	sd	s0,16(sp)
 5d2:	1000                	addi	s0,sp,32
 5d4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d8:	4605                	li	a2,1
 5da:	fef40593          	addi	a1,s0,-17
 5de:	f6fff0ef          	jal	54c <write>
}
 5e2:	60e2                	ld	ra,24(sp)
 5e4:	6442                	ld	s0,16(sp)
 5e6:	6105                	addi	sp,sp,32
 5e8:	8082                	ret

00000000000005ea <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 5ea:	715d                	addi	sp,sp,-80
 5ec:	e486                	sd	ra,72(sp)
 5ee:	e0a2                	sd	s0,64(sp)
 5f0:	fc26                	sd	s1,56(sp)
 5f2:	f84a                	sd	s2,48(sp)
 5f4:	f44e                	sd	s3,40(sp)
 5f6:	0880                	addi	s0,sp,80
 5f8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5fa:	c299                	beqz	a3,600 <printint+0x16>
 5fc:	0605cf63          	bltz	a1,67a <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 600:	2581                	sext.w	a1,a1
  neg = 0;
 602:	4e01                	li	t3,0
  }

  i = 0;
 604:	fb840313          	addi	t1,s0,-72
  neg = 0;
 608:	869a                	mv	a3,t1
  i = 0;
 60a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 60c:	00000817          	auipc	a6,0x0
 610:	53480813          	addi	a6,a6,1332 # b40 <digits>
 614:	88be                	mv	a7,a5
 616:	0017851b          	addiw	a0,a5,1
 61a:	87aa                	mv	a5,a0
 61c:	02c5f73b          	remuw	a4,a1,a2
 620:	1702                	slli	a4,a4,0x20
 622:	9301                	srli	a4,a4,0x20
 624:	9742                	add	a4,a4,a6
 626:	00074703          	lbu	a4,0(a4)
 62a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 62e:	872e                	mv	a4,a1
 630:	02c5d5bb          	divuw	a1,a1,a2
 634:	0685                	addi	a3,a3,1
 636:	fcc77fe3          	bgeu	a4,a2,614 <printint+0x2a>
  if(neg)
 63a:	000e0c63          	beqz	t3,652 <printint+0x68>
    buf[i++] = '-';
 63e:	fd050793          	addi	a5,a0,-48
 642:	00878533          	add	a0,a5,s0
 646:	02d00793          	li	a5,45
 64a:	fef50423          	sb	a5,-24(a0)
 64e:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 652:	fff7899b          	addiw	s3,a5,-1
 656:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 65a:	fff4c583          	lbu	a1,-1(s1)
 65e:	854a                	mv	a0,s2
 660:	f6dff0ef          	jal	5cc <putc>
  while(--i >= 0)
 664:	39fd                	addiw	s3,s3,-1
 666:	14fd                	addi	s1,s1,-1
 668:	fe09d9e3          	bgez	s3,65a <printint+0x70>
}
 66c:	60a6                	ld	ra,72(sp)
 66e:	6406                	ld	s0,64(sp)
 670:	74e2                	ld	s1,56(sp)
 672:	7942                	ld	s2,48(sp)
 674:	79a2                	ld	s3,40(sp)
 676:	6161                	addi	sp,sp,80
 678:	8082                	ret
    x = -xx;
 67a:	40b005bb          	negw	a1,a1
    neg = 1;
 67e:	4e05                	li	t3,1
    x = -xx;
 680:	b751                	j	604 <printint+0x1a>

0000000000000682 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 682:	711d                	addi	sp,sp,-96
 684:	ec86                	sd	ra,88(sp)
 686:	e8a2                	sd	s0,80(sp)
 688:	e4a6                	sd	s1,72(sp)
 68a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 68c:	0005c483          	lbu	s1,0(a1)
 690:	28048463          	beqz	s1,918 <vprintf+0x296>
 694:	e0ca                	sd	s2,64(sp)
 696:	fc4e                	sd	s3,56(sp)
 698:	f852                	sd	s4,48(sp)
 69a:	f456                	sd	s5,40(sp)
 69c:	f05a                	sd	s6,32(sp)
 69e:	ec5e                	sd	s7,24(sp)
 6a0:	e862                	sd	s8,16(sp)
 6a2:	e466                	sd	s9,8(sp)
 6a4:	8b2a                	mv	s6,a0
 6a6:	8a2e                	mv	s4,a1
 6a8:	8bb2                	mv	s7,a2
  state = 0;
 6aa:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6ac:	4901                	li	s2,0
 6ae:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6b0:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6b8:	06c00c93          	li	s9,108
 6bc:	a00d                	j	6de <vprintf+0x5c>
        putc(fd, c0);
 6be:	85a6                	mv	a1,s1
 6c0:	855a                	mv	a0,s6
 6c2:	f0bff0ef          	jal	5cc <putc>
 6c6:	a019                	j	6cc <vprintf+0x4a>
    } else if(state == '%'){
 6c8:	03598363          	beq	s3,s5,6ee <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 6cc:	0019079b          	addiw	a5,s2,1
 6d0:	893e                	mv	s2,a5
 6d2:	873e                	mv	a4,a5
 6d4:	97d2                	add	a5,a5,s4
 6d6:	0007c483          	lbu	s1,0(a5)
 6da:	22048763          	beqz	s1,908 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 6de:	0004879b          	sext.w	a5,s1
    if(state == 0){
 6e2:	fe0993e3          	bnez	s3,6c8 <vprintf+0x46>
      if(c0 == '%'){
 6e6:	fd579ce3          	bne	a5,s5,6be <vprintf+0x3c>
        state = '%';
 6ea:	89be                	mv	s3,a5
 6ec:	b7c5                	j	6cc <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 6ee:	00ea06b3          	add	a3,s4,a4
 6f2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 6f6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 6f8:	c681                	beqz	a3,700 <vprintf+0x7e>
 6fa:	9752                	add	a4,a4,s4
 6fc:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 700:	05878263          	beq	a5,s8,744 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 704:	05978c63          	beq	a5,s9,75c <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 708:	07500713          	li	a4,117
 70c:	0ee78663          	beq	a5,a4,7f8 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 710:	07800713          	li	a4,120
 714:	12e78863          	beq	a5,a4,844 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 718:	07000713          	li	a4,112
 71c:	14e78d63          	beq	a5,a4,876 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 720:	06300713          	li	a4,99
 724:	18e78c63          	beq	a5,a4,8bc <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 728:	07300713          	li	a4,115
 72c:	1ae78263          	beq	a5,a4,8d0 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 730:	02500713          	li	a4,37
 734:	04e79463          	bne	a5,a4,77c <vprintf+0xfa>
        putc(fd, '%');
 738:	85ba                	mv	a1,a4
 73a:	855a                	mv	a0,s6
 73c:	e91ff0ef          	jal	5cc <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 740:	4981                	li	s3,0
 742:	b769                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 744:	008b8493          	addi	s1,s7,8
 748:	4685                	li	a3,1
 74a:	4629                	li	a2,10
 74c:	000ba583          	lw	a1,0(s7)
 750:	855a                	mv	a0,s6
 752:	e99ff0ef          	jal	5ea <printint>
 756:	8ba6                	mv	s7,s1
      state = 0;
 758:	4981                	li	s3,0
 75a:	bf8d                	j	6cc <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 75c:	06400793          	li	a5,100
 760:	02f68963          	beq	a3,a5,792 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 764:	06c00793          	li	a5,108
 768:	04f68263          	beq	a3,a5,7ac <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 76c:	07500793          	li	a5,117
 770:	0af68063          	beq	a3,a5,810 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 774:	07800793          	li	a5,120
 778:	0ef68263          	beq	a3,a5,85c <vprintf+0x1da>
        putc(fd, '%');
 77c:	02500593          	li	a1,37
 780:	855a                	mv	a0,s6
 782:	e4bff0ef          	jal	5cc <putc>
        putc(fd, c0);
 786:	85a6                	mv	a1,s1
 788:	855a                	mv	a0,s6
 78a:	e43ff0ef          	jal	5cc <putc>
      state = 0;
 78e:	4981                	li	s3,0
 790:	bf35                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 792:	008b8493          	addi	s1,s7,8
 796:	4685                	li	a3,1
 798:	4629                	li	a2,10
 79a:	000bb583          	ld	a1,0(s7)
 79e:	855a                	mv	a0,s6
 7a0:	e4bff0ef          	jal	5ea <printint>
        i += 1;
 7a4:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7a6:	8ba6                	mv	s7,s1
      state = 0;
 7a8:	4981                	li	s3,0
        i += 1;
 7aa:	b70d                	j	6cc <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7ac:	06400793          	li	a5,100
 7b0:	02f60763          	beq	a2,a5,7de <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7b4:	07500793          	li	a5,117
 7b8:	06f60963          	beq	a2,a5,82a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7bc:	07800793          	li	a5,120
 7c0:	faf61ee3          	bne	a2,a5,77c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7c4:	008b8493          	addi	s1,s7,8
 7c8:	4681                	li	a3,0
 7ca:	4641                	li	a2,16
 7cc:	000bb583          	ld	a1,0(s7)
 7d0:	855a                	mv	a0,s6
 7d2:	e19ff0ef          	jal	5ea <printint>
        i += 2;
 7d6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d8:	8ba6                	mv	s7,s1
      state = 0;
 7da:	4981                	li	s3,0
        i += 2;
 7dc:	bdc5                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7de:	008b8493          	addi	s1,s7,8
 7e2:	4685                	li	a3,1
 7e4:	4629                	li	a2,10
 7e6:	000bb583          	ld	a1,0(s7)
 7ea:	855a                	mv	a0,s6
 7ec:	dffff0ef          	jal	5ea <printint>
        i += 2;
 7f0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 7f2:	8ba6                	mv	s7,s1
      state = 0;
 7f4:	4981                	li	s3,0
        i += 2;
 7f6:	bdd9                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 7f8:	008b8493          	addi	s1,s7,8
 7fc:	4681                	li	a3,0
 7fe:	4629                	li	a2,10
 800:	000be583          	lwu	a1,0(s7)
 804:	855a                	mv	a0,s6
 806:	de5ff0ef          	jal	5ea <printint>
 80a:	8ba6                	mv	s7,s1
      state = 0;
 80c:	4981                	li	s3,0
 80e:	bd7d                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 810:	008b8493          	addi	s1,s7,8
 814:	4681                	li	a3,0
 816:	4629                	li	a2,10
 818:	000bb583          	ld	a1,0(s7)
 81c:	855a                	mv	a0,s6
 81e:	dcdff0ef          	jal	5ea <printint>
        i += 1;
 822:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 824:	8ba6                	mv	s7,s1
      state = 0;
 826:	4981                	li	s3,0
        i += 1;
 828:	b555                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 82a:	008b8493          	addi	s1,s7,8
 82e:	4681                	li	a3,0
 830:	4629                	li	a2,10
 832:	000bb583          	ld	a1,0(s7)
 836:	855a                	mv	a0,s6
 838:	db3ff0ef          	jal	5ea <printint>
        i += 2;
 83c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 83e:	8ba6                	mv	s7,s1
      state = 0;
 840:	4981                	li	s3,0
        i += 2;
 842:	b569                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 844:	008b8493          	addi	s1,s7,8
 848:	4681                	li	a3,0
 84a:	4641                	li	a2,16
 84c:	000be583          	lwu	a1,0(s7)
 850:	855a                	mv	a0,s6
 852:	d99ff0ef          	jal	5ea <printint>
 856:	8ba6                	mv	s7,s1
      state = 0;
 858:	4981                	li	s3,0
 85a:	bd8d                	j	6cc <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 85c:	008b8493          	addi	s1,s7,8
 860:	4681                	li	a3,0
 862:	4641                	li	a2,16
 864:	000bb583          	ld	a1,0(s7)
 868:	855a                	mv	a0,s6
 86a:	d81ff0ef          	jal	5ea <printint>
        i += 1;
 86e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 870:	8ba6                	mv	s7,s1
      state = 0;
 872:	4981                	li	s3,0
        i += 1;
 874:	bda1                	j	6cc <vprintf+0x4a>
 876:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 878:	008b8d13          	addi	s10,s7,8
 87c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 880:	03000593          	li	a1,48
 884:	855a                	mv	a0,s6
 886:	d47ff0ef          	jal	5cc <putc>
  putc(fd, 'x');
 88a:	07800593          	li	a1,120
 88e:	855a                	mv	a0,s6
 890:	d3dff0ef          	jal	5cc <putc>
 894:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 896:	00000b97          	auipc	s7,0x0
 89a:	2aab8b93          	addi	s7,s7,682 # b40 <digits>
 89e:	03c9d793          	srli	a5,s3,0x3c
 8a2:	97de                	add	a5,a5,s7
 8a4:	0007c583          	lbu	a1,0(a5)
 8a8:	855a                	mv	a0,s6
 8aa:	d23ff0ef          	jal	5cc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ae:	0992                	slli	s3,s3,0x4
 8b0:	34fd                	addiw	s1,s1,-1
 8b2:	f4f5                	bnez	s1,89e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 8b4:	8bea                	mv	s7,s10
      state = 0;
 8b6:	4981                	li	s3,0
 8b8:	6d02                	ld	s10,0(sp)
 8ba:	bd09                	j	6cc <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 8bc:	008b8493          	addi	s1,s7,8
 8c0:	000bc583          	lbu	a1,0(s7)
 8c4:	855a                	mv	a0,s6
 8c6:	d07ff0ef          	jal	5cc <putc>
 8ca:	8ba6                	mv	s7,s1
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	bbfd                	j	6cc <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 8d0:	008b8993          	addi	s3,s7,8
 8d4:	000bb483          	ld	s1,0(s7)
 8d8:	cc91                	beqz	s1,8f4 <vprintf+0x272>
        for(; *s; s++)
 8da:	0004c583          	lbu	a1,0(s1)
 8de:	c195                	beqz	a1,902 <vprintf+0x280>
          putc(fd, *s);
 8e0:	855a                	mv	a0,s6
 8e2:	cebff0ef          	jal	5cc <putc>
        for(; *s; s++)
 8e6:	0485                	addi	s1,s1,1
 8e8:	0004c583          	lbu	a1,0(s1)
 8ec:	f9f5                	bnez	a1,8e0 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 8ee:	8bce                	mv	s7,s3
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	bbe9                	j	6cc <vprintf+0x4a>
          s = "(null)";
 8f4:	00000497          	auipc	s1,0x0
 8f8:	24448493          	addi	s1,s1,580 # b38 <malloc+0x134>
        for(; *s; s++)
 8fc:	02800593          	li	a1,40
 900:	b7c5                	j	8e0 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 902:	8bce                	mv	s7,s3
      state = 0;
 904:	4981                	li	s3,0
 906:	b3d9                	j	6cc <vprintf+0x4a>
 908:	6906                	ld	s2,64(sp)
 90a:	79e2                	ld	s3,56(sp)
 90c:	7a42                	ld	s4,48(sp)
 90e:	7aa2                	ld	s5,40(sp)
 910:	7b02                	ld	s6,32(sp)
 912:	6be2                	ld	s7,24(sp)
 914:	6c42                	ld	s8,16(sp)
 916:	6ca2                	ld	s9,8(sp)
    }
  }
}
 918:	60e6                	ld	ra,88(sp)
 91a:	6446                	ld	s0,80(sp)
 91c:	64a6                	ld	s1,72(sp)
 91e:	6125                	addi	sp,sp,96
 920:	8082                	ret

0000000000000922 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 922:	715d                	addi	sp,sp,-80
 924:	ec06                	sd	ra,24(sp)
 926:	e822                	sd	s0,16(sp)
 928:	1000                	addi	s0,sp,32
 92a:	e010                	sd	a2,0(s0)
 92c:	e414                	sd	a3,8(s0)
 92e:	e818                	sd	a4,16(s0)
 930:	ec1c                	sd	a5,24(s0)
 932:	03043023          	sd	a6,32(s0)
 936:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 93a:	8622                	mv	a2,s0
 93c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 940:	d43ff0ef          	jal	682 <vprintf>
}
 944:	60e2                	ld	ra,24(sp)
 946:	6442                	ld	s0,16(sp)
 948:	6161                	addi	sp,sp,80
 94a:	8082                	ret

000000000000094c <printf>:

void
printf(const char *fmt, ...)
{
 94c:	711d                	addi	sp,sp,-96
 94e:	ec06                	sd	ra,24(sp)
 950:	e822                	sd	s0,16(sp)
 952:	1000                	addi	s0,sp,32
 954:	e40c                	sd	a1,8(s0)
 956:	e810                	sd	a2,16(s0)
 958:	ec14                	sd	a3,24(s0)
 95a:	f018                	sd	a4,32(s0)
 95c:	f41c                	sd	a5,40(s0)
 95e:	03043823          	sd	a6,48(s0)
 962:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 966:	00840613          	addi	a2,s0,8
 96a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 96e:	85aa                	mv	a1,a0
 970:	4505                	li	a0,1
 972:	d11ff0ef          	jal	682 <vprintf>
}
 976:	60e2                	ld	ra,24(sp)
 978:	6442                	ld	s0,16(sp)
 97a:	6125                	addi	sp,sp,96
 97c:	8082                	ret

000000000000097e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 97e:	1141                	addi	sp,sp,-16
 980:	e406                	sd	ra,8(sp)
 982:	e022                	sd	s0,0(sp)
 984:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 986:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98a:	00001797          	auipc	a5,0x1
 98e:	6767b783          	ld	a5,1654(a5) # 2000 <freep>
 992:	a02d                	j	9bc <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 994:	4618                	lw	a4,8(a2)
 996:	9f2d                	addw	a4,a4,a1
 998:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 99c:	6398                	ld	a4,0(a5)
 99e:	6310                	ld	a2,0(a4)
 9a0:	a83d                	j	9de <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a2:	ff852703          	lw	a4,-8(a0)
 9a6:	9f31                	addw	a4,a4,a2
 9a8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9aa:	ff053683          	ld	a3,-16(a0)
 9ae:	a091                	j	9f2 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b0:	6398                	ld	a4,0(a5)
 9b2:	00e7e463          	bltu	a5,a4,9ba <free+0x3c>
 9b6:	00e6ea63          	bltu	a3,a4,9ca <free+0x4c>
{
 9ba:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9bc:	fed7fae3          	bgeu	a5,a3,9b0 <free+0x32>
 9c0:	6398                	ld	a4,0(a5)
 9c2:	00e6e463          	bltu	a3,a4,9ca <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c6:	fee7eae3          	bltu	a5,a4,9ba <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 9ca:	ff852583          	lw	a1,-8(a0)
 9ce:	6390                	ld	a2,0(a5)
 9d0:	02059813          	slli	a6,a1,0x20
 9d4:	01c85713          	srli	a4,a6,0x1c
 9d8:	9736                	add	a4,a4,a3
 9da:	fae60de3          	beq	a2,a4,994 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 9de:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9e2:	4790                	lw	a2,8(a5)
 9e4:	02061593          	slli	a1,a2,0x20
 9e8:	01c5d713          	srli	a4,a1,0x1c
 9ec:	973e                	add	a4,a4,a5
 9ee:	fae68ae3          	beq	a3,a4,9a2 <free+0x24>
    p->s.ptr = bp->s.ptr;
 9f2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9f4:	00001717          	auipc	a4,0x1
 9f8:	60f73623          	sd	a5,1548(a4) # 2000 <freep>
}
 9fc:	60a2                	ld	ra,8(sp)
 9fe:	6402                	ld	s0,0(sp)
 a00:	0141                	addi	sp,sp,16
 a02:	8082                	ret

0000000000000a04 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a04:	7139                	addi	sp,sp,-64
 a06:	fc06                	sd	ra,56(sp)
 a08:	f822                	sd	s0,48(sp)
 a0a:	f04a                	sd	s2,32(sp)
 a0c:	ec4e                	sd	s3,24(sp)
 a0e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a10:	02051993          	slli	s3,a0,0x20
 a14:	0209d993          	srli	s3,s3,0x20
 a18:	09bd                	addi	s3,s3,15
 a1a:	0049d993          	srli	s3,s3,0x4
 a1e:	2985                	addiw	s3,s3,1
 a20:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a22:	00001517          	auipc	a0,0x1
 a26:	5de53503          	ld	a0,1502(a0) # 2000 <freep>
 a2a:	c905                	beqz	a0,a5a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a2c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a2e:	4798                	lw	a4,8(a5)
 a30:	09377663          	bgeu	a4,s3,abc <malloc+0xb8>
 a34:	f426                	sd	s1,40(sp)
 a36:	e852                	sd	s4,16(sp)
 a38:	e456                	sd	s5,8(sp)
 a3a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a3c:	8a4e                	mv	s4,s3
 a3e:	6705                	lui	a4,0x1
 a40:	00e9f363          	bgeu	s3,a4,a46 <malloc+0x42>
 a44:	6a05                	lui	s4,0x1
 a46:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a4a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a4e:	00001497          	auipc	s1,0x1
 a52:	5b248493          	addi	s1,s1,1458 # 2000 <freep>
  if(p == SBRK_ERROR)
 a56:	5afd                	li	s5,-1
 a58:	a83d                	j	a96 <malloc+0x92>
 a5a:	f426                	sd	s1,40(sp)
 a5c:	e852                	sd	s4,16(sp)
 a5e:	e456                	sd	s5,8(sp)
 a60:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a62:	00002797          	auipc	a5,0x2
 a66:	9ae78793          	addi	a5,a5,-1618 # 2410 <base>
 a6a:	00001717          	auipc	a4,0x1
 a6e:	58f73b23          	sd	a5,1430(a4) # 2000 <freep>
 a72:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a74:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a78:	b7d1                	j	a3c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 a7a:	6398                	ld	a4,0(a5)
 a7c:	e118                	sd	a4,0(a0)
 a7e:	a899                	j	ad4 <malloc+0xd0>
  hp->s.size = nu;
 a80:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a84:	0541                	addi	a0,a0,16
 a86:	ef9ff0ef          	jal	97e <free>
  return freep;
 a8a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 a8c:	c125                	beqz	a0,aec <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a8e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a90:	4798                	lw	a4,8(a5)
 a92:	03277163          	bgeu	a4,s2,ab4 <malloc+0xb0>
    if(p == freep)
 a96:	6098                	ld	a4,0(s1)
 a98:	853e                	mv	a0,a5
 a9a:	fef71ae3          	bne	a4,a5,a8e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 a9e:	8552                	mv	a0,s4
 aa0:	a59ff0ef          	jal	4f8 <sbrk>
  if(p == SBRK_ERROR)
 aa4:	fd551ee3          	bne	a0,s5,a80 <malloc+0x7c>
        return 0;
 aa8:	4501                	li	a0,0
 aaa:	74a2                	ld	s1,40(sp)
 aac:	6a42                	ld	s4,16(sp)
 aae:	6aa2                	ld	s5,8(sp)
 ab0:	6b02                	ld	s6,0(sp)
 ab2:	a03d                	j	ae0 <malloc+0xdc>
 ab4:	74a2                	ld	s1,40(sp)
 ab6:	6a42                	ld	s4,16(sp)
 ab8:	6aa2                	ld	s5,8(sp)
 aba:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 abc:	fae90fe3          	beq	s2,a4,a7a <malloc+0x76>
        p->s.size -= nunits;
 ac0:	4137073b          	subw	a4,a4,s3
 ac4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ac6:	02071693          	slli	a3,a4,0x20
 aca:	01c6d713          	srli	a4,a3,0x1c
 ace:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 ad0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ad4:	00001717          	auipc	a4,0x1
 ad8:	52a73623          	sd	a0,1324(a4) # 2000 <freep>
      return (void*)(p + 1);
 adc:	01078513          	addi	a0,a5,16
  }
}
 ae0:	70e2                	ld	ra,56(sp)
 ae2:	7442                	ld	s0,48(sp)
 ae4:	7902                	ld	s2,32(sp)
 ae6:	69e2                	ld	s3,24(sp)
 ae8:	6121                	addi	sp,sp,64
 aea:	8082                	ret
 aec:	74a2                	ld	s1,40(sp)
 aee:	6a42                	ld	s4,16(sp)
 af0:	6aa2                	ld	s5,8(sp)
 af2:	6b02                	ld	s6,0(sp)
 af4:	b7f5                	j	ae0 <malloc+0xdc>
