
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	1800                	addi	s0,sp,48
   a:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   c:	2e2000ef          	jal	2ee <strlen>
  10:	02051793          	slli	a5,a0,0x20
  14:	9381                	srli	a5,a5,0x20
  16:	97a6                	add	a5,a5,s1
  18:	02f00693          	li	a3,47
  1c:	0097e963          	bltu	a5,s1,2e <fmtname+0x2e>
  20:	0007c703          	lbu	a4,0(a5)
  24:	00d70563          	beq	a4,a3,2e <fmtname+0x2e>
  28:	17fd                	addi	a5,a5,-1
  2a:	fe97fbe3          	bgeu	a5,s1,20 <fmtname+0x20>
    ;
  p++;
  2e:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  32:	8526                	mv	a0,s1
  34:	2ba000ef          	jal	2ee <strlen>
  38:	47b5                	li	a5,13
  3a:	00a7f863          	bgeu	a5,a0,4a <fmtname+0x4a>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  buf[sizeof(buf)-1] = '\0';
  return buf;
}
  3e:	8526                	mv	a0,s1
  40:	70a2                	ld	ra,40(sp)
  42:	7402                	ld	s0,32(sp)
  44:	64e2                	ld	s1,24(sp)
  46:	6145                	addi	sp,sp,48
  48:	8082                	ret
  4a:	e84a                	sd	s2,16(sp)
  4c:	e44e                	sd	s3,8(sp)
  memmove(buf, p, strlen(p));
  4e:	8526                	mv	a0,s1
  50:	29e000ef          	jal	2ee <strlen>
  54:	862a                	mv	a2,a0
  56:	00002997          	auipc	s3,0x2
  5a:	fba98993          	addi	s3,s3,-70 # 2010 <buf.0>
  5e:	85a6                	mv	a1,s1
  60:	854e                	mv	a0,s3
  62:	412000ef          	jal	474 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  66:	8526                	mv	a0,s1
  68:	286000ef          	jal	2ee <strlen>
  6c:	892a                	mv	s2,a0
  6e:	8526                	mv	a0,s1
  70:	27e000ef          	jal	2ee <strlen>
  74:	1902                	slli	s2,s2,0x20
  76:	02095913          	srli	s2,s2,0x20
  7a:	4639                	li	a2,14
  7c:	9e09                	subw	a2,a2,a0
  7e:	02000593          	li	a1,32
  82:	01298533          	add	a0,s3,s2
  86:	296000ef          	jal	31c <memset>
  buf[sizeof(buf)-1] = '\0';
  8a:	00098723          	sb	zero,14(s3)
  return buf;
  8e:	84ce                	mv	s1,s3
  90:	6942                	ld	s2,16(sp)
  92:	69a2                	ld	s3,8(sp)
  94:	b76d                	j	3e <fmtname+0x3e>

0000000000000096 <ls>:

