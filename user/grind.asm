
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       8:	611c                	ld	a5,0(a0)
       a:	0017d693          	srli	a3,a5,0x1
       e:	c0000737          	lui	a4,0xc0000
      12:	0705                	addi	a4,a4,1 # ffffffffc0000001 <base+0xffffffffbfffdbf9>
      14:	1706                	slli	a4,a4,0x21
      16:	0725                	addi	a4,a4,9
      18:	02e6b733          	mulhu	a4,a3,a4
      1c:	8375                	srli	a4,a4,0x1d
      1e:	01e71693          	slli	a3,a4,0x1e
      22:	40e68733          	sub	a4,a3,a4
      26:	0706                	slli	a4,a4,0x1
      28:	8f99                	sub	a5,a5,a4
      2a:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      2c:	1fe406b7          	lui	a3,0x1fe40
      30:	b7968693          	addi	a3,a3,-1159 # 1fe3fb79 <base+0x1fe3d771>
      34:	41a70737          	lui	a4,0x41a70
      38:	5af70713          	addi	a4,a4,1455 # 41a705af <base+0x41a6e1a7>
      3c:	1702                	slli	a4,a4,0x20
      3e:	9736                	add	a4,a4,a3
      40:	02e79733          	mulh	a4,a5,a4
      44:	873d                	srai	a4,a4,0xf
      46:	43f7d693          	srai	a3,a5,0x3f
      4a:	8f15                	sub	a4,a4,a3
      4c:	66fd                	lui	a3,0x1f
      4e:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x1cf15>
      52:	02d706b3          	mul	a3,a4,a3
      56:	8f95                	sub	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      58:	6691                	lui	a3,0x4
      5a:	1a768693          	addi	a3,a3,423 # 41a7 <base+0x1d9f>
      5e:	02d787b3          	mul	a5,a5,a3
      62:	76fd                	lui	a3,0xfffff
      64:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffd0e4>
      68:	02d70733          	mul	a4,a4,a3
      6c:	97ba                	add	a5,a5,a4
    if (x < 0)
      6e:	0007ca63          	bltz	a5,82 <do_rand+0x82>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      72:	17fd                	addi	a5,a5,-1
    *ctx = x;
      74:	e11c                	sd	a5,0(a0)
    return (x);
}
      76:	0007851b          	sext.w	a0,a5
      7a:	60a2                	ld	ra,8(sp)
      7c:	6402                	ld	s0,0(sp)
      7e:	0141                	addi	sp,sp,16
      80:	8082                	ret
        x += 0x7fffffff;
      82:	80000737          	lui	a4,0x80000
      86:	fff74713          	not	a4,a4
      8a:	97ba                	add	a5,a5,a4
      8c:	b7dd                	j	72 <do_rand+0x72>

000000000000008e <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      8e:	1141                	addi	sp,sp,-16
      90:	e406                	sd	ra,8(sp)
      92:	e022                	sd	s0,0(sp)
      94:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      96:	00002517          	auipc	a0,0x2
      9a:	f6a50513          	addi	a0,a0,-150 # 2000 <rand_next>
      9e:	f63ff0ef          	jal	0 <do_rand>
}
      a2:	60a2                	ld	ra,8(sp)
      a4:	6402                	ld	s0,0(sp)
      a6:	0141                	addi	sp,sp,16
      a8:	8082                	ret

00000000000000aa <go>:

