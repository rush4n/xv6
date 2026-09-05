
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	711d                	addi	sp,sp,-96
       2:	ec86                	sd	ra,88(sp)
       4:	e8a2                	sd	s0,80(sp)
       6:	e4a6                	sd	s1,72(sp)
       8:	e0ca                	sd	s2,64(sp)
       a:	fc4e                	sd	s3,56(sp)
       c:	f852                	sd	s4,48(sp)
       e:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
      10:	00008797          	auipc	a5,0x8
      14:	95878793          	addi	a5,a5,-1704 # 7968 <malloc+0x2584>
      18:	638c                	ld	a1,0(a5)
      1a:	6790                	ld	a2,8(a5)
      1c:	6b94                	ld	a3,16(a5)
      1e:	6f98                	ld	a4,24(a5)
      20:	739c                	ld	a5,32(a5)
      22:	fab43423          	sd	a1,-88(s0)
      26:	fac43823          	sd	a2,-80(s0)
      2a:	fad43c23          	sd	a3,-72(s0)
      2e:	fce43023          	sd	a4,-64(s0)
      32:	fcf43423          	sd	a5,-56(s0)
                     0xffffffffffffffff };

  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      36:	fa840493          	addi	s1,s0,-88
      3a:	fd040a13          	addi	s4,s0,-48
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      3e:	20100993          	li	s3,513
      42:	0004b903          	ld	s2,0(s1)
      46:	85ce                	mv	a1,s3
      48:	854a                	mv	a0,s2
      4a:	703040ef          	jal	4f4c <open>
    if(fd >= 0){
      4e:	00055d63          	bgez	a0,68 <copyinstr1+0x68>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
      52:	04a1                	addi	s1,s1,8
      54:	ff4497e3          	bne	s1,s4,42 <copyinstr1+0x42>
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      exit(1);
    }
  }
}
      58:	60e6                	ld	ra,88(sp)
      5a:	6446                	ld	s0,80(sp)
      5c:	64a6                	ld	s1,72(sp)
      5e:	6906                	ld	s2,64(sp)
      60:	79e2                	ld	s3,56(sp)
      62:	7a42                	ld	s4,48(sp)
      64:	6125                	addi	sp,sp,96
      66:	8082                	ret
      printf("open(%p) returned %d, not -1\n", (void*)addr, fd);
      68:	862a                	mv	a2,a0
      6a:	85ca                	mv	a1,s2
      6c:	00005517          	auipc	a0,0x5
      70:	47450513          	addi	a0,a0,1140 # 54e0 <malloc+0xfc>
      74:	2b8050ef          	jal	532c <printf>
      exit(1);
      78:	4505                	li	a0,1
      7a:	693040ef          	jal	4f0c <exit>

000000000000007e <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      7e:	0000b797          	auipc	a5,0xb
      82:	51a78793          	addi	a5,a5,1306 # b598 <uninit>
      86:	0000e697          	auipc	a3,0xe
      8a:	c2268693          	addi	a3,a3,-990 # dca8 <buf>
    if(uninit[i] != '\0'){
      8e:	0007c703          	lbu	a4,0(a5)
      92:	e709                	bnez	a4,9c <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      94:	0785                	addi	a5,a5,1
      96:	fed79ce3          	bne	a5,a3,8e <bsstest+0x10>
      9a:	8082                	ret
{
      9c:	1141                	addi	sp,sp,-16
      9e:	e406                	sd	ra,8(sp)
      a0:	e022                	sd	s0,0(sp)
      a2:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      a4:	85aa                	mv	a1,a0
      a6:	00005517          	auipc	a0,0x5
      aa:	45a50513          	addi	a0,a0,1114 # 5500 <malloc+0x11c>
      ae:	27e050ef          	jal	532c <printf>
      exit(1);
      b2:	4505                	li	a0,1
      b4:	659040ef          	jal	4f0c <exit>

00000000000000b8 <opentest>:
{
      b8:	1101                	addi	sp,sp,-32
      ba:	ec06                	sd	ra,24(sp)
      bc:	e822                	sd	s0,16(sp)
      be:	e426                	sd	s1,8(sp)
      c0:	1000                	addi	s0,sp,32
      c2:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      c4:	4581                	li	a1,0
      c6:	00005517          	auipc	a0,0x5
      ca:	45250513          	addi	a0,a0,1106 # 5518 <malloc+0x134>
      ce:	67f040ef          	jal	4f4c <open>
  if(fd < 0){
      d2:	02054263          	bltz	a0,f6 <opentest+0x3e>
  close(fd);
      d6:	65f040ef          	jal	4f34 <close>
  fd = open("doesnotexist", 0);
      da:	4581                	li	a1,0
      dc:	00005517          	auipc	a0,0x5
      e0:	45c50513          	addi	a0,a0,1116 # 5538 <malloc+0x154>
      e4:	669040ef          	jal	4f4c <open>
  if(fd >= 0){
      e8:	02055163          	bgez	a0,10a <opentest+0x52>
}
      ec:	60e2                	ld	ra,24(sp)
      ee:	6442                	ld	s0,16(sp)
      f0:	64a2                	ld	s1,8(sp)
      f2:	6105                	addi	sp,sp,32
      f4:	8082                	ret
    printf("%s: open echo failed!\n", s);
      f6:	85a6                	mv	a1,s1
      f8:	00005517          	auipc	a0,0x5
      fc:	42850513          	addi	a0,a0,1064 # 5520 <malloc+0x13c>
     100:	22c050ef          	jal	532c <printf>
    exit(1);
     104:	4505                	li	a0,1
     106:	607040ef          	jal	4f0c <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     10a:	85a6                	mv	a1,s1
     10c:	00005517          	auipc	a0,0x5
     110:	43c50513          	addi	a0,a0,1084 # 5548 <malloc+0x164>
     114:	218050ef          	jal	532c <printf>
    exit(1);
     118:	4505                	li	a0,1
     11a:	5f3040ef          	jal	4f0c <exit>

000000000000011e <truncate2>:
{
     11e:	7179                	addi	sp,sp,-48
     120:	f406                	sd	ra,40(sp)
     122:	f022                	sd	s0,32(sp)
     124:	ec26                	sd	s1,24(sp)
     126:	e84a                	sd	s2,16(sp)
     128:	e44e                	sd	s3,8(sp)
     12a:	1800                	addi	s0,sp,48
     12c:	89aa                	mv	s3,a0
  unlink("truncfile");
     12e:	00005517          	auipc	a0,0x5
     132:	44250513          	addi	a0,a0,1090 # 5570 <malloc+0x18c>
     136:	627040ef          	jal	4f5c <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13a:	60100593          	li	a1,1537
     13e:	00005517          	auipc	a0,0x5
     142:	43250513          	addi	a0,a0,1074 # 5570 <malloc+0x18c>
     146:	607040ef          	jal	4f4c <open>
     14a:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     14c:	4611                	li	a2,4
     14e:	00005597          	auipc	a1,0x5
     152:	43258593          	addi	a1,a1,1074 # 5580 <malloc+0x19c>
     156:	5d7040ef          	jal	4f2c <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     15a:	40100593          	li	a1,1025
     15e:	00005517          	auipc	a0,0x5
     162:	41250513          	addi	a0,a0,1042 # 5570 <malloc+0x18c>
     166:	5e7040ef          	jal	4f4c <open>
     16a:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     16c:	4605                	li	a2,1
     16e:	00005597          	auipc	a1,0x5
     172:	41a58593          	addi	a1,a1,1050 # 5588 <malloc+0x1a4>
     176:	8526                	mv	a0,s1
     178:	5b5040ef          	jal	4f2c <write>
  if(n != -1){
     17c:	57fd                	li	a5,-1
     17e:	02f51563          	bne	a0,a5,1a8 <truncate2+0x8a>
  unlink("truncfile");
     182:	00005517          	auipc	a0,0x5
     186:	3ee50513          	addi	a0,a0,1006 # 5570 <malloc+0x18c>
     18a:	5d3040ef          	jal	4f5c <unlink>
  close(fd1);
     18e:	8526                	mv	a0,s1
     190:	5a5040ef          	jal	4f34 <close>
  close(fd2);
     194:	854a                	mv	a0,s2
     196:	59f040ef          	jal	4f34 <close>
}
     19a:	70a2                	ld	ra,40(sp)
     19c:	7402                	ld	s0,32(sp)
     19e:	64e2                	ld	s1,24(sp)
     1a0:	6942                	ld	s2,16(sp)
     1a2:	69a2                	ld	s3,8(sp)
     1a4:	6145                	addi	sp,sp,48
     1a6:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1a8:	862a                	mv	a2,a0
     1aa:	85ce                	mv	a1,s3
     1ac:	00005517          	auipc	a0,0x5
     1b0:	3e450513          	addi	a0,a0,996 # 5590 <malloc+0x1ac>
     1b4:	178050ef          	jal	532c <printf>
    exit(1);
     1b8:	4505                	li	a0,1
     1ba:	553040ef          	jal	4f0c <exit>

00000000000001be <createtest>:
{
     1be:	7139                	addi	sp,sp,-64
     1c0:	fc06                	sd	ra,56(sp)
     1c2:	f822                	sd	s0,48(sp)
     1c4:	f426                	sd	s1,40(sp)
     1c6:	f04a                	sd	s2,32(sp)
     1c8:	ec4e                	sd	s3,24(sp)
     1ca:	e852                	sd	s4,16(sp)
     1cc:	0080                	addi	s0,sp,64
  name[0] = 'a';
     1ce:	06100793          	li	a5,97
     1d2:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     1d6:	fc040523          	sb	zero,-54(s0)
     1da:	03000493          	li	s1,48
    fd = open(name, O_CREATE|O_RDWR);
     1de:	fc840a13          	addi	s4,s0,-56
     1e2:	20200993          	li	s3,514
  for(i = 0; i < N; i++){
     1e6:	06400913          	li	s2,100
    name[1] = '0' + i;
     1ea:	fc9404a3          	sb	s1,-55(s0)
    fd = open(name, O_CREATE|O_RDWR);
     1ee:	85ce                	mv	a1,s3
     1f0:	8552                	mv	a0,s4
     1f2:	55b040ef          	jal	4f4c <open>
    close(fd);
     1f6:	53f040ef          	jal	4f34 <close>
  for(i = 0; i < N; i++){
     1fa:	2485                	addiw	s1,s1,1
     1fc:	0ff4f493          	zext.b	s1,s1
     200:	ff2495e3          	bne	s1,s2,1ea <createtest+0x2c>
  name[0] = 'a';
     204:	06100793          	li	a5,97
     208:	fcf40423          	sb	a5,-56(s0)
  name[2] = '\0';
     20c:	fc040523          	sb	zero,-54(s0)
     210:	03000493          	li	s1,48
    unlink(name);
     214:	fc840993          	addi	s3,s0,-56
  for(i = 0; i < N; i++){
     218:	06400913          	li	s2,100
    name[1] = '0' + i;
     21c:	fc9404a3          	sb	s1,-55(s0)
    unlink(name);
     220:	854e                	mv	a0,s3
     222:	53b040ef          	jal	4f5c <unlink>
  for(i = 0; i < N; i++){
     226:	2485                	addiw	s1,s1,1
     228:	0ff4f493          	zext.b	s1,s1
     22c:	ff2498e3          	bne	s1,s2,21c <createtest+0x5e>
}
     230:	70e2                	ld	ra,56(sp)
     232:	7442                	ld	s0,48(sp)
     234:	74a2                	ld	s1,40(sp)
     236:	7902                	ld	s2,32(sp)
     238:	69e2                	ld	s3,24(sp)
     23a:	6a42                	ld	s4,16(sp)
     23c:	6121                	addi	sp,sp,64
     23e:	8082                	ret

0000000000000240 <bigwrite>:
{
     240:	715d                	addi	sp,sp,-80
     242:	e486                	sd	ra,72(sp)
     244:	e0a2                	sd	s0,64(sp)
     246:	fc26                	sd	s1,56(sp)
     248:	f84a                	sd	s2,48(sp)
     24a:	f44e                	sd	s3,40(sp)
     24c:	f052                	sd	s4,32(sp)
     24e:	ec56                	sd	s5,24(sp)
     250:	e85a                	sd	s6,16(sp)
     252:	e45e                	sd	s7,8(sp)
     254:	e062                	sd	s8,0(sp)
     256:	0880                	addi	s0,sp,80
     258:	8c2a                	mv	s8,a0
  unlink("bigwrite");
     25a:	00005517          	auipc	a0,0x5
     25e:	35e50513          	addi	a0,a0,862 # 55b8 <malloc+0x1d4>
     262:	4fb040ef          	jal	4f5c <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     266:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     26a:	20200b93          	li	s7,514
     26e:	00005a97          	auipc	s5,0x5
     272:	34aa8a93          	addi	s5,s5,842 # 55b8 <malloc+0x1d4>
      int cc = write(fd, buf, sz);
     276:	0000ea17          	auipc	s4,0xe
     27a:	a32a0a13          	addi	s4,s4,-1486 # dca8 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     27e:	6b0d                	lui	s6,0x3
     280:	1c9b0b13          	addi	s6,s6,457 # 31c9 <subdir+0x4e7>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     284:	85de                	mv	a1,s7
     286:	8556                	mv	a0,s5
     288:	4c5040ef          	jal	4f4c <open>
     28c:	892a                	mv	s2,a0
    if(fd < 0){
     28e:	04054663          	bltz	a0,2da <bigwrite+0x9a>
      int cc = write(fd, buf, sz);
     292:	8626                	mv	a2,s1
     294:	85d2                	mv	a1,s4
     296:	497040ef          	jal	4f2c <write>
     29a:	89aa                	mv	s3,a0
      if(cc != sz){
     29c:	04a49963          	bne	s1,a0,2ee <bigwrite+0xae>
      int cc = write(fd, buf, sz);
     2a0:	8626                	mv	a2,s1
     2a2:	85d2                	mv	a1,s4
     2a4:	854a                	mv	a0,s2
     2a6:	487040ef          	jal	4f2c <write>
      if(cc != sz){
     2aa:	04951363          	bne	a0,s1,2f0 <bigwrite+0xb0>
    close(fd);
     2ae:	854a                	mv	a0,s2
     2b0:	485040ef          	jal	4f34 <close>
    unlink("bigwrite");
     2b4:	8556                	mv	a0,s5
     2b6:	4a7040ef          	jal	4f5c <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2ba:	1d74849b          	addiw	s1,s1,471
     2be:	fd6493e3          	bne	s1,s6,284 <bigwrite+0x44>
}
     2c2:	60a6                	ld	ra,72(sp)
     2c4:	6406                	ld	s0,64(sp)
     2c6:	74e2                	ld	s1,56(sp)
     2c8:	7942                	ld	s2,48(sp)
     2ca:	79a2                	ld	s3,40(sp)
     2cc:	7a02                	ld	s4,32(sp)
     2ce:	6ae2                	ld	s5,24(sp)
     2d0:	6b42                	ld	s6,16(sp)
     2d2:	6ba2                	ld	s7,8(sp)
     2d4:	6c02                	ld	s8,0(sp)
     2d6:	6161                	addi	sp,sp,80
     2d8:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     2da:	85e2                	mv	a1,s8
     2dc:	00005517          	auipc	a0,0x5
     2e0:	2ec50513          	addi	a0,a0,748 # 55c8 <malloc+0x1e4>
     2e4:	048050ef          	jal	532c <printf>
      exit(1);
     2e8:	4505                	li	a0,1
     2ea:	423040ef          	jal	4f0c <exit>
      if(cc != sz){
     2ee:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     2f0:	86aa                	mv	a3,a0
     2f2:	864e                	mv	a2,s3
     2f4:	85e2                	mv	a1,s8
     2f6:	00005517          	auipc	a0,0x5
     2fa:	2f250513          	addi	a0,a0,754 # 55e8 <malloc+0x204>
     2fe:	02e050ef          	jal	532c <printf>
        exit(1);
     302:	4505                	li	a0,1
     304:	409040ef          	jal	4f0c <exit>

0000000000000308 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     308:	7139                	addi	sp,sp,-64
     30a:	fc06                	sd	ra,56(sp)
     30c:	f822                	sd	s0,48(sp)
     30e:	f426                	sd	s1,40(sp)
     310:	f04a                	sd	s2,32(sp)
     312:	ec4e                	sd	s3,24(sp)
     314:	e852                	sd	s4,16(sp)
     316:	e456                	sd	s5,8(sp)
     318:	e05a                	sd	s6,0(sp)
     31a:	0080                	addi	s0,sp,64
  int assumed_free = 600;
  
  unlink("junk");
     31c:	00005517          	auipc	a0,0x5
     320:	2e450513          	addi	a0,a0,740 # 5600 <malloc+0x21c>
     324:	439040ef          	jal	4f5c <unlink>
     328:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     32c:	20100a93          	li	s5,513
     330:	00005997          	auipc	s3,0x5
     334:	2d098993          	addi	s3,s3,720 # 5600 <malloc+0x21c>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     338:	4b05                	li	s6,1
     33a:	5a7d                	li	s4,-1
     33c:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     340:	85d6                	mv	a1,s5
     342:	854e                	mv	a0,s3
     344:	409040ef          	jal	4f4c <open>
     348:	84aa                	mv	s1,a0
    if(fd < 0){
     34a:	04054d63          	bltz	a0,3a4 <badwrite+0x9c>
    write(fd, (char*)0xffffffffffL, 1);
     34e:	865a                	mv	a2,s6
     350:	85d2                	mv	a1,s4
     352:	3db040ef          	jal	4f2c <write>
    close(fd);
     356:	8526                	mv	a0,s1
     358:	3dd040ef          	jal	4f34 <close>
    unlink("junk");
     35c:	854e                	mv	a0,s3
     35e:	3ff040ef          	jal	4f5c <unlink>
  for(int i = 0; i < assumed_free; i++){
     362:	397d                	addiw	s2,s2,-1
     364:	fc091ee3          	bnez	s2,340 <badwrite+0x38>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     368:	20100593          	li	a1,513
     36c:	00005517          	auipc	a0,0x5
     370:	29450513          	addi	a0,a0,660 # 5600 <malloc+0x21c>
     374:	3d9040ef          	jal	4f4c <open>
     378:	84aa                	mv	s1,a0
  if(fd < 0){
     37a:	02054e63          	bltz	a0,3b6 <badwrite+0xae>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     37e:	4605                	li	a2,1
     380:	00005597          	auipc	a1,0x5
     384:	20858593          	addi	a1,a1,520 # 5588 <malloc+0x1a4>
     388:	3a5040ef          	jal	4f2c <write>
     38c:	4785                	li	a5,1
     38e:	02f50d63          	beq	a0,a5,3c8 <badwrite+0xc0>
    printf("write failed\n");
     392:	00005517          	auipc	a0,0x5
     396:	28e50513          	addi	a0,a0,654 # 5620 <malloc+0x23c>
     39a:	793040ef          	jal	532c <printf>
    exit(1);
     39e:	4505                	li	a0,1
     3a0:	36d040ef          	jal	4f0c <exit>
      printf("open junk failed\n");
     3a4:	00005517          	auipc	a0,0x5
     3a8:	26450513          	addi	a0,a0,612 # 5608 <malloc+0x224>
     3ac:	781040ef          	jal	532c <printf>
      exit(1);
     3b0:	4505                	li	a0,1
     3b2:	35b040ef          	jal	4f0c <exit>
    printf("open junk failed\n");
     3b6:	00005517          	auipc	a0,0x5
     3ba:	25250513          	addi	a0,a0,594 # 5608 <malloc+0x224>
     3be:	76f040ef          	jal	532c <printf>
    exit(1);
     3c2:	4505                	li	a0,1
     3c4:	349040ef          	jal	4f0c <exit>
  }
  close(fd);
     3c8:	8526                	mv	a0,s1
     3ca:	36b040ef          	jal	4f34 <close>
  unlink("junk");
     3ce:	00005517          	auipc	a0,0x5
     3d2:	23250513          	addi	a0,a0,562 # 5600 <malloc+0x21c>
     3d6:	387040ef          	jal	4f5c <unlink>

  exit(0);
     3da:	4501                	li	a0,0
     3dc:	331040ef          	jal	4f0c <exit>

00000000000003e0 <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     3e0:	711d                	addi	sp,sp,-96
     3e2:	ec86                	sd	ra,88(sp)
     3e4:	e8a2                	sd	s0,80(sp)
     3e6:	e4a6                	sd	s1,72(sp)
     3e8:	e0ca                	sd	s2,64(sp)
     3ea:	fc4e                	sd	s3,56(sp)
     3ec:	f852                	sd	s4,48(sp)
     3ee:	f456                	sd	s5,40(sp)
     3f0:	1080                	addi	s0,sp,96
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     3f2:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     3f4:	07a00993          	li	s3,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     3f8:	fa040913          	addi	s2,s0,-96
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     3fc:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
     400:	40000a93          	li	s5,1024
    name[0] = 'z';
     404:	fb340023          	sb	s3,-96(s0)
    name[1] = 'z';
     408:	fb3400a3          	sb	s3,-95(s0)
    name[2] = '0' + (i / 32);
     40c:	41f4d71b          	sraiw	a4,s1,0x1f
     410:	01b7571b          	srliw	a4,a4,0x1b
     414:	009707bb          	addw	a5,a4,s1
     418:	4057d69b          	sraiw	a3,a5,0x5
     41c:	0306869b          	addiw	a3,a3,48
     420:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     424:	8bfd                	andi	a5,a5,31
     426:	9f99                	subw	a5,a5,a4
     428:	0307879b          	addiw	a5,a5,48
     42c:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     430:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     434:	854a                	mv	a0,s2
     436:	327040ef          	jal	4f5c <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     43a:	85d2                	mv	a1,s4
     43c:	854a                	mv	a0,s2
     43e:	30f040ef          	jal	4f4c <open>
    if(fd < 0){
     442:	00054763          	bltz	a0,450 <outofinodes+0x70>
      // failure is eventually expected.
      break;
    }
    close(fd);
     446:	2ef040ef          	jal	4f34 <close>
  for(int i = 0; i < nzz; i++){
     44a:	2485                	addiw	s1,s1,1
     44c:	fb549ce3          	bne	s1,s5,404 <outofinodes+0x24>
     450:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     452:	07a00913          	li	s2,122
    name[1] = 'z';
    name[2] = '0' + (i / 32);
    name[3] = '0' + (i % 32);
    name[4] = '\0';
    unlink(name);
     456:	fa040a13          	addi	s4,s0,-96
  for(int i = 0; i < nzz; i++){
     45a:	40000993          	li	s3,1024
    name[0] = 'z';
     45e:	fb240023          	sb	s2,-96(s0)
    name[1] = 'z';
     462:	fb2400a3          	sb	s2,-95(s0)
    name[2] = '0' + (i / 32);
     466:	41f4d71b          	sraiw	a4,s1,0x1f
     46a:	01b7571b          	srliw	a4,a4,0x1b
     46e:	009707bb          	addw	a5,a4,s1
     472:	4057d69b          	sraiw	a3,a5,0x5
     476:	0306869b          	addiw	a3,a3,48
     47a:	fad40123          	sb	a3,-94(s0)
    name[3] = '0' + (i % 32);
     47e:	8bfd                	andi	a5,a5,31
     480:	9f99                	subw	a5,a5,a4
     482:	0307879b          	addiw	a5,a5,48
     486:	faf401a3          	sb	a5,-93(s0)
    name[4] = '\0';
     48a:	fa040223          	sb	zero,-92(s0)
    unlink(name);
     48e:	8552                	mv	a0,s4
     490:	2cd040ef          	jal	4f5c <unlink>
  for(int i = 0; i < nzz; i++){
     494:	2485                	addiw	s1,s1,1
     496:	fd3494e3          	bne	s1,s3,45e <outofinodes+0x7e>
  }
}
     49a:	60e6                	ld	ra,88(sp)
     49c:	6446                	ld	s0,80(sp)
     49e:	64a6                	ld	s1,72(sp)
     4a0:	6906                	ld	s2,64(sp)
     4a2:	79e2                	ld	s3,56(sp)
     4a4:	7a42                	ld	s4,48(sp)
     4a6:	7aa2                	ld	s5,40(sp)
     4a8:	6125                	addi	sp,sp,96
     4aa:	8082                	ret

00000000000004ac <copyin>:
{
     4ac:	7175                	addi	sp,sp,-144
     4ae:	e506                	sd	ra,136(sp)
     4b0:	e122                	sd	s0,128(sp)
     4b2:	fca6                	sd	s1,120(sp)
     4b4:	f8ca                	sd	s2,112(sp)
     4b6:	f4ce                	sd	s3,104(sp)
     4b8:	f0d2                	sd	s4,96(sp)
     4ba:	ecd6                	sd	s5,88(sp)
     4bc:	e8da                	sd	s6,80(sp)
     4be:	e4de                	sd	s7,72(sp)
     4c0:	e0e2                	sd	s8,64(sp)
     4c2:	fc66                	sd	s9,56(sp)
     4c4:	0900                	addi	s0,sp,144
  uint64 addrs[] = { 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     4c6:	00007797          	auipc	a5,0x7
     4ca:	4a278793          	addi	a5,a5,1186 # 7968 <malloc+0x2584>
     4ce:	638c                	ld	a1,0(a5)
     4d0:	6790                	ld	a2,8(a5)
     4d2:	6b94                	ld	a3,16(a5)
     4d4:	6f98                	ld	a4,24(a5)
     4d6:	739c                	ld	a5,32(a5)
     4d8:	f6b43c23          	sd	a1,-136(s0)
     4dc:	f8c43023          	sd	a2,-128(s0)
     4e0:	f8d43423          	sd	a3,-120(s0)
     4e4:	f8e43823          	sd	a4,-112(s0)
     4e8:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     4ec:	f7840913          	addi	s2,s0,-136
     4f0:	fa040c93          	addi	s9,s0,-96
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     4f4:	20100b13          	li	s6,513
     4f8:	00005a97          	auipc	s5,0x5
     4fc:	138a8a93          	addi	s5,s5,312 # 5630 <malloc+0x24c>
    int n = write(fd, (void*)addr, 8192);
     500:	6a09                	lui	s4,0x2
    n = write(1, (char*)addr, 8192);
     502:	4c05                	li	s8,1
    if(pipe(fds) < 0){
     504:	f7040b93          	addi	s7,s0,-144
    uint64 addr = addrs[ai];
     508:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     50c:	85da                	mv	a1,s6
     50e:	8556                	mv	a0,s5
     510:	23d040ef          	jal	4f4c <open>
     514:	84aa                	mv	s1,a0
    if(fd < 0){
     516:	06054a63          	bltz	a0,58a <copyin+0xde>
    int n = write(fd, (void*)addr, 8192);
     51a:	8652                	mv	a2,s4
     51c:	85ce                	mv	a1,s3
     51e:	20f040ef          	jal	4f2c <write>
    if(n >= 0){
     522:	06055d63          	bgez	a0,59c <copyin+0xf0>
    close(fd);
     526:	8526                	mv	a0,s1
     528:	20d040ef          	jal	4f34 <close>
    unlink("copyin1");
     52c:	8556                	mv	a0,s5
     52e:	22f040ef          	jal	4f5c <unlink>
    n = write(1, (char*)addr, 8192);
     532:	8652                	mv	a2,s4
     534:	85ce                	mv	a1,s3
     536:	8562                	mv	a0,s8
     538:	1f5040ef          	jal	4f2c <write>
    if(n > 0){
     53c:	06a04b63          	bgtz	a0,5b2 <copyin+0x106>
    if(pipe(fds) < 0){
     540:	855e                	mv	a0,s7
     542:	1db040ef          	jal	4f1c <pipe>
     546:	08054163          	bltz	a0,5c8 <copyin+0x11c>
    n = write(fds[1], (char*)addr, 8192);
     54a:	8652                	mv	a2,s4
     54c:	85ce                	mv	a1,s3
     54e:	f7442503          	lw	a0,-140(s0)
     552:	1db040ef          	jal	4f2c <write>
    if(n > 0){
     556:	08a04263          	bgtz	a0,5da <copyin+0x12e>
    close(fds[0]);
     55a:	f7042503          	lw	a0,-144(s0)
     55e:	1d7040ef          	jal	4f34 <close>
    close(fds[1]);
     562:	f7442503          	lw	a0,-140(s0)
     566:	1cf040ef          	jal	4f34 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     56a:	0921                	addi	s2,s2,8
     56c:	f9991ee3          	bne	s2,s9,508 <copyin+0x5c>
}
     570:	60aa                	ld	ra,136(sp)
     572:	640a                	ld	s0,128(sp)
     574:	74e6                	ld	s1,120(sp)
     576:	7946                	ld	s2,112(sp)
     578:	79a6                	ld	s3,104(sp)
     57a:	7a06                	ld	s4,96(sp)
     57c:	6ae6                	ld	s5,88(sp)
     57e:	6b46                	ld	s6,80(sp)
     580:	6ba6                	ld	s7,72(sp)
     582:	6c06                	ld	s8,64(sp)
     584:	7ce2                	ld	s9,56(sp)
     586:	6149                	addi	sp,sp,144
     588:	8082                	ret
      printf("open(copyin1) failed\n");
     58a:	00005517          	auipc	a0,0x5
     58e:	0ae50513          	addi	a0,a0,174 # 5638 <malloc+0x254>
     592:	59b040ef          	jal	532c <printf>
      exit(1);
     596:	4505                	li	a0,1
     598:	175040ef          	jal	4f0c <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", (void*)addr, n);
     59c:	862a                	mv	a2,a0
     59e:	85ce                	mv	a1,s3
     5a0:	00005517          	auipc	a0,0x5
     5a4:	0b050513          	addi	a0,a0,176 # 5650 <malloc+0x26c>
     5a8:	585040ef          	jal	532c <printf>
      exit(1);
     5ac:	4505                	li	a0,1
     5ae:	15f040ef          	jal	4f0c <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5b2:	862a                	mv	a2,a0
     5b4:	85ce                	mv	a1,s3
     5b6:	00005517          	auipc	a0,0x5
     5ba:	0ca50513          	addi	a0,a0,202 # 5680 <malloc+0x29c>
     5be:	56f040ef          	jal	532c <printf>
      exit(1);
     5c2:	4505                	li	a0,1
     5c4:	149040ef          	jal	4f0c <exit>
      printf("pipe() failed\n");
     5c8:	00005517          	auipc	a0,0x5
     5cc:	0e850513          	addi	a0,a0,232 # 56b0 <malloc+0x2cc>
     5d0:	55d040ef          	jal	532c <printf>
      exit(1);
     5d4:	4505                	li	a0,1
     5d6:	137040ef          	jal	4f0c <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     5da:	862a                	mv	a2,a0
     5dc:	85ce                	mv	a1,s3
     5de:	00005517          	auipc	a0,0x5
     5e2:	0e250513          	addi	a0,a0,226 # 56c0 <malloc+0x2dc>
     5e6:	547040ef          	jal	532c <printf>
      exit(1);
     5ea:	4505                	li	a0,1
     5ec:	121040ef          	jal	4f0c <exit>

00000000000005f0 <copyout>:
{
     5f0:	7135                	addi	sp,sp,-160
     5f2:	ed06                	sd	ra,152(sp)
     5f4:	e922                	sd	s0,144(sp)
     5f6:	e526                	sd	s1,136(sp)
     5f8:	e14a                	sd	s2,128(sp)
     5fa:	fcce                	sd	s3,120(sp)
     5fc:	f8d2                	sd	s4,112(sp)
     5fe:	f4d6                	sd	s5,104(sp)
     600:	f0da                	sd	s6,96(sp)
     602:	ecde                	sd	s7,88(sp)
     604:	e8e2                	sd	s8,80(sp)
     606:	e4e6                	sd	s9,72(sp)
     608:	1100                	addi	s0,sp,160
  uint64 addrs[] = { 0LL, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
     60a:	00007797          	auipc	a5,0x7
     60e:	35e78793          	addi	a5,a5,862 # 7968 <malloc+0x2584>
     612:	7788                	ld	a0,40(a5)
     614:	7b8c                	ld	a1,48(a5)
     616:	7f90                	ld	a2,56(a5)
     618:	63b4                	ld	a3,64(a5)
     61a:	67b8                	ld	a4,72(a5)
     61c:	6bbc                	ld	a5,80(a5)
     61e:	f6a43823          	sd	a0,-144(s0)
     622:	f6b43c23          	sd	a1,-136(s0)
     626:	f8c43023          	sd	a2,-128(s0)
     62a:	f8d43423          	sd	a3,-120(s0)
     62e:	f8e43823          	sd	a4,-112(s0)
     632:	f8f43c23          	sd	a5,-104(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     636:	f7040913          	addi	s2,s0,-144
     63a:	fa040c93          	addi	s9,s0,-96
    int fd = open("README", 0);
     63e:	00005b17          	auipc	s6,0x5
     642:	0b2b0b13          	addi	s6,s6,178 # 56f0 <malloc+0x30c>
    int n = read(fd, (void*)addr, 8192);
     646:	6a89                	lui	s5,0x2
    if(pipe(fds) < 0){
     648:	f6840c13          	addi	s8,s0,-152
    n = write(fds[1], "x", 1);
     64c:	4a05                	li	s4,1
     64e:	00005b97          	auipc	s7,0x5
     652:	f3ab8b93          	addi	s7,s7,-198 # 5588 <malloc+0x1a4>
    uint64 addr = addrs[ai];
     656:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     65a:	4581                	li	a1,0
     65c:	855a                	mv	a0,s6
     65e:	0ef040ef          	jal	4f4c <open>
     662:	84aa                	mv	s1,a0
    if(fd < 0){
     664:	06054863          	bltz	a0,6d4 <copyout+0xe4>
    int n = read(fd, (void*)addr, 8192);
     668:	8656                	mv	a2,s5
     66a:	85ce                	mv	a1,s3
     66c:	0b9040ef          	jal	4f24 <read>
    if(n > 0){
     670:	06a04b63          	bgtz	a0,6e6 <copyout+0xf6>
    close(fd);
     674:	8526                	mv	a0,s1
     676:	0bf040ef          	jal	4f34 <close>
    if(pipe(fds) < 0){
     67a:	8562                	mv	a0,s8
     67c:	0a1040ef          	jal	4f1c <pipe>
     680:	06054e63          	bltz	a0,6fc <copyout+0x10c>
    n = write(fds[1], "x", 1);
     684:	8652                	mv	a2,s4
     686:	85de                	mv	a1,s7
     688:	f6c42503          	lw	a0,-148(s0)
     68c:	0a1040ef          	jal	4f2c <write>
    if(n != 1){
     690:	07451f63          	bne	a0,s4,70e <copyout+0x11e>
    n = read(fds[0], (void*)addr, 8192);
     694:	8656                	mv	a2,s5
     696:	85ce                	mv	a1,s3
     698:	f6842503          	lw	a0,-152(s0)
     69c:	089040ef          	jal	4f24 <read>
    if(n > 0){
     6a0:	08a04063          	bgtz	a0,720 <copyout+0x130>
    close(fds[0]);
     6a4:	f6842503          	lw	a0,-152(s0)
     6a8:	08d040ef          	jal	4f34 <close>
    close(fds[1]);
     6ac:	f6c42503          	lw	a0,-148(s0)
     6b0:	085040ef          	jal	4f34 <close>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
     6b4:	0921                	addi	s2,s2,8
     6b6:	fb9910e3          	bne	s2,s9,656 <copyout+0x66>
}
     6ba:	60ea                	ld	ra,152(sp)
     6bc:	644a                	ld	s0,144(sp)
     6be:	64aa                	ld	s1,136(sp)
     6c0:	690a                	ld	s2,128(sp)
     6c2:	79e6                	ld	s3,120(sp)
     6c4:	7a46                	ld	s4,112(sp)
     6c6:	7aa6                	ld	s5,104(sp)
     6c8:	7b06                	ld	s6,96(sp)
     6ca:	6be6                	ld	s7,88(sp)
     6cc:	6c46                	ld	s8,80(sp)
     6ce:	6ca6                	ld	s9,72(sp)
     6d0:	610d                	addi	sp,sp,160
     6d2:	8082                	ret
      printf("open(README) failed\n");
     6d4:	00005517          	auipc	a0,0x5
     6d8:	02450513          	addi	a0,a0,36 # 56f8 <malloc+0x314>
     6dc:	451040ef          	jal	532c <printf>
      exit(1);
     6e0:	4505                	li	a0,1
     6e2:	02b040ef          	jal	4f0c <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     6e6:	862a                	mv	a2,a0
     6e8:	85ce                	mv	a1,s3
     6ea:	00005517          	auipc	a0,0x5
     6ee:	02650513          	addi	a0,a0,38 # 5710 <malloc+0x32c>
     6f2:	43b040ef          	jal	532c <printf>
      exit(1);
     6f6:	4505                	li	a0,1
     6f8:	015040ef          	jal	4f0c <exit>
      printf("pipe() failed\n");
     6fc:	00005517          	auipc	a0,0x5
     700:	fb450513          	addi	a0,a0,-76 # 56b0 <malloc+0x2cc>
     704:	429040ef          	jal	532c <printf>
      exit(1);
     708:	4505                	li	a0,1
     70a:	003040ef          	jal	4f0c <exit>
      printf("pipe write failed\n");
     70e:	00005517          	auipc	a0,0x5
     712:	03250513          	addi	a0,a0,50 # 5740 <malloc+0x35c>
     716:	417040ef          	jal	532c <printf>
      exit(1);
     71a:	4505                	li	a0,1
     71c:	7f0040ef          	jal	4f0c <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", (void*)addr, n);
     720:	862a                	mv	a2,a0
     722:	85ce                	mv	a1,s3
     724:	00005517          	auipc	a0,0x5
     728:	03450513          	addi	a0,a0,52 # 5758 <malloc+0x374>
     72c:	401040ef          	jal	532c <printf>
      exit(1);
     730:	4505                	li	a0,1
     732:	7da040ef          	jal	4f0c <exit>

0000000000000736 <truncate1>:
{
     736:	711d                	addi	sp,sp,-96
     738:	ec86                	sd	ra,88(sp)
     73a:	e8a2                	sd	s0,80(sp)
     73c:	e4a6                	sd	s1,72(sp)
     73e:	e0ca                	sd	s2,64(sp)
     740:	fc4e                	sd	s3,56(sp)
     742:	f852                	sd	s4,48(sp)
     744:	f456                	sd	s5,40(sp)
     746:	1080                	addi	s0,sp,96
     748:	8aaa                	mv	s5,a0
  unlink("truncfile");
     74a:	00005517          	auipc	a0,0x5
     74e:	e2650513          	addi	a0,a0,-474 # 5570 <malloc+0x18c>
     752:	00b040ef          	jal	4f5c <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     756:	60100593          	li	a1,1537
     75a:	00005517          	auipc	a0,0x5
     75e:	e1650513          	addi	a0,a0,-490 # 5570 <malloc+0x18c>
     762:	7ea040ef          	jal	4f4c <open>
     766:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     768:	4611                	li	a2,4
     76a:	00005597          	auipc	a1,0x5
     76e:	e1658593          	addi	a1,a1,-490 # 5580 <malloc+0x19c>
     772:	7ba040ef          	jal	4f2c <write>
  close(fd1);
     776:	8526                	mv	a0,s1
     778:	7bc040ef          	jal	4f34 <close>
  int fd2 = open("truncfile", O_RDONLY);
     77c:	4581                	li	a1,0
     77e:	00005517          	auipc	a0,0x5
     782:	df250513          	addi	a0,a0,-526 # 5570 <malloc+0x18c>
     786:	7c6040ef          	jal	4f4c <open>
     78a:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     78c:	02000613          	li	a2,32
     790:	fa040593          	addi	a1,s0,-96
     794:	790040ef          	jal	4f24 <read>
  if(n != 4){
     798:	4791                	li	a5,4
     79a:	0af51863          	bne	a0,a5,84a <truncate1+0x114>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     79e:	40100593          	li	a1,1025
     7a2:	00005517          	auipc	a0,0x5
     7a6:	dce50513          	addi	a0,a0,-562 # 5570 <malloc+0x18c>
     7aa:	7a2040ef          	jal	4f4c <open>
     7ae:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     7b0:	4581                	li	a1,0
     7b2:	00005517          	auipc	a0,0x5
     7b6:	dbe50513          	addi	a0,a0,-578 # 5570 <malloc+0x18c>
     7ba:	792040ef          	jal	4f4c <open>
     7be:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     7c0:	02000613          	li	a2,32
     7c4:	fa040593          	addi	a1,s0,-96
     7c8:	75c040ef          	jal	4f24 <read>
     7cc:	8a2a                	mv	s4,a0
  if(n != 0){
     7ce:	e949                	bnez	a0,860 <truncate1+0x12a>
  n = read(fd2, buf, sizeof(buf));
     7d0:	02000613          	li	a2,32
     7d4:	fa040593          	addi	a1,s0,-96
     7d8:	8526                	mv	a0,s1
     7da:	74a040ef          	jal	4f24 <read>
     7de:	8a2a                	mv	s4,a0
  if(n != 0){
     7e0:	e155                	bnez	a0,884 <truncate1+0x14e>
  write(fd1, "abcdef", 6);
     7e2:	4619                	li	a2,6
     7e4:	00005597          	auipc	a1,0x5
     7e8:	00458593          	addi	a1,a1,4 # 57e8 <malloc+0x404>
     7ec:	854e                	mv	a0,s3
     7ee:	73e040ef          	jal	4f2c <write>
  n = read(fd3, buf, sizeof(buf));
     7f2:	02000613          	li	a2,32
     7f6:	fa040593          	addi	a1,s0,-96
     7fa:	854a                	mv	a0,s2
     7fc:	728040ef          	jal	4f24 <read>
  if(n != 6){
     800:	4799                	li	a5,6
     802:	0af51363          	bne	a0,a5,8a8 <truncate1+0x172>
  n = read(fd2, buf, sizeof(buf));
     806:	02000613          	li	a2,32
     80a:	fa040593          	addi	a1,s0,-96
     80e:	8526                	mv	a0,s1
     810:	714040ef          	jal	4f24 <read>
  if(n != 2){
     814:	4789                	li	a5,2
     816:	0af51463          	bne	a0,a5,8be <truncate1+0x188>
  unlink("truncfile");
     81a:	00005517          	auipc	a0,0x5
     81e:	d5650513          	addi	a0,a0,-682 # 5570 <malloc+0x18c>
     822:	73a040ef          	jal	4f5c <unlink>
  close(fd1);
     826:	854e                	mv	a0,s3
     828:	70c040ef          	jal	4f34 <close>
  close(fd2);
     82c:	8526                	mv	a0,s1
     82e:	706040ef          	jal	4f34 <close>
  close(fd3);
     832:	854a                	mv	a0,s2
     834:	700040ef          	jal	4f34 <close>
}
     838:	60e6                	ld	ra,88(sp)
     83a:	6446                	ld	s0,80(sp)
     83c:	64a6                	ld	s1,72(sp)
     83e:	6906                	ld	s2,64(sp)
     840:	79e2                	ld	s3,56(sp)
     842:	7a42                	ld	s4,48(sp)
     844:	7aa2                	ld	s5,40(sp)
     846:	6125                	addi	sp,sp,96
     848:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     84a:	862a                	mv	a2,a0
     84c:	85d6                	mv	a1,s5
     84e:	00005517          	auipc	a0,0x5
     852:	f3a50513          	addi	a0,a0,-198 # 5788 <malloc+0x3a4>
     856:	2d7040ef          	jal	532c <printf>
    exit(1);
     85a:	4505                	li	a0,1
     85c:	6b0040ef          	jal	4f0c <exit>
    printf("aaa fd3=%d\n", fd3);
     860:	85ca                	mv	a1,s2
     862:	00005517          	auipc	a0,0x5
     866:	f4650513          	addi	a0,a0,-186 # 57a8 <malloc+0x3c4>
     86a:	2c3040ef          	jal	532c <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     86e:	8652                	mv	a2,s4
     870:	85d6                	mv	a1,s5
     872:	00005517          	auipc	a0,0x5
     876:	f4650513          	addi	a0,a0,-186 # 57b8 <malloc+0x3d4>
     87a:	2b3040ef          	jal	532c <printf>
    exit(1);
     87e:	4505                	li	a0,1
     880:	68c040ef          	jal	4f0c <exit>
    printf("bbb fd2=%d\n", fd2);
     884:	85a6                	mv	a1,s1
     886:	00005517          	auipc	a0,0x5
     88a:	f5250513          	addi	a0,a0,-174 # 57d8 <malloc+0x3f4>
     88e:	29f040ef          	jal	532c <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     892:	8652                	mv	a2,s4
     894:	85d6                	mv	a1,s5
     896:	00005517          	auipc	a0,0x5
     89a:	f2250513          	addi	a0,a0,-222 # 57b8 <malloc+0x3d4>
     89e:	28f040ef          	jal	532c <printf>
    exit(1);
     8a2:	4505                	li	a0,1
     8a4:	668040ef          	jal	4f0c <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     8a8:	862a                	mv	a2,a0
     8aa:	85d6                	mv	a1,s5
     8ac:	00005517          	auipc	a0,0x5
     8b0:	f4450513          	addi	a0,a0,-188 # 57f0 <malloc+0x40c>
     8b4:	279040ef          	jal	532c <printf>
    exit(1);
     8b8:	4505                	li	a0,1
     8ba:	652040ef          	jal	4f0c <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     8be:	862a                	mv	a2,a0
     8c0:	85d6                	mv	a1,s5
     8c2:	00005517          	auipc	a0,0x5
     8c6:	f4e50513          	addi	a0,a0,-178 # 5810 <malloc+0x42c>
     8ca:	263040ef          	jal	532c <printf>
    exit(1);
     8ce:	4505                	li	a0,1
     8d0:	63c040ef          	jal	4f0c <exit>

00000000000008d4 <writetest>:
{
     8d4:	715d                	addi	sp,sp,-80
     8d6:	e486                	sd	ra,72(sp)
     8d8:	e0a2                	sd	s0,64(sp)
     8da:	fc26                	sd	s1,56(sp)
     8dc:	f84a                	sd	s2,48(sp)
     8de:	f44e                	sd	s3,40(sp)
     8e0:	f052                	sd	s4,32(sp)
     8e2:	ec56                	sd	s5,24(sp)
     8e4:	e85a                	sd	s6,16(sp)
     8e6:	e45e                	sd	s7,8(sp)
     8e8:	0880                	addi	s0,sp,80
     8ea:	8baa                	mv	s7,a0
  fd = open("small", O_CREATE|O_RDWR);
     8ec:	20200593          	li	a1,514
     8f0:	00005517          	auipc	a0,0x5
     8f4:	f4050513          	addi	a0,a0,-192 # 5830 <malloc+0x44c>
     8f8:	654040ef          	jal	4f4c <open>
  if(fd < 0){
     8fc:	08054f63          	bltz	a0,99a <writetest+0xc6>
     900:	89aa                	mv	s3,a0
     902:	4901                	li	s2,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     904:	44a9                	li	s1,10
     906:	00005a17          	auipc	s4,0x5
     90a:	f52a0a13          	addi	s4,s4,-174 # 5858 <malloc+0x474>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     90e:	00005b17          	auipc	s6,0x5
     912:	f82b0b13          	addi	s6,s6,-126 # 5890 <malloc+0x4ac>
  for(i = 0; i < N; i++){
     916:	06400a93          	li	s5,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     91a:	8626                	mv	a2,s1
     91c:	85d2                	mv	a1,s4
     91e:	854e                	mv	a0,s3
     920:	60c040ef          	jal	4f2c <write>
     924:	08951563          	bne	a0,s1,9ae <writetest+0xda>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     928:	8626                	mv	a2,s1
     92a:	85da                	mv	a1,s6
     92c:	854e                	mv	a0,s3
     92e:	5fe040ef          	jal	4f2c <write>
     932:	08951963          	bne	a0,s1,9c4 <writetest+0xf0>
  for(i = 0; i < N; i++){
     936:	2905                	addiw	s2,s2,1
     938:	ff5911e3          	bne	s2,s5,91a <writetest+0x46>
  close(fd);
     93c:	854e                	mv	a0,s3
     93e:	5f6040ef          	jal	4f34 <close>
  fd = open("small", O_RDONLY);
     942:	4581                	li	a1,0
     944:	00005517          	auipc	a0,0x5
     948:	eec50513          	addi	a0,a0,-276 # 5830 <malloc+0x44c>
     94c:	600040ef          	jal	4f4c <open>
     950:	84aa                	mv	s1,a0
  if(fd < 0){
     952:	08054463          	bltz	a0,9da <writetest+0x106>
  i = read(fd, buf, N*SZ*2);
     956:	7d000613          	li	a2,2000
     95a:	0000d597          	auipc	a1,0xd
     95e:	34e58593          	addi	a1,a1,846 # dca8 <buf>
     962:	5c2040ef          	jal	4f24 <read>
  if(i != N*SZ*2){
     966:	7d000793          	li	a5,2000
     96a:	08f51263          	bne	a0,a5,9ee <writetest+0x11a>
  close(fd);
     96e:	8526                	mv	a0,s1
     970:	5c4040ef          	jal	4f34 <close>
  if(unlink("small") < 0){
     974:	00005517          	auipc	a0,0x5
     978:	ebc50513          	addi	a0,a0,-324 # 5830 <malloc+0x44c>
     97c:	5e0040ef          	jal	4f5c <unlink>
     980:	08054163          	bltz	a0,a02 <writetest+0x12e>
}
     984:	60a6                	ld	ra,72(sp)
     986:	6406                	ld	s0,64(sp)
     988:	74e2                	ld	s1,56(sp)
     98a:	7942                	ld	s2,48(sp)
     98c:	79a2                	ld	s3,40(sp)
     98e:	7a02                	ld	s4,32(sp)
     990:	6ae2                	ld	s5,24(sp)
     992:	6b42                	ld	s6,16(sp)
     994:	6ba2                	ld	s7,8(sp)
     996:	6161                	addi	sp,sp,80
     998:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     99a:	85de                	mv	a1,s7
     99c:	00005517          	auipc	a0,0x5
     9a0:	e9c50513          	addi	a0,a0,-356 # 5838 <malloc+0x454>
     9a4:	189040ef          	jal	532c <printf>
    exit(1);
     9a8:	4505                	li	a0,1
     9aa:	562040ef          	jal	4f0c <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     9ae:	864a                	mv	a2,s2
     9b0:	85de                	mv	a1,s7
     9b2:	00005517          	auipc	a0,0x5
     9b6:	eb650513          	addi	a0,a0,-330 # 5868 <malloc+0x484>
     9ba:	173040ef          	jal	532c <printf>
      exit(1);
     9be:	4505                	li	a0,1
     9c0:	54c040ef          	jal	4f0c <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     9c4:	864a                	mv	a2,s2
     9c6:	85de                	mv	a1,s7
     9c8:	00005517          	auipc	a0,0x5
     9cc:	ed850513          	addi	a0,a0,-296 # 58a0 <malloc+0x4bc>
     9d0:	15d040ef          	jal	532c <printf>
      exit(1);
     9d4:	4505                	li	a0,1
     9d6:	536040ef          	jal	4f0c <exit>
    printf("%s: error: open small failed!\n", s);
     9da:	85de                	mv	a1,s7
     9dc:	00005517          	auipc	a0,0x5
     9e0:	eec50513          	addi	a0,a0,-276 # 58c8 <malloc+0x4e4>
     9e4:	149040ef          	jal	532c <printf>
    exit(1);
     9e8:	4505                	li	a0,1
     9ea:	522040ef          	jal	4f0c <exit>
    printf("%s: read failed\n", s);
     9ee:	85de                	mv	a1,s7
     9f0:	00005517          	auipc	a0,0x5
     9f4:	ef850513          	addi	a0,a0,-264 # 58e8 <malloc+0x504>
     9f8:	135040ef          	jal	532c <printf>
    exit(1);
     9fc:	4505                	li	a0,1
     9fe:	50e040ef          	jal	4f0c <exit>
    printf("%s: unlink small failed\n", s);
     a02:	85de                	mv	a1,s7
     a04:	00005517          	auipc	a0,0x5
     a08:	efc50513          	addi	a0,a0,-260 # 5900 <malloc+0x51c>
     a0c:	121040ef          	jal	532c <printf>
    exit(1);
     a10:	4505                	li	a0,1
     a12:	4fa040ef          	jal	4f0c <exit>

0000000000000a16 <writebig>:
{
     a16:	7139                	addi	sp,sp,-64
     a18:	fc06                	sd	ra,56(sp)
     a1a:	f822                	sd	s0,48(sp)
     a1c:	f426                	sd	s1,40(sp)
     a1e:	f04a                	sd	s2,32(sp)
     a20:	ec4e                	sd	s3,24(sp)
     a22:	e852                	sd	s4,16(sp)
     a24:	e456                	sd	s5,8(sp)
     a26:	e05a                	sd	s6,0(sp)
     a28:	0080                	addi	s0,sp,64
     a2a:	8b2a                	mv	s6,a0
  fd = open("big", O_CREATE|O_RDWR);
     a2c:	20200593          	li	a1,514
     a30:	00005517          	auipc	a0,0x5
     a34:	ef050513          	addi	a0,a0,-272 # 5920 <malloc+0x53c>
     a38:	514040ef          	jal	4f4c <open>
  if(fd < 0){
     a3c:	06054a63          	bltz	a0,ab0 <writebig+0x9a>
     a40:	8a2a                	mv	s4,a0
     a42:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     a44:	0000d997          	auipc	s3,0xd
     a48:	26498993          	addi	s3,s3,612 # dca8 <buf>
    if(write(fd, buf, BSIZE) != BSIZE){
     a4c:	40000913          	li	s2,1024
  for(i = 0; i < MAXFILE; i++){
     a50:	10c00a93          	li	s5,268
    ((int*)buf)[0] = i;
     a54:	0099a023          	sw	s1,0(s3)
    if(write(fd, buf, BSIZE) != BSIZE){
     a58:	864a                	mv	a2,s2
     a5a:	85ce                	mv	a1,s3
     a5c:	8552                	mv	a0,s4
     a5e:	4ce040ef          	jal	4f2c <write>
     a62:	07251163          	bne	a0,s2,ac4 <writebig+0xae>
  for(i = 0; i < MAXFILE; i++){
     a66:	2485                	addiw	s1,s1,1
     a68:	ff5496e3          	bne	s1,s5,a54 <writebig+0x3e>
  close(fd);
     a6c:	8552                	mv	a0,s4
     a6e:	4c6040ef          	jal	4f34 <close>
  fd = open("big", O_RDONLY);
     a72:	4581                	li	a1,0
     a74:	00005517          	auipc	a0,0x5
     a78:	eac50513          	addi	a0,a0,-340 # 5920 <malloc+0x53c>
     a7c:	4d0040ef          	jal	4f4c <open>
     a80:	8a2a                	mv	s4,a0
  n = 0;
     a82:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a84:	40000993          	li	s3,1024
     a88:	0000d917          	auipc	s2,0xd
     a8c:	22090913          	addi	s2,s2,544 # dca8 <buf>
  if(fd < 0){
     a90:	04054563          	bltz	a0,ada <writebig+0xc4>
    i = read(fd, buf, BSIZE);
     a94:	864e                	mv	a2,s3
     a96:	85ca                	mv	a1,s2
     a98:	8552                	mv	a0,s4
     a9a:	48a040ef          	jal	4f24 <read>
    if(i == 0){
     a9e:	c921                	beqz	a0,aee <writebig+0xd8>
    } else if(i != BSIZE){
     aa0:	09351b63          	bne	a0,s3,b36 <writebig+0x120>
    if(((int*)buf)[0] != n){
     aa4:	00092683          	lw	a3,0(s2)
     aa8:	0a969263          	bne	a3,s1,b4c <writebig+0x136>
    n++;
     aac:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     aae:	b7dd                	j	a94 <writebig+0x7e>
    printf("%s: error: creat big failed!\n", s);
     ab0:	85da                	mv	a1,s6
     ab2:	00005517          	auipc	a0,0x5
     ab6:	e7650513          	addi	a0,a0,-394 # 5928 <malloc+0x544>
     aba:	073040ef          	jal	532c <printf>
    exit(1);
     abe:	4505                	li	a0,1
     ac0:	44c040ef          	jal	4f0c <exit>
      printf("%s: error: write big file failed i=%d\n", s, i);
     ac4:	8626                	mv	a2,s1
     ac6:	85da                	mv	a1,s6
     ac8:	00005517          	auipc	a0,0x5
     acc:	e8050513          	addi	a0,a0,-384 # 5948 <malloc+0x564>
     ad0:	05d040ef          	jal	532c <printf>
      exit(1);
     ad4:	4505                	li	a0,1
     ad6:	436040ef          	jal	4f0c <exit>
    printf("%s: error: open big failed!\n", s);
     ada:	85da                	mv	a1,s6
     adc:	00005517          	auipc	a0,0x5
     ae0:	e9450513          	addi	a0,a0,-364 # 5970 <malloc+0x58c>
     ae4:	049040ef          	jal	532c <printf>
    exit(1);
     ae8:	4505                	li	a0,1
     aea:	422040ef          	jal	4f0c <exit>
      if(n != MAXFILE){
     aee:	10c00793          	li	a5,268
     af2:	02f49763          	bne	s1,a5,b20 <writebig+0x10a>
  close(fd);
     af6:	8552                	mv	a0,s4
     af8:	43c040ef          	jal	4f34 <close>
  if(unlink("big") < 0){
     afc:	00005517          	auipc	a0,0x5
     b00:	e2450513          	addi	a0,a0,-476 # 5920 <malloc+0x53c>
     b04:	458040ef          	jal	4f5c <unlink>
     b08:	04054d63          	bltz	a0,b62 <writebig+0x14c>
}
     b0c:	70e2                	ld	ra,56(sp)
     b0e:	7442                	ld	s0,48(sp)
     b10:	74a2                	ld	s1,40(sp)
     b12:	7902                	ld	s2,32(sp)
     b14:	69e2                	ld	s3,24(sp)
     b16:	6a42                	ld	s4,16(sp)
     b18:	6aa2                	ld	s5,8(sp)
     b1a:	6b02                	ld	s6,0(sp)
     b1c:	6121                	addi	sp,sp,64
     b1e:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     b20:	8626                	mv	a2,s1
     b22:	85da                	mv	a1,s6
     b24:	00005517          	auipc	a0,0x5
     b28:	e6c50513          	addi	a0,a0,-404 # 5990 <malloc+0x5ac>
     b2c:	001040ef          	jal	532c <printf>
        exit(1);
     b30:	4505                	li	a0,1
     b32:	3da040ef          	jal	4f0c <exit>
      printf("%s: read failed %d\n", s, i);
     b36:	862a                	mv	a2,a0
     b38:	85da                	mv	a1,s6
     b3a:	00005517          	auipc	a0,0x5
     b3e:	e7e50513          	addi	a0,a0,-386 # 59b8 <malloc+0x5d4>
     b42:	7ea040ef          	jal	532c <printf>
      exit(1);
     b46:	4505                	li	a0,1
     b48:	3c4040ef          	jal	4f0c <exit>
      printf("%s: read content of block %d is %d\n", s,
     b4c:	8626                	mv	a2,s1
     b4e:	85da                	mv	a1,s6
     b50:	00005517          	auipc	a0,0x5
     b54:	e8050513          	addi	a0,a0,-384 # 59d0 <malloc+0x5ec>
     b58:	7d4040ef          	jal	532c <printf>
      exit(1);
     b5c:	4505                	li	a0,1
     b5e:	3ae040ef          	jal	4f0c <exit>
    printf("%s: unlink big failed\n", s);
     b62:	85da                	mv	a1,s6
     b64:	00005517          	auipc	a0,0x5
     b68:	e9450513          	addi	a0,a0,-364 # 59f8 <malloc+0x614>
     b6c:	7c0040ef          	jal	532c <printf>
    exit(1);
     b70:	4505                	li	a0,1
     b72:	39a040ef          	jal	4f0c <exit>

0000000000000b76 <unlinkread>:
{
     b76:	7179                	addi	sp,sp,-48
     b78:	f406                	sd	ra,40(sp)
     b7a:	f022                	sd	s0,32(sp)
     b7c:	ec26                	sd	s1,24(sp)
     b7e:	e84a                	sd	s2,16(sp)
     b80:	e44e                	sd	s3,8(sp)
     b82:	1800                	addi	s0,sp,48
     b84:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b86:	20200593          	li	a1,514
     b8a:	00005517          	auipc	a0,0x5
     b8e:	e8650513          	addi	a0,a0,-378 # 5a10 <malloc+0x62c>
     b92:	3ba040ef          	jal	4f4c <open>
  if(fd < 0){
     b96:	0a054f63          	bltz	a0,c54 <unlinkread+0xde>
     b9a:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b9c:	4615                	li	a2,5
     b9e:	00005597          	auipc	a1,0x5
     ba2:	ea258593          	addi	a1,a1,-350 # 5a40 <malloc+0x65c>
     ba6:	386040ef          	jal	4f2c <write>
  close(fd);
     baa:	8526                	mv	a0,s1
     bac:	388040ef          	jal	4f34 <close>
  fd = open("unlinkread", O_RDWR);
     bb0:	4589                	li	a1,2
     bb2:	00005517          	auipc	a0,0x5
     bb6:	e5e50513          	addi	a0,a0,-418 # 5a10 <malloc+0x62c>
     bba:	392040ef          	jal	4f4c <open>
     bbe:	84aa                	mv	s1,a0
  if(fd < 0){
     bc0:	0a054463          	bltz	a0,c68 <unlinkread+0xf2>
  if(unlink("unlinkread") != 0){
     bc4:	00005517          	auipc	a0,0x5
     bc8:	e4c50513          	addi	a0,a0,-436 # 5a10 <malloc+0x62c>
     bcc:	390040ef          	jal	4f5c <unlink>
     bd0:	e555                	bnez	a0,c7c <unlinkread+0x106>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd2:	20200593          	li	a1,514
     bd6:	00005517          	auipc	a0,0x5
     bda:	e3a50513          	addi	a0,a0,-454 # 5a10 <malloc+0x62c>
     bde:	36e040ef          	jal	4f4c <open>
     be2:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be4:	460d                	li	a2,3
     be6:	00005597          	auipc	a1,0x5
     bea:	ea258593          	addi	a1,a1,-350 # 5a88 <malloc+0x6a4>
     bee:	33e040ef          	jal	4f2c <write>
  close(fd1);
     bf2:	854a                	mv	a0,s2
     bf4:	340040ef          	jal	4f34 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     bf8:	660d                	lui	a2,0x3
     bfa:	0000d597          	auipc	a1,0xd
     bfe:	0ae58593          	addi	a1,a1,174 # dca8 <buf>
     c02:	8526                	mv	a0,s1
     c04:	320040ef          	jal	4f24 <read>
     c08:	4795                	li	a5,5
     c0a:	08f51363          	bne	a0,a5,c90 <unlinkread+0x11a>
  if(buf[0] != 'h'){
     c0e:	0000d717          	auipc	a4,0xd
     c12:	09a74703          	lbu	a4,154(a4) # dca8 <buf>
     c16:	06800793          	li	a5,104
     c1a:	08f71563          	bne	a4,a5,ca4 <unlinkread+0x12e>
  if(write(fd, buf, 10) != 10){
     c1e:	4629                	li	a2,10
     c20:	0000d597          	auipc	a1,0xd
     c24:	08858593          	addi	a1,a1,136 # dca8 <buf>
     c28:	8526                	mv	a0,s1
     c2a:	302040ef          	jal	4f2c <write>
     c2e:	47a9                	li	a5,10
     c30:	08f51463          	bne	a0,a5,cb8 <unlinkread+0x142>
  close(fd);
     c34:	8526                	mv	a0,s1
     c36:	2fe040ef          	jal	4f34 <close>
  unlink("unlinkread");
     c3a:	00005517          	auipc	a0,0x5
     c3e:	dd650513          	addi	a0,a0,-554 # 5a10 <malloc+0x62c>
     c42:	31a040ef          	jal	4f5c <unlink>
}
     c46:	70a2                	ld	ra,40(sp)
     c48:	7402                	ld	s0,32(sp)
     c4a:	64e2                	ld	s1,24(sp)
     c4c:	6942                	ld	s2,16(sp)
     c4e:	69a2                	ld	s3,8(sp)
     c50:	6145                	addi	sp,sp,48
     c52:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c54:	85ce                	mv	a1,s3
     c56:	00005517          	auipc	a0,0x5
     c5a:	dca50513          	addi	a0,a0,-566 # 5a20 <malloc+0x63c>
     c5e:	6ce040ef          	jal	532c <printf>
    exit(1);
     c62:	4505                	li	a0,1
     c64:	2a8040ef          	jal	4f0c <exit>
    printf("%s: open unlinkread failed\n", s);
     c68:	85ce                	mv	a1,s3
     c6a:	00005517          	auipc	a0,0x5
     c6e:	dde50513          	addi	a0,a0,-546 # 5a48 <malloc+0x664>
     c72:	6ba040ef          	jal	532c <printf>
    exit(1);
     c76:	4505                	li	a0,1
     c78:	294040ef          	jal	4f0c <exit>
    printf("%s: unlink unlinkread failed\n", s);
     c7c:	85ce                	mv	a1,s3
     c7e:	00005517          	auipc	a0,0x5
     c82:	dea50513          	addi	a0,a0,-534 # 5a68 <malloc+0x684>
     c86:	6a6040ef          	jal	532c <printf>
    exit(1);
     c8a:	4505                	li	a0,1
     c8c:	280040ef          	jal	4f0c <exit>
    printf("%s: unlinkread read failed", s);
     c90:	85ce                	mv	a1,s3
     c92:	00005517          	auipc	a0,0x5
     c96:	dfe50513          	addi	a0,a0,-514 # 5a90 <malloc+0x6ac>
     c9a:	692040ef          	jal	532c <printf>
    exit(1);
     c9e:	4505                	li	a0,1
     ca0:	26c040ef          	jal	4f0c <exit>
    printf("%s: unlinkread wrong data\n", s);
     ca4:	85ce                	mv	a1,s3
     ca6:	00005517          	auipc	a0,0x5
     caa:	e0a50513          	addi	a0,a0,-502 # 5ab0 <malloc+0x6cc>
     cae:	67e040ef          	jal	532c <printf>
    exit(1);
     cb2:	4505                	li	a0,1
     cb4:	258040ef          	jal	4f0c <exit>
    printf("%s: unlinkread write failed\n", s);
     cb8:	85ce                	mv	a1,s3
     cba:	00005517          	auipc	a0,0x5
     cbe:	e1650513          	addi	a0,a0,-490 # 5ad0 <malloc+0x6ec>
     cc2:	66a040ef          	jal	532c <printf>
    exit(1);
     cc6:	4505                	li	a0,1
     cc8:	244040ef          	jal	4f0c <exit>

0000000000000ccc <linktest>:
{
     ccc:	1101                	addi	sp,sp,-32
     cce:	ec06                	sd	ra,24(sp)
     cd0:	e822                	sd	s0,16(sp)
     cd2:	e426                	sd	s1,8(sp)
     cd4:	e04a                	sd	s2,0(sp)
     cd6:	1000                	addi	s0,sp,32
     cd8:	892a                	mv	s2,a0
  unlink("lf1");
     cda:	00005517          	auipc	a0,0x5
     cde:	e1650513          	addi	a0,a0,-490 # 5af0 <malloc+0x70c>
     ce2:	27a040ef          	jal	4f5c <unlink>
  unlink("lf2");
     ce6:	00005517          	auipc	a0,0x5
     cea:	e1250513          	addi	a0,a0,-494 # 5af8 <malloc+0x714>
     cee:	26e040ef          	jal	4f5c <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     cf2:	20200593          	li	a1,514
     cf6:	00005517          	auipc	a0,0x5
     cfa:	dfa50513          	addi	a0,a0,-518 # 5af0 <malloc+0x70c>
     cfe:	24e040ef          	jal	4f4c <open>
  if(fd < 0){
     d02:	0c054f63          	bltz	a0,de0 <linktest+0x114>
     d06:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d08:	4615                	li	a2,5
     d0a:	00005597          	auipc	a1,0x5
     d0e:	d3658593          	addi	a1,a1,-714 # 5a40 <malloc+0x65c>
     d12:	21a040ef          	jal	4f2c <write>
     d16:	4795                	li	a5,5
     d18:	0cf51e63          	bne	a0,a5,df4 <linktest+0x128>
  close(fd);
     d1c:	8526                	mv	a0,s1
     d1e:	216040ef          	jal	4f34 <close>
  if(link("lf1", "lf2") < 0){
     d22:	00005597          	auipc	a1,0x5
     d26:	dd658593          	addi	a1,a1,-554 # 5af8 <malloc+0x714>
     d2a:	00005517          	auipc	a0,0x5
     d2e:	dc650513          	addi	a0,a0,-570 # 5af0 <malloc+0x70c>
     d32:	23a040ef          	jal	4f6c <link>
     d36:	0c054963          	bltz	a0,e08 <linktest+0x13c>
  unlink("lf1");
     d3a:	00005517          	auipc	a0,0x5
     d3e:	db650513          	addi	a0,a0,-586 # 5af0 <malloc+0x70c>
     d42:	21a040ef          	jal	4f5c <unlink>
  if(open("lf1", 0) >= 0){
     d46:	4581                	li	a1,0
     d48:	00005517          	auipc	a0,0x5
     d4c:	da850513          	addi	a0,a0,-600 # 5af0 <malloc+0x70c>
     d50:	1fc040ef          	jal	4f4c <open>
     d54:	0c055463          	bgez	a0,e1c <linktest+0x150>
  fd = open("lf2", 0);
     d58:	4581                	li	a1,0
     d5a:	00005517          	auipc	a0,0x5
     d5e:	d9e50513          	addi	a0,a0,-610 # 5af8 <malloc+0x714>
     d62:	1ea040ef          	jal	4f4c <open>
     d66:	84aa                	mv	s1,a0
  if(fd < 0){
     d68:	0c054463          	bltz	a0,e30 <linktest+0x164>
  if(read(fd, buf, sizeof(buf)) != SZ){
     d6c:	660d                	lui	a2,0x3
     d6e:	0000d597          	auipc	a1,0xd
     d72:	f3a58593          	addi	a1,a1,-198 # dca8 <buf>
     d76:	1ae040ef          	jal	4f24 <read>
     d7a:	4795                	li	a5,5
     d7c:	0cf51463          	bne	a0,a5,e44 <linktest+0x178>
  close(fd);
     d80:	8526                	mv	a0,s1
     d82:	1b2040ef          	jal	4f34 <close>
  if(link("lf2", "lf2") >= 0){
     d86:	00005597          	auipc	a1,0x5
     d8a:	d7258593          	addi	a1,a1,-654 # 5af8 <malloc+0x714>
     d8e:	852e                	mv	a0,a1
     d90:	1dc040ef          	jal	4f6c <link>
     d94:	0c055263          	bgez	a0,e58 <linktest+0x18c>
  unlink("lf2");
     d98:	00005517          	auipc	a0,0x5
     d9c:	d6050513          	addi	a0,a0,-672 # 5af8 <malloc+0x714>
     da0:	1bc040ef          	jal	4f5c <unlink>
  if(link("lf2", "lf1") >= 0){
     da4:	00005597          	auipc	a1,0x5
     da8:	d4c58593          	addi	a1,a1,-692 # 5af0 <malloc+0x70c>
     dac:	00005517          	auipc	a0,0x5
     db0:	d4c50513          	addi	a0,a0,-692 # 5af8 <malloc+0x714>
     db4:	1b8040ef          	jal	4f6c <link>
     db8:	0a055a63          	bgez	a0,e6c <linktest+0x1a0>
  if(link(".", "lf1") >= 0){
     dbc:	00005597          	auipc	a1,0x5
     dc0:	d3458593          	addi	a1,a1,-716 # 5af0 <malloc+0x70c>
     dc4:	00005517          	auipc	a0,0x5
     dc8:	e3c50513          	addi	a0,a0,-452 # 5c00 <malloc+0x81c>
     dcc:	1a0040ef          	jal	4f6c <link>
     dd0:	0a055863          	bgez	a0,e80 <linktest+0x1b4>
}
     dd4:	60e2                	ld	ra,24(sp)
     dd6:	6442                	ld	s0,16(sp)
     dd8:	64a2                	ld	s1,8(sp)
     dda:	6902                	ld	s2,0(sp)
     ddc:	6105                	addi	sp,sp,32
     dde:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     de0:	85ca                	mv	a1,s2
     de2:	00005517          	auipc	a0,0x5
     de6:	d1e50513          	addi	a0,a0,-738 # 5b00 <malloc+0x71c>
     dea:	542040ef          	jal	532c <printf>
    exit(1);
     dee:	4505                	li	a0,1
     df0:	11c040ef          	jal	4f0c <exit>
    printf("%s: write lf1 failed\n", s);
     df4:	85ca                	mv	a1,s2
     df6:	00005517          	auipc	a0,0x5
     dfa:	d2250513          	addi	a0,a0,-734 # 5b18 <malloc+0x734>
     dfe:	52e040ef          	jal	532c <printf>
    exit(1);
     e02:	4505                	li	a0,1
     e04:	108040ef          	jal	4f0c <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e08:	85ca                	mv	a1,s2
     e0a:	00005517          	auipc	a0,0x5
     e0e:	d2650513          	addi	a0,a0,-730 # 5b30 <malloc+0x74c>
     e12:	51a040ef          	jal	532c <printf>
    exit(1);
     e16:	4505                	li	a0,1
     e18:	0f4040ef          	jal	4f0c <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     e1c:	85ca                	mv	a1,s2
     e1e:	00005517          	auipc	a0,0x5
     e22:	d3250513          	addi	a0,a0,-718 # 5b50 <malloc+0x76c>
     e26:	506040ef          	jal	532c <printf>
    exit(1);
     e2a:	4505                	li	a0,1
     e2c:	0e0040ef          	jal	4f0c <exit>
    printf("%s: open lf2 failed\n", s);
     e30:	85ca                	mv	a1,s2
     e32:	00005517          	auipc	a0,0x5
     e36:	d4e50513          	addi	a0,a0,-690 # 5b80 <malloc+0x79c>
     e3a:	4f2040ef          	jal	532c <printf>
    exit(1);
     e3e:	4505                	li	a0,1
     e40:	0cc040ef          	jal	4f0c <exit>
    printf("%s: read lf2 failed\n", s);
     e44:	85ca                	mv	a1,s2
     e46:	00005517          	auipc	a0,0x5
     e4a:	d5250513          	addi	a0,a0,-686 # 5b98 <malloc+0x7b4>
     e4e:	4de040ef          	jal	532c <printf>
    exit(1);
     e52:	4505                	li	a0,1
     e54:	0b8040ef          	jal	4f0c <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     e58:	85ca                	mv	a1,s2
     e5a:	00005517          	auipc	a0,0x5
     e5e:	d5650513          	addi	a0,a0,-682 # 5bb0 <malloc+0x7cc>
     e62:	4ca040ef          	jal	532c <printf>
    exit(1);
     e66:	4505                	li	a0,1
     e68:	0a4040ef          	jal	4f0c <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     e6c:	85ca                	mv	a1,s2
     e6e:	00005517          	auipc	a0,0x5
     e72:	d6a50513          	addi	a0,a0,-662 # 5bd8 <malloc+0x7f4>
     e76:	4b6040ef          	jal	532c <printf>
    exit(1);
     e7a:	4505                	li	a0,1
     e7c:	090040ef          	jal	4f0c <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     e80:	85ca                	mv	a1,s2
     e82:	00005517          	auipc	a0,0x5
     e86:	d8650513          	addi	a0,a0,-634 # 5c08 <malloc+0x824>
     e8a:	4a2040ef          	jal	532c <printf>
    exit(1);
     e8e:	4505                	li	a0,1
     e90:	07c040ef          	jal	4f0c <exit>

0000000000000e94 <validatetest>:
{
     e94:	7139                	addi	sp,sp,-64
     e96:	fc06                	sd	ra,56(sp)
     e98:	f822                	sd	s0,48(sp)
     e9a:	f426                	sd	s1,40(sp)
     e9c:	f04a                	sd	s2,32(sp)
     e9e:	ec4e                	sd	s3,24(sp)
     ea0:	e852                	sd	s4,16(sp)
     ea2:	e456                	sd	s5,8(sp)
     ea4:	e05a                	sd	s6,0(sp)
     ea6:	0080                	addi	s0,sp,64
     ea8:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     eaa:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
     eac:	00005997          	auipc	s3,0x5
     eb0:	d7c98993          	addi	s3,s3,-644 # 5c28 <malloc+0x844>
     eb4:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     eb6:	6a85                	lui	s5,0x1
     eb8:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
     ebc:	85a6                	mv	a1,s1
     ebe:	854e                	mv	a0,s3
     ec0:	0ac040ef          	jal	4f6c <link>
     ec4:	01251f63          	bne	a0,s2,ee2 <validatetest+0x4e>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
     ec8:	94d6                	add	s1,s1,s5
     eca:	ff4499e3          	bne	s1,s4,ebc <validatetest+0x28>
}
     ece:	70e2                	ld	ra,56(sp)
     ed0:	7442                	ld	s0,48(sp)
     ed2:	74a2                	ld	s1,40(sp)
     ed4:	7902                	ld	s2,32(sp)
     ed6:	69e2                	ld	s3,24(sp)
     ed8:	6a42                	ld	s4,16(sp)
     eda:	6aa2                	ld	s5,8(sp)
     edc:	6b02                	ld	s6,0(sp)
     ede:	6121                	addi	sp,sp,64
     ee0:	8082                	ret
      printf("%s: link should not succeed\n", s);
     ee2:	85da                	mv	a1,s6
     ee4:	00005517          	auipc	a0,0x5
     ee8:	d5450513          	addi	a0,a0,-684 # 5c38 <malloc+0x854>
     eec:	440040ef          	jal	532c <printf>
      exit(1);
     ef0:	4505                	li	a0,1
     ef2:	01a040ef          	jal	4f0c <exit>

0000000000000ef6 <bigdir>:
{
     ef6:	711d                	addi	sp,sp,-96
     ef8:	ec86                	sd	ra,88(sp)
     efa:	e8a2                	sd	s0,80(sp)
     efc:	e4a6                	sd	s1,72(sp)
     efe:	e0ca                	sd	s2,64(sp)
     f00:	fc4e                	sd	s3,56(sp)
     f02:	f852                	sd	s4,48(sp)
     f04:	f456                	sd	s5,40(sp)
     f06:	f05a                	sd	s6,32(sp)
     f08:	ec5e                	sd	s7,24(sp)
     f0a:	1080                	addi	s0,sp,96
     f0c:	89aa                	mv	s3,a0
  unlink("bd");
     f0e:	00005517          	auipc	a0,0x5
     f12:	d4a50513          	addi	a0,a0,-694 # 5c58 <malloc+0x874>
     f16:	046040ef          	jal	4f5c <unlink>
  fd = open("bd", O_CREATE);
     f1a:	20000593          	li	a1,512
     f1e:	00005517          	auipc	a0,0x5
     f22:	d3a50513          	addi	a0,a0,-710 # 5c58 <malloc+0x874>
     f26:	026040ef          	jal	4f4c <open>
  if(fd < 0){
     f2a:	0c054463          	bltz	a0,ff2 <bigdir+0xfc>
  close(fd);
     f2e:	006040ef          	jal	4f34 <close>
  for(i = 0; i < N; i++){
     f32:	4901                	li	s2,0
    name[0] = 'x';
     f34:	07800b13          	li	s6,120
    if(link("bd", name) != 0){
     f38:	fa040a93          	addi	s5,s0,-96
     f3c:	00005a17          	auipc	s4,0x5
     f40:	d1ca0a13          	addi	s4,s4,-740 # 5c58 <malloc+0x874>
  for(i = 0; i < N; i++){
     f44:	1f400b93          	li	s7,500
    name[0] = 'x';
     f48:	fb640023          	sb	s6,-96(s0)
    name[1] = '0' + (i / 64);
     f4c:	41f9571b          	sraiw	a4,s2,0x1f
     f50:	01a7571b          	srliw	a4,a4,0x1a
     f54:	012707bb          	addw	a5,a4,s2
     f58:	4067d69b          	sraiw	a3,a5,0x6
     f5c:	0306869b          	addiw	a3,a3,48
     f60:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     f64:	03f7f793          	andi	a5,a5,63
     f68:	9f99                	subw	a5,a5,a4
     f6a:	0307879b          	addiw	a5,a5,48
     f6e:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     f72:	fa0401a3          	sb	zero,-93(s0)
    if(link("bd", name) != 0){
     f76:	85d6                	mv	a1,s5
     f78:	8552                	mv	a0,s4
     f7a:	7f3030ef          	jal	4f6c <link>
     f7e:	84aa                	mv	s1,a0
     f80:	e159                	bnez	a0,1006 <bigdir+0x110>
  for(i = 0; i < N; i++){
     f82:	2905                	addiw	s2,s2,1
     f84:	fd7912e3          	bne	s2,s7,f48 <bigdir+0x52>
  unlink("bd");
     f88:	00005517          	auipc	a0,0x5
     f8c:	cd050513          	addi	a0,a0,-816 # 5c58 <malloc+0x874>
     f90:	7cd030ef          	jal	4f5c <unlink>
    name[0] = 'x';
     f94:	07800a13          	li	s4,120
    if(unlink(name) != 0){
     f98:	fa040913          	addi	s2,s0,-96
  for(i = 0; i < N; i++){
     f9c:	1f400a93          	li	s5,500
    name[0] = 'x';
     fa0:	fb440023          	sb	s4,-96(s0)
    name[1] = '0' + (i / 64);
     fa4:	41f4d71b          	sraiw	a4,s1,0x1f
     fa8:	01a7571b          	srliw	a4,a4,0x1a
     fac:	009707bb          	addw	a5,a4,s1
     fb0:	4067d69b          	sraiw	a3,a5,0x6
     fb4:	0306869b          	addiw	a3,a3,48
     fb8:	fad400a3          	sb	a3,-95(s0)
    name[2] = '0' + (i % 64);
     fbc:	03f7f793          	andi	a5,a5,63
     fc0:	9f99                	subw	a5,a5,a4
     fc2:	0307879b          	addiw	a5,a5,48
     fc6:	faf40123          	sb	a5,-94(s0)
    name[3] = '\0';
     fca:	fa0401a3          	sb	zero,-93(s0)
    if(unlink(name) != 0){
     fce:	854a                	mv	a0,s2
     fd0:	78d030ef          	jal	4f5c <unlink>
     fd4:	e531                	bnez	a0,1020 <bigdir+0x12a>
  for(i = 0; i < N; i++){
     fd6:	2485                	addiw	s1,s1,1
     fd8:	fd5494e3          	bne	s1,s5,fa0 <bigdir+0xaa>
}
     fdc:	60e6                	ld	ra,88(sp)
     fde:	6446                	ld	s0,80(sp)
     fe0:	64a6                	ld	s1,72(sp)
     fe2:	6906                	ld	s2,64(sp)
     fe4:	79e2                	ld	s3,56(sp)
     fe6:	7a42                	ld	s4,48(sp)
     fe8:	7aa2                	ld	s5,40(sp)
     fea:	7b02                	ld	s6,32(sp)
     fec:	6be2                	ld	s7,24(sp)
     fee:	6125                	addi	sp,sp,96
     ff0:	8082                	ret
    printf("%s: bigdir create failed\n", s);
     ff2:	85ce                	mv	a1,s3
     ff4:	00005517          	auipc	a0,0x5
     ff8:	c6c50513          	addi	a0,a0,-916 # 5c60 <malloc+0x87c>
     ffc:	330040ef          	jal	532c <printf>
    exit(1);
    1000:	4505                	li	a0,1
    1002:	70b030ef          	jal	4f0c <exit>
      printf("%s: bigdir i=%d link(bd, %s) failed\n", s, i, name);
    1006:	fa040693          	addi	a3,s0,-96
    100a:	864a                	mv	a2,s2
    100c:	85ce                	mv	a1,s3
    100e:	00005517          	auipc	a0,0x5
    1012:	c7250513          	addi	a0,a0,-910 # 5c80 <malloc+0x89c>
    1016:	316040ef          	jal	532c <printf>
      exit(1);
    101a:	4505                	li	a0,1
    101c:	6f1030ef          	jal	4f0c <exit>
      printf("%s: bigdir unlink failed", s);
    1020:	85ce                	mv	a1,s3
    1022:	00005517          	auipc	a0,0x5
    1026:	c8650513          	addi	a0,a0,-890 # 5ca8 <malloc+0x8c4>
    102a:	302040ef          	jal	532c <printf>
      exit(1);
    102e:	4505                	li	a0,1
    1030:	6dd030ef          	jal	4f0c <exit>

0000000000001034 <pgbug>:
{
    1034:	7179                	addi	sp,sp,-48
    1036:	f406                	sd	ra,40(sp)
    1038:	f022                	sd	s0,32(sp)
    103a:	ec26                	sd	s1,24(sp)
    103c:	1800                	addi	s0,sp,48
  argv[0] = 0;
    103e:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1042:	00009497          	auipc	s1,0x9
    1046:	fbe48493          	addi	s1,s1,-66 # a000 <big>
    104a:	fd840593          	addi	a1,s0,-40
    104e:	6088                	ld	a0,0(s1)
    1050:	6f5030ef          	jal	4f44 <exec>
  pipe(big);
    1054:	6088                	ld	a0,0(s1)
    1056:	6c7030ef          	jal	4f1c <pipe>
  exit(0);
    105a:	4501                	li	a0,0
    105c:	6b1030ef          	jal	4f0c <exit>

0000000000001060 <badarg>:
{
    1060:	7139                	addi	sp,sp,-64
    1062:	fc06                	sd	ra,56(sp)
    1064:	f822                	sd	s0,48(sp)
    1066:	f426                	sd	s1,40(sp)
    1068:	f04a                	sd	s2,32(sp)
    106a:	ec4e                	sd	s3,24(sp)
    106c:	e852                	sd	s4,16(sp)
    106e:	0080                	addi	s0,sp,64
    1070:	64b1                	lui	s1,0xc
    1072:	35048493          	addi	s1,s1,848 # c350 <uninit+0xdb8>
    argv[0] = (char*)0xffffffff;
    1076:	597d                	li	s2,-1
    1078:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    107c:	fc040a13          	addi	s4,s0,-64
    1080:	00004997          	auipc	s3,0x4
    1084:	49898993          	addi	s3,s3,1176 # 5518 <malloc+0x134>
    argv[0] = (char*)0xffffffff;
    1088:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    108c:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1090:	85d2                	mv	a1,s4
    1092:	854e                	mv	a0,s3
    1094:	6b1030ef          	jal	4f44 <exec>
  for(int i = 0; i < 50000; i++){
    1098:	34fd                	addiw	s1,s1,-1
    109a:	f4fd                	bnez	s1,1088 <badarg+0x28>
  exit(0);
    109c:	4501                	li	a0,0
    109e:	66f030ef          	jal	4f0c <exit>

00000000000010a2 <copyinstr2>:
{
    10a2:	7155                	addi	sp,sp,-208
    10a4:	e586                	sd	ra,200(sp)
    10a6:	e1a2                	sd	s0,192(sp)
    10a8:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    10aa:	f6840793          	addi	a5,s0,-152
    10ae:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    10b2:	07800713          	li	a4,120
    10b6:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    10ba:	0785                	addi	a5,a5,1
    10bc:	fed79de3          	bne	a5,a3,10b6 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    10c0:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    10c4:	f6840513          	addi	a0,s0,-152
    10c8:	695030ef          	jal	4f5c <unlink>
  if(ret != -1){
    10cc:	57fd                	li	a5,-1
    10ce:	0cf51263          	bne	a0,a5,1192 <copyinstr2+0xf0>
  int fd = open(b, O_CREATE | O_WRONLY);
    10d2:	20100593          	li	a1,513
    10d6:	f6840513          	addi	a0,s0,-152
    10da:	673030ef          	jal	4f4c <open>
  if(fd != -1){
    10de:	57fd                	li	a5,-1
    10e0:	0cf51563          	bne	a0,a5,11aa <copyinstr2+0x108>
  ret = link(b, b);
    10e4:	f6840513          	addi	a0,s0,-152
    10e8:	85aa                	mv	a1,a0
    10ea:	683030ef          	jal	4f6c <link>
  if(ret != -1){
    10ee:	57fd                	li	a5,-1
    10f0:	0cf51963          	bne	a0,a5,11c2 <copyinstr2+0x120>
  char *args[] = { "xx", 0 };
    10f4:	00006797          	auipc	a5,0x6
    10f8:	d0478793          	addi	a5,a5,-764 # 6df8 <malloc+0x1a14>
    10fc:	f4f43c23          	sd	a5,-168(s0)
    1100:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1104:	f5840593          	addi	a1,s0,-168
    1108:	f6840513          	addi	a0,s0,-152
    110c:	639030ef          	jal	4f44 <exec>
  if(ret != -1){
    1110:	57fd                	li	a5,-1
    1112:	0cf51563          	bne	a0,a5,11dc <copyinstr2+0x13a>
  int pid = fork();
    1116:	5ef030ef          	jal	4f04 <fork>
  if(pid < 0){
    111a:	0c054d63          	bltz	a0,11f4 <copyinstr2+0x152>
  if(pid == 0){
    111e:	0e051863          	bnez	a0,120e <copyinstr2+0x16c>
    1122:	00009797          	auipc	a5,0x9
    1126:	46e78793          	addi	a5,a5,1134 # a590 <big.0>
    112a:	0000a697          	auipc	a3,0xa
    112e:	46668693          	addi	a3,a3,1126 # b590 <big.0+0x1000>
      big[i] = 'x';
    1132:	07800713          	li	a4,120
    1136:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    113a:	0785                	addi	a5,a5,1
    113c:	fed79de3          	bne	a5,a3,1136 <copyinstr2+0x94>
    big[PGSIZE] = '\0';
    1140:	0000a797          	auipc	a5,0xa
    1144:	44078823          	sb	zero,1104(a5) # b590 <big.0+0x1000>
    char *args2[] = { big, big, big, 0 };
    1148:	00007797          	auipc	a5,0x7
    114c:	82078793          	addi	a5,a5,-2016 # 7968 <malloc+0x2584>
    1150:	6fb0                	ld	a2,88(a5)
    1152:	73b4                	ld	a3,96(a5)
    1154:	77b8                	ld	a4,104(a5)
    1156:	7bbc                	ld	a5,112(a5)
    1158:	f2c43823          	sd	a2,-208(s0)
    115c:	f2d43c23          	sd	a3,-200(s0)
    1160:	f4e43023          	sd	a4,-192(s0)
    1164:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    1168:	f3040593          	addi	a1,s0,-208
    116c:	00004517          	auipc	a0,0x4
    1170:	3ac50513          	addi	a0,a0,940 # 5518 <malloc+0x134>
    1174:	5d1030ef          	jal	4f44 <exec>
    if(ret != -1){
    1178:	57fd                	li	a5,-1
    117a:	08f50663          	beq	a0,a5,1206 <copyinstr2+0x164>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    117e:	85be                	mv	a1,a5
    1180:	00005517          	auipc	a0,0x5
    1184:	bd050513          	addi	a0,a0,-1072 # 5d50 <malloc+0x96c>
    1188:	1a4040ef          	jal	532c <printf>
      exit(1);
    118c:	4505                	li	a0,1
    118e:	57f030ef          	jal	4f0c <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    1192:	862a                	mv	a2,a0
    1194:	f6840593          	addi	a1,s0,-152
    1198:	00005517          	auipc	a0,0x5
    119c:	b3050513          	addi	a0,a0,-1232 # 5cc8 <malloc+0x8e4>
    11a0:	18c040ef          	jal	532c <printf>
    exit(1);
    11a4:	4505                	li	a0,1
    11a6:	567030ef          	jal	4f0c <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    11aa:	862a                	mv	a2,a0
    11ac:	f6840593          	addi	a1,s0,-152
    11b0:	00005517          	auipc	a0,0x5
    11b4:	b3850513          	addi	a0,a0,-1224 # 5ce8 <malloc+0x904>
    11b8:	174040ef          	jal	532c <printf>
    exit(1);
    11bc:	4505                	li	a0,1
    11be:	54f030ef          	jal	4f0c <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    11c2:	f6840593          	addi	a1,s0,-152
    11c6:	86aa                	mv	a3,a0
    11c8:	862e                	mv	a2,a1
    11ca:	00005517          	auipc	a0,0x5
    11ce:	b3e50513          	addi	a0,a0,-1218 # 5d08 <malloc+0x924>
    11d2:	15a040ef          	jal	532c <printf>
    exit(1);
    11d6:	4505                	li	a0,1
    11d8:	535030ef          	jal	4f0c <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    11dc:	863e                	mv	a2,a5
    11de:	f6840593          	addi	a1,s0,-152
    11e2:	00005517          	auipc	a0,0x5
    11e6:	b4e50513          	addi	a0,a0,-1202 # 5d30 <malloc+0x94c>
    11ea:	142040ef          	jal	532c <printf>
    exit(1);
    11ee:	4505                	li	a0,1
    11f0:	51d030ef          	jal	4f0c <exit>
    printf("fork failed\n");
    11f4:	00006517          	auipc	a0,0x6
    11f8:	15c50513          	addi	a0,a0,348 # 7350 <malloc+0x1f6c>
    11fc:	130040ef          	jal	532c <printf>
    exit(1);
    1200:	4505                	li	a0,1
    1202:	50b030ef          	jal	4f0c <exit>
    exit(747); // OK
    1206:	2eb00513          	li	a0,747
    120a:	503030ef          	jal	4f0c <exit>
  int st = 0;
    120e:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    1212:	f5440513          	addi	a0,s0,-172
    1216:	4ff030ef          	jal	4f14 <wait>
  if(st != 747){
    121a:	f5442703          	lw	a4,-172(s0)
    121e:	2eb00793          	li	a5,747
    1222:	00f71663          	bne	a4,a5,122e <copyinstr2+0x18c>
}
    1226:	60ae                	ld	ra,200(sp)
    1228:	640e                	ld	s0,192(sp)
    122a:	6169                	addi	sp,sp,208
    122c:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    122e:	00005517          	auipc	a0,0x5
    1232:	b4a50513          	addi	a0,a0,-1206 # 5d78 <malloc+0x994>
    1236:	0f6040ef          	jal	532c <printf>
    exit(1);
    123a:	4505                	li	a0,1
    123c:	4d1030ef          	jal	4f0c <exit>

0000000000001240 <truncate3>:
{
    1240:	7175                	addi	sp,sp,-144
    1242:	e506                	sd	ra,136(sp)
    1244:	e122                	sd	s0,128(sp)
    1246:	ecd6                	sd	s5,88(sp)
    1248:	0900                	addi	s0,sp,144
    124a:	8aaa                	mv	s5,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    124c:	60100593          	li	a1,1537
    1250:	00004517          	auipc	a0,0x4
    1254:	32050513          	addi	a0,a0,800 # 5570 <malloc+0x18c>
    1258:	4f5030ef          	jal	4f4c <open>
    125c:	4d9030ef          	jal	4f34 <close>
  pid = fork();
    1260:	4a5030ef          	jal	4f04 <fork>
  if(pid < 0){
    1264:	06054d63          	bltz	a0,12de <truncate3+0x9e>
  if(pid == 0){
    1268:	e171                	bnez	a0,132c <truncate3+0xec>
    126a:	fca6                	sd	s1,120(sp)
    126c:	f8ca                	sd	s2,112(sp)
    126e:	f4ce                	sd	s3,104(sp)
    1270:	f0d2                	sd	s4,96(sp)
    1272:	e8da                	sd	s6,80(sp)
    1274:	e4de                	sd	s7,72(sp)
    1276:	e0e2                	sd	s8,64(sp)
    1278:	fc66                	sd	s9,56(sp)
    127a:	06400913          	li	s2,100
      int fd = open("truncfile", O_WRONLY);
    127e:	4b05                	li	s6,1
    1280:	00004997          	auipc	s3,0x4
    1284:	2f098993          	addi	s3,s3,752 # 5570 <malloc+0x18c>
      int n = write(fd, "1234567890", 10);
    1288:	4a29                	li	s4,10
    128a:	00005b97          	auipc	s7,0x5
    128e:	b4eb8b93          	addi	s7,s7,-1202 # 5dd8 <malloc+0x9f4>
      read(fd, buf, sizeof(buf));
    1292:	f7840c93          	addi	s9,s0,-136
    1296:	02000c13          	li	s8,32
      int fd = open("truncfile", O_WRONLY);
    129a:	85da                	mv	a1,s6
    129c:	854e                	mv	a0,s3
    129e:	4af030ef          	jal	4f4c <open>
    12a2:	84aa                	mv	s1,a0
      if(fd < 0){
    12a4:	04054f63          	bltz	a0,1302 <truncate3+0xc2>
      int n = write(fd, "1234567890", 10);
    12a8:	8652                	mv	a2,s4
    12aa:	85de                	mv	a1,s7
    12ac:	481030ef          	jal	4f2c <write>
      if(n != 10){
    12b0:	07451363          	bne	a0,s4,1316 <truncate3+0xd6>
      close(fd);
    12b4:	8526                	mv	a0,s1
    12b6:	47f030ef          	jal	4f34 <close>
      fd = open("truncfile", O_RDONLY);
    12ba:	4581                	li	a1,0
    12bc:	854e                	mv	a0,s3
    12be:	48f030ef          	jal	4f4c <open>
    12c2:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    12c4:	8662                	mv	a2,s8
    12c6:	85e6                	mv	a1,s9
    12c8:	45d030ef          	jal	4f24 <read>
      close(fd);
    12cc:	8526                	mv	a0,s1
    12ce:	467030ef          	jal	4f34 <close>
    for(int i = 0; i < 100; i++){
    12d2:	397d                	addiw	s2,s2,-1
    12d4:	fc0913e3          	bnez	s2,129a <truncate3+0x5a>
    exit(0);
    12d8:	4501                	li	a0,0
    12da:	433030ef          	jal	4f0c <exit>
    12de:	fca6                	sd	s1,120(sp)
    12e0:	f8ca                	sd	s2,112(sp)
    12e2:	f4ce                	sd	s3,104(sp)
    12e4:	f0d2                	sd	s4,96(sp)
    12e6:	e8da                	sd	s6,80(sp)
    12e8:	e4de                	sd	s7,72(sp)
    12ea:	e0e2                	sd	s8,64(sp)
    12ec:	fc66                	sd	s9,56(sp)
    printf("%s: fork failed\n", s);
    12ee:	85d6                	mv	a1,s5
    12f0:	00005517          	auipc	a0,0x5
    12f4:	ab850513          	addi	a0,a0,-1352 # 5da8 <malloc+0x9c4>
    12f8:	034040ef          	jal	532c <printf>
    exit(1);
    12fc:	4505                	li	a0,1
    12fe:	40f030ef          	jal	4f0c <exit>
        printf("%s: open failed\n", s);
    1302:	85d6                	mv	a1,s5
    1304:	00005517          	auipc	a0,0x5
    1308:	abc50513          	addi	a0,a0,-1348 # 5dc0 <malloc+0x9dc>
    130c:	020040ef          	jal	532c <printf>
        exit(1);
    1310:	4505                	li	a0,1
    1312:	3fb030ef          	jal	4f0c <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1316:	862a                	mv	a2,a0
    1318:	85d6                	mv	a1,s5
    131a:	00005517          	auipc	a0,0x5
    131e:	ace50513          	addi	a0,a0,-1330 # 5de8 <malloc+0xa04>
    1322:	00a040ef          	jal	532c <printf>
        exit(1);
    1326:	4505                	li	a0,1
    1328:	3e5030ef          	jal	4f0c <exit>
    132c:	fca6                	sd	s1,120(sp)
    132e:	f8ca                	sd	s2,112(sp)
    1330:	f4ce                	sd	s3,104(sp)
    1332:	f0d2                	sd	s4,96(sp)
    1334:	e8da                	sd	s6,80(sp)
    1336:	e4de                	sd	s7,72(sp)
    1338:	09600913          	li	s2,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    133c:	60100b13          	li	s6,1537
    1340:	00004a17          	auipc	s4,0x4
    1344:	230a0a13          	addi	s4,s4,560 # 5570 <malloc+0x18c>
    int n = write(fd, "xxx", 3);
    1348:	498d                	li	s3,3
    134a:	00005b97          	auipc	s7,0x5
    134e:	abeb8b93          	addi	s7,s7,-1346 # 5e08 <malloc+0xa24>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    1352:	85da                	mv	a1,s6
    1354:	8552                	mv	a0,s4
    1356:	3f7030ef          	jal	4f4c <open>
    135a:	84aa                	mv	s1,a0
    if(fd < 0){
    135c:	02054e63          	bltz	a0,1398 <truncate3+0x158>
    int n = write(fd, "xxx", 3);
    1360:	864e                	mv	a2,s3
    1362:	85de                	mv	a1,s7
    1364:	3c9030ef          	jal	4f2c <write>
    if(n != 3){
    1368:	05351463          	bne	a0,s3,13b0 <truncate3+0x170>
    close(fd);
    136c:	8526                	mv	a0,s1
    136e:	3c7030ef          	jal	4f34 <close>
  for(int i = 0; i < 150; i++){
    1372:	397d                	addiw	s2,s2,-1
    1374:	fc091fe3          	bnez	s2,1352 <truncate3+0x112>
    1378:	e0e2                	sd	s8,64(sp)
    137a:	fc66                	sd	s9,56(sp)
  wait(&xstatus);
    137c:	f9c40513          	addi	a0,s0,-100
    1380:	395030ef          	jal	4f14 <wait>
  unlink("truncfile");
    1384:	00004517          	auipc	a0,0x4
    1388:	1ec50513          	addi	a0,a0,492 # 5570 <malloc+0x18c>
    138c:	3d1030ef          	jal	4f5c <unlink>
  exit(xstatus);
    1390:	f9c42503          	lw	a0,-100(s0)
    1394:	379030ef          	jal	4f0c <exit>
    1398:	e0e2                	sd	s8,64(sp)
    139a:	fc66                	sd	s9,56(sp)
      printf("%s: open failed\n", s);
    139c:	85d6                	mv	a1,s5
    139e:	00005517          	auipc	a0,0x5
    13a2:	a2250513          	addi	a0,a0,-1502 # 5dc0 <malloc+0x9dc>
    13a6:	787030ef          	jal	532c <printf>
      exit(1);
    13aa:	4505                	li	a0,1
    13ac:	361030ef          	jal	4f0c <exit>
    13b0:	e0e2                	sd	s8,64(sp)
    13b2:	fc66                	sd	s9,56(sp)
      printf("%s: write got %d, expected 3\n", s, n);
    13b4:	862a                	mv	a2,a0
    13b6:	85d6                	mv	a1,s5
    13b8:	00005517          	auipc	a0,0x5
    13bc:	a5850513          	addi	a0,a0,-1448 # 5e10 <malloc+0xa2c>
    13c0:	76d030ef          	jal	532c <printf>
      exit(1);
    13c4:	4505                	li	a0,1
    13c6:	347030ef          	jal	4f0c <exit>

00000000000013ca <exectest>:
{
    13ca:	715d                	addi	sp,sp,-80
    13cc:	e486                	sd	ra,72(sp)
    13ce:	e0a2                	sd	s0,64(sp)
    13d0:	f84a                	sd	s2,48(sp)
    13d2:	0880                	addi	s0,sp,80
    13d4:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    13d6:	00004797          	auipc	a5,0x4
    13da:	14278793          	addi	a5,a5,322 # 5518 <malloc+0x134>
    13de:	fcf43023          	sd	a5,-64(s0)
    13e2:	00005797          	auipc	a5,0x5
    13e6:	a4e78793          	addi	a5,a5,-1458 # 5e30 <malloc+0xa4c>
    13ea:	fcf43423          	sd	a5,-56(s0)
    13ee:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    13f2:	00005517          	auipc	a0,0x5
    13f6:	a4650513          	addi	a0,a0,-1466 # 5e38 <malloc+0xa54>
    13fa:	363030ef          	jal	4f5c <unlink>
  pid = fork();
    13fe:	307030ef          	jal	4f04 <fork>
  if(pid < 0) {
    1402:	02054f63          	bltz	a0,1440 <exectest+0x76>
    1406:	fc26                	sd	s1,56(sp)
    1408:	84aa                	mv	s1,a0
  if(pid == 0) {
    140a:	e935                	bnez	a0,147e <exectest+0xb4>
    close(1);
    140c:	4505                	li	a0,1
    140e:	327030ef          	jal	4f34 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1412:	20100593          	li	a1,513
    1416:	00005517          	auipc	a0,0x5
    141a:	a2250513          	addi	a0,a0,-1502 # 5e38 <malloc+0xa54>
    141e:	32f030ef          	jal	4f4c <open>
    if(fd < 0) {
    1422:	02054a63          	bltz	a0,1456 <exectest+0x8c>
    if(fd != 1) {
    1426:	4785                	li	a5,1
    1428:	04f50163          	beq	a0,a5,146a <exectest+0xa0>
      printf("%s: wrong fd\n", s);
    142c:	85ca                	mv	a1,s2
    142e:	00005517          	auipc	a0,0x5
    1432:	a2a50513          	addi	a0,a0,-1494 # 5e58 <malloc+0xa74>
    1436:	6f7030ef          	jal	532c <printf>
      exit(1);
    143a:	4505                	li	a0,1
    143c:	2d1030ef          	jal	4f0c <exit>
    1440:	fc26                	sd	s1,56(sp)
     printf("%s: fork failed\n", s);
    1442:	85ca                	mv	a1,s2
    1444:	00005517          	auipc	a0,0x5
    1448:	96450513          	addi	a0,a0,-1692 # 5da8 <malloc+0x9c4>
    144c:	6e1030ef          	jal	532c <printf>
     exit(1);
    1450:	4505                	li	a0,1
    1452:	2bb030ef          	jal	4f0c <exit>
      printf("%s: create failed\n", s);
    1456:	85ca                	mv	a1,s2
    1458:	00005517          	auipc	a0,0x5
    145c:	9e850513          	addi	a0,a0,-1560 # 5e40 <malloc+0xa5c>
    1460:	6cd030ef          	jal	532c <printf>
      exit(1);
    1464:	4505                	li	a0,1
    1466:	2a7030ef          	jal	4f0c <exit>
    if(exec("echo", echoargv) < 0){
    146a:	fc040593          	addi	a1,s0,-64
    146e:	00004517          	auipc	a0,0x4
    1472:	0aa50513          	addi	a0,a0,170 # 5518 <malloc+0x134>
    1476:	2cf030ef          	jal	4f44 <exec>
    147a:	00054d63          	bltz	a0,1494 <exectest+0xca>
  if (wait(&xstatus) != pid) {
    147e:	fdc40513          	addi	a0,s0,-36
    1482:	293030ef          	jal	4f14 <wait>
    1486:	02951163          	bne	a0,s1,14a8 <exectest+0xde>
  if(xstatus != 0)
    148a:	fdc42503          	lw	a0,-36(s0)
    148e:	c50d                	beqz	a0,14b8 <exectest+0xee>
    exit(xstatus);
    1490:	27d030ef          	jal	4f0c <exit>
      printf("%s: exec echo failed\n", s);
    1494:	85ca                	mv	a1,s2
    1496:	00005517          	auipc	a0,0x5
    149a:	9d250513          	addi	a0,a0,-1582 # 5e68 <malloc+0xa84>
    149e:	68f030ef          	jal	532c <printf>
      exit(1);
    14a2:	4505                	li	a0,1
    14a4:	269030ef          	jal	4f0c <exit>
    printf("%s: wait failed!\n", s);
    14a8:	85ca                	mv	a1,s2
    14aa:	00005517          	auipc	a0,0x5
    14ae:	9d650513          	addi	a0,a0,-1578 # 5e80 <malloc+0xa9c>
    14b2:	67b030ef          	jal	532c <printf>
    14b6:	bfd1                	j	148a <exectest+0xc0>
  fd = open("echo-ok", O_RDONLY);
    14b8:	4581                	li	a1,0
    14ba:	00005517          	auipc	a0,0x5
    14be:	97e50513          	addi	a0,a0,-1666 # 5e38 <malloc+0xa54>
    14c2:	28b030ef          	jal	4f4c <open>
  if(fd < 0) {
    14c6:	02054463          	bltz	a0,14ee <exectest+0x124>
  if (read(fd, buf, 2) != 2) {
    14ca:	4609                	li	a2,2
    14cc:	fb840593          	addi	a1,s0,-72
    14d0:	255030ef          	jal	4f24 <read>
    14d4:	4789                	li	a5,2
    14d6:	02f50663          	beq	a0,a5,1502 <exectest+0x138>
    printf("%s: read failed\n", s);
    14da:	85ca                	mv	a1,s2
    14dc:	00004517          	auipc	a0,0x4
    14e0:	40c50513          	addi	a0,a0,1036 # 58e8 <malloc+0x504>
    14e4:	649030ef          	jal	532c <printf>
    exit(1);
    14e8:	4505                	li	a0,1
    14ea:	223030ef          	jal	4f0c <exit>
    printf("%s: open failed\n", s);
    14ee:	85ca                	mv	a1,s2
    14f0:	00005517          	auipc	a0,0x5
    14f4:	8d050513          	addi	a0,a0,-1840 # 5dc0 <malloc+0x9dc>
    14f8:	635030ef          	jal	532c <printf>
    exit(1);
    14fc:	4505                	li	a0,1
    14fe:	20f030ef          	jal	4f0c <exit>
  unlink("echo-ok");
    1502:	00005517          	auipc	a0,0x5
    1506:	93650513          	addi	a0,a0,-1738 # 5e38 <malloc+0xa54>
    150a:	253030ef          	jal	4f5c <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    150e:	fb844703          	lbu	a4,-72(s0)
    1512:	04f00793          	li	a5,79
    1516:	00f71863          	bne	a4,a5,1526 <exectest+0x15c>
    151a:	fb944703          	lbu	a4,-71(s0)
    151e:	04b00793          	li	a5,75
    1522:	00f70c63          	beq	a4,a5,153a <exectest+0x170>
    printf("%s: wrong output\n", s);
    1526:	85ca                	mv	a1,s2
    1528:	00005517          	auipc	a0,0x5
    152c:	97050513          	addi	a0,a0,-1680 # 5e98 <malloc+0xab4>
    1530:	5fd030ef          	jal	532c <printf>
    exit(1);
    1534:	4505                	li	a0,1
    1536:	1d7030ef          	jal	4f0c <exit>
    exit(0);
    153a:	4501                	li	a0,0
    153c:	1d1030ef          	jal	4f0c <exit>

0000000000001540 <pipe1>:
{
    1540:	711d                	addi	sp,sp,-96
    1542:	ec86                	sd	ra,88(sp)
    1544:	e8a2                	sd	s0,80(sp)
    1546:	e0ca                	sd	s2,64(sp)
    1548:	1080                	addi	s0,sp,96
    154a:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    154c:	fa840513          	addi	a0,s0,-88
    1550:	1cd030ef          	jal	4f1c <pipe>
    1554:	e53d                	bnez	a0,15c2 <pipe1+0x82>
    1556:	e4a6                	sd	s1,72(sp)
    1558:	f852                	sd	s4,48(sp)
    155a:	84aa                	mv	s1,a0
  pid = fork();
    155c:	1a9030ef          	jal	4f04 <fork>
    1560:	8a2a                	mv	s4,a0
  if(pid == 0){
    1562:	c149                	beqz	a0,15e4 <pipe1+0xa4>
  } else if(pid > 0){
    1564:	14a05f63          	blez	a0,16c2 <pipe1+0x182>
    1568:	fc4e                	sd	s3,56(sp)
    156a:	f456                	sd	s5,40(sp)
    close(fds[1]);
    156c:	fac42503          	lw	a0,-84(s0)
    1570:	1c5030ef          	jal	4f34 <close>
    total = 0;
    1574:	8a26                	mv	s4,s1
    cc = 1;
    1576:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1578:	0000ca97          	auipc	s5,0xc
    157c:	730a8a93          	addi	s5,s5,1840 # dca8 <buf>
    1580:	864e                	mv	a2,s3
    1582:	85d6                	mv	a1,s5
    1584:	fa842503          	lw	a0,-88(s0)
    1588:	19d030ef          	jal	4f24 <read>
    158c:	0ea05963          	blez	a0,167e <pipe1+0x13e>
    1590:	0000c717          	auipc	a4,0xc
    1594:	71870713          	addi	a4,a4,1816 # dca8 <buf>
    1598:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    159c:	00074683          	lbu	a3,0(a4)
    15a0:	0ff4f793          	zext.b	a5,s1
    15a4:	2485                	addiw	s1,s1,1
    15a6:	0af69c63          	bne	a3,a5,165e <pipe1+0x11e>
      for(i = 0; i < n; i++){
    15aa:	0705                	addi	a4,a4,1
    15ac:	fec498e3          	bne	s1,a2,159c <pipe1+0x5c>
      total += n;
    15b0:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    15b4:	0019999b          	slliw	s3,s3,0x1
      if(cc > sizeof(buf))
    15b8:	678d                	lui	a5,0x3
    15ba:	fd37f3e3          	bgeu	a5,s3,1580 <pipe1+0x40>
        cc = sizeof(buf);
    15be:	89be                	mv	s3,a5
    15c0:	b7c1                	j	1580 <pipe1+0x40>
    15c2:	e4a6                	sd	s1,72(sp)
    15c4:	fc4e                	sd	s3,56(sp)
    15c6:	f852                	sd	s4,48(sp)
    15c8:	f456                	sd	s5,40(sp)
    15ca:	f05a                	sd	s6,32(sp)
    15cc:	ec5e                	sd	s7,24(sp)
    15ce:	e862                	sd	s8,16(sp)
    printf("%s: pipe() failed\n", s);
    15d0:	85ca                	mv	a1,s2
    15d2:	00005517          	auipc	a0,0x5
    15d6:	8de50513          	addi	a0,a0,-1826 # 5eb0 <malloc+0xacc>
    15da:	553030ef          	jal	532c <printf>
    exit(1);
    15de:	4505                	li	a0,1
    15e0:	12d030ef          	jal	4f0c <exit>
    15e4:	fc4e                	sd	s3,56(sp)
    15e6:	f456                	sd	s5,40(sp)
    15e8:	f05a                	sd	s6,32(sp)
    15ea:	ec5e                	sd	s7,24(sp)
    15ec:	e862                	sd	s8,16(sp)
    close(fds[0]);
    15ee:	fa842503          	lw	a0,-88(s0)
    15f2:	143030ef          	jal	4f34 <close>
    for(n = 0; n < N; n++){
    15f6:	0000cb97          	auipc	s7,0xc
    15fa:	6b2b8b93          	addi	s7,s7,1714 # dca8 <buf>
    15fe:	417004bb          	negw	s1,s7
    1602:	0ff4f493          	zext.b	s1,s1
    1606:	409b8993          	addi	s3,s7,1033
      if(write(fds[1], buf, SZ) != SZ){
    160a:	40900a93          	li	s5,1033
    160e:	8c5e                	mv	s8,s7
    for(n = 0; n < N; n++){
    1610:	6b05                	lui	s6,0x1
    1612:	42db0b13          	addi	s6,s6,1069 # 142d <exectest+0x63>
{
    1616:	87de                	mv	a5,s7
        buf[i] = seq++;
    1618:	0097873b          	addw	a4,a5,s1
    161c:	00e78023          	sb	a4,0(a5) # 3000 <subdir+0x31e>
      for(i = 0; i < SZ; i++)
    1620:	0785                	addi	a5,a5,1
    1622:	ff379be3          	bne	a5,s3,1618 <pipe1+0xd8>
    1626:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    162a:	8656                	mv	a2,s5
    162c:	85e2                	mv	a1,s8
    162e:	fac42503          	lw	a0,-84(s0)
    1632:	0fb030ef          	jal	4f2c <write>
    1636:	01551a63          	bne	a0,s5,164a <pipe1+0x10a>
    for(n = 0; n < N; n++){
    163a:	24a5                	addiw	s1,s1,9
    163c:	0ff4f493          	zext.b	s1,s1
    1640:	fd6a1be3          	bne	s4,s6,1616 <pipe1+0xd6>
    exit(0);
    1644:	4501                	li	a0,0
    1646:	0c7030ef          	jal	4f0c <exit>
        printf("%s: pipe1 oops 1\n", s);
    164a:	85ca                	mv	a1,s2
    164c:	00005517          	auipc	a0,0x5
    1650:	87c50513          	addi	a0,a0,-1924 # 5ec8 <malloc+0xae4>
    1654:	4d9030ef          	jal	532c <printf>
        exit(1);
    1658:	4505                	li	a0,1
    165a:	0b3030ef          	jal	4f0c <exit>
          printf("%s: pipe1 oops 2\n", s);
    165e:	85ca                	mv	a1,s2
    1660:	00005517          	auipc	a0,0x5
    1664:	88050513          	addi	a0,a0,-1920 # 5ee0 <malloc+0xafc>
    1668:	4c5030ef          	jal	532c <printf>
          return;
    166c:	64a6                	ld	s1,72(sp)
    166e:	79e2                	ld	s3,56(sp)
    1670:	7a42                	ld	s4,48(sp)
    1672:	7aa2                	ld	s5,40(sp)
}
    1674:	60e6                	ld	ra,88(sp)
    1676:	6446                	ld	s0,80(sp)
    1678:	6906                	ld	s2,64(sp)
    167a:	6125                	addi	sp,sp,96
    167c:	8082                	ret
    if(total != N * SZ){
    167e:	6785                	lui	a5,0x1
    1680:	42d78793          	addi	a5,a5,1069 # 142d <exectest+0x63>
    1684:	02fa0063          	beq	s4,a5,16a4 <pipe1+0x164>
    1688:	f05a                	sd	s6,32(sp)
    168a:	ec5e                	sd	s7,24(sp)
    168c:	e862                	sd	s8,16(sp)
      printf("%s: pipe1 oops 3 total %d\n", s, total);
    168e:	8652                	mv	a2,s4
    1690:	85ca                	mv	a1,s2
    1692:	00005517          	auipc	a0,0x5
    1696:	86650513          	addi	a0,a0,-1946 # 5ef8 <malloc+0xb14>
    169a:	493030ef          	jal	532c <printf>
      exit(1);
    169e:	4505                	li	a0,1
    16a0:	06d030ef          	jal	4f0c <exit>
    16a4:	f05a                	sd	s6,32(sp)
    16a6:	ec5e                	sd	s7,24(sp)
    16a8:	e862                	sd	s8,16(sp)
    close(fds[0]);
    16aa:	fa842503          	lw	a0,-88(s0)
    16ae:	087030ef          	jal	4f34 <close>
    wait(&xstatus);
    16b2:	fa440513          	addi	a0,s0,-92
    16b6:	05f030ef          	jal	4f14 <wait>
    exit(xstatus);
    16ba:	fa442503          	lw	a0,-92(s0)
    16be:	04f030ef          	jal	4f0c <exit>
    16c2:	fc4e                	sd	s3,56(sp)
    16c4:	f456                	sd	s5,40(sp)
    16c6:	f05a                	sd	s6,32(sp)
    16c8:	ec5e                	sd	s7,24(sp)
    16ca:	e862                	sd	s8,16(sp)
    printf("%s: fork() failed\n", s);
    16cc:	85ca                	mv	a1,s2
    16ce:	00005517          	auipc	a0,0x5
    16d2:	84a50513          	addi	a0,a0,-1974 # 5f18 <malloc+0xb34>
    16d6:	457030ef          	jal	532c <printf>
    exit(1);
    16da:	4505                	li	a0,1
    16dc:	031030ef          	jal	4f0c <exit>

00000000000016e0 <exitwait>:
{
    16e0:	715d                	addi	sp,sp,-80
    16e2:	e486                	sd	ra,72(sp)
    16e4:	e0a2                	sd	s0,64(sp)
    16e6:	fc26                	sd	s1,56(sp)
    16e8:	f84a                	sd	s2,48(sp)
    16ea:	f44e                	sd	s3,40(sp)
    16ec:	f052                	sd	s4,32(sp)
    16ee:	ec56                	sd	s5,24(sp)
    16f0:	0880                	addi	s0,sp,80
    16f2:	8aaa                	mv	s5,a0
  for(i = 0; i < 100; i++){
    16f4:	4901                	li	s2,0
      if(wait(&xstate) != pid){
    16f6:	fbc40993          	addi	s3,s0,-68
  for(i = 0; i < 100; i++){
    16fa:	06400a13          	li	s4,100
    pid = fork();
    16fe:	007030ef          	jal	4f04 <fork>
    1702:	84aa                	mv	s1,a0
    if(pid < 0){
    1704:	02054863          	bltz	a0,1734 <exitwait+0x54>
    if(pid){
    1708:	c525                	beqz	a0,1770 <exitwait+0x90>
      if(wait(&xstate) != pid){
    170a:	854e                	mv	a0,s3
    170c:	009030ef          	jal	4f14 <wait>
    1710:	02951c63          	bne	a0,s1,1748 <exitwait+0x68>
      if(i != xstate) {
    1714:	fbc42783          	lw	a5,-68(s0)
    1718:	05279263          	bne	a5,s2,175c <exitwait+0x7c>
  for(i = 0; i < 100; i++){
    171c:	2905                	addiw	s2,s2,1
    171e:	ff4910e3          	bne	s2,s4,16fe <exitwait+0x1e>
}
    1722:	60a6                	ld	ra,72(sp)
    1724:	6406                	ld	s0,64(sp)
    1726:	74e2                	ld	s1,56(sp)
    1728:	7942                	ld	s2,48(sp)
    172a:	79a2                	ld	s3,40(sp)
    172c:	7a02                	ld	s4,32(sp)
    172e:	6ae2                	ld	s5,24(sp)
    1730:	6161                	addi	sp,sp,80
    1732:	8082                	ret
      printf("%s: fork failed\n", s);
    1734:	85d6                	mv	a1,s5
    1736:	00004517          	auipc	a0,0x4
    173a:	67250513          	addi	a0,a0,1650 # 5da8 <malloc+0x9c4>
    173e:	3ef030ef          	jal	532c <printf>
      exit(1);
    1742:	4505                	li	a0,1
    1744:	7c8030ef          	jal	4f0c <exit>
        printf("%s: wait wrong pid\n", s);
    1748:	85d6                	mv	a1,s5
    174a:	00004517          	auipc	a0,0x4
    174e:	7e650513          	addi	a0,a0,2022 # 5f30 <malloc+0xb4c>
    1752:	3db030ef          	jal	532c <printf>
        exit(1);
    1756:	4505                	li	a0,1
    1758:	7b4030ef          	jal	4f0c <exit>
        printf("%s: wait wrong exit status\n", s);
    175c:	85d6                	mv	a1,s5
    175e:	00004517          	auipc	a0,0x4
    1762:	7ea50513          	addi	a0,a0,2026 # 5f48 <malloc+0xb64>
    1766:	3c7030ef          	jal	532c <printf>
        exit(1);
    176a:	4505                	li	a0,1
    176c:	7a0030ef          	jal	4f0c <exit>
      exit(i);
    1770:	854a                	mv	a0,s2
    1772:	79a030ef          	jal	4f0c <exit>

0000000000001776 <twochildren>:
{
    1776:	1101                	addi	sp,sp,-32
    1778:	ec06                	sd	ra,24(sp)
    177a:	e822                	sd	s0,16(sp)
    177c:	e426                	sd	s1,8(sp)
    177e:	e04a                	sd	s2,0(sp)
    1780:	1000                	addi	s0,sp,32
    1782:	892a                	mv	s2,a0
    1784:	3e800493          	li	s1,1000
    int pid1 = fork();
    1788:	77c030ef          	jal	4f04 <fork>
    if(pid1 < 0){
    178c:	02054663          	bltz	a0,17b8 <twochildren+0x42>
    if(pid1 == 0){
    1790:	cd15                	beqz	a0,17cc <twochildren+0x56>
      int pid2 = fork();
    1792:	772030ef          	jal	4f04 <fork>
      if(pid2 < 0){
    1796:	02054d63          	bltz	a0,17d0 <twochildren+0x5a>
      if(pid2 == 0){
    179a:	c529                	beqz	a0,17e4 <twochildren+0x6e>
        wait(0);
    179c:	4501                	li	a0,0
    179e:	776030ef          	jal	4f14 <wait>
        wait(0);
    17a2:	4501                	li	a0,0
    17a4:	770030ef          	jal	4f14 <wait>
  for(int i = 0; i < 1000; i++){
    17a8:	34fd                	addiw	s1,s1,-1
    17aa:	fcf9                	bnez	s1,1788 <twochildren+0x12>
}
    17ac:	60e2                	ld	ra,24(sp)
    17ae:	6442                	ld	s0,16(sp)
    17b0:	64a2                	ld	s1,8(sp)
    17b2:	6902                	ld	s2,0(sp)
    17b4:	6105                	addi	sp,sp,32
    17b6:	8082                	ret
      printf("%s: fork failed\n", s);
    17b8:	85ca                	mv	a1,s2
    17ba:	00004517          	auipc	a0,0x4
    17be:	5ee50513          	addi	a0,a0,1518 # 5da8 <malloc+0x9c4>
    17c2:	36b030ef          	jal	532c <printf>
      exit(1);
    17c6:	4505                	li	a0,1
    17c8:	744030ef          	jal	4f0c <exit>
      exit(0);
    17cc:	740030ef          	jal	4f0c <exit>
        printf("%s: fork failed\n", s);
    17d0:	85ca                	mv	a1,s2
    17d2:	00004517          	auipc	a0,0x4
    17d6:	5d650513          	addi	a0,a0,1494 # 5da8 <malloc+0x9c4>
    17da:	353030ef          	jal	532c <printf>
        exit(1);
    17de:	4505                	li	a0,1
    17e0:	72c030ef          	jal	4f0c <exit>
        exit(0);
    17e4:	728030ef          	jal	4f0c <exit>

00000000000017e8 <forkfork>:
{
    17e8:	7179                	addi	sp,sp,-48
    17ea:	f406                	sd	ra,40(sp)
    17ec:	f022                	sd	s0,32(sp)
    17ee:	ec26                	sd	s1,24(sp)
    17f0:	1800                	addi	s0,sp,48
    17f2:	84aa                	mv	s1,a0
    int pid = fork();
    17f4:	710030ef          	jal	4f04 <fork>
    if(pid < 0){
    17f8:	02054b63          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    17fc:	c139                	beqz	a0,1842 <forkfork+0x5a>
    int pid = fork();
    17fe:	706030ef          	jal	4f04 <fork>
    if(pid < 0){
    1802:	02054663          	bltz	a0,182e <forkfork+0x46>
    if(pid == 0){
    1806:	cd15                	beqz	a0,1842 <forkfork+0x5a>
    wait(&xstatus);
    1808:	fdc40513          	addi	a0,s0,-36
    180c:	708030ef          	jal	4f14 <wait>
    if(xstatus != 0) {
    1810:	fdc42783          	lw	a5,-36(s0)
    1814:	ebb9                	bnez	a5,186a <forkfork+0x82>
    wait(&xstatus);
    1816:	fdc40513          	addi	a0,s0,-36
    181a:	6fa030ef          	jal	4f14 <wait>
    if(xstatus != 0) {
    181e:	fdc42783          	lw	a5,-36(s0)
    1822:	e7a1                	bnez	a5,186a <forkfork+0x82>
}
    1824:	70a2                	ld	ra,40(sp)
    1826:	7402                	ld	s0,32(sp)
    1828:	64e2                	ld	s1,24(sp)
    182a:	6145                	addi	sp,sp,48
    182c:	8082                	ret
      printf("%s: fork failed", s);
    182e:	85a6                	mv	a1,s1
    1830:	00004517          	auipc	a0,0x4
    1834:	73850513          	addi	a0,a0,1848 # 5f68 <malloc+0xb84>
    1838:	2f5030ef          	jal	532c <printf>
      exit(1);
    183c:	4505                	li	a0,1
    183e:	6ce030ef          	jal	4f0c <exit>
{
    1842:	0c800493          	li	s1,200
        int pid1 = fork();
    1846:	6be030ef          	jal	4f04 <fork>
        if(pid1 < 0){
    184a:	00054b63          	bltz	a0,1860 <forkfork+0x78>
        if(pid1 == 0){
    184e:	cd01                	beqz	a0,1866 <forkfork+0x7e>
        wait(0);
    1850:	4501                	li	a0,0
    1852:	6c2030ef          	jal	4f14 <wait>
      for(int j = 0; j < 200; j++){
    1856:	34fd                	addiw	s1,s1,-1
    1858:	f4fd                	bnez	s1,1846 <forkfork+0x5e>
      exit(0);
    185a:	4501                	li	a0,0
    185c:	6b0030ef          	jal	4f0c <exit>
          exit(1);
    1860:	4505                	li	a0,1
    1862:	6aa030ef          	jal	4f0c <exit>
          exit(0);
    1866:	6a6030ef          	jal	4f0c <exit>
      printf("%s: fork in child failed", s);
    186a:	85a6                	mv	a1,s1
    186c:	00004517          	auipc	a0,0x4
    1870:	70c50513          	addi	a0,a0,1804 # 5f78 <malloc+0xb94>
    1874:	2b9030ef          	jal	532c <printf>
      exit(1);
    1878:	4505                	li	a0,1
    187a:	692030ef          	jal	4f0c <exit>

000000000000187e <reparent2>:
{
    187e:	1101                	addi	sp,sp,-32
    1880:	ec06                	sd	ra,24(sp)
    1882:	e822                	sd	s0,16(sp)
    1884:	e426                	sd	s1,8(sp)
    1886:	1000                	addi	s0,sp,32
    1888:	32000493          	li	s1,800
    int pid1 = fork();
    188c:	678030ef          	jal	4f04 <fork>
    if(pid1 < 0){
    1890:	00054b63          	bltz	a0,18a6 <reparent2+0x28>
    if(pid1 == 0){
    1894:	c115                	beqz	a0,18b8 <reparent2+0x3a>
    wait(0);
    1896:	4501                	li	a0,0
    1898:	67c030ef          	jal	4f14 <wait>
  for(int i = 0; i < 800; i++){
    189c:	34fd                	addiw	s1,s1,-1
    189e:	f4fd                	bnez	s1,188c <reparent2+0xe>
  exit(0);
    18a0:	4501                	li	a0,0
    18a2:	66a030ef          	jal	4f0c <exit>
      printf("fork failed\n");
    18a6:	00006517          	auipc	a0,0x6
    18aa:	aaa50513          	addi	a0,a0,-1366 # 7350 <malloc+0x1f6c>
    18ae:	27f030ef          	jal	532c <printf>
      exit(1);
    18b2:	4505                	li	a0,1
    18b4:	658030ef          	jal	4f0c <exit>
      fork();
    18b8:	64c030ef          	jal	4f04 <fork>
      fork();
    18bc:	648030ef          	jal	4f04 <fork>
      exit(0);
    18c0:	4501                	li	a0,0
    18c2:	64a030ef          	jal	4f0c <exit>

00000000000018c6 <createdelete>:
{
    18c6:	7175                	addi	sp,sp,-144
    18c8:	e506                	sd	ra,136(sp)
    18ca:	e122                	sd	s0,128(sp)
    18cc:	fca6                	sd	s1,120(sp)
    18ce:	f8ca                	sd	s2,112(sp)
    18d0:	f4ce                	sd	s3,104(sp)
    18d2:	f0d2                	sd	s4,96(sp)
    18d4:	ecd6                	sd	s5,88(sp)
    18d6:	e8da                	sd	s6,80(sp)
    18d8:	e4de                	sd	s7,72(sp)
    18da:	e0e2                	sd	s8,64(sp)
    18dc:	fc66                	sd	s9,56(sp)
    18de:	f86a                	sd	s10,48(sp)
    18e0:	0900                	addi	s0,sp,144
    18e2:	8d2a                	mv	s10,a0
  for(pi = 0; pi < NCHILD; pi++){
    18e4:	4901                	li	s2,0
    18e6:	4991                	li	s3,4
    pid = fork();
    18e8:	61c030ef          	jal	4f04 <fork>
    18ec:	84aa                	mv	s1,a0
    if(pid < 0){
    18ee:	02054e63          	bltz	a0,192a <createdelete+0x64>
    if(pid == 0){
    18f2:	c531                	beqz	a0,193e <createdelete+0x78>
  for(pi = 0; pi < NCHILD; pi++){
    18f4:	2905                	addiw	s2,s2,1
    18f6:	ff3919e3          	bne	s2,s3,18e8 <createdelete+0x22>
    18fa:	4491                	li	s1,4
    wait(&xstatus);
    18fc:	f7c40993          	addi	s3,s0,-132
    1900:	854e                	mv	a0,s3
    1902:	612030ef          	jal	4f14 <wait>
    if(xstatus != 0)
    1906:	f7c42903          	lw	s2,-132(s0)
    190a:	0c091063          	bnez	s2,19ca <createdelete+0x104>
  for(pi = 0; pi < NCHILD; pi++){
    190e:	34fd                	addiw	s1,s1,-1
    1910:	f8e5                	bnez	s1,1900 <createdelete+0x3a>
  name[0] = name[1] = name[2] = 0;
    1912:	f8040123          	sb	zero,-126(s0)
    1916:	03000993          	li	s3,48
    191a:	5afd                	li	s5,-1
    191c:	07000c93          	li	s9,112
      if((i == 0 || i >= N/2) && fd < 0){
    1920:	4ba5                	li	s7,9
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1922:	4c21                	li	s8,8
    for(pi = 0; pi < NCHILD; pi++){
    1924:	07400b13          	li	s6,116
    1928:	a205                	j	1a48 <createdelete+0x182>
      printf("%s: fork failed\n", s);
    192a:	85ea                	mv	a1,s10
    192c:	00004517          	auipc	a0,0x4
    1930:	47c50513          	addi	a0,a0,1148 # 5da8 <malloc+0x9c4>
    1934:	1f9030ef          	jal	532c <printf>
      exit(1);
    1938:	4505                	li	a0,1
    193a:	5d2030ef          	jal	4f0c <exit>
      name[0] = 'p' + pi;
    193e:	0709091b          	addiw	s2,s2,112
    1942:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1946:	f8040123          	sb	zero,-126(s0)
        fd = open(name, O_CREATE | O_RDWR);
    194a:	f8040913          	addi	s2,s0,-128
    194e:	20200993          	li	s3,514
      for(i = 0; i < N; i++){
    1952:	4a51                	li	s4,20
    1954:	a815                	j	1988 <createdelete+0xc2>
          printf("%s: create failed\n", s);
    1956:	85ea                	mv	a1,s10
    1958:	00004517          	auipc	a0,0x4
    195c:	4e850513          	addi	a0,a0,1256 # 5e40 <malloc+0xa5c>
    1960:	1cd030ef          	jal	532c <printf>
          exit(1);
    1964:	4505                	li	a0,1
    1966:	5a6030ef          	jal	4f0c <exit>
          name[1] = '0' + (i / 2);
    196a:	01f4d79b          	srliw	a5,s1,0x1f
    196e:	9fa5                	addw	a5,a5,s1
    1970:	4017d79b          	sraiw	a5,a5,0x1
    1974:	0307879b          	addiw	a5,a5,48
    1978:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    197c:	854a                	mv	a0,s2
    197e:	5de030ef          	jal	4f5c <unlink>
    1982:	02054a63          	bltz	a0,19b6 <createdelete+0xf0>
      for(i = 0; i < N; i++){
    1986:	2485                	addiw	s1,s1,1
        name[1] = '0' + i;
    1988:	0304879b          	addiw	a5,s1,48
    198c:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1990:	85ce                	mv	a1,s3
    1992:	854a                	mv	a0,s2
    1994:	5b8030ef          	jal	4f4c <open>
        if(fd < 0){
    1998:	fa054fe3          	bltz	a0,1956 <createdelete+0x90>
        close(fd);
    199c:	598030ef          	jal	4f34 <close>
        if(i > 0 && (i % 2 ) == 0){
    19a0:	fe9053e3          	blez	s1,1986 <createdelete+0xc0>
    19a4:	0014f793          	andi	a5,s1,1
    19a8:	d3e9                	beqz	a5,196a <createdelete+0xa4>
      for(i = 0; i < N; i++){
    19aa:	2485                	addiw	s1,s1,1
    19ac:	fd449ee3          	bne	s1,s4,1988 <createdelete+0xc2>
      exit(0);
    19b0:	4501                	li	a0,0
    19b2:	55a030ef          	jal	4f0c <exit>
            printf("%s: unlink failed\n", s);
    19b6:	85ea                	mv	a1,s10
    19b8:	00004517          	auipc	a0,0x4
    19bc:	5e050513          	addi	a0,a0,1504 # 5f98 <malloc+0xbb4>
    19c0:	16d030ef          	jal	532c <printf>
            exit(1);
    19c4:	4505                	li	a0,1
    19c6:	546030ef          	jal	4f0c <exit>
      exit(1);
    19ca:	4505                	li	a0,1
    19cc:	540030ef          	jal	4f0c <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    19d0:	f8040613          	addi	a2,s0,-128
    19d4:	85ea                	mv	a1,s10
    19d6:	00004517          	auipc	a0,0x4
    19da:	5da50513          	addi	a0,a0,1498 # 5fb0 <malloc+0xbcc>
    19de:	14f030ef          	jal	532c <printf>
        exit(1);
    19e2:	4505                	li	a0,1
    19e4:	528030ef          	jal	4f0c <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    19e8:	035c7a63          	bgeu	s8,s5,1a1c <createdelete+0x156>
      if(fd >= 0)
    19ec:	02055563          	bgez	a0,1a16 <createdelete+0x150>
    for(pi = 0; pi < NCHILD; pi++){
    19f0:	2485                	addiw	s1,s1,1
    19f2:	0ff4f493          	zext.b	s1,s1
    19f6:	05648163          	beq	s1,s6,1a38 <createdelete+0x172>
      name[0] = 'p' + pi;
    19fa:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    19fe:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1a02:	4581                	li	a1,0
    1a04:	8552                	mv	a0,s4
    1a06:	546030ef          	jal	4f4c <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1a0a:	00090463          	beqz	s2,1a12 <createdelete+0x14c>
    1a0e:	fd2bdde3          	bge	s7,s2,19e8 <createdelete+0x122>
    1a12:	fa054fe3          	bltz	a0,19d0 <createdelete+0x10a>
        close(fd);
    1a16:	51e030ef          	jal	4f34 <close>
    1a1a:	bfd9                	j	19f0 <createdelete+0x12a>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1a1c:	fc054ae3          	bltz	a0,19f0 <createdelete+0x12a>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1a20:	f8040613          	addi	a2,s0,-128
    1a24:	85ea                	mv	a1,s10
    1a26:	00004517          	auipc	a0,0x4
    1a2a:	5b250513          	addi	a0,a0,1458 # 5fd8 <malloc+0xbf4>
    1a2e:	0ff030ef          	jal	532c <printf>
        exit(1);
    1a32:	4505                	li	a0,1
    1a34:	4d8030ef          	jal	4f0c <exit>
  for(i = 0; i < N; i++){
    1a38:	2905                	addiw	s2,s2,1
    1a3a:	2a85                	addiw	s5,s5,1
    1a3c:	2985                	addiw	s3,s3,1
    1a3e:	0ff9f993          	zext.b	s3,s3
    1a42:	47d1                	li	a5,20
    1a44:	00f90663          	beq	s2,a5,1a50 <createdelete+0x18a>
    for(pi = 0; pi < NCHILD; pi++){
    1a48:	84e6                	mv	s1,s9
      fd = open(name, 0);
    1a4a:	f8040a13          	addi	s4,s0,-128
    1a4e:	b775                	j	19fa <createdelete+0x134>
    1a50:	03000913          	li	s2,48
  name[0] = name[1] = name[2] = 0;
    1a54:	07000b13          	li	s6,112
      unlink(name);
    1a58:	f8040a13          	addi	s4,s0,-128
    for(pi = 0; pi < NCHILD; pi++){
    1a5c:	07400993          	li	s3,116
  for(i = 0; i < N; i++){
    1a60:	04400a93          	li	s5,68
  name[0] = name[1] = name[2] = 0;
    1a64:	84da                	mv	s1,s6
      name[0] = 'p' + pi;
    1a66:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1a6a:	f92400a3          	sb	s2,-127(s0)
      unlink(name);
    1a6e:	8552                	mv	a0,s4
    1a70:	4ec030ef          	jal	4f5c <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1a74:	2485                	addiw	s1,s1,1
    1a76:	0ff4f493          	zext.b	s1,s1
    1a7a:	ff3496e3          	bne	s1,s3,1a66 <createdelete+0x1a0>
  for(i = 0; i < N; i++){
    1a7e:	2905                	addiw	s2,s2,1
    1a80:	0ff97913          	zext.b	s2,s2
    1a84:	ff5910e3          	bne	s2,s5,1a64 <createdelete+0x19e>
}
    1a88:	60aa                	ld	ra,136(sp)
    1a8a:	640a                	ld	s0,128(sp)
    1a8c:	74e6                	ld	s1,120(sp)
    1a8e:	7946                	ld	s2,112(sp)
    1a90:	79a6                	ld	s3,104(sp)
    1a92:	7a06                	ld	s4,96(sp)
    1a94:	6ae6                	ld	s5,88(sp)
    1a96:	6b46                	ld	s6,80(sp)
    1a98:	6ba6                	ld	s7,72(sp)
    1a9a:	6c06                	ld	s8,64(sp)
    1a9c:	7ce2                	ld	s9,56(sp)
    1a9e:	7d42                	ld	s10,48(sp)
    1aa0:	6149                	addi	sp,sp,144
    1aa2:	8082                	ret

0000000000001aa4 <linkunlink>:
{
    1aa4:	711d                	addi	sp,sp,-96
    1aa6:	ec86                	sd	ra,88(sp)
    1aa8:	e8a2                	sd	s0,80(sp)
    1aaa:	e4a6                	sd	s1,72(sp)
    1aac:	e0ca                	sd	s2,64(sp)
    1aae:	fc4e                	sd	s3,56(sp)
    1ab0:	f852                	sd	s4,48(sp)
    1ab2:	f456                	sd	s5,40(sp)
    1ab4:	f05a                	sd	s6,32(sp)
    1ab6:	ec5e                	sd	s7,24(sp)
    1ab8:	e862                	sd	s8,16(sp)
    1aba:	e466                	sd	s9,8(sp)
    1abc:	e06a                	sd	s10,0(sp)
    1abe:	1080                	addi	s0,sp,96
    1ac0:	84aa                	mv	s1,a0
  unlink("x");
    1ac2:	00004517          	auipc	a0,0x4
    1ac6:	ac650513          	addi	a0,a0,-1338 # 5588 <malloc+0x1a4>
    1aca:	492030ef          	jal	4f5c <unlink>
  pid = fork();
    1ace:	436030ef          	jal	4f04 <fork>
  if(pid < 0){
    1ad2:	04054363          	bltz	a0,1b18 <linkunlink+0x74>
    1ad6:	8d2a                	mv	s10,a0
  unsigned int x = (pid ? 1 : 97);
    1ad8:	06100913          	li	s2,97
    1adc:	c111                	beqz	a0,1ae0 <linkunlink+0x3c>
    1ade:	4905                	li	s2,1
    1ae0:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1ae4:	41c65ab7          	lui	s5,0x41c65
    1ae8:	e6da8a9b          	addiw	s5,s5,-403 # 41c64e6d <base+0x41c541c5>
    1aec:	6a0d                	lui	s4,0x3
    1aee:	039a0a1b          	addiw	s4,s4,57 # 3039 <subdir+0x357>
    if((x % 3) == 0){
    1af2:	000ab9b7          	lui	s3,0xab
    1af6:	aab98993          	addi	s3,s3,-1365 # aaaab <base+0x99e03>
    1afa:	09b2                	slli	s3,s3,0xc
    1afc:	aab98993          	addi	s3,s3,-1365
    } else if((x % 3) == 1){
    1b00:	4b85                	li	s7,1
      unlink("x");
    1b02:	00004b17          	auipc	s6,0x4
    1b06:	a86b0b13          	addi	s6,s6,-1402 # 5588 <malloc+0x1a4>
      link("cat", "x");
    1b0a:	00004c97          	auipc	s9,0x4
    1b0e:	4f6c8c93          	addi	s9,s9,1270 # 6000 <malloc+0xc1c>
      close(open("x", O_RDWR | O_CREATE));
    1b12:	20200c13          	li	s8,514
    1b16:	a03d                	j	1b44 <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1b18:	85a6                	mv	a1,s1
    1b1a:	00004517          	auipc	a0,0x4
    1b1e:	28e50513          	addi	a0,a0,654 # 5da8 <malloc+0x9c4>
    1b22:	00b030ef          	jal	532c <printf>
    exit(1);
    1b26:	4505                	li	a0,1
    1b28:	3e4030ef          	jal	4f0c <exit>
      close(open("x", O_RDWR | O_CREATE));
    1b2c:	85e2                	mv	a1,s8
    1b2e:	855a                	mv	a0,s6
    1b30:	41c030ef          	jal	4f4c <open>
    1b34:	400030ef          	jal	4f34 <close>
    1b38:	a021                	j	1b40 <linkunlink+0x9c>
      unlink("x");
    1b3a:	855a                	mv	a0,s6
    1b3c:	420030ef          	jal	4f5c <unlink>
  for(i = 0; i < 100; i++){
    1b40:	34fd                	addiw	s1,s1,-1
    1b42:	c885                	beqz	s1,1b72 <linkunlink+0xce>
    x = x * 1103515245 + 12345;
    1b44:	035907bb          	mulw	a5,s2,s5
    1b48:	00fa07bb          	addw	a5,s4,a5
    1b4c:	893e                	mv	s2,a5
    if((x % 3) == 0){
    1b4e:	02079713          	slli	a4,a5,0x20
    1b52:	9301                	srli	a4,a4,0x20
    1b54:	03370733          	mul	a4,a4,s3
    1b58:	9305                	srli	a4,a4,0x21
    1b5a:	0017169b          	slliw	a3,a4,0x1
    1b5e:	9f35                	addw	a4,a4,a3
    1b60:	9f99                	subw	a5,a5,a4
    1b62:	d7e9                	beqz	a5,1b2c <linkunlink+0x88>
    } else if((x % 3) == 1){
    1b64:	fd779be3          	bne	a5,s7,1b3a <linkunlink+0x96>
      link("cat", "x");
    1b68:	85da                	mv	a1,s6
    1b6a:	8566                	mv	a0,s9
    1b6c:	400030ef          	jal	4f6c <link>
    1b70:	bfc1                	j	1b40 <linkunlink+0x9c>
  if(pid)
    1b72:	020d0363          	beqz	s10,1b98 <linkunlink+0xf4>
    wait(0);
    1b76:	4501                	li	a0,0
    1b78:	39c030ef          	jal	4f14 <wait>
}
    1b7c:	60e6                	ld	ra,88(sp)
    1b7e:	6446                	ld	s0,80(sp)
    1b80:	64a6                	ld	s1,72(sp)
    1b82:	6906                	ld	s2,64(sp)
    1b84:	79e2                	ld	s3,56(sp)
    1b86:	7a42                	ld	s4,48(sp)
    1b88:	7aa2                	ld	s5,40(sp)
    1b8a:	7b02                	ld	s6,32(sp)
    1b8c:	6be2                	ld	s7,24(sp)
    1b8e:	6c42                	ld	s8,16(sp)
    1b90:	6ca2                	ld	s9,8(sp)
    1b92:	6d02                	ld	s10,0(sp)
    1b94:	6125                	addi	sp,sp,96
    1b96:	8082                	ret
    exit(0);
    1b98:	4501                	li	a0,0
    1b9a:	372030ef          	jal	4f0c <exit>

0000000000001b9e <forktest>:
{
    1b9e:	7179                	addi	sp,sp,-48
    1ba0:	f406                	sd	ra,40(sp)
    1ba2:	f022                	sd	s0,32(sp)
    1ba4:	ec26                	sd	s1,24(sp)
    1ba6:	e84a                	sd	s2,16(sp)
    1ba8:	e44e                	sd	s3,8(sp)
    1baa:	1800                	addi	s0,sp,48
    1bac:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    1bae:	4481                	li	s1,0
    1bb0:	3e800913          	li	s2,1000
    pid = fork();
    1bb4:	350030ef          	jal	4f04 <fork>
    if(pid < 0)
    1bb8:	06054063          	bltz	a0,1c18 <forktest+0x7a>
    if(pid == 0)
    1bbc:	cd11                	beqz	a0,1bd8 <forktest+0x3a>
  for(n=0; n<N; n++){
    1bbe:	2485                	addiw	s1,s1,1
    1bc0:	ff249ae3          	bne	s1,s2,1bb4 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    1bc4:	85ce                	mv	a1,s3
    1bc6:	00004517          	auipc	a0,0x4
    1bca:	48a50513          	addi	a0,a0,1162 # 6050 <malloc+0xc6c>
    1bce:	75e030ef          	jal	532c <printf>
    exit(1);
    1bd2:	4505                	li	a0,1
    1bd4:	338030ef          	jal	4f0c <exit>
      exit(0);
    1bd8:	334030ef          	jal	4f0c <exit>
    printf("%s: no fork at all!\n", s);
    1bdc:	85ce                	mv	a1,s3
    1bde:	00004517          	auipc	a0,0x4
    1be2:	42a50513          	addi	a0,a0,1066 # 6008 <malloc+0xc24>
    1be6:	746030ef          	jal	532c <printf>
    exit(1);
    1bea:	4505                	li	a0,1
    1bec:	320030ef          	jal	4f0c <exit>
      printf("%s: wait stopped early\n", s);
    1bf0:	85ce                	mv	a1,s3
    1bf2:	00004517          	auipc	a0,0x4
    1bf6:	42e50513          	addi	a0,a0,1070 # 6020 <malloc+0xc3c>
    1bfa:	732030ef          	jal	532c <printf>
      exit(1);
    1bfe:	4505                	li	a0,1
    1c00:	30c030ef          	jal	4f0c <exit>
    printf("%s: wait got too many\n", s);
    1c04:	85ce                	mv	a1,s3
    1c06:	00004517          	auipc	a0,0x4
    1c0a:	43250513          	addi	a0,a0,1074 # 6038 <malloc+0xc54>
    1c0e:	71e030ef          	jal	532c <printf>
    exit(1);
    1c12:	4505                	li	a0,1
    1c14:	2f8030ef          	jal	4f0c <exit>
  if (n == 0) {
    1c18:	d0f1                	beqz	s1,1bdc <forktest+0x3e>
    if(wait(0) < 0){
    1c1a:	4501                	li	a0,0
    1c1c:	2f8030ef          	jal	4f14 <wait>
    1c20:	fc0548e3          	bltz	a0,1bf0 <forktest+0x52>
  for(; n > 0; n--){
    1c24:	34fd                	addiw	s1,s1,-1
    1c26:	fe904ae3          	bgtz	s1,1c1a <forktest+0x7c>
  if(wait(0) != -1){
    1c2a:	4501                	li	a0,0
    1c2c:	2e8030ef          	jal	4f14 <wait>
    1c30:	57fd                	li	a5,-1
    1c32:	fcf519e3          	bne	a0,a5,1c04 <forktest+0x66>
}
    1c36:	70a2                	ld	ra,40(sp)
    1c38:	7402                	ld	s0,32(sp)
    1c3a:	64e2                	ld	s1,24(sp)
    1c3c:	6942                	ld	s2,16(sp)
    1c3e:	69a2                	ld	s3,8(sp)
    1c40:	6145                	addi	sp,sp,48
    1c42:	8082                	ret

0000000000001c44 <kernmem>:
{
    1c44:	715d                	addi	sp,sp,-80
    1c46:	e486                	sd	ra,72(sp)
    1c48:	e0a2                	sd	s0,64(sp)
    1c4a:	fc26                	sd	s1,56(sp)
    1c4c:	f84a                	sd	s2,48(sp)
    1c4e:	f44e                	sd	s3,40(sp)
    1c50:	f052                	sd	s4,32(sp)
    1c52:	ec56                	sd	s5,24(sp)
    1c54:	e85a                	sd	s6,16(sp)
    1c56:	0880                	addi	s0,sp,80
    1c58:	8b2a                	mv	s6,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c5a:	4485                	li	s1,1
    1c5c:	04fe                	slli	s1,s1,0x1f
    wait(&xstatus);
    1c5e:	fbc40a93          	addi	s5,s0,-68
    if(xstatus != -1)  // did kernel kill child?
    1c62:	5a7d                	li	s4,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c64:	69b1                	lui	s3,0xc
    1c66:	35098993          	addi	s3,s3,848 # c350 <uninit+0xdb8>
    1c6a:	1003d937          	lui	s2,0x1003d
    1c6e:	090e                	slli	s2,s2,0x3
    1c70:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002c7d8>
    pid = fork();
    1c74:	290030ef          	jal	4f04 <fork>
    if(pid < 0){
    1c78:	02054763          	bltz	a0,1ca6 <kernmem+0x62>
    if(pid == 0){
    1c7c:	cd1d                	beqz	a0,1cba <kernmem+0x76>
    wait(&xstatus);
    1c7e:	8556                	mv	a0,s5
    1c80:	294030ef          	jal	4f14 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1c84:	fbc42783          	lw	a5,-68(s0)
    1c88:	05479663          	bne	a5,s4,1cd4 <kernmem+0x90>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    1c8c:	94ce                	add	s1,s1,s3
    1c8e:	ff2493e3          	bne	s1,s2,1c74 <kernmem+0x30>
}
    1c92:	60a6                	ld	ra,72(sp)
    1c94:	6406                	ld	s0,64(sp)
    1c96:	74e2                	ld	s1,56(sp)
    1c98:	7942                	ld	s2,48(sp)
    1c9a:	79a2                	ld	s3,40(sp)
    1c9c:	7a02                	ld	s4,32(sp)
    1c9e:	6ae2                	ld	s5,24(sp)
    1ca0:	6b42                	ld	s6,16(sp)
    1ca2:	6161                	addi	sp,sp,80
    1ca4:	8082                	ret
      printf("%s: fork failed\n", s);
    1ca6:	85da                	mv	a1,s6
    1ca8:	00004517          	auipc	a0,0x4
    1cac:	10050513          	addi	a0,a0,256 # 5da8 <malloc+0x9c4>
    1cb0:	67c030ef          	jal	532c <printf>
      exit(1);
    1cb4:	4505                	li	a0,1
    1cb6:	256030ef          	jal	4f0c <exit>
      printf("%s: oops could read %p = %x\n", s, a, *a);
    1cba:	0004c683          	lbu	a3,0(s1)
    1cbe:	8626                	mv	a2,s1
    1cc0:	85da                	mv	a1,s6
    1cc2:	00004517          	auipc	a0,0x4
    1cc6:	3b650513          	addi	a0,a0,950 # 6078 <malloc+0xc94>
    1cca:	662030ef          	jal	532c <printf>
      exit(1);
    1cce:	4505                	li	a0,1
    1cd0:	23c030ef          	jal	4f0c <exit>
      exit(1);
    1cd4:	4505                	li	a0,1
    1cd6:	236030ef          	jal	4f0c <exit>

0000000000001cda <MAXVAplus>:
{
    1cda:	7139                	addi	sp,sp,-64
    1cdc:	fc06                	sd	ra,56(sp)
    1cde:	f822                	sd	s0,48(sp)
    1ce0:	0080                	addi	s0,sp,64
  volatile uint64 a = MAXVA;
    1ce2:	4785                	li	a5,1
    1ce4:	179a                	slli	a5,a5,0x26
    1ce6:	fcf43423          	sd	a5,-56(s0)
  for( ; a != 0; a <<= 1){
    1cea:	fc843783          	ld	a5,-56(s0)
    1cee:	cf9d                	beqz	a5,1d2c <MAXVAplus+0x52>
    1cf0:	f426                	sd	s1,40(sp)
    1cf2:	f04a                	sd	s2,32(sp)
    1cf4:	ec4e                	sd	s3,24(sp)
    1cf6:	89aa                	mv	s3,a0
    wait(&xstatus);
    1cf8:	fc440913          	addi	s2,s0,-60
    if(xstatus != -1)  // did kernel kill child?
    1cfc:	54fd                	li	s1,-1
    pid = fork();
    1cfe:	206030ef          	jal	4f04 <fork>
    if(pid < 0){
    1d02:	02054963          	bltz	a0,1d34 <MAXVAplus+0x5a>
    if(pid == 0){
    1d06:	c129                	beqz	a0,1d48 <MAXVAplus+0x6e>
    wait(&xstatus);
    1d08:	854a                	mv	a0,s2
    1d0a:	20a030ef          	jal	4f14 <wait>
    if(xstatus != -1)  // did kernel kill child?
    1d0e:	fc442783          	lw	a5,-60(s0)
    1d12:	04979d63          	bne	a5,s1,1d6c <MAXVAplus+0x92>
  for( ; a != 0; a <<= 1){
    1d16:	fc843783          	ld	a5,-56(s0)
    1d1a:	0786                	slli	a5,a5,0x1
    1d1c:	fcf43423          	sd	a5,-56(s0)
    1d20:	fc843783          	ld	a5,-56(s0)
    1d24:	ffe9                	bnez	a5,1cfe <MAXVAplus+0x24>
    1d26:	74a2                	ld	s1,40(sp)
    1d28:	7902                	ld	s2,32(sp)
    1d2a:	69e2                	ld	s3,24(sp)
}
    1d2c:	70e2                	ld	ra,56(sp)
    1d2e:	7442                	ld	s0,48(sp)
    1d30:	6121                	addi	sp,sp,64
    1d32:	8082                	ret
      printf("%s: fork failed\n", s);
    1d34:	85ce                	mv	a1,s3
    1d36:	00004517          	auipc	a0,0x4
    1d3a:	07250513          	addi	a0,a0,114 # 5da8 <malloc+0x9c4>
    1d3e:	5ee030ef          	jal	532c <printf>
      exit(1);
    1d42:	4505                	li	a0,1
    1d44:	1c8030ef          	jal	4f0c <exit>
      *(char*)a = 99;
    1d48:	fc843783          	ld	a5,-56(s0)
    1d4c:	06300713          	li	a4,99
    1d50:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %p\n", s, (void*)a);
    1d54:	fc843603          	ld	a2,-56(s0)
    1d58:	85ce                	mv	a1,s3
    1d5a:	00004517          	auipc	a0,0x4
    1d5e:	33e50513          	addi	a0,a0,830 # 6098 <malloc+0xcb4>
    1d62:	5ca030ef          	jal	532c <printf>
      exit(1);
    1d66:	4505                	li	a0,1
    1d68:	1a4030ef          	jal	4f0c <exit>
      exit(1);
    1d6c:	4505                	li	a0,1
    1d6e:	19e030ef          	jal	4f0c <exit>

0000000000001d72 <stacktest>:
{
    1d72:	7179                	addi	sp,sp,-48
    1d74:	f406                	sd	ra,40(sp)
    1d76:	f022                	sd	s0,32(sp)
    1d78:	ec26                	sd	s1,24(sp)
    1d7a:	1800                	addi	s0,sp,48
    1d7c:	84aa                	mv	s1,a0
  pid = fork();
    1d7e:	186030ef          	jal	4f04 <fork>
  if(pid == 0) {
    1d82:	cd11                	beqz	a0,1d9e <stacktest+0x2c>
  } else if(pid < 0){
    1d84:	02054c63          	bltz	a0,1dbc <stacktest+0x4a>
  wait(&xstatus);
    1d88:	fdc40513          	addi	a0,s0,-36
    1d8c:	188030ef          	jal	4f14 <wait>
  if(xstatus == -1)  // kernel killed child?
    1d90:	fdc42503          	lw	a0,-36(s0)
    1d94:	57fd                	li	a5,-1
    1d96:	02f50d63          	beq	a0,a5,1dd0 <stacktest+0x5e>
    exit(xstatus);
    1d9a:	172030ef          	jal	4f0c <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    1d9e:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %d\n", s, *sp);
    1da0:	77f9                	lui	a5,0xffffe
    1da2:	97ba                	add	a5,a5,a4
    1da4:	0007c603          	lbu	a2,0(a5) # ffffffffffffe000 <base+0xfffffffffffed358>
    1da8:	85a6                	mv	a1,s1
    1daa:	00004517          	auipc	a0,0x4
    1dae:	30650513          	addi	a0,a0,774 # 60b0 <malloc+0xccc>
    1db2:	57a030ef          	jal	532c <printf>
    exit(1);
    1db6:	4505                	li	a0,1
    1db8:	154030ef          	jal	4f0c <exit>
    printf("%s: fork failed\n", s);
    1dbc:	85a6                	mv	a1,s1
    1dbe:	00004517          	auipc	a0,0x4
    1dc2:	fea50513          	addi	a0,a0,-22 # 5da8 <malloc+0x9c4>
    1dc6:	566030ef          	jal	532c <printf>
    exit(1);
    1dca:	4505                	li	a0,1
    1dcc:	140030ef          	jal	4f0c <exit>
    exit(0);
    1dd0:	4501                	li	a0,0
    1dd2:	13a030ef          	jal	4f0c <exit>

0000000000001dd6 <nowrite>:
{
    1dd6:	7159                	addi	sp,sp,-112
    1dd8:	f486                	sd	ra,104(sp)
    1dda:	f0a2                	sd	s0,96(sp)
    1ddc:	eca6                	sd	s1,88(sp)
    1dde:	e8ca                	sd	s2,80(sp)
    1de0:	e4ce                	sd	s3,72(sp)
    1de2:	e0d2                	sd	s4,64(sp)
    1de4:	1880                	addi	s0,sp,112
    1de6:	8a2a                	mv	s4,a0
  uint64 addrs[] = { 0, 0x80000000LL, 0x3fffffe000, 0x3ffffff000, 0x4000000000,
    1de8:	00006797          	auipc	a5,0x6
    1dec:	b8078793          	addi	a5,a5,-1152 # 7968 <malloc+0x2584>
    1df0:	7788                	ld	a0,40(a5)
    1df2:	7b8c                	ld	a1,48(a5)
    1df4:	7f90                	ld	a2,56(a5)
    1df6:	63b4                	ld	a3,64(a5)
    1df8:	67b8                	ld	a4,72(a5)
    1dfa:	6bbc                	ld	a5,80(a5)
    1dfc:	f8a43c23          	sd	a0,-104(s0)
    1e00:	fab43023          	sd	a1,-96(s0)
    1e04:	fac43423          	sd	a2,-88(s0)
    1e08:	fad43823          	sd	a3,-80(s0)
    1e0c:	fae43c23          	sd	a4,-72(s0)
    1e10:	fcf43023          	sd	a5,-64(s0)
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e14:	4481                	li	s1,0
    wait(&xstatus);
    1e16:	fcc40913          	addi	s2,s0,-52
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e1a:	4999                	li	s3,6
    pid = fork();
    1e1c:	0e8030ef          	jal	4f04 <fork>
    if(pid == 0) {
    1e20:	cd19                	beqz	a0,1e3e <nowrite+0x68>
    } else if(pid < 0){
    1e22:	04054163          	bltz	a0,1e64 <nowrite+0x8e>
    wait(&xstatus);
    1e26:	854a                	mv	a0,s2
    1e28:	0ec030ef          	jal	4f14 <wait>
    if(xstatus == 0){
    1e2c:	fcc42783          	lw	a5,-52(s0)
    1e30:	c7a1                	beqz	a5,1e78 <nowrite+0xa2>
  for(int ai = 0; ai < sizeof(addrs)/sizeof(addrs[0]); ai++){
    1e32:	2485                	addiw	s1,s1,1
    1e34:	ff3494e3          	bne	s1,s3,1e1c <nowrite+0x46>
  exit(0);
    1e38:	4501                	li	a0,0
    1e3a:	0d2030ef          	jal	4f0c <exit>
      volatile int *addr = (int *) addrs[ai];
    1e3e:	048e                	slli	s1,s1,0x3
    1e40:	fd048793          	addi	a5,s1,-48
    1e44:	008784b3          	add	s1,a5,s0
    1e48:	fc84b603          	ld	a2,-56(s1)
      *addr = 10;
    1e4c:	47a9                	li	a5,10
    1e4e:	c21c                	sw	a5,0(a2)
      printf("%s: write to %p did not fail!\n", s, addr);
    1e50:	85d2                	mv	a1,s4
    1e52:	00004517          	auipc	a0,0x4
    1e56:	28650513          	addi	a0,a0,646 # 60d8 <malloc+0xcf4>
    1e5a:	4d2030ef          	jal	532c <printf>
      exit(0);
    1e5e:	4501                	li	a0,0
    1e60:	0ac030ef          	jal	4f0c <exit>
      printf("%s: fork failed\n", s);
    1e64:	85d2                	mv	a1,s4
    1e66:	00004517          	auipc	a0,0x4
    1e6a:	f4250513          	addi	a0,a0,-190 # 5da8 <malloc+0x9c4>
    1e6e:	4be030ef          	jal	532c <printf>
      exit(1);
    1e72:	4505                	li	a0,1
    1e74:	098030ef          	jal	4f0c <exit>
      exit(1);
    1e78:	4505                	li	a0,1
    1e7a:	092030ef          	jal	4f0c <exit>

0000000000001e7e <manywrites>:
{
    1e7e:	7159                	addi	sp,sp,-112
    1e80:	f486                	sd	ra,104(sp)
    1e82:	f0a2                	sd	s0,96(sp)
    1e84:	eca6                	sd	s1,88(sp)
    1e86:	e8ca                	sd	s2,80(sp)
    1e88:	e4ce                	sd	s3,72(sp)
    1e8a:	fc56                	sd	s5,56(sp)
    1e8c:	1880                	addi	s0,sp,112
    1e8e:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1e90:	4901                	li	s2,0
    1e92:	4991                	li	s3,4
    int pid = fork();
    1e94:	070030ef          	jal	4f04 <fork>
    1e98:	84aa                	mv	s1,a0
    if(pid < 0){
    1e9a:	02054d63          	bltz	a0,1ed4 <manywrites+0x56>
    if(pid == 0){
    1e9e:	c931                	beqz	a0,1ef2 <manywrites+0x74>
  for(int ci = 0; ci < nchildren; ci++){
    1ea0:	2905                	addiw	s2,s2,1
    1ea2:	ff3919e3          	bne	s2,s3,1e94 <manywrites+0x16>
    1ea6:	4491                	li	s1,4
    wait(&st);
    1ea8:	f9840913          	addi	s2,s0,-104
    int st = 0;
    1eac:	f8042c23          	sw	zero,-104(s0)
    wait(&st);
    1eb0:	854a                	mv	a0,s2
    1eb2:	062030ef          	jal	4f14 <wait>
    if(st != 0)
    1eb6:	f9842503          	lw	a0,-104(s0)
    1eba:	0e051463          	bnez	a0,1fa2 <manywrites+0x124>
  for(int ci = 0; ci < nchildren; ci++){
    1ebe:	34fd                	addiw	s1,s1,-1
    1ec0:	f4f5                	bnez	s1,1eac <manywrites+0x2e>
    1ec2:	e0d2                	sd	s4,64(sp)
    1ec4:	f85a                	sd	s6,48(sp)
    1ec6:	f45e                	sd	s7,40(sp)
    1ec8:	f062                	sd	s8,32(sp)
    1eca:	ec66                	sd	s9,24(sp)
    1ecc:	e86a                	sd	s10,16(sp)
  exit(0);
    1ece:	4501                	li	a0,0
    1ed0:	03c030ef          	jal	4f0c <exit>
    1ed4:	e0d2                	sd	s4,64(sp)
    1ed6:	f85a                	sd	s6,48(sp)
    1ed8:	f45e                	sd	s7,40(sp)
    1eda:	f062                	sd	s8,32(sp)
    1edc:	ec66                	sd	s9,24(sp)
    1ede:	e86a                	sd	s10,16(sp)
      printf("fork failed\n");
    1ee0:	00005517          	auipc	a0,0x5
    1ee4:	47050513          	addi	a0,a0,1136 # 7350 <malloc+0x1f6c>
    1ee8:	444030ef          	jal	532c <printf>
      exit(1);
    1eec:	4505                	li	a0,1
    1eee:	01e030ef          	jal	4f0c <exit>
    1ef2:	e0d2                	sd	s4,64(sp)
    1ef4:	f85a                	sd	s6,48(sp)
    1ef6:	f45e                	sd	s7,40(sp)
    1ef8:	f062                	sd	s8,32(sp)
    1efa:	ec66                	sd	s9,24(sp)
    1efc:	e86a                	sd	s10,16(sp)
      name[0] = 'b';
    1efe:	06200793          	li	a5,98
    1f02:	f8f40c23          	sb	a5,-104(s0)
      name[1] = 'a' + ci;
    1f06:	0619079b          	addiw	a5,s2,97
    1f0a:	f8f40ca3          	sb	a5,-103(s0)
      name[2] = '\0';
    1f0e:	f8040d23          	sb	zero,-102(s0)
      unlink(name);
    1f12:	f9840513          	addi	a0,s0,-104
    1f16:	046030ef          	jal	4f5c <unlink>
    1f1a:	4d79                	li	s10,30
          int fd = open(name, O_CREATE | O_RDWR);
    1f1c:	f9840c13          	addi	s8,s0,-104
    1f20:	20200b93          	li	s7,514
          int cc = write(fd, buf, sz);
    1f24:	6b0d                	lui	s6,0x3
    1f26:	0000cc97          	auipc	s9,0xc
    1f2a:	d82c8c93          	addi	s9,s9,-638 # dca8 <buf>
        for(int i = 0; i < ci+1; i++){
    1f2e:	8a26                	mv	s4,s1
          int fd = open(name, O_CREATE | O_RDWR);
    1f30:	85de                	mv	a1,s7
    1f32:	8562                	mv	a0,s8
    1f34:	018030ef          	jal	4f4c <open>
    1f38:	89aa                	mv	s3,a0
          if(fd < 0){
    1f3a:	02054c63          	bltz	a0,1f72 <manywrites+0xf4>
          int cc = write(fd, buf, sz);
    1f3e:	865a                	mv	a2,s6
    1f40:	85e6                	mv	a1,s9
    1f42:	7eb020ef          	jal	4f2c <write>
          if(cc != sz){
    1f46:	05651263          	bne	a0,s6,1f8a <manywrites+0x10c>
          close(fd);
    1f4a:	854e                	mv	a0,s3
    1f4c:	7e9020ef          	jal	4f34 <close>
        for(int i = 0; i < ci+1; i++){
    1f50:	2a05                	addiw	s4,s4,1
    1f52:	fd495fe3          	bge	s2,s4,1f30 <manywrites+0xb2>
        unlink(name);
    1f56:	f9840513          	addi	a0,s0,-104
    1f5a:	002030ef          	jal	4f5c <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f5e:	3d7d                	addiw	s10,s10,-1
    1f60:	fc0d17e3          	bnez	s10,1f2e <manywrites+0xb0>
      unlink(name);
    1f64:	f9840513          	addi	a0,s0,-104
    1f68:	7f5020ef          	jal	4f5c <unlink>
      exit(0);
    1f6c:	4501                	li	a0,0
    1f6e:	79f020ef          	jal	4f0c <exit>
            printf("%s: cannot create %s\n", s, name);
    1f72:	f9840613          	addi	a2,s0,-104
    1f76:	85d6                	mv	a1,s5
    1f78:	00004517          	auipc	a0,0x4
    1f7c:	18050513          	addi	a0,a0,384 # 60f8 <malloc+0xd14>
    1f80:	3ac030ef          	jal	532c <printf>
            exit(1);
    1f84:	4505                	li	a0,1
    1f86:	787020ef          	jal	4f0c <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1f8a:	86aa                	mv	a3,a0
    1f8c:	660d                	lui	a2,0x3
    1f8e:	85d6                	mv	a1,s5
    1f90:	00003517          	auipc	a0,0x3
    1f94:	65850513          	addi	a0,a0,1624 # 55e8 <malloc+0x204>
    1f98:	394030ef          	jal	532c <printf>
            exit(1);
    1f9c:	4505                	li	a0,1
    1f9e:	76f020ef          	jal	4f0c <exit>
    1fa2:	e0d2                	sd	s4,64(sp)
    1fa4:	f85a                	sd	s6,48(sp)
    1fa6:	f45e                	sd	s7,40(sp)
    1fa8:	f062                	sd	s8,32(sp)
    1faa:	ec66                	sd	s9,24(sp)
    1fac:	e86a                	sd	s10,16(sp)
      exit(st);
    1fae:	75f020ef          	jal	4f0c <exit>

0000000000001fb2 <copyinstr3>:
{
    1fb2:	7179                	addi	sp,sp,-48
    1fb4:	f406                	sd	ra,40(sp)
    1fb6:	f022                	sd	s0,32(sp)
    1fb8:	ec26                	sd	s1,24(sp)
    1fba:	1800                	addi	s0,sp,48
  sbrk(8192);
    1fbc:	6509                	lui	a0,0x2
    1fbe:	71b020ef          	jal	4ed8 <sbrk>
  uint64 top = (uint64) sbrk(0);
    1fc2:	4501                	li	a0,0
    1fc4:	715020ef          	jal	4ed8 <sbrk>
  if((top % PGSIZE) != 0){
    1fc8:	03451793          	slli	a5,a0,0x34
    1fcc:	e7bd                	bnez	a5,203a <copyinstr3+0x88>
  top = (uint64) sbrk(0);
    1fce:	4501                	li	a0,0
    1fd0:	709020ef          	jal	4ed8 <sbrk>
  if(top % PGSIZE){
    1fd4:	03451793          	slli	a5,a0,0x34
    1fd8:	ebb5                	bnez	a5,204c <copyinstr3+0x9a>
  char *b = (char *) (top - 1);
    1fda:	fff50493          	addi	s1,a0,-1 # 1fff <copyinstr3+0x4d>
  *b = 'x';
    1fde:	07800793          	li	a5,120
    1fe2:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    1fe6:	8526                	mv	a0,s1
    1fe8:	775020ef          	jal	4f5c <unlink>
  if(ret != -1){
    1fec:	57fd                	li	a5,-1
    1fee:	06f51863          	bne	a0,a5,205e <copyinstr3+0xac>
  int fd = open(b, O_CREATE | O_WRONLY);
    1ff2:	20100593          	li	a1,513
    1ff6:	8526                	mv	a0,s1
    1ff8:	755020ef          	jal	4f4c <open>
  if(fd != -1){
    1ffc:	57fd                	li	a5,-1
    1ffe:	06f51b63          	bne	a0,a5,2074 <copyinstr3+0xc2>
  ret = link(b, b);
    2002:	85a6                	mv	a1,s1
    2004:	8526                	mv	a0,s1
    2006:	767020ef          	jal	4f6c <link>
  if(ret != -1){
    200a:	57fd                	li	a5,-1
    200c:	06f51f63          	bne	a0,a5,208a <copyinstr3+0xd8>
  char *args[] = { "xx", 0 };
    2010:	00005797          	auipc	a5,0x5
    2014:	de878793          	addi	a5,a5,-536 # 6df8 <malloc+0x1a14>
    2018:	fcf43823          	sd	a5,-48(s0)
    201c:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2020:	fd040593          	addi	a1,s0,-48
    2024:	8526                	mv	a0,s1
    2026:	71f020ef          	jal	4f44 <exec>
  if(ret != -1){
    202a:	57fd                	li	a5,-1
    202c:	06f51b63          	bne	a0,a5,20a2 <copyinstr3+0xf0>
}
    2030:	70a2                	ld	ra,40(sp)
    2032:	7402                	ld	s0,32(sp)
    2034:	64e2                	ld	s1,24(sp)
    2036:	6145                	addi	sp,sp,48
    2038:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    203a:	6785                	lui	a5,0x1
    203c:	fff78713          	addi	a4,a5,-1 # fff <bigdir+0x109>
    2040:	8d79                	and	a0,a0,a4
    2042:	40a7853b          	subw	a0,a5,a0
    2046:	693020ef          	jal	4ed8 <sbrk>
    204a:	b751                	j	1fce <copyinstr3+0x1c>
    printf("oops\n");
    204c:	00004517          	auipc	a0,0x4
    2050:	0c450513          	addi	a0,a0,196 # 6110 <malloc+0xd2c>
    2054:	2d8030ef          	jal	532c <printf>
    exit(1);
    2058:	4505                	li	a0,1
    205a:	6b3020ef          	jal	4f0c <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    205e:	862a                	mv	a2,a0
    2060:	85a6                	mv	a1,s1
    2062:	00004517          	auipc	a0,0x4
    2066:	c6650513          	addi	a0,a0,-922 # 5cc8 <malloc+0x8e4>
    206a:	2c2030ef          	jal	532c <printf>
    exit(1);
    206e:	4505                	li	a0,1
    2070:	69d020ef          	jal	4f0c <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    2074:	862a                	mv	a2,a0
    2076:	85a6                	mv	a1,s1
    2078:	00004517          	auipc	a0,0x4
    207c:	c7050513          	addi	a0,a0,-912 # 5ce8 <malloc+0x904>
    2080:	2ac030ef          	jal	532c <printf>
    exit(1);
    2084:	4505                	li	a0,1
    2086:	687020ef          	jal	4f0c <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    208a:	86aa                	mv	a3,a0
    208c:	8626                	mv	a2,s1
    208e:	85a6                	mv	a1,s1
    2090:	00004517          	auipc	a0,0x4
    2094:	c7850513          	addi	a0,a0,-904 # 5d08 <malloc+0x924>
    2098:	294030ef          	jal	532c <printf>
    exit(1);
    209c:	4505                	li	a0,1
    209e:	66f020ef          	jal	4f0c <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    20a2:	863e                	mv	a2,a5
    20a4:	85a6                	mv	a1,s1
    20a6:	00004517          	auipc	a0,0x4
    20aa:	c8a50513          	addi	a0,a0,-886 # 5d30 <malloc+0x94c>
    20ae:	27e030ef          	jal	532c <printf>
    exit(1);
    20b2:	4505                	li	a0,1
    20b4:	659020ef          	jal	4f0c <exit>

00000000000020b8 <rwsbrk>:
{
    20b8:	1101                	addi	sp,sp,-32
    20ba:	ec06                	sd	ra,24(sp)
    20bc:	e822                	sd	s0,16(sp)
    20be:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    20c0:	6509                	lui	a0,0x2
    20c2:	617020ef          	jal	4ed8 <sbrk>
  if(a == (uint64) SBRK_ERROR) {
    20c6:	57fd                	li	a5,-1
    20c8:	04f50a63          	beq	a0,a5,211c <rwsbrk+0x64>
    20cc:	e426                	sd	s1,8(sp)
    20ce:	84aa                	mv	s1,a0
  if (sbrk(-8192) == SBRK_ERROR) {
    20d0:	7579                	lui	a0,0xffffe
    20d2:	607020ef          	jal	4ed8 <sbrk>
    20d6:	57fd                	li	a5,-1
    20d8:	04f50d63          	beq	a0,a5,2132 <rwsbrk+0x7a>
    20dc:	e04a                	sd	s2,0(sp)
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    20de:	20100593          	li	a1,513
    20e2:	00004517          	auipc	a0,0x4
    20e6:	06e50513          	addi	a0,a0,110 # 6150 <malloc+0xd6c>
    20ea:	663020ef          	jal	4f4c <open>
    20ee:	892a                	mv	s2,a0
  if(fd < 0){
    20f0:	04054b63          	bltz	a0,2146 <rwsbrk+0x8e>
  n = write(fd, (void*)(a+PGSIZE), 1024);
    20f4:	6785                	lui	a5,0x1
    20f6:	94be                	add	s1,s1,a5
    20f8:	40000613          	li	a2,1024
    20fc:	85a6                	mv	a1,s1
    20fe:	62f020ef          	jal	4f2c <write>
    2102:	862a                	mv	a2,a0
  if(n >= 0){
    2104:	04054a63          	bltz	a0,2158 <rwsbrk+0xa0>
    printf("write(fd, %p, 1024) returned %d, not -1\n", (void*)a+PGSIZE, n);
    2108:	85a6                	mv	a1,s1
    210a:	00004517          	auipc	a0,0x4
    210e:	06650513          	addi	a0,a0,102 # 6170 <malloc+0xd8c>
    2112:	21a030ef          	jal	532c <printf>
    exit(1);
    2116:	4505                	li	a0,1
    2118:	5f5020ef          	jal	4f0c <exit>
    211c:	e426                	sd	s1,8(sp)
    211e:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) failed\n");
    2120:	00004517          	auipc	a0,0x4
    2124:	ff850513          	addi	a0,a0,-8 # 6118 <malloc+0xd34>
    2128:	204030ef          	jal	532c <printf>
    exit(1);
    212c:	4505                	li	a0,1
    212e:	5df020ef          	jal	4f0c <exit>
    2132:	e04a                	sd	s2,0(sp)
    printf("sbrk(rwsbrk) shrink failed\n");
    2134:	00004517          	auipc	a0,0x4
    2138:	ffc50513          	addi	a0,a0,-4 # 6130 <malloc+0xd4c>
    213c:	1f0030ef          	jal	532c <printf>
    exit(1);
    2140:	4505                	li	a0,1
    2142:	5cb020ef          	jal	4f0c <exit>
    printf("open(rwsbrk) failed\n");
    2146:	00004517          	auipc	a0,0x4
    214a:	01250513          	addi	a0,a0,18 # 6158 <malloc+0xd74>
    214e:	1de030ef          	jal	532c <printf>
    exit(1);
    2152:	4505                	li	a0,1
    2154:	5b9020ef          	jal	4f0c <exit>
  close(fd);
    2158:	854a                	mv	a0,s2
    215a:	5db020ef          	jal	4f34 <close>
  unlink("rwsbrk");
    215e:	00004517          	auipc	a0,0x4
    2162:	ff250513          	addi	a0,a0,-14 # 6150 <malloc+0xd6c>
    2166:	5f7020ef          	jal	4f5c <unlink>
  fd = open("README", O_RDONLY);
    216a:	4581                	li	a1,0
    216c:	00003517          	auipc	a0,0x3
    2170:	58450513          	addi	a0,a0,1412 # 56f0 <malloc+0x30c>
    2174:	5d9020ef          	jal	4f4c <open>
    2178:	892a                	mv	s2,a0
  if(fd < 0){
    217a:	02054363          	bltz	a0,21a0 <rwsbrk+0xe8>
  n = read(fd, (void*)(a+PGSIZE), 10);
    217e:	4629                	li	a2,10
    2180:	85a6                	mv	a1,s1
    2182:	5a3020ef          	jal	4f24 <read>
    2186:	862a                	mv	a2,a0
  if(n >= 0){
    2188:	02054563          	bltz	a0,21b2 <rwsbrk+0xfa>
    printf("read(fd, %p, 10) returned %d, not -1\n", (void*)a+PGSIZE, n);
    218c:	85a6                	mv	a1,s1
    218e:	00004517          	auipc	a0,0x4
    2192:	01250513          	addi	a0,a0,18 # 61a0 <malloc+0xdbc>
    2196:	196030ef          	jal	532c <printf>
    exit(1);
    219a:	4505                	li	a0,1
    219c:	571020ef          	jal	4f0c <exit>
    printf("open(README) failed\n");
    21a0:	00003517          	auipc	a0,0x3
    21a4:	55850513          	addi	a0,a0,1368 # 56f8 <malloc+0x314>
    21a8:	184030ef          	jal	532c <printf>
    exit(1);
    21ac:	4505                	li	a0,1
    21ae:	55f020ef          	jal	4f0c <exit>
  close(fd);
    21b2:	854a                	mv	a0,s2
    21b4:	581020ef          	jal	4f34 <close>
  exit(0);
    21b8:	4501                	li	a0,0
    21ba:	553020ef          	jal	4f0c <exit>

00000000000021be <sbrkbasic>:
{
    21be:	715d                	addi	sp,sp,-80
    21c0:	e486                	sd	ra,72(sp)
    21c2:	e0a2                	sd	s0,64(sp)
    21c4:	ec56                	sd	s5,24(sp)
    21c6:	0880                	addi	s0,sp,80
    21c8:	8aaa                	mv	s5,a0
  pid = fork();
    21ca:	53b020ef          	jal	4f04 <fork>
  if(pid < 0){
    21ce:	02054c63          	bltz	a0,2206 <sbrkbasic+0x48>
  if(pid == 0){
    21d2:	ed31                	bnez	a0,222e <sbrkbasic+0x70>
    a = sbrk(TOOMUCH);
    21d4:	40000537          	lui	a0,0x40000
    21d8:	501020ef          	jal	4ed8 <sbrk>
    if(a == (char*)SBRK_ERROR){
    21dc:	57fd                	li	a5,-1
    21de:	04f50163          	beq	a0,a5,2220 <sbrkbasic+0x62>
    21e2:	fc26                	sd	s1,56(sp)
    21e4:	f84a                	sd	s2,48(sp)
    21e6:	f44e                	sd	s3,40(sp)
    21e8:	f052                	sd	s4,32(sp)
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    21ea:	400007b7          	lui	a5,0x40000
    21ee:	97aa                	add	a5,a5,a0
      *b = 99;
    21f0:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    21f4:	6705                	lui	a4,0x1
      *b = 99;
    21f6:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3ffef358>
    for(b = a; b < a+TOOMUCH; b += PGSIZE){
    21fa:	953a                	add	a0,a0,a4
    21fc:	fef51de3          	bne	a0,a5,21f6 <sbrkbasic+0x38>
    exit(1);
    2200:	4505                	li	a0,1
    2202:	50b020ef          	jal	4f0c <exit>
    2206:	fc26                	sd	s1,56(sp)
    2208:	f84a                	sd	s2,48(sp)
    220a:	f44e                	sd	s3,40(sp)
    220c:	f052                	sd	s4,32(sp)
    printf("fork failed in sbrkbasic\n");
    220e:	00004517          	auipc	a0,0x4
    2212:	fba50513          	addi	a0,a0,-70 # 61c8 <malloc+0xde4>
    2216:	116030ef          	jal	532c <printf>
    exit(1);
    221a:	4505                	li	a0,1
    221c:	4f1020ef          	jal	4f0c <exit>
    2220:	fc26                	sd	s1,56(sp)
    2222:	f84a                	sd	s2,48(sp)
    2224:	f44e                	sd	s3,40(sp)
    2226:	f052                	sd	s4,32(sp)
      exit(0);
    2228:	4501                	li	a0,0
    222a:	4e3020ef          	jal	4f0c <exit>
  wait(&xstatus);
    222e:	fbc40513          	addi	a0,s0,-68
    2232:	4e3020ef          	jal	4f14 <wait>
  if(xstatus == 1){
    2236:	fbc42703          	lw	a4,-68(s0)
    223a:	4785                	li	a5,1
    223c:	02f70063          	beq	a4,a5,225c <sbrkbasic+0x9e>
    2240:	fc26                	sd	s1,56(sp)
    2242:	f84a                	sd	s2,48(sp)
    2244:	f44e                	sd	s3,40(sp)
    2246:	f052                	sd	s4,32(sp)
  a = sbrk(0);
    2248:	4501                	li	a0,0
    224a:	48f020ef          	jal	4ed8 <sbrk>
    224e:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    2250:	4901                	li	s2,0
    b = sbrk(1);
    2252:	4985                	li	s3,1
  for(i = 0; i < 5000; i++){
    2254:	6a05                	lui	s4,0x1
    2256:	388a0a13          	addi	s4,s4,904 # 1388 <truncate3+0x148>
    225a:	a005                	j	227a <sbrkbasic+0xbc>
    225c:	fc26                	sd	s1,56(sp)
    225e:	f84a                	sd	s2,48(sp)
    2260:	f44e                	sd	s3,40(sp)
    2262:	f052                	sd	s4,32(sp)
    printf("%s: too much memory allocated!\n", s);
    2264:	85d6                	mv	a1,s5
    2266:	00004517          	auipc	a0,0x4
    226a:	f8250513          	addi	a0,a0,-126 # 61e8 <malloc+0xe04>
    226e:	0be030ef          	jal	532c <printf>
    exit(1);
    2272:	4505                	li	a0,1
    2274:	499020ef          	jal	4f0c <exit>
    2278:	84be                	mv	s1,a5
    b = sbrk(1);
    227a:	854e                	mv	a0,s3
    227c:	45d020ef          	jal	4ed8 <sbrk>
    if(b != a){
    2280:	04951163          	bne	a0,s1,22c2 <sbrkbasic+0x104>
    *b = 1;
    2284:	01348023          	sb	s3,0(s1)
    a = b + 1;
    2288:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    228c:	2905                	addiw	s2,s2,1
    228e:	ff4915e3          	bne	s2,s4,2278 <sbrkbasic+0xba>
  pid = fork();
    2292:	473020ef          	jal	4f04 <fork>
    2296:	892a                	mv	s2,a0
  if(pid < 0){
    2298:	04054263          	bltz	a0,22dc <sbrkbasic+0x11e>
  c = sbrk(1);
    229c:	4505                	li	a0,1
    229e:	43b020ef          	jal	4ed8 <sbrk>
  c = sbrk(1);
    22a2:	4505                	li	a0,1
    22a4:	435020ef          	jal	4ed8 <sbrk>
  if(c != a + 1){
    22a8:	0489                	addi	s1,s1,2
    22aa:	04a48363          	beq	s1,a0,22f0 <sbrkbasic+0x132>
    printf("%s: sbrk test failed post-fork\n", s);
    22ae:	85d6                	mv	a1,s5
    22b0:	00004517          	auipc	a0,0x4
    22b4:	f9850513          	addi	a0,a0,-104 # 6248 <malloc+0xe64>
    22b8:	074030ef          	jal	532c <printf>
    exit(1);
    22bc:	4505                	li	a0,1
    22be:	44f020ef          	jal	4f0c <exit>
      printf("%s: sbrk test failed %d %p %p\n", s, i, a, b);
    22c2:	872a                	mv	a4,a0
    22c4:	86a6                	mv	a3,s1
    22c6:	864a                	mv	a2,s2
    22c8:	85d6                	mv	a1,s5
    22ca:	00004517          	auipc	a0,0x4
    22ce:	f3e50513          	addi	a0,a0,-194 # 6208 <malloc+0xe24>
    22d2:	05a030ef          	jal	532c <printf>
      exit(1);
    22d6:	4505                	li	a0,1
    22d8:	435020ef          	jal	4f0c <exit>
    printf("%s: sbrk test fork failed\n", s);
    22dc:	85d6                	mv	a1,s5
    22de:	00004517          	auipc	a0,0x4
    22e2:	f4a50513          	addi	a0,a0,-182 # 6228 <malloc+0xe44>
    22e6:	046030ef          	jal	532c <printf>
    exit(1);
    22ea:	4505                	li	a0,1
    22ec:	421020ef          	jal	4f0c <exit>
  if(pid == 0)
    22f0:	00091563          	bnez	s2,22fa <sbrkbasic+0x13c>
    exit(0);
    22f4:	4501                	li	a0,0
    22f6:	417020ef          	jal	4f0c <exit>
  wait(&xstatus);
    22fa:	fbc40513          	addi	a0,s0,-68
    22fe:	417020ef          	jal	4f14 <wait>
  exit(xstatus);
    2302:	fbc42503          	lw	a0,-68(s0)
    2306:	407020ef          	jal	4f0c <exit>

000000000000230a <sbrkmuch>:
{
    230a:	7179                	addi	sp,sp,-48
    230c:	f406                	sd	ra,40(sp)
    230e:	f022                	sd	s0,32(sp)
    2310:	ec26                	sd	s1,24(sp)
    2312:	e84a                	sd	s2,16(sp)
    2314:	e44e                	sd	s3,8(sp)
    2316:	e052                	sd	s4,0(sp)
    2318:	1800                	addi	s0,sp,48
    231a:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    231c:	4501                	li	a0,0
    231e:	3bb020ef          	jal	4ed8 <sbrk>
    2322:	892a                	mv	s2,a0
  a = sbrk(0);
    2324:	4501                	li	a0,0
    2326:	3b3020ef          	jal	4ed8 <sbrk>
    232a:	84aa                	mv	s1,a0
  p = sbrk(amt);
    232c:	06400537          	lui	a0,0x6400
    2330:	9d05                	subw	a0,a0,s1
    2332:	3a7020ef          	jal	4ed8 <sbrk>
  if (p != a) {
    2336:	08a49763          	bne	s1,a0,23c4 <sbrkmuch+0xba>
  *lastaddr = 99;
    233a:	064007b7          	lui	a5,0x6400
    233e:	06300713          	li	a4,99
    2342:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63ef357>
  a = sbrk(0);
    2346:	4501                	li	a0,0
    2348:	391020ef          	jal	4ed8 <sbrk>
    234c:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    234e:	757d                	lui	a0,0xfffff
    2350:	389020ef          	jal	4ed8 <sbrk>
  if(c == (char*)SBRK_ERROR){
    2354:	57fd                	li	a5,-1
    2356:	08f50163          	beq	a0,a5,23d8 <sbrkmuch+0xce>
  c = sbrk(0);
    235a:	4501                	li	a0,0
    235c:	37d020ef          	jal	4ed8 <sbrk>
  if(c != a - PGSIZE){
    2360:	77fd                	lui	a5,0xfffff
    2362:	97a6                	add	a5,a5,s1
    2364:	08f51463          	bne	a0,a5,23ec <sbrkmuch+0xe2>
  a = sbrk(0);
    2368:	4501                	li	a0,0
    236a:	36f020ef          	jal	4ed8 <sbrk>
    236e:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2370:	6505                	lui	a0,0x1
    2372:	367020ef          	jal	4ed8 <sbrk>
    2376:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2378:	08a49663          	bne	s1,a0,2404 <sbrkmuch+0xfa>
    237c:	4501                	li	a0,0
    237e:	35b020ef          	jal	4ed8 <sbrk>
    2382:	6785                	lui	a5,0x1
    2384:	97a6                	add	a5,a5,s1
    2386:	06f51f63          	bne	a0,a5,2404 <sbrkmuch+0xfa>
  if(*lastaddr == 99){
    238a:	064007b7          	lui	a5,0x6400
    238e:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63ef357>
    2392:	06300793          	li	a5,99
    2396:	08f70363          	beq	a4,a5,241c <sbrkmuch+0x112>
  a = sbrk(0);
    239a:	4501                	li	a0,0
    239c:	33d020ef          	jal	4ed8 <sbrk>
    23a0:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    23a2:	4501                	li	a0,0
    23a4:	335020ef          	jal	4ed8 <sbrk>
    23a8:	40a9053b          	subw	a0,s2,a0
    23ac:	32d020ef          	jal	4ed8 <sbrk>
  if(c != a){
    23b0:	08a49063          	bne	s1,a0,2430 <sbrkmuch+0x126>
}
    23b4:	70a2                	ld	ra,40(sp)
    23b6:	7402                	ld	s0,32(sp)
    23b8:	64e2                	ld	s1,24(sp)
    23ba:	6942                	ld	s2,16(sp)
    23bc:	69a2                	ld	s3,8(sp)
    23be:	6a02                	ld	s4,0(sp)
    23c0:	6145                	addi	sp,sp,48
    23c2:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    23c4:	85ce                	mv	a1,s3
    23c6:	00004517          	auipc	a0,0x4
    23ca:	ea250513          	addi	a0,a0,-350 # 6268 <malloc+0xe84>
    23ce:	75f020ef          	jal	532c <printf>
    exit(1);
    23d2:	4505                	li	a0,1
    23d4:	339020ef          	jal	4f0c <exit>
    printf("%s: sbrk could not deallocate\n", s);
    23d8:	85ce                	mv	a1,s3
    23da:	00004517          	auipc	a0,0x4
    23de:	ed650513          	addi	a0,a0,-298 # 62b0 <malloc+0xecc>
    23e2:	74b020ef          	jal	532c <printf>
    exit(1);
    23e6:	4505                	li	a0,1
    23e8:	325020ef          	jal	4f0c <exit>
    printf("%s: sbrk deallocation produced wrong address, a %p c %p\n", s, a, c);
    23ec:	86aa                	mv	a3,a0
    23ee:	8626                	mv	a2,s1
    23f0:	85ce                	mv	a1,s3
    23f2:	00004517          	auipc	a0,0x4
    23f6:	ede50513          	addi	a0,a0,-290 # 62d0 <malloc+0xeec>
    23fa:	733020ef          	jal	532c <printf>
    exit(1);
    23fe:	4505                	li	a0,1
    2400:	30d020ef          	jal	4f0c <exit>
    printf("%s: sbrk re-allocation failed, a %p c %p\n", s, a, c);
    2404:	86d2                	mv	a3,s4
    2406:	8626                	mv	a2,s1
    2408:	85ce                	mv	a1,s3
    240a:	00004517          	auipc	a0,0x4
    240e:	f0650513          	addi	a0,a0,-250 # 6310 <malloc+0xf2c>
    2412:	71b020ef          	jal	532c <printf>
    exit(1);
    2416:	4505                	li	a0,1
    2418:	2f5020ef          	jal	4f0c <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    241c:	85ce                	mv	a1,s3
    241e:	00004517          	auipc	a0,0x4
    2422:	f2250513          	addi	a0,a0,-222 # 6340 <malloc+0xf5c>
    2426:	707020ef          	jal	532c <printf>
    exit(1);
    242a:	4505                	li	a0,1
    242c:	2e1020ef          	jal	4f0c <exit>
    printf("%s: sbrk downsize failed, a %p c %p\n", s, a, c);
    2430:	86aa                	mv	a3,a0
    2432:	8626                	mv	a2,s1
    2434:	85ce                	mv	a1,s3
    2436:	00004517          	auipc	a0,0x4
    243a:	f4250513          	addi	a0,a0,-190 # 6378 <malloc+0xf94>
    243e:	6ef020ef          	jal	532c <printf>
    exit(1);
    2442:	4505                	li	a0,1
    2444:	2c9020ef          	jal	4f0c <exit>

0000000000002448 <sbrkarg>:
{
    2448:	7179                	addi	sp,sp,-48
    244a:	f406                	sd	ra,40(sp)
    244c:	f022                	sd	s0,32(sp)
    244e:	ec26                	sd	s1,24(sp)
    2450:	e84a                	sd	s2,16(sp)
    2452:	e44e                	sd	s3,8(sp)
    2454:	1800                	addi	s0,sp,48
    2456:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2458:	6505                	lui	a0,0x1
    245a:	27f020ef          	jal	4ed8 <sbrk>
    245e:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2460:	20100593          	li	a1,513
    2464:	00004517          	auipc	a0,0x4
    2468:	f3c50513          	addi	a0,a0,-196 # 63a0 <malloc+0xfbc>
    246c:	2e1020ef          	jal	4f4c <open>
    2470:	84aa                	mv	s1,a0
  unlink("sbrk");
    2472:	00004517          	auipc	a0,0x4
    2476:	f2e50513          	addi	a0,a0,-210 # 63a0 <malloc+0xfbc>
    247a:	2e3020ef          	jal	4f5c <unlink>
  if(fd < 0)  {
    247e:	0204c963          	bltz	s1,24b0 <sbrkarg+0x68>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2482:	6605                	lui	a2,0x1
    2484:	85ca                	mv	a1,s2
    2486:	8526                	mv	a0,s1
    2488:	2a5020ef          	jal	4f2c <write>
    248c:	02054c63          	bltz	a0,24c4 <sbrkarg+0x7c>
  close(fd);
    2490:	8526                	mv	a0,s1
    2492:	2a3020ef          	jal	4f34 <close>
  a = sbrk(PGSIZE);
    2496:	6505                	lui	a0,0x1
    2498:	241020ef          	jal	4ed8 <sbrk>
  if(pipe((int *) a) != 0){
    249c:	281020ef          	jal	4f1c <pipe>
    24a0:	ed05                	bnez	a0,24d8 <sbrkarg+0x90>
}
    24a2:	70a2                	ld	ra,40(sp)
    24a4:	7402                	ld	s0,32(sp)
    24a6:	64e2                	ld	s1,24(sp)
    24a8:	6942                	ld	s2,16(sp)
    24aa:	69a2                	ld	s3,8(sp)
    24ac:	6145                	addi	sp,sp,48
    24ae:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    24b0:	85ce                	mv	a1,s3
    24b2:	00004517          	auipc	a0,0x4
    24b6:	ef650513          	addi	a0,a0,-266 # 63a8 <malloc+0xfc4>
    24ba:	673020ef          	jal	532c <printf>
    exit(1);
    24be:	4505                	li	a0,1
    24c0:	24d020ef          	jal	4f0c <exit>
    printf("%s: write sbrk failed\n", s);
    24c4:	85ce                	mv	a1,s3
    24c6:	00004517          	auipc	a0,0x4
    24ca:	efa50513          	addi	a0,a0,-262 # 63c0 <malloc+0xfdc>
    24ce:	65f020ef          	jal	532c <printf>
    exit(1);
    24d2:	4505                	li	a0,1
    24d4:	239020ef          	jal	4f0c <exit>
    printf("%s: pipe() failed\n", s);
    24d8:	85ce                	mv	a1,s3
    24da:	00004517          	auipc	a0,0x4
    24de:	9d650513          	addi	a0,a0,-1578 # 5eb0 <malloc+0xacc>
    24e2:	64b020ef          	jal	532c <printf>
    exit(1);
    24e6:	4505                	li	a0,1
    24e8:	225020ef          	jal	4f0c <exit>

00000000000024ec <argptest>:
{
    24ec:	1101                	addi	sp,sp,-32
    24ee:	ec06                	sd	ra,24(sp)
    24f0:	e822                	sd	s0,16(sp)
    24f2:	e426                	sd	s1,8(sp)
    24f4:	e04a                	sd	s2,0(sp)
    24f6:	1000                	addi	s0,sp,32
    24f8:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    24fa:	4581                	li	a1,0
    24fc:	00004517          	auipc	a0,0x4
    2500:	edc50513          	addi	a0,a0,-292 # 63d8 <malloc+0xff4>
    2504:	249020ef          	jal	4f4c <open>
  if (fd < 0) {
    2508:	02054563          	bltz	a0,2532 <argptest+0x46>
    250c:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    250e:	4501                	li	a0,0
    2510:	1c9020ef          	jal	4ed8 <sbrk>
    2514:	567d                	li	a2,-1
    2516:	00c505b3          	add	a1,a0,a2
    251a:	8526                	mv	a0,s1
    251c:	209020ef          	jal	4f24 <read>
  close(fd);
    2520:	8526                	mv	a0,s1
    2522:	213020ef          	jal	4f34 <close>
}
    2526:	60e2                	ld	ra,24(sp)
    2528:	6442                	ld	s0,16(sp)
    252a:	64a2                	ld	s1,8(sp)
    252c:	6902                	ld	s2,0(sp)
    252e:	6105                	addi	sp,sp,32
    2530:	8082                	ret
    printf("%s: open failed\n", s);
    2532:	85ca                	mv	a1,s2
    2534:	00004517          	auipc	a0,0x4
    2538:	88c50513          	addi	a0,a0,-1908 # 5dc0 <malloc+0x9dc>
    253c:	5f1020ef          	jal	532c <printf>
    exit(1);
    2540:	4505                	li	a0,1
    2542:	1cb020ef          	jal	4f0c <exit>

0000000000002546 <sbrkbugs>:
{
    2546:	1141                	addi	sp,sp,-16
    2548:	e406                	sd	ra,8(sp)
    254a:	e022                	sd	s0,0(sp)
    254c:	0800                	addi	s0,sp,16
  int pid = fork();
    254e:	1b7020ef          	jal	4f04 <fork>
  if(pid < 0){
    2552:	00054c63          	bltz	a0,256a <sbrkbugs+0x24>
  if(pid == 0){
    2556:	e11d                	bnez	a0,257c <sbrkbugs+0x36>
    int sz = (uint64) sbrk(0);
    2558:	181020ef          	jal	4ed8 <sbrk>
    sbrk(-sz);
    255c:	40a0053b          	negw	a0,a0
    2560:	179020ef          	jal	4ed8 <sbrk>
    exit(0);
    2564:	4501                	li	a0,0
    2566:	1a7020ef          	jal	4f0c <exit>
    printf("fork failed\n");
    256a:	00005517          	auipc	a0,0x5
    256e:	de650513          	addi	a0,a0,-538 # 7350 <malloc+0x1f6c>
    2572:	5bb020ef          	jal	532c <printf>
    exit(1);
    2576:	4505                	li	a0,1
    2578:	195020ef          	jal	4f0c <exit>
  wait(0);
    257c:	4501                	li	a0,0
    257e:	197020ef          	jal	4f14 <wait>
  pid = fork();
    2582:	183020ef          	jal	4f04 <fork>
  if(pid < 0){
    2586:	00054f63          	bltz	a0,25a4 <sbrkbugs+0x5e>
  if(pid == 0){
    258a:	e515                	bnez	a0,25b6 <sbrkbugs+0x70>
    int sz = (uint64) sbrk(0);
    258c:	14d020ef          	jal	4ed8 <sbrk>
    sbrk(-(sz - 3500));
    2590:	6785                	lui	a5,0x1
    2592:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0xe0>
    2596:	40a7853b          	subw	a0,a5,a0
    259a:	13f020ef          	jal	4ed8 <sbrk>
    exit(0);
    259e:	4501                	li	a0,0
    25a0:	16d020ef          	jal	4f0c <exit>
    printf("fork failed\n");
    25a4:	00005517          	auipc	a0,0x5
    25a8:	dac50513          	addi	a0,a0,-596 # 7350 <malloc+0x1f6c>
    25ac:	581020ef          	jal	532c <printf>
    exit(1);
    25b0:	4505                	li	a0,1
    25b2:	15b020ef          	jal	4f0c <exit>
  wait(0);
    25b6:	4501                	li	a0,0
    25b8:	15d020ef          	jal	4f14 <wait>
  pid = fork();
    25bc:	149020ef          	jal	4f04 <fork>
  if(pid < 0){
    25c0:	02054263          	bltz	a0,25e4 <sbrkbugs+0x9e>
  if(pid == 0){
    25c4:	e90d                	bnez	a0,25f6 <sbrkbugs+0xb0>
    sbrk((10*PGSIZE + 2048) - (uint64)sbrk(0));
    25c6:	113020ef          	jal	4ed8 <sbrk>
    25ca:	67ad                	lui	a5,0xb
    25cc:	8007879b          	addiw	a5,a5,-2048 # a800 <big.0+0x270>
    25d0:	40a7853b          	subw	a0,a5,a0
    25d4:	105020ef          	jal	4ed8 <sbrk>
    sbrk(-10);
    25d8:	5559                	li	a0,-10
    25da:	0ff020ef          	jal	4ed8 <sbrk>
    exit(0);
    25de:	4501                	li	a0,0
    25e0:	12d020ef          	jal	4f0c <exit>
    printf("fork failed\n");
    25e4:	00005517          	auipc	a0,0x5
    25e8:	d6c50513          	addi	a0,a0,-660 # 7350 <malloc+0x1f6c>
    25ec:	541020ef          	jal	532c <printf>
    exit(1);
    25f0:	4505                	li	a0,1
    25f2:	11b020ef          	jal	4f0c <exit>
  wait(0);
    25f6:	4501                	li	a0,0
    25f8:	11d020ef          	jal	4f14 <wait>
  exit(0);
    25fc:	4501                	li	a0,0
    25fe:	10f020ef          	jal	4f0c <exit>

0000000000002602 <sbrklast>:
{
    2602:	7179                	addi	sp,sp,-48
    2604:	f406                	sd	ra,40(sp)
    2606:	f022                	sd	s0,32(sp)
    2608:	ec26                	sd	s1,24(sp)
    260a:	e84a                	sd	s2,16(sp)
    260c:	e44e                	sd	s3,8(sp)
    260e:	e052                	sd	s4,0(sp)
    2610:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2612:	4501                	li	a0,0
    2614:	0c5020ef          	jal	4ed8 <sbrk>
  if((top % PGSIZE) != 0)
    2618:	03451793          	slli	a5,a0,0x34
    261c:	ebad                	bnez	a5,268e <sbrklast+0x8c>
  sbrk(PGSIZE);
    261e:	6505                	lui	a0,0x1
    2620:	0b9020ef          	jal	4ed8 <sbrk>
  sbrk(10);
    2624:	4529                	li	a0,10
    2626:	0b3020ef          	jal	4ed8 <sbrk>
  sbrk(-20);
    262a:	5531                	li	a0,-20
    262c:	0ad020ef          	jal	4ed8 <sbrk>
  top = (uint64) sbrk(0);
    2630:	4501                	li	a0,0
    2632:	0a7020ef          	jal	4ed8 <sbrk>
    2636:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2638:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0xca>
  p[0] = 'x';
    263c:	07800a13          	li	s4,120
    2640:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2644:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2648:	20200593          	li	a1,514
    264c:	854a                	mv	a0,s2
    264e:	0ff020ef          	jal	4f4c <open>
    2652:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2654:	4605                	li	a2,1
    2656:	85ca                	mv	a1,s2
    2658:	0d5020ef          	jal	4f2c <write>
  close(fd);
    265c:	854e                	mv	a0,s3
    265e:	0d7020ef          	jal	4f34 <close>
  fd = open(p, O_RDWR);
    2662:	4589                	li	a1,2
    2664:	854a                	mv	a0,s2
    2666:	0e7020ef          	jal	4f4c <open>
  p[0] = '\0';
    266a:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    266e:	4605                	li	a2,1
    2670:	85ca                	mv	a1,s2
    2672:	0b3020ef          	jal	4f24 <read>
  if(p[0] != 'x')
    2676:	fc04c783          	lbu	a5,-64(s1)
    267a:	03479363          	bne	a5,s4,26a0 <sbrklast+0x9e>
}
    267e:	70a2                	ld	ra,40(sp)
    2680:	7402                	ld	s0,32(sp)
    2682:	64e2                	ld	s1,24(sp)
    2684:	6942                	ld	s2,16(sp)
    2686:	69a2                	ld	s3,8(sp)
    2688:	6a02                	ld	s4,0(sp)
    268a:	6145                	addi	sp,sp,48
    268c:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    268e:	6785                	lui	a5,0x1
    2690:	fff78713          	addi	a4,a5,-1 # fff <bigdir+0x109>
    2694:	8d79                	and	a0,a0,a4
    2696:	40a7853b          	subw	a0,a5,a0
    269a:	03f020ef          	jal	4ed8 <sbrk>
    269e:	b741                	j	261e <sbrklast+0x1c>
    exit(1);
    26a0:	4505                	li	a0,1
    26a2:	06b020ef          	jal	4f0c <exit>

00000000000026a6 <sbrk8000>:
{
    26a6:	1141                	addi	sp,sp,-16
    26a8:	e406                	sd	ra,8(sp)
    26aa:	e022                	sd	s0,0(sp)
    26ac:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    26ae:	80000537          	lui	a0,0x80000
    26b2:	0511                	addi	a0,a0,4 # ffffffff80000004 <base+0xffffffff7ffef35c>
    26b4:	025020ef          	jal	4ed8 <sbrk>
  volatile char *top = sbrk(0);
    26b8:	4501                	li	a0,0
    26ba:	01f020ef          	jal	4ed8 <sbrk>
  *(top-1) = *(top-1) + 1;
    26be:	fff54783          	lbu	a5,-1(a0)
    26c2:	0785                	addi	a5,a5,1
    26c4:	0ff7f793          	zext.b	a5,a5
    26c8:	fef50fa3          	sb	a5,-1(a0)
}
    26cc:	60a2                	ld	ra,8(sp)
    26ce:	6402                	ld	s0,0(sp)
    26d0:	0141                	addi	sp,sp,16
    26d2:	8082                	ret

00000000000026d4 <execout>:
{
    26d4:	711d                	addi	sp,sp,-96
    26d6:	ec86                	sd	ra,88(sp)
    26d8:	e8a2                	sd	s0,80(sp)
    26da:	e4a6                	sd	s1,72(sp)
    26dc:	e0ca                	sd	s2,64(sp)
    26de:	fc4e                	sd	s3,56(sp)
    26e0:	1080                	addi	s0,sp,96
  for(int avail = 0; avail < 15; avail++){
    26e2:	4901                	li	s2,0
    26e4:	49bd                	li	s3,15
    int pid = fork();
    26e6:	01f020ef          	jal	4f04 <fork>
    26ea:	84aa                	mv	s1,a0
    if(pid < 0){
    26ec:	00054e63          	bltz	a0,2708 <execout+0x34>
    } else if(pid == 0){
    26f0:	c51d                	beqz	a0,271e <execout+0x4a>
      wait((int*)0);
    26f2:	4501                	li	a0,0
    26f4:	021020ef          	jal	4f14 <wait>
  for(int avail = 0; avail < 15; avail++){
    26f8:	2905                	addiw	s2,s2,1
    26fa:	ff3916e3          	bne	s2,s3,26e6 <execout+0x12>
    26fe:	f852                	sd	s4,48(sp)
    2700:	f456                	sd	s5,40(sp)
  exit(0);
    2702:	4501                	li	a0,0
    2704:	009020ef          	jal	4f0c <exit>
    2708:	f852                	sd	s4,48(sp)
    270a:	f456                	sd	s5,40(sp)
      printf("fork failed\n");
    270c:	00005517          	auipc	a0,0x5
    2710:	c4450513          	addi	a0,a0,-956 # 7350 <malloc+0x1f6c>
    2714:	419020ef          	jal	532c <printf>
      exit(1);
    2718:	4505                	li	a0,1
    271a:	7f2020ef          	jal	4f0c <exit>
    271e:	f852                	sd	s4,48(sp)
    2720:	f456                	sd	s5,40(sp)
        char *a = sbrk(PGSIZE);
    2722:	6985                	lui	s3,0x1
        if(a == SBRK_ERROR)
    2724:	5a7d                	li	s4,-1
        *(a + PGSIZE - 1) = 1;
    2726:	4a85                	li	s5,1
        char *a = sbrk(PGSIZE);
    2728:	854e                	mv	a0,s3
    272a:	7ae020ef          	jal	4ed8 <sbrk>
        if(a == SBRK_ERROR)
    272e:	01450663          	beq	a0,s4,273a <execout+0x66>
        *(a + PGSIZE - 1) = 1;
    2732:	954e                	add	a0,a0,s3
    2734:	ff550fa3          	sb	s5,-1(a0)
      while(1){
    2738:	bfc5                	j	2728 <execout+0x54>
        sbrk(-PGSIZE);
    273a:	79fd                	lui	s3,0xfffff
      for(int i = 0; i < avail; i++)
    273c:	01205863          	blez	s2,274c <execout+0x78>
        sbrk(-PGSIZE);
    2740:	854e                	mv	a0,s3
    2742:	796020ef          	jal	4ed8 <sbrk>
      for(int i = 0; i < avail; i++)
    2746:	2485                	addiw	s1,s1,1
    2748:	ff249ce3          	bne	s1,s2,2740 <execout+0x6c>
      close(1);
    274c:	4505                	li	a0,1
    274e:	7e6020ef          	jal	4f34 <close>
      char *args[] = { "echo", "x", 0 };
    2752:	00003517          	auipc	a0,0x3
    2756:	dc650513          	addi	a0,a0,-570 # 5518 <malloc+0x134>
    275a:	faa43423          	sd	a0,-88(s0)
    275e:	00003797          	auipc	a5,0x3
    2762:	e2a78793          	addi	a5,a5,-470 # 5588 <malloc+0x1a4>
    2766:	faf43823          	sd	a5,-80(s0)
    276a:	fa043c23          	sd	zero,-72(s0)
      exec("echo", args);
    276e:	fa840593          	addi	a1,s0,-88
    2772:	7d2020ef          	jal	4f44 <exec>
      exit(0);
    2776:	4501                	li	a0,0
    2778:	794020ef          	jal	4f0c <exit>

000000000000277c <fourteen>:
{
    277c:	1101                	addi	sp,sp,-32
    277e:	ec06                	sd	ra,24(sp)
    2780:	e822                	sd	s0,16(sp)
    2782:	e426                	sd	s1,8(sp)
    2784:	1000                	addi	s0,sp,32
    2786:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2788:	00004517          	auipc	a0,0x4
    278c:	e2850513          	addi	a0,a0,-472 # 65b0 <malloc+0x11cc>
    2790:	7e4020ef          	jal	4f74 <mkdir>
    2794:	e555                	bnez	a0,2840 <fourteen+0xc4>
  if(mkdir("12345678901234/123456789012345") != 0){
    2796:	00004517          	auipc	a0,0x4
    279a:	c7250513          	addi	a0,a0,-910 # 6408 <malloc+0x1024>
    279e:	7d6020ef          	jal	4f74 <mkdir>
    27a2:	e94d                	bnez	a0,2854 <fourteen+0xd8>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    27a4:	20000593          	li	a1,512
    27a8:	00004517          	auipc	a0,0x4
    27ac:	cb850513          	addi	a0,a0,-840 # 6460 <malloc+0x107c>
    27b0:	79c020ef          	jal	4f4c <open>
  if(fd < 0){
    27b4:	0a054a63          	bltz	a0,2868 <fourteen+0xec>
  close(fd);
    27b8:	77c020ef          	jal	4f34 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27bc:	4581                	li	a1,0
    27be:	00004517          	auipc	a0,0x4
    27c2:	d1a50513          	addi	a0,a0,-742 # 64d8 <malloc+0x10f4>
    27c6:	786020ef          	jal	4f4c <open>
  if(fd < 0){
    27ca:	0a054963          	bltz	a0,287c <fourteen+0x100>
  close(fd);
    27ce:	766020ef          	jal	4f34 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    27d2:	00004517          	auipc	a0,0x4
    27d6:	d7650513          	addi	a0,a0,-650 # 6548 <malloc+0x1164>
    27da:	79a020ef          	jal	4f74 <mkdir>
    27de:	c94d                	beqz	a0,2890 <fourteen+0x114>
  if(mkdir("123456789012345/12345678901234") == 0){
    27e0:	00004517          	auipc	a0,0x4
    27e4:	dc050513          	addi	a0,a0,-576 # 65a0 <malloc+0x11bc>
    27e8:	78c020ef          	jal	4f74 <mkdir>
    27ec:	cd45                	beqz	a0,28a4 <fourteen+0x128>
  unlink("123456789012345/12345678901234");
    27ee:	00004517          	auipc	a0,0x4
    27f2:	db250513          	addi	a0,a0,-590 # 65a0 <malloc+0x11bc>
    27f6:	766020ef          	jal	4f5c <unlink>
  unlink("12345678901234/12345678901234");
    27fa:	00004517          	auipc	a0,0x4
    27fe:	d4e50513          	addi	a0,a0,-690 # 6548 <malloc+0x1164>
    2802:	75a020ef          	jal	4f5c <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2806:	00004517          	auipc	a0,0x4
    280a:	cd250513          	addi	a0,a0,-814 # 64d8 <malloc+0x10f4>
    280e:	74e020ef          	jal	4f5c <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2812:	00004517          	auipc	a0,0x4
    2816:	c4e50513          	addi	a0,a0,-946 # 6460 <malloc+0x107c>
    281a:	742020ef          	jal	4f5c <unlink>
  unlink("12345678901234/123456789012345");
    281e:	00004517          	auipc	a0,0x4
    2822:	bea50513          	addi	a0,a0,-1046 # 6408 <malloc+0x1024>
    2826:	736020ef          	jal	4f5c <unlink>
  unlink("12345678901234");
    282a:	00004517          	auipc	a0,0x4
    282e:	d8650513          	addi	a0,a0,-634 # 65b0 <malloc+0x11cc>
    2832:	72a020ef          	jal	4f5c <unlink>
}
    2836:	60e2                	ld	ra,24(sp)
    2838:	6442                	ld	s0,16(sp)
    283a:	64a2                	ld	s1,8(sp)
    283c:	6105                	addi	sp,sp,32
    283e:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2840:	85a6                	mv	a1,s1
    2842:	00004517          	auipc	a0,0x4
    2846:	b9e50513          	addi	a0,a0,-1122 # 63e0 <malloc+0xffc>
    284a:	2e3020ef          	jal	532c <printf>
    exit(1);
    284e:	4505                	li	a0,1
    2850:	6bc020ef          	jal	4f0c <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2854:	85a6                	mv	a1,s1
    2856:	00004517          	auipc	a0,0x4
    285a:	bd250513          	addi	a0,a0,-1070 # 6428 <malloc+0x1044>
    285e:	2cf020ef          	jal	532c <printf>
    exit(1);
    2862:	4505                	li	a0,1
    2864:	6a8020ef          	jal	4f0c <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2868:	85a6                	mv	a1,s1
    286a:	00004517          	auipc	a0,0x4
    286e:	c2650513          	addi	a0,a0,-986 # 6490 <malloc+0x10ac>
    2872:	2bb020ef          	jal	532c <printf>
    exit(1);
    2876:	4505                	li	a0,1
    2878:	694020ef          	jal	4f0c <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    287c:	85a6                	mv	a1,s1
    287e:	00004517          	auipc	a0,0x4
    2882:	c8a50513          	addi	a0,a0,-886 # 6508 <malloc+0x1124>
    2886:	2a7020ef          	jal	532c <printf>
    exit(1);
    288a:	4505                	li	a0,1
    288c:	680020ef          	jal	4f0c <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2890:	85a6                	mv	a1,s1
    2892:	00004517          	auipc	a0,0x4
    2896:	cd650513          	addi	a0,a0,-810 # 6568 <malloc+0x1184>
    289a:	293020ef          	jal	532c <printf>
    exit(1);
    289e:	4505                	li	a0,1
    28a0:	66c020ef          	jal	4f0c <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    28a4:	85a6                	mv	a1,s1
    28a6:	00004517          	auipc	a0,0x4
    28aa:	d1a50513          	addi	a0,a0,-742 # 65c0 <malloc+0x11dc>
    28ae:	27f020ef          	jal	532c <printf>
    exit(1);
    28b2:	4505                	li	a0,1
    28b4:	658020ef          	jal	4f0c <exit>

00000000000028b8 <diskfull>:
{
    28b8:	b6010113          	addi	sp,sp,-1184
    28bc:	48113c23          	sd	ra,1176(sp)
    28c0:	48813823          	sd	s0,1168(sp)
    28c4:	48913423          	sd	s1,1160(sp)
    28c8:	49213023          	sd	s2,1152(sp)
    28cc:	47313c23          	sd	s3,1144(sp)
    28d0:	47413823          	sd	s4,1136(sp)
    28d4:	47513423          	sd	s5,1128(sp)
    28d8:	47613023          	sd	s6,1120(sp)
    28dc:	45713c23          	sd	s7,1112(sp)
    28e0:	45813823          	sd	s8,1104(sp)
    28e4:	45913423          	sd	s9,1096(sp)
    28e8:	45a13023          	sd	s10,1088(sp)
    28ec:	43b13c23          	sd	s11,1080(sp)
    28f0:	4a010413          	addi	s0,sp,1184
    28f4:	b6a43423          	sd	a0,-1176(s0)
  unlink("diskfulldir");
    28f8:	00004517          	auipc	a0,0x4
    28fc:	d0050513          	addi	a0,a0,-768 # 65f8 <malloc+0x1214>
    2900:	65c020ef          	jal	4f5c <unlink>
    2904:	03000a93          	li	s5,48
    name[0] = 'b';
    2908:	06200d13          	li	s10,98
    name[1] = 'i';
    290c:	06900c93          	li	s9,105
    name[2] = 'g';
    2910:	06700c13          	li	s8,103
    unlink(name);
    2914:	b7040b13          	addi	s6,s0,-1168
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2918:	60200b93          	li	s7,1538
    291c:	10c00d93          	li	s11,268
      if(write(fd, buf, BSIZE) != BSIZE){
    2920:	b9040a13          	addi	s4,s0,-1136
    2924:	aa8d                	j	2a96 <diskfull+0x1de>
      printf("%s: could not create file %s\n", s, name);
    2926:	b7040613          	addi	a2,s0,-1168
    292a:	b6843583          	ld	a1,-1176(s0)
    292e:	00004517          	auipc	a0,0x4
    2932:	cda50513          	addi	a0,a0,-806 # 6608 <malloc+0x1224>
    2936:	1f7020ef          	jal	532c <printf>
      break;
    293a:	a039                	j	2948 <diskfull+0x90>
        close(fd);
    293c:	854e                	mv	a0,s3
    293e:	5f6020ef          	jal	4f34 <close>
    close(fd);
    2942:	854e                	mv	a0,s3
    2944:	5f0020ef          	jal	4f34 <close>
  for(int i = 0; i < nzz; i++){
    2948:	4481                	li	s1,0
    name[0] = 'z';
    294a:	07a00993          	li	s3,122
    unlink(name);
    294e:	b9040913          	addi	s2,s0,-1136
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2952:	60200a13          	li	s4,1538
  for(int i = 0; i < nzz; i++){
    2956:	08000a93          	li	s5,128
    name[0] = 'z';
    295a:	b9340823          	sb	s3,-1136(s0)
    name[1] = 'z';
    295e:	b93408a3          	sb	s3,-1135(s0)
    name[2] = '0' + (i / 32);
    2962:	41f4d71b          	sraiw	a4,s1,0x1f
    2966:	01b7571b          	srliw	a4,a4,0x1b
    296a:	009707bb          	addw	a5,a4,s1
    296e:	4057d69b          	sraiw	a3,a5,0x5
    2972:	0306869b          	addiw	a3,a3,48
    2976:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    297a:	8bfd                	andi	a5,a5,31
    297c:	9f99                	subw	a5,a5,a4
    297e:	0307879b          	addiw	a5,a5,48
    2982:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    2986:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    298a:	854a                	mv	a0,s2
    298c:	5d0020ef          	jal	4f5c <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2990:	85d2                	mv	a1,s4
    2992:	854a                	mv	a0,s2
    2994:	5b8020ef          	jal	4f4c <open>
    if(fd < 0)
    2998:	00054763          	bltz	a0,29a6 <diskfull+0xee>
    close(fd);
    299c:	598020ef          	jal	4f34 <close>
  for(int i = 0; i < nzz; i++){
    29a0:	2485                	addiw	s1,s1,1
    29a2:	fb549ce3          	bne	s1,s5,295a <diskfull+0xa2>
  if(mkdir("diskfulldir") == 0)
    29a6:	00004517          	auipc	a0,0x4
    29aa:	c5250513          	addi	a0,a0,-942 # 65f8 <malloc+0x1214>
    29ae:	5c6020ef          	jal	4f74 <mkdir>
    29b2:	12050363          	beqz	a0,2ad8 <diskfull+0x220>
  unlink("diskfulldir");
    29b6:	00004517          	auipc	a0,0x4
    29ba:	c4250513          	addi	a0,a0,-958 # 65f8 <malloc+0x1214>
    29be:	59e020ef          	jal	4f5c <unlink>
  for(int i = 0; i < nzz; i++){
    29c2:	4481                	li	s1,0
    name[0] = 'z';
    29c4:	07a00913          	li	s2,122
    unlink(name);
    29c8:	b9040a13          	addi	s4,s0,-1136
  for(int i = 0; i < nzz; i++){
    29cc:	08000993          	li	s3,128
    name[0] = 'z';
    29d0:	b9240823          	sb	s2,-1136(s0)
    name[1] = 'z';
    29d4:	b92408a3          	sb	s2,-1135(s0)
    name[2] = '0' + (i / 32);
    29d8:	41f4d71b          	sraiw	a4,s1,0x1f
    29dc:	01b7571b          	srliw	a4,a4,0x1b
    29e0:	009707bb          	addw	a5,a4,s1
    29e4:	4057d69b          	sraiw	a3,a5,0x5
    29e8:	0306869b          	addiw	a3,a3,48
    29ec:	b8d40923          	sb	a3,-1134(s0)
    name[3] = '0' + (i % 32);
    29f0:	8bfd                	andi	a5,a5,31
    29f2:	9f99                	subw	a5,a5,a4
    29f4:	0307879b          	addiw	a5,a5,48
    29f8:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    29fc:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a00:	8552                	mv	a0,s4
    2a02:	55a020ef          	jal	4f5c <unlink>
  for(int i = 0; i < nzz; i++){
    2a06:	2485                	addiw	s1,s1,1
    2a08:	fd3494e3          	bne	s1,s3,29d0 <diskfull+0x118>
    2a0c:	03000493          	li	s1,48
    name[0] = 'b';
    2a10:	06200b13          	li	s6,98
    name[1] = 'i';
    2a14:	06900a93          	li	s5,105
    name[2] = 'g';
    2a18:	06700a13          	li	s4,103
    unlink(name);
    2a1c:	b9040993          	addi	s3,s0,-1136
  for(int i = 0; '0' + i < 0177; i++){
    2a20:	07f00913          	li	s2,127
    name[0] = 'b';
    2a24:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    2a28:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    2a2c:	b9440923          	sb	s4,-1134(s0)
    name[3] = '0' + i;
    2a30:	b89409a3          	sb	s1,-1133(s0)
    name[4] = '\0';
    2a34:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    2a38:	854e                	mv	a0,s3
    2a3a:	522020ef          	jal	4f5c <unlink>
  for(int i = 0; '0' + i < 0177; i++){
    2a3e:	2485                	addiw	s1,s1,1
    2a40:	0ff4f493          	zext.b	s1,s1
    2a44:	ff2490e3          	bne	s1,s2,2a24 <diskfull+0x16c>
}
    2a48:	49813083          	ld	ra,1176(sp)
    2a4c:	49013403          	ld	s0,1168(sp)
    2a50:	48813483          	ld	s1,1160(sp)
    2a54:	48013903          	ld	s2,1152(sp)
    2a58:	47813983          	ld	s3,1144(sp)
    2a5c:	47013a03          	ld	s4,1136(sp)
    2a60:	46813a83          	ld	s5,1128(sp)
    2a64:	46013b03          	ld	s6,1120(sp)
    2a68:	45813b83          	ld	s7,1112(sp)
    2a6c:	45013c03          	ld	s8,1104(sp)
    2a70:	44813c83          	ld	s9,1096(sp)
    2a74:	44013d03          	ld	s10,1088(sp)
    2a78:	43813d83          	ld	s11,1080(sp)
    2a7c:	4a010113          	addi	sp,sp,1184
    2a80:	8082                	ret
    close(fd);
    2a82:	854e                	mv	a0,s3
    2a84:	4b0020ef          	jal	4f34 <close>
  for(fi = 0; done == 0 && '0' + fi < 0177; fi++){
    2a88:	2a85                	addiw	s5,s5,1
    2a8a:	0ffafa93          	zext.b	s5,s5
    2a8e:	07f00793          	li	a5,127
    2a92:	eafa8be3          	beq	s5,a5,2948 <diskfull+0x90>
    name[0] = 'b';
    2a96:	b7a40823          	sb	s10,-1168(s0)
    name[1] = 'i';
    2a9a:	b79408a3          	sb	s9,-1167(s0)
    name[2] = 'g';
    2a9e:	b7840923          	sb	s8,-1166(s0)
    name[3] = '0' + fi;
    2aa2:	b75409a3          	sb	s5,-1165(s0)
    name[4] = '\0';
    2aa6:	b6040a23          	sb	zero,-1164(s0)
    unlink(name);
    2aaa:	855a                	mv	a0,s6
    2aac:	4b0020ef          	jal	4f5c <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    2ab0:	85de                	mv	a1,s7
    2ab2:	855a                	mv	a0,s6
    2ab4:	498020ef          	jal	4f4c <open>
    2ab8:	89aa                	mv	s3,a0
    if(fd < 0){
    2aba:	e60546e3          	bltz	a0,2926 <diskfull+0x6e>
    2abe:	84ee                	mv	s1,s11
      if(write(fd, buf, BSIZE) != BSIZE){
    2ac0:	40000913          	li	s2,1024
    2ac4:	864a                	mv	a2,s2
    2ac6:	85d2                	mv	a1,s4
    2ac8:	854e                	mv	a0,s3
    2aca:	462020ef          	jal	4f2c <write>
    2ace:	e72517e3          	bne	a0,s2,293c <diskfull+0x84>
    for(int i = 0; i < MAXFILE; i++){
    2ad2:	34fd                	addiw	s1,s1,-1
    2ad4:	f8e5                	bnez	s1,2ac4 <diskfull+0x20c>
    2ad6:	b775                	j	2a82 <diskfull+0x1ca>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n", s);
    2ad8:	b6843583          	ld	a1,-1176(s0)
    2adc:	00004517          	auipc	a0,0x4
    2ae0:	b4c50513          	addi	a0,a0,-1204 # 6628 <malloc+0x1244>
    2ae4:	049020ef          	jal	532c <printf>
    2ae8:	b5f9                	j	29b6 <diskfull+0xfe>

0000000000002aea <iputtest>:
{
    2aea:	1101                	addi	sp,sp,-32
    2aec:	ec06                	sd	ra,24(sp)
    2aee:	e822                	sd	s0,16(sp)
    2af0:	e426                	sd	s1,8(sp)
    2af2:	1000                	addi	s0,sp,32
    2af4:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2af6:	00004517          	auipc	a0,0x4
    2afa:	b6250513          	addi	a0,a0,-1182 # 6658 <malloc+0x1274>
    2afe:	476020ef          	jal	4f74 <mkdir>
    2b02:	02054f63          	bltz	a0,2b40 <iputtest+0x56>
  if(chdir("iputdir") < 0){
    2b06:	00004517          	auipc	a0,0x4
    2b0a:	b5250513          	addi	a0,a0,-1198 # 6658 <malloc+0x1274>
    2b0e:	46e020ef          	jal	4f7c <chdir>
    2b12:	04054163          	bltz	a0,2b54 <iputtest+0x6a>
  if(unlink("../iputdir") < 0){
    2b16:	00004517          	auipc	a0,0x4
    2b1a:	b8250513          	addi	a0,a0,-1150 # 6698 <malloc+0x12b4>
    2b1e:	43e020ef          	jal	4f5c <unlink>
    2b22:	04054363          	bltz	a0,2b68 <iputtest+0x7e>
  if(chdir("/") < 0){
    2b26:	00004517          	auipc	a0,0x4
    2b2a:	ba250513          	addi	a0,a0,-1118 # 66c8 <malloc+0x12e4>
    2b2e:	44e020ef          	jal	4f7c <chdir>
    2b32:	04054563          	bltz	a0,2b7c <iputtest+0x92>
}
    2b36:	60e2                	ld	ra,24(sp)
    2b38:	6442                	ld	s0,16(sp)
    2b3a:	64a2                	ld	s1,8(sp)
    2b3c:	6105                	addi	sp,sp,32
    2b3e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2b40:	85a6                	mv	a1,s1
    2b42:	00004517          	auipc	a0,0x4
    2b46:	b1e50513          	addi	a0,a0,-1250 # 6660 <malloc+0x127c>
    2b4a:	7e2020ef          	jal	532c <printf>
    exit(1);
    2b4e:	4505                	li	a0,1
    2b50:	3bc020ef          	jal	4f0c <exit>
    printf("%s: chdir iputdir failed\n", s);
    2b54:	85a6                	mv	a1,s1
    2b56:	00004517          	auipc	a0,0x4
    2b5a:	b2250513          	addi	a0,a0,-1246 # 6678 <malloc+0x1294>
    2b5e:	7ce020ef          	jal	532c <printf>
    exit(1);
    2b62:	4505                	li	a0,1
    2b64:	3a8020ef          	jal	4f0c <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    2b68:	85a6                	mv	a1,s1
    2b6a:	00004517          	auipc	a0,0x4
    2b6e:	b3e50513          	addi	a0,a0,-1218 # 66a8 <malloc+0x12c4>
    2b72:	7ba020ef          	jal	532c <printf>
    exit(1);
    2b76:	4505                	li	a0,1
    2b78:	394020ef          	jal	4f0c <exit>
    printf("%s: chdir / failed\n", s);
    2b7c:	85a6                	mv	a1,s1
    2b7e:	00004517          	auipc	a0,0x4
    2b82:	b5250513          	addi	a0,a0,-1198 # 66d0 <malloc+0x12ec>
    2b86:	7a6020ef          	jal	532c <printf>
    exit(1);
    2b8a:	4505                	li	a0,1
    2b8c:	380020ef          	jal	4f0c <exit>

0000000000002b90 <exitiputtest>:
{
    2b90:	7179                	addi	sp,sp,-48
    2b92:	f406                	sd	ra,40(sp)
    2b94:	f022                	sd	s0,32(sp)
    2b96:	ec26                	sd	s1,24(sp)
    2b98:	1800                	addi	s0,sp,48
    2b9a:	84aa                	mv	s1,a0
  pid = fork();
    2b9c:	368020ef          	jal	4f04 <fork>
  if(pid < 0){
    2ba0:	02054e63          	bltz	a0,2bdc <exitiputtest+0x4c>
  if(pid == 0){
    2ba4:	e541                	bnez	a0,2c2c <exitiputtest+0x9c>
    if(mkdir("iputdir") < 0){
    2ba6:	00004517          	auipc	a0,0x4
    2baa:	ab250513          	addi	a0,a0,-1358 # 6658 <malloc+0x1274>
    2bae:	3c6020ef          	jal	4f74 <mkdir>
    2bb2:	02054f63          	bltz	a0,2bf0 <exitiputtest+0x60>
    if(chdir("iputdir") < 0){
    2bb6:	00004517          	auipc	a0,0x4
    2bba:	aa250513          	addi	a0,a0,-1374 # 6658 <malloc+0x1274>
    2bbe:	3be020ef          	jal	4f7c <chdir>
    2bc2:	04054163          	bltz	a0,2c04 <exitiputtest+0x74>
    if(unlink("../iputdir") < 0){
    2bc6:	00004517          	auipc	a0,0x4
    2bca:	ad250513          	addi	a0,a0,-1326 # 6698 <malloc+0x12b4>
    2bce:	38e020ef          	jal	4f5c <unlink>
    2bd2:	04054363          	bltz	a0,2c18 <exitiputtest+0x88>
    exit(0);
    2bd6:	4501                	li	a0,0
    2bd8:	334020ef          	jal	4f0c <exit>
    printf("%s: fork failed\n", s);
    2bdc:	85a6                	mv	a1,s1
    2bde:	00003517          	auipc	a0,0x3
    2be2:	1ca50513          	addi	a0,a0,458 # 5da8 <malloc+0x9c4>
    2be6:	746020ef          	jal	532c <printf>
    exit(1);
    2bea:	4505                	li	a0,1
    2bec:	320020ef          	jal	4f0c <exit>
      printf("%s: mkdir failed\n", s);
    2bf0:	85a6                	mv	a1,s1
    2bf2:	00004517          	auipc	a0,0x4
    2bf6:	a6e50513          	addi	a0,a0,-1426 # 6660 <malloc+0x127c>
    2bfa:	732020ef          	jal	532c <printf>
      exit(1);
    2bfe:	4505                	li	a0,1
    2c00:	30c020ef          	jal	4f0c <exit>
      printf("%s: child chdir failed\n", s);
    2c04:	85a6                	mv	a1,s1
    2c06:	00004517          	auipc	a0,0x4
    2c0a:	ae250513          	addi	a0,a0,-1310 # 66e8 <malloc+0x1304>
    2c0e:	71e020ef          	jal	532c <printf>
      exit(1);
    2c12:	4505                	li	a0,1
    2c14:	2f8020ef          	jal	4f0c <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    2c18:	85a6                	mv	a1,s1
    2c1a:	00004517          	auipc	a0,0x4
    2c1e:	a8e50513          	addi	a0,a0,-1394 # 66a8 <malloc+0x12c4>
    2c22:	70a020ef          	jal	532c <printf>
      exit(1);
    2c26:	4505                	li	a0,1
    2c28:	2e4020ef          	jal	4f0c <exit>
  wait(&xstatus);
    2c2c:	fdc40513          	addi	a0,s0,-36
    2c30:	2e4020ef          	jal	4f14 <wait>
  exit(xstatus);
    2c34:	fdc42503          	lw	a0,-36(s0)
    2c38:	2d4020ef          	jal	4f0c <exit>

0000000000002c3c <dirtest>:
{
    2c3c:	1101                	addi	sp,sp,-32
    2c3e:	ec06                	sd	ra,24(sp)
    2c40:	e822                	sd	s0,16(sp)
    2c42:	e426                	sd	s1,8(sp)
    2c44:	1000                	addi	s0,sp,32
    2c46:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    2c48:	00004517          	auipc	a0,0x4
    2c4c:	ab850513          	addi	a0,a0,-1352 # 6700 <malloc+0x131c>
    2c50:	324020ef          	jal	4f74 <mkdir>
    2c54:	02054f63          	bltz	a0,2c92 <dirtest+0x56>
  if(chdir("dir0") < 0){
    2c58:	00004517          	auipc	a0,0x4
    2c5c:	aa850513          	addi	a0,a0,-1368 # 6700 <malloc+0x131c>
    2c60:	31c020ef          	jal	4f7c <chdir>
    2c64:	04054163          	bltz	a0,2ca6 <dirtest+0x6a>
  if(chdir("..") < 0){
    2c68:	00004517          	auipc	a0,0x4
    2c6c:	ab850513          	addi	a0,a0,-1352 # 6720 <malloc+0x133c>
    2c70:	30c020ef          	jal	4f7c <chdir>
    2c74:	04054363          	bltz	a0,2cba <dirtest+0x7e>
  if(unlink("dir0") < 0){
    2c78:	00004517          	auipc	a0,0x4
    2c7c:	a8850513          	addi	a0,a0,-1400 # 6700 <malloc+0x131c>
    2c80:	2dc020ef          	jal	4f5c <unlink>
    2c84:	04054563          	bltz	a0,2cce <dirtest+0x92>
}
    2c88:	60e2                	ld	ra,24(sp)
    2c8a:	6442                	ld	s0,16(sp)
    2c8c:	64a2                	ld	s1,8(sp)
    2c8e:	6105                	addi	sp,sp,32
    2c90:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2c92:	85a6                	mv	a1,s1
    2c94:	00004517          	auipc	a0,0x4
    2c98:	9cc50513          	addi	a0,a0,-1588 # 6660 <malloc+0x127c>
    2c9c:	690020ef          	jal	532c <printf>
    exit(1);
    2ca0:	4505                	li	a0,1
    2ca2:	26a020ef          	jal	4f0c <exit>
    printf("%s: chdir dir0 failed\n", s);
    2ca6:	85a6                	mv	a1,s1
    2ca8:	00004517          	auipc	a0,0x4
    2cac:	a6050513          	addi	a0,a0,-1440 # 6708 <malloc+0x1324>
    2cb0:	67c020ef          	jal	532c <printf>
    exit(1);
    2cb4:	4505                	li	a0,1
    2cb6:	256020ef          	jal	4f0c <exit>
    printf("%s: chdir .. failed\n", s);
    2cba:	85a6                	mv	a1,s1
    2cbc:	00004517          	auipc	a0,0x4
    2cc0:	a6c50513          	addi	a0,a0,-1428 # 6728 <malloc+0x1344>
    2cc4:	668020ef          	jal	532c <printf>
    exit(1);
    2cc8:	4505                	li	a0,1
    2cca:	242020ef          	jal	4f0c <exit>
    printf("%s: unlink dir0 failed\n", s);
    2cce:	85a6                	mv	a1,s1
    2cd0:	00004517          	auipc	a0,0x4
    2cd4:	a7050513          	addi	a0,a0,-1424 # 6740 <malloc+0x135c>
    2cd8:	654020ef          	jal	532c <printf>
    exit(1);
    2cdc:	4505                	li	a0,1
    2cde:	22e020ef          	jal	4f0c <exit>

0000000000002ce2 <subdir>:
{
    2ce2:	1101                	addi	sp,sp,-32
    2ce4:	ec06                	sd	ra,24(sp)
    2ce6:	e822                	sd	s0,16(sp)
    2ce8:	e426                	sd	s1,8(sp)
    2cea:	e04a                	sd	s2,0(sp)
    2cec:	1000                	addi	s0,sp,32
    2cee:	892a                	mv	s2,a0
  unlink("ff");
    2cf0:	00004517          	auipc	a0,0x4
    2cf4:	b9850513          	addi	a0,a0,-1128 # 6888 <malloc+0x14a4>
    2cf8:	264020ef          	jal	4f5c <unlink>
  if(mkdir("dd") != 0){
    2cfc:	00004517          	auipc	a0,0x4
    2d00:	a5c50513          	addi	a0,a0,-1444 # 6758 <malloc+0x1374>
    2d04:	270020ef          	jal	4f74 <mkdir>
    2d08:	2e051263          	bnez	a0,2fec <subdir+0x30a>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    2d0c:	20200593          	li	a1,514
    2d10:	00004517          	auipc	a0,0x4
    2d14:	a6850513          	addi	a0,a0,-1432 # 6778 <malloc+0x1394>
    2d18:	234020ef          	jal	4f4c <open>
    2d1c:	84aa                	mv	s1,a0
  if(fd < 0){
    2d1e:	2e054163          	bltz	a0,3000 <subdir+0x31e>
  write(fd, "ff", 2);
    2d22:	4609                	li	a2,2
    2d24:	00004597          	auipc	a1,0x4
    2d28:	b6458593          	addi	a1,a1,-1180 # 6888 <malloc+0x14a4>
    2d2c:	200020ef          	jal	4f2c <write>
  close(fd);
    2d30:	8526                	mv	a0,s1
    2d32:	202020ef          	jal	4f34 <close>
  if(unlink("dd") >= 0){
    2d36:	00004517          	auipc	a0,0x4
    2d3a:	a2250513          	addi	a0,a0,-1502 # 6758 <malloc+0x1374>
    2d3e:	21e020ef          	jal	4f5c <unlink>
    2d42:	2c055963          	bgez	a0,3014 <subdir+0x332>
  if(mkdir("/dd/dd") != 0){
    2d46:	00004517          	auipc	a0,0x4
    2d4a:	a8a50513          	addi	a0,a0,-1398 # 67d0 <malloc+0x13ec>
    2d4e:	226020ef          	jal	4f74 <mkdir>
    2d52:	2c051b63          	bnez	a0,3028 <subdir+0x346>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2d56:	20200593          	li	a1,514
    2d5a:	00004517          	auipc	a0,0x4
    2d5e:	a9e50513          	addi	a0,a0,-1378 # 67f8 <malloc+0x1414>
    2d62:	1ea020ef          	jal	4f4c <open>
    2d66:	84aa                	mv	s1,a0
  if(fd < 0){
    2d68:	2c054a63          	bltz	a0,303c <subdir+0x35a>
  write(fd, "FF", 2);
    2d6c:	4609                	li	a2,2
    2d6e:	00004597          	auipc	a1,0x4
    2d72:	aba58593          	addi	a1,a1,-1350 # 6828 <malloc+0x1444>
    2d76:	1b6020ef          	jal	4f2c <write>
  close(fd);
    2d7a:	8526                	mv	a0,s1
    2d7c:	1b8020ef          	jal	4f34 <close>
  fd = open("dd/dd/../ff", 0);
    2d80:	4581                	li	a1,0
    2d82:	00004517          	auipc	a0,0x4
    2d86:	aae50513          	addi	a0,a0,-1362 # 6830 <malloc+0x144c>
    2d8a:	1c2020ef          	jal	4f4c <open>
    2d8e:	84aa                	mv	s1,a0
  if(fd < 0){
    2d90:	2c054063          	bltz	a0,3050 <subdir+0x36e>
  cc = read(fd, buf, sizeof(buf));
    2d94:	660d                	lui	a2,0x3
    2d96:	0000b597          	auipc	a1,0xb
    2d9a:	f1258593          	addi	a1,a1,-238 # dca8 <buf>
    2d9e:	186020ef          	jal	4f24 <read>
  if(cc != 2 || buf[0] != 'f'){
    2da2:	4789                	li	a5,2
    2da4:	2cf51063          	bne	a0,a5,3064 <subdir+0x382>
    2da8:	0000b717          	auipc	a4,0xb
    2dac:	f0074703          	lbu	a4,-256(a4) # dca8 <buf>
    2db0:	06600793          	li	a5,102
    2db4:	2af71863          	bne	a4,a5,3064 <subdir+0x382>
  close(fd);
    2db8:	8526                	mv	a0,s1
    2dba:	17a020ef          	jal	4f34 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2dbe:	00004597          	auipc	a1,0x4
    2dc2:	ac258593          	addi	a1,a1,-1342 # 6880 <malloc+0x149c>
    2dc6:	00004517          	auipc	a0,0x4
    2dca:	a3250513          	addi	a0,a0,-1486 # 67f8 <malloc+0x1414>
    2dce:	19e020ef          	jal	4f6c <link>
    2dd2:	2a051363          	bnez	a0,3078 <subdir+0x396>
  if(unlink("dd/dd/ff") != 0){
    2dd6:	00004517          	auipc	a0,0x4
    2dda:	a2250513          	addi	a0,a0,-1502 # 67f8 <malloc+0x1414>
    2dde:	17e020ef          	jal	4f5c <unlink>
    2de2:	2a051563          	bnez	a0,308c <subdir+0x3aa>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2de6:	4581                	li	a1,0
    2de8:	00004517          	auipc	a0,0x4
    2dec:	a1050513          	addi	a0,a0,-1520 # 67f8 <malloc+0x1414>
    2df0:	15c020ef          	jal	4f4c <open>
    2df4:	2a055663          	bgez	a0,30a0 <subdir+0x3be>
  if(chdir("dd") != 0){
    2df8:	00004517          	auipc	a0,0x4
    2dfc:	96050513          	addi	a0,a0,-1696 # 6758 <malloc+0x1374>
    2e00:	17c020ef          	jal	4f7c <chdir>
    2e04:	2a051863          	bnez	a0,30b4 <subdir+0x3d2>
  if(chdir("dd/../../dd") != 0){
    2e08:	00004517          	auipc	a0,0x4
    2e0c:	b1050513          	addi	a0,a0,-1264 # 6918 <malloc+0x1534>
    2e10:	16c020ef          	jal	4f7c <chdir>
    2e14:	2a051a63          	bnez	a0,30c8 <subdir+0x3e6>
  if(chdir("dd/../../../dd") != 0){
    2e18:	00004517          	auipc	a0,0x4
    2e1c:	b3050513          	addi	a0,a0,-1232 # 6948 <malloc+0x1564>
    2e20:	15c020ef          	jal	4f7c <chdir>
    2e24:	2a051c63          	bnez	a0,30dc <subdir+0x3fa>
  if(chdir("./..") != 0){
    2e28:	00004517          	auipc	a0,0x4
    2e2c:	b5850513          	addi	a0,a0,-1192 # 6980 <malloc+0x159c>
    2e30:	14c020ef          	jal	4f7c <chdir>
    2e34:	2a051e63          	bnez	a0,30f0 <subdir+0x40e>
  fd = open("dd/dd/ffff", 0);
    2e38:	4581                	li	a1,0
    2e3a:	00004517          	auipc	a0,0x4
    2e3e:	a4650513          	addi	a0,a0,-1466 # 6880 <malloc+0x149c>
    2e42:	10a020ef          	jal	4f4c <open>
    2e46:	84aa                	mv	s1,a0
  if(fd < 0){
    2e48:	2a054e63          	bltz	a0,3104 <subdir+0x422>
  if(read(fd, buf, sizeof(buf)) != 2){
    2e4c:	660d                	lui	a2,0x3
    2e4e:	0000b597          	auipc	a1,0xb
    2e52:	e5a58593          	addi	a1,a1,-422 # dca8 <buf>
    2e56:	0ce020ef          	jal	4f24 <read>
    2e5a:	4789                	li	a5,2
    2e5c:	2af51e63          	bne	a0,a5,3118 <subdir+0x436>
  close(fd);
    2e60:	8526                	mv	a0,s1
    2e62:	0d2020ef          	jal	4f34 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2e66:	4581                	li	a1,0
    2e68:	00004517          	auipc	a0,0x4
    2e6c:	99050513          	addi	a0,a0,-1648 # 67f8 <malloc+0x1414>
    2e70:	0dc020ef          	jal	4f4c <open>
    2e74:	2a055c63          	bgez	a0,312c <subdir+0x44a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2e78:	20200593          	li	a1,514
    2e7c:	00004517          	auipc	a0,0x4
    2e80:	b9450513          	addi	a0,a0,-1132 # 6a10 <malloc+0x162c>
    2e84:	0c8020ef          	jal	4f4c <open>
    2e88:	2a055c63          	bgez	a0,3140 <subdir+0x45e>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2e8c:	20200593          	li	a1,514
    2e90:	00004517          	auipc	a0,0x4
    2e94:	bb050513          	addi	a0,a0,-1104 # 6a40 <malloc+0x165c>
    2e98:	0b4020ef          	jal	4f4c <open>
    2e9c:	2a055c63          	bgez	a0,3154 <subdir+0x472>
  if(open("dd", O_CREATE) >= 0){
    2ea0:	20000593          	li	a1,512
    2ea4:	00004517          	auipc	a0,0x4
    2ea8:	8b450513          	addi	a0,a0,-1868 # 6758 <malloc+0x1374>
    2eac:	0a0020ef          	jal	4f4c <open>
    2eb0:	2a055c63          	bgez	a0,3168 <subdir+0x486>
  if(open("dd", O_RDWR) >= 0){
    2eb4:	4589                	li	a1,2
    2eb6:	00004517          	auipc	a0,0x4
    2eba:	8a250513          	addi	a0,a0,-1886 # 6758 <malloc+0x1374>
    2ebe:	08e020ef          	jal	4f4c <open>
    2ec2:	2a055d63          	bgez	a0,317c <subdir+0x49a>
  if(open("dd", O_WRONLY) >= 0){
    2ec6:	4585                	li	a1,1
    2ec8:	00004517          	auipc	a0,0x4
    2ecc:	89050513          	addi	a0,a0,-1904 # 6758 <malloc+0x1374>
    2ed0:	07c020ef          	jal	4f4c <open>
    2ed4:	2a055e63          	bgez	a0,3190 <subdir+0x4ae>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2ed8:	00004597          	auipc	a1,0x4
    2edc:	bf858593          	addi	a1,a1,-1032 # 6ad0 <malloc+0x16ec>
    2ee0:	00004517          	auipc	a0,0x4
    2ee4:	b3050513          	addi	a0,a0,-1232 # 6a10 <malloc+0x162c>
    2ee8:	084020ef          	jal	4f6c <link>
    2eec:	2a050c63          	beqz	a0,31a4 <subdir+0x4c2>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2ef0:	00004597          	auipc	a1,0x4
    2ef4:	be058593          	addi	a1,a1,-1056 # 6ad0 <malloc+0x16ec>
    2ef8:	00004517          	auipc	a0,0x4
    2efc:	b4850513          	addi	a0,a0,-1208 # 6a40 <malloc+0x165c>
    2f00:	06c020ef          	jal	4f6c <link>
    2f04:	2a050a63          	beqz	a0,31b8 <subdir+0x4d6>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2f08:	00004597          	auipc	a1,0x4
    2f0c:	97858593          	addi	a1,a1,-1672 # 6880 <malloc+0x149c>
    2f10:	00004517          	auipc	a0,0x4
    2f14:	86850513          	addi	a0,a0,-1944 # 6778 <malloc+0x1394>
    2f18:	054020ef          	jal	4f6c <link>
    2f1c:	2a050863          	beqz	a0,31cc <subdir+0x4ea>
  if(mkdir("dd/ff/ff") == 0){
    2f20:	00004517          	auipc	a0,0x4
    2f24:	af050513          	addi	a0,a0,-1296 # 6a10 <malloc+0x162c>
    2f28:	04c020ef          	jal	4f74 <mkdir>
    2f2c:	2a050a63          	beqz	a0,31e0 <subdir+0x4fe>
  if(mkdir("dd/xx/ff") == 0){
    2f30:	00004517          	auipc	a0,0x4
    2f34:	b1050513          	addi	a0,a0,-1264 # 6a40 <malloc+0x165c>
    2f38:	03c020ef          	jal	4f74 <mkdir>
    2f3c:	2a050c63          	beqz	a0,31f4 <subdir+0x512>
  if(mkdir("dd/dd/ffff") == 0){
    2f40:	00004517          	auipc	a0,0x4
    2f44:	94050513          	addi	a0,a0,-1728 # 6880 <malloc+0x149c>
    2f48:	02c020ef          	jal	4f74 <mkdir>
    2f4c:	2a050e63          	beqz	a0,3208 <subdir+0x526>
  if(unlink("dd/xx/ff") == 0){
    2f50:	00004517          	auipc	a0,0x4
    2f54:	af050513          	addi	a0,a0,-1296 # 6a40 <malloc+0x165c>
    2f58:	004020ef          	jal	4f5c <unlink>
    2f5c:	2c050063          	beqz	a0,321c <subdir+0x53a>
  if(unlink("dd/ff/ff") == 0){
    2f60:	00004517          	auipc	a0,0x4
    2f64:	ab050513          	addi	a0,a0,-1360 # 6a10 <malloc+0x162c>
    2f68:	7f5010ef          	jal	4f5c <unlink>
    2f6c:	2c050263          	beqz	a0,3230 <subdir+0x54e>
  if(chdir("dd/ff") == 0){
    2f70:	00004517          	auipc	a0,0x4
    2f74:	80850513          	addi	a0,a0,-2040 # 6778 <malloc+0x1394>
    2f78:	004020ef          	jal	4f7c <chdir>
    2f7c:	2c050463          	beqz	a0,3244 <subdir+0x562>
  if(chdir("dd/xx") == 0){
    2f80:	00004517          	auipc	a0,0x4
    2f84:	ca050513          	addi	a0,a0,-864 # 6c20 <malloc+0x183c>
    2f88:	7f5010ef          	jal	4f7c <chdir>
    2f8c:	2c050663          	beqz	a0,3258 <subdir+0x576>
  if(unlink("dd/dd/ffff") != 0){
    2f90:	00004517          	auipc	a0,0x4
    2f94:	8f050513          	addi	a0,a0,-1808 # 6880 <malloc+0x149c>
    2f98:	7c5010ef          	jal	4f5c <unlink>
    2f9c:	2c051863          	bnez	a0,326c <subdir+0x58a>
  if(unlink("dd/ff") != 0){
    2fa0:	00003517          	auipc	a0,0x3
    2fa4:	7d850513          	addi	a0,a0,2008 # 6778 <malloc+0x1394>
    2fa8:	7b5010ef          	jal	4f5c <unlink>
    2fac:	2c051a63          	bnez	a0,3280 <subdir+0x59e>
  if(unlink("dd") == 0){
    2fb0:	00003517          	auipc	a0,0x3
    2fb4:	7a850513          	addi	a0,a0,1960 # 6758 <malloc+0x1374>
    2fb8:	7a5010ef          	jal	4f5c <unlink>
    2fbc:	2c050c63          	beqz	a0,3294 <subdir+0x5b2>
  if(unlink("dd/dd") < 0){
    2fc0:	00004517          	auipc	a0,0x4
    2fc4:	cd050513          	addi	a0,a0,-816 # 6c90 <malloc+0x18ac>
    2fc8:	795010ef          	jal	4f5c <unlink>
    2fcc:	2c054e63          	bltz	a0,32a8 <subdir+0x5c6>
  if(unlink("dd") < 0){
    2fd0:	00003517          	auipc	a0,0x3
    2fd4:	78850513          	addi	a0,a0,1928 # 6758 <malloc+0x1374>
    2fd8:	785010ef          	jal	4f5c <unlink>
    2fdc:	2e054063          	bltz	a0,32bc <subdir+0x5da>
}
    2fe0:	60e2                	ld	ra,24(sp)
    2fe2:	6442                	ld	s0,16(sp)
    2fe4:	64a2                	ld	s1,8(sp)
    2fe6:	6902                	ld	s2,0(sp)
    2fe8:	6105                	addi	sp,sp,32
    2fea:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    2fec:	85ca                	mv	a1,s2
    2fee:	00003517          	auipc	a0,0x3
    2ff2:	77250513          	addi	a0,a0,1906 # 6760 <malloc+0x137c>
    2ff6:	336020ef          	jal	532c <printf>
    exit(1);
    2ffa:	4505                	li	a0,1
    2ffc:	711010ef          	jal	4f0c <exit>
    printf("%s: create dd/ff failed\n", s);
    3000:	85ca                	mv	a1,s2
    3002:	00003517          	auipc	a0,0x3
    3006:	77e50513          	addi	a0,a0,1918 # 6780 <malloc+0x139c>
    300a:	322020ef          	jal	532c <printf>
    exit(1);
    300e:	4505                	li	a0,1
    3010:	6fd010ef          	jal	4f0c <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3014:	85ca                	mv	a1,s2
    3016:	00003517          	auipc	a0,0x3
    301a:	78a50513          	addi	a0,a0,1930 # 67a0 <malloc+0x13bc>
    301e:	30e020ef          	jal	532c <printf>
    exit(1);
    3022:	4505                	li	a0,1
    3024:	6e9010ef          	jal	4f0c <exit>
    printf("%s: subdir mkdir dd/dd failed\n", s);
    3028:	85ca                	mv	a1,s2
    302a:	00003517          	auipc	a0,0x3
    302e:	7ae50513          	addi	a0,a0,1966 # 67d8 <malloc+0x13f4>
    3032:	2fa020ef          	jal	532c <printf>
    exit(1);
    3036:	4505                	li	a0,1
    3038:	6d5010ef          	jal	4f0c <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    303c:	85ca                	mv	a1,s2
    303e:	00003517          	auipc	a0,0x3
    3042:	7ca50513          	addi	a0,a0,1994 # 6808 <malloc+0x1424>
    3046:	2e6020ef          	jal	532c <printf>
    exit(1);
    304a:	4505                	li	a0,1
    304c:	6c1010ef          	jal	4f0c <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3050:	85ca                	mv	a1,s2
    3052:	00003517          	auipc	a0,0x3
    3056:	7ee50513          	addi	a0,a0,2030 # 6840 <malloc+0x145c>
    305a:	2d2020ef          	jal	532c <printf>
    exit(1);
    305e:	4505                	li	a0,1
    3060:	6ad010ef          	jal	4f0c <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3064:	85ca                	mv	a1,s2
    3066:	00003517          	auipc	a0,0x3
    306a:	7fa50513          	addi	a0,a0,2042 # 6860 <malloc+0x147c>
    306e:	2be020ef          	jal	532c <printf>
    exit(1);
    3072:	4505                	li	a0,1
    3074:	699010ef          	jal	4f0c <exit>
    printf("%s: link dd/dd/ff dd/dd/ffff failed\n", s);
    3078:	85ca                	mv	a1,s2
    307a:	00004517          	auipc	a0,0x4
    307e:	81650513          	addi	a0,a0,-2026 # 6890 <malloc+0x14ac>
    3082:	2aa020ef          	jal	532c <printf>
    exit(1);
    3086:	4505                	li	a0,1
    3088:	685010ef          	jal	4f0c <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    308c:	85ca                	mv	a1,s2
    308e:	00004517          	auipc	a0,0x4
    3092:	82a50513          	addi	a0,a0,-2006 # 68b8 <malloc+0x14d4>
    3096:	296020ef          	jal	532c <printf>
    exit(1);
    309a:	4505                	li	a0,1
    309c:	671010ef          	jal	4f0c <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    30a0:	85ca                	mv	a1,s2
    30a2:	00004517          	auipc	a0,0x4
    30a6:	83650513          	addi	a0,a0,-1994 # 68d8 <malloc+0x14f4>
    30aa:	282020ef          	jal	532c <printf>
    exit(1);
    30ae:	4505                	li	a0,1
    30b0:	65d010ef          	jal	4f0c <exit>
    printf("%s: chdir dd failed\n", s);
    30b4:	85ca                	mv	a1,s2
    30b6:	00004517          	auipc	a0,0x4
    30ba:	84a50513          	addi	a0,a0,-1974 # 6900 <malloc+0x151c>
    30be:	26e020ef          	jal	532c <printf>
    exit(1);
    30c2:	4505                	li	a0,1
    30c4:	649010ef          	jal	4f0c <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    30c8:	85ca                	mv	a1,s2
    30ca:	00004517          	auipc	a0,0x4
    30ce:	85e50513          	addi	a0,a0,-1954 # 6928 <malloc+0x1544>
    30d2:	25a020ef          	jal	532c <printf>
    exit(1);
    30d6:	4505                	li	a0,1
    30d8:	635010ef          	jal	4f0c <exit>
    printf("%s: chdir dd/../../../dd failed\n", s);
    30dc:	85ca                	mv	a1,s2
    30de:	00004517          	auipc	a0,0x4
    30e2:	87a50513          	addi	a0,a0,-1926 # 6958 <malloc+0x1574>
    30e6:	246020ef          	jal	532c <printf>
    exit(1);
    30ea:	4505                	li	a0,1
    30ec:	621010ef          	jal	4f0c <exit>
    printf("%s: chdir ./.. failed\n", s);
    30f0:	85ca                	mv	a1,s2
    30f2:	00004517          	auipc	a0,0x4
    30f6:	89650513          	addi	a0,a0,-1898 # 6988 <malloc+0x15a4>
    30fa:	232020ef          	jal	532c <printf>
    exit(1);
    30fe:	4505                	li	a0,1
    3100:	60d010ef          	jal	4f0c <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3104:	85ca                	mv	a1,s2
    3106:	00004517          	auipc	a0,0x4
    310a:	89a50513          	addi	a0,a0,-1894 # 69a0 <malloc+0x15bc>
    310e:	21e020ef          	jal	532c <printf>
    exit(1);
    3112:	4505                	li	a0,1
    3114:	5f9010ef          	jal	4f0c <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3118:	85ca                	mv	a1,s2
    311a:	00004517          	auipc	a0,0x4
    311e:	8a650513          	addi	a0,a0,-1882 # 69c0 <malloc+0x15dc>
    3122:	20a020ef          	jal	532c <printf>
    exit(1);
    3126:	4505                	li	a0,1
    3128:	5e5010ef          	jal	4f0c <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    312c:	85ca                	mv	a1,s2
    312e:	00004517          	auipc	a0,0x4
    3132:	8b250513          	addi	a0,a0,-1870 # 69e0 <malloc+0x15fc>
    3136:	1f6020ef          	jal	532c <printf>
    exit(1);
    313a:	4505                	li	a0,1
    313c:	5d1010ef          	jal	4f0c <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3140:	85ca                	mv	a1,s2
    3142:	00004517          	auipc	a0,0x4
    3146:	8de50513          	addi	a0,a0,-1826 # 6a20 <malloc+0x163c>
    314a:	1e2020ef          	jal	532c <printf>
    exit(1);
    314e:	4505                	li	a0,1
    3150:	5bd010ef          	jal	4f0c <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3154:	85ca                	mv	a1,s2
    3156:	00004517          	auipc	a0,0x4
    315a:	8fa50513          	addi	a0,a0,-1798 # 6a50 <malloc+0x166c>
    315e:	1ce020ef          	jal	532c <printf>
    exit(1);
    3162:	4505                	li	a0,1
    3164:	5a9010ef          	jal	4f0c <exit>
    printf("%s: create dd succeeded!\n", s);
    3168:	85ca                	mv	a1,s2
    316a:	00004517          	auipc	a0,0x4
    316e:	90650513          	addi	a0,a0,-1786 # 6a70 <malloc+0x168c>
    3172:	1ba020ef          	jal	532c <printf>
    exit(1);
    3176:	4505                	li	a0,1
    3178:	595010ef          	jal	4f0c <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    317c:	85ca                	mv	a1,s2
    317e:	00004517          	auipc	a0,0x4
    3182:	91250513          	addi	a0,a0,-1774 # 6a90 <malloc+0x16ac>
    3186:	1a6020ef          	jal	532c <printf>
    exit(1);
    318a:	4505                	li	a0,1
    318c:	581010ef          	jal	4f0c <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3190:	85ca                	mv	a1,s2
    3192:	00004517          	auipc	a0,0x4
    3196:	91e50513          	addi	a0,a0,-1762 # 6ab0 <malloc+0x16cc>
    319a:	192020ef          	jal	532c <printf>
    exit(1);
    319e:	4505                	li	a0,1
    31a0:	56d010ef          	jal	4f0c <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    31a4:	85ca                	mv	a1,s2
    31a6:	00004517          	auipc	a0,0x4
    31aa:	93a50513          	addi	a0,a0,-1734 # 6ae0 <malloc+0x16fc>
    31ae:	17e020ef          	jal	532c <printf>
    exit(1);
    31b2:	4505                	li	a0,1
    31b4:	559010ef          	jal	4f0c <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    31b8:	85ca                	mv	a1,s2
    31ba:	00004517          	auipc	a0,0x4
    31be:	94e50513          	addi	a0,a0,-1714 # 6b08 <malloc+0x1724>
    31c2:	16a020ef          	jal	532c <printf>
    exit(1);
    31c6:	4505                	li	a0,1
    31c8:	545010ef          	jal	4f0c <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    31cc:	85ca                	mv	a1,s2
    31ce:	00004517          	auipc	a0,0x4
    31d2:	96250513          	addi	a0,a0,-1694 # 6b30 <malloc+0x174c>
    31d6:	156020ef          	jal	532c <printf>
    exit(1);
    31da:	4505                	li	a0,1
    31dc:	531010ef          	jal	4f0c <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    31e0:	85ca                	mv	a1,s2
    31e2:	00004517          	auipc	a0,0x4
    31e6:	97650513          	addi	a0,a0,-1674 # 6b58 <malloc+0x1774>
    31ea:	142020ef          	jal	532c <printf>
    exit(1);
    31ee:	4505                	li	a0,1
    31f0:	51d010ef          	jal	4f0c <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    31f4:	85ca                	mv	a1,s2
    31f6:	00004517          	auipc	a0,0x4
    31fa:	98250513          	addi	a0,a0,-1662 # 6b78 <malloc+0x1794>
    31fe:	12e020ef          	jal	532c <printf>
    exit(1);
    3202:	4505                	li	a0,1
    3204:	509010ef          	jal	4f0c <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3208:	85ca                	mv	a1,s2
    320a:	00004517          	auipc	a0,0x4
    320e:	98e50513          	addi	a0,a0,-1650 # 6b98 <malloc+0x17b4>
    3212:	11a020ef          	jal	532c <printf>
    exit(1);
    3216:	4505                	li	a0,1
    3218:	4f5010ef          	jal	4f0c <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    321c:	85ca                	mv	a1,s2
    321e:	00004517          	auipc	a0,0x4
    3222:	9a250513          	addi	a0,a0,-1630 # 6bc0 <malloc+0x17dc>
    3226:	106020ef          	jal	532c <printf>
    exit(1);
    322a:	4505                	li	a0,1
    322c:	4e1010ef          	jal	4f0c <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3230:	85ca                	mv	a1,s2
    3232:	00004517          	auipc	a0,0x4
    3236:	9ae50513          	addi	a0,a0,-1618 # 6be0 <malloc+0x17fc>
    323a:	0f2020ef          	jal	532c <printf>
    exit(1);
    323e:	4505                	li	a0,1
    3240:	4cd010ef          	jal	4f0c <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3244:	85ca                	mv	a1,s2
    3246:	00004517          	auipc	a0,0x4
    324a:	9ba50513          	addi	a0,a0,-1606 # 6c00 <malloc+0x181c>
    324e:	0de020ef          	jal	532c <printf>
    exit(1);
    3252:	4505                	li	a0,1
    3254:	4b9010ef          	jal	4f0c <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3258:	85ca                	mv	a1,s2
    325a:	00004517          	auipc	a0,0x4
    325e:	9ce50513          	addi	a0,a0,-1586 # 6c28 <malloc+0x1844>
    3262:	0ca020ef          	jal	532c <printf>
    exit(1);
    3266:	4505                	li	a0,1
    3268:	4a5010ef          	jal	4f0c <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    326c:	85ca                	mv	a1,s2
    326e:	00003517          	auipc	a0,0x3
    3272:	64a50513          	addi	a0,a0,1610 # 68b8 <malloc+0x14d4>
    3276:	0b6020ef          	jal	532c <printf>
    exit(1);
    327a:	4505                	li	a0,1
    327c:	491010ef          	jal	4f0c <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3280:	85ca                	mv	a1,s2
    3282:	00004517          	auipc	a0,0x4
    3286:	9c650513          	addi	a0,a0,-1594 # 6c48 <malloc+0x1864>
    328a:	0a2020ef          	jal	532c <printf>
    exit(1);
    328e:	4505                	li	a0,1
    3290:	47d010ef          	jal	4f0c <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3294:	85ca                	mv	a1,s2
    3296:	00004517          	auipc	a0,0x4
    329a:	9d250513          	addi	a0,a0,-1582 # 6c68 <malloc+0x1884>
    329e:	08e020ef          	jal	532c <printf>
    exit(1);
    32a2:	4505                	li	a0,1
    32a4:	469010ef          	jal	4f0c <exit>
    printf("%s: unlink dd/dd failed\n", s);
    32a8:	85ca                	mv	a1,s2
    32aa:	00004517          	auipc	a0,0x4
    32ae:	9ee50513          	addi	a0,a0,-1554 # 6c98 <malloc+0x18b4>
    32b2:	07a020ef          	jal	532c <printf>
    exit(1);
    32b6:	4505                	li	a0,1
    32b8:	455010ef          	jal	4f0c <exit>
    printf("%s: unlink dd failed\n", s);
    32bc:	85ca                	mv	a1,s2
    32be:	00004517          	auipc	a0,0x4
    32c2:	9fa50513          	addi	a0,a0,-1542 # 6cb8 <malloc+0x18d4>
    32c6:	066020ef          	jal	532c <printf>
    exit(1);
    32ca:	4505                	li	a0,1
    32cc:	441010ef          	jal	4f0c <exit>

00000000000032d0 <rmdot>:
{
    32d0:	1101                	addi	sp,sp,-32
    32d2:	ec06                	sd	ra,24(sp)
    32d4:	e822                	sd	s0,16(sp)
    32d6:	e426                	sd	s1,8(sp)
    32d8:	1000                	addi	s0,sp,32
    32da:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    32dc:	00004517          	auipc	a0,0x4
    32e0:	9f450513          	addi	a0,a0,-1548 # 6cd0 <malloc+0x18ec>
    32e4:	491010ef          	jal	4f74 <mkdir>
    32e8:	e53d                	bnez	a0,3356 <rmdot+0x86>
  if(chdir("dots") != 0){
    32ea:	00004517          	auipc	a0,0x4
    32ee:	9e650513          	addi	a0,a0,-1562 # 6cd0 <malloc+0x18ec>
    32f2:	48b010ef          	jal	4f7c <chdir>
    32f6:	e935                	bnez	a0,336a <rmdot+0x9a>
  if(unlink(".") == 0){
    32f8:	00003517          	auipc	a0,0x3
    32fc:	90850513          	addi	a0,a0,-1784 # 5c00 <malloc+0x81c>
    3300:	45d010ef          	jal	4f5c <unlink>
    3304:	cd2d                	beqz	a0,337e <rmdot+0xae>
  if(unlink("..") == 0){
    3306:	00003517          	auipc	a0,0x3
    330a:	41a50513          	addi	a0,a0,1050 # 6720 <malloc+0x133c>
    330e:	44f010ef          	jal	4f5c <unlink>
    3312:	c141                	beqz	a0,3392 <rmdot+0xc2>
  if(chdir("/") != 0){
    3314:	00003517          	auipc	a0,0x3
    3318:	3b450513          	addi	a0,a0,948 # 66c8 <malloc+0x12e4>
    331c:	461010ef          	jal	4f7c <chdir>
    3320:	e159                	bnez	a0,33a6 <rmdot+0xd6>
  if(unlink("dots/.") == 0){
    3322:	00004517          	auipc	a0,0x4
    3326:	a1650513          	addi	a0,a0,-1514 # 6d38 <malloc+0x1954>
    332a:	433010ef          	jal	4f5c <unlink>
    332e:	c551                	beqz	a0,33ba <rmdot+0xea>
  if(unlink("dots/..") == 0){
    3330:	00004517          	auipc	a0,0x4
    3334:	a3050513          	addi	a0,a0,-1488 # 6d60 <malloc+0x197c>
    3338:	425010ef          	jal	4f5c <unlink>
    333c:	c949                	beqz	a0,33ce <rmdot+0xfe>
  if(unlink("dots") != 0){
    333e:	00004517          	auipc	a0,0x4
    3342:	99250513          	addi	a0,a0,-1646 # 6cd0 <malloc+0x18ec>
    3346:	417010ef          	jal	4f5c <unlink>
    334a:	ed41                	bnez	a0,33e2 <rmdot+0x112>
}
    334c:	60e2                	ld	ra,24(sp)
    334e:	6442                	ld	s0,16(sp)
    3350:	64a2                	ld	s1,8(sp)
    3352:	6105                	addi	sp,sp,32
    3354:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3356:	85a6                	mv	a1,s1
    3358:	00004517          	auipc	a0,0x4
    335c:	98050513          	addi	a0,a0,-1664 # 6cd8 <malloc+0x18f4>
    3360:	7cd010ef          	jal	532c <printf>
    exit(1);
    3364:	4505                	li	a0,1
    3366:	3a7010ef          	jal	4f0c <exit>
    printf("%s: chdir dots failed\n", s);
    336a:	85a6                	mv	a1,s1
    336c:	00004517          	auipc	a0,0x4
    3370:	98450513          	addi	a0,a0,-1660 # 6cf0 <malloc+0x190c>
    3374:	7b9010ef          	jal	532c <printf>
    exit(1);
    3378:	4505                	li	a0,1
    337a:	393010ef          	jal	4f0c <exit>
    printf("%s: rm . worked!\n", s);
    337e:	85a6                	mv	a1,s1
    3380:	00004517          	auipc	a0,0x4
    3384:	98850513          	addi	a0,a0,-1656 # 6d08 <malloc+0x1924>
    3388:	7a5010ef          	jal	532c <printf>
    exit(1);
    338c:	4505                	li	a0,1
    338e:	37f010ef          	jal	4f0c <exit>
    printf("%s: rm .. worked!\n", s);
    3392:	85a6                	mv	a1,s1
    3394:	00004517          	auipc	a0,0x4
    3398:	98c50513          	addi	a0,a0,-1652 # 6d20 <malloc+0x193c>
    339c:	791010ef          	jal	532c <printf>
    exit(1);
    33a0:	4505                	li	a0,1
    33a2:	36b010ef          	jal	4f0c <exit>
    printf("%s: chdir / failed\n", s);
    33a6:	85a6                	mv	a1,s1
    33a8:	00003517          	auipc	a0,0x3
    33ac:	32850513          	addi	a0,a0,808 # 66d0 <malloc+0x12ec>
    33b0:	77d010ef          	jal	532c <printf>
    exit(1);
    33b4:	4505                	li	a0,1
    33b6:	357010ef          	jal	4f0c <exit>
    printf("%s: unlink dots/. worked!\n", s);
    33ba:	85a6                	mv	a1,s1
    33bc:	00004517          	auipc	a0,0x4
    33c0:	98450513          	addi	a0,a0,-1660 # 6d40 <malloc+0x195c>
    33c4:	769010ef          	jal	532c <printf>
    exit(1);
    33c8:	4505                	li	a0,1
    33ca:	343010ef          	jal	4f0c <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    33ce:	85a6                	mv	a1,s1
    33d0:	00004517          	auipc	a0,0x4
    33d4:	99850513          	addi	a0,a0,-1640 # 6d68 <malloc+0x1984>
    33d8:	755010ef          	jal	532c <printf>
    exit(1);
    33dc:	4505                	li	a0,1
    33de:	32f010ef          	jal	4f0c <exit>
    printf("%s: unlink dots failed!\n", s);
    33e2:	85a6                	mv	a1,s1
    33e4:	00004517          	auipc	a0,0x4
    33e8:	9a450513          	addi	a0,a0,-1628 # 6d88 <malloc+0x19a4>
    33ec:	741010ef          	jal	532c <printf>
    exit(1);
    33f0:	4505                	li	a0,1
    33f2:	31b010ef          	jal	4f0c <exit>

00000000000033f6 <dirfile>:
{
    33f6:	1101                	addi	sp,sp,-32
    33f8:	ec06                	sd	ra,24(sp)
    33fa:	e822                	sd	s0,16(sp)
    33fc:	e426                	sd	s1,8(sp)
    33fe:	e04a                	sd	s2,0(sp)
    3400:	1000                	addi	s0,sp,32
    3402:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3404:	20000593          	li	a1,512
    3408:	00004517          	auipc	a0,0x4
    340c:	9a050513          	addi	a0,a0,-1632 # 6da8 <malloc+0x19c4>
    3410:	33d010ef          	jal	4f4c <open>
  if(fd < 0){
    3414:	0c054563          	bltz	a0,34de <dirfile+0xe8>
  close(fd);
    3418:	31d010ef          	jal	4f34 <close>
  if(chdir("dirfile") == 0){
    341c:	00004517          	auipc	a0,0x4
    3420:	98c50513          	addi	a0,a0,-1652 # 6da8 <malloc+0x19c4>
    3424:	359010ef          	jal	4f7c <chdir>
    3428:	c569                	beqz	a0,34f2 <dirfile+0xfc>
  fd = open("dirfile/xx", 0);
    342a:	4581                	li	a1,0
    342c:	00004517          	auipc	a0,0x4
    3430:	9c450513          	addi	a0,a0,-1596 # 6df0 <malloc+0x1a0c>
    3434:	319010ef          	jal	4f4c <open>
  if(fd >= 0){
    3438:	0c055763          	bgez	a0,3506 <dirfile+0x110>
  fd = open("dirfile/xx", O_CREATE);
    343c:	20000593          	li	a1,512
    3440:	00004517          	auipc	a0,0x4
    3444:	9b050513          	addi	a0,a0,-1616 # 6df0 <malloc+0x1a0c>
    3448:	305010ef          	jal	4f4c <open>
  if(fd >= 0){
    344c:	0c055763          	bgez	a0,351a <dirfile+0x124>
  if(mkdir("dirfile/xx") == 0){
    3450:	00004517          	auipc	a0,0x4
    3454:	9a050513          	addi	a0,a0,-1632 # 6df0 <malloc+0x1a0c>
    3458:	31d010ef          	jal	4f74 <mkdir>
    345c:	0c050963          	beqz	a0,352e <dirfile+0x138>
  if(unlink("dirfile/xx") == 0){
    3460:	00004517          	auipc	a0,0x4
    3464:	99050513          	addi	a0,a0,-1648 # 6df0 <malloc+0x1a0c>
    3468:	2f5010ef          	jal	4f5c <unlink>
    346c:	0c050b63          	beqz	a0,3542 <dirfile+0x14c>
  if(link("README", "dirfile/xx") == 0){
    3470:	00004597          	auipc	a1,0x4
    3474:	98058593          	addi	a1,a1,-1664 # 6df0 <malloc+0x1a0c>
    3478:	00002517          	auipc	a0,0x2
    347c:	27850513          	addi	a0,a0,632 # 56f0 <malloc+0x30c>
    3480:	2ed010ef          	jal	4f6c <link>
    3484:	0c050963          	beqz	a0,3556 <dirfile+0x160>
  if(unlink("dirfile") != 0){
    3488:	00004517          	auipc	a0,0x4
    348c:	92050513          	addi	a0,a0,-1760 # 6da8 <malloc+0x19c4>
    3490:	2cd010ef          	jal	4f5c <unlink>
    3494:	0c051b63          	bnez	a0,356a <dirfile+0x174>
  fd = open(".", O_RDWR);
    3498:	4589                	li	a1,2
    349a:	00002517          	auipc	a0,0x2
    349e:	76650513          	addi	a0,a0,1894 # 5c00 <malloc+0x81c>
    34a2:	2ab010ef          	jal	4f4c <open>
  if(fd >= 0){
    34a6:	0c055c63          	bgez	a0,357e <dirfile+0x188>
  fd = open(".", 0);
    34aa:	4581                	li	a1,0
    34ac:	00002517          	auipc	a0,0x2
    34b0:	75450513          	addi	a0,a0,1876 # 5c00 <malloc+0x81c>
    34b4:	299010ef          	jal	4f4c <open>
    34b8:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    34ba:	4605                	li	a2,1
    34bc:	00002597          	auipc	a1,0x2
    34c0:	0cc58593          	addi	a1,a1,204 # 5588 <malloc+0x1a4>
    34c4:	269010ef          	jal	4f2c <write>
    34c8:	0ca04563          	bgtz	a0,3592 <dirfile+0x19c>
  close(fd);
    34cc:	8526                	mv	a0,s1
    34ce:	267010ef          	jal	4f34 <close>
}
    34d2:	60e2                	ld	ra,24(sp)
    34d4:	6442                	ld	s0,16(sp)
    34d6:	64a2                	ld	s1,8(sp)
    34d8:	6902                	ld	s2,0(sp)
    34da:	6105                	addi	sp,sp,32
    34dc:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    34de:	85ca                	mv	a1,s2
    34e0:	00004517          	auipc	a0,0x4
    34e4:	8d050513          	addi	a0,a0,-1840 # 6db0 <malloc+0x19cc>
    34e8:	645010ef          	jal	532c <printf>
    exit(1);
    34ec:	4505                	li	a0,1
    34ee:	21f010ef          	jal	4f0c <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    34f2:	85ca                	mv	a1,s2
    34f4:	00004517          	auipc	a0,0x4
    34f8:	8dc50513          	addi	a0,a0,-1828 # 6dd0 <malloc+0x19ec>
    34fc:	631010ef          	jal	532c <printf>
    exit(1);
    3500:	4505                	li	a0,1
    3502:	20b010ef          	jal	4f0c <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3506:	85ca                	mv	a1,s2
    3508:	00004517          	auipc	a0,0x4
    350c:	8f850513          	addi	a0,a0,-1800 # 6e00 <malloc+0x1a1c>
    3510:	61d010ef          	jal	532c <printf>
    exit(1);
    3514:	4505                	li	a0,1
    3516:	1f7010ef          	jal	4f0c <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    351a:	85ca                	mv	a1,s2
    351c:	00004517          	auipc	a0,0x4
    3520:	8e450513          	addi	a0,a0,-1820 # 6e00 <malloc+0x1a1c>
    3524:	609010ef          	jal	532c <printf>
    exit(1);
    3528:	4505                	li	a0,1
    352a:	1e3010ef          	jal	4f0c <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    352e:	85ca                	mv	a1,s2
    3530:	00004517          	auipc	a0,0x4
    3534:	8f850513          	addi	a0,a0,-1800 # 6e28 <malloc+0x1a44>
    3538:	5f5010ef          	jal	532c <printf>
    exit(1);
    353c:	4505                	li	a0,1
    353e:	1cf010ef          	jal	4f0c <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3542:	85ca                	mv	a1,s2
    3544:	00004517          	auipc	a0,0x4
    3548:	90c50513          	addi	a0,a0,-1780 # 6e50 <malloc+0x1a6c>
    354c:	5e1010ef          	jal	532c <printf>
    exit(1);
    3550:	4505                	li	a0,1
    3552:	1bb010ef          	jal	4f0c <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3556:	85ca                	mv	a1,s2
    3558:	00004517          	auipc	a0,0x4
    355c:	92050513          	addi	a0,a0,-1760 # 6e78 <malloc+0x1a94>
    3560:	5cd010ef          	jal	532c <printf>
    exit(1);
    3564:	4505                	li	a0,1
    3566:	1a7010ef          	jal	4f0c <exit>
    printf("%s: unlink dirfile failed!\n", s);
    356a:	85ca                	mv	a1,s2
    356c:	00004517          	auipc	a0,0x4
    3570:	93450513          	addi	a0,a0,-1740 # 6ea0 <malloc+0x1abc>
    3574:	5b9010ef          	jal	532c <printf>
    exit(1);
    3578:	4505                	li	a0,1
    357a:	193010ef          	jal	4f0c <exit>
    printf("%s: open . for writing succeeded!\n", s);
    357e:	85ca                	mv	a1,s2
    3580:	00004517          	auipc	a0,0x4
    3584:	94050513          	addi	a0,a0,-1728 # 6ec0 <malloc+0x1adc>
    3588:	5a5010ef          	jal	532c <printf>
    exit(1);
    358c:	4505                	li	a0,1
    358e:	17f010ef          	jal	4f0c <exit>
    printf("%s: write . succeeded!\n", s);
    3592:	85ca                	mv	a1,s2
    3594:	00004517          	auipc	a0,0x4
    3598:	95450513          	addi	a0,a0,-1708 # 6ee8 <malloc+0x1b04>
    359c:	591010ef          	jal	532c <printf>
    exit(1);
    35a0:	4505                	li	a0,1
    35a2:	16b010ef          	jal	4f0c <exit>

00000000000035a6 <iref>:
{
    35a6:	715d                	addi	sp,sp,-80
    35a8:	e486                	sd	ra,72(sp)
    35aa:	e0a2                	sd	s0,64(sp)
    35ac:	fc26                	sd	s1,56(sp)
    35ae:	f84a                	sd	s2,48(sp)
    35b0:	f44e                	sd	s3,40(sp)
    35b2:	f052                	sd	s4,32(sp)
    35b4:	ec56                	sd	s5,24(sp)
    35b6:	e85a                	sd	s6,16(sp)
    35b8:	e45e                	sd	s7,8(sp)
    35ba:	0880                	addi	s0,sp,80
    35bc:	8baa                	mv	s7,a0
    35be:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    35c2:	00004a97          	auipc	s5,0x4
    35c6:	93ea8a93          	addi	s5,s5,-1730 # 6f00 <malloc+0x1b1c>
    mkdir("");
    35ca:	00003497          	auipc	s1,0x3
    35ce:	43e48493          	addi	s1,s1,1086 # 6a08 <malloc+0x1624>
    link("README", "");
    35d2:	00002b17          	auipc	s6,0x2
    35d6:	11eb0b13          	addi	s6,s6,286 # 56f0 <malloc+0x30c>
    fd = open("", O_CREATE);
    35da:	20000a13          	li	s4,512
    fd = open("xx", O_CREATE);
    35de:	00004997          	auipc	s3,0x4
    35e2:	81a98993          	addi	s3,s3,-2022 # 6df8 <malloc+0x1a14>
    35e6:	a835                	j	3622 <iref+0x7c>
      printf("%s: mkdir irefd failed\n", s);
    35e8:	85de                	mv	a1,s7
    35ea:	00004517          	auipc	a0,0x4
    35ee:	91e50513          	addi	a0,a0,-1762 # 6f08 <malloc+0x1b24>
    35f2:	53b010ef          	jal	532c <printf>
      exit(1);
    35f6:	4505                	li	a0,1
    35f8:	115010ef          	jal	4f0c <exit>
      printf("%s: chdir irefd failed\n", s);
    35fc:	85de                	mv	a1,s7
    35fe:	00004517          	auipc	a0,0x4
    3602:	92250513          	addi	a0,a0,-1758 # 6f20 <malloc+0x1b3c>
    3606:	527010ef          	jal	532c <printf>
      exit(1);
    360a:	4505                	li	a0,1
    360c:	101010ef          	jal	4f0c <exit>
      close(fd);
    3610:	125010ef          	jal	4f34 <close>
    3614:	a825                	j	364c <iref+0xa6>
    unlink("xx");
    3616:	854e                	mv	a0,s3
    3618:	145010ef          	jal	4f5c <unlink>
  for(i = 0; i < NINODE + 1; i++){
    361c:	397d                	addiw	s2,s2,-1
    361e:	04090063          	beqz	s2,365e <iref+0xb8>
    if(mkdir("irefd") != 0){
    3622:	8556                	mv	a0,s5
    3624:	151010ef          	jal	4f74 <mkdir>
    3628:	f161                	bnez	a0,35e8 <iref+0x42>
    if(chdir("irefd") != 0){
    362a:	8556                	mv	a0,s5
    362c:	151010ef          	jal	4f7c <chdir>
    3630:	f571                	bnez	a0,35fc <iref+0x56>
    mkdir("");
    3632:	8526                	mv	a0,s1
    3634:	141010ef          	jal	4f74 <mkdir>
    link("README", "");
    3638:	85a6                	mv	a1,s1
    363a:	855a                	mv	a0,s6
    363c:	131010ef          	jal	4f6c <link>
    fd = open("", O_CREATE);
    3640:	85d2                	mv	a1,s4
    3642:	8526                	mv	a0,s1
    3644:	109010ef          	jal	4f4c <open>
    if(fd >= 0)
    3648:	fc0554e3          	bgez	a0,3610 <iref+0x6a>
    fd = open("xx", O_CREATE);
    364c:	85d2                	mv	a1,s4
    364e:	854e                	mv	a0,s3
    3650:	0fd010ef          	jal	4f4c <open>
    if(fd >= 0)
    3654:	fc0541e3          	bltz	a0,3616 <iref+0x70>
      close(fd);
    3658:	0dd010ef          	jal	4f34 <close>
    365c:	bf6d                	j	3616 <iref+0x70>
    365e:	03300493          	li	s1,51
    chdir("..");
    3662:	00003997          	auipc	s3,0x3
    3666:	0be98993          	addi	s3,s3,190 # 6720 <malloc+0x133c>
    unlink("irefd");
    366a:	00004917          	auipc	s2,0x4
    366e:	89690913          	addi	s2,s2,-1898 # 6f00 <malloc+0x1b1c>
    chdir("..");
    3672:	854e                	mv	a0,s3
    3674:	109010ef          	jal	4f7c <chdir>
    unlink("irefd");
    3678:	854a                	mv	a0,s2
    367a:	0e3010ef          	jal	4f5c <unlink>
  for(i = 0; i < NINODE + 1; i++){
    367e:	34fd                	addiw	s1,s1,-1
    3680:	f8ed                	bnez	s1,3672 <iref+0xcc>
  chdir("/");
    3682:	00003517          	auipc	a0,0x3
    3686:	04650513          	addi	a0,a0,70 # 66c8 <malloc+0x12e4>
    368a:	0f3010ef          	jal	4f7c <chdir>
}
    368e:	60a6                	ld	ra,72(sp)
    3690:	6406                	ld	s0,64(sp)
    3692:	74e2                	ld	s1,56(sp)
    3694:	7942                	ld	s2,48(sp)
    3696:	79a2                	ld	s3,40(sp)
    3698:	7a02                	ld	s4,32(sp)
    369a:	6ae2                	ld	s5,24(sp)
    369c:	6b42                	ld	s6,16(sp)
    369e:	6ba2                	ld	s7,8(sp)
    36a0:	6161                	addi	sp,sp,80
    36a2:	8082                	ret

00000000000036a4 <openiputtest>:
{
    36a4:	7179                	addi	sp,sp,-48
    36a6:	f406                	sd	ra,40(sp)
    36a8:	f022                	sd	s0,32(sp)
    36aa:	ec26                	sd	s1,24(sp)
    36ac:	1800                	addi	s0,sp,48
    36ae:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    36b0:	00004517          	auipc	a0,0x4
    36b4:	88850513          	addi	a0,a0,-1912 # 6f38 <malloc+0x1b54>
    36b8:	0bd010ef          	jal	4f74 <mkdir>
    36bc:	02054a63          	bltz	a0,36f0 <openiputtest+0x4c>
  pid = fork();
    36c0:	045010ef          	jal	4f04 <fork>
  if(pid < 0){
    36c4:	04054063          	bltz	a0,3704 <openiputtest+0x60>
  if(pid == 0){
    36c8:	e939                	bnez	a0,371e <openiputtest+0x7a>
    int fd = open("oidir", O_RDWR);
    36ca:	4589                	li	a1,2
    36cc:	00004517          	auipc	a0,0x4
    36d0:	86c50513          	addi	a0,a0,-1940 # 6f38 <malloc+0x1b54>
    36d4:	079010ef          	jal	4f4c <open>
    if(fd >= 0){
    36d8:	04054063          	bltz	a0,3718 <openiputtest+0x74>
      printf("%s: open directory for write succeeded\n", s);
    36dc:	85a6                	mv	a1,s1
    36de:	00004517          	auipc	a0,0x4
    36e2:	87a50513          	addi	a0,a0,-1926 # 6f58 <malloc+0x1b74>
    36e6:	447010ef          	jal	532c <printf>
      exit(1);
    36ea:	4505                	li	a0,1
    36ec:	021010ef          	jal	4f0c <exit>
    printf("%s: mkdir oidir failed\n", s);
    36f0:	85a6                	mv	a1,s1
    36f2:	00004517          	auipc	a0,0x4
    36f6:	84e50513          	addi	a0,a0,-1970 # 6f40 <malloc+0x1b5c>
    36fa:	433010ef          	jal	532c <printf>
    exit(1);
    36fe:	4505                	li	a0,1
    3700:	00d010ef          	jal	4f0c <exit>
    printf("%s: fork failed\n", s);
    3704:	85a6                	mv	a1,s1
    3706:	00002517          	auipc	a0,0x2
    370a:	6a250513          	addi	a0,a0,1698 # 5da8 <malloc+0x9c4>
    370e:	41f010ef          	jal	532c <printf>
    exit(1);
    3712:	4505                	li	a0,1
    3714:	7f8010ef          	jal	4f0c <exit>
    exit(0);
    3718:	4501                	li	a0,0
    371a:	7f2010ef          	jal	4f0c <exit>
  pause(1);
    371e:	4505                	li	a0,1
    3720:	07d010ef          	jal	4f9c <pause>
  if(unlink("oidir") != 0){
    3724:	00004517          	auipc	a0,0x4
    3728:	81450513          	addi	a0,a0,-2028 # 6f38 <malloc+0x1b54>
    372c:	031010ef          	jal	4f5c <unlink>
    3730:	c919                	beqz	a0,3746 <openiputtest+0xa2>
    printf("%s: unlink failed\n", s);
    3732:	85a6                	mv	a1,s1
    3734:	00003517          	auipc	a0,0x3
    3738:	86450513          	addi	a0,a0,-1948 # 5f98 <malloc+0xbb4>
    373c:	3f1010ef          	jal	532c <printf>
    exit(1);
    3740:	4505                	li	a0,1
    3742:	7ca010ef          	jal	4f0c <exit>
  wait(&xstatus);
    3746:	fdc40513          	addi	a0,s0,-36
    374a:	7ca010ef          	jal	4f14 <wait>
  exit(xstatus);
    374e:	fdc42503          	lw	a0,-36(s0)
    3752:	7ba010ef          	jal	4f0c <exit>

0000000000003756 <forkforkfork>:
{
    3756:	1101                	addi	sp,sp,-32
    3758:	ec06                	sd	ra,24(sp)
    375a:	e822                	sd	s0,16(sp)
    375c:	e426                	sd	s1,8(sp)
    375e:	1000                	addi	s0,sp,32
    3760:	84aa                	mv	s1,a0
  unlink("stopforking");
    3762:	00004517          	auipc	a0,0x4
    3766:	81e50513          	addi	a0,a0,-2018 # 6f80 <malloc+0x1b9c>
    376a:	7f2010ef          	jal	4f5c <unlink>
  int pid = fork();
    376e:	796010ef          	jal	4f04 <fork>
  if(pid < 0){
    3772:	02054b63          	bltz	a0,37a8 <forkforkfork+0x52>
  if(pid == 0){
    3776:	c139                	beqz	a0,37bc <forkforkfork+0x66>
  pause(20); // two seconds
    3778:	4551                	li	a0,20
    377a:	023010ef          	jal	4f9c <pause>
  close(open("stopforking", O_CREATE|O_RDWR));
    377e:	20200593          	li	a1,514
    3782:	00003517          	auipc	a0,0x3
    3786:	7fe50513          	addi	a0,a0,2046 # 6f80 <malloc+0x1b9c>
    378a:	7c2010ef          	jal	4f4c <open>
    378e:	7a6010ef          	jal	4f34 <close>
  wait(0);
    3792:	4501                	li	a0,0
    3794:	780010ef          	jal	4f14 <wait>
  pause(10); // one second
    3798:	4529                	li	a0,10
    379a:	003010ef          	jal	4f9c <pause>
}
    379e:	60e2                	ld	ra,24(sp)
    37a0:	6442                	ld	s0,16(sp)
    37a2:	64a2                	ld	s1,8(sp)
    37a4:	6105                	addi	sp,sp,32
    37a6:	8082                	ret
    printf("%s: fork failed", s);
    37a8:	85a6                	mv	a1,s1
    37aa:	00002517          	auipc	a0,0x2
    37ae:	7be50513          	addi	a0,a0,1982 # 5f68 <malloc+0xb84>
    37b2:	37b010ef          	jal	532c <printf>
    exit(1);
    37b6:	4505                	li	a0,1
    37b8:	754010ef          	jal	4f0c <exit>
      int fd = open("stopforking", 0);
    37bc:	00003497          	auipc	s1,0x3
    37c0:	7c448493          	addi	s1,s1,1988 # 6f80 <malloc+0x1b9c>
    37c4:	4581                	li	a1,0
    37c6:	8526                	mv	a0,s1
    37c8:	784010ef          	jal	4f4c <open>
      if(fd >= 0){
    37cc:	02055163          	bgez	a0,37ee <forkforkfork+0x98>
      if(fork() < 0){
    37d0:	734010ef          	jal	4f04 <fork>
    37d4:	fe0558e3          	bgez	a0,37c4 <forkforkfork+0x6e>
        close(open("stopforking", O_CREATE|O_RDWR));
    37d8:	20200593          	li	a1,514
    37dc:	00003517          	auipc	a0,0x3
    37e0:	7a450513          	addi	a0,a0,1956 # 6f80 <malloc+0x1b9c>
    37e4:	768010ef          	jal	4f4c <open>
    37e8:	74c010ef          	jal	4f34 <close>
    37ec:	bfe1                	j	37c4 <forkforkfork+0x6e>
        exit(0);
    37ee:	4501                	li	a0,0
    37f0:	71c010ef          	jal	4f0c <exit>

00000000000037f4 <killstatus>:
{
    37f4:	715d                	addi	sp,sp,-80
    37f6:	e486                	sd	ra,72(sp)
    37f8:	e0a2                	sd	s0,64(sp)
    37fa:	fc26                	sd	s1,56(sp)
    37fc:	f84a                	sd	s2,48(sp)
    37fe:	f44e                	sd	s3,40(sp)
    3800:	f052                	sd	s4,32(sp)
    3802:	ec56                	sd	s5,24(sp)
    3804:	e85a                	sd	s6,16(sp)
    3806:	0880                	addi	s0,sp,80
    3808:	8b2a                	mv	s6,a0
    380a:	06400913          	li	s2,100
    pause(1);
    380e:	4a85                	li	s5,1
    wait(&xst);
    3810:	fbc40a13          	addi	s4,s0,-68
    if(xst != -1) {
    3814:	59fd                	li	s3,-1
    int pid1 = fork();
    3816:	6ee010ef          	jal	4f04 <fork>
    381a:	84aa                	mv	s1,a0
    if(pid1 < 0){
    381c:	02054663          	bltz	a0,3848 <killstatus+0x54>
    if(pid1 == 0){
    3820:	cd15                	beqz	a0,385c <killstatus+0x68>
    pause(1);
    3822:	8556                	mv	a0,s5
    3824:	778010ef          	jal	4f9c <pause>
    kill(pid1);
    3828:	8526                	mv	a0,s1
    382a:	712010ef          	jal	4f3c <kill>
    wait(&xst);
    382e:	8552                	mv	a0,s4
    3830:	6e4010ef          	jal	4f14 <wait>
    if(xst != -1) {
    3834:	fbc42783          	lw	a5,-68(s0)
    3838:	03379563          	bne	a5,s3,3862 <killstatus+0x6e>
  for(int i = 0; i < 100; i++){
    383c:	397d                	addiw	s2,s2,-1
    383e:	fc091ce3          	bnez	s2,3816 <killstatus+0x22>
  exit(0);
    3842:	4501                	li	a0,0
    3844:	6c8010ef          	jal	4f0c <exit>
      printf("%s: fork failed\n", s);
    3848:	85da                	mv	a1,s6
    384a:	00002517          	auipc	a0,0x2
    384e:	55e50513          	addi	a0,a0,1374 # 5da8 <malloc+0x9c4>
    3852:	2db010ef          	jal	532c <printf>
      exit(1);
    3856:	4505                	li	a0,1
    3858:	6b4010ef          	jal	4f0c <exit>
        getpid();
    385c:	730010ef          	jal	4f8c <getpid>
      while(1) {
    3860:	bff5                	j	385c <killstatus+0x68>
       printf("%s: status should be -1\n", s);
    3862:	85da                	mv	a1,s6
    3864:	00003517          	auipc	a0,0x3
    3868:	72c50513          	addi	a0,a0,1836 # 6f90 <malloc+0x1bac>
    386c:	2c1010ef          	jal	532c <printf>
       exit(1);
    3870:	4505                	li	a0,1
    3872:	69a010ef          	jal	4f0c <exit>

0000000000003876 <preempt>:
{
    3876:	7139                	addi	sp,sp,-64
    3878:	fc06                	sd	ra,56(sp)
    387a:	f822                	sd	s0,48(sp)
    387c:	f426                	sd	s1,40(sp)
    387e:	f04a                	sd	s2,32(sp)
    3880:	ec4e                	sd	s3,24(sp)
    3882:	e852                	sd	s4,16(sp)
    3884:	0080                	addi	s0,sp,64
    3886:	892a                	mv	s2,a0
  pid1 = fork();
    3888:	67c010ef          	jal	4f04 <fork>
  if(pid1 < 0) {
    388c:	00054563          	bltz	a0,3896 <preempt+0x20>
    3890:	84aa                	mv	s1,a0
  if(pid1 == 0)
    3892:	ed01                	bnez	a0,38aa <preempt+0x34>
    for(;;)
    3894:	a001                	j	3894 <preempt+0x1e>
    printf("%s: fork failed", s);
    3896:	85ca                	mv	a1,s2
    3898:	00002517          	auipc	a0,0x2
    389c:	6d050513          	addi	a0,a0,1744 # 5f68 <malloc+0xb84>
    38a0:	28d010ef          	jal	532c <printf>
    exit(1);
    38a4:	4505                	li	a0,1
    38a6:	666010ef          	jal	4f0c <exit>
  pid2 = fork();
    38aa:	65a010ef          	jal	4f04 <fork>
    38ae:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    38b0:	00054463          	bltz	a0,38b8 <preempt+0x42>
  if(pid2 == 0)
    38b4:	ed01                	bnez	a0,38cc <preempt+0x56>
    for(;;)
    38b6:	a001                	j	38b6 <preempt+0x40>
    printf("%s: fork failed\n", s);
    38b8:	85ca                	mv	a1,s2
    38ba:	00002517          	auipc	a0,0x2
    38be:	4ee50513          	addi	a0,a0,1262 # 5da8 <malloc+0x9c4>
    38c2:	26b010ef          	jal	532c <printf>
    exit(1);
    38c6:	4505                	li	a0,1
    38c8:	644010ef          	jal	4f0c <exit>
  pipe(pfds);
    38cc:	fc840513          	addi	a0,s0,-56
    38d0:	64c010ef          	jal	4f1c <pipe>
  pid3 = fork();
    38d4:	630010ef          	jal	4f04 <fork>
    38d8:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    38da:	02054863          	bltz	a0,390a <preempt+0x94>
  if(pid3 == 0){
    38de:	e921                	bnez	a0,392e <preempt+0xb8>
    close(pfds[0]);
    38e0:	fc842503          	lw	a0,-56(s0)
    38e4:	650010ef          	jal	4f34 <close>
    if(write(pfds[1], "x", 1) != 1)
    38e8:	4605                	li	a2,1
    38ea:	00002597          	auipc	a1,0x2
    38ee:	c9e58593          	addi	a1,a1,-866 # 5588 <malloc+0x1a4>
    38f2:	fcc42503          	lw	a0,-52(s0)
    38f6:	636010ef          	jal	4f2c <write>
    38fa:	4785                	li	a5,1
    38fc:	02f51163          	bne	a0,a5,391e <preempt+0xa8>
    close(pfds[1]);
    3900:	fcc42503          	lw	a0,-52(s0)
    3904:	630010ef          	jal	4f34 <close>
    for(;;)
    3908:	a001                	j	3908 <preempt+0x92>
     printf("%s: fork failed\n", s);
    390a:	85ca                	mv	a1,s2
    390c:	00002517          	auipc	a0,0x2
    3910:	49c50513          	addi	a0,a0,1180 # 5da8 <malloc+0x9c4>
    3914:	219010ef          	jal	532c <printf>
     exit(1);
    3918:	4505                	li	a0,1
    391a:	5f2010ef          	jal	4f0c <exit>
      printf("%s: preempt write error", s);
    391e:	85ca                	mv	a1,s2
    3920:	00003517          	auipc	a0,0x3
    3924:	69050513          	addi	a0,a0,1680 # 6fb0 <malloc+0x1bcc>
    3928:	205010ef          	jal	532c <printf>
    392c:	bfd1                	j	3900 <preempt+0x8a>
  close(pfds[1]);
    392e:	fcc42503          	lw	a0,-52(s0)
    3932:	602010ef          	jal	4f34 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    3936:	660d                	lui	a2,0x3
    3938:	0000a597          	auipc	a1,0xa
    393c:	37058593          	addi	a1,a1,880 # dca8 <buf>
    3940:	fc842503          	lw	a0,-56(s0)
    3944:	5e0010ef          	jal	4f24 <read>
    3948:	4785                	li	a5,1
    394a:	02f50163          	beq	a0,a5,396c <preempt+0xf6>
    printf("%s: preempt read error", s);
    394e:	85ca                	mv	a1,s2
    3950:	00003517          	auipc	a0,0x3
    3954:	67850513          	addi	a0,a0,1656 # 6fc8 <malloc+0x1be4>
    3958:	1d5010ef          	jal	532c <printf>
}
    395c:	70e2                	ld	ra,56(sp)
    395e:	7442                	ld	s0,48(sp)
    3960:	74a2                	ld	s1,40(sp)
    3962:	7902                	ld	s2,32(sp)
    3964:	69e2                	ld	s3,24(sp)
    3966:	6a42                	ld	s4,16(sp)
    3968:	6121                	addi	sp,sp,64
    396a:	8082                	ret
  close(pfds[0]);
    396c:	fc842503          	lw	a0,-56(s0)
    3970:	5c4010ef          	jal	4f34 <close>
  printf("kill... ");
    3974:	00003517          	auipc	a0,0x3
    3978:	66c50513          	addi	a0,a0,1644 # 6fe0 <malloc+0x1bfc>
    397c:	1b1010ef          	jal	532c <printf>
  kill(pid1);
    3980:	8526                	mv	a0,s1
    3982:	5ba010ef          	jal	4f3c <kill>
  kill(pid2);
    3986:	854e                	mv	a0,s3
    3988:	5b4010ef          	jal	4f3c <kill>
  kill(pid3);
    398c:	8552                	mv	a0,s4
    398e:	5ae010ef          	jal	4f3c <kill>
  printf("wait... ");
    3992:	00003517          	auipc	a0,0x3
    3996:	65e50513          	addi	a0,a0,1630 # 6ff0 <malloc+0x1c0c>
    399a:	193010ef          	jal	532c <printf>
  wait(0);
    399e:	4501                	li	a0,0
    39a0:	574010ef          	jal	4f14 <wait>
  wait(0);
    39a4:	4501                	li	a0,0
    39a6:	56e010ef          	jal	4f14 <wait>
  wait(0);
    39aa:	4501                	li	a0,0
    39ac:	568010ef          	jal	4f14 <wait>
    39b0:	b775                	j	395c <preempt+0xe6>

00000000000039b2 <reparent>:
{
    39b2:	7179                	addi	sp,sp,-48
    39b4:	f406                	sd	ra,40(sp)
    39b6:	f022                	sd	s0,32(sp)
    39b8:	ec26                	sd	s1,24(sp)
    39ba:	e84a                	sd	s2,16(sp)
    39bc:	e44e                	sd	s3,8(sp)
    39be:	e052                	sd	s4,0(sp)
    39c0:	1800                	addi	s0,sp,48
    39c2:	89aa                	mv	s3,a0
  int master_pid = getpid();
    39c4:	5c8010ef          	jal	4f8c <getpid>
    39c8:	8a2a                	mv	s4,a0
    39ca:	0c800913          	li	s2,200
    int pid = fork();
    39ce:	536010ef          	jal	4f04 <fork>
    39d2:	84aa                	mv	s1,a0
    if(pid < 0){
    39d4:	00054e63          	bltz	a0,39f0 <reparent+0x3e>
    if(pid){
    39d8:	c121                	beqz	a0,3a18 <reparent+0x66>
      if(wait(0) != pid){
    39da:	4501                	li	a0,0
    39dc:	538010ef          	jal	4f14 <wait>
    39e0:	02951263          	bne	a0,s1,3a04 <reparent+0x52>
  for(int i = 0; i < 200; i++){
    39e4:	397d                	addiw	s2,s2,-1
    39e6:	fe0914e3          	bnez	s2,39ce <reparent+0x1c>
  exit(0);
    39ea:	4501                	li	a0,0
    39ec:	520010ef          	jal	4f0c <exit>
      printf("%s: fork failed\n", s);
    39f0:	85ce                	mv	a1,s3
    39f2:	00002517          	auipc	a0,0x2
    39f6:	3b650513          	addi	a0,a0,950 # 5da8 <malloc+0x9c4>
    39fa:	133010ef          	jal	532c <printf>
      exit(1);
    39fe:	4505                	li	a0,1
    3a00:	50c010ef          	jal	4f0c <exit>
        printf("%s: wait wrong pid\n", s);
    3a04:	85ce                	mv	a1,s3
    3a06:	00002517          	auipc	a0,0x2
    3a0a:	52a50513          	addi	a0,a0,1322 # 5f30 <malloc+0xb4c>
    3a0e:	11f010ef          	jal	532c <printf>
        exit(1);
    3a12:	4505                	li	a0,1
    3a14:	4f8010ef          	jal	4f0c <exit>
      int pid2 = fork();
    3a18:	4ec010ef          	jal	4f04 <fork>
      if(pid2 < 0){
    3a1c:	00054563          	bltz	a0,3a26 <reparent+0x74>
      exit(0);
    3a20:	4501                	li	a0,0
    3a22:	4ea010ef          	jal	4f0c <exit>
        kill(master_pid);
    3a26:	8552                	mv	a0,s4
    3a28:	514010ef          	jal	4f3c <kill>
        exit(1);
    3a2c:	4505                	li	a0,1
    3a2e:	4de010ef          	jal	4f0c <exit>

0000000000003a32 <sbrkfail>:
{
    3a32:	7175                	addi	sp,sp,-144
    3a34:	e506                	sd	ra,136(sp)
    3a36:	e122                	sd	s0,128(sp)
    3a38:	fca6                	sd	s1,120(sp)
    3a3a:	f8ca                	sd	s2,112(sp)
    3a3c:	f4ce                	sd	s3,104(sp)
    3a3e:	f0d2                	sd	s4,96(sp)
    3a40:	ecd6                	sd	s5,88(sp)
    3a42:	e8da                	sd	s6,80(sp)
    3a44:	e4de                	sd	s7,72(sp)
    3a46:	e0e2                	sd	s8,64(sp)
    3a48:	0900                	addi	s0,sp,144
    3a4a:	8baa                	mv	s7,a0
  if(pipe(fds) != 0){
    3a4c:	fa040513          	addi	a0,s0,-96
    3a50:	4cc010ef          	jal	4f1c <pipe>
    3a54:	ed01                	bnez	a0,3a6c <sbrkfail+0x3a>
    3a56:	8c2a                	mv	s8,a0
    3a58:	f7040493          	addi	s1,s0,-144
    3a5c:	f9840993          	addi	s3,s0,-104
    3a60:	8926                	mv	s2,s1
    if(pids[i] != -1) {
    3a62:	5a7d                	li	s4,-1
      read(fds[0], &scratch, 1);
    3a64:	f9f40b13          	addi	s6,s0,-97
    3a68:	4a85                	li	s5,1
    3a6a:	a095                	j	3ace <sbrkfail+0x9c>
    printf("%s: pipe() failed\n", s);
    3a6c:	85de                	mv	a1,s7
    3a6e:	00002517          	auipc	a0,0x2
    3a72:	44250513          	addi	a0,a0,1090 # 5eb0 <malloc+0xacc>
    3a76:	0b7010ef          	jal	532c <printf>
    exit(1);
    3a7a:	4505                	li	a0,1
    3a7c:	490010ef          	jal	4f0c <exit>
      if (sbrk(BIG - (uint64)sbrk(0)) ==  (char*)SBRK_ERROR)
    3a80:	458010ef          	jal	4ed8 <sbrk>
    3a84:	064007b7          	lui	a5,0x6400
    3a88:	40a7853b          	subw	a0,a5,a0
    3a8c:	44c010ef          	jal	4ed8 <sbrk>
    3a90:	57fd                	li	a5,-1
    3a92:	02f50163          	beq	a0,a5,3ab4 <sbrkfail+0x82>
        write(fds[1], "1", 1);
    3a96:	4605                	li	a2,1
    3a98:	00004597          	auipc	a1,0x4
    3a9c:	bf858593          	addi	a1,a1,-1032 # 7690 <malloc+0x22ac>
    3aa0:	fa442503          	lw	a0,-92(s0)
    3aa4:	488010ef          	jal	4f2c <write>
      for(;;) pause(1000);
    3aa8:	3e800493          	li	s1,1000
    3aac:	8526                	mv	a0,s1
    3aae:	4ee010ef          	jal	4f9c <pause>
    3ab2:	bfed                	j	3aac <sbrkfail+0x7a>
        write(fds[1], "0", 1);
    3ab4:	4605                	li	a2,1
    3ab6:	00003597          	auipc	a1,0x3
    3aba:	54a58593          	addi	a1,a1,1354 # 7000 <malloc+0x1c1c>
    3abe:	fa442503          	lw	a0,-92(s0)
    3ac2:	46a010ef          	jal	4f2c <write>
    3ac6:	b7cd                	j	3aa8 <sbrkfail+0x76>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3ac8:	0911                	addi	s2,s2,4
    3aca:	03390a63          	beq	s2,s3,3afe <sbrkfail+0xcc>
    if((pids[i] = fork()) == 0){
    3ace:	436010ef          	jal	4f04 <fork>
    3ad2:	00a92023          	sw	a0,0(s2)
    3ad6:	d54d                	beqz	a0,3a80 <sbrkfail+0x4e>
    if(pids[i] != -1) {
    3ad8:	ff4508e3          	beq	a0,s4,3ac8 <sbrkfail+0x96>
      read(fds[0], &scratch, 1);
    3adc:	8656                	mv	a2,s5
    3ade:	85da                	mv	a1,s6
    3ae0:	fa042503          	lw	a0,-96(s0)
    3ae4:	440010ef          	jal	4f24 <read>
      if(scratch == '0')
    3ae8:	f9f44783          	lbu	a5,-97(s0)
    3aec:	fd078793          	addi	a5,a5,-48 # 63fffd0 <base+0x63ef328>
    3af0:	0017b793          	seqz	a5,a5
    3af4:	00fc67b3          	or	a5,s8,a5
    3af8:	00078c1b          	sext.w	s8,a5
    3afc:	b7f1                	j	3ac8 <sbrkfail+0x96>
  if(!failed) {
    3afe:	000c0863          	beqz	s8,3b0e <sbrkfail+0xdc>
  c = sbrk(PGSIZE);
    3b02:	6505                	lui	a0,0x1
    3b04:	3d4010ef          	jal	4ed8 <sbrk>
    3b08:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    3b0a:	597d                	li	s2,-1
    3b0c:	a821                	j	3b24 <sbrkfail+0xf2>
    printf("%s: no allocation failed; allocate more?\n", s);
    3b0e:	85de                	mv	a1,s7
    3b10:	00003517          	auipc	a0,0x3
    3b14:	4f850513          	addi	a0,a0,1272 # 7008 <malloc+0x1c24>
    3b18:	015010ef          	jal	532c <printf>
    3b1c:	b7dd                	j	3b02 <sbrkfail+0xd0>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3b1e:	0491                	addi	s1,s1,4
    3b20:	01348b63          	beq	s1,s3,3b36 <sbrkfail+0x104>
    if(pids[i] == -1)
    3b24:	4088                	lw	a0,0(s1)
    3b26:	ff250ce3          	beq	a0,s2,3b1e <sbrkfail+0xec>
    kill(pids[i]);
    3b2a:	412010ef          	jal	4f3c <kill>
    wait(0);
    3b2e:	4501                	li	a0,0
    3b30:	3e4010ef          	jal	4f14 <wait>
    3b34:	b7ed                	j	3b1e <sbrkfail+0xec>
  if(c == (char*)SBRK_ERROR){
    3b36:	57fd                	li	a5,-1
    3b38:	02fa0a63          	beq	s4,a5,3b6c <sbrkfail+0x13a>
  pid = fork();
    3b3c:	3c8010ef          	jal	4f04 <fork>
  if(pid < 0){
    3b40:	04054063          	bltz	a0,3b80 <sbrkfail+0x14e>
  if(pid == 0){
    3b44:	e939                	bnez	a0,3b9a <sbrkfail+0x168>
    a = sbrk(10*BIG);
    3b46:	3e800537          	lui	a0,0x3e800
    3b4a:	38e010ef          	jal	4ed8 <sbrk>
    if(a == (char*)SBRK_ERROR){
    3b4e:	57fd                	li	a5,-1
    3b50:	04f50263          	beq	a0,a5,3b94 <sbrkfail+0x162>
    printf("%s: allocate a lot of memory succeeded %d\n", s, 10*BIG);
    3b54:	3e800637          	lui	a2,0x3e800
    3b58:	85de                	mv	a1,s7
    3b5a:	00003517          	auipc	a0,0x3
    3b5e:	4fe50513          	addi	a0,a0,1278 # 7058 <malloc+0x1c74>
    3b62:	7ca010ef          	jal	532c <printf>
    exit(1);
    3b66:	4505                	li	a0,1
    3b68:	3a4010ef          	jal	4f0c <exit>
    printf("%s: failed sbrk leaked memory\n", s);
    3b6c:	85de                	mv	a1,s7
    3b6e:	00003517          	auipc	a0,0x3
    3b72:	4ca50513          	addi	a0,a0,1226 # 7038 <malloc+0x1c54>
    3b76:	7b6010ef          	jal	532c <printf>
    exit(1);
    3b7a:	4505                	li	a0,1
    3b7c:	390010ef          	jal	4f0c <exit>
    printf("%s: fork failed\n", s);
    3b80:	85de                	mv	a1,s7
    3b82:	00002517          	auipc	a0,0x2
    3b86:	22650513          	addi	a0,a0,550 # 5da8 <malloc+0x9c4>
    3b8a:	7a2010ef          	jal	532c <printf>
    exit(1);
    3b8e:	4505                	li	a0,1
    3b90:	37c010ef          	jal	4f0c <exit>
      exit(0);
    3b94:	4501                	li	a0,0
    3b96:	376010ef          	jal	4f0c <exit>
  wait(&xstatus);
    3b9a:	fac40513          	addi	a0,s0,-84
    3b9e:	376010ef          	jal	4f14 <wait>
  if(xstatus != 0)
    3ba2:	fac42783          	lw	a5,-84(s0)
    3ba6:	ef89                	bnez	a5,3bc0 <sbrkfail+0x18e>
}
    3ba8:	60aa                	ld	ra,136(sp)
    3baa:	640a                	ld	s0,128(sp)
    3bac:	74e6                	ld	s1,120(sp)
    3bae:	7946                	ld	s2,112(sp)
    3bb0:	79a6                	ld	s3,104(sp)
    3bb2:	7a06                	ld	s4,96(sp)
    3bb4:	6ae6                	ld	s5,88(sp)
    3bb6:	6b46                	ld	s6,80(sp)
    3bb8:	6ba6                	ld	s7,72(sp)
    3bba:	6c06                	ld	s8,64(sp)
    3bbc:	6149                	addi	sp,sp,144
    3bbe:	8082                	ret
    exit(1);
    3bc0:	4505                	li	a0,1
    3bc2:	34a010ef          	jal	4f0c <exit>

0000000000003bc6 <mem>:
{
    3bc6:	7139                	addi	sp,sp,-64
    3bc8:	fc06                	sd	ra,56(sp)
    3bca:	f822                	sd	s0,48(sp)
    3bcc:	f426                	sd	s1,40(sp)
    3bce:	f04a                	sd	s2,32(sp)
    3bd0:	ec4e                	sd	s3,24(sp)
    3bd2:	0080                	addi	s0,sp,64
    3bd4:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    3bd6:	32e010ef          	jal	4f04 <fork>
    m1 = 0;
    3bda:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    3bdc:	6909                	lui	s2,0x2
    3bde:	71190913          	addi	s2,s2,1809 # 2711 <execout+0x3d>
  if((pid = fork()) == 0){
    3be2:	cd11                	beqz	a0,3bfe <mem+0x38>
    wait(&xstatus);
    3be4:	fcc40513          	addi	a0,s0,-52
    3be8:	32c010ef          	jal	4f14 <wait>
    if(xstatus == -1){
    3bec:	fcc42503          	lw	a0,-52(s0)
    3bf0:	57fd                	li	a5,-1
    3bf2:	04f50363          	beq	a0,a5,3c38 <mem+0x72>
    exit(xstatus);
    3bf6:	316010ef          	jal	4f0c <exit>
      *(char**)m2 = m1;
    3bfa:	e104                	sd	s1,0(a0)
      m1 = m2;
    3bfc:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    3bfe:	854a                	mv	a0,s2
    3c00:	7e4010ef          	jal	53e4 <malloc>
    3c04:	f97d                	bnez	a0,3bfa <mem+0x34>
    while(m1){
    3c06:	c491                	beqz	s1,3c12 <mem+0x4c>
      m2 = *(char**)m1;
    3c08:	8526                	mv	a0,s1
    3c0a:	6084                	ld	s1,0(s1)
      free(m1);
    3c0c:	752010ef          	jal	535e <free>
    while(m1){
    3c10:	fce5                	bnez	s1,3c08 <mem+0x42>
    m1 = malloc(1024*20);
    3c12:	6515                	lui	a0,0x5
    3c14:	7d0010ef          	jal	53e4 <malloc>
    if(m1 == 0){
    3c18:	c511                	beqz	a0,3c24 <mem+0x5e>
    free(m1);
    3c1a:	744010ef          	jal	535e <free>
    exit(0);
    3c1e:	4501                	li	a0,0
    3c20:	2ec010ef          	jal	4f0c <exit>
      printf("%s: couldn't allocate mem?!!\n", s);
    3c24:	85ce                	mv	a1,s3
    3c26:	00003517          	auipc	a0,0x3
    3c2a:	46250513          	addi	a0,a0,1122 # 7088 <malloc+0x1ca4>
    3c2e:	6fe010ef          	jal	532c <printf>
      exit(1);
    3c32:	4505                	li	a0,1
    3c34:	2d8010ef          	jal	4f0c <exit>
      exit(0);
    3c38:	4501                	li	a0,0
    3c3a:	2d2010ef          	jal	4f0c <exit>

0000000000003c3e <sharedfd>:
{
    3c3e:	7119                	addi	sp,sp,-128
    3c40:	fc86                	sd	ra,120(sp)
    3c42:	f8a2                	sd	s0,112(sp)
    3c44:	e0da                	sd	s6,64(sp)
    3c46:	0100                	addi	s0,sp,128
    3c48:	8b2a                	mv	s6,a0
  unlink("sharedfd");
    3c4a:	00003517          	auipc	a0,0x3
    3c4e:	45e50513          	addi	a0,a0,1118 # 70a8 <malloc+0x1cc4>
    3c52:	30a010ef          	jal	4f5c <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    3c56:	20200593          	li	a1,514
    3c5a:	00003517          	auipc	a0,0x3
    3c5e:	44e50513          	addi	a0,a0,1102 # 70a8 <malloc+0x1cc4>
    3c62:	2ea010ef          	jal	4f4c <open>
  if(fd < 0){
    3c66:	04054b63          	bltz	a0,3cbc <sharedfd+0x7e>
    3c6a:	f4a6                	sd	s1,104(sp)
    3c6c:	f0ca                	sd	s2,96(sp)
    3c6e:	ecce                	sd	s3,88(sp)
    3c70:	e8d2                	sd	s4,80(sp)
    3c72:	e4d6                	sd	s5,72(sp)
    3c74:	89aa                	mv	s3,a0
  pid = fork();
    3c76:	28e010ef          	jal	4f04 <fork>
    3c7a:	8aaa                	mv	s5,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    3c7c:	07000593          	li	a1,112
    3c80:	e119                	bnez	a0,3c86 <sharedfd+0x48>
    3c82:	06300593          	li	a1,99
    3c86:	4629                	li	a2,10
    3c88:	f9040513          	addi	a0,s0,-112
    3c8c:	046010ef          	jal	4cd2 <memset>
    3c90:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    3c94:	f9040a13          	addi	s4,s0,-112
    3c98:	4929                	li	s2,10
    3c9a:	864a                	mv	a2,s2
    3c9c:	85d2                	mv	a1,s4
    3c9e:	854e                	mv	a0,s3
    3ca0:	28c010ef          	jal	4f2c <write>
    3ca4:	03251e63          	bne	a0,s2,3ce0 <sharedfd+0xa2>
  for(i = 0; i < N; i++){
    3ca8:	34fd                	addiw	s1,s1,-1
    3caa:	f8e5                	bnez	s1,3c9a <sharedfd+0x5c>
  if(pid == 0) {
    3cac:	040a9763          	bnez	s5,3cfa <sharedfd+0xbc>
    3cb0:	fc5e                	sd	s7,56(sp)
    3cb2:	f862                	sd	s8,48(sp)
    3cb4:	f466                	sd	s9,40(sp)
    exit(0);
    3cb6:	4501                	li	a0,0
    3cb8:	254010ef          	jal	4f0c <exit>
    3cbc:	f4a6                	sd	s1,104(sp)
    3cbe:	f0ca                	sd	s2,96(sp)
    3cc0:	ecce                	sd	s3,88(sp)
    3cc2:	e8d2                	sd	s4,80(sp)
    3cc4:	e4d6                	sd	s5,72(sp)
    3cc6:	fc5e                	sd	s7,56(sp)
    3cc8:	f862                	sd	s8,48(sp)
    3cca:	f466                	sd	s9,40(sp)
    printf("%s: cannot open sharedfd for writing", s);
    3ccc:	85da                	mv	a1,s6
    3cce:	00003517          	auipc	a0,0x3
    3cd2:	3ea50513          	addi	a0,a0,1002 # 70b8 <malloc+0x1cd4>
    3cd6:	656010ef          	jal	532c <printf>
    exit(1);
    3cda:	4505                	li	a0,1
    3cdc:	230010ef          	jal	4f0c <exit>
    3ce0:	fc5e                	sd	s7,56(sp)
    3ce2:	f862                	sd	s8,48(sp)
    3ce4:	f466                	sd	s9,40(sp)
      printf("%s: write sharedfd failed\n", s);
    3ce6:	85da                	mv	a1,s6
    3ce8:	00003517          	auipc	a0,0x3
    3cec:	3f850513          	addi	a0,a0,1016 # 70e0 <malloc+0x1cfc>
    3cf0:	63c010ef          	jal	532c <printf>
      exit(1);
    3cf4:	4505                	li	a0,1
    3cf6:	216010ef          	jal	4f0c <exit>
    wait(&xstatus);
    3cfa:	f8c40513          	addi	a0,s0,-116
    3cfe:	216010ef          	jal	4f14 <wait>
    if(xstatus != 0)
    3d02:	f8c42a03          	lw	s4,-116(s0)
    3d06:	000a0863          	beqz	s4,3d16 <sharedfd+0xd8>
    3d0a:	fc5e                	sd	s7,56(sp)
    3d0c:	f862                	sd	s8,48(sp)
    3d0e:	f466                	sd	s9,40(sp)
      exit(xstatus);
    3d10:	8552                	mv	a0,s4
    3d12:	1fa010ef          	jal	4f0c <exit>
    3d16:	fc5e                	sd	s7,56(sp)
  close(fd);
    3d18:	854e                	mv	a0,s3
    3d1a:	21a010ef          	jal	4f34 <close>
  fd = open("sharedfd", 0);
    3d1e:	4581                	li	a1,0
    3d20:	00003517          	auipc	a0,0x3
    3d24:	38850513          	addi	a0,a0,904 # 70a8 <malloc+0x1cc4>
    3d28:	224010ef          	jal	4f4c <open>
    3d2c:	8baa                	mv	s7,a0
  nc = np = 0;
    3d2e:	89d2                	mv	s3,s4
  if(fd < 0){
    3d30:	02054763          	bltz	a0,3d5e <sharedfd+0x120>
    3d34:	f862                	sd	s8,48(sp)
    3d36:	f466                	sd	s9,40(sp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3d38:	f9040c93          	addi	s9,s0,-112
    3d3c:	4c29                	li	s8,10
    3d3e:	f9a40913          	addi	s2,s0,-102
      if(buf[i] == 'c')
    3d42:	06300493          	li	s1,99
      if(buf[i] == 'p')
    3d46:	07000a93          	li	s5,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3d4a:	8662                	mv	a2,s8
    3d4c:	85e6                	mv	a1,s9
    3d4e:	855e                	mv	a0,s7
    3d50:	1d4010ef          	jal	4f24 <read>
    3d54:	02a05d63          	blez	a0,3d8e <sharedfd+0x150>
    3d58:	f9040793          	addi	a5,s0,-112
    3d5c:	a00d                	j	3d7e <sharedfd+0x140>
    3d5e:	f862                	sd	s8,48(sp)
    3d60:	f466                	sd	s9,40(sp)
    printf("%s: cannot open sharedfd for reading\n", s);
    3d62:	85da                	mv	a1,s6
    3d64:	00003517          	auipc	a0,0x3
    3d68:	39c50513          	addi	a0,a0,924 # 7100 <malloc+0x1d1c>
    3d6c:	5c0010ef          	jal	532c <printf>
    exit(1);
    3d70:	4505                	li	a0,1
    3d72:	19a010ef          	jal	4f0c <exit>
        nc++;
    3d76:	2a05                	addiw	s4,s4,1
    for(i = 0; i < sizeof(buf); i++){
    3d78:	0785                	addi	a5,a5,1
    3d7a:	fd2788e3          	beq	a5,s2,3d4a <sharedfd+0x10c>
      if(buf[i] == 'c')
    3d7e:	0007c703          	lbu	a4,0(a5)
    3d82:	fe970ae3          	beq	a4,s1,3d76 <sharedfd+0x138>
      if(buf[i] == 'p')
    3d86:	ff5719e3          	bne	a4,s5,3d78 <sharedfd+0x13a>
        np++;
    3d8a:	2985                	addiw	s3,s3,1
    3d8c:	b7f5                	j	3d78 <sharedfd+0x13a>
  close(fd);
    3d8e:	855e                	mv	a0,s7
    3d90:	1a4010ef          	jal	4f34 <close>
  unlink("sharedfd");
    3d94:	00003517          	auipc	a0,0x3
    3d98:	31450513          	addi	a0,a0,788 # 70a8 <malloc+0x1cc4>
    3d9c:	1c0010ef          	jal	4f5c <unlink>
  if(nc == N*SZ && np == N*SZ){
    3da0:	6789                	lui	a5,0x2
    3da2:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x3c>
    3da6:	00fa1763          	bne	s4,a5,3db4 <sharedfd+0x176>
    3daa:	6789                	lui	a5,0x2
    3dac:	71078793          	addi	a5,a5,1808 # 2710 <execout+0x3c>
    3db0:	00f98c63          	beq	s3,a5,3dc8 <sharedfd+0x18a>
    printf("%s: nc/np test fails\n", s);
    3db4:	85da                	mv	a1,s6
    3db6:	00003517          	auipc	a0,0x3
    3dba:	37250513          	addi	a0,a0,882 # 7128 <malloc+0x1d44>
    3dbe:	56e010ef          	jal	532c <printf>
    exit(1);
    3dc2:	4505                	li	a0,1
    3dc4:	148010ef          	jal	4f0c <exit>
    exit(0);
    3dc8:	4501                	li	a0,0
    3dca:	142010ef          	jal	4f0c <exit>

0000000000003dce <fourfiles>:
{
    3dce:	7135                	addi	sp,sp,-160
    3dd0:	ed06                	sd	ra,152(sp)
    3dd2:	e922                	sd	s0,144(sp)
    3dd4:	e526                	sd	s1,136(sp)
    3dd6:	e14a                	sd	s2,128(sp)
    3dd8:	fcce                	sd	s3,120(sp)
    3dda:	f8d2                	sd	s4,112(sp)
    3ddc:	f4d6                	sd	s5,104(sp)
    3dde:	f0da                	sd	s6,96(sp)
    3de0:	ecde                	sd	s7,88(sp)
    3de2:	e8e2                	sd	s8,80(sp)
    3de4:	e4e6                	sd	s9,72(sp)
    3de6:	e0ea                	sd	s10,64(sp)
    3de8:	fc6e                	sd	s11,56(sp)
    3dea:	1100                	addi	s0,sp,160
    3dec:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    3dee:	00003797          	auipc	a5,0x3
    3df2:	35278793          	addi	a5,a5,850 # 7140 <malloc+0x1d5c>
    3df6:	f6f43823          	sd	a5,-144(s0)
    3dfa:	00003797          	auipc	a5,0x3
    3dfe:	34e78793          	addi	a5,a5,846 # 7148 <malloc+0x1d64>
    3e02:	f6f43c23          	sd	a5,-136(s0)
    3e06:	00003797          	auipc	a5,0x3
    3e0a:	34a78793          	addi	a5,a5,842 # 7150 <malloc+0x1d6c>
    3e0e:	f8f43023          	sd	a5,-128(s0)
    3e12:	00003797          	auipc	a5,0x3
    3e16:	34678793          	addi	a5,a5,838 # 7158 <malloc+0x1d74>
    3e1a:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    3e1e:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    3e22:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    3e24:	4481                	li	s1,0
    3e26:	4a11                	li	s4,4
    fname = names[pi];
    3e28:	00093983          	ld	s3,0(s2)
    unlink(fname);
    3e2c:	854e                	mv	a0,s3
    3e2e:	12e010ef          	jal	4f5c <unlink>
    pid = fork();
    3e32:	0d2010ef          	jal	4f04 <fork>
    if(pid < 0){
    3e36:	04054063          	bltz	a0,3e76 <fourfiles+0xa8>
    if(pid == 0){
    3e3a:	c921                	beqz	a0,3e8a <fourfiles+0xbc>
  for(pi = 0; pi < NCHILD; pi++){
    3e3c:	2485                	addiw	s1,s1,1
    3e3e:	0921                	addi	s2,s2,8
    3e40:	ff4494e3          	bne	s1,s4,3e28 <fourfiles+0x5a>
    3e44:	4491                	li	s1,4
    wait(&xstatus);
    3e46:	f6c40913          	addi	s2,s0,-148
    3e4a:	854a                	mv	a0,s2
    3e4c:	0c8010ef          	jal	4f14 <wait>
    if(xstatus != 0)
    3e50:	f6c42b03          	lw	s6,-148(s0)
    3e54:	0a0b1463          	bnez	s6,3efc <fourfiles+0x12e>
  for(pi = 0; pi < NCHILD; pi++){
    3e58:	34fd                	addiw	s1,s1,-1
    3e5a:	f8e5                	bnez	s1,3e4a <fourfiles+0x7c>
    3e5c:	03000493          	li	s1,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3e60:	6a8d                	lui	s5,0x3
    3e62:	0000aa17          	auipc	s4,0xa
    3e66:	e46a0a13          	addi	s4,s4,-442 # dca8 <buf>
    if(total != N*SZ){
    3e6a:	6d05                	lui	s10,0x1
    3e6c:	770d0d13          	addi	s10,s10,1904 # 1770 <exitwait+0x90>
  for(i = 0; i < NCHILD; i++){
    3e70:	03400d93          	li	s11,52
    3e74:	a86d                	j	3f2e <fourfiles+0x160>
      printf("%s: fork failed\n", s);
    3e76:	85e6                	mv	a1,s9
    3e78:	00002517          	auipc	a0,0x2
    3e7c:	f3050513          	addi	a0,a0,-208 # 5da8 <malloc+0x9c4>
    3e80:	4ac010ef          	jal	532c <printf>
      exit(1);
    3e84:	4505                	li	a0,1
    3e86:	086010ef          	jal	4f0c <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    3e8a:	20200593          	li	a1,514
    3e8e:	854e                	mv	a0,s3
    3e90:	0bc010ef          	jal	4f4c <open>
    3e94:	892a                	mv	s2,a0
      if(fd < 0){
    3e96:	04054063          	bltz	a0,3ed6 <fourfiles+0x108>
      memset(buf, '0'+pi, SZ);
    3e9a:	1f400613          	li	a2,500
    3e9e:	0304859b          	addiw	a1,s1,48
    3ea2:	0000a517          	auipc	a0,0xa
    3ea6:	e0650513          	addi	a0,a0,-506 # dca8 <buf>
    3eaa:	629000ef          	jal	4cd2 <memset>
    3eae:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    3eb0:	1f400993          	li	s3,500
    3eb4:	0000aa17          	auipc	s4,0xa
    3eb8:	df4a0a13          	addi	s4,s4,-524 # dca8 <buf>
    3ebc:	864e                	mv	a2,s3
    3ebe:	85d2                	mv	a1,s4
    3ec0:	854a                	mv	a0,s2
    3ec2:	06a010ef          	jal	4f2c <write>
    3ec6:	85aa                	mv	a1,a0
    3ec8:	03351163          	bne	a0,s3,3eea <fourfiles+0x11c>
      for(i = 0; i < N; i++){
    3ecc:	34fd                	addiw	s1,s1,-1
    3ece:	f4fd                	bnez	s1,3ebc <fourfiles+0xee>
      exit(0);
    3ed0:	4501                	li	a0,0
    3ed2:	03a010ef          	jal	4f0c <exit>
        printf("%s: create failed\n", s);
    3ed6:	85e6                	mv	a1,s9
    3ed8:	00002517          	auipc	a0,0x2
    3edc:	f6850513          	addi	a0,a0,-152 # 5e40 <malloc+0xa5c>
    3ee0:	44c010ef          	jal	532c <printf>
        exit(1);
    3ee4:	4505                	li	a0,1
    3ee6:	026010ef          	jal	4f0c <exit>
          printf("write failed %d\n", n);
    3eea:	00003517          	auipc	a0,0x3
    3eee:	27650513          	addi	a0,a0,630 # 7160 <malloc+0x1d7c>
    3ef2:	43a010ef          	jal	532c <printf>
          exit(1);
    3ef6:	4505                	li	a0,1
    3ef8:	014010ef          	jal	4f0c <exit>
      exit(xstatus);
    3efc:	855a                	mv	a0,s6
    3efe:	00e010ef          	jal	4f0c <exit>
          printf("%s: wrong char\n", s);
    3f02:	85e6                	mv	a1,s9
    3f04:	00003517          	auipc	a0,0x3
    3f08:	27450513          	addi	a0,a0,628 # 7178 <malloc+0x1d94>
    3f0c:	420010ef          	jal	532c <printf>
          exit(1);
    3f10:	4505                	li	a0,1
    3f12:	7fb000ef          	jal	4f0c <exit>
    close(fd);
    3f16:	854e                	mv	a0,s3
    3f18:	01c010ef          	jal	4f34 <close>
    if(total != N*SZ){
    3f1c:	05a91863          	bne	s2,s10,3f6c <fourfiles+0x19e>
    unlink(fname);
    3f20:	8562                	mv	a0,s8
    3f22:	03a010ef          	jal	4f5c <unlink>
  for(i = 0; i < NCHILD; i++){
    3f26:	0ba1                	addi	s7,s7,8
    3f28:	2485                	addiw	s1,s1,1
    3f2a:	05b48b63          	beq	s1,s11,3f80 <fourfiles+0x1b2>
    fname = names[i];
    3f2e:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    3f32:	4581                	li	a1,0
    3f34:	8562                	mv	a0,s8
    3f36:	016010ef          	jal	4f4c <open>
    3f3a:	89aa                	mv	s3,a0
    total = 0;
    3f3c:	895a                	mv	s2,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    3f3e:	8656                	mv	a2,s5
    3f40:	85d2                	mv	a1,s4
    3f42:	854e                	mv	a0,s3
    3f44:	7e1000ef          	jal	4f24 <read>
    3f48:	fca057e3          	blez	a0,3f16 <fourfiles+0x148>
    3f4c:	0000a797          	auipc	a5,0xa
    3f50:	d5c78793          	addi	a5,a5,-676 # dca8 <buf>
    3f54:	00f506b3          	add	a3,a0,a5
        if(buf[j] != '0'+i){
    3f58:	0007c703          	lbu	a4,0(a5)
    3f5c:	fa9713e3          	bne	a4,s1,3f02 <fourfiles+0x134>
      for(j = 0; j < n; j++){
    3f60:	0785                	addi	a5,a5,1
    3f62:	fed79be3          	bne	a5,a3,3f58 <fourfiles+0x18a>
      total += n;
    3f66:	00a9093b          	addw	s2,s2,a0
    3f6a:	bfd1                	j	3f3e <fourfiles+0x170>
      printf("wrong length %d\n", total);
    3f6c:	85ca                	mv	a1,s2
    3f6e:	00003517          	auipc	a0,0x3
    3f72:	21a50513          	addi	a0,a0,538 # 7188 <malloc+0x1da4>
    3f76:	3b6010ef          	jal	532c <printf>
      exit(1);
    3f7a:	4505                	li	a0,1
    3f7c:	791000ef          	jal	4f0c <exit>
}
    3f80:	60ea                	ld	ra,152(sp)
    3f82:	644a                	ld	s0,144(sp)
    3f84:	64aa                	ld	s1,136(sp)
    3f86:	690a                	ld	s2,128(sp)
    3f88:	79e6                	ld	s3,120(sp)
    3f8a:	7a46                	ld	s4,112(sp)
    3f8c:	7aa6                	ld	s5,104(sp)
    3f8e:	7b06                	ld	s6,96(sp)
    3f90:	6be6                	ld	s7,88(sp)
    3f92:	6c46                	ld	s8,80(sp)
    3f94:	6ca6                	ld	s9,72(sp)
    3f96:	6d06                	ld	s10,64(sp)
    3f98:	7de2                	ld	s11,56(sp)
    3f9a:	610d                	addi	sp,sp,160
    3f9c:	8082                	ret

0000000000003f9e <concreate>:
{
    3f9e:	7171                	addi	sp,sp,-176
    3fa0:	f506                	sd	ra,168(sp)
    3fa2:	f122                	sd	s0,160(sp)
    3fa4:	ed26                	sd	s1,152(sp)
    3fa6:	e94a                	sd	s2,144(sp)
    3fa8:	e54e                	sd	s3,136(sp)
    3faa:	e152                	sd	s4,128(sp)
    3fac:	fcd6                	sd	s5,120(sp)
    3fae:	f8da                	sd	s6,112(sp)
    3fb0:	f4de                	sd	s7,104(sp)
    3fb2:	f0e2                	sd	s8,96(sp)
    3fb4:	ece6                	sd	s9,88(sp)
    3fb6:	e8ea                	sd	s10,80(sp)
    3fb8:	1900                	addi	s0,sp,176
    3fba:	8baa                	mv	s7,a0
  file[0] = 'C';
    3fbc:	04300793          	li	a5,67
    3fc0:	f8f40c23          	sb	a5,-104(s0)
  file[2] = '\0';
    3fc4:	f8040d23          	sb	zero,-102(s0)
  for(i = 0; i < N; i++){
    3fc8:	4901                	li	s2,0
    unlink(file);
    3fca:	f9840993          	addi	s3,s0,-104
    if(pid && (i % 3) == 1){
    3fce:	55555b37          	lui	s6,0x55555
    3fd2:	556b0b13          	addi	s6,s6,1366 # 55555556 <base+0x555448ae>
    3fd6:	4c05                	li	s8,1
      fd = open(file, O_CREATE | O_RDWR);
    3fd8:	20200c93          	li	s9,514
      link("C0", file);
    3fdc:	00003d17          	auipc	s10,0x3
    3fe0:	1c4d0d13          	addi	s10,s10,452 # 71a0 <malloc+0x1dbc>
      wait(&xstatus);
    3fe4:	f5c40a93          	addi	s5,s0,-164
  for(i = 0; i < N; i++){
    3fe8:	02800a13          	li	s4,40
    3fec:	ac2d                	j	4226 <concreate+0x288>
      link("C0", file);
    3fee:	85ce                	mv	a1,s3
    3ff0:	856a                	mv	a0,s10
    3ff2:	77b000ef          	jal	4f6c <link>
    if(pid == 0) {
    3ff6:	ac31                	j	4212 <concreate+0x274>
    } else if(pid == 0 && (i % 5) == 1){
    3ff8:	666667b7          	lui	a5,0x66666
    3ffc:	66778793          	addi	a5,a5,1639 # 66666667 <base+0x666559bf>
    4000:	02f907b3          	mul	a5,s2,a5
    4004:	9785                	srai	a5,a5,0x21
    4006:	41f9571b          	sraiw	a4,s2,0x1f
    400a:	9f99                	subw	a5,a5,a4
    400c:	0027971b          	slliw	a4,a5,0x2
    4010:	9fb9                	addw	a5,a5,a4
    4012:	40f9093b          	subw	s2,s2,a5
    4016:	4785                	li	a5,1
    4018:	02f90563          	beq	s2,a5,4042 <concreate+0xa4>
      fd = open(file, O_CREATE | O_RDWR);
    401c:	20200593          	li	a1,514
    4020:	f9840513          	addi	a0,s0,-104
    4024:	729000ef          	jal	4f4c <open>
      if(fd < 0){
    4028:	1e055063          	bgez	a0,4208 <concreate+0x26a>
        printf("concreate create %s failed\n", file);
    402c:	f9840593          	addi	a1,s0,-104
    4030:	00003517          	auipc	a0,0x3
    4034:	17850513          	addi	a0,a0,376 # 71a8 <malloc+0x1dc4>
    4038:	2f4010ef          	jal	532c <printf>
        exit(1);
    403c:	4505                	li	a0,1
    403e:	6cf000ef          	jal	4f0c <exit>
      link("C0", file);
    4042:	f9840593          	addi	a1,s0,-104
    4046:	00003517          	auipc	a0,0x3
    404a:	15a50513          	addi	a0,a0,346 # 71a0 <malloc+0x1dbc>
    404e:	71f000ef          	jal	4f6c <link>
      exit(0);
    4052:	4501                	li	a0,0
    4054:	6b9000ef          	jal	4f0c <exit>
        exit(1);
    4058:	4505                	li	a0,1
    405a:	6b3000ef          	jal	4f0c <exit>
  memset(fa, 0, sizeof(fa));
    405e:	02800613          	li	a2,40
    4062:	4581                	li	a1,0
    4064:	f7040513          	addi	a0,s0,-144
    4068:	46b000ef          	jal	4cd2 <memset>
  fd = open(".", 0);
    406c:	4581                	li	a1,0
    406e:	00002517          	auipc	a0,0x2
    4072:	b9250513          	addi	a0,a0,-1134 # 5c00 <malloc+0x81c>
    4076:	6d7000ef          	jal	4f4c <open>
    407a:	892a                	mv	s2,a0
  n = 0;
    407c:	8b26                	mv	s6,s1
  while(read(fd, &de, sizeof(de)) > 0){
    407e:	f6040a13          	addi	s4,s0,-160
    4082:	49c1                	li	s3,16
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4084:	04300a93          	li	s5,67
      if(i < 0 || i >= sizeof(fa)){
    4088:	02700c13          	li	s8,39
      fa[i] = 1;
    408c:	4c85                	li	s9,1
  while(read(fd, &de, sizeof(de)) > 0){
    408e:	864e                	mv	a2,s3
    4090:	85d2                	mv	a1,s4
    4092:	854a                	mv	a0,s2
    4094:	691000ef          	jal	4f24 <read>
    4098:	06a05763          	blez	a0,4106 <concreate+0x168>
    if(de.inum == 0)
    409c:	f6045783          	lhu	a5,-160(s0)
    40a0:	d7fd                	beqz	a5,408e <concreate+0xf0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    40a2:	f6244783          	lbu	a5,-158(s0)
    40a6:	ff5794e3          	bne	a5,s5,408e <concreate+0xf0>
    40aa:	f6444783          	lbu	a5,-156(s0)
    40ae:	f3e5                	bnez	a5,408e <concreate+0xf0>
      i = de.name[1] - '0';
    40b0:	f6344783          	lbu	a5,-157(s0)
    40b4:	fd07879b          	addiw	a5,a5,-48
      if(i < 0 || i >= sizeof(fa)){
    40b8:	00fc6f63          	bltu	s8,a5,40d6 <concreate+0x138>
      if(fa[i]){
    40bc:	fa078713          	addi	a4,a5,-96
    40c0:	9722                	add	a4,a4,s0
    40c2:	fd074703          	lbu	a4,-48(a4)
    40c6:	e705                	bnez	a4,40ee <concreate+0x150>
      fa[i] = 1;
    40c8:	fa078793          	addi	a5,a5,-96
    40cc:	97a2                	add	a5,a5,s0
    40ce:	fd978823          	sb	s9,-48(a5)
      n++;
    40d2:	2b05                	addiw	s6,s6,1
    40d4:	bf6d                	j	408e <concreate+0xf0>
        printf("%s: concreate weird file %s\n", s, de.name);
    40d6:	f6240613          	addi	a2,s0,-158
    40da:	85de                	mv	a1,s7
    40dc:	00003517          	auipc	a0,0x3
    40e0:	0ec50513          	addi	a0,a0,236 # 71c8 <malloc+0x1de4>
    40e4:	248010ef          	jal	532c <printf>
        exit(1);
    40e8:	4505                	li	a0,1
    40ea:	623000ef          	jal	4f0c <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    40ee:	f6240613          	addi	a2,s0,-158
    40f2:	85de                	mv	a1,s7
    40f4:	00003517          	auipc	a0,0x3
    40f8:	0f450513          	addi	a0,a0,244 # 71e8 <malloc+0x1e04>
    40fc:	230010ef          	jal	532c <printf>
        exit(1);
    4100:	4505                	li	a0,1
    4102:	60b000ef          	jal	4f0c <exit>
  close(fd);
    4106:	854a                	mv	a0,s2
    4108:	62d000ef          	jal	4f34 <close>
  if(n != N){
    410c:	02800793          	li	a5,40
    4110:	00fb1b63          	bne	s6,a5,4126 <concreate+0x188>
    if(((i % 3) == 0 && pid == 0) ||
    4114:	55555a37          	lui	s4,0x55555
    4118:	556a0a13          	addi	s4,s4,1366 # 55555556 <base+0x555448ae>
      close(open(file, 0));
    411c:	f9840993          	addi	s3,s0,-104
    if(((i % 3) == 0 && pid == 0) ||
    4120:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4122:	8abe                	mv	s5,a5
    4124:	a049                	j	41a6 <concreate+0x208>
    printf("%s: concreate not enough files in directory listing\n", s);
    4126:	85de                	mv	a1,s7
    4128:	00003517          	auipc	a0,0x3
    412c:	0e850513          	addi	a0,a0,232 # 7210 <malloc+0x1e2c>
    4130:	1fc010ef          	jal	532c <printf>
    exit(1);
    4134:	4505                	li	a0,1
    4136:	5d7000ef          	jal	4f0c <exit>
      printf("%s: fork failed\n", s);
    413a:	85de                	mv	a1,s7
    413c:	00002517          	auipc	a0,0x2
    4140:	c6c50513          	addi	a0,a0,-916 # 5da8 <malloc+0x9c4>
    4144:	1e8010ef          	jal	532c <printf>
      exit(1);
    4148:	4505                	li	a0,1
    414a:	5c3000ef          	jal	4f0c <exit>
      close(open(file, 0));
    414e:	4581                	li	a1,0
    4150:	854e                	mv	a0,s3
    4152:	5fb000ef          	jal	4f4c <open>
    4156:	5df000ef          	jal	4f34 <close>
      close(open(file, 0));
    415a:	4581                	li	a1,0
    415c:	854e                	mv	a0,s3
    415e:	5ef000ef          	jal	4f4c <open>
    4162:	5d3000ef          	jal	4f34 <close>
      close(open(file, 0));
    4166:	4581                	li	a1,0
    4168:	854e                	mv	a0,s3
    416a:	5e3000ef          	jal	4f4c <open>
    416e:	5c7000ef          	jal	4f34 <close>
      close(open(file, 0));
    4172:	4581                	li	a1,0
    4174:	854e                	mv	a0,s3
    4176:	5d7000ef          	jal	4f4c <open>
    417a:	5bb000ef          	jal	4f34 <close>
      close(open(file, 0));
    417e:	4581                	li	a1,0
    4180:	854e                	mv	a0,s3
    4182:	5cb000ef          	jal	4f4c <open>
    4186:	5af000ef          	jal	4f34 <close>
      close(open(file, 0));
    418a:	4581                	li	a1,0
    418c:	854e                	mv	a0,s3
    418e:	5bf000ef          	jal	4f4c <open>
    4192:	5a3000ef          	jal	4f34 <close>
    if(pid == 0)
    4196:	06090663          	beqz	s2,4202 <concreate+0x264>
      wait(0);
    419a:	4501                	li	a0,0
    419c:	579000ef          	jal	4f14 <wait>
  for(i = 0; i < N; i++){
    41a0:	2485                	addiw	s1,s1,1
    41a2:	0d548163          	beq	s1,s5,4264 <concreate+0x2c6>
    file[1] = '0' + i;
    41a6:	0304879b          	addiw	a5,s1,48
    41aa:	f8f40ca3          	sb	a5,-103(s0)
    pid = fork();
    41ae:	557000ef          	jal	4f04 <fork>
    41b2:	892a                	mv	s2,a0
    if(pid < 0){
    41b4:	f80543e3          	bltz	a0,413a <concreate+0x19c>
    if(((i % 3) == 0 && pid == 0) ||
    41b8:	03448733          	mul	a4,s1,s4
    41bc:	9301                	srli	a4,a4,0x20
    41be:	41f4d79b          	sraiw	a5,s1,0x1f
    41c2:	9f1d                	subw	a4,a4,a5
    41c4:	0017179b          	slliw	a5,a4,0x1
    41c8:	9fb9                	addw	a5,a5,a4
    41ca:	40f487bb          	subw	a5,s1,a5
    41ce:	873e                	mv	a4,a5
    41d0:	8fc9                	or	a5,a5,a0
    41d2:	2781                	sext.w	a5,a5
    41d4:	dfad                	beqz	a5,414e <concreate+0x1b0>
    41d6:	01671363          	bne	a4,s6,41dc <concreate+0x23e>
       ((i % 3) == 1 && pid != 0)){
    41da:	f935                	bnez	a0,414e <concreate+0x1b0>
      unlink(file);
    41dc:	854e                	mv	a0,s3
    41de:	57f000ef          	jal	4f5c <unlink>
      unlink(file);
    41e2:	854e                	mv	a0,s3
    41e4:	579000ef          	jal	4f5c <unlink>
      unlink(file);
    41e8:	854e                	mv	a0,s3
    41ea:	573000ef          	jal	4f5c <unlink>
      unlink(file);
    41ee:	854e                	mv	a0,s3
    41f0:	56d000ef          	jal	4f5c <unlink>
      unlink(file);
    41f4:	854e                	mv	a0,s3
    41f6:	567000ef          	jal	4f5c <unlink>
      unlink(file);
    41fa:	854e                	mv	a0,s3
    41fc:	561000ef          	jal	4f5c <unlink>
    4200:	bf59                	j	4196 <concreate+0x1f8>
      exit(0);
    4202:	4501                	li	a0,0
    4204:	509000ef          	jal	4f0c <exit>
      close(fd);
    4208:	52d000ef          	jal	4f34 <close>
    if(pid == 0) {
    420c:	b599                	j	4052 <concreate+0xb4>
      close(fd);
    420e:	527000ef          	jal	4f34 <close>
      wait(&xstatus);
    4212:	8556                	mv	a0,s5
    4214:	501000ef          	jal	4f14 <wait>
      if(xstatus != 0)
    4218:	f5c42483          	lw	s1,-164(s0)
    421c:	e2049ee3          	bnez	s1,4058 <concreate+0xba>
  for(i = 0; i < N; i++){
    4220:	2905                	addiw	s2,s2,1
    4222:	e3490ee3          	beq	s2,s4,405e <concreate+0xc0>
    file[1] = '0' + i;
    4226:	0309079b          	addiw	a5,s2,48
    422a:	f8f40ca3          	sb	a5,-103(s0)
    unlink(file);
    422e:	854e                	mv	a0,s3
    4230:	52d000ef          	jal	4f5c <unlink>
    pid = fork();
    4234:	4d1000ef          	jal	4f04 <fork>
    if(pid && (i % 3) == 1){
    4238:	dc0500e3          	beqz	a0,3ff8 <concreate+0x5a>
    423c:	036907b3          	mul	a5,s2,s6
    4240:	9381                	srli	a5,a5,0x20
    4242:	41f9571b          	sraiw	a4,s2,0x1f
    4246:	9f99                	subw	a5,a5,a4
    4248:	0017971b          	slliw	a4,a5,0x1
    424c:	9fb9                	addw	a5,a5,a4
    424e:	40f907bb          	subw	a5,s2,a5
    4252:	d9878ee3          	beq	a5,s8,3fee <concreate+0x50>
      fd = open(file, O_CREATE | O_RDWR);
    4256:	85e6                	mv	a1,s9
    4258:	854e                	mv	a0,s3
    425a:	4f3000ef          	jal	4f4c <open>
      if(fd < 0){
    425e:	fa0558e3          	bgez	a0,420e <concreate+0x270>
    4262:	b3e9                	j	402c <concreate+0x8e>
}
    4264:	70aa                	ld	ra,168(sp)
    4266:	740a                	ld	s0,160(sp)
    4268:	64ea                	ld	s1,152(sp)
    426a:	694a                	ld	s2,144(sp)
    426c:	69aa                	ld	s3,136(sp)
    426e:	6a0a                	ld	s4,128(sp)
    4270:	7ae6                	ld	s5,120(sp)
    4272:	7b46                	ld	s6,112(sp)
    4274:	7ba6                	ld	s7,104(sp)
    4276:	7c06                	ld	s8,96(sp)
    4278:	6ce6                	ld	s9,88(sp)
    427a:	6d46                	ld	s10,80(sp)
    427c:	614d                	addi	sp,sp,176
    427e:	8082                	ret

0000000000004280 <bigfile>:
{
    4280:	7139                	addi	sp,sp,-64
    4282:	fc06                	sd	ra,56(sp)
    4284:	f822                	sd	s0,48(sp)
    4286:	f426                	sd	s1,40(sp)
    4288:	f04a                	sd	s2,32(sp)
    428a:	ec4e                	sd	s3,24(sp)
    428c:	e852                	sd	s4,16(sp)
    428e:	e456                	sd	s5,8(sp)
    4290:	e05a                	sd	s6,0(sp)
    4292:	0080                	addi	s0,sp,64
    4294:	8b2a                	mv	s6,a0
  unlink("bigfile.dat");
    4296:	00003517          	auipc	a0,0x3
    429a:	fb250513          	addi	a0,a0,-78 # 7248 <malloc+0x1e64>
    429e:	4bf000ef          	jal	4f5c <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    42a2:	20200593          	li	a1,514
    42a6:	00003517          	auipc	a0,0x3
    42aa:	fa250513          	addi	a0,a0,-94 # 7248 <malloc+0x1e64>
    42ae:	49f000ef          	jal	4f4c <open>
  if(fd < 0){
    42b2:	08054a63          	bltz	a0,4346 <bigfile+0xc6>
    42b6:	8a2a                	mv	s4,a0
    42b8:	4481                	li	s1,0
    memset(buf, i, SZ);
    42ba:	25800913          	li	s2,600
    42be:	0000a997          	auipc	s3,0xa
    42c2:	9ea98993          	addi	s3,s3,-1558 # dca8 <buf>
  for(i = 0; i < N; i++){
    42c6:	4ad1                	li	s5,20
    memset(buf, i, SZ);
    42c8:	864a                	mv	a2,s2
    42ca:	85a6                	mv	a1,s1
    42cc:	854e                	mv	a0,s3
    42ce:	205000ef          	jal	4cd2 <memset>
    if(write(fd, buf, SZ) != SZ){
    42d2:	864a                	mv	a2,s2
    42d4:	85ce                	mv	a1,s3
    42d6:	8552                	mv	a0,s4
    42d8:	455000ef          	jal	4f2c <write>
    42dc:	07251f63          	bne	a0,s2,435a <bigfile+0xda>
  for(i = 0; i < N; i++){
    42e0:	2485                	addiw	s1,s1,1
    42e2:	ff5493e3          	bne	s1,s5,42c8 <bigfile+0x48>
  close(fd);
    42e6:	8552                	mv	a0,s4
    42e8:	44d000ef          	jal	4f34 <close>
  fd = open("bigfile.dat", 0);
    42ec:	4581                	li	a1,0
    42ee:	00003517          	auipc	a0,0x3
    42f2:	f5a50513          	addi	a0,a0,-166 # 7248 <malloc+0x1e64>
    42f6:	457000ef          	jal	4f4c <open>
    42fa:	8aaa                	mv	s5,a0
  total = 0;
    42fc:	4a01                	li	s4,0
  for(i = 0; ; i++){
    42fe:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4300:	12c00993          	li	s3,300
    4304:	0000a917          	auipc	s2,0xa
    4308:	9a490913          	addi	s2,s2,-1628 # dca8 <buf>
  if(fd < 0){
    430c:	06054163          	bltz	a0,436e <bigfile+0xee>
    cc = read(fd, buf, SZ/2);
    4310:	864e                	mv	a2,s3
    4312:	85ca                	mv	a1,s2
    4314:	8556                	mv	a0,s5
    4316:	40f000ef          	jal	4f24 <read>
    if(cc < 0){
    431a:	06054463          	bltz	a0,4382 <bigfile+0x102>
    if(cc == 0)
    431e:	c145                	beqz	a0,43be <bigfile+0x13e>
    if(cc != SZ/2){
    4320:	07351b63          	bne	a0,s3,4396 <bigfile+0x116>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4324:	01f4d79b          	srliw	a5,s1,0x1f
    4328:	9fa5                	addw	a5,a5,s1
    432a:	4017d79b          	sraiw	a5,a5,0x1
    432e:	00094703          	lbu	a4,0(s2)
    4332:	06f71c63          	bne	a4,a5,43aa <bigfile+0x12a>
    4336:	12b94703          	lbu	a4,299(s2)
    433a:	06f71863          	bne	a4,a5,43aa <bigfile+0x12a>
    total += cc;
    433e:	12ca0a1b          	addiw	s4,s4,300
  for(i = 0; ; i++){
    4342:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4344:	b7f1                	j	4310 <bigfile+0x90>
    printf("%s: cannot create bigfile", s);
    4346:	85da                	mv	a1,s6
    4348:	00003517          	auipc	a0,0x3
    434c:	f1050513          	addi	a0,a0,-240 # 7258 <malloc+0x1e74>
    4350:	7dd000ef          	jal	532c <printf>
    exit(1);
    4354:	4505                	li	a0,1
    4356:	3b7000ef          	jal	4f0c <exit>
      printf("%s: write bigfile failed\n", s);
    435a:	85da                	mv	a1,s6
    435c:	00003517          	auipc	a0,0x3
    4360:	f1c50513          	addi	a0,a0,-228 # 7278 <malloc+0x1e94>
    4364:	7c9000ef          	jal	532c <printf>
      exit(1);
    4368:	4505                	li	a0,1
    436a:	3a3000ef          	jal	4f0c <exit>
    printf("%s: cannot open bigfile\n", s);
    436e:	85da                	mv	a1,s6
    4370:	00003517          	auipc	a0,0x3
    4374:	f2850513          	addi	a0,a0,-216 # 7298 <malloc+0x1eb4>
    4378:	7b5000ef          	jal	532c <printf>
    exit(1);
    437c:	4505                	li	a0,1
    437e:	38f000ef          	jal	4f0c <exit>
      printf("%s: read bigfile failed\n", s);
    4382:	85da                	mv	a1,s6
    4384:	00003517          	auipc	a0,0x3
    4388:	f3450513          	addi	a0,a0,-204 # 72b8 <malloc+0x1ed4>
    438c:	7a1000ef          	jal	532c <printf>
      exit(1);
    4390:	4505                	li	a0,1
    4392:	37b000ef          	jal	4f0c <exit>
      printf("%s: short read bigfile\n", s);
    4396:	85da                	mv	a1,s6
    4398:	00003517          	auipc	a0,0x3
    439c:	f4050513          	addi	a0,a0,-192 # 72d8 <malloc+0x1ef4>
    43a0:	78d000ef          	jal	532c <printf>
      exit(1);
    43a4:	4505                	li	a0,1
    43a6:	367000ef          	jal	4f0c <exit>
      printf("%s: read bigfile wrong data\n", s);
    43aa:	85da                	mv	a1,s6
    43ac:	00003517          	auipc	a0,0x3
    43b0:	f4450513          	addi	a0,a0,-188 # 72f0 <malloc+0x1f0c>
    43b4:	779000ef          	jal	532c <printf>
      exit(1);
    43b8:	4505                	li	a0,1
    43ba:	353000ef          	jal	4f0c <exit>
  close(fd);
    43be:	8556                	mv	a0,s5
    43c0:	375000ef          	jal	4f34 <close>
  if(total != N*SZ){
    43c4:	678d                	lui	a5,0x3
    43c6:	ee078793          	addi	a5,a5,-288 # 2ee0 <subdir+0x1fe>
    43ca:	02fa1263          	bne	s4,a5,43ee <bigfile+0x16e>
  unlink("bigfile.dat");
    43ce:	00003517          	auipc	a0,0x3
    43d2:	e7a50513          	addi	a0,a0,-390 # 7248 <malloc+0x1e64>
    43d6:	387000ef          	jal	4f5c <unlink>
}
    43da:	70e2                	ld	ra,56(sp)
    43dc:	7442                	ld	s0,48(sp)
    43de:	74a2                	ld	s1,40(sp)
    43e0:	7902                	ld	s2,32(sp)
    43e2:	69e2                	ld	s3,24(sp)
    43e4:	6a42                	ld	s4,16(sp)
    43e6:	6aa2                	ld	s5,8(sp)
    43e8:	6b02                	ld	s6,0(sp)
    43ea:	6121                	addi	sp,sp,64
    43ec:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    43ee:	85da                	mv	a1,s6
    43f0:	00003517          	auipc	a0,0x3
    43f4:	f2050513          	addi	a0,a0,-224 # 7310 <malloc+0x1f2c>
    43f8:	735000ef          	jal	532c <printf>
    exit(1);
    43fc:	4505                	li	a0,1
    43fe:	30f000ef          	jal	4f0c <exit>

0000000000004402 <bigargtest>:
{
    4402:	7121                	addi	sp,sp,-448
    4404:	ff06                	sd	ra,440(sp)
    4406:	fb22                	sd	s0,432(sp)
    4408:	f726                	sd	s1,424(sp)
    440a:	0380                	addi	s0,sp,448
    440c:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    440e:	00003517          	auipc	a0,0x3
    4412:	f2250513          	addi	a0,a0,-222 # 7330 <malloc+0x1f4c>
    4416:	347000ef          	jal	4f5c <unlink>
  pid = fork();
    441a:	2eb000ef          	jal	4f04 <fork>
  if(pid == 0){
    441e:	c915                	beqz	a0,4452 <bigargtest+0x50>
  } else if(pid < 0){
    4420:	08054a63          	bltz	a0,44b4 <bigargtest+0xb2>
  wait(&xstatus);
    4424:	fdc40513          	addi	a0,s0,-36
    4428:	2ed000ef          	jal	4f14 <wait>
  if(xstatus != 0)
    442c:	fdc42503          	lw	a0,-36(s0)
    4430:	ed41                	bnez	a0,44c8 <bigargtest+0xc6>
  fd = open("bigarg-ok", 0);
    4432:	4581                	li	a1,0
    4434:	00003517          	auipc	a0,0x3
    4438:	efc50513          	addi	a0,a0,-260 # 7330 <malloc+0x1f4c>
    443c:	311000ef          	jal	4f4c <open>
  if(fd < 0){
    4440:	08054663          	bltz	a0,44cc <bigargtest+0xca>
  close(fd);
    4444:	2f1000ef          	jal	4f34 <close>
}
    4448:	70fa                	ld	ra,440(sp)
    444a:	745a                	ld	s0,432(sp)
    444c:	74ba                	ld	s1,424(sp)
    444e:	6139                	addi	sp,sp,448
    4450:	8082                	ret
    memset(big, ' ', sizeof(big));
    4452:	19000613          	li	a2,400
    4456:	02000593          	li	a1,32
    445a:	e4840513          	addi	a0,s0,-440
    445e:	075000ef          	jal	4cd2 <memset>
    big[sizeof(big)-1] = '\0';
    4462:	fc040ba3          	sb	zero,-41(s0)
    for(i = 0; i < MAXARG-1; i++)
    4466:	00006797          	auipc	a5,0x6
    446a:	02a78793          	addi	a5,a5,42 # a490 <args.1>
    446e:	00006697          	auipc	a3,0x6
    4472:	11a68693          	addi	a3,a3,282 # a588 <args.1+0xf8>
      args[i] = big;
    4476:	e4840713          	addi	a4,s0,-440
    447a:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    447c:	07a1                	addi	a5,a5,8
    447e:	fed79ee3          	bne	a5,a3,447a <bigargtest+0x78>
    args[MAXARG-1] = 0;
    4482:	00006597          	auipc	a1,0x6
    4486:	00e58593          	addi	a1,a1,14 # a490 <args.1>
    448a:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    448e:	00001517          	auipc	a0,0x1
    4492:	08a50513          	addi	a0,a0,138 # 5518 <malloc+0x134>
    4496:	2af000ef          	jal	4f44 <exec>
    fd = open("bigarg-ok", O_CREATE);
    449a:	20000593          	li	a1,512
    449e:	00003517          	auipc	a0,0x3
    44a2:	e9250513          	addi	a0,a0,-366 # 7330 <malloc+0x1f4c>
    44a6:	2a7000ef          	jal	4f4c <open>
    close(fd);
    44aa:	28b000ef          	jal	4f34 <close>
    exit(0);
    44ae:	4501                	li	a0,0
    44b0:	25d000ef          	jal	4f0c <exit>
    printf("%s: bigargtest: fork failed\n", s);
    44b4:	85a6                	mv	a1,s1
    44b6:	00003517          	auipc	a0,0x3
    44ba:	e8a50513          	addi	a0,a0,-374 # 7340 <malloc+0x1f5c>
    44be:	66f000ef          	jal	532c <printf>
    exit(1);
    44c2:	4505                	li	a0,1
    44c4:	249000ef          	jal	4f0c <exit>
    exit(xstatus);
    44c8:	245000ef          	jal	4f0c <exit>
    printf("%s: bigarg test failed!\n", s);
    44cc:	85a6                	mv	a1,s1
    44ce:	00003517          	auipc	a0,0x3
    44d2:	e9250513          	addi	a0,a0,-366 # 7360 <malloc+0x1f7c>
    44d6:	657000ef          	jal	532c <printf>
    exit(1);
    44da:	4505                	li	a0,1
    44dc:	231000ef          	jal	4f0c <exit>

00000000000044e0 <lazy_alloc>:
{
    44e0:	1141                	addi	sp,sp,-16
    44e2:	e406                	sd	ra,8(sp)
    44e4:	e022                	sd	s0,0(sp)
    44e6:	0800                	addi	s0,sp,16
  prev_end = sbrklazy(REGION_SZ);
    44e8:	40000537          	lui	a0,0x40000
    44ec:	203000ef          	jal	4eee <sbrklazy>
  if (prev_end == (char *) SBRK_ERROR) {
    44f0:	57fd                	li	a5,-1
    44f2:	02f50a63          	beq	a0,a5,4526 <lazy_alloc+0x46>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    44f6:	6605                	lui	a2,0x1
    44f8:	962a                	add	a2,a2,a0
    44fa:	400017b7          	lui	a5,0x40001
    44fe:	00f50733          	add	a4,a0,a5
    4502:	87b2                	mv	a5,a2
    4504:	000406b7          	lui	a3,0x40
    *(char **)i = i;
    4508:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE)
    450a:	97b6                	add	a5,a5,a3
    450c:	fee79ee3          	bne	a5,a4,4508 <lazy_alloc+0x28>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    4510:	000406b7          	lui	a3,0x40
    if (*(char **)i != i) {
    4514:	621c                	ld	a5,0(a2)
    4516:	02c79163          	bne	a5,a2,4538 <lazy_alloc+0x58>
  for (i = prev_end + PGSIZE; i < new_end; i += 64 * PGSIZE) {
    451a:	9636                	add	a2,a2,a3
    451c:	fee61ce3          	bne	a2,a4,4514 <lazy_alloc+0x34>
  exit(0);
    4520:	4501                	li	a0,0
    4522:	1eb000ef          	jal	4f0c <exit>
    printf("sbrklazy() failed\n");
    4526:	00003517          	auipc	a0,0x3
    452a:	e5a50513          	addi	a0,a0,-422 # 7380 <malloc+0x1f9c>
    452e:	5ff000ef          	jal	532c <printf>
    exit(1);
    4532:	4505                	li	a0,1
    4534:	1d9000ef          	jal	4f0c <exit>
      printf("failed to read value from memory\n");
    4538:	00003517          	auipc	a0,0x3
    453c:	e6050513          	addi	a0,a0,-416 # 7398 <malloc+0x1fb4>
    4540:	5ed000ef          	jal	532c <printf>
      exit(1);
    4544:	4505                	li	a0,1
    4546:	1c7000ef          	jal	4f0c <exit>

000000000000454a <lazy_unmap>:
{
    454a:	7139                	addi	sp,sp,-64
    454c:	fc06                	sd	ra,56(sp)
    454e:	f822                	sd	s0,48(sp)
    4550:	0080                	addi	s0,sp,64
  prev_end = sbrklazy(REGION_SZ);
    4552:	40000537          	lui	a0,0x40000
    4556:	199000ef          	jal	4eee <sbrklazy>
  if (prev_end == (char*)SBRK_ERROR) {
    455a:	57fd                	li	a5,-1
    455c:	04f50863          	beq	a0,a5,45ac <lazy_unmap+0x62>
    4560:	f426                	sd	s1,40(sp)
    4562:	f04a                	sd	s2,32(sp)
    4564:	ec4e                	sd	s3,24(sp)
    4566:	e852                	sd	s4,16(sp)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    4568:	6905                	lui	s2,0x1
    456a:	992a                	add	s2,s2,a0
    456c:	400017b7          	lui	a5,0x40001
    4570:	00f504b3          	add	s1,a0,a5
    4574:	87ca                	mv	a5,s2
    4576:	01000737          	lui	a4,0x1000
    *(char **)i = i;
    457a:	e39c                	sd	a5,0(a5)
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE)
    457c:	97ba                	add	a5,a5,a4
    457e:	fe979ee3          	bne	a5,s1,457a <lazy_unmap+0x30>
      wait(&status);
    4582:	fcc40993          	addi	s3,s0,-52
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    4586:	01000a37          	lui	s4,0x1000
    pid = fork();
    458a:	17b000ef          	jal	4f04 <fork>
    if (pid < 0) {
    458e:	02054c63          	bltz	a0,45c6 <lazy_unmap+0x7c>
    } else if (pid == 0) {
    4592:	c139                	beqz	a0,45d8 <lazy_unmap+0x8e>
      wait(&status);
    4594:	854e                	mv	a0,s3
    4596:	17f000ef          	jal	4f14 <wait>
      if (status == 0) {
    459a:	fcc42783          	lw	a5,-52(s0)
    459e:	c7b1                	beqz	a5,45ea <lazy_unmap+0xa0>
  for (i = prev_end + PGSIZE; i < new_end; i += PGSIZE * PGSIZE) {
    45a0:	9952                	add	s2,s2,s4
    45a2:	fe9914e3          	bne	s2,s1,458a <lazy_unmap+0x40>
  exit(0);
    45a6:	4501                	li	a0,0
    45a8:	165000ef          	jal	4f0c <exit>
    45ac:	f426                	sd	s1,40(sp)
    45ae:	f04a                	sd	s2,32(sp)
    45b0:	ec4e                	sd	s3,24(sp)
    45b2:	e852                	sd	s4,16(sp)
    printf("sbrklazy() failed\n");
    45b4:	00003517          	auipc	a0,0x3
    45b8:	dcc50513          	addi	a0,a0,-564 # 7380 <malloc+0x1f9c>
    45bc:	571000ef          	jal	532c <printf>
    exit(1);
    45c0:	4505                	li	a0,1
    45c2:	14b000ef          	jal	4f0c <exit>
      printf("error forking\n");
    45c6:	00003517          	auipc	a0,0x3
    45ca:	dfa50513          	addi	a0,a0,-518 # 73c0 <malloc+0x1fdc>
    45ce:	55f000ef          	jal	532c <printf>
      exit(1);
    45d2:	4505                	li	a0,1
    45d4:	139000ef          	jal	4f0c <exit>
      sbrklazy(-1L * REGION_SZ);
    45d8:	c0000537          	lui	a0,0xc0000
    45dc:	113000ef          	jal	4eee <sbrklazy>
      *(char **)i = i;
    45e0:	01293023          	sd	s2,0(s2) # 1000 <bigdir+0x10a>
      exit(0);
    45e4:	4501                	li	a0,0
    45e6:	127000ef          	jal	4f0c <exit>
        printf("memory not unmapped\n");
    45ea:	00003517          	auipc	a0,0x3
    45ee:	de650513          	addi	a0,a0,-538 # 73d0 <malloc+0x1fec>
    45f2:	53b000ef          	jal	532c <printf>
        exit(1);
    45f6:	4505                	li	a0,1
    45f8:	115000ef          	jal	4f0c <exit>

00000000000045fc <lazy_copy>:
{
    45fc:	7119                	addi	sp,sp,-128
    45fe:	fc86                	sd	ra,120(sp)
    4600:	f8a2                	sd	s0,112(sp)
    4602:	f4a6                	sd	s1,104(sp)
    4604:	f0ca                	sd	s2,96(sp)
    4606:	ecce                	sd	s3,88(sp)
    4608:	e8d2                	sd	s4,80(sp)
    460a:	e4d6                	sd	s5,72(sp)
    460c:	e0da                	sd	s6,64(sp)
    460e:	fc5e                	sd	s7,56(sp)
    4610:	f862                	sd	s8,48(sp)
    4612:	0100                	addi	s0,sp,128
    char *p = sbrk(0);
    4614:	4501                	li	a0,0
    4616:	0c3000ef          	jal	4ed8 <sbrk>
    461a:	84aa                	mv	s1,a0
    sbrklazy(4*PGSIZE);
    461c:	6511                	lui	a0,0x4
    461e:	0d1000ef          	jal	4eee <sbrklazy>
    open(p + 8192, 0);
    4622:	4581                	li	a1,0
    4624:	6509                	lui	a0,0x2
    4626:	9526                	add	a0,a0,s1
    4628:	125000ef          	jal	4f4c <open>
    void *xx = sbrk(0);
    462c:	4501                	li	a0,0
    462e:	0ab000ef          	jal	4ed8 <sbrk>
    4632:	84aa                	mv	s1,a0
    void *ret = sbrk(-(((uint64) xx)+1));
    4634:	fff54513          	not	a0,a0
    4638:	2501                	sext.w	a0,a0
    463a:	09f000ef          	jal	4ed8 <sbrk>
    if(ret != xx){
    463e:	00a48c63          	beq	s1,a0,4656 <lazy_copy+0x5a>
    4642:	85aa                	mv	a1,a0
      printf("sbrk(sbrk(0)+1) returned %p, not old sz\n", ret);
    4644:	00003517          	auipc	a0,0x3
    4648:	da450513          	addi	a0,a0,-604 # 73e8 <malloc+0x2004>
    464c:	4e1000ef          	jal	532c <printf>
      exit(1);
    4650:	4505                	li	a0,1
    4652:	0bb000ef          	jal	4f0c <exit>
  unsigned long bad[] = {
    4656:	00003797          	auipc	a5,0x3
    465a:	31278793          	addi	a5,a5,786 # 7968 <malloc+0x2584>
    465e:	7fa8                	ld	a0,120(a5)
    4660:	63cc                	ld	a1,128(a5)
    4662:	67d0                	ld	a2,136(a5)
    4664:	6bd4                	ld	a3,144(a5)
    4666:	6fd8                	ld	a4,152(a5)
    4668:	73dc                	ld	a5,160(a5)
    466a:	f8a43023          	sd	a0,-128(s0)
    466e:	f8b43423          	sd	a1,-120(s0)
    4672:	f8c43823          	sd	a2,-112(s0)
    4676:	f8d43c23          	sd	a3,-104(s0)
    467a:	fae43023          	sd	a4,-96(s0)
    467e:	faf43423          	sd	a5,-88(s0)
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    4682:	f8040913          	addi	s2,s0,-128
    4686:	fb040c13          	addi	s8,s0,-80
    int fd = open("README", 0);
    468a:	00001a97          	auipc	s5,0x1
    468e:	066a8a93          	addi	s5,s5,102 # 56f0 <malloc+0x30c>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    4692:	20000a13          	li	s4,512
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    4696:	60200b93          	li	s7,1538
    469a:	00001b17          	auipc	s6,0x1
    469e:	f66b0b13          	addi	s6,s6,-154 # 5600 <malloc+0x21c>
    int fd = open("README", 0);
    46a2:	4581                	li	a1,0
    46a4:	8556                	mv	a0,s5
    46a6:	0a7000ef          	jal	4f4c <open>
    46aa:	84aa                	mv	s1,a0
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    46ac:	04054363          	bltz	a0,46f2 <lazy_copy+0xf6>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    46b0:	00093983          	ld	s3,0(s2)
    46b4:	8652                	mv	a2,s4
    46b6:	85ce                	mv	a1,s3
    46b8:	06d000ef          	jal	4f24 <read>
    46bc:	04055463          	bgez	a0,4704 <lazy_copy+0x108>
    close(fd);
    46c0:	8526                	mv	a0,s1
    46c2:	073000ef          	jal	4f34 <close>
    fd = open("junk", O_CREATE|O_RDWR|O_TRUNC);
    46c6:	85de                	mv	a1,s7
    46c8:	855a                	mv	a0,s6
    46ca:	083000ef          	jal	4f4c <open>
    46ce:	84aa                	mv	s1,a0
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    46d0:	04054363          	bltz	a0,4716 <lazy_copy+0x11a>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    46d4:	8652                	mv	a2,s4
    46d6:	85ce                	mv	a1,s3
    46d8:	055000ef          	jal	4f2c <write>
    46dc:	04055663          	bgez	a0,4728 <lazy_copy+0x12c>
    close(fd);
    46e0:	8526                	mv	a0,s1
    46e2:	053000ef          	jal	4f34 <close>
  for(int i = 0; i < sizeof(bad)/sizeof(bad[0]); i++){
    46e6:	0921                	addi	s2,s2,8
    46e8:	fb891de3          	bne	s2,s8,46a2 <lazy_copy+0xa6>
  exit(0);
    46ec:	4501                	li	a0,0
    46ee:	01f000ef          	jal	4f0c <exit>
    if(fd < 0) { printf("cannot open README\n"); exit(1); }
    46f2:	00003517          	auipc	a0,0x3
    46f6:	d2650513          	addi	a0,a0,-730 # 7418 <malloc+0x2034>
    46fa:	433000ef          	jal	532c <printf>
    46fe:	4505                	li	a0,1
    4700:	00d000ef          	jal	4f0c <exit>
    if(read(fd, (char*)bad[i], 512) >= 0) { printf("read succeeded\n");  exit(1); }
    4704:	00003517          	auipc	a0,0x3
    4708:	d2c50513          	addi	a0,a0,-724 # 7430 <malloc+0x204c>
    470c:	421000ef          	jal	532c <printf>
    4710:	4505                	li	a0,1
    4712:	7fa000ef          	jal	4f0c <exit>
    if(fd < 0) { printf("cannot open junk\n"); exit(1); }
    4716:	00003517          	auipc	a0,0x3
    471a:	d2a50513          	addi	a0,a0,-726 # 7440 <malloc+0x205c>
    471e:	40f000ef          	jal	532c <printf>
    4722:	4505                	li	a0,1
    4724:	7e8000ef          	jal	4f0c <exit>
    if(write(fd, (char*)bad[i], 512) >= 0) { printf("write succeeded\n"); exit(1); }
    4728:	00003517          	auipc	a0,0x3
    472c:	d3050513          	addi	a0,a0,-720 # 7458 <malloc+0x2074>
    4730:	3fd000ef          	jal	532c <printf>
    4734:	4505                	li	a0,1
    4736:	7d6000ef          	jal	4f0c <exit>

000000000000473a <fsfull>:
{
    473a:	7171                	addi	sp,sp,-176
    473c:	f506                	sd	ra,168(sp)
    473e:	f122                	sd	s0,160(sp)
    4740:	ed26                	sd	s1,152(sp)
    4742:	e94a                	sd	s2,144(sp)
    4744:	e54e                	sd	s3,136(sp)
    4746:	e152                	sd	s4,128(sp)
    4748:	fcd6                	sd	s5,120(sp)
    474a:	f8da                	sd	s6,112(sp)
    474c:	f4de                	sd	s7,104(sp)
    474e:	f0e2                	sd	s8,96(sp)
    4750:	ece6                	sd	s9,88(sp)
    4752:	e8ea                	sd	s10,80(sp)
    4754:	e4ee                	sd	s11,72(sp)
    4756:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4758:	00003517          	auipc	a0,0x3
    475c:	d1850513          	addi	a0,a0,-744 # 7470 <malloc+0x208c>
    4760:	3cd000ef          	jal	532c <printf>
  for(nfiles = 0; ; nfiles++){
    4764:	4481                	li	s1,0
    name[0] = 'f';
    4766:	06600d93          	li	s11,102
    name[1] = '0' + nfiles / 1000;
    476a:	10625cb7          	lui	s9,0x10625
    476e:	dd3c8c93          	addi	s9,s9,-557 # 10624dd3 <base+0x1061412b>
    name[2] = '0' + (nfiles % 1000) / 100;
    4772:	51eb8ab7          	lui	s5,0x51eb8
    4776:	51fa8a93          	addi	s5,s5,1311 # 51eb851f <base+0x51ea7877>
    name[3] = '0' + (nfiles % 100) / 10;
    477a:	66666a37          	lui	s4,0x66666
    477e:	667a0a13          	addi	s4,s4,1639 # 66666667 <base+0x666559bf>
    printf("writing %s\n", name);
    4782:	f5040d13          	addi	s10,s0,-176
    name[0] = 'f';
    4786:	f5b40823          	sb	s11,-176(s0)
    name[1] = '0' + nfiles / 1000;
    478a:	039487b3          	mul	a5,s1,s9
    478e:	9799                	srai	a5,a5,0x26
    4790:	41f4d69b          	sraiw	a3,s1,0x1f
    4794:	9f95                	subw	a5,a5,a3
    4796:	0307871b          	addiw	a4,a5,48
    479a:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    479e:	3e800713          	li	a4,1000
    47a2:	02f707bb          	mulw	a5,a4,a5
    47a6:	40f487bb          	subw	a5,s1,a5
    47aa:	03578733          	mul	a4,a5,s5
    47ae:	9715                	srai	a4,a4,0x25
    47b0:	41f7d79b          	sraiw	a5,a5,0x1f
    47b4:	40f707bb          	subw	a5,a4,a5
    47b8:	0307879b          	addiw	a5,a5,48
    47bc:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    47c0:	035487b3          	mul	a5,s1,s5
    47c4:	9795                	srai	a5,a5,0x25
    47c6:	9f95                	subw	a5,a5,a3
    47c8:	06400713          	li	a4,100
    47cc:	02f707bb          	mulw	a5,a4,a5
    47d0:	40f487bb          	subw	a5,s1,a5
    47d4:	03478733          	mul	a4,a5,s4
    47d8:	9709                	srai	a4,a4,0x22
    47da:	41f7d79b          	sraiw	a5,a5,0x1f
    47de:	40f707bb          	subw	a5,a4,a5
    47e2:	0307879b          	addiw	a5,a5,48
    47e6:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    47ea:	03448733          	mul	a4,s1,s4
    47ee:	9709                	srai	a4,a4,0x22
    47f0:	9f15                	subw	a4,a4,a3
    47f2:	0027179b          	slliw	a5,a4,0x2
    47f6:	9fb9                	addw	a5,a5,a4
    47f8:	0017979b          	slliw	a5,a5,0x1
    47fc:	40f487bb          	subw	a5,s1,a5
    4800:	0307879b          	addiw	a5,a5,48
    4804:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4808:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    480c:	85ea                	mv	a1,s10
    480e:	00003517          	auipc	a0,0x3
    4812:	c7250513          	addi	a0,a0,-910 # 7480 <malloc+0x209c>
    4816:	317000ef          	jal	532c <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    481a:	20200593          	li	a1,514
    481e:	856a                	mv	a0,s10
    4820:	72c000ef          	jal	4f4c <open>
    4824:	892a                	mv	s2,a0
    if(fd < 0){
    4826:	0e055863          	bgez	a0,4916 <fsfull+0x1dc>
      printf("open %s failed\n", name);
    482a:	f5040593          	addi	a1,s0,-176
    482e:	00003517          	auipc	a0,0x3
    4832:	c6250513          	addi	a0,a0,-926 # 7490 <malloc+0x20ac>
    4836:	2f7000ef          	jal	532c <printf>
    name[0] = 'f';
    483a:	06600c13          	li	s8,102
    name[1] = '0' + nfiles / 1000;
    483e:	10625a37          	lui	s4,0x10625
    4842:	dd3a0a13          	addi	s4,s4,-557 # 10624dd3 <base+0x1061412b>
    name[2] = '0' + (nfiles % 1000) / 100;
    4846:	3e800b93          	li	s7,1000
    484a:	51eb89b7          	lui	s3,0x51eb8
    484e:	51f98993          	addi	s3,s3,1311 # 51eb851f <base+0x51ea7877>
    name[3] = '0' + (nfiles % 100) / 10;
    4852:	06400b13          	li	s6,100
    4856:	66666937          	lui	s2,0x66666
    485a:	66790913          	addi	s2,s2,1639 # 66666667 <base+0x666559bf>
    unlink(name);
    485e:	f5040a93          	addi	s5,s0,-176
    name[0] = 'f';
    4862:	f5840823          	sb	s8,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4866:	034487b3          	mul	a5,s1,s4
    486a:	9799                	srai	a5,a5,0x26
    486c:	41f4d69b          	sraiw	a3,s1,0x1f
    4870:	9f95                	subw	a5,a5,a3
    4872:	0307871b          	addiw	a4,a5,48
    4876:	f4e408a3          	sb	a4,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    487a:	02fb87bb          	mulw	a5,s7,a5
    487e:	40f487bb          	subw	a5,s1,a5
    4882:	03378733          	mul	a4,a5,s3
    4886:	9715                	srai	a4,a4,0x25
    4888:	41f7d79b          	sraiw	a5,a5,0x1f
    488c:	40f707bb          	subw	a5,a4,a5
    4890:	0307879b          	addiw	a5,a5,48
    4894:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4898:	033487b3          	mul	a5,s1,s3
    489c:	9795                	srai	a5,a5,0x25
    489e:	9f95                	subw	a5,a5,a3
    48a0:	02fb07bb          	mulw	a5,s6,a5
    48a4:	40f487bb          	subw	a5,s1,a5
    48a8:	03278733          	mul	a4,a5,s2
    48ac:	9709                	srai	a4,a4,0x22
    48ae:	41f7d79b          	sraiw	a5,a5,0x1f
    48b2:	40f707bb          	subw	a5,a4,a5
    48b6:	0307879b          	addiw	a5,a5,48
    48ba:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    48be:	03248733          	mul	a4,s1,s2
    48c2:	9709                	srai	a4,a4,0x22
    48c4:	9f15                	subw	a4,a4,a3
    48c6:	0027179b          	slliw	a5,a4,0x2
    48ca:	9fb9                	addw	a5,a5,a4
    48cc:	0017979b          	slliw	a5,a5,0x1
    48d0:	40f487bb          	subw	a5,s1,a5
    48d4:	0307879b          	addiw	a5,a5,48
    48d8:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    48dc:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    48e0:	8556                	mv	a0,s5
    48e2:	67a000ef          	jal	4f5c <unlink>
    nfiles--;
    48e6:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    48e8:	f604dde3          	bgez	s1,4862 <fsfull+0x128>
  printf("fsfull test finished\n");
    48ec:	00003517          	auipc	a0,0x3
    48f0:	bc450513          	addi	a0,a0,-1084 # 74b0 <malloc+0x20cc>
    48f4:	239000ef          	jal	532c <printf>
}
    48f8:	70aa                	ld	ra,168(sp)
    48fa:	740a                	ld	s0,160(sp)
    48fc:	64ea                	ld	s1,152(sp)
    48fe:	694a                	ld	s2,144(sp)
    4900:	69aa                	ld	s3,136(sp)
    4902:	6a0a                	ld	s4,128(sp)
    4904:	7ae6                	ld	s5,120(sp)
    4906:	7b46                	ld	s6,112(sp)
    4908:	7ba6                	ld	s7,104(sp)
    490a:	7c06                	ld	s8,96(sp)
    490c:	6ce6                	ld	s9,88(sp)
    490e:	6d46                	ld	s10,80(sp)
    4910:	6da6                	ld	s11,72(sp)
    4912:	614d                	addi	sp,sp,176
    4914:	8082                	ret
    int total = 0;
    4916:	4981                	li	s3,0
      int cc = write(fd, buf, BSIZE);
    4918:	40000c13          	li	s8,1024
    491c:	00009b97          	auipc	s7,0x9
    4920:	38cb8b93          	addi	s7,s7,908 # dca8 <buf>
      if(cc < BSIZE)
    4924:	3ff00b13          	li	s6,1023
      int cc = write(fd, buf, BSIZE);
    4928:	8662                	mv	a2,s8
    492a:	85de                	mv	a1,s7
    492c:	854a                	mv	a0,s2
    492e:	5fe000ef          	jal	4f2c <write>
      if(cc < BSIZE)
    4932:	00ab5563          	bge	s6,a0,493c <fsfull+0x202>
      total += cc;
    4936:	00a989bb          	addw	s3,s3,a0
    while(1){
    493a:	b7fd                	j	4928 <fsfull+0x1ee>
    printf("wrote %d bytes\n", total);
    493c:	85ce                	mv	a1,s3
    493e:	00003517          	auipc	a0,0x3
    4942:	b6250513          	addi	a0,a0,-1182 # 74a0 <malloc+0x20bc>
    4946:	1e7000ef          	jal	532c <printf>
    close(fd);
    494a:	854a                	mv	a0,s2
    494c:	5e8000ef          	jal	4f34 <close>
    if(total == 0)
    4950:	ee0985e3          	beqz	s3,483a <fsfull+0x100>
  for(nfiles = 0; ; nfiles++){
    4954:	2485                	addiw	s1,s1,1
    4956:	bd05                	j	4786 <fsfull+0x4c>

0000000000004958 <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    4958:	7179                	addi	sp,sp,-48
    495a:	f406                	sd	ra,40(sp)
    495c:	f022                	sd	s0,32(sp)
    495e:	ec26                	sd	s1,24(sp)
    4960:	e84a                	sd	s2,16(sp)
    4962:	1800                	addi	s0,sp,48
    4964:	84aa                	mv	s1,a0
    4966:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    4968:	00003517          	auipc	a0,0x3
    496c:	b6050513          	addi	a0,a0,-1184 # 74c8 <malloc+0x20e4>
    4970:	1bd000ef          	jal	532c <printf>
  if((pid = fork()) < 0) {
    4974:	590000ef          	jal	4f04 <fork>
    4978:	02054a63          	bltz	a0,49ac <run+0x54>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    497c:	c129                	beqz	a0,49be <run+0x66>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    497e:	fdc40513          	addi	a0,s0,-36
    4982:	592000ef          	jal	4f14 <wait>
    if(xstatus != 0) 
    4986:	fdc42783          	lw	a5,-36(s0)
    498a:	cf9d                	beqz	a5,49c8 <run+0x70>
      printf("FAILED\n");
    498c:	00003517          	auipc	a0,0x3
    4990:	b6450513          	addi	a0,a0,-1180 # 74f0 <malloc+0x210c>
    4994:	199000ef          	jal	532c <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    4998:	fdc42503          	lw	a0,-36(s0)
  }
}
    499c:	00153513          	seqz	a0,a0
    49a0:	70a2                	ld	ra,40(sp)
    49a2:	7402                	ld	s0,32(sp)
    49a4:	64e2                	ld	s1,24(sp)
    49a6:	6942                	ld	s2,16(sp)
    49a8:	6145                	addi	sp,sp,48
    49aa:	8082                	ret
    printf("runtest: fork error\n");
    49ac:	00003517          	auipc	a0,0x3
    49b0:	b2c50513          	addi	a0,a0,-1236 # 74d8 <malloc+0x20f4>
    49b4:	179000ef          	jal	532c <printf>
    exit(1);
    49b8:	4505                	li	a0,1
    49ba:	552000ef          	jal	4f0c <exit>
    f(s);
    49be:	854a                	mv	a0,s2
    49c0:	9482                	jalr	s1
    exit(0);
    49c2:	4501                	li	a0,0
    49c4:	548000ef          	jal	4f0c <exit>
      printf("OK\n");
    49c8:	00003517          	auipc	a0,0x3
    49cc:	b3050513          	addi	a0,a0,-1232 # 74f8 <malloc+0x2114>
    49d0:	15d000ef          	jal	532c <printf>
    49d4:	b7d1                	j	4998 <run+0x40>

00000000000049d6 <runtests>:

int
runtests(struct test *tests, char *justone, int continuous) {
    49d6:	7139                	addi	sp,sp,-64
    49d8:	fc06                	sd	ra,56(sp)
    49da:	f822                	sd	s0,48(sp)
    49dc:	f426                	sd	s1,40(sp)
    49de:	ec4e                	sd	s3,24(sp)
    49e0:	0080                	addi	s0,sp,64
    49e2:	84aa                	mv	s1,a0
  int ntests = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    49e4:	6508                	ld	a0,8(a0)
    49e6:	cd39                	beqz	a0,4a44 <runtests+0x6e>
    49e8:	f04a                	sd	s2,32(sp)
    49ea:	e852                	sd	s4,16(sp)
    49ec:	e456                	sd	s5,8(sp)
    49ee:	892e                	mv	s2,a1
    49f0:	8a32                	mv	s4,a2
  int ntests = 0;
    49f2:	4981                	li	s3,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      ntests++;
      if(!run(t->f, t->s)){
        if(continuous != 2){
    49f4:	4a89                	li	s5,2
    49f6:	a021                	j	49fe <runtests+0x28>
  for (struct test *t = tests; t->s != 0; t++) {
    49f8:	04c1                	addi	s1,s1,16
    49fa:	6488                	ld	a0,8(s1)
    49fc:	c915                	beqz	a0,4a30 <runtests+0x5a>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    49fe:	00090663          	beqz	s2,4a0a <runtests+0x34>
    4a02:	85ca                	mv	a1,s2
    4a04:	270000ef          	jal	4c74 <strcmp>
    4a08:	f965                	bnez	a0,49f8 <runtests+0x22>
      ntests++;
    4a0a:	2985                	addiw	s3,s3,1
      if(!run(t->f, t->s)){
    4a0c:	648c                	ld	a1,8(s1)
    4a0e:	6088                	ld	a0,0(s1)
    4a10:	f49ff0ef          	jal	4958 <run>
    4a14:	f175                	bnez	a0,49f8 <runtests+0x22>
        if(continuous != 2){
    4a16:	ff5a01e3          	beq	s4,s5,49f8 <runtests+0x22>
          printf("SOME TESTS FAILED\n");
    4a1a:	00003517          	auipc	a0,0x3
    4a1e:	ae650513          	addi	a0,a0,-1306 # 7500 <malloc+0x211c>
    4a22:	10b000ef          	jal	532c <printf>
          return -1;
    4a26:	59fd                	li	s3,-1
    4a28:	7902                	ld	s2,32(sp)
    4a2a:	6a42                	ld	s4,16(sp)
    4a2c:	6aa2                	ld	s5,8(sp)
    4a2e:	a021                	j	4a36 <runtests+0x60>
    4a30:	7902                	ld	s2,32(sp)
    4a32:	6a42                	ld	s4,16(sp)
    4a34:	6aa2                	ld	s5,8(sp)
        }
      }
    }
  }
  return ntests;
}
    4a36:	854e                	mv	a0,s3
    4a38:	70e2                	ld	ra,56(sp)
    4a3a:	7442                	ld	s0,48(sp)
    4a3c:	74a2                	ld	s1,40(sp)
    4a3e:	69e2                	ld	s3,24(sp)
    4a40:	6121                	addi	sp,sp,64
    4a42:	8082                	ret
  return ntests;
    4a44:	4981                	li	s3,0
    4a46:	bfc5                	j	4a36 <runtests+0x60>

0000000000004a48 <countfree>:


// use sbrk() to count how many free physical memory pages there are.
int
countfree()
{
    4a48:	7179                	addi	sp,sp,-48
    4a4a:	f406                	sd	ra,40(sp)
    4a4c:	f022                	sd	s0,32(sp)
    4a4e:	ec26                	sd	s1,24(sp)
    4a50:	e84a                	sd	s2,16(sp)
    4a52:	e44e                	sd	s3,8(sp)
    4a54:	e052                	sd	s4,0(sp)
    4a56:	1800                	addi	s0,sp,48
  int n = 0;
  uint64 sz0 = (uint64)sbrk(0);
    4a58:	4501                	li	a0,0
    4a5a:	47e000ef          	jal	4ed8 <sbrk>
    4a5e:	8a2a                	mv	s4,a0
  int n = 0;
    4a60:	4481                	li	s1,0
  while(1){
    char *a = sbrk(PGSIZE);
    4a62:	6985                	lui	s3,0x1
    if(a == SBRK_ERROR){
    4a64:	597d                	li	s2,-1
    char *a = sbrk(PGSIZE);
    4a66:	854e                	mv	a0,s3
    4a68:	470000ef          	jal	4ed8 <sbrk>
    if(a == SBRK_ERROR){
    4a6c:	01250463          	beq	a0,s2,4a74 <countfree+0x2c>
      break;
    }
    n += 1;
    4a70:	2485                	addiw	s1,s1,1
  while(1){
    4a72:	bfd5                	j	4a66 <countfree+0x1e>
  }
  sbrk(-((uint64)sbrk(0) - sz0));  
    4a74:	4501                	li	a0,0
    4a76:	462000ef          	jal	4ed8 <sbrk>
    4a7a:	40aa053b          	subw	a0,s4,a0
    4a7e:	45a000ef          	jal	4ed8 <sbrk>
  return n;
}
    4a82:	8526                	mv	a0,s1
    4a84:	70a2                	ld	ra,40(sp)
    4a86:	7402                	ld	s0,32(sp)
    4a88:	64e2                	ld	s1,24(sp)
    4a8a:	6942                	ld	s2,16(sp)
    4a8c:	69a2                	ld	s3,8(sp)
    4a8e:	6a02                	ld	s4,0(sp)
    4a90:	6145                	addi	sp,sp,48
    4a92:	8082                	ret

0000000000004a94 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    4a94:	7159                	addi	sp,sp,-112
    4a96:	f486                	sd	ra,104(sp)
    4a98:	f0a2                	sd	s0,96(sp)
    4a9a:	eca6                	sd	s1,88(sp)
    4a9c:	e8ca                	sd	s2,80(sp)
    4a9e:	e4ce                	sd	s3,72(sp)
    4aa0:	e0d2                	sd	s4,64(sp)
    4aa2:	fc56                	sd	s5,56(sp)
    4aa4:	f85a                	sd	s6,48(sp)
    4aa6:	f45e                	sd	s7,40(sp)
    4aa8:	f062                	sd	s8,32(sp)
    4aaa:	ec66                	sd	s9,24(sp)
    4aac:	e86a                	sd	s10,16(sp)
    4aae:	e46e                	sd	s11,8(sp)
    4ab0:	1880                	addi	s0,sp,112
    4ab2:	8aaa                	mv	s5,a0
    4ab4:	89ae                	mv	s3,a1
    4ab6:	8a32                	mv	s4,a2
  do {
    printf("usertests starting\n");
    4ab8:	00003c17          	auipc	s8,0x3
    4abc:	a60c0c13          	addi	s8,s8,-1440 # 7518 <malloc+0x2134>
    int free0 = countfree();
    int free1 = 0;
    int ntests = 0;
    int n;
    n = runtests(quicktests, justone, continuous);
    4ac0:	00005b97          	auipc	s7,0x5
    4ac4:	550b8b93          	addi	s7,s7,1360 # a010 <quicktests>
    if (n < 0) {
      if(continuous != 2) {
    4ac8:	4b09                	li	s6,2
      ntests += n;
    }
    if(!quick) {
      if (justone == 0)
        printf("usertests slow tests starting\n");
      n = runtests(slowtests, justone, continuous);
    4aca:	00006c97          	auipc	s9,0x6
    4ace:	946c8c93          	addi	s9,s9,-1722 # a410 <slowtests>
        printf("usertests slow tests starting\n");
    4ad2:	00003d97          	auipc	s11,0x3
    4ad6:	a5ed8d93          	addi	s11,s11,-1442 # 7530 <malloc+0x214c>
      } else {
        ntests += n;
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4ada:	00003d17          	auipc	s10,0x3
    4ade:	a76d0d13          	addi	s10,s10,-1418 # 7550 <malloc+0x216c>
    4ae2:	a025                	j	4b0a <drivetests+0x76>
      if(continuous != 2) {
    4ae4:	09699063          	bne	s3,s6,4b64 <drivetests+0xd0>
    int ntests = 0;
    4ae8:	4481                	li	s1,0
    4aea:	a835                	j	4b26 <drivetests+0x92>
        printf("usertests slow tests starting\n");
    4aec:	856e                	mv	a0,s11
    4aee:	03f000ef          	jal	532c <printf>
    4af2:	a835                	j	4b2e <drivetests+0x9a>
        if(continuous != 2) {
    4af4:	07699a63          	bne	s3,s6,4b68 <drivetests+0xd4>
    if((free1 = countfree()) < free0) {
    4af8:	f51ff0ef          	jal	4a48 <countfree>
    4afc:	05254263          	blt	a0,s2,4b40 <drivetests+0xac>
      if(continuous != 2) {
        return 1;
      }
    }
    if (justone != 0 && ntests == 0) {
    4b00:	000a0363          	beqz	s4,4b06 <drivetests+0x72>
    4b04:	c8a1                	beqz	s1,4b54 <drivetests+0xc0>
      printf("NO TESTS EXECUTED\n");
      return 1;
    }
  } while(continuous);
    4b06:	06098563          	beqz	s3,4b70 <drivetests+0xdc>
    printf("usertests starting\n");
    4b0a:	8562                	mv	a0,s8
    4b0c:	021000ef          	jal	532c <printf>
    int free0 = countfree();
    4b10:	f39ff0ef          	jal	4a48 <countfree>
    4b14:	892a                	mv	s2,a0
    n = runtests(quicktests, justone, continuous);
    4b16:	864e                	mv	a2,s3
    4b18:	85d2                	mv	a1,s4
    4b1a:	855e                	mv	a0,s7
    4b1c:	ebbff0ef          	jal	49d6 <runtests>
    4b20:	84aa                	mv	s1,a0
    if (n < 0) {
    4b22:	fc0541e3          	bltz	a0,4ae4 <drivetests+0x50>
    if(!quick) {
    4b26:	fc0a99e3          	bnez	s5,4af8 <drivetests+0x64>
      if (justone == 0)
    4b2a:	fc0a01e3          	beqz	s4,4aec <drivetests+0x58>
      n = runtests(slowtests, justone, continuous);
    4b2e:	864e                	mv	a2,s3
    4b30:	85d2                	mv	a1,s4
    4b32:	8566                	mv	a0,s9
    4b34:	ea3ff0ef          	jal	49d6 <runtests>
      if (n < 0) {
    4b38:	fa054ee3          	bltz	a0,4af4 <drivetests+0x60>
        ntests += n;
    4b3c:	9ca9                	addw	s1,s1,a0
    4b3e:	bf6d                	j	4af8 <drivetests+0x64>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    4b40:	864a                	mv	a2,s2
    4b42:	85aa                	mv	a1,a0
    4b44:	856a                	mv	a0,s10
    4b46:	7e6000ef          	jal	532c <printf>
      if(continuous != 2) {
    4b4a:	03699163          	bne	s3,s6,4b6c <drivetests+0xd8>
    if (justone != 0 && ntests == 0) {
    4b4e:	fa0a1be3          	bnez	s4,4b04 <drivetests+0x70>
    4b52:	bf65                	j	4b0a <drivetests+0x76>
      printf("NO TESTS EXECUTED\n");
    4b54:	00003517          	auipc	a0,0x3
    4b58:	a2c50513          	addi	a0,a0,-1492 # 7580 <malloc+0x219c>
    4b5c:	7d0000ef          	jal	532c <printf>
      return 1;
    4b60:	4505                	li	a0,1
    4b62:	a801                	j	4b72 <drivetests+0xde>
        return 1;
    4b64:	4505                	li	a0,1
    4b66:	a031                	j	4b72 <drivetests+0xde>
          return 1;
    4b68:	4505                	li	a0,1
    4b6a:	a021                	j	4b72 <drivetests+0xde>
        return 1;
    4b6c:	4505                	li	a0,1
    4b6e:	a011                	j	4b72 <drivetests+0xde>
  return 0;
    4b70:	854e                	mv	a0,s3
}
    4b72:	70a6                	ld	ra,104(sp)
    4b74:	7406                	ld	s0,96(sp)
    4b76:	64e6                	ld	s1,88(sp)
    4b78:	6946                	ld	s2,80(sp)
    4b7a:	69a6                	ld	s3,72(sp)
    4b7c:	6a06                	ld	s4,64(sp)
    4b7e:	7ae2                	ld	s5,56(sp)
    4b80:	7b42                	ld	s6,48(sp)
    4b82:	7ba2                	ld	s7,40(sp)
    4b84:	7c02                	ld	s8,32(sp)
    4b86:	6ce2                	ld	s9,24(sp)
    4b88:	6d42                	ld	s10,16(sp)
    4b8a:	6da2                	ld	s11,8(sp)
    4b8c:	6165                	addi	sp,sp,112
    4b8e:	8082                	ret

0000000000004b90 <main>:

int
main(int argc, char *argv[])
{
    4b90:	1101                	addi	sp,sp,-32
    4b92:	ec06                	sd	ra,24(sp)
    4b94:	e822                	sd	s0,16(sp)
    4b96:	e426                	sd	s1,8(sp)
    4b98:	e04a                	sd	s2,0(sp)
    4b9a:	1000                	addi	s0,sp,32
    4b9c:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4b9e:	4789                	li	a5,2
    4ba0:	00f50e63          	beq	a0,a5,4bbc <main+0x2c>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    4ba4:	4785                	li	a5,1
    4ba6:	06a7c663          	blt	a5,a0,4c12 <main+0x82>
  char *justone = 0;
    4baa:	4601                	li	a2,0
  int quick = 0;
    4bac:	4501                	li	a0,0
  int continuous = 0;
    4bae:	4581                	li	a1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    4bb0:	ee5ff0ef          	jal	4a94 <drivetests>
    4bb4:	cd35                	beqz	a0,4c30 <main+0xa0>
    exit(1);
    4bb6:	4505                	li	a0,1
    4bb8:	354000ef          	jal	4f0c <exit>
    4bbc:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    4bbe:	00003597          	auipc	a1,0x3
    4bc2:	9da58593          	addi	a1,a1,-1574 # 7598 <malloc+0x21b4>
    4bc6:	00893503          	ld	a0,8(s2)
    4bca:	0aa000ef          	jal	4c74 <strcmp>
    4bce:	85aa                	mv	a1,a0
    4bd0:	e501                	bnez	a0,4bd8 <main+0x48>
  char *justone = 0;
    4bd2:	4601                	li	a2,0
    quick = 1;
    4bd4:	4505                	li	a0,1
    4bd6:	bfe9                	j	4bb0 <main+0x20>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    4bd8:	00003597          	auipc	a1,0x3
    4bdc:	9c858593          	addi	a1,a1,-1592 # 75a0 <malloc+0x21bc>
    4be0:	00893503          	ld	a0,8(s2)
    4be4:	090000ef          	jal	4c74 <strcmp>
    4be8:	cd15                	beqz	a0,4c24 <main+0x94>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    4bea:	00003597          	auipc	a1,0x3
    4bee:	a0658593          	addi	a1,a1,-1530 # 75f0 <malloc+0x220c>
    4bf2:	00893503          	ld	a0,8(s2)
    4bf6:	07e000ef          	jal	4c74 <strcmp>
    4bfa:	c905                	beqz	a0,4c2a <main+0x9a>
  } else if(argc == 2 && argv[1][0] != '-'){
    4bfc:	00893603          	ld	a2,8(s2)
    4c00:	00064703          	lbu	a4,0(a2) # 1000 <bigdir+0x10a>
    4c04:	02d00793          	li	a5,45
    4c08:	00f70563          	beq	a4,a5,4c12 <main+0x82>
  int quick = 0;
    4c0c:	4501                	li	a0,0
  int continuous = 0;
    4c0e:	4581                	li	a1,0
    4c10:	b745                	j	4bb0 <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    4c12:	00003517          	auipc	a0,0x3
    4c16:	99650513          	addi	a0,a0,-1642 # 75a8 <malloc+0x21c4>
    4c1a:	712000ef          	jal	532c <printf>
    exit(1);
    4c1e:	4505                	li	a0,1
    4c20:	2ec000ef          	jal	4f0c <exit>
  char *justone = 0;
    4c24:	4601                	li	a2,0
    continuous = 1;
    4c26:	4585                	li	a1,1
    4c28:	b761                	j	4bb0 <main+0x20>
    continuous = 2;
    4c2a:	85a6                	mv	a1,s1
  char *justone = 0;
    4c2c:	4601                	li	a2,0
    4c2e:	b749                	j	4bb0 <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    4c30:	00003517          	auipc	a0,0x3
    4c34:	9a850513          	addi	a0,a0,-1624 # 75d8 <malloc+0x21f4>
    4c38:	6f4000ef          	jal	532c <printf>
  exit(0);
    4c3c:	4501                	li	a0,0
    4c3e:	2ce000ef          	jal	4f0c <exit>

0000000000004c42 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
    4c42:	1141                	addi	sp,sp,-16
    4c44:	e406                	sd	ra,8(sp)
    4c46:	e022                	sd	s0,0(sp)
    4c48:	0800                	addi	s0,sp,16
  extern int main();
  main();
    4c4a:	f47ff0ef          	jal	4b90 <main>
  exit(0);
    4c4e:	4501                	li	a0,0
    4c50:	2bc000ef          	jal	4f0c <exit>

0000000000004c54 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    4c54:	1141                	addi	sp,sp,-16
    4c56:	e406                	sd	ra,8(sp)
    4c58:	e022                	sd	s0,0(sp)
    4c5a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    4c5c:	87aa                	mv	a5,a0
    4c5e:	0585                	addi	a1,a1,1
    4c60:	0785                	addi	a5,a5,1
    4c62:	fff5c703          	lbu	a4,-1(a1)
    4c66:	fee78fa3          	sb	a4,-1(a5)
    4c6a:	fb75                	bnez	a4,4c5e <strcpy+0xa>
    ;
  return os;
}
    4c6c:	60a2                	ld	ra,8(sp)
    4c6e:	6402                	ld	s0,0(sp)
    4c70:	0141                	addi	sp,sp,16
    4c72:	8082                	ret

0000000000004c74 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    4c74:	1141                	addi	sp,sp,-16
    4c76:	e406                	sd	ra,8(sp)
    4c78:	e022                	sd	s0,0(sp)
    4c7a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    4c7c:	00054783          	lbu	a5,0(a0)
    4c80:	cb91                	beqz	a5,4c94 <strcmp+0x20>
    4c82:	0005c703          	lbu	a4,0(a1)
    4c86:	00f71763          	bne	a4,a5,4c94 <strcmp+0x20>
    p++, q++;
    4c8a:	0505                	addi	a0,a0,1
    4c8c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    4c8e:	00054783          	lbu	a5,0(a0)
    4c92:	fbe5                	bnez	a5,4c82 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
    4c94:	0005c503          	lbu	a0,0(a1)
}
    4c98:	40a7853b          	subw	a0,a5,a0
    4c9c:	60a2                	ld	ra,8(sp)
    4c9e:	6402                	ld	s0,0(sp)
    4ca0:	0141                	addi	sp,sp,16
    4ca2:	8082                	ret

0000000000004ca4 <strlen>:

uint
strlen(const char *s)
{
    4ca4:	1141                	addi	sp,sp,-16
    4ca6:	e406                	sd	ra,8(sp)
    4ca8:	e022                	sd	s0,0(sp)
    4caa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    4cac:	00054783          	lbu	a5,0(a0)
    4cb0:	cf99                	beqz	a5,4cce <strlen+0x2a>
    4cb2:	0505                	addi	a0,a0,1
    4cb4:	87aa                	mv	a5,a0
    4cb6:	86be                	mv	a3,a5
    4cb8:	0785                	addi	a5,a5,1
    4cba:	fff7c703          	lbu	a4,-1(a5)
    4cbe:	ff65                	bnez	a4,4cb6 <strlen+0x12>
    4cc0:	40a6853b          	subw	a0,a3,a0
    4cc4:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    4cc6:	60a2                	ld	ra,8(sp)
    4cc8:	6402                	ld	s0,0(sp)
    4cca:	0141                	addi	sp,sp,16
    4ccc:	8082                	ret
  for(n = 0; s[n]; n++)
    4cce:	4501                	li	a0,0
    4cd0:	bfdd                	j	4cc6 <strlen+0x22>

0000000000004cd2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    4cd2:	1141                	addi	sp,sp,-16
    4cd4:	e406                	sd	ra,8(sp)
    4cd6:	e022                	sd	s0,0(sp)
    4cd8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    4cda:	ca19                	beqz	a2,4cf0 <memset+0x1e>
    4cdc:	87aa                	mv	a5,a0
    4cde:	1602                	slli	a2,a2,0x20
    4ce0:	9201                	srli	a2,a2,0x20
    4ce2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    4ce6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    4cea:	0785                	addi	a5,a5,1
    4cec:	fee79de3          	bne	a5,a4,4ce6 <memset+0x14>
  }
  return dst;
}
    4cf0:	60a2                	ld	ra,8(sp)
    4cf2:	6402                	ld	s0,0(sp)
    4cf4:	0141                	addi	sp,sp,16
    4cf6:	8082                	ret

0000000000004cf8 <strchr>:

char*
strchr(const char *s, char c)
{
    4cf8:	1141                	addi	sp,sp,-16
    4cfa:	e406                	sd	ra,8(sp)
    4cfc:	e022                	sd	s0,0(sp)
    4cfe:	0800                	addi	s0,sp,16
  for(; *s; s++)
    4d00:	00054783          	lbu	a5,0(a0)
    4d04:	cf81                	beqz	a5,4d1c <strchr+0x24>
    if(*s == c)
    4d06:	00f58763          	beq	a1,a5,4d14 <strchr+0x1c>
  for(; *s; s++)
    4d0a:	0505                	addi	a0,a0,1
    4d0c:	00054783          	lbu	a5,0(a0)
    4d10:	fbfd                	bnez	a5,4d06 <strchr+0xe>
      return (char*)s;
  return 0;
    4d12:	4501                	li	a0,0
}
    4d14:	60a2                	ld	ra,8(sp)
    4d16:	6402                	ld	s0,0(sp)
    4d18:	0141                	addi	sp,sp,16
    4d1a:	8082                	ret
  return 0;
    4d1c:	4501                	li	a0,0
    4d1e:	bfdd                	j	4d14 <strchr+0x1c>

0000000000004d20 <gets>:

char*
gets(char *buf, int max)
{
    4d20:	7159                	addi	sp,sp,-112
    4d22:	f486                	sd	ra,104(sp)
    4d24:	f0a2                	sd	s0,96(sp)
    4d26:	eca6                	sd	s1,88(sp)
    4d28:	e8ca                	sd	s2,80(sp)
    4d2a:	e4ce                	sd	s3,72(sp)
    4d2c:	e0d2                	sd	s4,64(sp)
    4d2e:	fc56                	sd	s5,56(sp)
    4d30:	f85a                	sd	s6,48(sp)
    4d32:	f45e                	sd	s7,40(sp)
    4d34:	f062                	sd	s8,32(sp)
    4d36:	ec66                	sd	s9,24(sp)
    4d38:	e86a                	sd	s10,16(sp)
    4d3a:	1880                	addi	s0,sp,112
    4d3c:	8caa                	mv	s9,a0
    4d3e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    4d40:	892a                	mv	s2,a0
    4d42:	4481                	li	s1,0
    cc = read(0, &c, 1);
    4d44:	f9f40b13          	addi	s6,s0,-97
    4d48:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    4d4a:	4ba9                	li	s7,10
    4d4c:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
    4d4e:	8d26                	mv	s10,s1
    4d50:	0014899b          	addiw	s3,s1,1
    4d54:	84ce                	mv	s1,s3
    4d56:	0349d563          	bge	s3,s4,4d80 <gets+0x60>
    cc = read(0, &c, 1);
    4d5a:	8656                	mv	a2,s5
    4d5c:	85da                	mv	a1,s6
    4d5e:	4501                	li	a0,0
    4d60:	1c4000ef          	jal	4f24 <read>
    if(cc < 1)
    4d64:	00a05e63          	blez	a0,4d80 <gets+0x60>
    buf[i++] = c;
    4d68:	f9f44783          	lbu	a5,-97(s0)
    4d6c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    4d70:	01778763          	beq	a5,s7,4d7e <gets+0x5e>
    4d74:	0905                	addi	s2,s2,1
    4d76:	fd879ce3          	bne	a5,s8,4d4e <gets+0x2e>
    buf[i++] = c;
    4d7a:	8d4e                	mv	s10,s3
    4d7c:	a011                	j	4d80 <gets+0x60>
    4d7e:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
    4d80:	9d66                	add	s10,s10,s9
    4d82:	000d0023          	sb	zero,0(s10)
  return buf;
}
    4d86:	8566                	mv	a0,s9
    4d88:	70a6                	ld	ra,104(sp)
    4d8a:	7406                	ld	s0,96(sp)
    4d8c:	64e6                	ld	s1,88(sp)
    4d8e:	6946                	ld	s2,80(sp)
    4d90:	69a6                	ld	s3,72(sp)
    4d92:	6a06                	ld	s4,64(sp)
    4d94:	7ae2                	ld	s5,56(sp)
    4d96:	7b42                	ld	s6,48(sp)
    4d98:	7ba2                	ld	s7,40(sp)
    4d9a:	7c02                	ld	s8,32(sp)
    4d9c:	6ce2                	ld	s9,24(sp)
    4d9e:	6d42                	ld	s10,16(sp)
    4da0:	6165                	addi	sp,sp,112
    4da2:	8082                	ret

0000000000004da4 <stat>:

int
stat(const char *n, struct stat *st)
{
    4da4:	1101                	addi	sp,sp,-32
    4da6:	ec06                	sd	ra,24(sp)
    4da8:	e822                	sd	s0,16(sp)
    4daa:	e04a                	sd	s2,0(sp)
    4dac:	1000                	addi	s0,sp,32
    4dae:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    4db0:	4581                	li	a1,0
    4db2:	19a000ef          	jal	4f4c <open>
  if(fd < 0)
    4db6:	02054263          	bltz	a0,4dda <stat+0x36>
    4dba:	e426                	sd	s1,8(sp)
    4dbc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    4dbe:	85ca                	mv	a1,s2
    4dc0:	1a4000ef          	jal	4f64 <fstat>
    4dc4:	892a                	mv	s2,a0
  close(fd);
    4dc6:	8526                	mv	a0,s1
    4dc8:	16c000ef          	jal	4f34 <close>
  return r;
    4dcc:	64a2                	ld	s1,8(sp)
}
    4dce:	854a                	mv	a0,s2
    4dd0:	60e2                	ld	ra,24(sp)
    4dd2:	6442                	ld	s0,16(sp)
    4dd4:	6902                	ld	s2,0(sp)
    4dd6:	6105                	addi	sp,sp,32
    4dd8:	8082                	ret
    return -1;
    4dda:	597d                	li	s2,-1
    4ddc:	bfcd                	j	4dce <stat+0x2a>

0000000000004dde <atoi>:

int
atoi(const char *s)
{
    4dde:	1141                	addi	sp,sp,-16
    4de0:	e406                	sd	ra,8(sp)
    4de2:	e022                	sd	s0,0(sp)
    4de4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    4de6:	00054683          	lbu	a3,0(a0)
    4dea:	fd06879b          	addiw	a5,a3,-48 # 3ffd0 <base+0x2f328>
    4dee:	0ff7f793          	zext.b	a5,a5
    4df2:	4625                	li	a2,9
    4df4:	02f66963          	bltu	a2,a5,4e26 <atoi+0x48>
    4df8:	872a                	mv	a4,a0
  n = 0;
    4dfa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    4dfc:	0705                	addi	a4,a4,1 # 1000001 <base+0xfef359>
    4dfe:	0025179b          	slliw	a5,a0,0x2
    4e02:	9fa9                	addw	a5,a5,a0
    4e04:	0017979b          	slliw	a5,a5,0x1
    4e08:	9fb5                	addw	a5,a5,a3
    4e0a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    4e0e:	00074683          	lbu	a3,0(a4)
    4e12:	fd06879b          	addiw	a5,a3,-48
    4e16:	0ff7f793          	zext.b	a5,a5
    4e1a:	fef671e3          	bgeu	a2,a5,4dfc <atoi+0x1e>
  return n;
}
    4e1e:	60a2                	ld	ra,8(sp)
    4e20:	6402                	ld	s0,0(sp)
    4e22:	0141                	addi	sp,sp,16
    4e24:	8082                	ret
  n = 0;
    4e26:	4501                	li	a0,0
    4e28:	bfdd                	j	4e1e <atoi+0x40>

0000000000004e2a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    4e2a:	1141                	addi	sp,sp,-16
    4e2c:	e406                	sd	ra,8(sp)
    4e2e:	e022                	sd	s0,0(sp)
    4e30:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    4e32:	02b57563          	bgeu	a0,a1,4e5c <memmove+0x32>
    while(n-- > 0)
    4e36:	00c05f63          	blez	a2,4e54 <memmove+0x2a>
    4e3a:	1602                	slli	a2,a2,0x20
    4e3c:	9201                	srli	a2,a2,0x20
    4e3e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    4e42:	872a                	mv	a4,a0
      *dst++ = *src++;
    4e44:	0585                	addi	a1,a1,1
    4e46:	0705                	addi	a4,a4,1
    4e48:	fff5c683          	lbu	a3,-1(a1)
    4e4c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    4e50:	fee79ae3          	bne	a5,a4,4e44 <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    4e54:	60a2                	ld	ra,8(sp)
    4e56:	6402                	ld	s0,0(sp)
    4e58:	0141                	addi	sp,sp,16
    4e5a:	8082                	ret
    dst += n;
    4e5c:	00c50733          	add	a4,a0,a2
    src += n;
    4e60:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    4e62:	fec059e3          	blez	a2,4e54 <memmove+0x2a>
    4e66:	fff6079b          	addiw	a5,a2,-1
    4e6a:	1782                	slli	a5,a5,0x20
    4e6c:	9381                	srli	a5,a5,0x20
    4e6e:	fff7c793          	not	a5,a5
    4e72:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    4e74:	15fd                	addi	a1,a1,-1
    4e76:	177d                	addi	a4,a4,-1
    4e78:	0005c683          	lbu	a3,0(a1)
    4e7c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    4e80:	fef71ae3          	bne	a4,a5,4e74 <memmove+0x4a>
    4e84:	bfc1                	j	4e54 <memmove+0x2a>

0000000000004e86 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    4e86:	1141                	addi	sp,sp,-16
    4e88:	e406                	sd	ra,8(sp)
    4e8a:	e022                	sd	s0,0(sp)
    4e8c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    4e8e:	ca0d                	beqz	a2,4ec0 <memcmp+0x3a>
    4e90:	fff6069b          	addiw	a3,a2,-1
    4e94:	1682                	slli	a3,a3,0x20
    4e96:	9281                	srli	a3,a3,0x20
    4e98:	0685                	addi	a3,a3,1
    4e9a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    4e9c:	00054783          	lbu	a5,0(a0)
    4ea0:	0005c703          	lbu	a4,0(a1)
    4ea4:	00e79863          	bne	a5,a4,4eb4 <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
    4ea8:	0505                	addi	a0,a0,1
    p2++;
    4eaa:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    4eac:	fed518e3          	bne	a0,a3,4e9c <memcmp+0x16>
  }
  return 0;
    4eb0:	4501                	li	a0,0
    4eb2:	a019                	j	4eb8 <memcmp+0x32>
      return *p1 - *p2;
    4eb4:	40e7853b          	subw	a0,a5,a4
}
    4eb8:	60a2                	ld	ra,8(sp)
    4eba:	6402                	ld	s0,0(sp)
    4ebc:	0141                	addi	sp,sp,16
    4ebe:	8082                	ret
  return 0;
    4ec0:	4501                	li	a0,0
    4ec2:	bfdd                	j	4eb8 <memcmp+0x32>

0000000000004ec4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    4ec4:	1141                	addi	sp,sp,-16
    4ec6:	e406                	sd	ra,8(sp)
    4ec8:	e022                	sd	s0,0(sp)
    4eca:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    4ecc:	f5fff0ef          	jal	4e2a <memmove>
}
    4ed0:	60a2                	ld	ra,8(sp)
    4ed2:	6402                	ld	s0,0(sp)
    4ed4:	0141                	addi	sp,sp,16
    4ed6:	8082                	ret

0000000000004ed8 <sbrk>:

char *
sbrk(int n) {
    4ed8:	1141                	addi	sp,sp,-16
    4eda:	e406                	sd	ra,8(sp)
    4edc:	e022                	sd	s0,0(sp)
    4ede:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
    4ee0:	4585                	li	a1,1
    4ee2:	0b2000ef          	jal	4f94 <sys_sbrk>
}
    4ee6:	60a2                	ld	ra,8(sp)
    4ee8:	6402                	ld	s0,0(sp)
    4eea:	0141                	addi	sp,sp,16
    4eec:	8082                	ret

0000000000004eee <sbrklazy>:

char *
sbrklazy(int n) {
    4eee:	1141                	addi	sp,sp,-16
    4ef0:	e406                	sd	ra,8(sp)
    4ef2:	e022                	sd	s0,0(sp)
    4ef4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
    4ef6:	4589                	li	a1,2
    4ef8:	09c000ef          	jal	4f94 <sys_sbrk>
}
    4efc:	60a2                	ld	ra,8(sp)
    4efe:	6402                	ld	s0,0(sp)
    4f00:	0141                	addi	sp,sp,16
    4f02:	8082                	ret

0000000000004f04 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    4f04:	4885                	li	a7,1
 ecall
    4f06:	00000073          	ecall
 ret
    4f0a:	8082                	ret

0000000000004f0c <exit>:
.global exit
exit:
 li a7, SYS_exit
    4f0c:	4889                	li	a7,2
 ecall
    4f0e:	00000073          	ecall
 ret
    4f12:	8082                	ret

0000000000004f14 <wait>:
.global wait
wait:
 li a7, SYS_wait
    4f14:	488d                	li	a7,3
 ecall
    4f16:	00000073          	ecall
 ret
    4f1a:	8082                	ret

0000000000004f1c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    4f1c:	4891                	li	a7,4
 ecall
    4f1e:	00000073          	ecall
 ret
    4f22:	8082                	ret

0000000000004f24 <read>:
.global read
read:
 li a7, SYS_read
    4f24:	4895                	li	a7,5
 ecall
    4f26:	00000073          	ecall
 ret
    4f2a:	8082                	ret

0000000000004f2c <write>:
.global write
write:
 li a7, SYS_write
    4f2c:	48c1                	li	a7,16
 ecall
    4f2e:	00000073          	ecall
 ret
    4f32:	8082                	ret

0000000000004f34 <close>:
.global close
close:
 li a7, SYS_close
    4f34:	48d5                	li	a7,21
 ecall
    4f36:	00000073          	ecall
 ret
    4f3a:	8082                	ret

0000000000004f3c <kill>:
.global kill
kill:
 li a7, SYS_kill
    4f3c:	4899                	li	a7,6
 ecall
    4f3e:	00000073          	ecall
 ret
    4f42:	8082                	ret

0000000000004f44 <exec>:
.global exec
exec:
 li a7, SYS_exec
    4f44:	489d                	li	a7,7
 ecall
    4f46:	00000073          	ecall
 ret
    4f4a:	8082                	ret

0000000000004f4c <open>:
.global open
open:
 li a7, SYS_open
    4f4c:	48bd                	li	a7,15
 ecall
    4f4e:	00000073          	ecall
 ret
    4f52:	8082                	ret

0000000000004f54 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    4f54:	48c5                	li	a7,17
 ecall
    4f56:	00000073          	ecall
 ret
    4f5a:	8082                	ret

0000000000004f5c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    4f5c:	48c9                	li	a7,18
 ecall
    4f5e:	00000073          	ecall
 ret
    4f62:	8082                	ret

0000000000004f64 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    4f64:	48a1                	li	a7,8
 ecall
    4f66:	00000073          	ecall
 ret
    4f6a:	8082                	ret

0000000000004f6c <link>:
.global link
link:
 li a7, SYS_link
    4f6c:	48cd                	li	a7,19
 ecall
    4f6e:	00000073          	ecall
 ret
    4f72:	8082                	ret

0000000000004f74 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    4f74:	48d1                	li	a7,20
 ecall
    4f76:	00000073          	ecall
 ret
    4f7a:	8082                	ret

0000000000004f7c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    4f7c:	48a5                	li	a7,9
 ecall
    4f7e:	00000073          	ecall
 ret
    4f82:	8082                	ret

0000000000004f84 <dup>:
.global dup
dup:
 li a7, SYS_dup
    4f84:	48a9                	li	a7,10
 ecall
    4f86:	00000073          	ecall
 ret
    4f8a:	8082                	ret

0000000000004f8c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    4f8c:	48ad                	li	a7,11
 ecall
    4f8e:	00000073          	ecall
 ret
    4f92:	8082                	ret

0000000000004f94 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
    4f94:	48b1                	li	a7,12
 ecall
    4f96:	00000073          	ecall
 ret
    4f9a:	8082                	ret

0000000000004f9c <pause>:
.global pause
pause:
 li a7, SYS_pause
    4f9c:	48b5                	li	a7,13
 ecall
    4f9e:	00000073          	ecall
 ret
    4fa2:	8082                	ret

0000000000004fa4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    4fa4:	48b9                	li	a7,14
 ecall
    4fa6:	00000073          	ecall
 ret
    4faa:	8082                	ret

0000000000004fac <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    4fac:	1101                	addi	sp,sp,-32
    4fae:	ec06                	sd	ra,24(sp)
    4fb0:	e822                	sd	s0,16(sp)
    4fb2:	1000                	addi	s0,sp,32
    4fb4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    4fb8:	4605                	li	a2,1
    4fba:	fef40593          	addi	a1,s0,-17
    4fbe:	f6fff0ef          	jal	4f2c <write>
}
    4fc2:	60e2                	ld	ra,24(sp)
    4fc4:	6442                	ld	s0,16(sp)
    4fc6:	6105                	addi	sp,sp,32
    4fc8:	8082                	ret

0000000000004fca <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
    4fca:	715d                	addi	sp,sp,-80
    4fcc:	e486                	sd	ra,72(sp)
    4fce:	e0a2                	sd	s0,64(sp)
    4fd0:	fc26                	sd	s1,56(sp)
    4fd2:	f84a                	sd	s2,48(sp)
    4fd4:	f44e                	sd	s3,40(sp)
    4fd6:	0880                	addi	s0,sp,80
    4fd8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    4fda:	c299                	beqz	a3,4fe0 <printint+0x16>
    4fdc:	0605cf63          	bltz	a1,505a <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    4fe0:	2581                	sext.w	a1,a1
  neg = 0;
    4fe2:	4e01                	li	t3,0
  }

  i = 0;
    4fe4:	fb840313          	addi	t1,s0,-72
  neg = 0;
    4fe8:	869a                	mv	a3,t1
  i = 0;
    4fea:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
    4fec:	00003817          	auipc	a6,0x3
    4ff0:	a2480813          	addi	a6,a6,-1500 # 7a10 <digits>
    4ff4:	88be                	mv	a7,a5
    4ff6:	0017851b          	addiw	a0,a5,1
    4ffa:	87aa                	mv	a5,a0
    4ffc:	02c5f73b          	remuw	a4,a1,a2
    5000:	1702                	slli	a4,a4,0x20
    5002:	9301                	srli	a4,a4,0x20
    5004:	9742                	add	a4,a4,a6
    5006:	00074703          	lbu	a4,0(a4)
    500a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
    500e:	872e                	mv	a4,a1
    5010:	02c5d5bb          	divuw	a1,a1,a2
    5014:	0685                	addi	a3,a3,1
    5016:	fcc77fe3          	bgeu	a4,a2,4ff4 <printint+0x2a>
  if(neg)
    501a:	000e0c63          	beqz	t3,5032 <printint+0x68>
    buf[i++] = '-';
    501e:	fd050793          	addi	a5,a0,-48
    5022:	00878533          	add	a0,a5,s0
    5026:	02d00793          	li	a5,45
    502a:	fef50423          	sb	a5,-24(a0)
    502e:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    5032:	fff7899b          	addiw	s3,a5,-1
    5036:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
    503a:	fff4c583          	lbu	a1,-1(s1)
    503e:	854a                	mv	a0,s2
    5040:	f6dff0ef          	jal	4fac <putc>
  while(--i >= 0)
    5044:	39fd                	addiw	s3,s3,-1 # fff <bigdir+0x109>
    5046:	14fd                	addi	s1,s1,-1
    5048:	fe09d9e3          	bgez	s3,503a <printint+0x70>
}
    504c:	60a6                	ld	ra,72(sp)
    504e:	6406                	ld	s0,64(sp)
    5050:	74e2                	ld	s1,56(sp)
    5052:	7942                	ld	s2,48(sp)
    5054:	79a2                	ld	s3,40(sp)
    5056:	6161                	addi	sp,sp,80
    5058:	8082                	ret
    x = -xx;
    505a:	40b005bb          	negw	a1,a1
    neg = 1;
    505e:	4e05                	li	t3,1
    x = -xx;
    5060:	b751                	j	4fe4 <printint+0x1a>

0000000000005062 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5062:	711d                	addi	sp,sp,-96
    5064:	ec86                	sd	ra,88(sp)
    5066:	e8a2                	sd	s0,80(sp)
    5068:	e4a6                	sd	s1,72(sp)
    506a:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    506c:	0005c483          	lbu	s1,0(a1)
    5070:	28048463          	beqz	s1,52f8 <vprintf+0x296>
    5074:	e0ca                	sd	s2,64(sp)
    5076:	fc4e                	sd	s3,56(sp)
    5078:	f852                	sd	s4,48(sp)
    507a:	f456                	sd	s5,40(sp)
    507c:	f05a                	sd	s6,32(sp)
    507e:	ec5e                	sd	s7,24(sp)
    5080:	e862                	sd	s8,16(sp)
    5082:	e466                	sd	s9,8(sp)
    5084:	8b2a                	mv	s6,a0
    5086:	8a2e                	mv	s4,a1
    5088:	8bb2                	mv	s7,a2
  state = 0;
    508a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
    508c:	4901                	li	s2,0
    508e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
    5090:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
    5094:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
    5098:	06c00c93          	li	s9,108
    509c:	a00d                	j	50be <vprintf+0x5c>
        putc(fd, c0);
    509e:	85a6                	mv	a1,s1
    50a0:	855a                	mv	a0,s6
    50a2:	f0bff0ef          	jal	4fac <putc>
    50a6:	a019                	j	50ac <vprintf+0x4a>
    } else if(state == '%'){
    50a8:	03598363          	beq	s3,s5,50ce <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
    50ac:	0019079b          	addiw	a5,s2,1
    50b0:	893e                	mv	s2,a5
    50b2:	873e                	mv	a4,a5
    50b4:	97d2                	add	a5,a5,s4
    50b6:	0007c483          	lbu	s1,0(a5)
    50ba:	22048763          	beqz	s1,52e8 <vprintf+0x286>
    c0 = fmt[i] & 0xff;
    50be:	0004879b          	sext.w	a5,s1
    if(state == 0){
    50c2:	fe0993e3          	bnez	s3,50a8 <vprintf+0x46>
      if(c0 == '%'){
    50c6:	fd579ce3          	bne	a5,s5,509e <vprintf+0x3c>
        state = '%';
    50ca:	89be                	mv	s3,a5
    50cc:	b7c5                	j	50ac <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
    50ce:	00ea06b3          	add	a3,s4,a4
    50d2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
    50d6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
    50d8:	c681                	beqz	a3,50e0 <vprintf+0x7e>
    50da:	9752                	add	a4,a4,s4
    50dc:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
    50e0:	05878263          	beq	a5,s8,5124 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
    50e4:	05978c63          	beq	a5,s9,513c <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
    50e8:	07500713          	li	a4,117
    50ec:	0ee78663          	beq	a5,a4,51d8 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
    50f0:	07800713          	li	a4,120
    50f4:	12e78863          	beq	a5,a4,5224 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
    50f8:	07000713          	li	a4,112
    50fc:	14e78d63          	beq	a5,a4,5256 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
    5100:	06300713          	li	a4,99
    5104:	18e78c63          	beq	a5,a4,529c <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
    5108:	07300713          	li	a4,115
    510c:	1ae78263          	beq	a5,a4,52b0 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
    5110:	02500713          	li	a4,37
    5114:	04e79463          	bne	a5,a4,515c <vprintf+0xfa>
        putc(fd, '%');
    5118:	85ba                	mv	a1,a4
    511a:	855a                	mv	a0,s6
    511c:	e91ff0ef          	jal	4fac <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
    5120:	4981                	li	s3,0
    5122:	b769                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
    5124:	008b8493          	addi	s1,s7,8
    5128:	4685                	li	a3,1
    512a:	4629                	li	a2,10
    512c:	000ba583          	lw	a1,0(s7)
    5130:	855a                	mv	a0,s6
    5132:	e99ff0ef          	jal	4fca <printint>
    5136:	8ba6                	mv	s7,s1
      state = 0;
    5138:	4981                	li	s3,0
    513a:	bf8d                	j	50ac <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
    513c:	06400793          	li	a5,100
    5140:	02f68963          	beq	a3,a5,5172 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    5144:	06c00793          	li	a5,108
    5148:	04f68263          	beq	a3,a5,518c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
    514c:	07500793          	li	a5,117
    5150:	0af68063          	beq	a3,a5,51f0 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
    5154:	07800793          	li	a5,120
    5158:	0ef68263          	beq	a3,a5,523c <vprintf+0x1da>
        putc(fd, '%');
    515c:	02500593          	li	a1,37
    5160:	855a                	mv	a0,s6
    5162:	e4bff0ef          	jal	4fac <putc>
        putc(fd, c0);
    5166:	85a6                	mv	a1,s1
    5168:	855a                	mv	a0,s6
    516a:	e43ff0ef          	jal	4fac <putc>
      state = 0;
    516e:	4981                	li	s3,0
    5170:	bf35                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    5172:	008b8493          	addi	s1,s7,8
    5176:	4685                	li	a3,1
    5178:	4629                	li	a2,10
    517a:	000bb583          	ld	a1,0(s7)
    517e:	855a                	mv	a0,s6
    5180:	e4bff0ef          	jal	4fca <printint>
        i += 1;
    5184:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
    5186:	8ba6                	mv	s7,s1
      state = 0;
    5188:	4981                	li	s3,0
        i += 1;
    518a:	b70d                	j	50ac <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    518c:	06400793          	li	a5,100
    5190:	02f60763          	beq	a2,a5,51be <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    5194:	07500793          	li	a5,117
    5198:	06f60963          	beq	a2,a5,520a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    519c:	07800793          	li	a5,120
    51a0:	faf61ee3          	bne	a2,a5,515c <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
    51a4:	008b8493          	addi	s1,s7,8
    51a8:	4681                	li	a3,0
    51aa:	4641                	li	a2,16
    51ac:	000bb583          	ld	a1,0(s7)
    51b0:	855a                	mv	a0,s6
    51b2:	e19ff0ef          	jal	4fca <printint>
        i += 2;
    51b6:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
    51b8:	8ba6                	mv	s7,s1
      state = 0;
    51ba:	4981                	li	s3,0
        i += 2;
    51bc:	bdc5                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
    51be:	008b8493          	addi	s1,s7,8
    51c2:	4685                	li	a3,1
    51c4:	4629                	li	a2,10
    51c6:	000bb583          	ld	a1,0(s7)
    51ca:	855a                	mv	a0,s6
    51cc:	dffff0ef          	jal	4fca <printint>
        i += 2;
    51d0:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
    51d2:	8ba6                	mv	s7,s1
      state = 0;
    51d4:	4981                	li	s3,0
        i += 2;
    51d6:	bdd9                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
    51d8:	008b8493          	addi	s1,s7,8
    51dc:	4681                	li	a3,0
    51de:	4629                	li	a2,10
    51e0:	000be583          	lwu	a1,0(s7)
    51e4:	855a                	mv	a0,s6
    51e6:	de5ff0ef          	jal	4fca <printint>
    51ea:	8ba6                	mv	s7,s1
      state = 0;
    51ec:	4981                	li	s3,0
    51ee:	bd7d                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    51f0:	008b8493          	addi	s1,s7,8
    51f4:	4681                	li	a3,0
    51f6:	4629                	li	a2,10
    51f8:	000bb583          	ld	a1,0(s7)
    51fc:	855a                	mv	a0,s6
    51fe:	dcdff0ef          	jal	4fca <printint>
        i += 1;
    5202:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
    5204:	8ba6                	mv	s7,s1
      state = 0;
    5206:	4981                	li	s3,0
        i += 1;
    5208:	b555                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
    520a:	008b8493          	addi	s1,s7,8
    520e:	4681                	li	a3,0
    5210:	4629                	li	a2,10
    5212:	000bb583          	ld	a1,0(s7)
    5216:	855a                	mv	a0,s6
    5218:	db3ff0ef          	jal	4fca <printint>
        i += 2;
    521c:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
    521e:	8ba6                	mv	s7,s1
      state = 0;
    5220:	4981                	li	s3,0
        i += 2;
    5222:	b569                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
    5224:	008b8493          	addi	s1,s7,8
    5228:	4681                	li	a3,0
    522a:	4641                	li	a2,16
    522c:	000be583          	lwu	a1,0(s7)
    5230:	855a                	mv	a0,s6
    5232:	d99ff0ef          	jal	4fca <printint>
    5236:	8ba6                	mv	s7,s1
      state = 0;
    5238:	4981                	li	s3,0
    523a:	bd8d                	j	50ac <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
    523c:	008b8493          	addi	s1,s7,8
    5240:	4681                	li	a3,0
    5242:	4641                	li	a2,16
    5244:	000bb583          	ld	a1,0(s7)
    5248:	855a                	mv	a0,s6
    524a:	d81ff0ef          	jal	4fca <printint>
        i += 1;
    524e:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
    5250:	8ba6                	mv	s7,s1
      state = 0;
    5252:	4981                	li	s3,0
        i += 1;
    5254:	bda1                	j	50ac <vprintf+0x4a>
    5256:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
    5258:	008b8d13          	addi	s10,s7,8
    525c:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
    5260:	03000593          	li	a1,48
    5264:	855a                	mv	a0,s6
    5266:	d47ff0ef          	jal	4fac <putc>
  putc(fd, 'x');
    526a:	07800593          	li	a1,120
    526e:	855a                	mv	a0,s6
    5270:	d3dff0ef          	jal	4fac <putc>
    5274:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5276:	00002b97          	auipc	s7,0x2
    527a:	79ab8b93          	addi	s7,s7,1946 # 7a10 <digits>
    527e:	03c9d793          	srli	a5,s3,0x3c
    5282:	97de                	add	a5,a5,s7
    5284:	0007c583          	lbu	a1,0(a5)
    5288:	855a                	mv	a0,s6
    528a:	d23ff0ef          	jal	4fac <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    528e:	0992                	slli	s3,s3,0x4
    5290:	34fd                	addiw	s1,s1,-1
    5292:	f4f5                	bnez	s1,527e <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
    5294:	8bea                	mv	s7,s10
      state = 0;
    5296:	4981                	li	s3,0
    5298:	6d02                	ld	s10,0(sp)
    529a:	bd09                	j	50ac <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
    529c:	008b8493          	addi	s1,s7,8
    52a0:	000bc583          	lbu	a1,0(s7)
    52a4:	855a                	mv	a0,s6
    52a6:	d07ff0ef          	jal	4fac <putc>
    52aa:	8ba6                	mv	s7,s1
      state = 0;
    52ac:	4981                	li	s3,0
    52ae:	bbfd                	j	50ac <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
    52b0:	008b8993          	addi	s3,s7,8
    52b4:	000bb483          	ld	s1,0(s7)
    52b8:	cc91                	beqz	s1,52d4 <vprintf+0x272>
        for(; *s; s++)
    52ba:	0004c583          	lbu	a1,0(s1)
    52be:	c195                	beqz	a1,52e2 <vprintf+0x280>
          putc(fd, *s);
    52c0:	855a                	mv	a0,s6
    52c2:	cebff0ef          	jal	4fac <putc>
        for(; *s; s++)
    52c6:	0485                	addi	s1,s1,1
    52c8:	0004c583          	lbu	a1,0(s1)
    52cc:	f9f5                	bnez	a1,52c0 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
    52ce:	8bce                	mv	s7,s3
      state = 0;
    52d0:	4981                	li	s3,0
    52d2:	bbe9                	j	50ac <vprintf+0x4a>
          s = "(null)";
    52d4:	00002497          	auipc	s1,0x2
    52d8:	68c48493          	addi	s1,s1,1676 # 7960 <malloc+0x257c>
        for(; *s; s++)
    52dc:	02800593          	li	a1,40
    52e0:	b7c5                	j	52c0 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
    52e2:	8bce                	mv	s7,s3
      state = 0;
    52e4:	4981                	li	s3,0
    52e6:	b3d9                	j	50ac <vprintf+0x4a>
    52e8:	6906                	ld	s2,64(sp)
    52ea:	79e2                	ld	s3,56(sp)
    52ec:	7a42                	ld	s4,48(sp)
    52ee:	7aa2                	ld	s5,40(sp)
    52f0:	7b02                	ld	s6,32(sp)
    52f2:	6be2                	ld	s7,24(sp)
    52f4:	6c42                	ld	s8,16(sp)
    52f6:	6ca2                	ld	s9,8(sp)
    }
  }
}
    52f8:	60e6                	ld	ra,88(sp)
    52fa:	6446                	ld	s0,80(sp)
    52fc:	64a6                	ld	s1,72(sp)
    52fe:	6125                	addi	sp,sp,96
    5300:	8082                	ret

0000000000005302 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5302:	715d                	addi	sp,sp,-80
    5304:	ec06                	sd	ra,24(sp)
    5306:	e822                	sd	s0,16(sp)
    5308:	1000                	addi	s0,sp,32
    530a:	e010                	sd	a2,0(s0)
    530c:	e414                	sd	a3,8(s0)
    530e:	e818                	sd	a4,16(s0)
    5310:	ec1c                	sd	a5,24(s0)
    5312:	03043023          	sd	a6,32(s0)
    5316:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    531a:	8622                	mv	a2,s0
    531c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5320:	d43ff0ef          	jal	5062 <vprintf>
}
    5324:	60e2                	ld	ra,24(sp)
    5326:	6442                	ld	s0,16(sp)
    5328:	6161                	addi	sp,sp,80
    532a:	8082                	ret

000000000000532c <printf>:

void
printf(const char *fmt, ...)
{
    532c:	711d                	addi	sp,sp,-96
    532e:	ec06                	sd	ra,24(sp)
    5330:	e822                	sd	s0,16(sp)
    5332:	1000                	addi	s0,sp,32
    5334:	e40c                	sd	a1,8(s0)
    5336:	e810                	sd	a2,16(s0)
    5338:	ec14                	sd	a3,24(s0)
    533a:	f018                	sd	a4,32(s0)
    533c:	f41c                	sd	a5,40(s0)
    533e:	03043823          	sd	a6,48(s0)
    5342:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5346:	00840613          	addi	a2,s0,8
    534a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    534e:	85aa                	mv	a1,a0
    5350:	4505                	li	a0,1
    5352:	d11ff0ef          	jal	5062 <vprintf>
}
    5356:	60e2                	ld	ra,24(sp)
    5358:	6442                	ld	s0,16(sp)
    535a:	6125                	addi	sp,sp,96
    535c:	8082                	ret

000000000000535e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    535e:	1141                	addi	sp,sp,-16
    5360:	e406                	sd	ra,8(sp)
    5362:	e022                	sd	s0,0(sp)
    5364:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5366:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    536a:	00005797          	auipc	a5,0x5
    536e:	1167b783          	ld	a5,278(a5) # a480 <freep>
    5372:	a02d                	j	539c <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5374:	4618                	lw	a4,8(a2)
    5376:	9f2d                	addw	a4,a4,a1
    5378:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    537c:	6398                	ld	a4,0(a5)
    537e:	6310                	ld	a2,0(a4)
    5380:	a83d                	j	53be <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5382:	ff852703          	lw	a4,-8(a0)
    5386:	9f31                	addw	a4,a4,a2
    5388:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    538a:	ff053683          	ld	a3,-16(a0)
    538e:	a091                	j	53d2 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5390:	6398                	ld	a4,0(a5)
    5392:	00e7e463          	bltu	a5,a4,539a <free+0x3c>
    5396:	00e6ea63          	bltu	a3,a4,53aa <free+0x4c>
{
    539a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    539c:	fed7fae3          	bgeu	a5,a3,5390 <free+0x32>
    53a0:	6398                	ld	a4,0(a5)
    53a2:	00e6e463          	bltu	a3,a4,53aa <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    53a6:	fee7eae3          	bltu	a5,a4,539a <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
    53aa:	ff852583          	lw	a1,-8(a0)
    53ae:	6390                	ld	a2,0(a5)
    53b0:	02059813          	slli	a6,a1,0x20
    53b4:	01c85713          	srli	a4,a6,0x1c
    53b8:	9736                	add	a4,a4,a3
    53ba:	fae60de3          	beq	a2,a4,5374 <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
    53be:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    53c2:	4790                	lw	a2,8(a5)
    53c4:	02061593          	slli	a1,a2,0x20
    53c8:	01c5d713          	srli	a4,a1,0x1c
    53cc:	973e                	add	a4,a4,a5
    53ce:	fae68ae3          	beq	a3,a4,5382 <free+0x24>
    p->s.ptr = bp->s.ptr;
    53d2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    53d4:	00005717          	auipc	a4,0x5
    53d8:	0af73623          	sd	a5,172(a4) # a480 <freep>
}
    53dc:	60a2                	ld	ra,8(sp)
    53de:	6402                	ld	s0,0(sp)
    53e0:	0141                	addi	sp,sp,16
    53e2:	8082                	ret

00000000000053e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    53e4:	7139                	addi	sp,sp,-64
    53e6:	fc06                	sd	ra,56(sp)
    53e8:	f822                	sd	s0,48(sp)
    53ea:	f04a                	sd	s2,32(sp)
    53ec:	ec4e                	sd	s3,24(sp)
    53ee:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    53f0:	02051993          	slli	s3,a0,0x20
    53f4:	0209d993          	srli	s3,s3,0x20
    53f8:	09bd                	addi	s3,s3,15
    53fa:	0049d993          	srli	s3,s3,0x4
    53fe:	2985                	addiw	s3,s3,1
    5400:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    5402:	00005517          	auipc	a0,0x5
    5406:	07e53503          	ld	a0,126(a0) # a480 <freep>
    540a:	c905                	beqz	a0,543a <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    540c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    540e:	4798                	lw	a4,8(a5)
    5410:	09377663          	bgeu	a4,s3,549c <malloc+0xb8>
    5414:	f426                	sd	s1,40(sp)
    5416:	e852                	sd	s4,16(sp)
    5418:	e456                	sd	s5,8(sp)
    541a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    541c:	8a4e                	mv	s4,s3
    541e:	6705                	lui	a4,0x1
    5420:	00e9f363          	bgeu	s3,a4,5426 <malloc+0x42>
    5424:	6a05                	lui	s4,0x1
    5426:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    542a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    542e:	00005497          	auipc	s1,0x5
    5432:	05248493          	addi	s1,s1,82 # a480 <freep>
  if(p == SBRK_ERROR)
    5436:	5afd                	li	s5,-1
    5438:	a83d                	j	5476 <malloc+0x92>
    543a:	f426                	sd	s1,40(sp)
    543c:	e852                	sd	s4,16(sp)
    543e:	e456                	sd	s5,8(sp)
    5440:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    5442:	0000c797          	auipc	a5,0xc
    5446:	86678793          	addi	a5,a5,-1946 # 10ca8 <base>
    544a:	00005717          	auipc	a4,0x5
    544e:	02f73b23          	sd	a5,54(a4) # a480 <freep>
    5452:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5454:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5458:	b7d1                	j	541c <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    545a:	6398                	ld	a4,0(a5)
    545c:	e118                	sd	a4,0(a0)
    545e:	a899                	j	54b4 <malloc+0xd0>
  hp->s.size = nu;
    5460:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5464:	0541                	addi	a0,a0,16
    5466:	ef9ff0ef          	jal	535e <free>
  return freep;
    546a:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    546c:	c125                	beqz	a0,54cc <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    546e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5470:	4798                	lw	a4,8(a5)
    5472:	03277163          	bgeu	a4,s2,5494 <malloc+0xb0>
    if(p == freep)
    5476:	6098                	ld	a4,0(s1)
    5478:	853e                	mv	a0,a5
    547a:	fef71ae3          	bne	a4,a5,546e <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    547e:	8552                	mv	a0,s4
    5480:	a59ff0ef          	jal	4ed8 <sbrk>
  if(p == SBRK_ERROR)
    5484:	fd551ee3          	bne	a0,s5,5460 <malloc+0x7c>
        return 0;
    5488:	4501                	li	a0,0
    548a:	74a2                	ld	s1,40(sp)
    548c:	6a42                	ld	s4,16(sp)
    548e:	6aa2                	ld	s5,8(sp)
    5490:	6b02                	ld	s6,0(sp)
    5492:	a03d                	j	54c0 <malloc+0xdc>
    5494:	74a2                	ld	s1,40(sp)
    5496:	6a42                	ld	s4,16(sp)
    5498:	6aa2                	ld	s5,8(sp)
    549a:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    549c:	fae90fe3          	beq	s2,a4,545a <malloc+0x76>
        p->s.size -= nunits;
    54a0:	4137073b          	subw	a4,a4,s3
    54a4:	c798                	sw	a4,8(a5)
        p += p->s.size;
    54a6:	02071693          	slli	a3,a4,0x20
    54aa:	01c6d713          	srli	a4,a3,0x1c
    54ae:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    54b0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    54b4:	00005717          	auipc	a4,0x5
    54b8:	fca73623          	sd	a0,-52(a4) # a480 <freep>
      return (void*)(p + 1);
    54bc:	01078513          	addi	a0,a5,16
  }
}
    54c0:	70e2                	ld	ra,56(sp)
    54c2:	7442                	ld	s0,48(sp)
    54c4:	7902                	ld	s2,32(sp)
    54c6:	69e2                	ld	s3,24(sp)
    54c8:	6121                	addi	sp,sp,64
    54ca:	8082                	ret
    54cc:	74a2                	ld	s1,40(sp)
    54ce:	6a42                	ld	s4,16(sp)
    54d0:	6aa2                	ld	s5,8(sp)
    54d2:	6b02                	ld	s6,0(sp)
    54d4:	b7f5                	j	54c0 <malloc+0xdc>