void
ls(char *path)
{
  96:	d7010113          	addi	sp,sp,-656
  9a:	28113423          	sd	ra,648(sp)
  9e:	28813023          	sd	s0,640(sp)
  a2:	27213823          	sd	s2,624(sp)
  a6:	0d00                	addi	s0,sp,656
  a8:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, O_RDONLY)) < 0){
  aa:	4581                	li	a1,0
  ac:	4ea000ef          	jal	596 <open>
  b0:	06054363          	bltz	a0,116 <ls+0x80>
  b4:	26913c23          	sd	s1,632(sp)
  b8:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  ba:	d7840593          	addi	a1,s0,-648
  be:	4f0000ef          	jal	5ae <fstat>
  c2:	06054363          	bltz	a0,128 <ls+0x92>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  c6:	d8041783          	lh	a5,-640(s0)
  ca:	4705                	li	a4,1
  cc:	06e78c63          	beq	a5,a4,144 <ls+0xae>
  d0:	37f9                	addiw	a5,a5,-2
  d2:	17c2                	slli	a5,a5,0x30
  d4:	93c1                	srli	a5,a5,0x30
  d6:	02f76263          	bltu	a4,a5,fa <ls+0x64>
  case T_DEVICE:
  case T_FILE:
    printf("%s %d %d %d\n", fmtname(path), st.type, st.ino, (int) st.size);
  da:	854a                	mv	a0,s2
  dc:	f25ff0ef          	jal	0 <fmtname>
  e0:	85aa                	mv	a1,a0
  e2:	d8842703          	lw	a4,-632(s0)
  e6:	d7c42683          	lw	a3,-644(s0)
  ea:	d8041603          	lh	a2,-640(s0)
  ee:	00001517          	auipc	a0,0x1
  f2:	a6250513          	addi	a0,a0,-1438 # b50 <malloc+0x122>
  f6:	081000ef          	jal	976 <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
    }
    break;
  }
  close(fd);
  fa:	8526                	mv	a0,s1
  fc:	482000ef          	jal	57e <close>
 100:	27813483          	ld	s1,632(sp)
}
 104:	28813083          	ld	ra,648(sp)
 108:	28013403          	ld	s0,640(sp)
 10c:	27013903          	ld	s2,624(sp)
 110:	29010113          	addi	sp,sp,656
 114:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 116:	864a                	mv	a2,s2
 118:	00001597          	auipc	a1,0x1
 11c:	a0858593          	addi	a1,a1,-1528 # b20 <malloc+0xf2>
 120:	4509                	li	a0,2
 122:	02b000ef          	jal	94c <fprintf>
    return;
 126:	bff9                	j	104 <ls+0x6e>
    fprintf(2, "ls: cannot stat %s\n", path);
 128:	864a                	mv	a2,s2
 12a:	00001597          	auipc	a1,0x1
 12e:	a0e58593          	addi	a1,a1,-1522 # b38 <malloc+0x10a>
 132:	4509                	li	a0,2
 134:	019000ef          	jal	94c <fprintf>
    close(fd);
 138:	8526                	mv	a0,s1
 13a:	444000ef          	jal	57e <close>
    return;
 13e:	27813483          	ld	s1,632(sp)
 142:	b7c9                	j	104 <ls+0x6e>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 144:	854a                	mv	a0,s2
 146:	1a8000ef          	jal	2ee <strlen>
 14a:	2541                	addiw	a0,a0,16
 14c:	20000793          	li	a5,512
 150:	00a7f963          	bgeu	a5,a0,162 <ls+0xcc>
      printf("ls: path too long\n");
 154:	00001517          	auipc	a0,0x1
 158:	a0c50513          	addi	a0,a0,-1524 # b60 <malloc+0x132>
 15c:	01b000ef          	jal	976 <printf>
      break;
 160:	bf69                	j	fa <ls+0x64>
 162:	27313423          	sd	s3,616(sp)
 166:	27413023          	sd	s4,608(sp)
 16a:	25513c23          	sd	s5,600(sp)
 16e:	25613823          	sd	s6,592(sp)
 172:	25713423          	sd	s7,584(sp)
 176:	25813023          	sd	s8,576(sp)
 17a:	23913c23          	sd	s9,568(sp)
 17e:	23a13823          	sd	s10,560(sp)
    strcpy(buf, path);
 182:	da040993          	addi	s3,s0,-608
 186:	85ca                	mv	a1,s2
 188:	854e                	mv	a0,s3
 18a:	114000ef          	jal	29e <strcpy>
    p = buf+strlen(buf);
 18e:	854e                	mv	a0,s3
 190:	15e000ef          	jal	2ee <strlen>
 194:	1502                	slli	a0,a0,0x20
 196:	9101                	srli	a0,a0,0x20
 198:	99aa                	add	s3,s3,a0
    *p++ = '/';
 19a:	00198c93          	addi	s9,s3,1
 19e:	02f00793          	li	a5,47
 1a2:	00f98023          	sb	a5,0(s3)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1a6:	d9040a13          	addi	s4,s0,-624
 1aa:	4941                	li	s2,16
      memmove(p, de.name, DIRSIZ);
 1ac:	d9240c13          	addi	s8,s0,-622
 1b0:	4bb9                	li	s7,14
      if(stat(buf, &st) < 0){
 1b2:	d7840b13          	addi	s6,s0,-648
 1b6:	da040a93          	addi	s5,s0,-608
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 1ba:	00001d17          	auipc	s10,0x1
 1be:	996d0d13          	addi	s10,s10,-1642 # b50 <malloc+0x122>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1c2:	a801                	j	1d2 <ls+0x13c>
        printf("ls: cannot stat %s\n", buf);
 1c4:	85d6                	mv	a1,s5
 1c6:	00001517          	auipc	a0,0x1
 1ca:	97250513          	addi	a0,a0,-1678 # b38 <malloc+0x10a>
 1ce:	7a8000ef          	jal	976 <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1d2:	864a                	mv	a2,s2
 1d4:	85d2                	mv	a1,s4
 1d6:	8526                	mv	a0,s1
 1d8:	396000ef          	jal	56e <read>
 1dc:	05251063          	bne	a0,s2,21c <ls+0x186>
      if(de.inum == 0)
 1e0:	d9045783          	lhu	a5,-624(s0)
 1e4:	d7fd                	beqz	a5,1d2 <ls+0x13c>
      memmove(p, de.name, DIRSIZ);
 1e6:	865e                	mv	a2,s7
 1e8:	85e2                	mv	a1,s8
 1ea:	8566                	mv	a0,s9
 1ec:	288000ef          	jal	474 <memmove>
      p[DIRSIZ] = 0;
 1f0:	000987a3          	sb	zero,15(s3)
      if(stat(buf, &st) < 0){
 1f4:	85da                	mv	a1,s6
 1f6:	8556                	mv	a0,s5
 1f8:	1f6000ef          	jal	3ee <stat>
 1fc:	fc0544e3          	bltz	a0,1c4 <ls+0x12e>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, (int) st.size);
 200:	8556                	mv	a0,s5
 202:	dffff0ef          	jal	0 <fmtname>
 206:	85aa                	mv	a1,a0
 208:	d8842703          	lw	a4,-632(s0)
 20c:	d7c42683          	lw	a3,-644(s0)
 210:	d8041603          	lh	a2,-640(s0)
 214:	856a                	mv	a0,s10
 216:	760000ef          	jal	976 <printf>
 21a:	bf65                	j	1d2 <ls+0x13c>
 21c:	26813983          	ld	s3,616(sp)
 220:	26013a03          	ld	s4,608(sp)
 224:	25813a83          	ld	s5,600(sp)
 228:	25013b03          	ld	s6,592(sp)
 22c:	24813b83          	ld	s7,584(sp)
 230:	24013c03          	ld	s8,576(sp)
 234:	23813c83          	ld	s9,568(sp)
 238:	23013d03          	ld	s10,560(sp)
 23c:	bd7d                	j	fa <ls+0x64>

000000000000023e <main>:

int
main(int argc, char *argv[])
{
 23e:	1101                	addi	sp,sp,-32
 240:	ec06                	sd	ra,24(sp)
 242:	e822                	sd	s0,16(sp)
 244:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 246:	4785                	li	a5,1
 248:	02a7d763          	bge	a5,a0,276 <main+0x38>
 24c:	e426                	sd	s1,8(sp)
 24e:	e04a                	sd	s2,0(sp)
 250:	00858493          	addi	s1,a1,8
 254:	ffe5091b          	addiw	s2,a0,-2
 258:	02091793          	slli	a5,s2,0x20
 25c:	01d7d913          	srli	s2,a5,0x1d
 260:	05c1                	addi	a1,a1,16
 262:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 264:	6088                	ld	a0,0(s1)
 266:	e31ff0ef          	jal	96 <ls>
  for(i=1; i<argc; i++)
 26a:	04a1                	addi	s1,s1,8
 26c:	ff249ce3          	bne	s1,s2,264 <main+0x26>
  exit(0);
 270:	4501                	li	a0,0
 272:	2e4000ef          	jal	556 <exit>
 276:	e426                	sd	s1,8(sp)
 278:	e04a                	sd	s2,0(sp)
    ls(".");
 27a:	00001517          	auipc	a0,0x1
 27e:	8fe50513          	addi	a0,a0,-1794 # b78 <malloc+0x14a>
 282:	e15ff0ef          	jal	96 <ls>
    exit(0);
 286:	4501                	li	a0,0
 288:	2ce000ef          	jal	556 <exit>

000000000000028c <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
 28c:	1141                	addi	sp,sp,-16
 28e:	e406                	sd	ra,8(sp)
 290:	e022                	sd	s0,0(sp)
 292:	0800                	addi	s0,sp,16
  extern int main();
  main();
 294:	fabff0ef          	jal	23e <main>
  exit(0);
 298:	4501                	li	a0,0
 29a:	2bc000ef          	jal	556 <exit>

000000000000029e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 29e:	1141                	addi	sp,sp,-16
 2a0:	e406                	sd	ra,8(sp)
 2a2:	e022                	sd	s0,0(sp)
 2a4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a6:	87aa                	mv	a5,a0
 2a8:	0585                	addi	a1,a1,1
 2aa:	0785                	addi	a5,a5,1
 2ac:	fff5c703          	lbu	a4,-1(a1)
 2b0:	fee78fa3          	sb	a4,-1(a5)
 2b4:	fb75                	bnez	a4,2a8 <strcpy+0xa>
    ;
  return os;
}
 2b6:	60a2                	ld	ra,8(sp)
 2b8:	6402                	ld	s0,0(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e406                	sd	ra,8(sp)
 2c2:	e022                	sd	s0,0(sp)
 2c4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2c6:	00054783          	lbu	a5,0(a0)
 2ca:	cb91                	beqz	a5,2de <strcmp+0x20>
 2cc:	0005c703          	lbu	a4,0(a1)
 2d0:	00f71763          	bne	a4,a5,2de <strcmp+0x20>
    p++, q++;
 2d4:	0505                	addi	a0,a0,1
 2d6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	fbe5                	bnez	a5,2cc <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
 2de:	0005c503          	lbu	a0,0(a1)
}
 2e2:	40a7853b          	subw	a0,a5,a0
 2e6:	60a2                	ld	ra,8(sp)
 2e8:	6402                	ld	s0,0(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <strlen>:

uint
strlen(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e406                	sd	ra,8(sp)
 2f2:	e022                	sd	s0,0(sp)
 2f4:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2f6:	00054783          	lbu	a5,0(a0)
 2fa:	cf99                	beqz	a5,318 <strlen+0x2a>
 2fc:	0505                	addi	a0,a0,1
 2fe:	87aa                	mv	a5,a0
 300:	86be                	mv	a3,a5
 302:	0785                	addi	a5,a5,1
 304:	fff7c703          	lbu	a4,-1(a5)
 308:	ff65                	bnez	a4,300 <strlen+0x12>
 30a:	40a6853b          	subw	a0,a3,a0
 30e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 310:	60a2                	ld	ra,8(sp)
 312:	6402                	ld	s0,0(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret
  for(n = 0; s[n]; n++)
 318:	4501                	li	a0,0
 31a:	bfdd                	j	310 <strlen+0x22>

000000000000031c <memset>:

void*
memset(void *dst, int c, uint n)
{
 31c:	1141                	addi	sp,sp,-16
 31e:	e406                	sd	ra,8(sp)
 320:	e022                	sd	s0,0(sp)
 322:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 324:	ca19                	beqz	a2,33a <memset+0x1e>
 326:	87aa                	mv	a5,a0
 328:	1602                	slli	a2,a2,0x20
 32a:	9201                	srli	a2,a2,0x20
 32c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 330:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 334:	0785                	addi	a5,a5,1
 336:	fee79de3          	bne	a5,a4,330 <memset+0x14>
  }
  return dst;
}
 33a:	60a2                	ld	ra,8(sp)
 33c:	6402                	ld	s0,0(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strchr>:

char*
strchr(const char *s, char c)
{
 342:	1141                	addi	sp,sp,-16
 344:	e406                	sd	ra,8(sp)
 346:	e022                	sd	s0,0(sp)
 348:	0800                	addi	s0,sp,16
  for(; *s; s++)
 34a:	00054783          	lbu	a5,0(a0)
 34e:	cf81                	beqz	a5,366 <strchr+0x24>
    if(*s == c)
 350:	00f58763          	beq	a1,a5,35e <strchr+0x1c>
  for(; *s; s++)
 354:	0505                	addi	a0,a0,1
 356:	00054783          	lbu	a5,0(a0)
 35a:	fbfd                	bnez	a5,350 <strchr+0xe>
      return (char*)s;
  return 0;
 35c:	4501                	li	a0,0
}
 35e:	60a2                	ld	ra,8(sp)
 360:	6402                	ld	s0,0(sp)
 362:	0141                	addi	sp,sp,16
 364:	8082                	ret
  return 0;
 366:	4501                	li	a0,0
 368:	bfdd                	j	35e <strchr+0x1c>

000000000000036a <gets>:

char*
gets(char *buf, int max)
{
 36a:	7159                	addi	sp,sp,-112
 36c:	f486                	sd	ra,104(sp)
 36e:	f0a2                	sd	s0,96(sp)
 370:	eca6                	sd	s1,88(sp)
 372:	e8ca                	sd	s2,80(sp)
 374:	e4ce                	sd	s3,72(sp)
 376:	e0d2                	sd	s4,64(sp)
 378:	fc56                	sd	s5,56(sp)
 37a:	f85a                	sd	s6,48(sp)
 37c:	f45e                	sd	s7,40(sp)
 37e:	f062                	sd	s8,32(sp)
 380:	ec66                	sd	s9,24(sp)
 382:	e86a                	sd	s10,16(sp)
 384:	1880                	addi	s0,sp,112
 386:	8caa                	mv	s9,a0
 388:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 38a:	892a                	mv	s2,a0
 38c:	4481                	li	s1,0
    cc = read(0, &c, 1);
 38e:	f9f40b13          	addi	s6,s0,-97
 392:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 394:	4ba9                	li	s7,10
 396:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
 398:	8d26                	mv	s10,s1
 39a:	0014899b          	addiw	s3,s1,1
 39e:	84ce                	mv	s1,s3
 3a0:	0349d563          	bge	s3,s4,3ca <gets+0x60>
    cc = read(0, &c, 1);
 3a4:	8656                	mv	a2,s5
 3a6:	85da                	mv	a1,s6
 3a8:	4501                	li	a0,0
 3aa:	1c4000ef          	jal	56e <read>
    if(cc < 1)
 3ae:	00a05e63          	blez	a0,3ca <gets+0x60>
    buf[i++] = c;
 3b2:	f9f44783          	lbu	a5,-97(s0)
 3b6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ba:	01778763          	beq	a5,s7,3c8 <gets+0x5e>
 3be:	0905                	addi	s2,s2,1
 3c0:	fd879ce3          	bne	a5,s8,398 <gets+0x2e>
    buf[i++] = c;
 3c4:	8d4e                	mv	s10,s3
 3c6:	a011                	j	3ca <gets+0x60>
 3c8:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
 3ca:	9d66                	add	s10,s10,s9
 3cc:	000d0023          	sb	zero,0(s10)
  return buf;
}
 3d0:	8566                	mv	a0,s9
 3d2:	70a6                	ld	ra,104(sp)
 3d4:	7406                	ld	s0,96(sp)
 3d6:	64e6                	ld	s1,88(sp)
 3d8:	6946                	ld	s2,80(sp)
 3da:	69a6                	ld	s3,72(sp)
 3dc:	6a06                	ld	s4,64(sp)
 3de:	7ae2                	ld	s5,56(sp)
 3e0:	7b42                	ld	s6,48(sp)
 3e2:	7ba2                	ld	s7,40(sp)
 3e4:	7c02                	ld	s8,32(sp)
 3e6:	6ce2                	ld	s9,24(sp)
 3e8:	6d42                	ld	s10,16(sp)
 3ea:	6165                	addi	sp,sp,112
 3ec:	8082                	ret

00000000000003ee <stat>:

int
stat(const char *n, struct stat *st)
{
 3ee:	1101                	addi	sp,sp,-32
 3f0:	ec06                	sd	ra,24(sp)
 3f2:	e822                	sd	s0,16(sp)
 3f4:	e04a                	sd	s2,0(sp)
 3f6:	1000                	addi	s0,sp,32
 3f8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3fa:	4581                	li	a1,0
 3fc:	19a000ef          	jal	596 <open>
  if(fd < 0)
 400:	02054263          	bltz	a0,424 <stat+0x36>
 404:	e426                	sd	s1,8(sp)
 406:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 408:	85ca                	mv	a1,s2
 40a:	1a4000ef          	jal	5ae <fstat>
 40e:	892a                	mv	s2,a0
  close(fd);
 410:	8526                	mv	a0,s1
 412:	16c000ef          	jal	57e <close>
  return r;
 416:	64a2                	ld	s1,8(sp)
}
 418:	854a                	mv	a0,s2
 41a:	60e2                	ld	ra,24(sp)
 41c:	6442                	ld	s0,16(sp)
 41e:	6902                	ld	s2,0(sp)
 420:	6105                	addi	sp,sp,32
 422:	8082                	ret
    return -1;
 424:	597d                	li	s2,-1
 426:	bfcd                	j	418 <stat+0x2a>

0000000000000428 <atoi>:

int
atoi(const char *s)
{
 428:	1141                	addi	sp,sp,-16
 42a:	e406                	sd	ra,8(sp)
 42c:	e022                	sd	s0,0(sp)
 42e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 430:	00054683          	lbu	a3,0(a0)
 434:	fd06879b          	addiw	a5,a3,-48
 438:	0ff7f793          	zext.b	a5,a5
 43c:	4625                	li	a2,9
 43e:	02f66963          	bltu	a2,a5,470 <atoi+0x48>
 442:	872a                	mv	a4,a0
  n = 0;
 444:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 446:	0705                	addi	a4,a4,1
 448:	0025179b          	slliw	a5,a0,0x2
 44c:	9fa9                	addw	a5,a5,a0
 44e:	0017979b          	slliw	a5,a5,0x1
 452:	9fb5                	addw	a5,a5,a3
 454:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 458:	00074683          	lbu	a3,0(a4)
 45c:	fd06879b          	addiw	a5,a3,-48
 460:	0ff7f793          	zext.b	a5,a5
 464:	fef671e3          	bgeu	a2,a5,446 <atoi+0x1e>
  return n;
}
 468:	60a2                	ld	ra,8(sp)
 46a:	6402                	ld	s0,0(sp)
 46c:	0141                	addi	sp,sp,16
 46e:	8082                	ret
  n = 0;
 470:	4501                	li	a0,0
 472:	bfdd                	j	468 <atoi+0x40>

0000000000000474 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 474:	1141                	addi	sp,sp,-16
 476:	e406                	sd	ra,8(sp)
 478:	e022                	sd	s0,0(sp)
 47a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 47c:	02b57563          	bgeu	a0,a1,4a6 <memmove+0x32>
    while(n-- > 0)
 480:	00c05f63          	blez	a2,49e <memmove+0x2a>
 484:	1602                	slli	a2,a2,0x20
 486:	9201                	srli	a2,a2,0x20
 488:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 48c:	872a                	mv	a4,a0
      *dst++ = *src++;
 48e:	0585                	addi	a1,a1,1
 490:	0705                	addi	a4,a4,1
 492:	fff5c683          	lbu	a3,-1(a1)
 496:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 49a:	fee79ae3          	bne	a5,a4,48e <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 49e:	60a2                	ld	ra,8(sp)
 4a0:	6402                	ld	s0,0(sp)
 4a2:	0141                	addi	sp,sp,16
 4a4:	8082                	ret
    dst += n;
 4a6:	00c50733          	add	a4,a0,a2
    src += n;
 4aa:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4ac:	fec059e3          	blez	a2,49e <memmove+0x2a>
 4b0:	fff6079b          	addiw	a5,a2,-1
 4b4:	1782                	slli	a5,a5,0x20
 4b6:	9381                	srli	a5,a5,0x20
 4b8:	fff7c793          	not	a5,a5
 4bc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4be:	15fd                	addi	a1,a1,-1
 4c0:	177d                	addi	a4,a4,-1
 4c2:	0005c683          	lbu	a3,0(a1)
 4c6:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4ca:	fef71ae3          	bne	a4,a5,4be <memmove+0x4a>
 4ce:	bfc1                	j	49e <memmove+0x2a>

00000000000004d0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4d0:	1141                	addi	sp,sp,-16
 4d2:	e406                	sd	ra,8(sp)
 4d4:	e022                	sd	s0,0(sp)
 4d6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4d8:	ca0d                	beqz	a2,50a <memcmp+0x3a>
 4da:	fff6069b          	addiw	a3,a2,-1
 4de:	1682                	slli	a3,a3,0x20
 4e0:	9281                	srli	a3,a3,0x20
 4e2:	0685                	addi	a3,a3,1
 4e4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4e6:	00054783          	lbu	a5,0(a0)
 4ea:	0005c703          	lbu	a4,0(a1)
 4ee:	00e79863          	bne	a5,a4,4fe <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
 4f2:	0505                	addi	a0,a0,1
    p2++;
 4f4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4f6:	fed518e3          	bne	a0,a3,4e6 <memcmp+0x16>
  }
  return 0;
 4fa:	4501                	li	a0,0
 4fc:	a019                	j	502 <memcmp+0x32>
      return *p1 - *p2;
 4fe:	40e7853b          	subw	a0,a5,a4
}
 502:	60a2                	ld	ra,8(sp)
 504:	6402                	ld	s0,0(sp)
 506:	0141                	addi	sp,sp,16
 508:	8082                	ret
  return 0;
 50a:	4501                	li	a0,0
 50c:	bfdd                	j	502 <memcmp+0x32>

000000000000050e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 50e:	1141                	addi	sp,sp,-16
 510:	e406                	sd	ra,8(sp)
 512:	e022                	sd	s0,0(sp)
 514:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 516:	f5fff0ef          	jal	474 <memmove>
}
 51a:	60a2                	ld	ra,8(sp)
 51c:	6402                	ld	s0,0(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret

0000000000000522 <sbrk>:

char *
sbrk(int n) {
 522:	1141                	addi	sp,sp,-16
 524:	e406                	sd	ra,8(sp)
 526:	e022                	sd	s0,0(sp)
 528:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 52a:	4585                	li	a1,1
 52c:	0b2000ef          	jal	5de <sys_sbrk>
}
 530:	60a2                	ld	ra,8(sp)
 532:	6402                	ld	s0,0(sp)
 534:	0141                	addi	sp,sp,16
 536:	8082                	ret

0000000000000538 <sbrklazy>:

char *
sbrklazy(int n) {
 538:	1141                	addi	sp,sp,-16
 53a:	e406                	sd	ra,8(sp)
 53c:	e022                	sd	s0,0(sp)
 53e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 540:	4589                	li	a1,2
 542:	09c000ef          	jal	5de <sys_sbrk>
}
 546:	60a2                	ld	ra,8(sp)
 548:	6402                	ld	s0,0(sp)
 54a:	0141                	addi	sp,sp,16
 54c:	8082                	ret

000000000000054e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 54e:	4885                	li	a7,1
 ecall
 550:	00000073          	ecall
 ret
 554:	8082                	ret

0000000000000556 <exit>:
.global exit
exit:
 li a7, SYS_exit
 556:	4889                	li	a7,2
 ecall
 558:	00000073          	ecall
 ret
 55c:	8082                	ret

000000000000055e <wait>:
.global wait
wait:
 li a7, SYS_wait
 55e:	488d                	li	a7,3
 ecall
 560:	00000073          	ecall
 ret
 564:	8082                	ret

0000000000000566 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 566:	4891                	li	a7,4
 ecall
 568:	00000073          	ecall
 ret
 56c:	8082                	ret

000000000000056e <read>:
.global read
read:
 li a7, SYS_read
 56e:	4895                	li	a7,5
 ecall
 570:	00000073          	ecall
 ret
 574:	8082                	ret

0000000000000576 <write>:
.global write
write:
 li a7, SYS_write
 576:	48c1                	li	a7,16
 ecall
 578:	00000073          	ecall
 ret
 57c:	8082                	ret

000000000000057e <close>:
.global close
close:
 li a7, SYS_close
 57e:	48d5                	li	a7,21
 ecall
 580:	00000073          	ecall
 ret
 584:	8082                	ret

0000000000000586 <kill>:
.global kill
kill:
 li a7, SYS_kill
 586:	4899                	li	a7,6
 ecall
 588:	00000073          	ecall
 ret
 58c:	8082                	ret

000000000000058e <exec>:
.global exec
exec:
 li a7, SYS_exec
 58e:	489d                	li	a7,7
 ecall
 590:	00000073          	ecall
 ret
 594:	8082                	ret

0000000000000596 <open>:
.global open
open:
 li a7, SYS_open
 596:	48bd                	li	a7,15
 ecall
 598:	00000073          	ecall
 ret
 59c:	8082                	ret

000000000000059e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 59e:	48c5                	li	a7,17
 ecall
 5a0:	00000073          	ecall
 ret
 5a4:	8082                	ret

00000000000005a6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5a6:	48c9                	li	a7,18
 ecall
 5a8:	00000073          	ecall
 ret
 5ac:	8082                	ret

00000000000005ae <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 5ae:	48a1                	li	a7,8
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <link>:
.global link
link:
 li a7, SYS_link
 5b6:	48cd                	li	a7,19
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 5be:	48d1                	li	a7,20
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5c6:	48a5                	li	a7,9
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ce:	48a9                	li	a7,10
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5d6:	48ad                	li	a7,11
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 5de:	48b1                	li	a7,12
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <pause>:
.global pause
pause:
 li a7, SYS_pause
 5e6:	48b5                	li	a7,13
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ee:	48b9                	li	a7,14
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5f6:	1101                	addi	sp,sp,-32
 5f8:	ec06                	sd	ra,24(sp)
 5fa:	e822                	sd	s0,16(sp)
 5fc:	1000                	addi	s0,sp,32
 5fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 602:	4605                	li	a2,1
 604:	fef40593          	addi	a1,s0,-17
 608:	f6fff0ef          	jal	576 <write>
}
 60c:	60e2                	ld	ra,24(sp)
 60e:	6442                	ld	s0,16(sp)
 610:	6105                	addi	sp,sp,32
 612:	8082                	ret

0000000000000614 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 614:	715d                	addi	sp,sp,-80
 616:	e486                	sd	ra,72(sp)
 618:	e0a2                	sd	s0,64(sp)
 61a:	fc26                	sd	s1,56(sp)
 61c:	f84a                	sd	s2,48(sp)
 61e:	f44e                	sd	s3,40(sp)
 620:	0880                	addi	s0,sp,80
 622:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 624:	c299                	beqz	a3,62a <printint+0x16>
 626:	0605cf63          	bltz	a1,6a4 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 62a:	2581                	sext.w	a1,a1
  neg = 0;
 62c:	4e01                	li	t3,0
  }

  i = 0;
 62e:	fb840313          	addi	t1,s0,-72
  neg = 0;
 632:	869a                	mv	a3,t1
  i = 0;
 634:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 636:	00000817          	auipc	a6,0x0
 63a:	55280813          	addi	a6,a6,1362 # b88 <digits>
 63e:	88be                	mv	a7,a5
 640:	0017851b          	addiw	a0,a5,1
 644:	87aa                	mv	a5,a0
 646:	02c5f73b          	remuw	a4,a1,a2
 64a:	1702                	slli	a4,a4,0x20
 64c:	9301                	srli	a4,a4,0x20
 64e:	9742                	add	a4,a4,a6
 650:	00074703          	lbu	a4,0(a4)
 654:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 658:	872e                	mv	a4,a1
 65a:	02c5d5bb          	divuw	a1,a1,a2
 65e:	0685                	addi	a3,a3,1
 660:	fcc77fe3          	bgeu	a4,a2,63e <printint+0x2a>
  if(neg)
 664:	000e0c63          	beqz	t3,67c <printint+0x68>
    buf[i++] = '-';
 668:	fd050793          	addi	a5,a0,-48
 66c:	00878533          	add	a0,a5,s0
 670:	02d00793          	li	a5,45
 674:	fef50423          	sb	a5,-24(a0)
 678:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
 67c:	fff7899b          	addiw	s3,a5,-1
 680:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
 684:	fff4c583          	lbu	a1,-1(s1)
 688:	854a                	mv	a0,s2
 68a:	f6dff0ef          	jal	5f6 <putc>
  while(--i >= 0)
 68e:	39fd                	addiw	s3,s3,-1
 690:	14fd                	addi	s1,s1,-1
 692:	fe09d9e3          	bgez	s3,684 <printint+0x70>
}
 696:	60a6                	ld	ra,72(sp)
 698:	6406                	ld	s0,64(sp)
 69a:	74e2                	ld	s1,56(sp)
 69c:	7942                	ld	s2,48(sp)
 69e:	79a2                	ld	s3,40(sp)
 6a0:	6161                	addi	sp,sp,80
 6a2:	8082                	ret
    x = -xx;
 6a4:	40b005bb          	negw	a1,a1
    neg = 1;
 6a8:	4e05                	li	t3,1
    x = -xx;
 6aa:	b751                	j	62e <printint+0x1a>