void
go(int which_child)
{
      aa:	7171                	addi	sp,sp,-176
      ac:	f506                	sd	ra,168(sp)
      ae:	f122                	sd	s0,160(sp)
      b0:	ed26                	sd	s1,152(sp)
      b2:	1900                	addi	s0,sp,176
      b4:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      b6:	4501                	li	a0,0
      b8:	357000ef          	jal	c0e <sbrk>
      bc:	f4a43c23          	sd	a0,-168(s0)
  uint64 iters = 0;

  mkdir("grindir");
      c0:	00001517          	auipc	a0,0x1
      c4:	15050513          	addi	a0,a0,336 # 1210 <malloc+0xf6>
      c8:	3e3000ef          	jal	caa <mkdir>
  if(chdir("grindir") != 0){
      cc:	00001517          	auipc	a0,0x1
      d0:	14450513          	addi	a0,a0,324 # 1210 <malloc+0xf6>
      d4:	3df000ef          	jal	cb2 <chdir>
      d8:	c505                	beqz	a0,100 <go+0x56>
      da:	e94a                	sd	s2,144(sp)
      dc:	e54e                	sd	s3,136(sp)
      de:	e152                	sd	s4,128(sp)
      e0:	fcd6                	sd	s5,120(sp)
      e2:	f8da                	sd	s6,112(sp)
      e4:	f4de                	sd	s7,104(sp)
      e6:	f0e2                	sd	s8,96(sp)
      e8:	ece6                	sd	s9,88(sp)
      ea:	e8ea                	sd	s10,80(sp)
      ec:	e4ee                	sd	s11,72(sp)
    printf("grind: chdir grindir failed\n");
      ee:	00001517          	auipc	a0,0x1
      f2:	12a50513          	addi	a0,a0,298 # 1218 <malloc+0xfe>
      f6:	76d000ef          	jal	1062 <printf>
    exit(1);
      fa:	4505                	li	a0,1
      fc:	347000ef          	jal	c42 <exit>
     100:	e94a                	sd	s2,144(sp)
     102:	e54e                	sd	s3,136(sp)
     104:	e152                	sd	s4,128(sp)
     106:	fcd6                	sd	s5,120(sp)
     108:	f8da                	sd	s6,112(sp)
     10a:	f4de                	sd	s7,104(sp)
     10c:	f0e2                	sd	s8,96(sp)
     10e:	ece6                	sd	s9,88(sp)
     110:	e8ea                	sd	s10,80(sp)
     112:	e4ee                	sd	s11,72(sp)
  }
  chdir("/");
     114:	00001517          	auipc	a0,0x1
     118:	12c50513          	addi	a0,a0,300 # 1240 <malloc+0x126>
     11c:	397000ef          	jal	cb2 <chdir>
     120:	00001c17          	auipc	s8,0x1
     124:	130c0c13          	addi	s8,s8,304 # 1250 <malloc+0x136>
     128:	c489                	beqz	s1,132 <go+0x88>
     12a:	00001c17          	auipc	s8,0x1
     12e:	11ec0c13          	addi	s8,s8,286 # 1248 <malloc+0x12e>
  uint64 iters = 0;
     132:	4481                	li	s1,0
  int fd = -1;
     134:	5cfd                	li	s9,-1
  
  while(1){
    iters++;
    if((iters % 500) == 0)
     136:	e353f7b7          	lui	a5,0xe353f
     13a:	7cf78793          	addi	a5,a5,1999 # ffffffffe353f7cf <base+0xffffffffe353d3c7>
     13e:	20c4a9b7          	lui	s3,0x20c4a
     142:	ba698993          	addi	s3,s3,-1114 # 20c49ba6 <base+0x20c4779e>
     146:	1982                	slli	s3,s3,0x20
     148:	99be                	add	s3,s3,a5
     14a:	1f400b13          	li	s6,500
      write(1, which_child?"B":"A", 1);
     14e:	4b85                	li	s7,1
    int what = rand() % 23;
     150:	b2164a37          	lui	s4,0xb2164
     154:	2c9a0a13          	addi	s4,s4,713 # ffffffffb21642c9 <base+0xffffffffb2161ec1>
     158:	4ad9                	li	s5,22
     15a:	00001917          	auipc	s2,0x1
     15e:	3c690913          	addi	s2,s2,966 # 1520 <malloc+0x406>
      close(fd1);
      unlink("c");
    } else if(what == 22){
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     162:	f6840d93          	addi	s11,s0,-152
     166:	a819                	j	17c <go+0xd2>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     168:	20200593          	li	a1,514
     16c:	00001517          	auipc	a0,0x1
     170:	0ec50513          	addi	a0,a0,236 # 1258 <malloc+0x13e>
     174:	30f000ef          	jal	c82 <open>
     178:	2f3000ef          	jal	c6a <close>
    iters++;
     17c:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     17e:	0024d793          	srli	a5,s1,0x2
     182:	0337b7b3          	mulhu	a5,a5,s3
     186:	8391                	srli	a5,a5,0x4
     188:	036787b3          	mul	a5,a5,s6
     18c:	00f49763          	bne	s1,a5,19a <go+0xf0>
      write(1, which_child?"B":"A", 1);
     190:	865e                	mv	a2,s7
     192:	85e2                	mv	a1,s8
     194:	855e                	mv	a0,s7
     196:	2cd000ef          	jal	c62 <write>
    int what = rand() % 23;
     19a:	ef5ff0ef          	jal	8e <rand>
     19e:	034507b3          	mul	a5,a0,s4
     1a2:	9381                	srli	a5,a5,0x20
     1a4:	9fa9                	addw	a5,a5,a0
     1a6:	4047d79b          	sraiw	a5,a5,0x4
     1aa:	41f5571b          	sraiw	a4,a0,0x1f
     1ae:	9f99                	subw	a5,a5,a4
     1b0:	0017971b          	slliw	a4,a5,0x1
     1b4:	9f3d                	addw	a4,a4,a5
     1b6:	0037171b          	slliw	a4,a4,0x3
     1ba:	40f707bb          	subw	a5,a4,a5
     1be:	9d1d                	subw	a0,a0,a5
     1c0:	faaaeee3          	bltu	s5,a0,17c <go+0xd2>
     1c4:	02051793          	slli	a5,a0,0x20
     1c8:	01e7d513          	srli	a0,a5,0x1e
     1cc:	954a                	add	a0,a0,s2
     1ce:	411c                	lw	a5,0(a0)
     1d0:	97ca                	add	a5,a5,s2
     1d2:	8782                	jr	a5
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     1d4:	20200593          	li	a1,514
     1d8:	00001517          	auipc	a0,0x1
     1dc:	09050513          	addi	a0,a0,144 # 1268 <malloc+0x14e>
     1e0:	2a3000ef          	jal	c82 <open>
     1e4:	287000ef          	jal	c6a <close>
     1e8:	bf51                	j	17c <go+0xd2>
      unlink("grindir/../a");
     1ea:	00001517          	auipc	a0,0x1
     1ee:	06e50513          	addi	a0,a0,110 # 1258 <malloc+0x13e>
     1f2:	2a1000ef          	jal	c92 <unlink>
     1f6:	b759                	j	17c <go+0xd2>
      if(chdir("grindir") != 0){
     1f8:	00001517          	auipc	a0,0x1
     1fc:	01850513          	addi	a0,a0,24 # 1210 <malloc+0xf6>
     200:	2b3000ef          	jal	cb2 <chdir>
     204:	ed11                	bnez	a0,220 <go+0x176>
      unlink("../b");
     206:	00001517          	auipc	a0,0x1
     20a:	07a50513          	addi	a0,a0,122 # 1280 <malloc+0x166>
     20e:	285000ef          	jal	c92 <unlink>
      chdir("/");
     212:	00001517          	auipc	a0,0x1
     216:	02e50513          	addi	a0,a0,46 # 1240 <malloc+0x126>
     21a:	299000ef          	jal	cb2 <chdir>
     21e:	bfb9                	j	17c <go+0xd2>
        printf("grind: chdir grindir failed\n");
     220:	00001517          	auipc	a0,0x1
     224:	ff850513          	addi	a0,a0,-8 # 1218 <malloc+0xfe>
     228:	63b000ef          	jal	1062 <printf>
        exit(1);
     22c:	4505                	li	a0,1
     22e:	215000ef          	jal	c42 <exit>
      close(fd);
     232:	8566                	mv	a0,s9
     234:	237000ef          	jal	c6a <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     238:	20200593          	li	a1,514
     23c:	00001517          	auipc	a0,0x1
     240:	04c50513          	addi	a0,a0,76 # 1288 <malloc+0x16e>
     244:	23f000ef          	jal	c82 <open>
     248:	8caa                	mv	s9,a0
     24a:	bf0d                	j	17c <go+0xd2>
      close(fd);
     24c:	8566                	mv	a0,s9
     24e:	21d000ef          	jal	c6a <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     252:	20200593          	li	a1,514
     256:	00001517          	auipc	a0,0x1
     25a:	04250513          	addi	a0,a0,66 # 1298 <malloc+0x17e>
     25e:	225000ef          	jal	c82 <open>
     262:	8caa                	mv	s9,a0
     264:	bf21                	j	17c <go+0xd2>
      write(fd, buf, sizeof(buf));
     266:	3e700613          	li	a2,999
     26a:	00002597          	auipc	a1,0x2
     26e:	db658593          	addi	a1,a1,-586 # 2020 <buf.0>
     272:	8566                	mv	a0,s9
     274:	1ef000ef          	jal	c62 <write>
     278:	b711                	j	17c <go+0xd2>
      read(fd, buf, sizeof(buf));
     27a:	3e700613          	li	a2,999
     27e:	00002597          	auipc	a1,0x2
     282:	da258593          	addi	a1,a1,-606 # 2020 <buf.0>
     286:	8566                	mv	a0,s9
     288:	1d3000ef          	jal	c5a <read>
     28c:	bdc5                	j	17c <go+0xd2>
      mkdir("grindir/../a");
     28e:	00001517          	auipc	a0,0x1
     292:	fca50513          	addi	a0,a0,-54 # 1258 <malloc+0x13e>
     296:	215000ef          	jal	caa <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     29a:	20200593          	li	a1,514
     29e:	00001517          	auipc	a0,0x1
     2a2:	01250513          	addi	a0,a0,18 # 12b0 <malloc+0x196>
     2a6:	1dd000ef          	jal	c82 <open>
     2aa:	1c1000ef          	jal	c6a <close>
      unlink("a/a");
     2ae:	00001517          	auipc	a0,0x1
     2b2:	01250513          	addi	a0,a0,18 # 12c0 <malloc+0x1a6>
     2b6:	1dd000ef          	jal	c92 <unlink>
     2ba:	b5c9                	j	17c <go+0xd2>
      mkdir("/../b");
     2bc:	00001517          	auipc	a0,0x1
     2c0:	00c50513          	addi	a0,a0,12 # 12c8 <malloc+0x1ae>
     2c4:	1e7000ef          	jal	caa <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     2c8:	20200593          	li	a1,514
     2cc:	00001517          	auipc	a0,0x1
     2d0:	00450513          	addi	a0,a0,4 # 12d0 <malloc+0x1b6>
     2d4:	1af000ef          	jal	c82 <open>
     2d8:	193000ef          	jal	c6a <close>
      unlink("b/b");
     2dc:	00001517          	auipc	a0,0x1
     2e0:	00450513          	addi	a0,a0,4 # 12e0 <malloc+0x1c6>
     2e4:	1af000ef          	jal	c92 <unlink>
     2e8:	bd51                	j	17c <go+0xd2>
      unlink("b");
     2ea:	00001517          	auipc	a0,0x1
     2ee:	ffe50513          	addi	a0,a0,-2 # 12e8 <malloc+0x1ce>
     2f2:	1a1000ef          	jal	c92 <unlink>
      link("../grindir/./../a", "../b");
     2f6:	00001597          	auipc	a1,0x1
     2fa:	f8a58593          	addi	a1,a1,-118 # 1280 <malloc+0x166>
     2fe:	00001517          	auipc	a0,0x1
     302:	ff250513          	addi	a0,a0,-14 # 12f0 <malloc+0x1d6>
     306:	19d000ef          	jal	ca2 <link>
     30a:	bd8d                	j	17c <go+0xd2>
      unlink("../grindir/../a");
     30c:	00001517          	auipc	a0,0x1
     310:	ffc50513          	addi	a0,a0,-4 # 1308 <malloc+0x1ee>
     314:	17f000ef          	jal	c92 <unlink>
      link(".././b", "/grindir/../a");
     318:	00001597          	auipc	a1,0x1
     31c:	f7058593          	addi	a1,a1,-144 # 1288 <malloc+0x16e>
     320:	00001517          	auipc	a0,0x1
     324:	ff850513          	addi	a0,a0,-8 # 1318 <malloc+0x1fe>
     328:	17b000ef          	jal	ca2 <link>
     32c:	bd81                	j	17c <go+0xd2>
      int pid = fork();
     32e:	10d000ef          	jal	c3a <fork>
      if(pid == 0){
     332:	c519                	beqz	a0,340 <go+0x296>
      } else if(pid < 0){
     334:	00054863          	bltz	a0,344 <go+0x29a>
      wait(0);
     338:	4501                	li	a0,0
     33a:	111000ef          	jal	c4a <wait>
     33e:	bd3d                	j	17c <go+0xd2>
        exit(0);
     340:	103000ef          	jal	c42 <exit>
        printf("grind: fork failed\n");
     344:	00001517          	auipc	a0,0x1
     348:	fdc50513          	addi	a0,a0,-36 # 1320 <malloc+0x206>
     34c:	517000ef          	jal	1062 <printf>
        exit(1);
     350:	4505                	li	a0,1
     352:	0f1000ef          	jal	c42 <exit>
      int pid = fork();
     356:	0e5000ef          	jal	c3a <fork>
      if(pid == 0){
     35a:	c519                	beqz	a0,368 <go+0x2be>
      } else if(pid < 0){
     35c:	00054d63          	bltz	a0,376 <go+0x2cc>
      wait(0);
     360:	4501                	li	a0,0
     362:	0e9000ef          	jal	c4a <wait>
     366:	bd19                	j	17c <go+0xd2>
        fork();
     368:	0d3000ef          	jal	c3a <fork>
        fork();
     36c:	0cf000ef          	jal	c3a <fork>
        exit(0);
     370:	4501                	li	a0,0
     372:	0d1000ef          	jal	c42 <exit>
        printf("grind: fork failed\n");
     376:	00001517          	auipc	a0,0x1
     37a:	faa50513          	addi	a0,a0,-86 # 1320 <malloc+0x206>
     37e:	4e5000ef          	jal	1062 <printf>
        exit(1);
     382:	4505                	li	a0,1
     384:	0bf000ef          	jal	c42 <exit>
      sbrk(6011);
     388:	6505                	lui	a0,0x1
     38a:	77b50513          	addi	a0,a0,1915 # 177b <digits+0x1fb>
     38e:	081000ef          	jal	c0e <sbrk>
     392:	b3ed                	j	17c <go+0xd2>
      if(sbrk(0) > break0)
     394:	4501                	li	a0,0
     396:	079000ef          	jal	c0e <sbrk>
     39a:	f5843783          	ld	a5,-168(s0)
     39e:	dca7ffe3          	bgeu	a5,a0,17c <go+0xd2>
        sbrk(-(sbrk(0) - break0));
     3a2:	4501                	li	a0,0
     3a4:	06b000ef          	jal	c0e <sbrk>
     3a8:	f5843783          	ld	a5,-168(s0)
     3ac:	40a7853b          	subw	a0,a5,a0
     3b0:	05f000ef          	jal	c0e <sbrk>
     3b4:	b3e1                	j	17c <go+0xd2>
      int pid = fork();
     3b6:	085000ef          	jal	c3a <fork>
     3ba:	8d2a                	mv	s10,a0
      if(pid == 0){
     3bc:	c10d                	beqz	a0,3de <go+0x334>
      } else if(pid < 0){
     3be:	02054d63          	bltz	a0,3f8 <go+0x34e>
      if(chdir("../grindir/..") != 0){
     3c2:	00001517          	auipc	a0,0x1
     3c6:	f7e50513          	addi	a0,a0,-130 # 1340 <malloc+0x226>
     3ca:	0e9000ef          	jal	cb2 <chdir>
     3ce:	ed15                	bnez	a0,40a <go+0x360>
      kill(pid);
     3d0:	856a                	mv	a0,s10
     3d2:	0a1000ef          	jal	c72 <kill>
      wait(0);
     3d6:	4501                	li	a0,0
     3d8:	073000ef          	jal	c4a <wait>
     3dc:	b345                	j	17c <go+0xd2>
        close(open("a", O_CREATE|O_RDWR));
     3de:	20200593          	li	a1,514
     3e2:	00001517          	auipc	a0,0x1
     3e6:	f5650513          	addi	a0,a0,-170 # 1338 <malloc+0x21e>
     3ea:	099000ef          	jal	c82 <open>
     3ee:	07d000ef          	jal	c6a <close>
        exit(0);
     3f2:	4501                	li	a0,0
     3f4:	04f000ef          	jal	c42 <exit>
        printf("grind: fork failed\n");
     3f8:	00001517          	auipc	a0,0x1
     3fc:	f2850513          	addi	a0,a0,-216 # 1320 <malloc+0x206>
     400:	463000ef          	jal	1062 <printf>
        exit(1);
     404:	4505                	li	a0,1
     406:	03d000ef          	jal	c42 <exit>
        printf("grind: chdir failed\n");
     40a:	00001517          	auipc	a0,0x1
     40e:	f4650513          	addi	a0,a0,-186 # 1350 <malloc+0x236>
     412:	451000ef          	jal	1062 <printf>
        exit(1);
     416:	4505                	li	a0,1
     418:	02b000ef          	jal	c42 <exit>
      int pid = fork();
     41c:	01f000ef          	jal	c3a <fork>
      if(pid == 0){
     420:	c519                	beqz	a0,42e <go+0x384>
      } else if(pid < 0){
     422:	00054d63          	bltz	a0,43c <go+0x392>
      wait(0);
     426:	4501                	li	a0,0
     428:	023000ef          	jal	c4a <wait>
     42c:	bb81                	j	17c <go+0xd2>
        kill(getpid());
     42e:	095000ef          	jal	cc2 <getpid>
     432:	041000ef          	jal	c72 <kill>
        exit(0);
     436:	4501                	li	a0,0
     438:	00b000ef          	jal	c42 <exit>
        printf("grind: fork failed\n");
     43c:	00001517          	auipc	a0,0x1
     440:	ee450513          	addi	a0,a0,-284 # 1320 <malloc+0x206>
     444:	41f000ef          	jal	1062 <printf>
        exit(1);
     448:	4505                	li	a0,1
     44a:	7f8000ef          	jal	c42 <exit>
      if(pipe(fds) < 0){
     44e:	f7840513          	addi	a0,s0,-136
     452:	001000ef          	jal	c52 <pipe>
     456:	02054363          	bltz	a0,47c <go+0x3d2>
      int pid = fork();
     45a:	7e0000ef          	jal	c3a <fork>
      if(pid == 0){
     45e:	c905                	beqz	a0,48e <go+0x3e4>
      } else if(pid < 0){
     460:	08054263          	bltz	a0,4e4 <go+0x43a>
      close(fds[0]);
     464:	f7842503          	lw	a0,-136(s0)
     468:	003000ef          	jal	c6a <close>
      close(fds[1]);
     46c:	f7c42503          	lw	a0,-132(s0)
     470:	7fa000ef          	jal	c6a <close>
      wait(0);
     474:	4501                	li	a0,0
     476:	7d4000ef          	jal	c4a <wait>
     47a:	b309                	j	17c <go+0xd2>
        printf("grind: pipe failed\n");
     47c:	00001517          	auipc	a0,0x1
     480:	eec50513          	addi	a0,a0,-276 # 1368 <malloc+0x24e>
     484:	3df000ef          	jal	1062 <printf>
        exit(1);
     488:	4505                	li	a0,1
     48a:	7b8000ef          	jal	c42 <exit>
        fork();
     48e:	7ac000ef          	jal	c3a <fork>
        fork();
     492:	7a8000ef          	jal	c3a <fork>
        if(write(fds[1], "x", 1) != 1)
     496:	4605                	li	a2,1
     498:	00001597          	auipc	a1,0x1
     49c:	ee858593          	addi	a1,a1,-280 # 1380 <malloc+0x266>
     4a0:	f7c42503          	lw	a0,-132(s0)
     4a4:	7be000ef          	jal	c62 <write>
     4a8:	4785                	li	a5,1
     4aa:	00f51f63          	bne	a0,a5,4c8 <go+0x41e>
        if(read(fds[0], &c, 1) != 1)
     4ae:	4605                	li	a2,1
     4b0:	f7040593          	addi	a1,s0,-144
     4b4:	f7842503          	lw	a0,-136(s0)
     4b8:	7a2000ef          	jal	c5a <read>
     4bc:	4785                	li	a5,1
     4be:	00f51c63          	bne	a0,a5,4d6 <go+0x42c>
        exit(0);
     4c2:	4501                	li	a0,0
     4c4:	77e000ef          	jal	c42 <exit>
          printf("grind: pipe write failed\n");
     4c8:	00001517          	auipc	a0,0x1
     4cc:	ec050513          	addi	a0,a0,-320 # 1388 <malloc+0x26e>
     4d0:	393000ef          	jal	1062 <printf>
     4d4:	bfe9                	j	4ae <go+0x404>
          printf("grind: pipe read failed\n");
     4d6:	00001517          	auipc	a0,0x1
     4da:	ed250513          	addi	a0,a0,-302 # 13a8 <malloc+0x28e>
     4de:	385000ef          	jal	1062 <printf>
     4e2:	b7c5                	j	4c2 <go+0x418>
        printf("grind: fork failed\n");
     4e4:	00001517          	auipc	a0,0x1
     4e8:	e3c50513          	addi	a0,a0,-452 # 1320 <malloc+0x206>
     4ec:	377000ef          	jal	1062 <printf>
        exit(1);
     4f0:	4505                	li	a0,1
     4f2:	750000ef          	jal	c42 <exit>
      int pid = fork();
     4f6:	744000ef          	jal	c3a <fork>
      if(pid == 0){
     4fa:	c519                	beqz	a0,508 <go+0x45e>
      } else if(pid < 0){
     4fc:	04054f63          	bltz	a0,55a <go+0x4b0>
      wait(0);
     500:	4501                	li	a0,0
     502:	748000ef          	jal	c4a <wait>
     506:	b99d                	j	17c <go+0xd2>
        unlink("a");
     508:	00001517          	auipc	a0,0x1
     50c:	e3050513          	addi	a0,a0,-464 # 1338 <malloc+0x21e>
     510:	782000ef          	jal	c92 <unlink>
        mkdir("a");
     514:	00001517          	auipc	a0,0x1
     518:	e2450513          	addi	a0,a0,-476 # 1338 <malloc+0x21e>
     51c:	78e000ef          	jal	caa <mkdir>
        chdir("a");
     520:	00001517          	auipc	a0,0x1
     524:	e1850513          	addi	a0,a0,-488 # 1338 <malloc+0x21e>
     528:	78a000ef          	jal	cb2 <chdir>
        unlink("../a");
     52c:	00001517          	auipc	a0,0x1
     530:	e9c50513          	addi	a0,a0,-356 # 13c8 <malloc+0x2ae>
     534:	75e000ef          	jal	c92 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     538:	20200593          	li	a1,514
     53c:	00001517          	auipc	a0,0x1
     540:	e4450513          	addi	a0,a0,-444 # 1380 <malloc+0x266>
     544:	73e000ef          	jal	c82 <open>
        unlink("x");
     548:	00001517          	auipc	a0,0x1
     54c:	e3850513          	addi	a0,a0,-456 # 1380 <malloc+0x266>
     550:	742000ef          	jal	c92 <unlink>
        exit(0);
     554:	4501                	li	a0,0
     556:	6ec000ef          	jal	c42 <exit>
        printf("grind: fork failed\n");
     55a:	00001517          	auipc	a0,0x1
     55e:	dc650513          	addi	a0,a0,-570 # 1320 <malloc+0x206>
     562:	301000ef          	jal	1062 <printf>
        exit(1);
     566:	4505                	li	a0,1
     568:	6da000ef          	jal	c42 <exit>
      unlink("c");
     56c:	00001517          	auipc	a0,0x1
     570:	e6450513          	addi	a0,a0,-412 # 13d0 <malloc+0x2b6>
     574:	71e000ef          	jal	c92 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     578:	20200593          	li	a1,514
     57c:	00001517          	auipc	a0,0x1
     580:	e5450513          	addi	a0,a0,-428 # 13d0 <malloc+0x2b6>
     584:	6fe000ef          	jal	c82 <open>
     588:	8d2a                	mv	s10,a0
      if(fd1 < 0){
     58a:	04054563          	bltz	a0,5d4 <go+0x52a>
      if(write(fd1, "x", 1) != 1){
     58e:	865e                	mv	a2,s7
     590:	00001597          	auipc	a1,0x1
     594:	df058593          	addi	a1,a1,-528 # 1380 <malloc+0x266>
     598:	6ca000ef          	jal	c62 <write>
     59c:	05751563          	bne	a0,s7,5e6 <go+0x53c>
      if(fstat(fd1, &st) != 0){
     5a0:	f7840593          	addi	a1,s0,-136
     5a4:	856a                	mv	a0,s10
     5a6:	6f4000ef          	jal	c9a <fstat>
     5aa:	e539                	bnez	a0,5f8 <go+0x54e>
      if(st.size != 1){
     5ac:	f8843583          	ld	a1,-120(s0)
     5b0:	05759d63          	bne	a1,s7,60a <go+0x560>
      if(st.ino > 200){
     5b4:	f7c42583          	lw	a1,-132(s0)
     5b8:	0c800793          	li	a5,200
     5bc:	06b7e163          	bltu	a5,a1,61e <go+0x574>
      close(fd1);
     5c0:	856a                	mv	a0,s10
     5c2:	6a8000ef          	jal	c6a <close>
      unlink("c");
     5c6:	00001517          	auipc	a0,0x1
     5ca:	e0a50513          	addi	a0,a0,-502 # 13d0 <malloc+0x2b6>
     5ce:	6c4000ef          	jal	c92 <unlink>
     5d2:	b66d                	j	17c <go+0xd2>
        printf("grind: create c failed\n");
     5d4:	00001517          	auipc	a0,0x1
     5d8:	e0450513          	addi	a0,a0,-508 # 13d8 <malloc+0x2be>
     5dc:	287000ef          	jal	1062 <printf>
        exit(1);
     5e0:	4505                	li	a0,1
     5e2:	660000ef          	jal	c42 <exit>
        printf("grind: write c failed\n");
     5e6:	00001517          	auipc	a0,0x1
     5ea:	e0a50513          	addi	a0,a0,-502 # 13f0 <malloc+0x2d6>
     5ee:	275000ef          	jal	1062 <printf>
        exit(1);
     5f2:	4505                	li	a0,1
     5f4:	64e000ef          	jal	c42 <exit>
        printf("grind: fstat failed\n");
     5f8:	00001517          	auipc	a0,0x1
     5fc:	e1050513          	addi	a0,a0,-496 # 1408 <malloc+0x2ee>
     600:	263000ef          	jal	1062 <printf>
        exit(1);
     604:	4505                	li	a0,1
     606:	63c000ef          	jal	c42 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     60a:	2581                	sext.w	a1,a1
     60c:	00001517          	auipc	a0,0x1
     610:	e1450513          	addi	a0,a0,-492 # 1420 <malloc+0x306>
     614:	24f000ef          	jal	1062 <printf>
        exit(1);
     618:	4505                	li	a0,1
     61a:	628000ef          	jal	c42 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     61e:	00001517          	auipc	a0,0x1
     622:	e2a50513          	addi	a0,a0,-470 # 1448 <malloc+0x32e>
     626:	23d000ef          	jal	1062 <printf>
        exit(1);
     62a:	4505                	li	a0,1
     62c:	616000ef          	jal	c42 <exit>
      if(pipe(aa) < 0){
     630:	856e                	mv	a0,s11
     632:	620000ef          	jal	c52 <pipe>
     636:	0c054263          	bltz	a0,6fa <go+0x650>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     63a:	f7040513          	addi	a0,s0,-144
     63e:	614000ef          	jal	c52 <pipe>
     642:	0c054663          	bltz	a0,70e <go+0x664>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     646:	5f4000ef          	jal	c3a <fork>
      if(pid1 == 0){
     64a:	0c050c63          	beqz	a0,722 <go+0x678>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     64e:	14054e63          	bltz	a0,7aa <go+0x700>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     652:	5e8000ef          	jal	c3a <fork>
      if(pid2 == 0){
     656:	16050463          	beqz	a0,7be <go+0x714>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     65a:	20054263          	bltz	a0,85e <go+0x7b4>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     65e:	f6842503          	lw	a0,-152(s0)
     662:	608000ef          	jal	c6a <close>
      close(aa[1]);
     666:	f6c42503          	lw	a0,-148(s0)
     66a:	600000ef          	jal	c6a <close>
      close(bb[1]);
     66e:	f7442503          	lw	a0,-140(s0)
     672:	5f8000ef          	jal	c6a <close>
      char buf[4] = { 0, 0, 0, 0 };
     676:	f6042023          	sw	zero,-160(s0)
      read(bb[0], buf+0, 1);
     67a:	865e                	mv	a2,s7
     67c:	f6040593          	addi	a1,s0,-160
     680:	f7042503          	lw	a0,-144(s0)
     684:	5d6000ef          	jal	c5a <read>
      read(bb[0], buf+1, 1);
     688:	865e                	mv	a2,s7
     68a:	f6140593          	addi	a1,s0,-159
     68e:	f7042503          	lw	a0,-144(s0)
     692:	5c8000ef          	jal	c5a <read>
      read(bb[0], buf+2, 1);
     696:	865e                	mv	a2,s7
     698:	f6240593          	addi	a1,s0,-158
     69c:	f7042503          	lw	a0,-144(s0)
     6a0:	5ba000ef          	jal	c5a <read>
      close(bb[0]);
     6a4:	f7042503          	lw	a0,-144(s0)
     6a8:	5c2000ef          	jal	c6a <close>
      int st1, st2;
      wait(&st1);
     6ac:	f6440513          	addi	a0,s0,-156
     6b0:	59a000ef          	jal	c4a <wait>
      wait(&st2);
     6b4:	f7840513          	addi	a0,s0,-136
     6b8:	592000ef          	jal	c4a <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     6bc:	f6442783          	lw	a5,-156(s0)
     6c0:	f7842703          	lw	a4,-136(s0)
     6c4:	8fd9                	or	a5,a5,a4
     6c6:	eb99                	bnez	a5,6dc <go+0x632>
     6c8:	00001597          	auipc	a1,0x1
     6cc:	e2058593          	addi	a1,a1,-480 # 14e8 <malloc+0x3ce>
     6d0:	f6040513          	addi	a0,s0,-160
     6d4:	2d6000ef          	jal	9aa <strcmp>
     6d8:	aa0502e3          	beqz	a0,17c <go+0xd2>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     6dc:	f6040693          	addi	a3,s0,-160
     6e0:	f7842603          	lw	a2,-136(s0)
     6e4:	f6442583          	lw	a1,-156(s0)
     6e8:	00001517          	auipc	a0,0x1
     6ec:	e0850513          	addi	a0,a0,-504 # 14f0 <malloc+0x3d6>
     6f0:	173000ef          	jal	1062 <printf>
        exit(1);
     6f4:	4505                	li	a0,1
     6f6:	54c000ef          	jal	c42 <exit>
        fprintf(2, "grind: pipe failed\n");
     6fa:	00001597          	auipc	a1,0x1
     6fe:	c6e58593          	addi	a1,a1,-914 # 1368 <malloc+0x24e>
     702:	4509                	li	a0,2
     704:	135000ef          	jal	1038 <fprintf>
        exit(1);
     708:	4505                	li	a0,1
     70a:	538000ef          	jal	c42 <exit>
        fprintf(2, "grind: pipe failed\n");
     70e:	00001597          	auipc	a1,0x1
     712:	c5a58593          	addi	a1,a1,-934 # 1368 <malloc+0x24e>
     716:	4509                	li	a0,2
     718:	121000ef          	jal	1038 <fprintf>
        exit(1);
     71c:	4505                	li	a0,1
     71e:	524000ef          	jal	c42 <exit>
        close(bb[0]);
     722:	f7042503          	lw	a0,-144(s0)
     726:	544000ef          	jal	c6a <close>
        close(bb[1]);
     72a:	f7442503          	lw	a0,-140(s0)
     72e:	53c000ef          	jal	c6a <close>
        close(aa[0]);
     732:	f6842503          	lw	a0,-152(s0)
     736:	534000ef          	jal	c6a <close>
        close(1);
     73a:	4505                	li	a0,1
     73c:	52e000ef          	jal	c6a <close>
        if(dup(aa[1]) != 1){
     740:	f6c42503          	lw	a0,-148(s0)
     744:	576000ef          	jal	cba <dup>
     748:	4785                	li	a5,1
     74a:	00f50c63          	beq	a0,a5,762 <go+0x6b8>
          fprintf(2, "grind: dup failed\n");
     74e:	00001597          	auipc	a1,0x1
     752:	d2258593          	addi	a1,a1,-734 # 1470 <malloc+0x356>
     756:	4509                	li	a0,2
     758:	0e1000ef          	jal	1038 <fprintf>
          exit(1);
     75c:	4505                	li	a0,1
     75e:	4e4000ef          	jal	c42 <exit>
        close(aa[1]);
     762:	f6c42503          	lw	a0,-148(s0)
     766:	504000ef          	jal	c6a <close>
        char *args[3] = { "echo", "hi", 0 };
     76a:	00001797          	auipc	a5,0x1
     76e:	d1e78793          	addi	a5,a5,-738 # 1488 <malloc+0x36e>
     772:	f6f43c23          	sd	a5,-136(s0)
     776:	00001797          	auipc	a5,0x1
     77a:	d1a78793          	addi	a5,a5,-742 # 1490 <malloc+0x376>
     77e:	f8f43023          	sd	a5,-128(s0)
     782:	f8043423          	sd	zero,-120(s0)
        exec("grindir/../echo", args);
     786:	f7840593          	addi	a1,s0,-136
     78a:	00001517          	auipc	a0,0x1
     78e:	d0e50513          	addi	a0,a0,-754 # 1498 <malloc+0x37e>
     792:	4e8000ef          	jal	c7a <exec>
        fprintf(2, "grind: echo: not found\n");
     796:	00001597          	auipc	a1,0x1
     79a:	d1258593          	addi	a1,a1,-750 # 14a8 <malloc+0x38e>
     79e:	4509                	li	a0,2
     7a0:	099000ef          	jal	1038 <fprintf>
        exit(2);
     7a4:	4509                	li	a0,2
     7a6:	49c000ef          	jal	c42 <exit>
        fprintf(2, "grind: fork failed\n");
     7aa:	00001597          	auipc	a1,0x1
     7ae:	b7658593          	addi	a1,a1,-1162 # 1320 <malloc+0x206>
     7b2:	4509                	li	a0,2
     7b4:	085000ef          	jal	1038 <fprintf>
        exit(3);
     7b8:	450d                	li	a0,3
     7ba:	488000ef          	jal	c42 <exit>
        close(aa[1]);
     7be:	f6c42503          	lw	a0,-148(s0)
     7c2:	4a8000ef          	jal	c6a <close>
        close(bb[0]);
     7c6:	f7042503          	lw	a0,-144(s0)
     7ca:	4a0000ef          	jal	c6a <close>
        close(0);
     7ce:	4501                	li	a0,0
     7d0:	49a000ef          	jal	c6a <close>
        if(dup(aa[0]) != 0){
     7d4:	f6842503          	lw	a0,-152(s0)
     7d8:	4e2000ef          	jal	cba <dup>
     7dc:	c919                	beqz	a0,7f2 <go+0x748>
          fprintf(2, "grind: dup failed\n");
     7de:	00001597          	auipc	a1,0x1
     7e2:	c9258593          	addi	a1,a1,-878 # 1470 <malloc+0x356>
     7e6:	4509                	li	a0,2
     7e8:	051000ef          	jal	1038 <fprintf>
          exit(4);
     7ec:	4511                	li	a0,4
     7ee:	454000ef          	jal	c42 <exit>
        close(aa[0]);
     7f2:	f6842503          	lw	a0,-152(s0)
     7f6:	474000ef          	jal	c6a <close>
        close(1);
     7fa:	4505                	li	a0,1
     7fc:	46e000ef          	jal	c6a <close>
        if(dup(bb[1]) != 1){
     800:	f7442503          	lw	a0,-140(s0)
     804:	4b6000ef          	jal	cba <dup>
     808:	4785                	li	a5,1
     80a:	00f50c63          	beq	a0,a5,822 <go+0x778>
          fprintf(2, "grind: dup failed\n");
     80e:	00001597          	auipc	a1,0x1
     812:	c6258593          	addi	a1,a1,-926 # 1470 <malloc+0x356>
     816:	4509                	li	a0,2
     818:	021000ef          	jal	1038 <fprintf>
          exit(5);
     81c:	4515                	li	a0,5
     81e:	424000ef          	jal	c42 <exit>
        close(bb[1]);
     822:	f7442503          	lw	a0,-140(s0)
     826:	444000ef          	jal	c6a <close>
        char *args[2] = { "cat", 0 };
     82a:	00001797          	auipc	a5,0x1
     82e:	c9678793          	addi	a5,a5,-874 # 14c0 <malloc+0x3a6>
     832:	f6f43c23          	sd	a5,-136(s0)
     836:	f8043023          	sd	zero,-128(s0)
        exec("/cat", args);
     83a:	f7840593          	addi	a1,s0,-136
     83e:	00001517          	auipc	a0,0x1
     842:	c8a50513          	addi	a0,a0,-886 # 14c8 <malloc+0x3ae>
     846:	434000ef          	jal	c7a <exec>
        fprintf(2, "grind: cat: not found\n");
     84a:	00001597          	auipc	a1,0x1
     84e:	c8658593          	addi	a1,a1,-890 # 14d0 <malloc+0x3b6>
     852:	4509                	li	a0,2
     854:	7e4000ef          	jal	1038 <fprintf>
        exit(6);
     858:	4519                	li	a0,6
     85a:	3e8000ef          	jal	c42 <exit>
        fprintf(2, "grind: fork failed\n");
     85e:	00001597          	auipc	a1,0x1
     862:	ac258593          	addi	a1,a1,-1342 # 1320 <malloc+0x206>
     866:	4509                	li	a0,2
     868:	7d0000ef          	jal	1038 <fprintf>
        exit(7);
     86c:	451d                	li	a0,7
     86e:	3d4000ef          	jal	c42 <exit>

0000000000000872 <iter>:
  }
}

void
iter()
{
     872:	7179                	addi	sp,sp,-48
     874:	f406                	sd	ra,40(sp)
     876:	f022                	sd	s0,32(sp)
     878:	1800                	addi	s0,sp,48
  unlink("a");
     87a:	00001517          	auipc	a0,0x1
     87e:	abe50513          	addi	a0,a0,-1346 # 1338 <malloc+0x21e>
     882:	410000ef          	jal	c92 <unlink>
  unlink("b");
     886:	00001517          	auipc	a0,0x1
     88a:	a6250513          	addi	a0,a0,-1438 # 12e8 <malloc+0x1ce>
     88e:	404000ef          	jal	c92 <unlink>
  
  int pid1 = fork();
     892:	3a8000ef          	jal	c3a <fork>
  if(pid1 < 0){
     896:	02054163          	bltz	a0,8b8 <iter+0x46>
     89a:	ec26                	sd	s1,24(sp)
     89c:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     89e:	e905                	bnez	a0,8ce <iter+0x5c>
     8a0:	e84a                	sd	s2,16(sp)
    rand_next ^= 31;
     8a2:	00001717          	auipc	a4,0x1
     8a6:	75e70713          	addi	a4,a4,1886 # 2000 <rand_next>
     8aa:	631c                	ld	a5,0(a4)
     8ac:	01f7c793          	xori	a5,a5,31
     8b0:	e31c                	sd	a5,0(a4)
    go(0);
     8b2:	4501                	li	a0,0
     8b4:	ff6ff0ef          	jal	aa <go>
     8b8:	ec26                	sd	s1,24(sp)
     8ba:	e84a                	sd	s2,16(sp)
    printf("grind: fork failed\n");
     8bc:	00001517          	auipc	a0,0x1
     8c0:	a6450513          	addi	a0,a0,-1436 # 1320 <malloc+0x206>
     8c4:	79e000ef          	jal	1062 <printf>
    exit(1);
     8c8:	4505                	li	a0,1
     8ca:	378000ef          	jal	c42 <exit>
     8ce:	e84a                	sd	s2,16(sp)
    exit(0);
  }

  int pid2 = fork();
     8d0:	36a000ef          	jal	c3a <fork>
     8d4:	892a                	mv	s2,a0
  if(pid2 < 0){
     8d6:	02054063          	bltz	a0,8f6 <iter+0x84>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     8da:	e51d                	bnez	a0,908 <iter+0x96>
    rand_next ^= 7177;
     8dc:	00001697          	auipc	a3,0x1
     8e0:	72468693          	addi	a3,a3,1828 # 2000 <rand_next>
     8e4:	629c                	ld	a5,0(a3)
     8e6:	6709                	lui	a4,0x2
     8e8:	c0970713          	addi	a4,a4,-1015 # 1c09 <digits+0x689>
     8ec:	8fb9                	xor	a5,a5,a4
     8ee:	e29c                	sd	a5,0(a3)
    go(1);
     8f0:	4505                	li	a0,1
     8f2:	fb8ff0ef          	jal	aa <go>
    printf("grind: fork failed\n");
     8f6:	00001517          	auipc	a0,0x1
     8fa:	a2a50513          	addi	a0,a0,-1494 # 1320 <malloc+0x206>
     8fe:	764000ef          	jal	1062 <printf>
    exit(1);
     902:	4505                	li	a0,1
     904:	33e000ef          	jal	c42 <exit>
    exit(0);
  }

  int st1 = -1;
     908:	57fd                	li	a5,-1
     90a:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     90e:	fdc40513          	addi	a0,s0,-36
     912:	338000ef          	jal	c4a <wait>
  if(st1 != 0){
     916:	fdc42783          	lw	a5,-36(s0)
     91a:	eb99                	bnez	a5,930 <iter+0xbe>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     91c:	57fd                	li	a5,-1
     91e:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     922:	fd840513          	addi	a0,s0,-40
     926:	324000ef          	jal	c4a <wait>

  exit(0);
     92a:	4501                	li	a0,0
     92c:	316000ef          	jal	c42 <exit>
    kill(pid1);
     930:	8526                	mv	a0,s1
     932:	340000ef          	jal	c72 <kill>
    kill(pid2);
     936:	854a                	mv	a0,s2
     938:	33a000ef          	jal	c72 <kill>
     93c:	b7c5                	j	91c <iter+0xaa>

000000000000093e <main>:
}

int
main()
{
     93e:	1101                	addi	sp,sp,-32
     940:	ec06                	sd	ra,24(sp)
     942:	e822                	sd	s0,16(sp)
     944:	e426                	sd	s1,8(sp)
     946:	e04a                	sd	s2,0(sp)
     948:	1000                	addi	s0,sp,32
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    pause(20);
     94a:	4951                	li	s2,20
    rand_next += 1;
     94c:	00001497          	auipc	s1,0x1
     950:	6b448493          	addi	s1,s1,1716 # 2000 <rand_next>
     954:	a809                	j	966 <main+0x28>
      iter();
     956:	f1dff0ef          	jal	872 <iter>
    pause(20);
     95a:	854a                	mv	a0,s2
     95c:	376000ef          	jal	cd2 <pause>
    rand_next += 1;
     960:	609c                	ld	a5,0(s1)
     962:	0785                	addi	a5,a5,1
     964:	e09c                	sd	a5,0(s1)
    int pid = fork();
     966:	2d4000ef          	jal	c3a <fork>
    if(pid == 0){
     96a:	d575                	beqz	a0,956 <main+0x18>
    if(pid > 0){
     96c:	fea057e3          	blez	a0,95a <main+0x1c>
      wait(0);
     970:	4501                	li	a0,0
     972:	2d8000ef          	jal	c4a <wait>
     976:	b7d5                	j	95a <main+0x1c>

0000000000000978 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start()
{
     978:	1141                	addi	sp,sp,-16
     97a:	e406                	sd	ra,8(sp)
     97c:	e022                	sd	s0,0(sp)
     97e:	0800                	addi	s0,sp,16
  extern int main();
  main();
     980:	fbfff0ef          	jal	93e <main>
  exit(0);
     984:	4501                	li	a0,0
     986:	2bc000ef          	jal	c42 <exit>

000000000000098a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     98a:	1141                	addi	sp,sp,-16
     98c:	e406                	sd	ra,8(sp)
     98e:	e022                	sd	s0,0(sp)
     990:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     992:	87aa                	mv	a5,a0
     994:	0585                	addi	a1,a1,1
     996:	0785                	addi	a5,a5,1
     998:	fff5c703          	lbu	a4,-1(a1)
     99c:	fee78fa3          	sb	a4,-1(a5)
     9a0:	fb75                	bnez	a4,994 <strcpy+0xa>
    ;
  return os;
}
     9a2:	60a2                	ld	ra,8(sp)
     9a4:	6402                	ld	s0,0(sp)
     9a6:	0141                	addi	sp,sp,16
     9a8:	8082                	ret

00000000000009aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
     9aa:	1141                	addi	sp,sp,-16
     9ac:	e406                	sd	ra,8(sp)
     9ae:	e022                	sd	s0,0(sp)
     9b0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     9b2:	00054783          	lbu	a5,0(a0)
     9b6:	cb91                	beqz	a5,9ca <strcmp+0x20>
     9b8:	0005c703          	lbu	a4,0(a1)
     9bc:	00f71763          	bne	a4,a5,9ca <strcmp+0x20>
    p++, q++;
     9c0:	0505                	addi	a0,a0,1
     9c2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     9c4:	00054783          	lbu	a5,0(a0)
     9c8:	fbe5                	bnez	a5,9b8 <strcmp+0xe>
  return (uchar)*p - (uchar)*q;
     9ca:	0005c503          	lbu	a0,0(a1)
}
     9ce:	40a7853b          	subw	a0,a5,a0
     9d2:	60a2                	ld	ra,8(sp)
     9d4:	6402                	ld	s0,0(sp)
     9d6:	0141                	addi	sp,sp,16
     9d8:	8082                	ret

00000000000009da <strlen>:

uint
strlen(const char *s)
{
     9da:	1141                	addi	sp,sp,-16
     9dc:	e406                	sd	ra,8(sp)
     9de:	e022                	sd	s0,0(sp)
     9e0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     9e2:	00054783          	lbu	a5,0(a0)
     9e6:	cf99                	beqz	a5,a04 <strlen+0x2a>
     9e8:	0505                	addi	a0,a0,1
     9ea:	87aa                	mv	a5,a0
     9ec:	86be                	mv	a3,a5
     9ee:	0785                	addi	a5,a5,1
     9f0:	fff7c703          	lbu	a4,-1(a5)
     9f4:	ff65                	bnez	a4,9ec <strlen+0x12>
     9f6:	40a6853b          	subw	a0,a3,a0
     9fa:	2505                	addiw	a0,a0,1
    ;
  return n;
}
     9fc:	60a2                	ld	ra,8(sp)
     9fe:	6402                	ld	s0,0(sp)
     a00:	0141                	addi	sp,sp,16
     a02:	8082                	ret
  for(n = 0; s[n]; n++)
     a04:	4501                	li	a0,0
     a06:	bfdd                	j	9fc <strlen+0x22>

0000000000000a08 <memset>:

void*
memset(void *dst, int c, uint n)
{
     a08:	1141                	addi	sp,sp,-16
     a0a:	e406                	sd	ra,8(sp)
     a0c:	e022                	sd	s0,0(sp)
     a0e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     a10:	ca19                	beqz	a2,a26 <memset+0x1e>
     a12:	87aa                	mv	a5,a0
     a14:	1602                	slli	a2,a2,0x20
     a16:	9201                	srli	a2,a2,0x20
     a18:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     a1c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     a20:	0785                	addi	a5,a5,1
     a22:	fee79de3          	bne	a5,a4,a1c <memset+0x14>
  }
  return dst;
}
     a26:	60a2                	ld	ra,8(sp)
     a28:	6402                	ld	s0,0(sp)
     a2a:	0141                	addi	sp,sp,16
     a2c:	8082                	ret

0000000000000a2e <strchr>:

char*
strchr(const char *s, char c)
{
     a2e:	1141                	addi	sp,sp,-16
     a30:	e406                	sd	ra,8(sp)
     a32:	e022                	sd	s0,0(sp)
     a34:	0800                	addi	s0,sp,16
  for(; *s; s++)
     a36:	00054783          	lbu	a5,0(a0)
     a3a:	cf81                	beqz	a5,a52 <strchr+0x24>
    if(*s == c)
     a3c:	00f58763          	beq	a1,a5,a4a <strchr+0x1c>
  for(; *s; s++)
     a40:	0505                	addi	a0,a0,1
     a42:	00054783          	lbu	a5,0(a0)
     a46:	fbfd                	bnez	a5,a3c <strchr+0xe>
      return (char*)s;
  return 0;
     a48:	4501                	li	a0,0
}
     a4a:	60a2                	ld	ra,8(sp)
     a4c:	6402                	ld	s0,0(sp)
     a4e:	0141                	addi	sp,sp,16
     a50:	8082                	ret
  return 0;
     a52:	4501                	li	a0,0
     a54:	bfdd                	j	a4a <strchr+0x1c>

0000000000000a56 <gets>:

char*
gets(char *buf, int max)
{
     a56:	7159                	addi	sp,sp,-112
     a58:	f486                	sd	ra,104(sp)
     a5a:	f0a2                	sd	s0,96(sp)
     a5c:	eca6                	sd	s1,88(sp)
     a5e:	e8ca                	sd	s2,80(sp)
     a60:	e4ce                	sd	s3,72(sp)
     a62:	e0d2                	sd	s4,64(sp)
     a64:	fc56                	sd	s5,56(sp)
     a66:	f85a                	sd	s6,48(sp)
     a68:	f45e                	sd	s7,40(sp)
     a6a:	f062                	sd	s8,32(sp)
     a6c:	ec66                	sd	s9,24(sp)
     a6e:	e86a                	sd	s10,16(sp)
     a70:	1880                	addi	s0,sp,112
     a72:	8caa                	mv	s9,a0
     a74:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     a76:	892a                	mv	s2,a0
     a78:	4481                	li	s1,0
    cc = read(0, &c, 1);
     a7a:	f9f40b13          	addi	s6,s0,-97
     a7e:	4a85                	li	s5,1
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     a80:	4ba9                	li	s7,10
     a82:	4c35                	li	s8,13
  for(i=0; i+1 < max; ){
     a84:	8d26                	mv	s10,s1
     a86:	0014899b          	addiw	s3,s1,1
     a8a:	84ce                	mv	s1,s3
     a8c:	0349d563          	bge	s3,s4,ab6 <gets+0x60>
    cc = read(0, &c, 1);
     a90:	8656                	mv	a2,s5
     a92:	85da                	mv	a1,s6
     a94:	4501                	li	a0,0
     a96:	1c4000ef          	jal	c5a <read>
    if(cc < 1)
     a9a:	00a05e63          	blez	a0,ab6 <gets+0x60>
    buf[i++] = c;
     a9e:	f9f44783          	lbu	a5,-97(s0)
     aa2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     aa6:	01778763          	beq	a5,s7,ab4 <gets+0x5e>
     aaa:	0905                	addi	s2,s2,1
     aac:	fd879ce3          	bne	a5,s8,a84 <gets+0x2e>
    buf[i++] = c;
     ab0:	8d4e                	mv	s10,s3
     ab2:	a011                	j	ab6 <gets+0x60>
     ab4:	8d4e                	mv	s10,s3
      break;
  }
  buf[i] = '\0';
     ab6:	9d66                	add	s10,s10,s9
     ab8:	000d0023          	sb	zero,0(s10)
  return buf;
}
     abc:	8566                	mv	a0,s9
     abe:	70a6                	ld	ra,104(sp)
     ac0:	7406                	ld	s0,96(sp)
     ac2:	64e6                	ld	s1,88(sp)
     ac4:	6946                	ld	s2,80(sp)
     ac6:	69a6                	ld	s3,72(sp)
     ac8:	6a06                	ld	s4,64(sp)
     aca:	7ae2                	ld	s5,56(sp)
     acc:	7b42                	ld	s6,48(sp)
     ace:	7ba2                	ld	s7,40(sp)
     ad0:	7c02                	ld	s8,32(sp)
     ad2:	6ce2                	ld	s9,24(sp)
     ad4:	6d42                	ld	s10,16(sp)
     ad6:	6165                	addi	sp,sp,112
     ad8:	8082                	ret

0000000000000ada <stat>:

int
stat(const char *n, struct stat *st)
{
     ada:	1101                	addi	sp,sp,-32
     adc:	ec06                	sd	ra,24(sp)
     ade:	e822                	sd	s0,16(sp)
     ae0:	e04a                	sd	s2,0(sp)
     ae2:	1000                	addi	s0,sp,32
     ae4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ae6:	4581                	li	a1,0
     ae8:	19a000ef          	jal	c82 <open>
  if(fd < 0)
     aec:	02054263          	bltz	a0,b10 <stat+0x36>
     af0:	e426                	sd	s1,8(sp)
     af2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     af4:	85ca                	mv	a1,s2
     af6:	1a4000ef          	jal	c9a <fstat>
     afa:	892a                	mv	s2,a0
  close(fd);
     afc:	8526                	mv	a0,s1
     afe:	16c000ef          	jal	c6a <close>
  return r;
     b02:	64a2                	ld	s1,8(sp)
}
     b04:	854a                	mv	a0,s2
     b06:	60e2                	ld	ra,24(sp)
     b08:	6442                	ld	s0,16(sp)
     b0a:	6902                	ld	s2,0(sp)
     b0c:	6105                	addi	sp,sp,32
     b0e:	8082                	ret
    return -1;
     b10:	597d                	li	s2,-1
     b12:	bfcd                	j	b04 <stat+0x2a>

0000000000000b14 <atoi>:

int
atoi(const char *s)
{
     b14:	1141                	addi	sp,sp,-16
     b16:	e406                	sd	ra,8(sp)
     b18:	e022                	sd	s0,0(sp)
     b1a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     b1c:	00054683          	lbu	a3,0(a0)
     b20:	fd06879b          	addiw	a5,a3,-48
     b24:	0ff7f793          	zext.b	a5,a5
     b28:	4625                	li	a2,9
     b2a:	02f66963          	bltu	a2,a5,b5c <atoi+0x48>
     b2e:	872a                	mv	a4,a0
  n = 0;
     b30:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
     b32:	0705                	addi	a4,a4,1
     b34:	0025179b          	slliw	a5,a0,0x2
     b38:	9fa9                	addw	a5,a5,a0
     b3a:	0017979b          	slliw	a5,a5,0x1
     b3e:	9fb5                	addw	a5,a5,a3
     b40:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     b44:	00074683          	lbu	a3,0(a4)
     b48:	fd06879b          	addiw	a5,a3,-48
     b4c:	0ff7f793          	zext.b	a5,a5
     b50:	fef671e3          	bgeu	a2,a5,b32 <atoi+0x1e>
  return n;
}
     b54:	60a2                	ld	ra,8(sp)
     b56:	6402                	ld	s0,0(sp)
     b58:	0141                	addi	sp,sp,16
     b5a:	8082                	ret
  n = 0;
     b5c:	4501                	li	a0,0
     b5e:	bfdd                	j	b54 <atoi+0x40>

0000000000000b60 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     b60:	1141                	addi	sp,sp,-16
     b62:	e406                	sd	ra,8(sp)
     b64:	e022                	sd	s0,0(sp)
     b66:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     b68:	02b57563          	bgeu	a0,a1,b92 <memmove+0x32>
    while(n-- > 0)
     b6c:	00c05f63          	blez	a2,b8a <memmove+0x2a>
     b70:	1602                	slli	a2,a2,0x20
     b72:	9201                	srli	a2,a2,0x20
     b74:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     b78:	872a                	mv	a4,a0
      *dst++ = *src++;
     b7a:	0585                	addi	a1,a1,1
     b7c:	0705                	addi	a4,a4,1
     b7e:	fff5c683          	lbu	a3,-1(a1)
     b82:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     b86:	fee79ae3          	bne	a5,a4,b7a <memmove+0x1a>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     b8a:	60a2                	ld	ra,8(sp)
     b8c:	6402                	ld	s0,0(sp)
     b8e:	0141                	addi	sp,sp,16
     b90:	8082                	ret
    dst += n;
     b92:	00c50733          	add	a4,a0,a2
    src += n;
     b96:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     b98:	fec059e3          	blez	a2,b8a <memmove+0x2a>
     b9c:	fff6079b          	addiw	a5,a2,-1
     ba0:	1782                	slli	a5,a5,0x20
     ba2:	9381                	srli	a5,a5,0x20
     ba4:	fff7c793          	not	a5,a5
     ba8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     baa:	15fd                	addi	a1,a1,-1
     bac:	177d                	addi	a4,a4,-1
     bae:	0005c683          	lbu	a3,0(a1)
     bb2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     bb6:	fef71ae3          	bne	a4,a5,baa <memmove+0x4a>
     bba:	bfc1                	j	b8a <memmove+0x2a>

0000000000000bbc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     bbc:	1141                	addi	sp,sp,-16
     bbe:	e406                	sd	ra,8(sp)
     bc0:	e022                	sd	s0,0(sp)
     bc2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     bc4:	ca0d                	beqz	a2,bf6 <memcmp+0x3a>
     bc6:	fff6069b          	addiw	a3,a2,-1
     bca:	1682                	slli	a3,a3,0x20
     bcc:	9281                	srli	a3,a3,0x20
     bce:	0685                	addi	a3,a3,1
     bd0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     bd2:	00054783          	lbu	a5,0(a0)
     bd6:	0005c703          	lbu	a4,0(a1)
     bda:	00e79863          	bne	a5,a4,bea <memcmp+0x2e>
      return *p1 - *p2;
    }
    p1++;
     bde:	0505                	addi	a0,a0,1
    p2++;
     be0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     be2:	fed518e3          	bne	a0,a3,bd2 <memcmp+0x16>
  }
  return 0;
     be6:	4501                	li	a0,0
     be8:	a019                	j	bee <memcmp+0x32>
      return *p1 - *p2;
     bea:	40e7853b          	subw	a0,a5,a4
}
     bee:	60a2                	ld	ra,8(sp)
     bf0:	6402                	ld	s0,0(sp)
     bf2:	0141                	addi	sp,sp,16
     bf4:	8082                	ret
  return 0;
     bf6:	4501                	li	a0,0
     bf8:	bfdd                	j	bee <memcmp+0x32>

0000000000000bfa <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     bfa:	1141                	addi	sp,sp,-16
     bfc:	e406                	sd	ra,8(sp)
     bfe:	e022                	sd	s0,0(sp)
     c00:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     c02:	f5fff0ef          	jal	b60 <memmove>
}
     c06:	60a2                	ld	ra,8(sp)
     c08:	6402                	ld	s0,0(sp)
     c0a:	0141                	addi	sp,sp,16
     c0c:	8082                	ret

0000000000000c0e <sbrk>:

char *
sbrk(int n) {
     c0e:	1141                	addi	sp,sp,-16
     c10:	e406                	sd	ra,8(sp)
     c12:	e022                	sd	s0,0(sp)
     c14:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
     c16:	4585                	li	a1,1
     c18:	0b2000ef          	jal	cca <sys_sbrk>
}
     c1c:	60a2                	ld	ra,8(sp)
     c1e:	6402                	ld	s0,0(sp)
     c20:	0141                	addi	sp,sp,16
     c22:	8082                	ret

0000000000000c24 <sbrklazy>:

char *
sbrklazy(int n) {
     c24:	1141                	addi	sp,sp,-16
     c26:	e406                	sd	ra,8(sp)
     c28:	e022                	sd	s0,0(sp)
     c2a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
     c2c:	4589                	li	a1,2
     c2e:	09c000ef          	jal	cca <sys_sbrk>
}
     c32:	60a2                	ld	ra,8(sp)
     c34:	6402                	ld	s0,0(sp)
     c36:	0141                	addi	sp,sp,16
     c38:	8082                	ret

0000000000000c3a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     c3a:	4885                	li	a7,1
 ecall
     c3c:	00000073          	ecall
 ret
     c40:	8082                	ret

0000000000000c42 <exit>:
.global exit
exit:
 li a7, SYS_exit
     c42:	4889                	li	a7,2
 ecall
     c44:	00000073          	ecall
 ret
     c48:	8082                	ret

0000000000000c4a <wait>:
.global wait
wait:
 li a7, SYS_wait
     c4a:	488d                	li	a7,3
 ecall
     c4c:	00000073          	ecall
 ret
     c50:	8082                	ret

0000000000000c52 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     c52:	4891                	li	a7,4
 ecall
     c54:	00000073          	ecall
 ret
     c58:	8082                	ret

0000000000000c5a <read>:
.global read
read:
 li a7, SYS_read
     c5a:	4895                	li	a7,5
 ecall
     c5c:	00000073          	ecall
 ret
     c60:	8082                	ret

0000000000000c62 <write>:
.global write
write:
 li a7, SYS_write
     c62:	48c1                	li	a7,16
 ecall
     c64:	00000073          	ecall
 ret
     c68:	8082                	ret

0000000000000c6a <close>:
.global close
close:
 li a7, SYS_close
     c6a:	48d5                	li	a7,21
 ecall
     c6c:	00000073          	ecall
 ret
     c70:	8082                	ret

0000000000000c72 <kill>:
.global kill
kill:
 li a7, SYS_kill
     c72:	4899                	li	a7,6
 ecall
     c74:	00000073          	ecall
 ret
     c78:	8082                	ret

0000000000000c7a <exec>:
.global exec
exec:
 li a7, SYS_exec
     c7a:	489d                	li	a7,7
 ecall
     c7c:	00000073          	ecall
 ret
     c80:	8082                	ret

0000000000000c82 <open>:
.global open
open:
 li a7, SYS_open
     c82:	48bd                	li	a7,15
 ecall
     c84:	00000073          	ecall
 ret
     c88:	8082                	ret

0000000000000c8a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     c8a:	48c5                	li	a7,17
 ecall
     c8c:	00000073          	ecall
 ret
     c90:	8082                	ret

0000000000000c92 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     c92:	48c9                	li	a7,18
 ecall
     c94:	00000073          	ecall
 ret
     c98:	8082                	ret

0000000000000c9a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     c9a:	48a1                	li	a7,8
 ecall
     c9c:	00000073          	ecall
 ret
     ca0:	8082                	ret

0000000000000ca2 <link>:
.global link
link:
 li a7, SYS_link
     ca2:	48cd                	li	a7,19
 ecall
     ca4:	00000073          	ecall
 ret
     ca8:	8082                	ret

0000000000000caa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     caa:	48d1                	li	a7,20
 ecall
     cac:	00000073          	ecall
 ret
     cb0:	8082                	ret

0000000000000cb2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     cb2:	48a5                	li	a7,9
 ecall
     cb4:	00000073          	ecall
 ret
     cb8:	8082                	ret

0000000000000cba <dup>:
.global dup
dup:
 li a7, SYS_dup
     cba:	48a9                	li	a7,10
 ecall
     cbc:	00000073          	ecall
 ret
     cc0:	8082                	ret

0000000000000cc2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     cc2:	48ad                	li	a7,11
 ecall
     cc4:	00000073          	ecall
 ret
     cc8:	8082                	ret

0000000000000cca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
     cca:	48b1                	li	a7,12
 ecall
     ccc:	00000073          	ecall
 ret
     cd0:	8082                	ret

0000000000000cd2 <pause>:
.global pause
pause:
 li a7, SYS_pause
     cd2:	48b5                	li	a7,13
 ecall
     cd4:	00000073          	ecall
 ret
     cd8:	8082                	ret

0000000000000cda <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     cda:	48b9                	li	a7,14
 ecall
     cdc:	00000073          	ecall
 ret
     ce0:	8082                	ret

0000000000000ce2 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     ce2:	1101                	addi	sp,sp,-32
     ce4:	ec06                	sd	ra,24(sp)
     ce6:	e822                	sd	s0,16(sp)
     ce8:	1000                	addi	s0,sp,32
     cea:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     cee:	4605                	li	a2,1
     cf0:	fef40593          	addi	a1,s0,-17
     cf4:	f6fff0ef          	jal	c62 <write>
}
     cf8:	60e2                	ld	ra,24(sp)
     cfa:	6442                	ld	s0,16(sp)
     cfc:	6105                	addi	sp,sp,32
     cfe:	8082                	ret

0000000000000d00 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
     d00:	715d                	addi	sp,sp,-80
     d02:	e486                	sd	ra,72(sp)
     d04:	e0a2                	sd	s0,64(sp)
     d06:	fc26                	sd	s1,56(sp)
     d08:	f84a                	sd	s2,48(sp)
     d0a:	f44e                	sd	s3,40(sp)
     d0c:	0880                	addi	s0,sp,80
     d0e:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d10:	c299                	beqz	a3,d16 <printint+0x16>
     d12:	0605cf63          	bltz	a1,d90 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     d16:	2581                	sext.w	a1,a1
  neg = 0;
     d18:	4e01                	li	t3,0
  }

  i = 0;
     d1a:	fb840313          	addi	t1,s0,-72
  neg = 0;
     d1e:	869a                	mv	a3,t1
  i = 0;
     d20:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
     d22:	00001817          	auipc	a6,0x1
     d26:	85e80813          	addi	a6,a6,-1954 # 1580 <digits>
     d2a:	88be                	mv	a7,a5
     d2c:	0017851b          	addiw	a0,a5,1
     d30:	87aa                	mv	a5,a0
     d32:	02c5f73b          	remuw	a4,a1,a2
     d36:	1702                	slli	a4,a4,0x20
     d38:	9301                	srli	a4,a4,0x20
     d3a:	9742                	add	a4,a4,a6
     d3c:	00074703          	lbu	a4,0(a4)
     d40:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
     d44:	872e                	mv	a4,a1
     d46:	02c5d5bb          	divuw	a1,a1,a2
     d4a:	0685                	addi	a3,a3,1
     d4c:	fcc77fe3          	bgeu	a4,a2,d2a <printint+0x2a>
  if(neg)
     d50:	000e0c63          	beqz	t3,d68 <printint+0x68>
    buf[i++] = '-';
     d54:	fd050793          	addi	a5,a0,-48
     d58:	00878533          	add	a0,a5,s0
     d5c:	02d00793          	li	a5,45
     d60:	fef50423          	sb	a5,-24(a0)
     d64:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
     d68:	fff7899b          	addiw	s3,a5,-1
     d6c:	006784b3          	add	s1,a5,t1
    putc(fd, buf[i]);
     d70:	fff4c583          	lbu	a1,-1(s1)
     d74:	854a                	mv	a0,s2
     d76:	f6dff0ef          	jal	ce2 <putc>
  while(--i >= 0)
     d7a:	39fd                	addiw	s3,s3,-1
     d7c:	14fd                	addi	s1,s1,-1
     d7e:	fe09d9e3          	bgez	s3,d70 <printint+0x70>
}
     d82:	60a6                	ld	ra,72(sp)
     d84:	6406                	ld	s0,64(sp)
     d86:	74e2                	ld	s1,56(sp)
     d88:	7942                	ld	s2,48(sp)
     d8a:	79a2                	ld	s3,40(sp)
     d8c:	6161                	addi	sp,sp,80
     d8e:	8082                	ret
    x = -xx;
     d90:	40b005bb          	negw	a1,a1
    neg = 1;
     d94:	4e05                	li	t3,1
    x = -xx;
     d96:	b751                	j	d1a <printint+0x1a>

0000000000000d98 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     d98:	711d                	addi	sp,sp,-96
     d9a:	ec86                	sd	ra,88(sp)
     d9c:	e8a2                	sd	s0,80(sp)
     d9e:	e4a6                	sd	s1,72(sp)
     da0:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     da2:	0005c483          	lbu	s1,0(a1)
     da6:	28048463          	beqz	s1,102e <vprintf+0x296>
     daa:	e0ca                	sd	s2,64(sp)
     dac:	fc4e                	sd	s3,56(sp)
     dae:	f852                	sd	s4,48(sp)
     db0:	f456                	sd	s5,40(sp)
     db2:	f05a                	sd	s6,32(sp)
     db4:	ec5e                	sd	s7,24(sp)
     db6:	e862                	sd	s8,16(sp)
     db8:	e466                	sd	s9,8(sp)
     dba:	8b2a                	mv	s6,a0
     dbc:	8a2e                	mv	s4,a1
     dbe:	8bb2                	mv	s7,a2
  state = 0;
     dc0:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
     dc2:	4901                	li	s2,0
     dc4:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
     dc6:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
     dca:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
     dce:	06c00c93          	li	s9,108
     dd2:	a00d                	j	df4 <vprintf+0x5c>
        putc(fd, c0);
     dd4:	85a6                	mv	a1,s1
     dd6:	855a                	mv	a0,s6
     dd8:	f0bff0ef          	jal	ce2 <putc>
     ddc:	a019                	j	de2 <vprintf+0x4a>
    } else if(state == '%'){
     dde:	03598363          	beq	s3,s5,e04 <vprintf+0x6c>
  for(i = 0; fmt[i]; i++){
     de2:	0019079b          	addiw	a5,s2,1
     de6:	893e                	mv	s2,a5
     de8:	873e                	mv	a4,a5
     dea:	97d2                	add	a5,a5,s4
     dec:	0007c483          	lbu	s1,0(a5)
     df0:	22048763          	beqz	s1,101e <vprintf+0x286>
    c0 = fmt[i] & 0xff;
     df4:	0004879b          	sext.w	a5,s1
    if(state == 0){
     df8:	fe0993e3          	bnez	s3,dde <vprintf+0x46>
      if(c0 == '%'){
     dfc:	fd579ce3          	bne	a5,s5,dd4 <vprintf+0x3c>
        state = '%';
     e00:	89be                	mv	s3,a5
     e02:	b7c5                	j	de2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
     e04:	00ea06b3          	add	a3,s4,a4
     e08:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
     e0c:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
     e0e:	c681                	beqz	a3,e16 <vprintf+0x7e>
     e10:	9752                	add	a4,a4,s4
     e12:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
     e16:	05878263          	beq	a5,s8,e5a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
     e1a:	05978c63          	beq	a5,s9,e72 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
     e1e:	07500713          	li	a4,117
     e22:	0ee78663          	beq	a5,a4,f0e <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
     e26:	07800713          	li	a4,120
     e2a:	12e78863          	beq	a5,a4,f5a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
     e2e:	07000713          	li	a4,112
     e32:	14e78d63          	beq	a5,a4,f8c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
     e36:	06300713          	li	a4,99
     e3a:	18e78c63          	beq	a5,a4,fd2 <vprintf+0x23a>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
     e3e:	07300713          	li	a4,115
     e42:	1ae78263          	beq	a5,a4,fe6 <vprintf+0x24e>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
     e46:	02500713          	li	a4,37
     e4a:	04e79463          	bne	a5,a4,e92 <vprintf+0xfa>
        putc(fd, '%');
     e4e:	85ba                	mv	a1,a4
     e50:	855a                	mv	a0,s6
     e52:	e91ff0ef          	jal	ce2 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
     e56:	4981                	li	s3,0
     e58:	b769                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
     e5a:	008b8493          	addi	s1,s7,8
     e5e:	4685                	li	a3,1
     e60:	4629                	li	a2,10
     e62:	000ba583          	lw	a1,0(s7)
     e66:	855a                	mv	a0,s6
     e68:	e99ff0ef          	jal	d00 <printint>
     e6c:	8ba6                	mv	s7,s1
      state = 0;
     e6e:	4981                	li	s3,0
     e70:	bf8d                	j	de2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
     e72:	06400793          	li	a5,100
     e76:	02f68963          	beq	a3,a5,ea8 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     e7a:	06c00793          	li	a5,108
     e7e:	04f68263          	beq	a3,a5,ec2 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
     e82:	07500793          	li	a5,117
     e86:	0af68063          	beq	a3,a5,f26 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
     e8a:	07800793          	li	a5,120
     e8e:	0ef68263          	beq	a3,a5,f72 <vprintf+0x1da>
        putc(fd, '%');
     e92:	02500593          	li	a1,37
     e96:	855a                	mv	a0,s6
     e98:	e4bff0ef          	jal	ce2 <putc>
        putc(fd, c0);
     e9c:	85a6                	mv	a1,s1
     e9e:	855a                	mv	a0,s6
     ea0:	e43ff0ef          	jal	ce2 <putc>
      state = 0;
     ea4:	4981                	li	s3,0
     ea6:	bf35                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ea8:	008b8493          	addi	s1,s7,8
     eac:	4685                	li	a3,1
     eae:	4629                	li	a2,10
     eb0:	000bb583          	ld	a1,0(s7)
     eb4:	855a                	mv	a0,s6
     eb6:	e4bff0ef          	jal	d00 <printint>
        i += 1;
     eba:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 1);
     ebc:	8ba6                	mv	s7,s1
      state = 0;
     ebe:	4981                	li	s3,0
        i += 1;
     ec0:	b70d                	j	de2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
     ec2:	06400793          	li	a5,100
     ec6:	02f60763          	beq	a2,a5,ef4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
     eca:	07500793          	li	a5,117
     ece:	06f60963          	beq	a2,a5,f40 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
     ed2:	07800793          	li	a5,120
     ed6:	faf61ee3          	bne	a2,a5,e92 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
     eda:	008b8493          	addi	s1,s7,8
     ede:	4681                	li	a3,0
     ee0:	4641                	li	a2,16
     ee2:	000bb583          	ld	a1,0(s7)
     ee6:	855a                	mv	a0,s6
     ee8:	e19ff0ef          	jal	d00 <printint>
        i += 2;
     eec:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 16, 0);
     eee:	8ba6                	mv	s7,s1
      state = 0;
     ef0:	4981                	li	s3,0
        i += 2;
     ef2:	bdc5                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
     ef4:	008b8493          	addi	s1,s7,8
     ef8:	4685                	li	a3,1
     efa:	4629                	li	a2,10
     efc:	000bb583          	ld	a1,0(s7)
     f00:	855a                	mv	a0,s6
     f02:	dffff0ef          	jal	d00 <printint>
        i += 2;
     f06:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 1);
     f08:	8ba6                	mv	s7,s1
      state = 0;
     f0a:	4981                	li	s3,0
        i += 2;
     f0c:	bdd9                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
     f0e:	008b8493          	addi	s1,s7,8
     f12:	4681                	li	a3,0
     f14:	4629                	li	a2,10
     f16:	000be583          	lwu	a1,0(s7)
     f1a:	855a                	mv	a0,s6
     f1c:	de5ff0ef          	jal	d00 <printint>
     f20:	8ba6                	mv	s7,s1
      state = 0;
     f22:	4981                	li	s3,0
     f24:	bd7d                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f26:	008b8493          	addi	s1,s7,8
     f2a:	4681                	li	a3,0
     f2c:	4629                	li	a2,10
     f2e:	000bb583          	ld	a1,0(s7)
     f32:	855a                	mv	a0,s6
     f34:	dcdff0ef          	jal	d00 <printint>
        i += 1;
     f38:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 10, 0);
     f3a:	8ba6                	mv	s7,s1
      state = 0;
     f3c:	4981                	li	s3,0
        i += 1;
     f3e:	b555                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
     f40:	008b8493          	addi	s1,s7,8
     f44:	4681                	li	a3,0
     f46:	4629                	li	a2,10
     f48:	000bb583          	ld	a1,0(s7)
     f4c:	855a                	mv	a0,s6
     f4e:	db3ff0ef          	jal	d00 <printint>
        i += 2;
     f52:	2909                	addiw	s2,s2,2
        printint(fd, va_arg(ap, uint64), 10, 0);
     f54:	8ba6                	mv	s7,s1
      state = 0;
     f56:	4981                	li	s3,0
        i += 2;
     f58:	b569                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
     f5a:	008b8493          	addi	s1,s7,8
     f5e:	4681                	li	a3,0
     f60:	4641                	li	a2,16
     f62:	000be583          	lwu	a1,0(s7)
     f66:	855a                	mv	a0,s6
     f68:	d99ff0ef          	jal	d00 <printint>
     f6c:	8ba6                	mv	s7,s1
      state = 0;
     f6e:	4981                	li	s3,0
     f70:	bd8d                	j	de2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
     f72:	008b8493          	addi	s1,s7,8
     f76:	4681                	li	a3,0
     f78:	4641                	li	a2,16
     f7a:	000bb583          	ld	a1,0(s7)
     f7e:	855a                	mv	a0,s6
     f80:	d81ff0ef          	jal	d00 <printint>
        i += 1;
     f84:	2905                	addiw	s2,s2,1
        printint(fd, va_arg(ap, uint64), 16, 0);
     f86:	8ba6                	mv	s7,s1
      state = 0;
     f88:	4981                	li	s3,0
        i += 1;
     f8a:	bda1                	j	de2 <vprintf+0x4a>
     f8c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
     f8e:	008b8d13          	addi	s10,s7,8
     f92:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
     f96:	03000593          	li	a1,48
     f9a:	855a                	mv	a0,s6
     f9c:	d47ff0ef          	jal	ce2 <putc>
  putc(fd, 'x');
     fa0:	07800593          	li	a1,120
     fa4:	855a                	mv	a0,s6
     fa6:	d3dff0ef          	jal	ce2 <putc>
     faa:	44c1                	li	s1,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     fac:	00000b97          	auipc	s7,0x0
     fb0:	5d4b8b93          	addi	s7,s7,1492 # 1580 <digits>
     fb4:	03c9d793          	srli	a5,s3,0x3c
     fb8:	97de                	add	a5,a5,s7
     fba:	0007c583          	lbu	a1,0(a5)
     fbe:	855a                	mv	a0,s6
     fc0:	d23ff0ef          	jal	ce2 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     fc4:	0992                	slli	s3,s3,0x4
     fc6:	34fd                	addiw	s1,s1,-1
     fc8:	f4f5                	bnez	s1,fb4 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
     fca:	8bea                	mv	s7,s10
      state = 0;
     fcc:	4981                	li	s3,0
     fce:	6d02                	ld	s10,0(sp)
     fd0:	bd09                	j	de2 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
     fd2:	008b8493          	addi	s1,s7,8
     fd6:	000bc583          	lbu	a1,0(s7)
     fda:	855a                	mv	a0,s6
     fdc:	d07ff0ef          	jal	ce2 <putc>
     fe0:	8ba6                	mv	s7,s1
      state = 0;
     fe2:	4981                	li	s3,0
     fe4:	bbfd                	j	de2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
     fe6:	008b8993          	addi	s3,s7,8
     fea:	000bb483          	ld	s1,0(s7)
     fee:	cc91                	beqz	s1,100a <vprintf+0x272>
        for(; *s; s++)
     ff0:	0004c583          	lbu	a1,0(s1)
     ff4:	c195                	beqz	a1,1018 <vprintf+0x280>
          putc(fd, *s);
     ff6:	855a                	mv	a0,s6
     ff8:	cebff0ef          	jal	ce2 <putc>
        for(; *s; s++)
     ffc:	0485                	addi	s1,s1,1
     ffe:	0004c583          	lbu	a1,0(s1)
    1002:	f9f5                	bnez	a1,ff6 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
    1004:	8bce                	mv	s7,s3
      state = 0;
    1006:	4981                	li	s3,0
    1008:	bbe9                	j	de2 <vprintf+0x4a>
          s = "(null)";
    100a:	00000497          	auipc	s1,0x0
    100e:	50e48493          	addi	s1,s1,1294 # 1518 <malloc+0x3fe>
        for(; *s; s++)
    1012:	02800593          	li	a1,40
    1016:	b7c5                	j	ff6 <vprintf+0x25e>
        if((s = va_arg(ap, char*)) == 0)
    1018:	8bce                	mv	s7,s3
      state = 0;
    101a:	4981                	li	s3,0
    101c:	b3d9                	j	de2 <vprintf+0x4a>
    101e:	6906                	ld	s2,64(sp)
    1020:	79e2                	ld	s3,56(sp)
    1022:	7a42                	ld	s4,48(sp)
    1024:	7aa2                	ld	s5,40(sp)
    1026:	7b02                	ld	s6,32(sp)
    1028:	6be2                	ld	s7,24(sp)
    102a:	6c42                	ld	s8,16(sp)
    102c:	6ca2                	ld	s9,8(sp)
    }
  }
}
    102e:	60e6                	ld	ra,88(sp)
    1030:	6446                	ld	s0,80(sp)
    1032:	64a6                	ld	s1,72(sp)
    1034:	6125                	addi	sp,sp,96
    1036:	8082                	ret

0000000000001038 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1038:	715d                	addi	sp,sp,-80
    103a:	ec06                	sd	ra,24(sp)
    103c:	e822                	sd	s0,16(sp)
    103e:	1000                	addi	s0,sp,32
    1040:	e010                	sd	a2,0(s0)
    1042:	e414                	sd	a3,8(s0)
    1044:	e818                	sd	a4,16(s0)
    1046:	ec1c                	sd	a5,24(s0)
    1048:	03043023          	sd	a6,32(s0)
    104c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1050:	8622                	mv	a2,s0
    1052:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    1056:	d43ff0ef          	jal	d98 <vprintf>
}
    105a:	60e2                	ld	ra,24(sp)
    105c:	6442                	ld	s0,16(sp)
    105e:	6161                	addi	sp,sp,80
    1060:	8082                	ret

0000000000001062 <printf>:

void
printf(const char *fmt, ...)
{
    1062:	711d                	addi	sp,sp,-96
    1064:	ec06                	sd	ra,24(sp)
    1066:	e822                	sd	s0,16(sp)
    1068:	1000                	addi	s0,sp,32
    106a:	e40c                	sd	a1,8(s0)
    106c:	e810                	sd	a2,16(s0)
    106e:	ec14                	sd	a3,24(s0)
    1070:	f018                	sd	a4,32(s0)
    1072:	f41c                	sd	a5,40(s0)
    1074:	03043823          	sd	a6,48(s0)
    1078:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    107c:	00840613          	addi	a2,s0,8
    1080:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1084:	85aa                	mv	a1,a0
    1086:	4505                	li	a0,1
    1088:	d11ff0ef          	jal	d98 <vprintf>
}
    108c:	60e2                	ld	ra,24(sp)
    108e:	6442                	ld	s0,16(sp)
    1090:	6125                	addi	sp,sp,96
    1092:	8082                	ret

0000000000001094 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1094:	1141                	addi	sp,sp,-16
    1096:	e406                	sd	ra,8(sp)
    1098:	e022                	sd	s0,0(sp)
    109a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    109c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10a0:	00001797          	auipc	a5,0x1
    10a4:	f707b783          	ld	a5,-144(a5) # 2010 <freep>
    10a8:	a02d                	j	10d2 <free+0x3e>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    10aa:	4618                	lw	a4,8(a2)
    10ac:	9f2d                	addw	a4,a4,a1
    10ae:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    10b2:	6398                	ld	a4,0(a5)
    10b4:	6310                	ld	a2,0(a4)
    10b6:	a83d                	j	10f4 <free+0x60>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    10b8:	ff852703          	lw	a4,-8(a0)
    10bc:	9f31                	addw	a4,a4,a2
    10be:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    10c0:	ff053683          	ld	a3,-16(a0)
    10c4:	a091                	j	1108 <free+0x74>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10c6:	6398                	ld	a4,0(a5)
    10c8:	00e7e463          	bltu	a5,a4,10d0 <free+0x3c>
    10cc:	00e6ea63          	bltu	a3,a4,10e0 <free+0x4c>
{
    10d0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10d2:	fed7fae3          	bgeu	a5,a3,10c6 <free+0x32>
    10d6:	6398                	ld	a4,0(a5)
    10d8:	00e6e463          	bltu	a3,a4,10e0 <free+0x4c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10dc:	fee7eae3          	bltu	a5,a4,10d0 <free+0x3c>
  if(bp + bp->s.size == p->s.ptr){
    10e0:	ff852583          	lw	a1,-8(a0)
    10e4:	6390                	ld	a2,0(a5)
    10e6:	02059813          	slli	a6,a1,0x20
    10ea:	01c85713          	srli	a4,a6,0x1c
    10ee:	9736                	add	a4,a4,a3
    10f0:	fae60de3          	beq	a2,a4,10aa <free+0x16>
    bp->s.ptr = p->s.ptr->s.ptr;
    10f4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    10f8:	4790                	lw	a2,8(a5)
    10fa:	02061593          	slli	a1,a2,0x20
    10fe:	01c5d713          	srli	a4,a1,0x1c
    1102:	973e                	add	a4,a4,a5
    1104:	fae68ae3          	beq	a3,a4,10b8 <free+0x24>
    p->s.ptr = bp->s.ptr;
    1108:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    110a:	00001717          	auipc	a4,0x1
    110e:	f0f73323          	sd	a5,-250(a4) # 2010 <freep>
}
    1112:	60a2                	ld	ra,8(sp)
    1114:	6402                	ld	s0,0(sp)
    1116:	0141                	addi	sp,sp,16
    1118:	8082                	ret

000000000000111a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    111a:	7139                	addi	sp,sp,-64
    111c:	fc06                	sd	ra,56(sp)
    111e:	f822                	sd	s0,48(sp)
    1120:	f04a                	sd	s2,32(sp)
    1122:	ec4e                	sd	s3,24(sp)
    1124:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1126:	02051993          	slli	s3,a0,0x20
    112a:	0209d993          	srli	s3,s3,0x20
    112e:	09bd                	addi	s3,s3,15
    1130:	0049d993          	srli	s3,s3,0x4
    1134:	2985                	addiw	s3,s3,1
    1136:	894e                	mv	s2,s3
  if((prevp = freep) == 0){
    1138:	00001517          	auipc	a0,0x1
    113c:	ed853503          	ld	a0,-296(a0) # 2010 <freep>
    1140:	c905                	beqz	a0,1170 <malloc+0x56>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1142:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    1144:	4798                	lw	a4,8(a5)
    1146:	09377663          	bgeu	a4,s3,11d2 <malloc+0xb8>
    114a:	f426                	sd	s1,40(sp)
    114c:	e852                	sd	s4,16(sp)
    114e:	e456                	sd	s5,8(sp)
    1150:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
    1152:	8a4e                	mv	s4,s3
    1154:	6705                	lui	a4,0x1
    1156:	00e9f363          	bgeu	s3,a4,115c <malloc+0x42>
    115a:	6a05                	lui	s4,0x1
    115c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1160:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1164:	00001497          	auipc	s1,0x1
    1168:	eac48493          	addi	s1,s1,-340 # 2010 <freep>
  if(p == SBRK_ERROR)
    116c:	5afd                	li	s5,-1
    116e:	a83d                	j	11ac <malloc+0x92>
    1170:	f426                	sd	s1,40(sp)
    1172:	e852                	sd	s4,16(sp)
    1174:	e456                	sd	s5,8(sp)
    1176:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
    1178:	00001797          	auipc	a5,0x1
    117c:	29078793          	addi	a5,a5,656 # 2408 <base>
    1180:	00001717          	auipc	a4,0x1
    1184:	e8f73823          	sd	a5,-368(a4) # 2010 <freep>
    1188:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    118a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    118e:	b7d1                	j	1152 <malloc+0x38>
        prevp->s.ptr = p->s.ptr;
    1190:	6398                	ld	a4,0(a5)
    1192:	e118                	sd	a4,0(a0)
    1194:	a899                	j	11ea <malloc+0xd0>
  hp->s.size = nu;
    1196:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    119a:	0541                	addi	a0,a0,16
    119c:	ef9ff0ef          	jal	1094 <free>
  return freep;
    11a0:	6088                	ld	a0,0(s1)
      if((p = morecore(nunits)) == 0)
    11a2:	c125                	beqz	a0,1202 <malloc+0xe8>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    11a4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    11a6:	4798                	lw	a4,8(a5)
    11a8:	03277163          	bgeu	a4,s2,11ca <malloc+0xb0>
    if(p == freep)
    11ac:	6098                	ld	a4,0(s1)
    11ae:	853e                	mv	a0,a5
    11b0:	fef71ae3          	bne	a4,a5,11a4 <malloc+0x8a>
  p = sbrk(nu * sizeof(Header));
    11b4:	8552                	mv	a0,s4
    11b6:	a59ff0ef          	jal	c0e <sbrk>
  if(p == SBRK_ERROR)
    11ba:	fd551ee3          	bne	a0,s5,1196 <malloc+0x7c>
        return 0;
    11be:	4501                	li	a0,0
    11c0:	74a2                	ld	s1,40(sp)
    11c2:	6a42                	ld	s4,16(sp)
    11c4:	6aa2                	ld	s5,8(sp)
    11c6:	6b02                	ld	s6,0(sp)
    11c8:	a03d                	j	11f6 <malloc+0xdc>
    11ca:	74a2                	ld	s1,40(sp)
    11cc:	6a42                	ld	s4,16(sp)
    11ce:	6aa2                	ld	s5,8(sp)
    11d0:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
    11d2:	fae90fe3          	beq	s2,a4,1190 <malloc+0x76>
        p->s.size -= nunits;
    11d6:	4137073b          	subw	a4,a4,s3
    11da:	c798                	sw	a4,8(a5)
        p += p->s.size;
    11dc:	02071693          	slli	a3,a4,0x20
    11e0:	01c6d713          	srli	a4,a3,0x1c
    11e4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    11e6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    11ea:	00001717          	auipc	a4,0x1
    11ee:	e2a73323          	sd	a0,-474(a4) # 2010 <freep>
      return (void*)(p + 1);
    11f2:	01078513          	addi	a0,a5,16
  }
}
    11f6:	70e2                	ld	ra,56(sp)
    11f8:	7442                	ld	s0,48(sp)
    11fa:	7902                	ld	s2,32(sp)
    11fc:	69e2                	ld	s3,24(sp)
    11fe:	6121                	addi	sp,sp,64
    1200:	8082                	ret
    1202:	74a2                	ld	s1,40(sp)
    1204:	6a42                	ld	s4,16(sp)
    1206:	6aa2                	ld	s5,8(sp)
    1208:	6b02                	ld	s6,0(sp)
    120a:	b7f5                	j	11f6 <malloc+0xdc>