00000000000006ac <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6ac:	711d                	addi	sp,sp,-96
 6ae:	ec86                	sd	ra,88(sp)
 6b0:	e8a2                	sd	s0,80(sp)
 6b2:	e4a6                	sd	s1,72(sp)
 6b4:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6b6:	0005c483          	lbu	s1,0(a1)
 6ba:	28048463          	beqz	s1,942 <vprintf+0x296>
 6be:	e0ca                	sd	s2,64(sp)
 6c0:	fc4e                	sd	s3,56(sp)
 6c2:	f852                	sd	s4,48(sp)
 6c4:	f456                	sd	s5,40(sp)
 6c6:	f05a                	sd	s6,32(sp)
 6c8:	ec5e                	sd	s7,24(sp)
 6ca:	e862                	sd	s8,16(sp)
 6cc:	e466                	sd	s9,8(sp)
 6ce:	8b2a                	mv	s6,a0
 6d0:	8a2e                	mv	s4,a1
 6d2:	8bb2                	mv	s7,a2
  state = 0;
 6d4:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 6d6:	4901                	li	s2,0
 6d8:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 6da:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 6de:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 6e2:	06c00c93          	li	s9,108
 6e6:	a00d                	j	708 <vprintf+0x5c>
        putc(fd, c0);
 6e8:	85a6                	mv	a1,s1
 6ea:	855a                	mv	a0,s6
 6ec:	f0bff0ef          	jal	5f6 <putc>
 6f0:	a019                	j	6f6 <vprintf+0x4a>
    } else if(state == '%'){
 6f2:	03598363          	beq	s3,s5,718 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
 6f6:	0019079b          	addiw	a5,s2,1
 6fa:	893e                	mv	s2,a5
 6fc:	873e                	mv	a4,a5
 6fe:	97d2                	add	a5,a5,s4
 700:	0007c483          	lbu	s1,0(a5)
 704:	22048763          	beqz	s1,932 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
 708:	0004879b          	sext.w	a5,s1
    if(state == 0){
 70c:	fe0993e3          	bnez	s3,6f2 <vprintf+0x46>
      if(c0 == '%'){
 710:	fd579ce3          	bne	a5,s5,6e8 <vprintf+0x3c>
        state = '%';
 714:	89be                	mv	s3,a5
 716:	b7c5                	j	6f6 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 718:	00ea06b3          	add	a3,s4,a4
 71c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 720:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 722:	c681                	beqz	a3,72a <vprintf+0x7e>
 724:	9752                	add	a4,a4,s4
 726:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 72a:	05878263          	beq	a5,s8,76e <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 72e:	05978c63          	beq	a5,s9,786 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 732:	07500713          	li	a4,117
 736:	0ee78663          	beq	a5,a4,822 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 73a:	07800713          	li	a4,120
 73e:	12e78863          	beq	a5,a4,86e <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 742:	07000713          	li	a4,112
 746:	14e78d63          	beq	a5,a4,8a0 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 74a:	06300713          	li	a4,99
 74e:	18e78c63          	beq	a5,a4,8e6 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 752:	07300713          	li	a4,115
 756:	1ae78263          	beq	a5,a4,8fa <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 75a:	02500713          	li	a4,37
 75e:	04e79463          	bne	a5,a4,7a6 <vprintf+0xfa>
        putc(fd, '%');
 762:	85ba                	mv	a1,a4
 764:	855a                	mv	a0,s6
 766:	e91ff0ef          	jal	5f6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 76a:	4981                	li	s3,0
 76c:	b769                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 76e:	008b8493          	addi	s1,s7,8
 772:	4685                	li	a3,1
 774:	4629                	li	a2,10
 776:	000ba583          	lw	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	e99ff0ef          	jal	614 <printint>
 780:	8ba6                	mv	s7,s1
      state = 0;
 782:	4981                	li	s3,0
 784:	bf8d                	j	6f6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 786:	06400793          	li	a5,100
 78a:	02f68963          	beq	a3,a5,7bc <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 78e:	06c00793          	li	a5,108
 792:	04f68263          	beq	a3,a5,7d6 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 796:	07500793          	li	a5,117
 79a:	0af68063          	beq	a3,a5,83a <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 79e:	07800793          	li	a5,120
 7a2:	0ef68263          	beq	a3,a5,886 <vprintf+0x1da>
        putc(fd, '%');
 7a6:	02500593          	li	a1,37
 7aa:	855a                	mv	a0,s6
 7ac:	e4bff0ef          	jal	5f6 <putc>
        putc(fd, c0);
 7b0:	85a6                	mv	a1,s1
 7b2:	855a                	mv	a0,s6
 7b4:	e43ff0ef          	jal	5f6 <putc>
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	bf35                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 7bc:	008b8493          	addi	s1,s7,8
 7c0:	4685                	li	a3,1
 7c2:	4629                	li	a2,10
 7c4:	000bb583          	ld	a1,0(s7)
 7c8:	855a                	mv	a0,s6
 7ca:	e4bff0ef          	jal	614 <printint>
        i += 1;
 7ce:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 7d0:	8ba6                	mv	s7,s1
      state = 0;
 7d2:	4981                	li	s3,0
        i += 1;
 7d4:	b70d                	j	6f6 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 7d6:	06400793          	li	a5,100
 7da:	02f60763          	beq	a2,a5,808 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 7de:	07500793          	li	a5,117
 7e2:	06f60963          	beq	a2,a5,854 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 7e6:	07800793          	li	a5,120
 7ea:	faf61ee3          	bne	a2,a5,7a6 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7ee:	008b8493          	addi	s1,s7,8
 7f2:	4681                	li	a3,0
 7f4:	4641                	li	a2,16
 7f6:	000bb583          	ld	a1,0(s7)
 7fa:	855a                	mv	a0,s6
 7fc:	e19ff0ef          	jal	614 <printint>
        i += 2;
 800:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 802:	8ba6                	mv	s7,s1
      state = 0;
 804:	4981                	li	s3,0
        i += 2;
 806:	bdc5                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 808:	008b8493          	addi	s1,s7,8
 80c:	4685                	li	a3,1
 80e:	4629                	li	a2,10
 810:	000bb583          	ld	a1,0(s7)
 814:	855a                	mv	a0,s6
 816:	dffff0ef          	jal	614 <printint>
        i += 2;
 81a:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 81c:	8ba6                	mv	s7,s1
      state = 0;
 81e:	4981                	li	s3,0
        i += 2;
 820:	bdd9                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 822:	008b8493          	addi	s1,s7,8
 826:	4681                	li	a3,0
 828:	4629                	li	a2,10
 82a:	000be583          	lwu	a1,0(s7)
 82e:	855a                	mv	a0,s6
 830:	de5ff0ef          	jal	614 <printint>
 834:	8ba6                	mv	s7,s1
      state = 0;
 836:	4981                	li	s3,0
 838:	bd7d                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 83a:	008b8493          	addi	s1,s7,8
 83e:	4681                	li	a3,0
 840:	4629                	li	a2,10
 842:	000bb583          	ld	a1,0(s7)
 846:	855a                	mv	a0,s6
 848:	dcdff0ef          	jal	614 <printint>
        i += 1;
 84c:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 84e:	8ba6                	mv	s7,s1
      state = 0;
 850:	4981                	li	s3,0
        i += 1;
 852:	b555                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 854:	008b8493          	addi	s1,s7,8
 858:	4681                	li	a3,0
 85a:	4629                	li	a2,10
 85c:	000bb583          	ld	a1,0(s7)
 860:	855a                	mv	a0,s6
 862:	db3ff0ef          	jal	614 <printint>
        i += 2;
 866:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 868:	8ba6                	mv	s7,s1
      state = 0;
 86a:	4981                	li	s3,0
        i += 2;
 86c:	b569                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 86e:	008b8493          	addi	s1,s7,8
 872:	4681                	li	a3,0
 874:	4641                	li	a2,16
 876:	000be583          	lwu	a1,0(s7)
 87a:	855a                	mv	a0,s6
 87c:	d99ff0ef          	jal	614 <printint>
 880:	8ba6                	mv	s7,s1
      state = 0;
 882:	4981                	li	s3,0
 884:	bd8d                	j	6f6 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 886:	008b8493          	addi	s1,s7,8
 88a:	4681                	li	a3,0
 88c:	4641                	li	a2,16
 88e:	000bb583          	ld	a1,0(s7)
 892:	855a                	mv	a0,s6
 894:	d81ff0ef          	jal	614 <printint>
        i += 1;
 898:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 89a:	8ba6                	mv	s7,s1
      state = 0;
 89c:	4981                	li	s3,0
        i += 1;
 89e:	bda1                	j	6f6 <vprintf+0x4a>
 8a0:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 8a2:	008b8d13          	addi	s10,s7,8
 8a6:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 8aa:	03000593          	li	a1,48
 8ae:	855a                	mv	a0,s6
 8b0:	d47ff0ef          	jal	5f6 <putc>
  putc(fd, 'x');
 8b4:	07800593          	li	a1,120
 8b8:	855a                	mv	a0,s6
 8ba:	d3dff0ef          	jal	5f6 <putc>
 8be:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8c0:	00000b97          	auipc	s7,0x0
 8c4:	2c8b8b93          	addi	s7,s7,712 # b88 <digits>
 8c8:	03c9d793          	srli	a5,s3,0x3c
 8cc:	97de                	add	a5,a5,s7
 8ce:	0007c583          	lbu	a1,0(a5)
 8d2:	855a                	mv	a0,s6
 8d4:	d23ff0ef          	jal	5f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8d8:	0992                	slli	s3,s3,0x4
 8da:	34fd                	addiw	s1,s1,-1
 8dc:	f4f5                	bnez	s1,8c8 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 8de:	8bea                	mv	s7,s10
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	6d02                	ld	s10,0(sp)
 8e4:	bd09                	j	6f6 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 8e6:	008b8493          	addi	s1,s7,8
 8ea:	000bc583          	lbu	a1,0(s7)
 8ee:	855a                	mv	a0,s6
 8f0:	d07ff0ef          	jal	5f6 <putc>
 8f4:	8ba6                	mv	s7,s1
      state = 0;
 8f6:	4981                	li	s3,0
 8f8:	bbfd                	j	6f6 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 8fa:	008b8993          	addi	s3,s7,8
 8fe:	000bb483          	ld	s1,0(s7)
 902:	cc91                	beqz	s1,91e <vprintf+0x272>
        for(; *s; s++)
 904:	0004c583          	lbu	a1,0(s1)
 908:	c195                	beqz	a1,92c <vprintf+0x280>
          putc(fd, *s);
 90a:	855a                	mv	a0,s6
 90c:	cebff0ef          	jal	5f6 <putc>
        for(; *s; s++)
 910:	0485                	addi	s1,s1,1
 912:	0004c583          	lbu	a1,0(s1)
 916:	f9f5                	bnez	a1,90a <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 918:	8bce                	mv	s7,s3
      state = 0;
 91a:	4981                	li	s3,0
 91c:	bbe9                	j	6f6 <vprintf+0x4a>
          s = "(null)";
 91e:	00000497          	auipc	s1,0x0
 922:	26248493          	addi	s1,s1,610 # b80 <malloc+0x152>
        for(; *s; s++)
 926:	02800593          	li	a1,40
 92a:	b7c5                	j	90a <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
 92c:	8bce                	mv	s7,s3
      state = 0;
 92e:	4981                	li	s3,0
 930:	b3d9                	j	6f6 <vprintf+0x4a>
 932:	6906                	ld	s2,64(sp)
 934:	79e2                	ld	s3,56(sp)
 936:	7a42                	ld	s4,48(sp)
 938:	7aa2                	ld	s5,40(sp)
 93a:	7b02                	ld	s6,32(sp)
 93c:	6be2                	ld	s7,24(sp)
 93e:	6c42                	ld	s8,16(sp)
 940:	6ca2                	ld	s9,8(sp)
    }
  }
}
 942:	60e6                	ld	ra,88(sp)
 944:	6446                	ld	s0,80(sp)
 946:	64a6                	ld	s1,72(sp)
 948:	6125                	addi	sp,sp,96
 94a:	8082                	ret

000000000000094c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 94c:	715d                	addi	sp,sp,-80
 94e:	ec06                	sd	ra,24(sp)
 950:	e822                	sd	s0,16(sp)
 952:	1000                	addi	s0,sp,32
 954:	e010                	sd	a2,0(s0)
 956:	e414                	sd	a3,8(s0)
 958:	e818                	sd	a4,16(s0)
 95a:	ec1c                	sd	a5,24(s0)
 95c:	03043023          	sd	a6,32(s0)
 960:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 964:	8622                	mv	a2,s0
 966:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 96a:	d43ff0ef          	jal	6ac <vprintf>
}
 96e:	60e2                	ld	ra,24(sp)
 970:	6442                	ld	s0,16(sp)
 972:	6161                	addi	sp,sp,80
 974:	8082                	ret

0000000000000976 <printf>:

void
printf(const char *fmt, ...)
{
 976:	711d                	addi	sp,sp,-96
 978:	ec06                	sd	ra,24(sp)
 97a:	e822                	sd	s0,16(sp)
 97c:	1000                	addi	s0,sp,32
 97e:	e40c                	sd	a1,8(s0)
 980:	e810                	sd	a2,16(s0)
 982:	ec14                	sd	a3,24(s0)
 984:	f018                	sd	a4,32(s0)
 986:	f41c                	sd	a5,40(s0)
 988:	03043823          	sd	a6,48(s0)
 98c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 990:	00840613          	addi	a2,s0,8
 994:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 998:	85aa                	mv	a1,a0
 99a:	4505                	li	a0,1
 99c:	d11ff0ef          	jal	6ac <vprintf>
}
 9a0:	60e2                	ld	ra,24(sp)
 9a2:	6442                	ld	s0,16(sp)
 9a4:	6125                	addi	sp,sp,96
 9a6:	8082                	ret

00000000000009a8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a8:	1141                	addi	sp,sp,-16
 9aa:	e406                	sd	ra,8(sp)
 9ac:	e022                	sd	s0,0(sp)
 9ae:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9b0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b4:	00001797          	auipc	a5,0x1
 9b8:	64c7b783          	ld	a5,1612(a5) # 2000 <freep>
 9bc:	a02d                	j	9e6 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9be:	4618                	lw	a4,8(a2)
 9c0:	9f2d                	addw	a4,a4,a1
 9c2:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9c6:	6398                	ld	a4,0(a5)
 9c8:	6310                	ld	a2,0(a4)
 9ca:	a83d                	j	a08 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9cc:	ff852703          	lw	a4,-8(a0)
 9d0:	9f31                	addw	a4,a4,a2
 9d2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9d4:	ff053683          	ld	a3,-16(a0)
 9d8:	a091                	j	a1c <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9da:	6398                	ld	a4,0(a5)
 9dc:	00e7e463          	bltu	a5,a4,9e4 <free+0x3c>
 9e0:	00e6ea63          	bltu	a3,a4,9f4 <free+0x4c>
{
 9e4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e6:	fed7fae3          	bgeu	a5,a3,9da <free+0x32>
 9ea:	6398                	ld	a4,0(a5)
 9ec:	00e6e463          	bltu	a3,a4,9f4 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f0:	fee7eae3          	bltu	a5,a4,9e4 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
 9f4:	ff852583          	lw	a1,-8(a0)
 9f8:	6390                	ld	a2,0(a5)
 9fa:	02059813          	slli	a6,a1,0x20
 9fe:	01c85713          	srli	a4,a6,0x1c
 a02:	9736                	add	a4,a4,a3
 a04:	fae60de3          	beq	a2,a4,9be <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
 a08:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a0c:	4790                	lw	a2,8(a5)
 a0e:	02061593          	slli	a1,a2,0x20
 a12:	01c5d713          	srli	a4,a1,0x1c
 a16:	973e                	add	a4,a4,a5
 a18:	fae68ae3          	beq	a3,a4,9cc <free+0x24>
    p->s.ptr = bp->s.ptr;
 a1c:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 a1e:	00001717          	auipc	a4,0x1
 a22:	5ef73123          	sd	a5,1506(a4) # 2000 <freep>
}
 a26:	60a2                	ld	ra,8(sp)
 a28:	6402                	ld	s0,0(sp)
 a2a:	0141                	addi	sp,sp,16
 a2c:	8082                	ret

0000000000000a2e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a2e:	7139                	addi	sp,sp,-64
 a30:	fc06                	sd	ra,56(sp)
 a32:	f822                	sd	s0,48(sp)
 a34:	f04a                	sd	s2,32(sp)
 a36:	ec4e                	sd	s3,24(sp)
 a38:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a3a:	02051993          	slli	s3,a0,0x20
 a3e:	0209d993          	srli	s3,s3,0x20
 a42:	09bd                	addi	s3,s3,15
 a44:	0049d993          	srli	s3,s3,0x4
 a48:	2985                	addiw	s3,s3,1
 a4a:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
 a4c:	00001517          	auipc	a0,0x1
 a50:	5b453503          	ld	a0,1460(a0) # 2000 <freep>
 a54:	c905                	beqz	a0,a84 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a56:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a58:	4798                	lw	a4,8(a5)
 a5a:	09377663          	bgeu	a4,s3,ae6 <malloc+0xb8>
 a5e:	f426                	sd	s1,40(sp)
 a60:	e852                	sd	s4,16(sp)
 a62:	e456                	sd	s5,8(sp)
 a64:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 a66:	8a4e                	mv	s4,s3
 a68:	6705                	lui	a4,0x1
 a6a:	00e9f363          	bgeu	s3,a4,a70 <malloc+0x42>
 a6e:	6a05                	lui	s4,0x1
 a70:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a74:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a78:	00001497          	auipc	s1,0x1
 a7c:	58848493          	addi	s1,s1,1416 # 2000 <freep>
  if(p == SBRK_ERROR)
 a80:	5afd                	li	s5,-1
 a82:	a83d                	j	ac0 <malloc+0x92>
 a84:	f426                	sd	s1,40(sp)
 a86:	e852                	sd	s4,16(sp)
 a88:	e456                	sd	s5,8(sp)
 a8a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 a8c:	00001797          	auipc	a5,0x1
 a90:	59478793          	addi	a5,a5,1428 # 2020 <base>
 a94:	00001717          	auipc	a4,0x1
 a98:	56f73623          	sd	a5,1388(a4) # 2000 <freep>
 a9c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a9e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 aa2:	b7d1                	j	a66 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
 aa4:	6398                	ld	a4,0(a5)
 aa6:	e118                	sd	a4,0(a0)
 aa8:	a899                	j	afe <malloc+0xd0>
  hp->s.size = nu;
 aaa:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aae:	0541                	addi	a0,a0,16
 ab0:	ef9ff0ef          	jal	9a8 <free>
  return freep;
 ab4:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
 ab6:	c125                	beqz	a0,b16 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aba:	4798                	lw	a4,8(a5)
 abc:	03277163          	bgeu	a4,s2,ade <malloc+0xb0>
    if(p == freep)
 ac0:	6098                	ld	a4,0(s1)
 ac2:	853e                	mv	a0,a5
 ac4:	fef71ae3          	bne	a4,a5,ab8 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
 ac8:	8552                	mv	a0,s4
 aca:	a59ff0ef          	jal	522 <sbrk>
  if(p == SBRK_ERROR)
 ace:	fd551ee3          	bne	a0,s5,aaa <malloc+0x7c>
        return 0;
 ad2:	4501                	li	a0,0
 ad4:	74a2                	ld	s1,40(sp)
 ad6:	6a42                	ld	s4,16(sp)
 ad8:	6aa2                	ld	s5,8(sp)
 ada:	6b02                	ld	s6,0(sp)
 adc:	a03d                	j	b0a <malloc+0xdc>
 ade:	74a2                	ld	s1,40(sp)
 ae0:	6a42                	ld	s4,16(sp)
 ae2:	6aa2                	ld	s5,8(sp)
 ae4:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 ae6:	fae90fe3          	beq	s2,a4,aa4 <malloc+0x76>
        p->s.size -= nunits;
 aea:	4137073b          	subw	a4,a4,s3
 aee:	c798                	sw	a4,8(a5)
        p += p->s.size;
 af0:	02071693          	slli	a3,a4,0x20
 af4:	01c6d713          	srli	a4,a3,0x1c
 af8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 afa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 afe:	00001717          	auipc	a4,0x1
 b02:	50a73123          	sd	a0,1282(a4) # 2000 <freep>
      return (void*)(p + 1);
 b06:	01078513          	addi	a0,a5,16
  }
}
 b0a:	70e2                	ld	ra,56(sp)
 b0c:	7442                	ld	s0,48(sp)
 b0e:	7902                	ld	s2,32(sp)
 b10:	69e2                	ld	s3,24(sp)
 b12:	6121                	addi	sp,sp,64
 b14:	8082                	ret
 b16:	74a2                	ld	s1,40(sp)
 b18:	6a42                	ld	s4,16(sp)
 b1a:	6aa2                	ld	s5,8(sp)
 b1c:	6b02                	ld	s6,0(sp)
 b1e:	b7f5                	j	b0a <malloc+0xdc>
