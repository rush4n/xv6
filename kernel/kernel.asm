
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
_entry:
        # set up a stack for C.
        # stack0 is declared in start.c,
        # with a 4096-byte stack per CPU.
        # sp = stack0 + ((hartid + 1) * 4096)
        la sp, stack0
    80000000:	0000a117          	auipc	sp,0xa
    80000004:	1f813103          	ld	sp,504(sp) # 8000a1f8 <_GLOBAL_OFFSET_TABLE_+0x8>
        li a0, 1024*4
    80000008:	6505                	lui	a0,0x1
        csrr a1, mhartid
    8000000a:	f14025f3          	csrr	a1,mhartid
        addi a1, a1, 1
    8000000e:	0585                	addi	a1,a1,1
        mul a0, a0, a1
    80000010:	02b50533          	mul	a0,a0,a1
        add sp, sp, a0
    80000014:	912a                	add	sp,sp,a0
        # jump to start() in start.c
        call start
    80000016:	617040ef          	jal	80004e2c <start>

000000008000001a <spin>:
spin:
        j spin
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	e7a9                	bnez	a5,80000076 <kfree+0x5a>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00023797          	auipc	a5,0x23
    80000034:	51878793          	addi	a5,a5,1304 # 80023548 <end>
    80000038:	02f56f63          	bltu	a0,a5,80000076 <kfree+0x5a>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	02f57b63          	bgeu	a0,a5,80000076 <kfree+0x5a>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	106000ef          	jal	8000014e <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    8000004c:	0000a917          	auipc	s2,0xa
    80000050:	1f490913          	addi	s2,s2,500 # 8000a240 <kmem>
    80000054:	854a                	mv	a0,s2
    80000056:	00d050ef          	jal	80005862 <acquire>
  r->next = kmem.freelist;
    8000005a:	01893783          	ld	a5,24(s2)
    8000005e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000060:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000064:	854a                	mv	a0,s2
    80000066:	091050ef          	jal	800058f6 <release>
}
    8000006a:	60e2                	ld	ra,24(sp)
    8000006c:	6442                	ld	s0,16(sp)
    8000006e:	64a2                	ld	s1,8(sp)
    80000070:	6902                	ld	s2,0(sp)
    80000072:	6105                	addi	sp,sp,32
    80000074:	8082                	ret
    panic("kfree");
    80000076:	00007517          	auipc	a0,0x7
    8000007a:	f8a50513          	addi	a0,a0,-118 # 80007000 <etext>
    8000007e:	528050ef          	jal	800055a6 <panic>

0000000080000082 <freerange>:
{
    80000082:	7179                	addi	sp,sp,-48
    80000084:	f406                	sd	ra,40(sp)
    80000086:	f022                	sd	s0,32(sp)
    80000088:	ec26                	sd	s1,24(sp)
    8000008a:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    8000008c:	6785                	lui	a5,0x1
    8000008e:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    80000092:	00e504b3          	add	s1,a0,a4
    80000096:	777d                	lui	a4,0xfffff
    80000098:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    8000009a:	94be                	add	s1,s1,a5
    8000009c:	0295e263          	bltu	a1,s1,800000c0 <freerange+0x3e>
    800000a0:	e84a                	sd	s2,16(sp)
    800000a2:	e44e                	sd	s3,8(sp)
    800000a4:	e052                	sd	s4,0(sp)
    800000a6:	892e                	mv	s2,a1
    kfree(p);
    800000a8:	8a3a                	mv	s4,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000aa:	89be                	mv	s3,a5
    kfree(p);
    800000ac:	01448533          	add	a0,s1,s4
    800000b0:	f6dff0ef          	jal	8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b4:	94ce                	add	s1,s1,s3
    800000b6:	fe997be3          	bgeu	s2,s1,800000ac <freerange+0x2a>
    800000ba:	6942                	ld	s2,16(sp)
    800000bc:	69a2                	ld	s3,8(sp)
    800000be:	6a02                	ld	s4,0(sp)
}
    800000c0:	70a2                	ld	ra,40(sp)
    800000c2:	7402                	ld	s0,32(sp)
    800000c4:	64e2                	ld	s1,24(sp)
    800000c6:	6145                	addi	sp,sp,48
    800000c8:	8082                	ret

00000000800000ca <kinit>:
{
    800000ca:	1141                	addi	sp,sp,-16
    800000cc:	e406                	sd	ra,8(sp)
    800000ce:	e022                	sd	s0,0(sp)
    800000d0:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000d2:	00007597          	auipc	a1,0x7
    800000d6:	f3e58593          	addi	a1,a1,-194 # 80007010 <etext+0x10>
    800000da:	0000a517          	auipc	a0,0xa
    800000de:	16650513          	addi	a0,a0,358 # 8000a240 <kmem>
    800000e2:	6fc050ef          	jal	800057de <initlock>
  freerange(end, (void*)PHYSTOP);
    800000e6:	45c5                	li	a1,17
    800000e8:	05ee                	slli	a1,a1,0x1b
    800000ea:	00023517          	auipc	a0,0x23
    800000ee:	45e50513          	addi	a0,a0,1118 # 80023548 <end>
    800000f2:	f91ff0ef          	jal	80000082 <freerange>
}
    800000f6:	60a2                	ld	ra,8(sp)
    800000f8:	6402                	ld	s0,0(sp)
    800000fa:	0141                	addi	sp,sp,16
    800000fc:	8082                	ret

00000000800000fe <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    800000fe:	1101                	addi	sp,sp,-32
    80000100:	ec06                	sd	ra,24(sp)
    80000102:	e822                	sd	s0,16(sp)
    80000104:	e426                	sd	s1,8(sp)
    80000106:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000108:	0000a497          	auipc	s1,0xa
    8000010c:	13848493          	addi	s1,s1,312 # 8000a240 <kmem>
    80000110:	8526                	mv	a0,s1
    80000112:	750050ef          	jal	80005862 <acquire>
  r = kmem.freelist;
    80000116:	6c84                	ld	s1,24(s1)
  if(r)
    80000118:	c485                	beqz	s1,80000140 <kalloc+0x42>
    kmem.freelist = r->next;
    8000011a:	609c                	ld	a5,0(s1)
    8000011c:	0000a517          	auipc	a0,0xa
    80000120:	12450513          	addi	a0,a0,292 # 8000a240 <kmem>
    80000124:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000126:	7d0050ef          	jal	800058f6 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000012a:	6605                	lui	a2,0x1
    8000012c:	4595                	li	a1,5
    8000012e:	8526                	mv	a0,s1
    80000130:	01e000ef          	jal	8000014e <memset>
  return (void*)r;
}
    80000134:	8526                	mv	a0,s1
    80000136:	60e2                	ld	ra,24(sp)
    80000138:	6442                	ld	s0,16(sp)
    8000013a:	64a2                	ld	s1,8(sp)
    8000013c:	6105                	addi	sp,sp,32
    8000013e:	8082                	ret
  release(&kmem.lock);
    80000140:	0000a517          	auipc	a0,0xa
    80000144:	10050513          	addi	a0,a0,256 # 8000a240 <kmem>
    80000148:	7ae050ef          	jal	800058f6 <release>
  if(r)
    8000014c:	b7e5                	j	80000134 <kalloc+0x36>

000000008000014e <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    8000014e:	1141                	addi	sp,sp,-16
    80000150:	e406                	sd	ra,8(sp)
    80000152:	e022                	sd	s0,0(sp)
    80000154:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000156:	ca19                	beqz	a2,8000016c <memset+0x1e>
    80000158:	87aa                	mv	a5,a0
    8000015a:	1602                	slli	a2,a2,0x20
    8000015c:	9201                	srli	a2,a2,0x20
    8000015e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000162:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000166:	0785                	addi	a5,a5,1
    80000168:	fee79de3          	bne	a5,a4,80000162 <memset+0x14>
  }
  return dst;
}
    8000016c:	60a2                	ld	ra,8(sp)
    8000016e:	6402                	ld	s0,0(sp)
    80000170:	0141                	addi	sp,sp,16
    80000172:	8082                	ret

0000000080000174 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000174:	1141                	addi	sp,sp,-16
    80000176:	e406                	sd	ra,8(sp)
    80000178:	e022                	sd	s0,0(sp)
    8000017a:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    8000017c:	ca0d                	beqz	a2,800001ae <memcmp+0x3a>
    8000017e:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    80000182:	1682                	slli	a3,a3,0x20
    80000184:	9281                	srli	a3,a3,0x20
    80000186:	0685                	addi	a3,a3,1
    80000188:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    8000018a:	00054783          	lbu	a5,0(a0)
    8000018e:	0005c703          	lbu	a4,0(a1)
    80000192:	00e79863          	bne	a5,a4,800001a2 <memcmp+0x2e>
      return *s1 - *s2;
    s1++, s2++;
    80000196:	0505                	addi	a0,a0,1
    80000198:	0585                	addi	a1,a1,1
  while(n-- > 0){
    8000019a:	fed518e3          	bne	a0,a3,8000018a <memcmp+0x16>
  }

  return 0;
    8000019e:	4501                	li	a0,0
    800001a0:	a019                	j	800001a6 <memcmp+0x32>
      return *s1 - *s2;
    800001a2:	40e7853b          	subw	a0,a5,a4
}
    800001a6:	60a2                	ld	ra,8(sp)
    800001a8:	6402                	ld	s0,0(sp)
    800001aa:	0141                	addi	sp,sp,16
    800001ac:	8082                	ret
  return 0;
    800001ae:	4501                	li	a0,0
    800001b0:	bfdd                	j	800001a6 <memcmp+0x32>

00000000800001b2 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001b2:	1141                	addi	sp,sp,-16
    800001b4:	e406                	sd	ra,8(sp)
    800001b6:	e022                	sd	s0,0(sp)
    800001b8:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001ba:	c205                	beqz	a2,800001da <memmove+0x28>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001bc:	02a5e363          	bltu	a1,a0,800001e2 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001c0:	1602                	slli	a2,a2,0x20
    800001c2:	9201                	srli	a2,a2,0x20
    800001c4:	00c587b3          	add	a5,a1,a2
{
    800001c8:	872a                	mv	a4,a0
      *d++ = *s++;
    800001ca:	0585                	addi	a1,a1,1
    800001cc:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffdbab9>
    800001ce:	fff5c683          	lbu	a3,-1(a1)
    800001d2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    800001d6:	feb79ae3          	bne	a5,a1,800001ca <memmove+0x18>

  return dst;
}
    800001da:	60a2                	ld	ra,8(sp)
    800001dc:	6402                	ld	s0,0(sp)
    800001de:	0141                	addi	sp,sp,16
    800001e0:	8082                	ret
  if(s < d && s + n > d){
    800001e2:	02061693          	slli	a3,a2,0x20
    800001e6:	9281                	srli	a3,a3,0x20
    800001e8:	00d58733          	add	a4,a1,a3
    800001ec:	fce57ae3          	bgeu	a0,a4,800001c0 <memmove+0xe>
    d += n;
    800001f0:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    800001f2:	fff6079b          	addiw	a5,a2,-1
    800001f6:	1782                	slli	a5,a5,0x20
    800001f8:	9381                	srli	a5,a5,0x20
    800001fa:	fff7c793          	not	a5,a5
    800001fe:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000200:	177d                	addi	a4,a4,-1
    80000202:	16fd                	addi	a3,a3,-1
    80000204:	00074603          	lbu	a2,0(a4)
    80000208:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    8000020c:	fee79ae3          	bne	a5,a4,80000200 <memmove+0x4e>
    80000210:	b7e9                	j	800001da <memmove+0x28>

0000000080000212 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000212:	1141                	addi	sp,sp,-16
    80000214:	e406                	sd	ra,8(sp)
    80000216:	e022                	sd	s0,0(sp)
    80000218:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000021a:	f99ff0ef          	jal	800001b2 <memmove>
}
    8000021e:	60a2                	ld	ra,8(sp)
    80000220:	6402                	ld	s0,0(sp)
    80000222:	0141                	addi	sp,sp,16
    80000224:	8082                	ret

0000000080000226 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000226:	1141                	addi	sp,sp,-16
    80000228:	e406                	sd	ra,8(sp)
    8000022a:	e022                	sd	s0,0(sp)
    8000022c:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    8000022e:	ce11                	beqz	a2,8000024a <strncmp+0x24>
    80000230:	00054783          	lbu	a5,0(a0)
    80000234:	cf89                	beqz	a5,8000024e <strncmp+0x28>
    80000236:	0005c703          	lbu	a4,0(a1)
    8000023a:	00f71a63          	bne	a4,a5,8000024e <strncmp+0x28>
    n--, p++, q++;
    8000023e:	367d                	addiw	a2,a2,-1
    80000240:	0505                	addi	a0,a0,1
    80000242:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000244:	f675                	bnez	a2,80000230 <strncmp+0xa>
  if(n == 0)
    return 0;
    80000246:	4501                	li	a0,0
    80000248:	a801                	j	80000258 <strncmp+0x32>
    8000024a:	4501                	li	a0,0
    8000024c:	a031                	j	80000258 <strncmp+0x32>
  return (uchar)*p - (uchar)*q;
    8000024e:	00054503          	lbu	a0,0(a0)
    80000252:	0005c783          	lbu	a5,0(a1)
    80000256:	9d1d                	subw	a0,a0,a5
}
    80000258:	60a2                	ld	ra,8(sp)
    8000025a:	6402                	ld	s0,0(sp)
    8000025c:	0141                	addi	sp,sp,16
    8000025e:	8082                	ret

0000000080000260 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000260:	1141                	addi	sp,sp,-16
    80000262:	e406                	sd	ra,8(sp)
    80000264:	e022                	sd	s0,0(sp)
    80000266:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000268:	87aa                	mv	a5,a0
    8000026a:	86b2                	mv	a3,a2
    8000026c:	367d                	addiw	a2,a2,-1
    8000026e:	02d05563          	blez	a3,80000298 <strncpy+0x38>
    80000272:	0785                	addi	a5,a5,1
    80000274:	0005c703          	lbu	a4,0(a1)
    80000278:	fee78fa3          	sb	a4,-1(a5)
    8000027c:	0585                	addi	a1,a1,1
    8000027e:	f775                	bnez	a4,8000026a <strncpy+0xa>
    ;
  while(n-- > 0)
    80000280:	873e                	mv	a4,a5
    80000282:	00c05b63          	blez	a2,80000298 <strncpy+0x38>
    80000286:	9fb5                	addw	a5,a5,a3
    80000288:	37fd                	addiw	a5,a5,-1
    *s++ = 0;
    8000028a:	0705                	addi	a4,a4,1
    8000028c:	fe070fa3          	sb	zero,-1(a4)
  while(n-- > 0)
    80000290:	40e786bb          	subw	a3,a5,a4
    80000294:	fed04be3          	bgtz	a3,8000028a <strncpy+0x2a>
  return os;
}
    80000298:	60a2                	ld	ra,8(sp)
    8000029a:	6402                	ld	s0,0(sp)
    8000029c:	0141                	addi	sp,sp,16
    8000029e:	8082                	ret

00000000800002a0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002a0:	1141                	addi	sp,sp,-16
    800002a2:	e406                	sd	ra,8(sp)
    800002a4:	e022                	sd	s0,0(sp)
    800002a6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002a8:	02c05363          	blez	a2,800002ce <safestrcpy+0x2e>
    800002ac:	fff6069b          	addiw	a3,a2,-1
    800002b0:	1682                	slli	a3,a3,0x20
    800002b2:	9281                	srli	a3,a3,0x20
    800002b4:	96ae                	add	a3,a3,a1
    800002b6:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002b8:	00d58963          	beq	a1,a3,800002ca <safestrcpy+0x2a>
    800002bc:	0585                	addi	a1,a1,1
    800002be:	0785                	addi	a5,a5,1
    800002c0:	fff5c703          	lbu	a4,-1(a1)
    800002c4:	fee78fa3          	sb	a4,-1(a5)
    800002c8:	fb65                	bnez	a4,800002b8 <safestrcpy+0x18>
    ;
  *s = 0;
    800002ca:	00078023          	sb	zero,0(a5)
  return os;
}
    800002ce:	60a2                	ld	ra,8(sp)
    800002d0:	6402                	ld	s0,0(sp)
    800002d2:	0141                	addi	sp,sp,16
    800002d4:	8082                	ret

00000000800002d6 <strlen>:

int
strlen(const char *s)
{
    800002d6:	1141                	addi	sp,sp,-16
    800002d8:	e406                	sd	ra,8(sp)
    800002da:	e022                	sd	s0,0(sp)
    800002dc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002de:	00054783          	lbu	a5,0(a0)
    800002e2:	cf99                	beqz	a5,80000300 <strlen+0x2a>
    800002e4:	0505                	addi	a0,a0,1
    800002e6:	87aa                	mv	a5,a0
    800002e8:	86be                	mv	a3,a5
    800002ea:	0785                	addi	a5,a5,1
    800002ec:	fff7c703          	lbu	a4,-1(a5)
    800002f0:	ff65                	bnez	a4,800002e8 <strlen+0x12>
    800002f2:	40a6853b          	subw	a0,a3,a0
    800002f6:	2505                	addiw	a0,a0,1
    ;
  return n;
}
    800002f8:	60a2                	ld	ra,8(sp)
    800002fa:	6402                	ld	s0,0(sp)
    800002fc:	0141                	addi	sp,sp,16
    800002fe:	8082                	ret
  for(n = 0; s[n]; n++)
    80000300:	4501                	li	a0,0
    80000302:	bfdd                	j	800002f8 <strlen+0x22>

0000000080000304 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000304:	1141                	addi	sp,sp,-16
    80000306:	e406                	sd	ra,8(sp)
    80000308:	e022                	sd	s0,0(sp)
    8000030a:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000030c:	231000ef          	jal	80000d3c <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000310:	0000a717          	auipc	a4,0xa
    80000314:	f0070713          	addi	a4,a4,-256 # 8000a210 <started>
  if(cpuid() == 0){
    80000318:	c51d                	beqz	a0,80000346 <main+0x42>
    while(started == 0)
    8000031a:	431c                	lw	a5,0(a4)
    8000031c:	2781                	sext.w	a5,a5
    8000031e:	dff5                	beqz	a5,8000031a <main+0x16>
      ;
    __sync_synchronize();
    80000320:	0330000f          	fence	rw,rw
    printf("hart %d starting\n", cpuid());
    80000324:	219000ef          	jal	80000d3c <cpuid>
    80000328:	85aa                	mv	a1,a0
    8000032a:	00007517          	auipc	a0,0x7
    8000032e:	d0e50513          	addi	a0,a0,-754 # 80007038 <etext+0x38>
    80000332:	791040ef          	jal	800052c2 <printf>
    kvminithart();    // turn on paging
    80000336:	080000ef          	jal	800003b6 <kvminithart>
    trapinithart();   // install kernel trap vector
    8000033a:	54a010ef          	jal	80001884 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    8000033e:	53a040ef          	jal	80004878 <plicinithart>
  }

  scheduler();        
    80000342:	68f000ef          	jal	800011d0 <scheduler>
    consoleinit();
    80000346:	6af040ef          	jal	800051f4 <consoleinit>
    printfinit();
    8000034a:	298050ef          	jal	800055e2 <printfinit>
    printf("\n");
    8000034e:	00007517          	auipc	a0,0x7
    80000352:	cca50513          	addi	a0,a0,-822 # 80007018 <etext+0x18>
    80000356:	76d040ef          	jal	800052c2 <printf>
    printf("xv6 kernel is booting\n");
    8000035a:	00007517          	auipc	a0,0x7
    8000035e:	cc650513          	addi	a0,a0,-826 # 80007020 <etext+0x20>
    80000362:	761040ef          	jal	800052c2 <printf>
    printf("\n");
    80000366:	00007517          	auipc	a0,0x7
    8000036a:	cb250513          	addi	a0,a0,-846 # 80007018 <etext+0x18>
    8000036e:	755040ef          	jal	800052c2 <printf>
    kinit();         // physical page allocator
    80000372:	d59ff0ef          	jal	800000ca <kinit>
    kvminit();       // create kernel page table
    80000376:	2ce000ef          	jal	80000644 <kvminit>
    kvminithart();   // turn on paging
    8000037a:	03c000ef          	jal	800003b6 <kvminithart>
    procinit();      // process table
    8000037e:	10f000ef          	jal	80000c8c <procinit>
    trapinit();      // trap vectors
    80000382:	4de010ef          	jal	80001860 <trapinit>
    trapinithart();  // install kernel trap vector
    80000386:	4fe010ef          	jal	80001884 <trapinithart>
    plicinit();      // set up interrupt controller
    8000038a:	4d4040ef          	jal	8000485e <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    8000038e:	4ea040ef          	jal	80004878 <plicinithart>
    binit();         // buffer cache
    80000392:	375010ef          	jal	80001f06 <binit>
    iinit();         // inode table
    80000396:	0d4020ef          	jal	8000246a <iinit>
    fileinit();      // file table
    8000039a:	7e7020ef          	jal	80003380 <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000039e:	5ca040ef          	jal	80004968 <virtio_disk_init>
    userinit();      // first user process
    800003a2:	495000ef          	jal	80001036 <userinit>
    __sync_synchronize();
    800003a6:	0330000f          	fence	rw,rw
    started = 1;
    800003aa:	4785                	li	a5,1
    800003ac:	0000a717          	auipc	a4,0xa
    800003b0:	e6f72223          	sw	a5,-412(a4) # 8000a210 <started>
    800003b4:	b779                	j	80000342 <main+0x3e>

00000000800003b6 <kvminithart>:

// Switch the current CPU's h/w page table register to
// the kernel's page table, and enable paging.
void
kvminithart()
{
    800003b6:	1141                	addi	sp,sp,-16
    800003b8:	e406                	sd	ra,8(sp)
    800003ba:	e022                	sd	s0,0(sp)
    800003bc:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    800003be:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    800003c2:	0000a797          	auipc	a5,0xa
    800003c6:	e567b783          	ld	a5,-426(a5) # 8000a218 <kernel_pagetable>
    800003ca:	83b1                	srli	a5,a5,0xc
    800003cc:	577d                	li	a4,-1
    800003ce:	177e                	slli	a4,a4,0x3f
    800003d0:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    800003d2:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    800003d6:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    800003da:	60a2                	ld	ra,8(sp)
    800003dc:	6402                	ld	s0,0(sp)
    800003de:	0141                	addi	sp,sp,16
    800003e0:	8082                	ret

00000000800003e2 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    800003e2:	7139                	addi	sp,sp,-64
    800003e4:	fc06                	sd	ra,56(sp)
    800003e6:	f822                	sd	s0,48(sp)
    800003e8:	f426                	sd	s1,40(sp)
    800003ea:	f04a                	sd	s2,32(sp)
    800003ec:	ec4e                	sd	s3,24(sp)
    800003ee:	e852                	sd	s4,16(sp)
    800003f0:	e456                	sd	s5,8(sp)
    800003f2:	e05a                	sd	s6,0(sp)
    800003f4:	0080                	addi	s0,sp,64
    800003f6:	84aa                	mv	s1,a0
    800003f8:	89ae                	mv	s3,a1
    800003fa:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    800003fc:	57fd                	li	a5,-1
    800003fe:	83e9                	srli	a5,a5,0x1a
    80000400:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000402:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000404:	04b7e263          	bltu	a5,a1,80000448 <walk+0x66>
    pte_t *pte = &pagetable[PX(level, va)];
    80000408:	0149d933          	srl	s2,s3,s4
    8000040c:	1ff97913          	andi	s2,s2,511
    80000410:	090e                	slli	s2,s2,0x3
    80000412:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80000414:	00093483          	ld	s1,0(s2)
    80000418:	0014f793          	andi	a5,s1,1
    8000041c:	cf85                	beqz	a5,80000454 <walk+0x72>
      pagetable = (pagetable_t)PTE2PA(*pte);
    8000041e:	80a9                	srli	s1,s1,0xa
    80000420:	04b2                	slli	s1,s1,0xc
  for(int level = 2; level > 0; level--) {
    80000422:	3a5d                	addiw	s4,s4,-9
    80000424:	ff6a12e3          	bne	s4,s6,80000408 <walk+0x26>
        return 0;
      memset(pagetable, 0, PGSIZE);
      *pte = PA2PTE(pagetable) | PTE_V;
    }
  }
  return &pagetable[PX(0, va)];
    80000428:	00c9d513          	srli	a0,s3,0xc
    8000042c:	1ff57513          	andi	a0,a0,511
    80000430:	050e                	slli	a0,a0,0x3
    80000432:	9526                	add	a0,a0,s1
}
    80000434:	70e2                	ld	ra,56(sp)
    80000436:	7442                	ld	s0,48(sp)
    80000438:	74a2                	ld	s1,40(sp)
    8000043a:	7902                	ld	s2,32(sp)
    8000043c:	69e2                	ld	s3,24(sp)
    8000043e:	6a42                	ld	s4,16(sp)
    80000440:	6aa2                	ld	s5,8(sp)
    80000442:	6b02                	ld	s6,0(sp)
    80000444:	6121                	addi	sp,sp,64
    80000446:	8082                	ret
    panic("walk");
    80000448:	00007517          	auipc	a0,0x7
    8000044c:	c0850513          	addi	a0,a0,-1016 # 80007050 <etext+0x50>
    80000450:	156050ef          	jal	800055a6 <panic>
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000454:	020a8263          	beqz	s5,80000478 <walk+0x96>
    80000458:	ca7ff0ef          	jal	800000fe <kalloc>
    8000045c:	84aa                	mv	s1,a0
    8000045e:	d979                	beqz	a0,80000434 <walk+0x52>
      memset(pagetable, 0, PGSIZE);
    80000460:	6605                	lui	a2,0x1
    80000462:	4581                	li	a1,0
    80000464:	cebff0ef          	jal	8000014e <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80000468:	00c4d793          	srli	a5,s1,0xc
    8000046c:	07aa                	slli	a5,a5,0xa
    8000046e:	0017e793          	ori	a5,a5,1
    80000472:	00f93023          	sd	a5,0(s2)
    80000476:	b775                	j	80000422 <walk+0x40>
        return 0;
    80000478:	4501                	li	a0,0
    8000047a:	bf6d                	j	80000434 <walk+0x52>

000000008000047c <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000047c:	57fd                	li	a5,-1
    8000047e:	83e9                	srli	a5,a5,0x1a
    80000480:	00b7f463          	bgeu	a5,a1,80000488 <walkaddr+0xc>
    return 0;
    80000484:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000486:	8082                	ret
{
    80000488:	1141                	addi	sp,sp,-16
    8000048a:	e406                	sd	ra,8(sp)
    8000048c:	e022                	sd	s0,0(sp)
    8000048e:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000490:	4601                	li	a2,0
    80000492:	f51ff0ef          	jal	800003e2 <walk>
  if(pte == 0)
    80000496:	c105                	beqz	a0,800004b6 <walkaddr+0x3a>
  if((*pte & PTE_V) == 0)
    80000498:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000049a:	0117f693          	andi	a3,a5,17
    8000049e:	4745                	li	a4,17
    return 0;
    800004a0:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    800004a2:	00e68663          	beq	a3,a4,800004ae <walkaddr+0x32>
}
    800004a6:	60a2                	ld	ra,8(sp)
    800004a8:	6402                	ld	s0,0(sp)
    800004aa:	0141                	addi	sp,sp,16
    800004ac:	8082                	ret
  pa = PTE2PA(*pte);
    800004ae:	83a9                	srli	a5,a5,0xa
    800004b0:	00c79513          	slli	a0,a5,0xc
  return pa;
    800004b4:	bfcd                	j	800004a6 <walkaddr+0x2a>
    return 0;
    800004b6:	4501                	li	a0,0
    800004b8:	b7fd                	j	800004a6 <walkaddr+0x2a>

00000000800004ba <mappages>:
// va and size MUST be page-aligned.
// Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    800004ba:	715d                	addi	sp,sp,-80
    800004bc:	e486                	sd	ra,72(sp)
    800004be:	e0a2                	sd	s0,64(sp)
    800004c0:	fc26                	sd	s1,56(sp)
    800004c2:	f84a                	sd	s2,48(sp)
    800004c4:	f44e                	sd	s3,40(sp)
    800004c6:	f052                	sd	s4,32(sp)
    800004c8:	ec56                	sd	s5,24(sp)
    800004ca:	e85a                	sd	s6,16(sp)
    800004cc:	e45e                	sd	s7,8(sp)
    800004ce:	e062                	sd	s8,0(sp)
    800004d0:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    800004d2:	03459793          	slli	a5,a1,0x34
    800004d6:	e7b1                	bnez	a5,80000522 <mappages+0x68>
    800004d8:	8aaa                	mv	s5,a0
    800004da:	8b3a                	mv	s6,a4
    panic("mappages: va not aligned");

  if((size % PGSIZE) != 0)
    800004dc:	03461793          	slli	a5,a2,0x34
    800004e0:	e7b9                	bnez	a5,8000052e <mappages+0x74>
    panic("mappages: size not aligned");

  if(size == 0)
    800004e2:	ce21                	beqz	a2,8000053a <mappages+0x80>
    panic("mappages: size");
  
  a = va;
  last = va + size - PGSIZE;
    800004e4:	77fd                	lui	a5,0xfffff
    800004e6:	963e                	add	a2,a2,a5
    800004e8:	00b609b3          	add	s3,a2,a1
  a = va;
    800004ec:	892e                	mv	s2,a1
    800004ee:	40b68a33          	sub	s4,a3,a1
  for(;;){
    if((pte = walk(pagetable, a, 1)) == 0)
    800004f2:	4b85                	li	s7,1
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800004f4:	6c05                	lui	s8,0x1
    800004f6:	014904b3          	add	s1,s2,s4
    if((pte = walk(pagetable, a, 1)) == 0)
    800004fa:	865e                	mv	a2,s7
    800004fc:	85ca                	mv	a1,s2
    800004fe:	8556                	mv	a0,s5
    80000500:	ee3ff0ef          	jal	800003e2 <walk>
    80000504:	c539                	beqz	a0,80000552 <mappages+0x98>
    if(*pte & PTE_V)
    80000506:	611c                	ld	a5,0(a0)
    80000508:	8b85                	andi	a5,a5,1
    8000050a:	ef95                	bnez	a5,80000546 <mappages+0x8c>
    *pte = PA2PTE(pa) | perm | PTE_V;
    8000050c:	80b1                	srli	s1,s1,0xc
    8000050e:	04aa                	slli	s1,s1,0xa
    80000510:	0164e4b3          	or	s1,s1,s6
    80000514:	0014e493          	ori	s1,s1,1
    80000518:	e104                	sd	s1,0(a0)
    if(a == last)
    8000051a:	05390963          	beq	s2,s3,8000056c <mappages+0xb2>
    a += PGSIZE;
    8000051e:	9962                	add	s2,s2,s8
    if((pte = walk(pagetable, a, 1)) == 0)
    80000520:	bfd9                	j	800004f6 <mappages+0x3c>
    panic("mappages: va not aligned");
    80000522:	00007517          	auipc	a0,0x7
    80000526:	b3650513          	addi	a0,a0,-1226 # 80007058 <etext+0x58>
    8000052a:	07c050ef          	jal	800055a6 <panic>
    panic("mappages: size not aligned");
    8000052e:	00007517          	auipc	a0,0x7
    80000532:	b4a50513          	addi	a0,a0,-1206 # 80007078 <etext+0x78>
    80000536:	070050ef          	jal	800055a6 <panic>
    panic("mappages: size");
    8000053a:	00007517          	auipc	a0,0x7
    8000053e:	b5e50513          	addi	a0,a0,-1186 # 80007098 <etext+0x98>
    80000542:	064050ef          	jal	800055a6 <panic>
      panic("mappages: remap");
    80000546:	00007517          	auipc	a0,0x7
    8000054a:	b6250513          	addi	a0,a0,-1182 # 800070a8 <etext+0xa8>
    8000054e:	058050ef          	jal	800055a6 <panic>
      return -1;
    80000552:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80000554:	60a6                	ld	ra,72(sp)
    80000556:	6406                	ld	s0,64(sp)
    80000558:	74e2                	ld	s1,56(sp)
    8000055a:	7942                	ld	s2,48(sp)
    8000055c:	79a2                	ld	s3,40(sp)
    8000055e:	7a02                	ld	s4,32(sp)
    80000560:	6ae2                	ld	s5,24(sp)
    80000562:	6b42                	ld	s6,16(sp)
    80000564:	6ba2                	ld	s7,8(sp)
    80000566:	6c02                	ld	s8,0(sp)
    80000568:	6161                	addi	sp,sp,80
    8000056a:	8082                	ret
  return 0;
    8000056c:	4501                	li	a0,0
    8000056e:	b7dd                	j	80000554 <mappages+0x9a>

0000000080000570 <kvmmap>:
{
    80000570:	1141                	addi	sp,sp,-16
    80000572:	e406                	sd	ra,8(sp)
    80000574:	e022                	sd	s0,0(sp)
    80000576:	0800                	addi	s0,sp,16
    80000578:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    8000057a:	86b2                	mv	a3,a2
    8000057c:	863e                	mv	a2,a5
    8000057e:	f3dff0ef          	jal	800004ba <mappages>
    80000582:	e509                	bnez	a0,8000058c <kvmmap+0x1c>
}
    80000584:	60a2                	ld	ra,8(sp)
    80000586:	6402                	ld	s0,0(sp)
    80000588:	0141                	addi	sp,sp,16
    8000058a:	8082                	ret
    panic("kvmmap");
    8000058c:	00007517          	auipc	a0,0x7
    80000590:	b2c50513          	addi	a0,a0,-1236 # 800070b8 <etext+0xb8>
    80000594:	012050ef          	jal	800055a6 <panic>

0000000080000598 <kvmmake>:
{
    80000598:	1101                	addi	sp,sp,-32
    8000059a:	ec06                	sd	ra,24(sp)
    8000059c:	e822                	sd	s0,16(sp)
    8000059e:	e426                	sd	s1,8(sp)
    800005a0:	e04a                	sd	s2,0(sp)
    800005a2:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    800005a4:	b5bff0ef          	jal	800000fe <kalloc>
    800005a8:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    800005aa:	6605                	lui	a2,0x1
    800005ac:	4581                	li	a1,0
    800005ae:	ba1ff0ef          	jal	8000014e <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    800005b2:	4719                	li	a4,6
    800005b4:	6685                	lui	a3,0x1
    800005b6:	10000637          	lui	a2,0x10000
    800005ba:	85b2                	mv	a1,a2
    800005bc:	8526                	mv	a0,s1
    800005be:	fb3ff0ef          	jal	80000570 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    800005c2:	4719                	li	a4,6
    800005c4:	6685                	lui	a3,0x1
    800005c6:	10001637          	lui	a2,0x10001
    800005ca:	85b2                	mv	a1,a2
    800005cc:	8526                	mv	a0,s1
    800005ce:	fa3ff0ef          	jal	80000570 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x4000000, PTE_R | PTE_W);
    800005d2:	4719                	li	a4,6
    800005d4:	040006b7          	lui	a3,0x4000
    800005d8:	0c000637          	lui	a2,0xc000
    800005dc:	85b2                	mv	a1,a2
    800005de:	8526                	mv	a0,s1
    800005e0:	f91ff0ef          	jal	80000570 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800005e4:	00007917          	auipc	s2,0x7
    800005e8:	a1c90913          	addi	s2,s2,-1508 # 80007000 <etext>
    800005ec:	4729                	li	a4,10
    800005ee:	80007697          	auipc	a3,0x80007
    800005f2:	a1268693          	addi	a3,a3,-1518 # 7000 <_entry-0x7fff9000>
    800005f6:	4605                	li	a2,1
    800005f8:	067e                	slli	a2,a2,0x1f
    800005fa:	85b2                	mv	a1,a2
    800005fc:	8526                	mv	a0,s1
    800005fe:	f73ff0ef          	jal	80000570 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    80000602:	4719                	li	a4,6
    80000604:	46c5                	li	a3,17
    80000606:	06ee                	slli	a3,a3,0x1b
    80000608:	412686b3          	sub	a3,a3,s2
    8000060c:	864a                	mv	a2,s2
    8000060e:	85ca                	mv	a1,s2
    80000610:	8526                	mv	a0,s1
    80000612:	f5fff0ef          	jal	80000570 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    80000616:	4729                	li	a4,10
    80000618:	6685                	lui	a3,0x1
    8000061a:	00006617          	auipc	a2,0x6
    8000061e:	9e660613          	addi	a2,a2,-1562 # 80006000 <_trampoline>
    80000622:	040005b7          	lui	a1,0x4000
    80000626:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000628:	05b2                	slli	a1,a1,0xc
    8000062a:	8526                	mv	a0,s1
    8000062c:	f45ff0ef          	jal	80000570 <kvmmap>
  proc_mapstacks(kpgtbl);
    80000630:	8526                	mv	a0,s1
    80000632:	5bc000ef          	jal	80000bee <proc_mapstacks>
}
    80000636:	8526                	mv	a0,s1
    80000638:	60e2                	ld	ra,24(sp)
    8000063a:	6442                	ld	s0,16(sp)
    8000063c:	64a2                	ld	s1,8(sp)
    8000063e:	6902                	ld	s2,0(sp)
    80000640:	6105                	addi	sp,sp,32
    80000642:	8082                	ret

0000000080000644 <kvminit>:
{
    80000644:	1141                	addi	sp,sp,-16
    80000646:	e406                	sd	ra,8(sp)
    80000648:	e022                	sd	s0,0(sp)
    8000064a:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    8000064c:	f4dff0ef          	jal	80000598 <kvmmake>
    80000650:	0000a797          	auipc	a5,0xa
    80000654:	bca7b423          	sd	a0,-1080(a5) # 8000a218 <kernel_pagetable>
}
    80000658:	60a2                	ld	ra,8(sp)
    8000065a:	6402                	ld	s0,0(sp)
    8000065c:	0141                	addi	sp,sp,16
    8000065e:	8082                	ret

0000000080000660 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80000660:	1101                	addi	sp,sp,-32
    80000662:	ec06                	sd	ra,24(sp)
    80000664:	e822                	sd	s0,16(sp)
    80000666:	e426                	sd	s1,8(sp)
    80000668:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8000066a:	a95ff0ef          	jal	800000fe <kalloc>
    8000066e:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000670:	c509                	beqz	a0,8000067a <uvmcreate+0x1a>
    return 0;
  memset(pagetable, 0, PGSIZE);
    80000672:	6605                	lui	a2,0x1
    80000674:	4581                	li	a1,0
    80000676:	ad9ff0ef          	jal	8000014e <memset>
  return pagetable;
}
    8000067a:	8526                	mv	a0,s1
    8000067c:	60e2                	ld	ra,24(sp)
    8000067e:	6442                	ld	s0,16(sp)
    80000680:	64a2                	ld	s1,8(sp)
    80000682:	6105                	addi	sp,sp,32
    80000684:	8082                	ret

0000000080000686 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. It's OK if the mappings don't exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000686:	7139                	addi	sp,sp,-64
    80000688:	fc06                	sd	ra,56(sp)
    8000068a:	f822                	sd	s0,48(sp)
    8000068c:	0080                	addi	s0,sp,64
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000068e:	03459793          	slli	a5,a1,0x34
    80000692:	e38d                	bnez	a5,800006b4 <uvmunmap+0x2e>
    80000694:	f04a                	sd	s2,32(sp)
    80000696:	ec4e                	sd	s3,24(sp)
    80000698:	e852                	sd	s4,16(sp)
    8000069a:	e456                	sd	s5,8(sp)
    8000069c:	e05a                	sd	s6,0(sp)
    8000069e:	8a2a                	mv	s4,a0
    800006a0:	892e                	mv	s2,a1
    800006a2:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800006a4:	0632                	slli	a2,a2,0xc
    800006a6:	00b609b3          	add	s3,a2,a1
    800006aa:	6b05                	lui	s6,0x1
    800006ac:	0535f963          	bgeu	a1,s3,800006fe <uvmunmap+0x78>
    800006b0:	f426                	sd	s1,40(sp)
    800006b2:	a015                	j	800006d6 <uvmunmap+0x50>
    800006b4:	f426                	sd	s1,40(sp)
    800006b6:	f04a                	sd	s2,32(sp)
    800006b8:	ec4e                	sd	s3,24(sp)
    800006ba:	e852                	sd	s4,16(sp)
    800006bc:	e456                	sd	s5,8(sp)
    800006be:	e05a                	sd	s6,0(sp)
    panic("uvmunmap: not aligned");
    800006c0:	00007517          	auipc	a0,0x7
    800006c4:	a0050513          	addi	a0,a0,-1536 # 800070c0 <etext+0xc0>
    800006c8:	6df040ef          	jal	800055a6 <panic>
      continue;
    if(do_free){
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
    800006cc:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800006d0:	995a                	add	s2,s2,s6
    800006d2:	03397563          	bgeu	s2,s3,800006fc <uvmunmap+0x76>
    if((pte = walk(pagetable, a, 0)) == 0) // leaf page table entry allocated?
    800006d6:	4601                	li	a2,0
    800006d8:	85ca                	mv	a1,s2
    800006da:	8552                	mv	a0,s4
    800006dc:	d07ff0ef          	jal	800003e2 <walk>
    800006e0:	84aa                	mv	s1,a0
    800006e2:	d57d                	beqz	a0,800006d0 <uvmunmap+0x4a>
    if((*pte & PTE_V) == 0)  // has physical page been allocated?
    800006e4:	611c                	ld	a5,0(a0)
    800006e6:	0017f713          	andi	a4,a5,1
    800006ea:	d37d                	beqz	a4,800006d0 <uvmunmap+0x4a>
    if(do_free){
    800006ec:	fe0a80e3          	beqz	s5,800006cc <uvmunmap+0x46>
      uint64 pa = PTE2PA(*pte);
    800006f0:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    800006f2:	00c79513          	slli	a0,a5,0xc
    800006f6:	927ff0ef          	jal	8000001c <kfree>
    800006fa:	bfc9                	j	800006cc <uvmunmap+0x46>
    800006fc:	74a2                	ld	s1,40(sp)
    800006fe:	7902                	ld	s2,32(sp)
    80000700:	69e2                	ld	s3,24(sp)
    80000702:	6a42                	ld	s4,16(sp)
    80000704:	6aa2                	ld	s5,8(sp)
    80000706:	6b02                	ld	s6,0(sp)
  }
}
    80000708:	70e2                	ld	ra,56(sp)
    8000070a:	7442                	ld	s0,48(sp)
    8000070c:	6121                	addi	sp,sp,64
    8000070e:	8082                	ret

0000000080000710 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000710:	1101                	addi	sp,sp,-32
    80000712:	ec06                	sd	ra,24(sp)
    80000714:	e822                	sd	s0,16(sp)
    80000716:	e426                	sd	s1,8(sp)
    80000718:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    8000071a:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    8000071c:	00b67d63          	bgeu	a2,a1,80000736 <uvmdealloc+0x26>
    80000720:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000722:	6785                	lui	a5,0x1
    80000724:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000726:	00f60733          	add	a4,a2,a5
    8000072a:	76fd                	lui	a3,0xfffff
    8000072c:	8f75                	and	a4,a4,a3
    8000072e:	97ae                	add	a5,a5,a1
    80000730:	8ff5                	and	a5,a5,a3
    80000732:	00f76863          	bltu	a4,a5,80000742 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000736:	8526                	mv	a0,s1
    80000738:	60e2                	ld	ra,24(sp)
    8000073a:	6442                	ld	s0,16(sp)
    8000073c:	64a2                	ld	s1,8(sp)
    8000073e:	6105                	addi	sp,sp,32
    80000740:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    80000742:	8f99                	sub	a5,a5,a4
    80000744:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    80000746:	4685                	li	a3,1
    80000748:	0007861b          	sext.w	a2,a5
    8000074c:	85ba                	mv	a1,a4
    8000074e:	f39ff0ef          	jal	80000686 <uvmunmap>
    80000752:	b7d5                	j	80000736 <uvmdealloc+0x26>

0000000080000754 <uvmalloc>:
  if(newsz < oldsz)
    80000754:	0ab66363          	bltu	a2,a1,800007fa <uvmalloc+0xa6>
{
    80000758:	715d                	addi	sp,sp,-80
    8000075a:	e486                	sd	ra,72(sp)
    8000075c:	e0a2                	sd	s0,64(sp)
    8000075e:	f052                	sd	s4,32(sp)
    80000760:	ec56                	sd	s5,24(sp)
    80000762:	e85a                	sd	s6,16(sp)
    80000764:	0880                	addi	s0,sp,80
    80000766:	8b2a                	mv	s6,a0
    80000768:	8ab2                	mv	s5,a2
  oldsz = PGROUNDUP(oldsz);
    8000076a:	6785                	lui	a5,0x1
    8000076c:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000076e:	95be                	add	a1,a1,a5
    80000770:	77fd                	lui	a5,0xfffff
    80000772:	00f5fa33          	and	s4,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    80000776:	08ca7463          	bgeu	s4,a2,800007fe <uvmalloc+0xaa>
    8000077a:	fc26                	sd	s1,56(sp)
    8000077c:	f84a                	sd	s2,48(sp)
    8000077e:	f44e                	sd	s3,40(sp)
    80000780:	e45e                	sd	s7,8(sp)
    80000782:	8952                	mv	s2,s4
    memset(mem, 0, PGSIZE);
    80000784:	6985                	lui	s3,0x1
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000786:	0126eb93          	ori	s7,a3,18
    mem = kalloc();
    8000078a:	975ff0ef          	jal	800000fe <kalloc>
    8000078e:	84aa                	mv	s1,a0
    if(mem == 0){
    80000790:	c515                	beqz	a0,800007bc <uvmalloc+0x68>
    memset(mem, 0, PGSIZE);
    80000792:	864e                	mv	a2,s3
    80000794:	4581                	li	a1,0
    80000796:	9b9ff0ef          	jal	8000014e <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    8000079a:	875e                	mv	a4,s7
    8000079c:	86a6                	mv	a3,s1
    8000079e:	864e                	mv	a2,s3
    800007a0:	85ca                	mv	a1,s2
    800007a2:	855a                	mv	a0,s6
    800007a4:	d17ff0ef          	jal	800004ba <mappages>
    800007a8:	e91d                	bnez	a0,800007de <uvmalloc+0x8a>
  for(a = oldsz; a < newsz; a += PGSIZE){
    800007aa:	994e                	add	s2,s2,s3
    800007ac:	fd596fe3          	bltu	s2,s5,8000078a <uvmalloc+0x36>
  return newsz;
    800007b0:	8556                	mv	a0,s5
    800007b2:	74e2                	ld	s1,56(sp)
    800007b4:	7942                	ld	s2,48(sp)
    800007b6:	79a2                	ld	s3,40(sp)
    800007b8:	6ba2                	ld	s7,8(sp)
    800007ba:	a819                	j	800007d0 <uvmalloc+0x7c>
      uvmdealloc(pagetable, a, oldsz);
    800007bc:	8652                	mv	a2,s4
    800007be:	85ca                	mv	a1,s2
    800007c0:	855a                	mv	a0,s6
    800007c2:	f4fff0ef          	jal	80000710 <uvmdealloc>
      return 0;
    800007c6:	4501                	li	a0,0
    800007c8:	74e2                	ld	s1,56(sp)
    800007ca:	7942                	ld	s2,48(sp)
    800007cc:	79a2                	ld	s3,40(sp)
    800007ce:	6ba2                	ld	s7,8(sp)
}
    800007d0:	60a6                	ld	ra,72(sp)
    800007d2:	6406                	ld	s0,64(sp)
    800007d4:	7a02                	ld	s4,32(sp)
    800007d6:	6ae2                	ld	s5,24(sp)
    800007d8:	6b42                	ld	s6,16(sp)
    800007da:	6161                	addi	sp,sp,80
    800007dc:	8082                	ret
      kfree(mem);
    800007de:	8526                	mv	a0,s1
    800007e0:	83dff0ef          	jal	8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    800007e4:	8652                	mv	a2,s4
    800007e6:	85ca                	mv	a1,s2
    800007e8:	855a                	mv	a0,s6
    800007ea:	f27ff0ef          	jal	80000710 <uvmdealloc>
      return 0;
    800007ee:	4501                	li	a0,0
    800007f0:	74e2                	ld	s1,56(sp)
    800007f2:	7942                	ld	s2,48(sp)
    800007f4:	79a2                	ld	s3,40(sp)
    800007f6:	6ba2                	ld	s7,8(sp)
    800007f8:	bfe1                	j	800007d0 <uvmalloc+0x7c>
    return oldsz;
    800007fa:	852e                	mv	a0,a1
}
    800007fc:	8082                	ret
  return newsz;
    800007fe:	8532                	mv	a0,a2
    80000800:	bfc1                	j	800007d0 <uvmalloc+0x7c>

0000000080000802 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000802:	7179                	addi	sp,sp,-48
    80000804:	f406                	sd	ra,40(sp)
    80000806:	f022                	sd	s0,32(sp)
    80000808:	ec26                	sd	s1,24(sp)
    8000080a:	e84a                	sd	s2,16(sp)
    8000080c:	e44e                	sd	s3,8(sp)
    8000080e:	e052                	sd	s4,0(sp)
    80000810:	1800                	addi	s0,sp,48
    80000812:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000814:	84aa                	mv	s1,a0
    80000816:	6905                	lui	s2,0x1
    80000818:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    8000081a:	4985                	li	s3,1
    8000081c:	a819                	j	80000832 <freewalk+0x30>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000081e:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    80000820:	00c79513          	slli	a0,a5,0xc
    80000824:	fdfff0ef          	jal	80000802 <freewalk>
      pagetable[i] = 0;
    80000828:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000082c:	04a1                	addi	s1,s1,8
    8000082e:	01248f63          	beq	s1,s2,8000084c <freewalk+0x4a>
    pte_t pte = pagetable[i];
    80000832:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000834:	00f7f713          	andi	a4,a5,15
    80000838:	ff3703e3          	beq	a4,s3,8000081e <freewalk+0x1c>
    } else if(pte & PTE_V){
    8000083c:	8b85                	andi	a5,a5,1
    8000083e:	d7fd                	beqz	a5,8000082c <freewalk+0x2a>
      panic("freewalk: leaf");
    80000840:	00007517          	auipc	a0,0x7
    80000844:	89850513          	addi	a0,a0,-1896 # 800070d8 <etext+0xd8>
    80000848:	55f040ef          	jal	800055a6 <panic>
    }
  }
  kfree((void*)pagetable);
    8000084c:	8552                	mv	a0,s4
    8000084e:	fceff0ef          	jal	8000001c <kfree>
}
    80000852:	70a2                	ld	ra,40(sp)
    80000854:	7402                	ld	s0,32(sp)
    80000856:	64e2                	ld	s1,24(sp)
    80000858:	6942                	ld	s2,16(sp)
    8000085a:	69a2                	ld	s3,8(sp)
    8000085c:	6a02                	ld	s4,0(sp)
    8000085e:	6145                	addi	sp,sp,48
    80000860:	8082                	ret

0000000080000862 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80000862:	1101                	addi	sp,sp,-32
    80000864:	ec06                	sd	ra,24(sp)
    80000866:	e822                	sd	s0,16(sp)
    80000868:	e426                	sd	s1,8(sp)
    8000086a:	1000                	addi	s0,sp,32
    8000086c:	84aa                	mv	s1,a0
  if(sz > 0)
    8000086e:	e989                	bnez	a1,80000880 <uvmfree+0x1e>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    80000870:	8526                	mv	a0,s1
    80000872:	f91ff0ef          	jal	80000802 <freewalk>
}
    80000876:	60e2                	ld	ra,24(sp)
    80000878:	6442                	ld	s0,16(sp)
    8000087a:	64a2                	ld	s1,8(sp)
    8000087c:	6105                	addi	sp,sp,32
    8000087e:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80000880:	6785                	lui	a5,0x1
    80000882:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000884:	95be                	add	a1,a1,a5
    80000886:	4685                	li	a3,1
    80000888:	00c5d613          	srli	a2,a1,0xc
    8000088c:	4581                	li	a1,0
    8000088e:	df9ff0ef          	jal	80000686 <uvmunmap>
    80000892:	bff9                	j	80000870 <uvmfree+0xe>

0000000080000894 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000894:	ce59                	beqz	a2,80000932 <uvmcopy+0x9e>
{
    80000896:	715d                	addi	sp,sp,-80
    80000898:	e486                	sd	ra,72(sp)
    8000089a:	e0a2                	sd	s0,64(sp)
    8000089c:	fc26                	sd	s1,56(sp)
    8000089e:	f84a                	sd	s2,48(sp)
    800008a0:	f44e                	sd	s3,40(sp)
    800008a2:	f052                	sd	s4,32(sp)
    800008a4:	ec56                	sd	s5,24(sp)
    800008a6:	e85a                	sd	s6,16(sp)
    800008a8:	e45e                	sd	s7,8(sp)
    800008aa:	e062                	sd	s8,0(sp)
    800008ac:	0880                	addi	s0,sp,80
    800008ae:	8b2a                	mv	s6,a0
    800008b0:	8bae                	mv	s7,a1
    800008b2:	8ab2                	mv	s5,a2
  for(i = 0; i < sz; i += PGSIZE){
    800008b4:	4481                	li	s1,0
      continue;   // physical page hasn't been allocated
    pa = PTE2PA(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    800008b6:	6a05                	lui	s4,0x1
    800008b8:	a021                	j	800008c0 <uvmcopy+0x2c>
  for(i = 0; i < sz; i += PGSIZE){
    800008ba:	94d2                	add	s1,s1,s4
    800008bc:	0554fe63          	bgeu	s1,s5,80000918 <uvmcopy+0x84>
    if((pte = walk(old, i, 0)) == 0)
    800008c0:	4601                	li	a2,0
    800008c2:	85a6                	mv	a1,s1
    800008c4:	855a                	mv	a0,s6
    800008c6:	b1dff0ef          	jal	800003e2 <walk>
    800008ca:	d965                	beqz	a0,800008ba <uvmcopy+0x26>
    if((*pte & PTE_V) == 0)
    800008cc:	6118                	ld	a4,0(a0)
    800008ce:	00177793          	andi	a5,a4,1
    800008d2:	d7e5                	beqz	a5,800008ba <uvmcopy+0x26>
    pa = PTE2PA(*pte);
    800008d4:	00a75593          	srli	a1,a4,0xa
    800008d8:	00c59c13          	slli	s8,a1,0xc
    flags = PTE_FLAGS(*pte);
    800008dc:	3ff77913          	andi	s2,a4,1023
    if((mem = kalloc()) == 0)
    800008e0:	81fff0ef          	jal	800000fe <kalloc>
    800008e4:	89aa                	mv	s3,a0
    800008e6:	c105                	beqz	a0,80000906 <uvmcopy+0x72>
    memmove(mem, (char*)pa, PGSIZE);
    800008e8:	8652                	mv	a2,s4
    800008ea:	85e2                	mv	a1,s8
    800008ec:	8c7ff0ef          	jal	800001b2 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800008f0:	874a                	mv	a4,s2
    800008f2:	86ce                	mv	a3,s3
    800008f4:	8652                	mv	a2,s4
    800008f6:	85a6                	mv	a1,s1
    800008f8:	855e                	mv	a0,s7
    800008fa:	bc1ff0ef          	jal	800004ba <mappages>
    800008fe:	dd55                	beqz	a0,800008ba <uvmcopy+0x26>
      kfree(mem);
    80000900:	854e                	mv	a0,s3
    80000902:	f1aff0ef          	jal	8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000906:	4685                	li	a3,1
    80000908:	00c4d613          	srli	a2,s1,0xc
    8000090c:	4581                	li	a1,0
    8000090e:	855e                	mv	a0,s7
    80000910:	d77ff0ef          	jal	80000686 <uvmunmap>
  return -1;
    80000914:	557d                	li	a0,-1
    80000916:	a011                	j	8000091a <uvmcopy+0x86>
  return 0;
    80000918:	4501                	li	a0,0
}
    8000091a:	60a6                	ld	ra,72(sp)
    8000091c:	6406                	ld	s0,64(sp)
    8000091e:	74e2                	ld	s1,56(sp)
    80000920:	7942                	ld	s2,48(sp)
    80000922:	79a2                	ld	s3,40(sp)
    80000924:	7a02                	ld	s4,32(sp)
    80000926:	6ae2                	ld	s5,24(sp)
    80000928:	6b42                	ld	s6,16(sp)
    8000092a:	6ba2                	ld	s7,8(sp)
    8000092c:	6c02                	ld	s8,0(sp)
    8000092e:	6161                	addi	sp,sp,80
    80000930:	8082                	ret
  return 0;
    80000932:	4501                	li	a0,0
}
    80000934:	8082                	ret

0000000080000936 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000936:	1141                	addi	sp,sp,-16
    80000938:	e406                	sd	ra,8(sp)
    8000093a:	e022                	sd	s0,0(sp)
    8000093c:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    8000093e:	4601                	li	a2,0
    80000940:	aa3ff0ef          	jal	800003e2 <walk>
  if(pte == 0)
    80000944:	c901                	beqz	a0,80000954 <uvmclear+0x1e>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000946:	611c                	ld	a5,0(a0)
    80000948:	9bbd                	andi	a5,a5,-17
    8000094a:	e11c                	sd	a5,0(a0)
}
    8000094c:	60a2                	ld	ra,8(sp)
    8000094e:	6402                	ld	s0,0(sp)
    80000950:	0141                	addi	sp,sp,16
    80000952:	8082                	ret
    panic("uvmclear");
    80000954:	00006517          	auipc	a0,0x6
    80000958:	79450513          	addi	a0,a0,1940 # 800070e8 <etext+0xe8>
    8000095c:	44b040ef          	jal	800055a6 <panic>

0000000080000960 <copyinstr>:
// Copy bytes to dst from virtual address srcva in a given page table,
// until a '\0', or max.
// Return 0 on success, -1 on error.
int
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
    80000960:	715d                	addi	sp,sp,-80
    80000962:	e486                	sd	ra,72(sp)
    80000964:	e0a2                	sd	s0,64(sp)
    80000966:	fc26                	sd	s1,56(sp)
    80000968:	f84a                	sd	s2,48(sp)
    8000096a:	f44e                	sd	s3,40(sp)
    8000096c:	f052                	sd	s4,32(sp)
    8000096e:	ec56                	sd	s5,24(sp)
    80000970:	e85a                	sd	s6,16(sp)
    80000972:	e45e                	sd	s7,8(sp)
    80000974:	0880                	addi	s0,sp,80
    80000976:	8aaa                	mv	s5,a0
    80000978:	89ae                	mv	s3,a1
    8000097a:	8bb2                	mv	s7,a2
    8000097c:	84b6                	mv	s1,a3
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    va0 = PGROUNDDOWN(srcva);
    8000097e:	7b7d                	lui	s6,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000980:	6a05                	lui	s4,0x1
    80000982:	a02d                	j	800009ac <copyinstr+0x4c>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000984:	00078023          	sb	zero,0(a5)
    80000988:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    8000098a:	0017c793          	xori	a5,a5,1
    8000098e:	40f0053b          	negw	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000992:	60a6                	ld	ra,72(sp)
    80000994:	6406                	ld	s0,64(sp)
    80000996:	74e2                	ld	s1,56(sp)
    80000998:	7942                	ld	s2,48(sp)
    8000099a:	79a2                	ld	s3,40(sp)
    8000099c:	7a02                	ld	s4,32(sp)
    8000099e:	6ae2                	ld	s5,24(sp)
    800009a0:	6b42                	ld	s6,16(sp)
    800009a2:	6ba2                	ld	s7,8(sp)
    800009a4:	6161                	addi	sp,sp,80
    800009a6:	8082                	ret
    srcva = va0 + PGSIZE;
    800009a8:	01490bb3          	add	s7,s2,s4
  while(got_null == 0 && max > 0){
    800009ac:	c4b1                	beqz	s1,800009f8 <copyinstr+0x98>
    va0 = PGROUNDDOWN(srcva);
    800009ae:	016bf933          	and	s2,s7,s6
    pa0 = walkaddr(pagetable, va0);
    800009b2:	85ca                	mv	a1,s2
    800009b4:	8556                	mv	a0,s5
    800009b6:	ac7ff0ef          	jal	8000047c <walkaddr>
    if(pa0 == 0)
    800009ba:	c129                	beqz	a0,800009fc <copyinstr+0x9c>
    n = PGSIZE - (srcva - va0);
    800009bc:	41790633          	sub	a2,s2,s7
    800009c0:	9652                	add	a2,a2,s4
    if(n > max)
    800009c2:	00c4f363          	bgeu	s1,a2,800009c8 <copyinstr+0x68>
    800009c6:	8626                	mv	a2,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800009c8:	412b8bb3          	sub	s7,s7,s2
    800009cc:	9baa                	add	s7,s7,a0
    while(n > 0){
    800009ce:	de69                	beqz	a2,800009a8 <copyinstr+0x48>
    800009d0:	87ce                	mv	a5,s3
      if(*p == '\0'){
    800009d2:	413b86b3          	sub	a3,s7,s3
    while(n > 0){
    800009d6:	964e                	add	a2,a2,s3
    800009d8:	85be                	mv	a1,a5
      if(*p == '\0'){
    800009da:	00f68733          	add	a4,a3,a5
    800009de:	00074703          	lbu	a4,0(a4)
    800009e2:	d34d                	beqz	a4,80000984 <copyinstr+0x24>
        *dst = *p;
    800009e4:	00e78023          	sb	a4,0(a5)
      dst++;
    800009e8:	0785                	addi	a5,a5,1
    while(n > 0){
    800009ea:	fec797e3          	bne	a5,a2,800009d8 <copyinstr+0x78>
    800009ee:	14fd                	addi	s1,s1,-1
    800009f0:	94ce                	add	s1,s1,s3
      --max;
    800009f2:	8c8d                	sub	s1,s1,a1
    800009f4:	89be                	mv	s3,a5
    800009f6:	bf4d                	j	800009a8 <copyinstr+0x48>
    800009f8:	4781                	li	a5,0
    800009fa:	bf41                	j	8000098a <copyinstr+0x2a>
      return -1;
    800009fc:	557d                	li	a0,-1
    800009fe:	bf51                	j	80000992 <copyinstr+0x32>

0000000080000a00 <ismapped>:
  return mem;
}

int
ismapped(pagetable_t pagetable, uint64 va)
{
    80000a00:	1141                	addi	sp,sp,-16
    80000a02:	e406                	sd	ra,8(sp)
    80000a04:	e022                	sd	s0,0(sp)
    80000a06:	0800                	addi	s0,sp,16
  pte_t *pte = walk(pagetable, va, 0);
    80000a08:	4601                	li	a2,0
    80000a0a:	9d9ff0ef          	jal	800003e2 <walk>
  if (pte == 0) {
    80000a0e:	c519                	beqz	a0,80000a1c <ismapped+0x1c>
    return 0;
  }
  if (*pte & PTE_V){
    80000a10:	6108                	ld	a0,0(a0)
    80000a12:	8905                	andi	a0,a0,1
    return 1;
  }
  return 0;
}
    80000a14:	60a2                	ld	ra,8(sp)
    80000a16:	6402                	ld	s0,0(sp)
    80000a18:	0141                	addi	sp,sp,16
    80000a1a:	8082                	ret
    return 0;
    80000a1c:	4501                	li	a0,0
    80000a1e:	bfdd                	j	80000a14 <ismapped+0x14>

0000000080000a20 <vmfault>:
{
    80000a20:	7179                	addi	sp,sp,-48
    80000a22:	f406                	sd	ra,40(sp)
    80000a24:	f022                	sd	s0,32(sp)
    80000a26:	ec26                	sd	s1,24(sp)
    80000a28:	e44e                	sd	s3,8(sp)
    80000a2a:	1800                	addi	s0,sp,48
    80000a2c:	89aa                	mv	s3,a0
    80000a2e:	84ae                	mv	s1,a1
  struct proc *p = myproc();
    80000a30:	340000ef          	jal	80000d70 <myproc>
  if (va >= p->sz)
    80000a34:	653c                	ld	a5,72(a0)
    80000a36:	00f4ea63          	bltu	s1,a5,80000a4a <vmfault+0x2a>
    return 0;
    80000a3a:	4981                	li	s3,0
}
    80000a3c:	854e                	mv	a0,s3
    80000a3e:	70a2                	ld	ra,40(sp)
    80000a40:	7402                	ld	s0,32(sp)
    80000a42:	64e2                	ld	s1,24(sp)
    80000a44:	69a2                	ld	s3,8(sp)
    80000a46:	6145                	addi	sp,sp,48
    80000a48:	8082                	ret
    80000a4a:	e84a                	sd	s2,16(sp)
    80000a4c:	892a                	mv	s2,a0
  va = PGROUNDDOWN(va);
    80000a4e:	77fd                	lui	a5,0xfffff
    80000a50:	8cfd                	and	s1,s1,a5
  if(ismapped(pagetable, va)) {
    80000a52:	85a6                	mv	a1,s1
    80000a54:	854e                	mv	a0,s3
    80000a56:	fabff0ef          	jal	80000a00 <ismapped>
    return 0;
    80000a5a:	4981                	li	s3,0
  if(ismapped(pagetable, va)) {
    80000a5c:	c119                	beqz	a0,80000a62 <vmfault+0x42>
    80000a5e:	6942                	ld	s2,16(sp)
    80000a60:	bff1                	j	80000a3c <vmfault+0x1c>
    80000a62:	e052                	sd	s4,0(sp)
  mem = (uint64) kalloc();
    80000a64:	e9aff0ef          	jal	800000fe <kalloc>
    80000a68:	8a2a                	mv	s4,a0
  if(mem == 0)
    80000a6a:	c90d                	beqz	a0,80000a9c <vmfault+0x7c>
  mem = (uint64) kalloc();
    80000a6c:	89aa                	mv	s3,a0
  memset((void *) mem, 0, PGSIZE);
    80000a6e:	6605                	lui	a2,0x1
    80000a70:	4581                	li	a1,0
    80000a72:	edcff0ef          	jal	8000014e <memset>
  if (mappages(p->pagetable, va, PGSIZE, mem, PTE_W|PTE_U|PTE_R) != 0) {
    80000a76:	4759                	li	a4,22
    80000a78:	86d2                	mv	a3,s4
    80000a7a:	6605                	lui	a2,0x1
    80000a7c:	85a6                	mv	a1,s1
    80000a7e:	05093503          	ld	a0,80(s2) # 1050 <_entry-0x7fffefb0>
    80000a82:	a39ff0ef          	jal	800004ba <mappages>
    80000a86:	e501                	bnez	a0,80000a8e <vmfault+0x6e>
    80000a88:	6942                	ld	s2,16(sp)
    80000a8a:	6a02                	ld	s4,0(sp)
    80000a8c:	bf45                	j	80000a3c <vmfault+0x1c>
    kfree((void *)mem);
    80000a8e:	8552                	mv	a0,s4
    80000a90:	d8cff0ef          	jal	8000001c <kfree>
    return 0;
    80000a94:	4981                	li	s3,0
    80000a96:	6942                	ld	s2,16(sp)
    80000a98:	6a02                	ld	s4,0(sp)
    80000a9a:	b74d                	j	80000a3c <vmfault+0x1c>
    80000a9c:	6942                	ld	s2,16(sp)
    80000a9e:	6a02                	ld	s4,0(sp)
    80000aa0:	bf71                	j	80000a3c <vmfault+0x1c>

0000000080000aa2 <copyout>:
  while(len > 0){
    80000aa2:	cad1                	beqz	a3,80000b36 <copyout+0x94>
{
    80000aa4:	711d                	addi	sp,sp,-96
    80000aa6:	ec86                	sd	ra,88(sp)
    80000aa8:	e8a2                	sd	s0,80(sp)
    80000aaa:	e4a6                	sd	s1,72(sp)
    80000aac:	e0ca                	sd	s2,64(sp)
    80000aae:	fc4e                	sd	s3,56(sp)
    80000ab0:	f852                	sd	s4,48(sp)
    80000ab2:	f456                	sd	s5,40(sp)
    80000ab4:	f05a                	sd	s6,32(sp)
    80000ab6:	ec5e                	sd	s7,24(sp)
    80000ab8:	e862                	sd	s8,16(sp)
    80000aba:	e466                	sd	s9,8(sp)
    80000abc:	e06a                	sd	s10,0(sp)
    80000abe:	1080                	addi	s0,sp,96
    80000ac0:	8baa                	mv	s7,a0
    80000ac2:	8a2e                	mv	s4,a1
    80000ac4:	8b32                	mv	s6,a2
    80000ac6:	8ab6                	mv	s5,a3
    va0 = PGROUNDDOWN(dstva);
    80000ac8:	7d7d                	lui	s10,0xfffff
    if(va0 >= MAXVA)
    80000aca:	5cfd                	li	s9,-1
    80000acc:	01acdc93          	srli	s9,s9,0x1a
    n = PGSIZE - (dstva - va0);
    80000ad0:	6c05                	lui	s8,0x1
    80000ad2:	a005                	j	80000af2 <copyout+0x50>
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000ad4:	409a0533          	sub	a0,s4,s1
    80000ad8:	0009061b          	sext.w	a2,s2
    80000adc:	85da                	mv	a1,s6
    80000ade:	954e                	add	a0,a0,s3
    80000ae0:	ed2ff0ef          	jal	800001b2 <memmove>
    len -= n;
    80000ae4:	412a8ab3          	sub	s5,s5,s2
    src += n;
    80000ae8:	9b4a                	add	s6,s6,s2
    dstva = va0 + PGSIZE;
    80000aea:	01848a33          	add	s4,s1,s8
  while(len > 0){
    80000aee:	040a8263          	beqz	s5,80000b32 <copyout+0x90>
    va0 = PGROUNDDOWN(dstva);
    80000af2:	01aa74b3          	and	s1,s4,s10
    if(va0 >= MAXVA)
    80000af6:	049ce263          	bltu	s9,s1,80000b3a <copyout+0x98>
    pa0 = walkaddr(pagetable, va0);
    80000afa:	85a6                	mv	a1,s1
    80000afc:	855e                	mv	a0,s7
    80000afe:	97fff0ef          	jal	8000047c <walkaddr>
    80000b02:	89aa                	mv	s3,a0
    if(pa0 == 0) {
    80000b04:	e901                	bnez	a0,80000b14 <copyout+0x72>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000b06:	4601                	li	a2,0
    80000b08:	85a6                	mv	a1,s1
    80000b0a:	855e                	mv	a0,s7
    80000b0c:	f15ff0ef          	jal	80000a20 <vmfault>
    80000b10:	89aa                	mv	s3,a0
    80000b12:	c139                	beqz	a0,80000b58 <copyout+0xb6>
    pte = walk(pagetable, va0, 0);
    80000b14:	4601                	li	a2,0
    80000b16:	85a6                	mv	a1,s1
    80000b18:	855e                	mv	a0,s7
    80000b1a:	8c9ff0ef          	jal	800003e2 <walk>
    if((*pte & PTE_W) == 0)
    80000b1e:	611c                	ld	a5,0(a0)
    80000b20:	8b91                	andi	a5,a5,4
    80000b22:	cf8d                	beqz	a5,80000b5c <copyout+0xba>
    n = PGSIZE - (dstva - va0);
    80000b24:	41448933          	sub	s2,s1,s4
    80000b28:	9962                	add	s2,s2,s8
    if(n > len)
    80000b2a:	fb2af5e3          	bgeu	s5,s2,80000ad4 <copyout+0x32>
    80000b2e:	8956                	mv	s2,s5
    80000b30:	b755                	j	80000ad4 <copyout+0x32>
  return 0;
    80000b32:	4501                	li	a0,0
    80000b34:	a021                	j	80000b3c <copyout+0x9a>
    80000b36:	4501                	li	a0,0
}
    80000b38:	8082                	ret
      return -1;
    80000b3a:	557d                	li	a0,-1
}
    80000b3c:	60e6                	ld	ra,88(sp)
    80000b3e:	6446                	ld	s0,80(sp)
    80000b40:	64a6                	ld	s1,72(sp)
    80000b42:	6906                	ld	s2,64(sp)
    80000b44:	79e2                	ld	s3,56(sp)
    80000b46:	7a42                	ld	s4,48(sp)
    80000b48:	7aa2                	ld	s5,40(sp)
    80000b4a:	7b02                	ld	s6,32(sp)
    80000b4c:	6be2                	ld	s7,24(sp)
    80000b4e:	6c42                	ld	s8,16(sp)
    80000b50:	6ca2                	ld	s9,8(sp)
    80000b52:	6d02                	ld	s10,0(sp)
    80000b54:	6125                	addi	sp,sp,96
    80000b56:	8082                	ret
        return -1;
    80000b58:	557d                	li	a0,-1
    80000b5a:	b7cd                	j	80000b3c <copyout+0x9a>
      return -1;
    80000b5c:	557d                	li	a0,-1
    80000b5e:	bff9                	j	80000b3c <copyout+0x9a>

0000000080000b60 <copyin>:
  while(len > 0){
    80000b60:	c6c9                	beqz	a3,80000bea <copyin+0x8a>
{
    80000b62:	715d                	addi	sp,sp,-80
    80000b64:	e486                	sd	ra,72(sp)
    80000b66:	e0a2                	sd	s0,64(sp)
    80000b68:	fc26                	sd	s1,56(sp)
    80000b6a:	f84a                	sd	s2,48(sp)
    80000b6c:	f44e                	sd	s3,40(sp)
    80000b6e:	f052                	sd	s4,32(sp)
    80000b70:	ec56                	sd	s5,24(sp)
    80000b72:	e85a                	sd	s6,16(sp)
    80000b74:	e45e                	sd	s7,8(sp)
    80000b76:	e062                	sd	s8,0(sp)
    80000b78:	0880                	addi	s0,sp,80
    80000b7a:	8baa                	mv	s7,a0
    80000b7c:	8aae                	mv	s5,a1
    80000b7e:	8932                	mv	s2,a2
    80000b80:	8a36                	mv	s4,a3
    va0 = PGROUNDDOWN(srcva);
    80000b82:	7c7d                	lui	s8,0xfffff
    n = PGSIZE - (srcva - va0);
    80000b84:	6b05                	lui	s6,0x1
    80000b86:	a035                	j	80000bb2 <copyin+0x52>
    80000b88:	412984b3          	sub	s1,s3,s2
    80000b8c:	94da                	add	s1,s1,s6
    if(n > len)
    80000b8e:	009a7363          	bgeu	s4,s1,80000b94 <copyin+0x34>
    80000b92:	84d2                	mv	s1,s4
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000b94:	413905b3          	sub	a1,s2,s3
    80000b98:	0004861b          	sext.w	a2,s1
    80000b9c:	95aa                	add	a1,a1,a0
    80000b9e:	8556                	mv	a0,s5
    80000ba0:	e12ff0ef          	jal	800001b2 <memmove>
    len -= n;
    80000ba4:	409a0a33          	sub	s4,s4,s1
    dst += n;
    80000ba8:	9aa6                	add	s5,s5,s1
    srcva = va0 + PGSIZE;
    80000baa:	01698933          	add	s2,s3,s6
  while(len > 0){
    80000bae:	020a0163          	beqz	s4,80000bd0 <copyin+0x70>
    va0 = PGROUNDDOWN(srcva);
    80000bb2:	018979b3          	and	s3,s2,s8
    pa0 = walkaddr(pagetable, va0);
    80000bb6:	85ce                	mv	a1,s3
    80000bb8:	855e                	mv	a0,s7
    80000bba:	8c3ff0ef          	jal	8000047c <walkaddr>
    if(pa0 == 0) {
    80000bbe:	f569                	bnez	a0,80000b88 <copyin+0x28>
      if((pa0 = vmfault(pagetable, va0, 0)) == 0) {
    80000bc0:	4601                	li	a2,0
    80000bc2:	85ce                	mv	a1,s3
    80000bc4:	855e                	mv	a0,s7
    80000bc6:	e5bff0ef          	jal	80000a20 <vmfault>
    80000bca:	fd5d                	bnez	a0,80000b88 <copyin+0x28>
        return -1;
    80000bcc:	557d                	li	a0,-1
    80000bce:	a011                	j	80000bd2 <copyin+0x72>
  return 0;
    80000bd0:	4501                	li	a0,0
}
    80000bd2:	60a6                	ld	ra,72(sp)
    80000bd4:	6406                	ld	s0,64(sp)
    80000bd6:	74e2                	ld	s1,56(sp)
    80000bd8:	7942                	ld	s2,48(sp)
    80000bda:	79a2                	ld	s3,40(sp)
    80000bdc:	7a02                	ld	s4,32(sp)
    80000bde:	6ae2                	ld	s5,24(sp)
    80000be0:	6b42                	ld	s6,16(sp)
    80000be2:	6ba2                	ld	s7,8(sp)
    80000be4:	6c02                	ld	s8,0(sp)
    80000be6:	6161                	addi	sp,sp,80
    80000be8:	8082                	ret
  return 0;
    80000bea:	4501                	li	a0,0
}
    80000bec:	8082                	ret

0000000080000bee <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000bee:	715d                	addi	sp,sp,-80
    80000bf0:	e486                	sd	ra,72(sp)
    80000bf2:	e0a2                	sd	s0,64(sp)
    80000bf4:	fc26                	sd	s1,56(sp)
    80000bf6:	f84a                	sd	s2,48(sp)
    80000bf8:	f44e                	sd	s3,40(sp)
    80000bfa:	f052                	sd	s4,32(sp)
    80000bfc:	ec56                	sd	s5,24(sp)
    80000bfe:	e85a                	sd	s6,16(sp)
    80000c00:	e45e                	sd	s7,8(sp)
    80000c02:	e062                	sd	s8,0(sp)
    80000c04:	0880                	addi	s0,sp,80
    80000c06:	8a2a                	mv	s4,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c08:	0000a497          	auipc	s1,0xa
    80000c0c:	a8848493          	addi	s1,s1,-1400 # 8000a690 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000c10:	8c26                	mv	s8,s1
    80000c12:	a4fa57b7          	lui	a5,0xa4fa5
    80000c16:	fa578793          	addi	a5,a5,-91 # ffffffffa4fa4fa5 <end+0xffffffff24f81a5d>
    80000c1a:	4fa50937          	lui	s2,0x4fa50
    80000c1e:	a5090913          	addi	s2,s2,-1456 # 4fa4fa50 <_entry-0x305b05b0>
    80000c22:	1902                	slli	s2,s2,0x20
    80000c24:	993e                	add	s2,s2,a5
    80000c26:	040009b7          	lui	s3,0x4000
    80000c2a:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000c2c:	09b2                	slli	s3,s3,0xc
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c2e:	4b99                	li	s7,6
    80000c30:	6b05                	lui	s6,0x1
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c32:	0000fa97          	auipc	s5,0xf
    80000c36:	45ea8a93          	addi	s5,s5,1118 # 80010090 <tickslock>
    char *pa = kalloc();
    80000c3a:	cc4ff0ef          	jal	800000fe <kalloc>
    80000c3e:	862a                	mv	a2,a0
    if(pa == 0)
    80000c40:	c121                	beqz	a0,80000c80 <proc_mapstacks+0x92>
    uint64 va = KSTACK((int) (p - proc));
    80000c42:	418485b3          	sub	a1,s1,s8
    80000c46:	858d                	srai	a1,a1,0x3
    80000c48:	032585b3          	mul	a1,a1,s2
    80000c4c:	2585                	addiw	a1,a1,1
    80000c4e:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000c52:	875e                	mv	a4,s7
    80000c54:	86da                	mv	a3,s6
    80000c56:	40b985b3          	sub	a1,s3,a1
    80000c5a:	8552                	mv	a0,s4
    80000c5c:	915ff0ef          	jal	80000570 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000c60:	16848493          	addi	s1,s1,360
    80000c64:	fd549be3          	bne	s1,s5,80000c3a <proc_mapstacks+0x4c>
  }
}
    80000c68:	60a6                	ld	ra,72(sp)
    80000c6a:	6406                	ld	s0,64(sp)
    80000c6c:	74e2                	ld	s1,56(sp)
    80000c6e:	7942                	ld	s2,48(sp)
    80000c70:	79a2                	ld	s3,40(sp)
    80000c72:	7a02                	ld	s4,32(sp)
    80000c74:	6ae2                	ld	s5,24(sp)
    80000c76:	6b42                	ld	s6,16(sp)
    80000c78:	6ba2                	ld	s7,8(sp)
    80000c7a:	6c02                	ld	s8,0(sp)
    80000c7c:	6161                	addi	sp,sp,80
    80000c7e:	8082                	ret
      panic("kalloc");
    80000c80:	00006517          	auipc	a0,0x6
    80000c84:	47850513          	addi	a0,a0,1144 # 800070f8 <etext+0xf8>
    80000c88:	11f040ef          	jal	800055a6 <panic>

0000000080000c8c <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000c8c:	7139                	addi	sp,sp,-64
    80000c8e:	fc06                	sd	ra,56(sp)
    80000c90:	f822                	sd	s0,48(sp)
    80000c92:	f426                	sd	s1,40(sp)
    80000c94:	f04a                	sd	s2,32(sp)
    80000c96:	ec4e                	sd	s3,24(sp)
    80000c98:	e852                	sd	s4,16(sp)
    80000c9a:	e456                	sd	s5,8(sp)
    80000c9c:	e05a                	sd	s6,0(sp)
    80000c9e:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000ca0:	00006597          	auipc	a1,0x6
    80000ca4:	46058593          	addi	a1,a1,1120 # 80007100 <etext+0x100>
    80000ca8:	00009517          	auipc	a0,0x9
    80000cac:	5b850513          	addi	a0,a0,1464 # 8000a260 <pid_lock>
    80000cb0:	32f040ef          	jal	800057de <initlock>
  initlock(&wait_lock, "wait_lock");
    80000cb4:	00006597          	auipc	a1,0x6
    80000cb8:	45458593          	addi	a1,a1,1108 # 80007108 <etext+0x108>
    80000cbc:	00009517          	auipc	a0,0x9
    80000cc0:	5bc50513          	addi	a0,a0,1468 # 8000a278 <wait_lock>
    80000cc4:	31b040ef          	jal	800057de <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cc8:	0000a497          	auipc	s1,0xa
    80000ccc:	9c848493          	addi	s1,s1,-1592 # 8000a690 <proc>
      initlock(&p->lock, "proc");
    80000cd0:	00006b17          	auipc	s6,0x6
    80000cd4:	448b0b13          	addi	s6,s6,1096 # 80007118 <etext+0x118>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000cd8:	8aa6                	mv	s5,s1
    80000cda:	a4fa57b7          	lui	a5,0xa4fa5
    80000cde:	fa578793          	addi	a5,a5,-91 # ffffffffa4fa4fa5 <end+0xffffffff24f81a5d>
    80000ce2:	4fa50937          	lui	s2,0x4fa50
    80000ce6:	a5090913          	addi	s2,s2,-1456 # 4fa4fa50 <_entry-0x305b05b0>
    80000cea:	1902                	slli	s2,s2,0x20
    80000cec:	993e                	add	s2,s2,a5
    80000cee:	040009b7          	lui	s3,0x4000
    80000cf2:	19fd                	addi	s3,s3,-1 # 3ffffff <_entry-0x7c000001>
    80000cf4:	09b2                	slli	s3,s3,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cf6:	0000fa17          	auipc	s4,0xf
    80000cfa:	39aa0a13          	addi	s4,s4,922 # 80010090 <tickslock>
      initlock(&p->lock, "proc");
    80000cfe:	85da                	mv	a1,s6
    80000d00:	8526                	mv	a0,s1
    80000d02:	2dd040ef          	jal	800057de <initlock>
      p->state = UNUSED;
    80000d06:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000d0a:	415487b3          	sub	a5,s1,s5
    80000d0e:	878d                	srai	a5,a5,0x3
    80000d10:	032787b3          	mul	a5,a5,s2
    80000d14:	2785                	addiw	a5,a5,1
    80000d16:	00d7979b          	slliw	a5,a5,0xd
    80000d1a:	40f987b3          	sub	a5,s3,a5
    80000d1e:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d20:	16848493          	addi	s1,s1,360
    80000d24:	fd449de3          	bne	s1,s4,80000cfe <procinit+0x72>
  }
}
    80000d28:	70e2                	ld	ra,56(sp)
    80000d2a:	7442                	ld	s0,48(sp)
    80000d2c:	74a2                	ld	s1,40(sp)
    80000d2e:	7902                	ld	s2,32(sp)
    80000d30:	69e2                	ld	s3,24(sp)
    80000d32:	6a42                	ld	s4,16(sp)
    80000d34:	6aa2                	ld	s5,8(sp)
    80000d36:	6b02                	ld	s6,0(sp)
    80000d38:	6121                	addi	sp,sp,64
    80000d3a:	8082                	ret

0000000080000d3c <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000d3c:	1141                	addi	sp,sp,-16
    80000d3e:	e406                	sd	ra,8(sp)
    80000d40:	e022                	sd	s0,0(sp)
    80000d42:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000d44:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000d46:	2501                	sext.w	a0,a0
    80000d48:	60a2                	ld	ra,8(sp)
    80000d4a:	6402                	ld	s0,0(sp)
    80000d4c:	0141                	addi	sp,sp,16
    80000d4e:	8082                	ret

0000000080000d50 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000d50:	1141                	addi	sp,sp,-16
    80000d52:	e406                	sd	ra,8(sp)
    80000d54:	e022                	sd	s0,0(sp)
    80000d56:	0800                	addi	s0,sp,16
    80000d58:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000d5a:	2781                	sext.w	a5,a5
    80000d5c:	079e                	slli	a5,a5,0x7
  return c;
}
    80000d5e:	00009517          	auipc	a0,0x9
    80000d62:	53250513          	addi	a0,a0,1330 # 8000a290 <cpus>
    80000d66:	953e                	add	a0,a0,a5
    80000d68:	60a2                	ld	ra,8(sp)
    80000d6a:	6402                	ld	s0,0(sp)
    80000d6c:	0141                	addi	sp,sp,16
    80000d6e:	8082                	ret

0000000080000d70 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000d70:	1101                	addi	sp,sp,-32
    80000d72:	ec06                	sd	ra,24(sp)
    80000d74:	e822                	sd	s0,16(sp)
    80000d76:	e426                	sd	s1,8(sp)
    80000d78:	1000                	addi	s0,sp,32
  push_off();
    80000d7a:	2a9040ef          	jal	80005822 <push_off>
    80000d7e:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000d80:	2781                	sext.w	a5,a5
    80000d82:	079e                	slli	a5,a5,0x7
    80000d84:	00009717          	auipc	a4,0x9
    80000d88:	4dc70713          	addi	a4,a4,1244 # 8000a260 <pid_lock>
    80000d8c:	97ba                	add	a5,a5,a4
    80000d8e:	7b84                	ld	s1,48(a5)
  pop_off();
    80000d90:	317040ef          	jal	800058a6 <pop_off>
  return p;
}
    80000d94:	8526                	mv	a0,s1
    80000d96:	60e2                	ld	ra,24(sp)
    80000d98:	6442                	ld	s0,16(sp)
    80000d9a:	64a2                	ld	s1,8(sp)
    80000d9c:	6105                	addi	sp,sp,32
    80000d9e:	8082                	ret

0000000080000da0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000da0:	7179                	addi	sp,sp,-48
    80000da2:	f406                	sd	ra,40(sp)
    80000da4:	f022                	sd	s0,32(sp)
    80000da6:	ec26                	sd	s1,24(sp)
    80000da8:	1800                	addi	s0,sp,48
  extern char userret[];
  static int first = 1;
  struct proc *p = myproc();
    80000daa:	fc7ff0ef          	jal	80000d70 <myproc>
    80000dae:	84aa                	mv	s1,a0

  // Still holding p->lock from scheduler.
  release(&p->lock);
    80000db0:	347040ef          	jal	800058f6 <release>

  if (first) {
    80000db4:	00009797          	auipc	a5,0x9
    80000db8:	42c7a783          	lw	a5,1068(a5) # 8000a1e0 <first.1>
    80000dbc:	cf8d                	beqz	a5,80000df6 <forkret+0x56>
    // File system initialization must be run in the context of a
    // regular process (e.g., because it calls sleep), and thus cannot
    // be run from main().
    fsinit(ROOTDEV);
    80000dbe:	4505                	li	a0,1
    80000dc0:	365010ef          	jal	80002924 <fsinit>

    first = 0;
    80000dc4:	00009797          	auipc	a5,0x9
    80000dc8:	4007ae23          	sw	zero,1052(a5) # 8000a1e0 <first.1>
    // ensure other cores see first=0.
    __sync_synchronize();
    80000dcc:	0330000f          	fence	rw,rw

    // We can invoke kexec() now that file system is initialized.
    // Put the return value (argc) of kexec into a0.
    p->trapframe->a0 = kexec("/init", (char *[]){ "/init", 0 });
    80000dd0:	00006517          	auipc	a0,0x6
    80000dd4:	35050513          	addi	a0,a0,848 # 80007120 <etext+0x120>
    80000dd8:	fca43823          	sd	a0,-48(s0)
    80000ddc:	fc043c23          	sd	zero,-40(s0)
    80000de0:	fd040593          	addi	a1,s0,-48
    80000de4:	497020ef          	jal	80003a7a <kexec>
    80000de8:	6cbc                	ld	a5,88(s1)
    80000dea:	fba8                	sd	a0,112(a5)
    if (p->trapframe->a0 == -1) {
    80000dec:	6cbc                	ld	a5,88(s1)
    80000dee:	7bb8                	ld	a4,112(a5)
    80000df0:	57fd                	li	a5,-1
    80000df2:	02f70d63          	beq	a4,a5,80000e2c <forkret+0x8c>
      panic("exec");
    }
  }

  // return to user space, mimicing usertrap()'s return.
  prepare_return();
    80000df6:	2ab000ef          	jal	800018a0 <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80000dfa:	68a8                	ld	a0,80(s1)
    80000dfc:	8131                	srli	a0,a0,0xc
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80000dfe:	04000737          	lui	a4,0x4000
    80000e02:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    80000e04:	0732                	slli	a4,a4,0xc
    80000e06:	00005797          	auipc	a5,0x5
    80000e0a:	29678793          	addi	a5,a5,662 # 8000609c <userret>
    80000e0e:	00005697          	auipc	a3,0x5
    80000e12:	1f268693          	addi	a3,a3,498 # 80006000 <_trampoline>
    80000e16:	8f95                	sub	a5,a5,a3
    80000e18:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80000e1a:	577d                	li	a4,-1
    80000e1c:	177e                	slli	a4,a4,0x3f
    80000e1e:	8d59                	or	a0,a0,a4
    80000e20:	9782                	jalr	a5
}
    80000e22:	70a2                	ld	ra,40(sp)
    80000e24:	7402                	ld	s0,32(sp)
    80000e26:	64e2                	ld	s1,24(sp)
    80000e28:	6145                	addi	sp,sp,48
    80000e2a:	8082                	ret
      panic("exec");
    80000e2c:	00006517          	auipc	a0,0x6
    80000e30:	2fc50513          	addi	a0,a0,764 # 80007128 <etext+0x128>
    80000e34:	772040ef          	jal	800055a6 <panic>

0000000080000e38 <allocpid>:
{
    80000e38:	1101                	addi	sp,sp,-32
    80000e3a:	ec06                	sd	ra,24(sp)
    80000e3c:	e822                	sd	s0,16(sp)
    80000e3e:	e426                	sd	s1,8(sp)
    80000e40:	e04a                	sd	s2,0(sp)
    80000e42:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000e44:	00009917          	auipc	s2,0x9
    80000e48:	41c90913          	addi	s2,s2,1052 # 8000a260 <pid_lock>
    80000e4c:	854a                	mv	a0,s2
    80000e4e:	215040ef          	jal	80005862 <acquire>
  pid = nextpid;
    80000e52:	00009797          	auipc	a5,0x9
    80000e56:	39278793          	addi	a5,a5,914 # 8000a1e4 <nextpid>
    80000e5a:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000e5c:	0014871b          	addiw	a4,s1,1
    80000e60:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000e62:	854a                	mv	a0,s2
    80000e64:	293040ef          	jal	800058f6 <release>
}
    80000e68:	8526                	mv	a0,s1
    80000e6a:	60e2                	ld	ra,24(sp)
    80000e6c:	6442                	ld	s0,16(sp)
    80000e6e:	64a2                	ld	s1,8(sp)
    80000e70:	6902                	ld	s2,0(sp)
    80000e72:	6105                	addi	sp,sp,32
    80000e74:	8082                	ret

0000000080000e76 <proc_pagetable>:
{
    80000e76:	1101                	addi	sp,sp,-32
    80000e78:	ec06                	sd	ra,24(sp)
    80000e7a:	e822                	sd	s0,16(sp)
    80000e7c:	e426                	sd	s1,8(sp)
    80000e7e:	e04a                	sd	s2,0(sp)
    80000e80:	1000                	addi	s0,sp,32
    80000e82:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000e84:	fdcff0ef          	jal	80000660 <uvmcreate>
    80000e88:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000e8a:	cd05                	beqz	a0,80000ec2 <proc_pagetable+0x4c>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000e8c:	4729                	li	a4,10
    80000e8e:	00005697          	auipc	a3,0x5
    80000e92:	17268693          	addi	a3,a3,370 # 80006000 <_trampoline>
    80000e96:	6605                	lui	a2,0x1
    80000e98:	040005b7          	lui	a1,0x4000
    80000e9c:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000e9e:	05b2                	slli	a1,a1,0xc
    80000ea0:	e1aff0ef          	jal	800004ba <mappages>
    80000ea4:	02054663          	bltz	a0,80000ed0 <proc_pagetable+0x5a>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000ea8:	4719                	li	a4,6
    80000eaa:	05893683          	ld	a3,88(s2)
    80000eae:	6605                	lui	a2,0x1
    80000eb0:	020005b7          	lui	a1,0x2000
    80000eb4:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000eb6:	05b6                	slli	a1,a1,0xd
    80000eb8:	8526                	mv	a0,s1
    80000eba:	e00ff0ef          	jal	800004ba <mappages>
    80000ebe:	00054f63          	bltz	a0,80000edc <proc_pagetable+0x66>
}
    80000ec2:	8526                	mv	a0,s1
    80000ec4:	60e2                	ld	ra,24(sp)
    80000ec6:	6442                	ld	s0,16(sp)
    80000ec8:	64a2                	ld	s1,8(sp)
    80000eca:	6902                	ld	s2,0(sp)
    80000ecc:	6105                	addi	sp,sp,32
    80000ece:	8082                	ret
    uvmfree(pagetable, 0);
    80000ed0:	4581                	li	a1,0
    80000ed2:	8526                	mv	a0,s1
    80000ed4:	98fff0ef          	jal	80000862 <uvmfree>
    return 0;
    80000ed8:	4481                	li	s1,0
    80000eda:	b7e5                	j	80000ec2 <proc_pagetable+0x4c>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000edc:	4681                	li	a3,0
    80000ede:	4605                	li	a2,1
    80000ee0:	040005b7          	lui	a1,0x4000
    80000ee4:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000ee6:	05b2                	slli	a1,a1,0xc
    80000ee8:	8526                	mv	a0,s1
    80000eea:	f9cff0ef          	jal	80000686 <uvmunmap>
    uvmfree(pagetable, 0);
    80000eee:	4581                	li	a1,0
    80000ef0:	8526                	mv	a0,s1
    80000ef2:	971ff0ef          	jal	80000862 <uvmfree>
    return 0;
    80000ef6:	4481                	li	s1,0
    80000ef8:	b7e9                	j	80000ec2 <proc_pagetable+0x4c>

0000000080000efa <proc_freepagetable>:
{
    80000efa:	1101                	addi	sp,sp,-32
    80000efc:	ec06                	sd	ra,24(sp)
    80000efe:	e822                	sd	s0,16(sp)
    80000f00:	e426                	sd	s1,8(sp)
    80000f02:	e04a                	sd	s2,0(sp)
    80000f04:	1000                	addi	s0,sp,32
    80000f06:	84aa                	mv	s1,a0
    80000f08:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f0a:	4681                	li	a3,0
    80000f0c:	4605                	li	a2,1
    80000f0e:	040005b7          	lui	a1,0x4000
    80000f12:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f14:	05b2                	slli	a1,a1,0xc
    80000f16:	f70ff0ef          	jal	80000686 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000f1a:	4681                	li	a3,0
    80000f1c:	4605                	li	a2,1
    80000f1e:	020005b7          	lui	a1,0x2000
    80000f22:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f24:	05b6                	slli	a1,a1,0xd
    80000f26:	8526                	mv	a0,s1
    80000f28:	f5eff0ef          	jal	80000686 <uvmunmap>
  uvmfree(pagetable, sz);
    80000f2c:	85ca                	mv	a1,s2
    80000f2e:	8526                	mv	a0,s1
    80000f30:	933ff0ef          	jal	80000862 <uvmfree>
}
    80000f34:	60e2                	ld	ra,24(sp)
    80000f36:	6442                	ld	s0,16(sp)
    80000f38:	64a2                	ld	s1,8(sp)
    80000f3a:	6902                	ld	s2,0(sp)
    80000f3c:	6105                	addi	sp,sp,32
    80000f3e:	8082                	ret

0000000080000f40 <freeproc>:
{
    80000f40:	1101                	addi	sp,sp,-32
    80000f42:	ec06                	sd	ra,24(sp)
    80000f44:	e822                	sd	s0,16(sp)
    80000f46:	e426                	sd	s1,8(sp)
    80000f48:	1000                	addi	s0,sp,32
    80000f4a:	84aa                	mv	s1,a0
  if(p->trapframe)
    80000f4c:	6d28                	ld	a0,88(a0)
    80000f4e:	c119                	beqz	a0,80000f54 <freeproc+0x14>
    kfree((void*)p->trapframe);
    80000f50:	8ccff0ef          	jal	8000001c <kfree>
  p->trapframe = 0;
    80000f54:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80000f58:	68a8                	ld	a0,80(s1)
    80000f5a:	c501                	beqz	a0,80000f62 <freeproc+0x22>
    proc_freepagetable(p->pagetable, p->sz);
    80000f5c:	64ac                	ld	a1,72(s1)
    80000f5e:	f9dff0ef          	jal	80000efa <proc_freepagetable>
  p->pagetable = 0;
    80000f62:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80000f66:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80000f6a:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80000f6e:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80000f72:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80000f76:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80000f7a:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80000f7e:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80000f82:	0004ac23          	sw	zero,24(s1)
}
    80000f86:	60e2                	ld	ra,24(sp)
    80000f88:	6442                	ld	s0,16(sp)
    80000f8a:	64a2                	ld	s1,8(sp)
    80000f8c:	6105                	addi	sp,sp,32
    80000f8e:	8082                	ret

0000000080000f90 <allocproc>:
{
    80000f90:	1101                	addi	sp,sp,-32
    80000f92:	ec06                	sd	ra,24(sp)
    80000f94:	e822                	sd	s0,16(sp)
    80000f96:	e426                	sd	s1,8(sp)
    80000f98:	e04a                	sd	s2,0(sp)
    80000f9a:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80000f9c:	00009497          	auipc	s1,0x9
    80000fa0:	6f448493          	addi	s1,s1,1780 # 8000a690 <proc>
    80000fa4:	0000f917          	auipc	s2,0xf
    80000fa8:	0ec90913          	addi	s2,s2,236 # 80010090 <tickslock>
    acquire(&p->lock);
    80000fac:	8526                	mv	a0,s1
    80000fae:	0b5040ef          	jal	80005862 <acquire>
    if(p->state == UNUSED) {
    80000fb2:	4c9c                	lw	a5,24(s1)
    80000fb4:	cb91                	beqz	a5,80000fc8 <allocproc+0x38>
      release(&p->lock);
    80000fb6:	8526                	mv	a0,s1
    80000fb8:	13f040ef          	jal	800058f6 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000fbc:	16848493          	addi	s1,s1,360
    80000fc0:	ff2496e3          	bne	s1,s2,80000fac <allocproc+0x1c>
  return 0;
    80000fc4:	4481                	li	s1,0
    80000fc6:	a089                	j	80001008 <allocproc+0x78>
  p->pid = allocpid();
    80000fc8:	e71ff0ef          	jal	80000e38 <allocpid>
    80000fcc:	d888                	sw	a0,48(s1)
  p->state = USED;
    80000fce:	4785                	li	a5,1
    80000fd0:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80000fd2:	92cff0ef          	jal	800000fe <kalloc>
    80000fd6:	892a                	mv	s2,a0
    80000fd8:	eca8                	sd	a0,88(s1)
    80000fda:	cd15                	beqz	a0,80001016 <allocproc+0x86>
  p->pagetable = proc_pagetable(p);
    80000fdc:	8526                	mv	a0,s1
    80000fde:	e99ff0ef          	jal	80000e76 <proc_pagetable>
    80000fe2:	892a                	mv	s2,a0
    80000fe4:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80000fe6:	c121                	beqz	a0,80001026 <allocproc+0x96>
  memset(&p->context, 0, sizeof(p->context));
    80000fe8:	07000613          	li	a2,112
    80000fec:	4581                	li	a1,0
    80000fee:	06048513          	addi	a0,s1,96
    80000ff2:	95cff0ef          	jal	8000014e <memset>
  p->context.ra = (uint64)forkret;
    80000ff6:	00000797          	auipc	a5,0x0
    80000ffa:	daa78793          	addi	a5,a5,-598 # 80000da0 <forkret>
    80000ffe:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001000:	60bc                	ld	a5,64(s1)
    80001002:	6705                	lui	a4,0x1
    80001004:	97ba                	add	a5,a5,a4
    80001006:	f4bc                	sd	a5,104(s1)
}
    80001008:	8526                	mv	a0,s1
    8000100a:	60e2                	ld	ra,24(sp)
    8000100c:	6442                	ld	s0,16(sp)
    8000100e:	64a2                	ld	s1,8(sp)
    80001010:	6902                	ld	s2,0(sp)
    80001012:	6105                	addi	sp,sp,32
    80001014:	8082                	ret
    freeproc(p);
    80001016:	8526                	mv	a0,s1
    80001018:	f29ff0ef          	jal	80000f40 <freeproc>
    release(&p->lock);
    8000101c:	8526                	mv	a0,s1
    8000101e:	0d9040ef          	jal	800058f6 <release>
    return 0;
    80001022:	84ca                	mv	s1,s2
    80001024:	b7d5                	j	80001008 <allocproc+0x78>
    freeproc(p);
    80001026:	8526                	mv	a0,s1
    80001028:	f19ff0ef          	jal	80000f40 <freeproc>
    release(&p->lock);
    8000102c:	8526                	mv	a0,s1
    8000102e:	0c9040ef          	jal	800058f6 <release>
    return 0;
    80001032:	84ca                	mv	s1,s2
    80001034:	bfd1                	j	80001008 <allocproc+0x78>

0000000080001036 <userinit>:
{
    80001036:	1101                	addi	sp,sp,-32
    80001038:	ec06                	sd	ra,24(sp)
    8000103a:	e822                	sd	s0,16(sp)
    8000103c:	e426                	sd	s1,8(sp)
    8000103e:	1000                	addi	s0,sp,32
  p = allocproc();
    80001040:	f51ff0ef          	jal	80000f90 <allocproc>
    80001044:	84aa                	mv	s1,a0
  initproc = p;
    80001046:	00009797          	auipc	a5,0x9
    8000104a:	1ca7bd23          	sd	a0,474(a5) # 8000a220 <initproc>
  p->cwd = namei("/");
    8000104e:	00006517          	auipc	a0,0x6
    80001052:	0e250513          	addi	a0,a0,226 # 80007130 <etext+0x130>
    80001056:	607010ef          	jal	80002e5c <namei>
    8000105a:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    8000105e:	478d                	li	a5,3
    80001060:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001062:	8526                	mv	a0,s1
    80001064:	093040ef          	jal	800058f6 <release>
}
    80001068:	60e2                	ld	ra,24(sp)
    8000106a:	6442                	ld	s0,16(sp)
    8000106c:	64a2                	ld	s1,8(sp)
    8000106e:	6105                	addi	sp,sp,32
    80001070:	8082                	ret

0000000080001072 <growproc>:
{
    80001072:	1101                	addi	sp,sp,-32
    80001074:	ec06                	sd	ra,24(sp)
    80001076:	e822                	sd	s0,16(sp)
    80001078:	e426                	sd	s1,8(sp)
    8000107a:	e04a                	sd	s2,0(sp)
    8000107c:	1000                	addi	s0,sp,32
    8000107e:	892a                	mv	s2,a0
  struct proc *p = myproc();
    80001080:	cf1ff0ef          	jal	80000d70 <myproc>
    80001084:	84aa                	mv	s1,a0
  sz = p->sz;
    80001086:	652c                	ld	a1,72(a0)
  if(n > 0){
    80001088:	01204c63          	bgtz	s2,800010a0 <growproc+0x2e>
  } else if(n < 0){
    8000108c:	02094463          	bltz	s2,800010b4 <growproc+0x42>
  p->sz = sz;
    80001090:	e4ac                	sd	a1,72(s1)
  return 0;
    80001092:	4501                	li	a0,0
}
    80001094:	60e2                	ld	ra,24(sp)
    80001096:	6442                	ld	s0,16(sp)
    80001098:	64a2                	ld	s1,8(sp)
    8000109a:	6902                	ld	s2,0(sp)
    8000109c:	6105                	addi	sp,sp,32
    8000109e:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    800010a0:	4691                	li	a3,4
    800010a2:	00b90633          	add	a2,s2,a1
    800010a6:	6928                	ld	a0,80(a0)
    800010a8:	eacff0ef          	jal	80000754 <uvmalloc>
    800010ac:	85aa                	mv	a1,a0
    800010ae:	f16d                	bnez	a0,80001090 <growproc+0x1e>
      return -1;
    800010b0:	557d                	li	a0,-1
    800010b2:	b7cd                	j	80001094 <growproc+0x22>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800010b4:	00b90633          	add	a2,s2,a1
    800010b8:	6928                	ld	a0,80(a0)
    800010ba:	e56ff0ef          	jal	80000710 <uvmdealloc>
    800010be:	85aa                	mv	a1,a0
    800010c0:	bfc1                	j	80001090 <growproc+0x1e>

00000000800010c2 <kfork>:
{
    800010c2:	7139                	addi	sp,sp,-64
    800010c4:	fc06                	sd	ra,56(sp)
    800010c6:	f822                	sd	s0,48(sp)
    800010c8:	f04a                	sd	s2,32(sp)
    800010ca:	e456                	sd	s5,8(sp)
    800010cc:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    800010ce:	ca3ff0ef          	jal	80000d70 <myproc>
    800010d2:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    800010d4:	ebdff0ef          	jal	80000f90 <allocproc>
    800010d8:	0e050a63          	beqz	a0,800011cc <kfork+0x10a>
    800010dc:	e852                	sd	s4,16(sp)
    800010de:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    800010e0:	048ab603          	ld	a2,72(s5)
    800010e4:	692c                	ld	a1,80(a0)
    800010e6:	050ab503          	ld	a0,80(s5)
    800010ea:	faaff0ef          	jal	80000894 <uvmcopy>
    800010ee:	04054a63          	bltz	a0,80001142 <kfork+0x80>
    800010f2:	f426                	sd	s1,40(sp)
    800010f4:	ec4e                	sd	s3,24(sp)
  np->sz = p->sz;
    800010f6:	048ab783          	ld	a5,72(s5)
    800010fa:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    800010fe:	058ab683          	ld	a3,88(s5)
    80001102:	87b6                	mv	a5,a3
    80001104:	058a3703          	ld	a4,88(s4)
    80001108:	12068693          	addi	a3,a3,288
    8000110c:	0007b803          	ld	a6,0(a5)
    80001110:	6788                	ld	a0,8(a5)
    80001112:	6b8c                	ld	a1,16(a5)
    80001114:	6f90                	ld	a2,24(a5)
    80001116:	01073023          	sd	a6,0(a4) # 1000 <_entry-0x7ffff000>
    8000111a:	e708                	sd	a0,8(a4)
    8000111c:	eb0c                	sd	a1,16(a4)
    8000111e:	ef10                	sd	a2,24(a4)
    80001120:	02078793          	addi	a5,a5,32
    80001124:	02070713          	addi	a4,a4,32
    80001128:	fed792e3          	bne	a5,a3,8000110c <kfork+0x4a>
  np->trapframe->a0 = 0;
    8000112c:	058a3783          	ld	a5,88(s4)
    80001130:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001134:	0d0a8493          	addi	s1,s5,208
    80001138:	0d0a0913          	addi	s2,s4,208
    8000113c:	150a8993          	addi	s3,s5,336
    80001140:	a831                	j	8000115c <kfork+0x9a>
    freeproc(np);
    80001142:	8552                	mv	a0,s4
    80001144:	dfdff0ef          	jal	80000f40 <freeproc>
    release(&np->lock);
    80001148:	8552                	mv	a0,s4
    8000114a:	7ac040ef          	jal	800058f6 <release>
    return -1;
    8000114e:	597d                	li	s2,-1
    80001150:	6a42                	ld	s4,16(sp)
    80001152:	a0b5                	j	800011be <kfork+0xfc>
  for(i = 0; i < NOFILE; i++)
    80001154:	04a1                	addi	s1,s1,8
    80001156:	0921                	addi	s2,s2,8
    80001158:	01348963          	beq	s1,s3,8000116a <kfork+0xa8>
    if(p->ofile[i])
    8000115c:	6088                	ld	a0,0(s1)
    8000115e:	d97d                	beqz	a0,80001154 <kfork+0x92>
      np->ofile[i] = filedup(p->ofile[i]);
    80001160:	2a2020ef          	jal	80003402 <filedup>
    80001164:	00a93023          	sd	a0,0(s2)
    80001168:	b7f5                	j	80001154 <kfork+0x92>
  np->cwd = idup(p->cwd);
    8000116a:	150ab503          	ld	a0,336(s5)
    8000116e:	48e010ef          	jal	800025fc <idup>
    80001172:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001176:	4641                	li	a2,16
    80001178:	158a8593          	addi	a1,s5,344
    8000117c:	158a0513          	addi	a0,s4,344
    80001180:	920ff0ef          	jal	800002a0 <safestrcpy>
  pid = np->pid;
    80001184:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001188:	8552                	mv	a0,s4
    8000118a:	76c040ef          	jal	800058f6 <release>
  acquire(&wait_lock);
    8000118e:	00009497          	auipc	s1,0x9
    80001192:	0ea48493          	addi	s1,s1,234 # 8000a278 <wait_lock>
    80001196:	8526                	mv	a0,s1
    80001198:	6ca040ef          	jal	80005862 <acquire>
  np->parent = p;
    8000119c:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    800011a0:	8526                	mv	a0,s1
    800011a2:	754040ef          	jal	800058f6 <release>
  acquire(&np->lock);
    800011a6:	8552                	mv	a0,s4
    800011a8:	6ba040ef          	jal	80005862 <acquire>
  np->state = RUNNABLE;
    800011ac:	478d                	li	a5,3
    800011ae:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    800011b2:	8552                	mv	a0,s4
    800011b4:	742040ef          	jal	800058f6 <release>
  return pid;
    800011b8:	74a2                	ld	s1,40(sp)
    800011ba:	69e2                	ld	s3,24(sp)
    800011bc:	6a42                	ld	s4,16(sp)
}
    800011be:	854a                	mv	a0,s2
    800011c0:	70e2                	ld	ra,56(sp)
    800011c2:	7442                	ld	s0,48(sp)
    800011c4:	7902                	ld	s2,32(sp)
    800011c6:	6aa2                	ld	s5,8(sp)
    800011c8:	6121                	addi	sp,sp,64
    800011ca:	8082                	ret
    return -1;
    800011cc:	597d                	li	s2,-1
    800011ce:	bfc5                	j	800011be <kfork+0xfc>

00000000800011d0 <scheduler>:
{
    800011d0:	715d                	addi	sp,sp,-80
    800011d2:	e486                	sd	ra,72(sp)
    800011d4:	e0a2                	sd	s0,64(sp)
    800011d6:	fc26                	sd	s1,56(sp)
    800011d8:	f84a                	sd	s2,48(sp)
    800011da:	f44e                	sd	s3,40(sp)
    800011dc:	f052                	sd	s4,32(sp)
    800011de:	ec56                	sd	s5,24(sp)
    800011e0:	e85a                	sd	s6,16(sp)
    800011e2:	e45e                	sd	s7,8(sp)
    800011e4:	e062                	sd	s8,0(sp)
    800011e6:	0880                	addi	s0,sp,80
    800011e8:	8792                	mv	a5,tp
  int id = r_tp();
    800011ea:	2781                	sext.w	a5,a5
  c->proc = 0;
    800011ec:	00779b13          	slli	s6,a5,0x7
    800011f0:	00009717          	auipc	a4,0x9
    800011f4:	07070713          	addi	a4,a4,112 # 8000a260 <pid_lock>
    800011f8:	975a                	add	a4,a4,s6
    800011fa:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    800011fe:	00009717          	auipc	a4,0x9
    80001202:	09a70713          	addi	a4,a4,154 # 8000a298 <cpus+0x8>
    80001206:	9b3a                	add	s6,s6,a4
        p->state = RUNNING;
    80001208:	4c11                	li	s8,4
        c->proc = p;
    8000120a:	079e                	slli	a5,a5,0x7
    8000120c:	00009a17          	auipc	s4,0x9
    80001210:	054a0a13          	addi	s4,s4,84 # 8000a260 <pid_lock>
    80001214:	9a3e                	add	s4,s4,a5
        found = 1;
    80001216:	4b85                	li	s7,1
    80001218:	a83d                	j	80001256 <scheduler+0x86>
      release(&p->lock);
    8000121a:	8526                	mv	a0,s1
    8000121c:	6da040ef          	jal	800058f6 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001220:	16848493          	addi	s1,s1,360
    80001224:	03248563          	beq	s1,s2,8000124e <scheduler+0x7e>
      acquire(&p->lock);
    80001228:	8526                	mv	a0,s1
    8000122a:	638040ef          	jal	80005862 <acquire>
      if(p->state == RUNNABLE) {
    8000122e:	4c9c                	lw	a5,24(s1)
    80001230:	ff3795e3          	bne	a5,s3,8000121a <scheduler+0x4a>
        p->state = RUNNING;
    80001234:	0184ac23          	sw	s8,24(s1)
        c->proc = p;
    80001238:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000123c:	06048593          	addi	a1,s1,96
    80001240:	855a                	mv	a0,s6
    80001242:	5b4000ef          	jal	800017f6 <swtch>
        c->proc = 0;
    80001246:	020a3823          	sd	zero,48(s4)
        found = 1;
    8000124a:	8ade                	mv	s5,s7
    8000124c:	b7f9                	j	8000121a <scheduler+0x4a>
    if(found == 0) {
    8000124e:	000a9463          	bnez	s5,80001256 <scheduler+0x86>
      asm volatile("wfi");
    80001252:	10500073          	wfi
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001256:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000125a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000125e:	10079073          	csrw	sstatus,a5
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001262:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001266:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001268:	10079073          	csrw	sstatus,a5
    int found = 0;
    8000126c:	4a81                	li	s5,0
    for(p = proc; p < &proc[NPROC]; p++) {
    8000126e:	00009497          	auipc	s1,0x9
    80001272:	42248493          	addi	s1,s1,1058 # 8000a690 <proc>
      if(p->state == RUNNABLE) {
    80001276:	498d                	li	s3,3
    for(p = proc; p < &proc[NPROC]; p++) {
    80001278:	0000f917          	auipc	s2,0xf
    8000127c:	e1890913          	addi	s2,s2,-488 # 80010090 <tickslock>
    80001280:	b765                	j	80001228 <scheduler+0x58>

0000000080001282 <sched>:
{
    80001282:	7179                	addi	sp,sp,-48
    80001284:	f406                	sd	ra,40(sp)
    80001286:	f022                	sd	s0,32(sp)
    80001288:	ec26                	sd	s1,24(sp)
    8000128a:	e84a                	sd	s2,16(sp)
    8000128c:	e44e                	sd	s3,8(sp)
    8000128e:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001290:	ae1ff0ef          	jal	80000d70 <myproc>
    80001294:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001296:	562040ef          	jal	800057f8 <holding>
    8000129a:	c92d                	beqz	a0,8000130c <sched+0x8a>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000129c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000129e:	2781                	sext.w	a5,a5
    800012a0:	079e                	slli	a5,a5,0x7
    800012a2:	00009717          	auipc	a4,0x9
    800012a6:	fbe70713          	addi	a4,a4,-66 # 8000a260 <pid_lock>
    800012aa:	97ba                	add	a5,a5,a4
    800012ac:	0a87a703          	lw	a4,168(a5)
    800012b0:	4785                	li	a5,1
    800012b2:	06f71363          	bne	a4,a5,80001318 <sched+0x96>
  if(p->state == RUNNING)
    800012b6:	4c98                	lw	a4,24(s1)
    800012b8:	4791                	li	a5,4
    800012ba:	06f70563          	beq	a4,a5,80001324 <sched+0xa2>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800012be:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800012c2:	8b89                	andi	a5,a5,2
  if(intr_get())
    800012c4:	e7b5                	bnez	a5,80001330 <sched+0xae>
  asm volatile("mv %0, tp" : "=r" (x) );
    800012c6:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    800012c8:	00009917          	auipc	s2,0x9
    800012cc:	f9890913          	addi	s2,s2,-104 # 8000a260 <pid_lock>
    800012d0:	2781                	sext.w	a5,a5
    800012d2:	079e                	slli	a5,a5,0x7
    800012d4:	97ca                	add	a5,a5,s2
    800012d6:	0ac7a983          	lw	s3,172(a5)
    800012da:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    800012dc:	2781                	sext.w	a5,a5
    800012de:	079e                	slli	a5,a5,0x7
    800012e0:	00009597          	auipc	a1,0x9
    800012e4:	fb858593          	addi	a1,a1,-72 # 8000a298 <cpus+0x8>
    800012e8:	95be                	add	a1,a1,a5
    800012ea:	06048513          	addi	a0,s1,96
    800012ee:	508000ef          	jal	800017f6 <swtch>
    800012f2:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    800012f4:	2781                	sext.w	a5,a5
    800012f6:	079e                	slli	a5,a5,0x7
    800012f8:	993e                	add	s2,s2,a5
    800012fa:	0b392623          	sw	s3,172(s2)
}
    800012fe:	70a2                	ld	ra,40(sp)
    80001300:	7402                	ld	s0,32(sp)
    80001302:	64e2                	ld	s1,24(sp)
    80001304:	6942                	ld	s2,16(sp)
    80001306:	69a2                	ld	s3,8(sp)
    80001308:	6145                	addi	sp,sp,48
    8000130a:	8082                	ret
    panic("sched p->lock");
    8000130c:	00006517          	auipc	a0,0x6
    80001310:	e2c50513          	addi	a0,a0,-468 # 80007138 <etext+0x138>
    80001314:	292040ef          	jal	800055a6 <panic>
    panic("sched locks");
    80001318:	00006517          	auipc	a0,0x6
    8000131c:	e3050513          	addi	a0,a0,-464 # 80007148 <etext+0x148>
    80001320:	286040ef          	jal	800055a6 <panic>
    panic("sched RUNNING");
    80001324:	00006517          	auipc	a0,0x6
    80001328:	e3450513          	addi	a0,a0,-460 # 80007158 <etext+0x158>
    8000132c:	27a040ef          	jal	800055a6 <panic>
    panic("sched interruptible");
    80001330:	00006517          	auipc	a0,0x6
    80001334:	e3850513          	addi	a0,a0,-456 # 80007168 <etext+0x168>
    80001338:	26e040ef          	jal	800055a6 <panic>

000000008000133c <yield>:
{
    8000133c:	1101                	addi	sp,sp,-32
    8000133e:	ec06                	sd	ra,24(sp)
    80001340:	e822                	sd	s0,16(sp)
    80001342:	e426                	sd	s1,8(sp)
    80001344:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    80001346:	a2bff0ef          	jal	80000d70 <myproc>
    8000134a:	84aa                	mv	s1,a0
  acquire(&p->lock);
    8000134c:	516040ef          	jal	80005862 <acquire>
  p->state = RUNNABLE;
    80001350:	478d                	li	a5,3
    80001352:	cc9c                	sw	a5,24(s1)
  sched();
    80001354:	f2fff0ef          	jal	80001282 <sched>
  release(&p->lock);
    80001358:	8526                	mv	a0,s1
    8000135a:	59c040ef          	jal	800058f6 <release>
}
    8000135e:	60e2                	ld	ra,24(sp)
    80001360:	6442                	ld	s0,16(sp)
    80001362:	64a2                	ld	s1,8(sp)
    80001364:	6105                	addi	sp,sp,32
    80001366:	8082                	ret

0000000080001368 <sleep>:

// Sleep on channel chan, releasing condition lock lk.
// Re-acquires lk when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001368:	7179                	addi	sp,sp,-48
    8000136a:	f406                	sd	ra,40(sp)
    8000136c:	f022                	sd	s0,32(sp)
    8000136e:	ec26                	sd	s1,24(sp)
    80001370:	e84a                	sd	s2,16(sp)
    80001372:	e44e                	sd	s3,8(sp)
    80001374:	1800                	addi	s0,sp,48
    80001376:	89aa                	mv	s3,a0
    80001378:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000137a:	9f7ff0ef          	jal	80000d70 <myproc>
    8000137e:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001380:	4e2040ef          	jal	80005862 <acquire>
  release(lk);
    80001384:	854a                	mv	a0,s2
    80001386:	570040ef          	jal	800058f6 <release>

  // Go to sleep.
  p->chan = chan;
    8000138a:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000138e:	4789                	li	a5,2
    80001390:	cc9c                	sw	a5,24(s1)

  sched();
    80001392:	ef1ff0ef          	jal	80001282 <sched>

  // Tidy up.
  p->chan = 0;
    80001396:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000139a:	8526                	mv	a0,s1
    8000139c:	55a040ef          	jal	800058f6 <release>
  acquire(lk);
    800013a0:	854a                	mv	a0,s2
    800013a2:	4c0040ef          	jal	80005862 <acquire>
}
    800013a6:	70a2                	ld	ra,40(sp)
    800013a8:	7402                	ld	s0,32(sp)
    800013aa:	64e2                	ld	s1,24(sp)
    800013ac:	6942                	ld	s2,16(sp)
    800013ae:	69a2                	ld	s3,8(sp)
    800013b0:	6145                	addi	sp,sp,48
    800013b2:	8082                	ret

00000000800013b4 <wakeup>:

// Wake up all processes sleeping on channel chan.
// Caller should hold the condition lock.
void
wakeup(void *chan)
{
    800013b4:	7139                	addi	sp,sp,-64
    800013b6:	fc06                	sd	ra,56(sp)
    800013b8:	f822                	sd	s0,48(sp)
    800013ba:	f426                	sd	s1,40(sp)
    800013bc:	f04a                	sd	s2,32(sp)
    800013be:	ec4e                	sd	s3,24(sp)
    800013c0:	e852                	sd	s4,16(sp)
    800013c2:	e456                	sd	s5,8(sp)
    800013c4:	0080                	addi	s0,sp,64
    800013c6:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800013c8:	00009497          	auipc	s1,0x9
    800013cc:	2c848493          	addi	s1,s1,712 # 8000a690 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800013d0:	4989                	li	s3,2
        p->state = RUNNABLE;
    800013d2:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800013d4:	0000f917          	auipc	s2,0xf
    800013d8:	cbc90913          	addi	s2,s2,-836 # 80010090 <tickslock>
    800013dc:	a801                	j	800013ec <wakeup+0x38>
      }
      release(&p->lock);
    800013de:	8526                	mv	a0,s1
    800013e0:	516040ef          	jal	800058f6 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800013e4:	16848493          	addi	s1,s1,360
    800013e8:	03248263          	beq	s1,s2,8000140c <wakeup+0x58>
    if(p != myproc()){
    800013ec:	985ff0ef          	jal	80000d70 <myproc>
    800013f0:	fea48ae3          	beq	s1,a0,800013e4 <wakeup+0x30>
      acquire(&p->lock);
    800013f4:	8526                	mv	a0,s1
    800013f6:	46c040ef          	jal	80005862 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800013fa:	4c9c                	lw	a5,24(s1)
    800013fc:	ff3791e3          	bne	a5,s3,800013de <wakeup+0x2a>
    80001400:	709c                	ld	a5,32(s1)
    80001402:	fd479ee3          	bne	a5,s4,800013de <wakeup+0x2a>
        p->state = RUNNABLE;
    80001406:	0154ac23          	sw	s5,24(s1)
    8000140a:	bfd1                	j	800013de <wakeup+0x2a>
    }
  }
}
    8000140c:	70e2                	ld	ra,56(sp)
    8000140e:	7442                	ld	s0,48(sp)
    80001410:	74a2                	ld	s1,40(sp)
    80001412:	7902                	ld	s2,32(sp)
    80001414:	69e2                	ld	s3,24(sp)
    80001416:	6a42                	ld	s4,16(sp)
    80001418:	6aa2                	ld	s5,8(sp)
    8000141a:	6121                	addi	sp,sp,64
    8000141c:	8082                	ret

000000008000141e <reparent>:
{
    8000141e:	7179                	addi	sp,sp,-48
    80001420:	f406                	sd	ra,40(sp)
    80001422:	f022                	sd	s0,32(sp)
    80001424:	ec26                	sd	s1,24(sp)
    80001426:	e84a                	sd	s2,16(sp)
    80001428:	e44e                	sd	s3,8(sp)
    8000142a:	e052                	sd	s4,0(sp)
    8000142c:	1800                	addi	s0,sp,48
    8000142e:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001430:	00009497          	auipc	s1,0x9
    80001434:	26048493          	addi	s1,s1,608 # 8000a690 <proc>
      pp->parent = initproc;
    80001438:	00009a17          	auipc	s4,0x9
    8000143c:	de8a0a13          	addi	s4,s4,-536 # 8000a220 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001440:	0000f997          	auipc	s3,0xf
    80001444:	c5098993          	addi	s3,s3,-944 # 80010090 <tickslock>
    80001448:	a029                	j	80001452 <reparent+0x34>
    8000144a:	16848493          	addi	s1,s1,360
    8000144e:	01348b63          	beq	s1,s3,80001464 <reparent+0x46>
    if(pp->parent == p){
    80001452:	7c9c                	ld	a5,56(s1)
    80001454:	ff279be3          	bne	a5,s2,8000144a <reparent+0x2c>
      pp->parent = initproc;
    80001458:	000a3503          	ld	a0,0(s4)
    8000145c:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000145e:	f57ff0ef          	jal	800013b4 <wakeup>
    80001462:	b7e5                	j	8000144a <reparent+0x2c>
}
    80001464:	70a2                	ld	ra,40(sp)
    80001466:	7402                	ld	s0,32(sp)
    80001468:	64e2                	ld	s1,24(sp)
    8000146a:	6942                	ld	s2,16(sp)
    8000146c:	69a2                	ld	s3,8(sp)
    8000146e:	6a02                	ld	s4,0(sp)
    80001470:	6145                	addi	sp,sp,48
    80001472:	8082                	ret

0000000080001474 <kexit>:
{
    80001474:	7179                	addi	sp,sp,-48
    80001476:	f406                	sd	ra,40(sp)
    80001478:	f022                	sd	s0,32(sp)
    8000147a:	ec26                	sd	s1,24(sp)
    8000147c:	e84a                	sd	s2,16(sp)
    8000147e:	e44e                	sd	s3,8(sp)
    80001480:	e052                	sd	s4,0(sp)
    80001482:	1800                	addi	s0,sp,48
    80001484:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001486:	8ebff0ef          	jal	80000d70 <myproc>
    8000148a:	89aa                	mv	s3,a0
  if(p == initproc)
    8000148c:	00009797          	auipc	a5,0x9
    80001490:	d947b783          	ld	a5,-620(a5) # 8000a220 <initproc>
    80001494:	0d050493          	addi	s1,a0,208
    80001498:	15050913          	addi	s2,a0,336
    8000149c:	00a79b63          	bne	a5,a0,800014b2 <kexit+0x3e>
    panic("init exiting");
    800014a0:	00006517          	auipc	a0,0x6
    800014a4:	ce050513          	addi	a0,a0,-800 # 80007180 <etext+0x180>
    800014a8:	0fe040ef          	jal	800055a6 <panic>
  for(int fd = 0; fd < NOFILE; fd++){
    800014ac:	04a1                	addi	s1,s1,8
    800014ae:	01248963          	beq	s1,s2,800014c0 <kexit+0x4c>
    if(p->ofile[fd]){
    800014b2:	6088                	ld	a0,0(s1)
    800014b4:	dd65                	beqz	a0,800014ac <kexit+0x38>
      fileclose(f);
    800014b6:	793010ef          	jal	80003448 <fileclose>
      p->ofile[fd] = 0;
    800014ba:	0004b023          	sd	zero,0(s1)
    800014be:	b7fd                	j	800014ac <kexit+0x38>
  begin_op();
    800014c0:	377010ef          	jal	80003036 <begin_op>
  iput(p->cwd);
    800014c4:	1509b503          	ld	a0,336(s3)
    800014c8:	2ec010ef          	jal	800027b4 <iput>
  end_op();
    800014cc:	3d5010ef          	jal	800030a0 <end_op>
  p->cwd = 0;
    800014d0:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800014d4:	00009497          	auipc	s1,0x9
    800014d8:	da448493          	addi	s1,s1,-604 # 8000a278 <wait_lock>
    800014dc:	8526                	mv	a0,s1
    800014de:	384040ef          	jal	80005862 <acquire>
  reparent(p);
    800014e2:	854e                	mv	a0,s3
    800014e4:	f3bff0ef          	jal	8000141e <reparent>
  wakeup(p->parent);
    800014e8:	0389b503          	ld	a0,56(s3)
    800014ec:	ec9ff0ef          	jal	800013b4 <wakeup>
  acquire(&p->lock);
    800014f0:	854e                	mv	a0,s3
    800014f2:	370040ef          	jal	80005862 <acquire>
  p->xstate = status;
    800014f6:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800014fa:	4795                	li	a5,5
    800014fc:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001500:	8526                	mv	a0,s1
    80001502:	3f4040ef          	jal	800058f6 <release>
  sched();
    80001506:	d7dff0ef          	jal	80001282 <sched>
  panic("zombie exit");
    8000150a:	00006517          	auipc	a0,0x6
    8000150e:	c8650513          	addi	a0,a0,-890 # 80007190 <etext+0x190>
    80001512:	094040ef          	jal	800055a6 <panic>

0000000080001516 <kkill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kkill(int pid)
{
    80001516:	7179                	addi	sp,sp,-48
    80001518:	f406                	sd	ra,40(sp)
    8000151a:	f022                	sd	s0,32(sp)
    8000151c:	ec26                	sd	s1,24(sp)
    8000151e:	e84a                	sd	s2,16(sp)
    80001520:	e44e                	sd	s3,8(sp)
    80001522:	1800                	addi	s0,sp,48
    80001524:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001526:	00009497          	auipc	s1,0x9
    8000152a:	16a48493          	addi	s1,s1,362 # 8000a690 <proc>
    8000152e:	0000f997          	auipc	s3,0xf
    80001532:	b6298993          	addi	s3,s3,-1182 # 80010090 <tickslock>
    acquire(&p->lock);
    80001536:	8526                	mv	a0,s1
    80001538:	32a040ef          	jal	80005862 <acquire>
    if(p->pid == pid){
    8000153c:	589c                	lw	a5,48(s1)
    8000153e:	01278b63          	beq	a5,s2,80001554 <kkill+0x3e>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001542:	8526                	mv	a0,s1
    80001544:	3b2040ef          	jal	800058f6 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001548:	16848493          	addi	s1,s1,360
    8000154c:	ff3495e3          	bne	s1,s3,80001536 <kkill+0x20>
  }
  return -1;
    80001550:	557d                	li	a0,-1
    80001552:	a819                	j	80001568 <kkill+0x52>
      p->killed = 1;
    80001554:	4785                	li	a5,1
    80001556:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001558:	4c98                	lw	a4,24(s1)
    8000155a:	4789                	li	a5,2
    8000155c:	00f70d63          	beq	a4,a5,80001576 <kkill+0x60>
      release(&p->lock);
    80001560:	8526                	mv	a0,s1
    80001562:	394040ef          	jal	800058f6 <release>
      return 0;
    80001566:	4501                	li	a0,0
}
    80001568:	70a2                	ld	ra,40(sp)
    8000156a:	7402                	ld	s0,32(sp)
    8000156c:	64e2                	ld	s1,24(sp)
    8000156e:	6942                	ld	s2,16(sp)
    80001570:	69a2                	ld	s3,8(sp)
    80001572:	6145                	addi	sp,sp,48
    80001574:	8082                	ret
        p->state = RUNNABLE;
    80001576:	478d                	li	a5,3
    80001578:	cc9c                	sw	a5,24(s1)
    8000157a:	b7dd                	j	80001560 <kkill+0x4a>

000000008000157c <setkilled>:

void
setkilled(struct proc *p)
{
    8000157c:	1101                	addi	sp,sp,-32
    8000157e:	ec06                	sd	ra,24(sp)
    80001580:	e822                	sd	s0,16(sp)
    80001582:	e426                	sd	s1,8(sp)
    80001584:	1000                	addi	s0,sp,32
    80001586:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001588:	2da040ef          	jal	80005862 <acquire>
  p->killed = 1;
    8000158c:	4785                	li	a5,1
    8000158e:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001590:	8526                	mv	a0,s1
    80001592:	364040ef          	jal	800058f6 <release>
}
    80001596:	60e2                	ld	ra,24(sp)
    80001598:	6442                	ld	s0,16(sp)
    8000159a:	64a2                	ld	s1,8(sp)
    8000159c:	6105                	addi	sp,sp,32
    8000159e:	8082                	ret

00000000800015a0 <killed>:

int
killed(struct proc *p)
{
    800015a0:	1101                	addi	sp,sp,-32
    800015a2:	ec06                	sd	ra,24(sp)
    800015a4:	e822                	sd	s0,16(sp)
    800015a6:	e426                	sd	s1,8(sp)
    800015a8:	e04a                	sd	s2,0(sp)
    800015aa:	1000                	addi	s0,sp,32
    800015ac:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    800015ae:	2b4040ef          	jal	80005862 <acquire>
  k = p->killed;
    800015b2:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    800015b6:	8526                	mv	a0,s1
    800015b8:	33e040ef          	jal	800058f6 <release>
  return k;
}
    800015bc:	854a                	mv	a0,s2
    800015be:	60e2                	ld	ra,24(sp)
    800015c0:	6442                	ld	s0,16(sp)
    800015c2:	64a2                	ld	s1,8(sp)
    800015c4:	6902                	ld	s2,0(sp)
    800015c6:	6105                	addi	sp,sp,32
    800015c8:	8082                	ret

00000000800015ca <kwait>:
{
    800015ca:	715d                	addi	sp,sp,-80
    800015cc:	e486                	sd	ra,72(sp)
    800015ce:	e0a2                	sd	s0,64(sp)
    800015d0:	fc26                	sd	s1,56(sp)
    800015d2:	f84a                	sd	s2,48(sp)
    800015d4:	f44e                	sd	s3,40(sp)
    800015d6:	f052                	sd	s4,32(sp)
    800015d8:	ec56                	sd	s5,24(sp)
    800015da:	e85a                	sd	s6,16(sp)
    800015dc:	e45e                	sd	s7,8(sp)
    800015de:	0880                	addi	s0,sp,80
    800015e0:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800015e2:	f8eff0ef          	jal	80000d70 <myproc>
    800015e6:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800015e8:	00009517          	auipc	a0,0x9
    800015ec:	c9050513          	addi	a0,a0,-880 # 8000a278 <wait_lock>
    800015f0:	272040ef          	jal	80005862 <acquire>
        if(pp->state == ZOMBIE){
    800015f4:	4a15                	li	s4,5
        havekids = 1;
    800015f6:	4a85                	li	s5,1
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800015f8:	0000f997          	auipc	s3,0xf
    800015fc:	a9898993          	addi	s3,s3,-1384 # 80010090 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001600:	00009b97          	auipc	s7,0x9
    80001604:	c78b8b93          	addi	s7,s7,-904 # 8000a278 <wait_lock>
    80001608:	a869                	j	800016a2 <kwait+0xd8>
          pid = pp->pid;
    8000160a:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    8000160e:	000b0c63          	beqz	s6,80001626 <kwait+0x5c>
    80001612:	4691                	li	a3,4
    80001614:	02c48613          	addi	a2,s1,44
    80001618:	85da                	mv	a1,s6
    8000161a:	05093503          	ld	a0,80(s2)
    8000161e:	c84ff0ef          	jal	80000aa2 <copyout>
    80001622:	02054a63          	bltz	a0,80001656 <kwait+0x8c>
          freeproc(pp);
    80001626:	8526                	mv	a0,s1
    80001628:	919ff0ef          	jal	80000f40 <freeproc>
          release(&pp->lock);
    8000162c:	8526                	mv	a0,s1
    8000162e:	2c8040ef          	jal	800058f6 <release>
          release(&wait_lock);
    80001632:	00009517          	auipc	a0,0x9
    80001636:	c4650513          	addi	a0,a0,-954 # 8000a278 <wait_lock>
    8000163a:	2bc040ef          	jal	800058f6 <release>
}
    8000163e:	854e                	mv	a0,s3
    80001640:	60a6                	ld	ra,72(sp)
    80001642:	6406                	ld	s0,64(sp)
    80001644:	74e2                	ld	s1,56(sp)
    80001646:	7942                	ld	s2,48(sp)
    80001648:	79a2                	ld	s3,40(sp)
    8000164a:	7a02                	ld	s4,32(sp)
    8000164c:	6ae2                	ld	s5,24(sp)
    8000164e:	6b42                	ld	s6,16(sp)
    80001650:	6ba2                	ld	s7,8(sp)
    80001652:	6161                	addi	sp,sp,80
    80001654:	8082                	ret
            release(&pp->lock);
    80001656:	8526                	mv	a0,s1
    80001658:	29e040ef          	jal	800058f6 <release>
            release(&wait_lock);
    8000165c:	00009517          	auipc	a0,0x9
    80001660:	c1c50513          	addi	a0,a0,-996 # 8000a278 <wait_lock>
    80001664:	292040ef          	jal	800058f6 <release>
            return -1;
    80001668:	59fd                	li	s3,-1
    8000166a:	bfd1                	j	8000163e <kwait+0x74>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000166c:	16848493          	addi	s1,s1,360
    80001670:	03348063          	beq	s1,s3,80001690 <kwait+0xc6>
      if(pp->parent == p){
    80001674:	7c9c                	ld	a5,56(s1)
    80001676:	ff279be3          	bne	a5,s2,8000166c <kwait+0xa2>
        acquire(&pp->lock);
    8000167a:	8526                	mv	a0,s1
    8000167c:	1e6040ef          	jal	80005862 <acquire>
        if(pp->state == ZOMBIE){
    80001680:	4c9c                	lw	a5,24(s1)
    80001682:	f94784e3          	beq	a5,s4,8000160a <kwait+0x40>
        release(&pp->lock);
    80001686:	8526                	mv	a0,s1
    80001688:	26e040ef          	jal	800058f6 <release>
        havekids = 1;
    8000168c:	8756                	mv	a4,s5
    8000168e:	bff9                	j	8000166c <kwait+0xa2>
    if(!havekids || killed(p)){
    80001690:	cf19                	beqz	a4,800016ae <kwait+0xe4>
    80001692:	854a                	mv	a0,s2
    80001694:	f0dff0ef          	jal	800015a0 <killed>
    80001698:	e919                	bnez	a0,800016ae <kwait+0xe4>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    8000169a:	85de                	mv	a1,s7
    8000169c:	854a                	mv	a0,s2
    8000169e:	ccbff0ef          	jal	80001368 <sleep>
    havekids = 0;
    800016a2:	4701                	li	a4,0
    for(pp = proc; pp < &proc[NPROC]; pp++){
    800016a4:	00009497          	auipc	s1,0x9
    800016a8:	fec48493          	addi	s1,s1,-20 # 8000a690 <proc>
    800016ac:	b7e1                	j	80001674 <kwait+0xaa>
      release(&wait_lock);
    800016ae:	00009517          	auipc	a0,0x9
    800016b2:	bca50513          	addi	a0,a0,-1078 # 8000a278 <wait_lock>
    800016b6:	240040ef          	jal	800058f6 <release>
      return -1;
    800016ba:	59fd                	li	s3,-1
    800016bc:	b749                	j	8000163e <kwait+0x74>

00000000800016be <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800016be:	7179                	addi	sp,sp,-48
    800016c0:	f406                	sd	ra,40(sp)
    800016c2:	f022                	sd	s0,32(sp)
    800016c4:	ec26                	sd	s1,24(sp)
    800016c6:	e84a                	sd	s2,16(sp)
    800016c8:	e44e                	sd	s3,8(sp)
    800016ca:	e052                	sd	s4,0(sp)
    800016cc:	1800                	addi	s0,sp,48
    800016ce:	84aa                	mv	s1,a0
    800016d0:	892e                	mv	s2,a1
    800016d2:	89b2                	mv	s3,a2
    800016d4:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800016d6:	e9aff0ef          	jal	80000d70 <myproc>
  if(user_dst){
    800016da:	cc99                	beqz	s1,800016f8 <either_copyout+0x3a>
    return copyout(p->pagetable, dst, src, len);
    800016dc:	86d2                	mv	a3,s4
    800016de:	864e                	mv	a2,s3
    800016e0:	85ca                	mv	a1,s2
    800016e2:	6928                	ld	a0,80(a0)
    800016e4:	bbeff0ef          	jal	80000aa2 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800016e8:	70a2                	ld	ra,40(sp)
    800016ea:	7402                	ld	s0,32(sp)
    800016ec:	64e2                	ld	s1,24(sp)
    800016ee:	6942                	ld	s2,16(sp)
    800016f0:	69a2                	ld	s3,8(sp)
    800016f2:	6a02                	ld	s4,0(sp)
    800016f4:	6145                	addi	sp,sp,48
    800016f6:	8082                	ret
    memmove((char *)dst, src, len);
    800016f8:	000a061b          	sext.w	a2,s4
    800016fc:	85ce                	mv	a1,s3
    800016fe:	854a                	mv	a0,s2
    80001700:	ab3fe0ef          	jal	800001b2 <memmove>
    return 0;
    80001704:	8526                	mv	a0,s1
    80001706:	b7cd                	j	800016e8 <either_copyout+0x2a>

0000000080001708 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001708:	7179                	addi	sp,sp,-48
    8000170a:	f406                	sd	ra,40(sp)
    8000170c:	f022                	sd	s0,32(sp)
    8000170e:	ec26                	sd	s1,24(sp)
    80001710:	e84a                	sd	s2,16(sp)
    80001712:	e44e                	sd	s3,8(sp)
    80001714:	e052                	sd	s4,0(sp)
    80001716:	1800                	addi	s0,sp,48
    80001718:	892a                	mv	s2,a0
    8000171a:	84ae                	mv	s1,a1
    8000171c:	89b2                	mv	s3,a2
    8000171e:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001720:	e50ff0ef          	jal	80000d70 <myproc>
  if(user_src){
    80001724:	cc99                	beqz	s1,80001742 <either_copyin+0x3a>
    return copyin(p->pagetable, dst, src, len);
    80001726:	86d2                	mv	a3,s4
    80001728:	864e                	mv	a2,s3
    8000172a:	85ca                	mv	a1,s2
    8000172c:	6928                	ld	a0,80(a0)
    8000172e:	c32ff0ef          	jal	80000b60 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001732:	70a2                	ld	ra,40(sp)
    80001734:	7402                	ld	s0,32(sp)
    80001736:	64e2                	ld	s1,24(sp)
    80001738:	6942                	ld	s2,16(sp)
    8000173a:	69a2                	ld	s3,8(sp)
    8000173c:	6a02                	ld	s4,0(sp)
    8000173e:	6145                	addi	sp,sp,48
    80001740:	8082                	ret
    memmove(dst, (char*)src, len);
    80001742:	000a061b          	sext.w	a2,s4
    80001746:	85ce                	mv	a1,s3
    80001748:	854a                	mv	a0,s2
    8000174a:	a69fe0ef          	jal	800001b2 <memmove>
    return 0;
    8000174e:	8526                	mv	a0,s1
    80001750:	b7cd                	j	80001732 <either_copyin+0x2a>

0000000080001752 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001752:	715d                	addi	sp,sp,-80
    80001754:	e486                	sd	ra,72(sp)
    80001756:	e0a2                	sd	s0,64(sp)
    80001758:	fc26                	sd	s1,56(sp)
    8000175a:	f84a                	sd	s2,48(sp)
    8000175c:	f44e                	sd	s3,40(sp)
    8000175e:	f052                	sd	s4,32(sp)
    80001760:	ec56                	sd	s5,24(sp)
    80001762:	e85a                	sd	s6,16(sp)
    80001764:	e45e                	sd	s7,8(sp)
    80001766:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001768:	00006517          	auipc	a0,0x6
    8000176c:	8b050513          	addi	a0,a0,-1872 # 80007018 <etext+0x18>
    80001770:	353030ef          	jal	800052c2 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001774:	00009497          	auipc	s1,0x9
    80001778:	07448493          	addi	s1,s1,116 # 8000a7e8 <proc+0x158>
    8000177c:	0000f917          	auipc	s2,0xf
    80001780:	a6c90913          	addi	s2,s2,-1428 # 800101e8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001784:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001786:	00006997          	auipc	s3,0x6
    8000178a:	a1a98993          	addi	s3,s3,-1510 # 800071a0 <etext+0x1a0>
    printf("%d %s %s", p->pid, state, p->name);
    8000178e:	00006a97          	auipc	s5,0x6
    80001792:	a1aa8a93          	addi	s5,s5,-1510 # 800071a8 <etext+0x1a8>
    printf("\n");
    80001796:	00006a17          	auipc	s4,0x6
    8000179a:	882a0a13          	addi	s4,s4,-1918 # 80007018 <etext+0x18>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000179e:	00006b97          	auipc	s7,0x6
    800017a2:	f72b8b93          	addi	s7,s7,-142 # 80007710 <states.0>
    800017a6:	a829                	j	800017c0 <procdump+0x6e>
    printf("%d %s %s", p->pid, state, p->name);
    800017a8:	ed86a583          	lw	a1,-296(a3)
    800017ac:	8556                	mv	a0,s5
    800017ae:	315030ef          	jal	800052c2 <printf>
    printf("\n");
    800017b2:	8552                	mv	a0,s4
    800017b4:	30f030ef          	jal	800052c2 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800017b8:	16848493          	addi	s1,s1,360
    800017bc:	03248263          	beq	s1,s2,800017e0 <procdump+0x8e>
    if(p->state == UNUSED)
    800017c0:	86a6                	mv	a3,s1
    800017c2:	ec04a783          	lw	a5,-320(s1)
    800017c6:	dbed                	beqz	a5,800017b8 <procdump+0x66>
      state = "???";
    800017c8:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800017ca:	fcfb6fe3          	bltu	s6,a5,800017a8 <procdump+0x56>
    800017ce:	02079713          	slli	a4,a5,0x20
    800017d2:	01d75793          	srli	a5,a4,0x1d
    800017d6:	97de                	add	a5,a5,s7
    800017d8:	6390                	ld	a2,0(a5)
    800017da:	f679                	bnez	a2,800017a8 <procdump+0x56>
      state = "???";
    800017dc:	864e                	mv	a2,s3
    800017de:	b7e9                	j	800017a8 <procdump+0x56>
  }
}
    800017e0:	60a6                	ld	ra,72(sp)
    800017e2:	6406                	ld	s0,64(sp)
    800017e4:	74e2                	ld	s1,56(sp)
    800017e6:	7942                	ld	s2,48(sp)
    800017e8:	79a2                	ld	s3,40(sp)
    800017ea:	7a02                	ld	s4,32(sp)
    800017ec:	6ae2                	ld	s5,24(sp)
    800017ee:	6b42                	ld	s6,16(sp)
    800017f0:	6ba2                	ld	s7,8(sp)
    800017f2:	6161                	addi	sp,sp,80
    800017f4:	8082                	ret

00000000800017f6 <swtch>:
# Save current registers in old. Load from new.	


.globl swtch
swtch:
        sd ra, 0(a0)
    800017f6:	00153023          	sd	ra,0(a0)
        sd sp, 8(a0)
    800017fa:	00253423          	sd	sp,8(a0)
        sd s0, 16(a0)
    800017fe:	e900                	sd	s0,16(a0)
        sd s1, 24(a0)
    80001800:	ed04                	sd	s1,24(a0)
        sd s2, 32(a0)
    80001802:	03253023          	sd	s2,32(a0)
        sd s3, 40(a0)
    80001806:	03353423          	sd	s3,40(a0)
        sd s4, 48(a0)
    8000180a:	03453823          	sd	s4,48(a0)
        sd s5, 56(a0)
    8000180e:	03553c23          	sd	s5,56(a0)
        sd s6, 64(a0)
    80001812:	05653023          	sd	s6,64(a0)
        sd s7, 72(a0)
    80001816:	05753423          	sd	s7,72(a0)
        sd s8, 80(a0)
    8000181a:	05853823          	sd	s8,80(a0)
        sd s9, 88(a0)
    8000181e:	05953c23          	sd	s9,88(a0)
        sd s10, 96(a0)
    80001822:	07a53023          	sd	s10,96(a0)
        sd s11, 104(a0)
    80001826:	07b53423          	sd	s11,104(a0)

        ld ra, 0(a1)
    8000182a:	0005b083          	ld	ra,0(a1)
        ld sp, 8(a1)
    8000182e:	0085b103          	ld	sp,8(a1)
        ld s0, 16(a1)
    80001832:	6980                	ld	s0,16(a1)
        ld s1, 24(a1)
    80001834:	6d84                	ld	s1,24(a1)
        ld s2, 32(a1)
    80001836:	0205b903          	ld	s2,32(a1)
        ld s3, 40(a1)
    8000183a:	0285b983          	ld	s3,40(a1)
        ld s4, 48(a1)
    8000183e:	0305ba03          	ld	s4,48(a1)
        ld s5, 56(a1)
    80001842:	0385ba83          	ld	s5,56(a1)
        ld s6, 64(a1)
    80001846:	0405bb03          	ld	s6,64(a1)
        ld s7, 72(a1)
    8000184a:	0485bb83          	ld	s7,72(a1)
        ld s8, 80(a1)
    8000184e:	0505bc03          	ld	s8,80(a1)
        ld s9, 88(a1)
    80001852:	0585bc83          	ld	s9,88(a1)
        ld s10, 96(a1)
    80001856:	0605bd03          	ld	s10,96(a1)
        ld s11, 104(a1)
    8000185a:	0685bd83          	ld	s11,104(a1)
        
        ret
    8000185e:	8082                	ret

0000000080001860 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001860:	1141                	addi	sp,sp,-16
    80001862:	e406                	sd	ra,8(sp)
    80001864:	e022                	sd	s0,0(sp)
    80001866:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001868:	00006597          	auipc	a1,0x6
    8000186c:	98058593          	addi	a1,a1,-1664 # 800071e8 <etext+0x1e8>
    80001870:	0000f517          	auipc	a0,0xf
    80001874:	82050513          	addi	a0,a0,-2016 # 80010090 <tickslock>
    80001878:	767030ef          	jal	800057de <initlock>
}
    8000187c:	60a2                	ld	ra,8(sp)
    8000187e:	6402                	ld	s0,0(sp)
    80001880:	0141                	addi	sp,sp,16
    80001882:	8082                	ret

0000000080001884 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001884:	1141                	addi	sp,sp,-16
    80001886:	e406                	sd	ra,8(sp)
    80001888:	e022                	sd	s0,0(sp)
    8000188a:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000188c:	00003797          	auipc	a5,0x3
    80001890:	f7478793          	addi	a5,a5,-140 # 80004800 <kernelvec>
    80001894:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001898:	60a2                	ld	ra,8(sp)
    8000189a:	6402                	ld	s0,0(sp)
    8000189c:	0141                	addi	sp,sp,16
    8000189e:	8082                	ret

00000000800018a0 <prepare_return>:
//
// set up trapframe and control registers for a return to user space
//
void
prepare_return(void)
{
    800018a0:	1141                	addi	sp,sp,-16
    800018a2:	e406                	sd	ra,8(sp)
    800018a4:	e022                	sd	s0,0(sp)
    800018a6:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800018a8:	cc8ff0ef          	jal	80000d70 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018ac:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800018b0:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800018b2:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(). because a trap from kernel
  // code to usertrap would be a disaster, turn off interrupts.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    800018b6:	04000737          	lui	a4,0x4000
    800018ba:	177d                	addi	a4,a4,-1 # 3ffffff <_entry-0x7c000001>
    800018bc:	0732                	slli	a4,a4,0xc
    800018be:	00004797          	auipc	a5,0x4
    800018c2:	74278793          	addi	a5,a5,1858 # 80006000 <_trampoline>
    800018c6:	00004697          	auipc	a3,0x4
    800018ca:	73a68693          	addi	a3,a3,1850 # 80006000 <_trampoline>
    800018ce:	8f95                	sub	a5,a5,a3
    800018d0:	97ba                	add	a5,a5,a4
  asm volatile("csrw stvec, %0" : : "r" (x));
    800018d2:	10579073          	csrw	stvec,a5
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    800018d6:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    800018d8:	18002773          	csrr	a4,satp
    800018dc:	e398                	sd	a4,0(a5)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    800018de:	6d38                	ld	a4,88(a0)
    800018e0:	613c                	ld	a5,64(a0)
    800018e2:	6685                	lui	a3,0x1
    800018e4:	97b6                	add	a5,a5,a3
    800018e6:	e71c                	sd	a5,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    800018e8:	6d3c                	ld	a5,88(a0)
    800018ea:	00000717          	auipc	a4,0x0
    800018ee:	0f870713          	addi	a4,a4,248 # 800019e2 <usertrap>
    800018f2:	eb98                	sd	a4,16(a5)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    800018f4:	6d3c                	ld	a5,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    800018f6:	8712                	mv	a4,tp
    800018f8:	f398                	sd	a4,32(a5)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800018fa:	100027f3          	csrr	a5,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    800018fe:	eff7f793          	andi	a5,a5,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001902:	0207e793          	ori	a5,a5,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001906:	10079073          	csrw	sstatus,a5
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    8000190a:	6d3c                	ld	a5,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    8000190c:	6f9c                	ld	a5,24(a5)
    8000190e:	14179073          	csrw	sepc,a5
}
    80001912:	60a2                	ld	ra,8(sp)
    80001914:	6402                	ld	s0,0(sp)
    80001916:	0141                	addi	sp,sp,16
    80001918:	8082                	ret

000000008000191a <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    8000191a:	1101                	addi	sp,sp,-32
    8000191c:	ec06                	sd	ra,24(sp)
    8000191e:	e822                	sd	s0,16(sp)
    80001920:	1000                	addi	s0,sp,32
  if(cpuid() == 0){
    80001922:	c1aff0ef          	jal	80000d3c <cpuid>
    80001926:	cd11                	beqz	a0,80001942 <clockintr+0x28>
  asm volatile("csrr %0, time" : "=r" (x) );
    80001928:	c01027f3          	rdtime	a5
  }

  // ask for the next timer interrupt. this also clears
  // the interrupt request. 1000000 is about a tenth
  // of a second.
  w_stimecmp(r_time() + 1000000);
    8000192c:	000f4737          	lui	a4,0xf4
    80001930:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80001934:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80001936:	14d79073          	csrw	stimecmp,a5
}
    8000193a:	60e2                	ld	ra,24(sp)
    8000193c:	6442                	ld	s0,16(sp)
    8000193e:	6105                	addi	sp,sp,32
    80001940:	8082                	ret
    80001942:	e426                	sd	s1,8(sp)
    acquire(&tickslock);
    80001944:	0000e497          	auipc	s1,0xe
    80001948:	74c48493          	addi	s1,s1,1868 # 80010090 <tickslock>
    8000194c:	8526                	mv	a0,s1
    8000194e:	715030ef          	jal	80005862 <acquire>
    ticks++;
    80001952:	00009517          	auipc	a0,0x9
    80001956:	8d650513          	addi	a0,a0,-1834 # 8000a228 <ticks>
    8000195a:	411c                	lw	a5,0(a0)
    8000195c:	2785                	addiw	a5,a5,1
    8000195e:	c11c                	sw	a5,0(a0)
    wakeup(&ticks);
    80001960:	a55ff0ef          	jal	800013b4 <wakeup>
    release(&tickslock);
    80001964:	8526                	mv	a0,s1
    80001966:	791030ef          	jal	800058f6 <release>
    8000196a:	64a2                	ld	s1,8(sp)
    8000196c:	bf75                	j	80001928 <clockintr+0xe>

000000008000196e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    8000196e:	1101                	addi	sp,sp,-32
    80001970:	ec06                	sd	ra,24(sp)
    80001972:	e822                	sd	s0,16(sp)
    80001974:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001976:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if(scause == 0x8000000000000009L){
    8000197a:	57fd                	li	a5,-1
    8000197c:	17fe                	slli	a5,a5,0x3f
    8000197e:	07a5                	addi	a5,a5,9
    80001980:	00f70c63          	beq	a4,a5,80001998 <devintr+0x2a>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000005L){
    80001984:	57fd                	li	a5,-1
    80001986:	17fe                	slli	a5,a5,0x3f
    80001988:	0795                	addi	a5,a5,5
    // timer interrupt.
    clockintr();
    return 2;
  } else {
    return 0;
    8000198a:	4501                	li	a0,0
  } else if(scause == 0x8000000000000005L){
    8000198c:	04f70763          	beq	a4,a5,800019da <devintr+0x6c>
  }
}
    80001990:	60e2                	ld	ra,24(sp)
    80001992:	6442                	ld	s0,16(sp)
    80001994:	6105                	addi	sp,sp,32
    80001996:	8082                	ret
    80001998:	e426                	sd	s1,8(sp)
    int irq = plic_claim();
    8000199a:	713020ef          	jal	800048ac <plic_claim>
    8000199e:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800019a0:	47a9                	li	a5,10
    800019a2:	00f50963          	beq	a0,a5,800019b4 <devintr+0x46>
    } else if(irq == VIRTIO0_IRQ){
    800019a6:	4785                	li	a5,1
    800019a8:	00f50963          	beq	a0,a5,800019ba <devintr+0x4c>
    return 1;
    800019ac:	4505                	li	a0,1
    } else if(irq){
    800019ae:	e889                	bnez	s1,800019c0 <devintr+0x52>
    800019b0:	64a2                	ld	s1,8(sp)
    800019b2:	bff9                	j	80001990 <devintr+0x22>
      uartintr();
    800019b4:	5c3030ef          	jal	80005776 <uartintr>
    if(irq)
    800019b8:	a819                	j	800019ce <devintr+0x60>
      virtio_disk_intr();
    800019ba:	382030ef          	jal	80004d3c <virtio_disk_intr>
    if(irq)
    800019be:	a801                	j	800019ce <devintr+0x60>
      printf("unexpected interrupt irq=%d\n", irq);
    800019c0:	85a6                	mv	a1,s1
    800019c2:	00006517          	auipc	a0,0x6
    800019c6:	82e50513          	addi	a0,a0,-2002 # 800071f0 <etext+0x1f0>
    800019ca:	0f9030ef          	jal	800052c2 <printf>
      plic_complete(irq);
    800019ce:	8526                	mv	a0,s1
    800019d0:	6fd020ef          	jal	800048cc <plic_complete>
    return 1;
    800019d4:	4505                	li	a0,1
    800019d6:	64a2                	ld	s1,8(sp)
    800019d8:	bf65                	j	80001990 <devintr+0x22>
    clockintr();
    800019da:	f41ff0ef          	jal	8000191a <clockintr>
    return 2;
    800019de:	4509                	li	a0,2
    800019e0:	bf45                	j	80001990 <devintr+0x22>

00000000800019e2 <usertrap>:
{
    800019e2:	1101                	addi	sp,sp,-32
    800019e4:	ec06                	sd	ra,24(sp)
    800019e6:	e822                	sd	s0,16(sp)
    800019e8:	e426                	sd	s1,8(sp)
    800019ea:	e04a                	sd	s2,0(sp)
    800019ec:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800019ee:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    800019f2:	1007f793          	andi	a5,a5,256
    800019f6:	eba5                	bnez	a5,80001a66 <usertrap+0x84>
  asm volatile("csrw stvec, %0" : : "r" (x));
    800019f8:	00003797          	auipc	a5,0x3
    800019fc:	e0878793          	addi	a5,a5,-504 # 80004800 <kernelvec>
    80001a00:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001a04:	b6cff0ef          	jal	80000d70 <myproc>
    80001a08:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001a0a:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a0c:	14102773          	csrr	a4,sepc
    80001a10:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001a12:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001a16:	47a1                	li	a5,8
    80001a18:	04f70d63          	beq	a4,a5,80001a72 <usertrap+0x90>
  } else if((which_dev = devintr()) != 0){
    80001a1c:	f53ff0ef          	jal	8000196e <devintr>
    80001a20:	892a                	mv	s2,a0
    80001a22:	e945                	bnez	a0,80001ad2 <usertrap+0xf0>
    80001a24:	14202773          	csrr	a4,scause
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001a28:	47bd                	li	a5,15
    80001a2a:	08f70863          	beq	a4,a5,80001aba <usertrap+0xd8>
    80001a2e:	14202773          	csrr	a4,scause
    80001a32:	47b5                	li	a5,13
    80001a34:	08f70363          	beq	a4,a5,80001aba <usertrap+0xd8>
    80001a38:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause 0x%lx pid=%d\n", r_scause(), p->pid);
    80001a3c:	5890                	lw	a2,48(s1)
    80001a3e:	00005517          	auipc	a0,0x5
    80001a42:	7f250513          	addi	a0,a0,2034 # 80007230 <etext+0x230>
    80001a46:	07d030ef          	jal	800052c2 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001a4a:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001a4e:	14302673          	csrr	a2,stval
    printf("            sepc=0x%lx stval=0x%lx\n", r_sepc(), r_stval());
    80001a52:	00006517          	auipc	a0,0x6
    80001a56:	80e50513          	addi	a0,a0,-2034 # 80007260 <etext+0x260>
    80001a5a:	069030ef          	jal	800052c2 <printf>
    setkilled(p);
    80001a5e:	8526                	mv	a0,s1
    80001a60:	b1dff0ef          	jal	8000157c <setkilled>
    80001a64:	a035                	j	80001a90 <usertrap+0xae>
    panic("usertrap: not from user mode");
    80001a66:	00005517          	auipc	a0,0x5
    80001a6a:	7aa50513          	addi	a0,a0,1962 # 80007210 <etext+0x210>
    80001a6e:	339030ef          	jal	800055a6 <panic>
    if(killed(p))
    80001a72:	b2fff0ef          	jal	800015a0 <killed>
    80001a76:	ed15                	bnez	a0,80001ab2 <usertrap+0xd0>
    p->trapframe->epc += 4;
    80001a78:	6cb8                	ld	a4,88(s1)
    80001a7a:	6f1c                	ld	a5,24(a4)
    80001a7c:	0791                	addi	a5,a5,4
    80001a7e:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001a80:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001a84:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001a88:	10079073          	csrw	sstatus,a5
    syscall();
    80001a8c:	23e000ef          	jal	80001cca <syscall>
  if(killed(p))
    80001a90:	8526                	mv	a0,s1
    80001a92:	b0fff0ef          	jal	800015a0 <killed>
    80001a96:	e139                	bnez	a0,80001adc <usertrap+0xfa>
  prepare_return();
    80001a98:	e09ff0ef          	jal	800018a0 <prepare_return>
  uint64 satp = MAKE_SATP(p->pagetable);
    80001a9c:	68a8                	ld	a0,80(s1)
    80001a9e:	8131                	srli	a0,a0,0xc
    80001aa0:	57fd                	li	a5,-1
    80001aa2:	17fe                	slli	a5,a5,0x3f
    80001aa4:	8d5d                	or	a0,a0,a5
}
    80001aa6:	60e2                	ld	ra,24(sp)
    80001aa8:	6442                	ld	s0,16(sp)
    80001aaa:	64a2                	ld	s1,8(sp)
    80001aac:	6902                	ld	s2,0(sp)
    80001aae:	6105                	addi	sp,sp,32
    80001ab0:	8082                	ret
      kexit(-1);
    80001ab2:	557d                	li	a0,-1
    80001ab4:	9c1ff0ef          	jal	80001474 <kexit>
    80001ab8:	b7c1                	j	80001a78 <usertrap+0x96>
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001aba:	143025f3          	csrr	a1,stval
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001abe:	14202673          	csrr	a2,scause
            vmfault(p->pagetable, r_stval(), (r_scause() == 13)? 1 : 0) != 0) {
    80001ac2:	164d                	addi	a2,a2,-13 # ff3 <_entry-0x7ffff00d>
    80001ac4:	00163613          	seqz	a2,a2
    80001ac8:	68a8                	ld	a0,80(s1)
    80001aca:	f57fe0ef          	jal	80000a20 <vmfault>
  } else if((r_scause() == 15 || r_scause() == 13) &&
    80001ace:	f169                	bnez	a0,80001a90 <usertrap+0xae>
    80001ad0:	b7a5                	j	80001a38 <usertrap+0x56>
  if(killed(p))
    80001ad2:	8526                	mv	a0,s1
    80001ad4:	acdff0ef          	jal	800015a0 <killed>
    80001ad8:	c511                	beqz	a0,80001ae4 <usertrap+0x102>
    80001ada:	a011                	j	80001ade <usertrap+0xfc>
    80001adc:	4901                	li	s2,0
    kexit(-1);
    80001ade:	557d                	li	a0,-1
    80001ae0:	995ff0ef          	jal	80001474 <kexit>
  if(which_dev == 2)
    80001ae4:	4789                	li	a5,2
    80001ae6:	faf919e3          	bne	s2,a5,80001a98 <usertrap+0xb6>
    yield();
    80001aea:	853ff0ef          	jal	8000133c <yield>
    80001aee:	b76d                	j	80001a98 <usertrap+0xb6>

0000000080001af0 <kerneltrap>:
{
    80001af0:	7179                	addi	sp,sp,-48
    80001af2:	f406                	sd	ra,40(sp)
    80001af4:	f022                	sd	s0,32(sp)
    80001af6:	ec26                	sd	s1,24(sp)
    80001af8:	e84a                	sd	s2,16(sp)
    80001afa:	e44e                	sd	s3,8(sp)
    80001afc:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001afe:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b02:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001b06:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001b0a:	1004f793          	andi	a5,s1,256
    80001b0e:	c795                	beqz	a5,80001b3a <kerneltrap+0x4a>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b10:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001b14:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001b16:	eb85                	bnez	a5,80001b46 <kerneltrap+0x56>
  if((which_dev = devintr()) == 0){
    80001b18:	e57ff0ef          	jal	8000196e <devintr>
    80001b1c:	c91d                	beqz	a0,80001b52 <kerneltrap+0x62>
  if(which_dev == 2 && myproc() != 0)
    80001b1e:	4789                	li	a5,2
    80001b20:	04f50a63          	beq	a0,a5,80001b74 <kerneltrap+0x84>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b24:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b28:	10049073          	csrw	sstatus,s1
}
    80001b2c:	70a2                	ld	ra,40(sp)
    80001b2e:	7402                	ld	s0,32(sp)
    80001b30:	64e2                	ld	s1,24(sp)
    80001b32:	6942                	ld	s2,16(sp)
    80001b34:	69a2                	ld	s3,8(sp)
    80001b36:	6145                	addi	sp,sp,48
    80001b38:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001b3a:	00005517          	auipc	a0,0x5
    80001b3e:	74e50513          	addi	a0,a0,1870 # 80007288 <etext+0x288>
    80001b42:	265030ef          	jal	800055a6 <panic>
    panic("kerneltrap: interrupts enabled");
    80001b46:	00005517          	auipc	a0,0x5
    80001b4a:	76a50513          	addi	a0,a0,1898 # 800072b0 <etext+0x2b0>
    80001b4e:	259030ef          	jal	800055a6 <panic>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001b52:	14102673          	csrr	a2,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001b56:	143026f3          	csrr	a3,stval
    printf("scause=0x%lx sepc=0x%lx stval=0x%lx\n", scause, r_sepc(), r_stval());
    80001b5a:	85ce                	mv	a1,s3
    80001b5c:	00005517          	auipc	a0,0x5
    80001b60:	77450513          	addi	a0,a0,1908 # 800072d0 <etext+0x2d0>
    80001b64:	75e030ef          	jal	800052c2 <printf>
    panic("kerneltrap");
    80001b68:	00005517          	auipc	a0,0x5
    80001b6c:	79050513          	addi	a0,a0,1936 # 800072f8 <etext+0x2f8>
    80001b70:	237030ef          	jal	800055a6 <panic>
  if(which_dev == 2 && myproc() != 0)
    80001b74:	9fcff0ef          	jal	80000d70 <myproc>
    80001b78:	d555                	beqz	a0,80001b24 <kerneltrap+0x34>
    yield();
    80001b7a:	fc2ff0ef          	jal	8000133c <yield>
    80001b7e:	b75d                	j	80001b24 <kerneltrap+0x34>

0000000080001b80 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001b80:	1101                	addi	sp,sp,-32
    80001b82:	ec06                	sd	ra,24(sp)
    80001b84:	e822                	sd	s0,16(sp)
    80001b86:	e426                	sd	s1,8(sp)
    80001b88:	1000                	addi	s0,sp,32
    80001b8a:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001b8c:	9e4ff0ef          	jal	80000d70 <myproc>
  switch (n) {
    80001b90:	4795                	li	a5,5
    80001b92:	0497e163          	bltu	a5,s1,80001bd4 <argraw+0x54>
    80001b96:	048a                	slli	s1,s1,0x2
    80001b98:	00006717          	auipc	a4,0x6
    80001b9c:	ba870713          	addi	a4,a4,-1112 # 80007740 <states.0+0x30>
    80001ba0:	94ba                	add	s1,s1,a4
    80001ba2:	409c                	lw	a5,0(s1)
    80001ba4:	97ba                	add	a5,a5,a4
    80001ba6:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001ba8:	6d3c                	ld	a5,88(a0)
    80001baa:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001bac:	60e2                	ld	ra,24(sp)
    80001bae:	6442                	ld	s0,16(sp)
    80001bb0:	64a2                	ld	s1,8(sp)
    80001bb2:	6105                	addi	sp,sp,32
    80001bb4:	8082                	ret
    return p->trapframe->a1;
    80001bb6:	6d3c                	ld	a5,88(a0)
    80001bb8:	7fa8                	ld	a0,120(a5)
    80001bba:	bfcd                	j	80001bac <argraw+0x2c>
    return p->trapframe->a2;
    80001bbc:	6d3c                	ld	a5,88(a0)
    80001bbe:	63c8                	ld	a0,128(a5)
    80001bc0:	b7f5                	j	80001bac <argraw+0x2c>
    return p->trapframe->a3;
    80001bc2:	6d3c                	ld	a5,88(a0)
    80001bc4:	67c8                	ld	a0,136(a5)
    80001bc6:	b7dd                	j	80001bac <argraw+0x2c>
    return p->trapframe->a4;
    80001bc8:	6d3c                	ld	a5,88(a0)
    80001bca:	6bc8                	ld	a0,144(a5)
    80001bcc:	b7c5                	j	80001bac <argraw+0x2c>
    return p->trapframe->a5;
    80001bce:	6d3c                	ld	a5,88(a0)
    80001bd0:	6fc8                	ld	a0,152(a5)
    80001bd2:	bfe9                	j	80001bac <argraw+0x2c>
  panic("argraw");
    80001bd4:	00005517          	auipc	a0,0x5
    80001bd8:	73450513          	addi	a0,a0,1844 # 80007308 <etext+0x308>
    80001bdc:	1cb030ef          	jal	800055a6 <panic>

0000000080001be0 <fetchaddr>:
{
    80001be0:	1101                	addi	sp,sp,-32
    80001be2:	ec06                	sd	ra,24(sp)
    80001be4:	e822                	sd	s0,16(sp)
    80001be6:	e426                	sd	s1,8(sp)
    80001be8:	e04a                	sd	s2,0(sp)
    80001bea:	1000                	addi	s0,sp,32
    80001bec:	84aa                	mv	s1,a0
    80001bee:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001bf0:	980ff0ef          	jal	80000d70 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001bf4:	653c                	ld	a5,72(a0)
    80001bf6:	02f4f663          	bgeu	s1,a5,80001c22 <fetchaddr+0x42>
    80001bfa:	00848713          	addi	a4,s1,8
    80001bfe:	02e7e463          	bltu	a5,a4,80001c26 <fetchaddr+0x46>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001c02:	46a1                	li	a3,8
    80001c04:	8626                	mv	a2,s1
    80001c06:	85ca                	mv	a1,s2
    80001c08:	6928                	ld	a0,80(a0)
    80001c0a:	f57fe0ef          	jal	80000b60 <copyin>
    80001c0e:	00a03533          	snez	a0,a0
    80001c12:	40a0053b          	negw	a0,a0
}
    80001c16:	60e2                	ld	ra,24(sp)
    80001c18:	6442                	ld	s0,16(sp)
    80001c1a:	64a2                	ld	s1,8(sp)
    80001c1c:	6902                	ld	s2,0(sp)
    80001c1e:	6105                	addi	sp,sp,32
    80001c20:	8082                	ret
    return -1;
    80001c22:	557d                	li	a0,-1
    80001c24:	bfcd                	j	80001c16 <fetchaddr+0x36>
    80001c26:	557d                	li	a0,-1
    80001c28:	b7fd                	j	80001c16 <fetchaddr+0x36>

0000000080001c2a <fetchstr>:
{
    80001c2a:	7179                	addi	sp,sp,-48
    80001c2c:	f406                	sd	ra,40(sp)
    80001c2e:	f022                	sd	s0,32(sp)
    80001c30:	ec26                	sd	s1,24(sp)
    80001c32:	e84a                	sd	s2,16(sp)
    80001c34:	e44e                	sd	s3,8(sp)
    80001c36:	1800                	addi	s0,sp,48
    80001c38:	892a                	mv	s2,a0
    80001c3a:	84ae                	mv	s1,a1
    80001c3c:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001c3e:	932ff0ef          	jal	80000d70 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001c42:	86ce                	mv	a3,s3
    80001c44:	864a                	mv	a2,s2
    80001c46:	85a6                	mv	a1,s1
    80001c48:	6928                	ld	a0,80(a0)
    80001c4a:	d17fe0ef          	jal	80000960 <copyinstr>
    80001c4e:	00054c63          	bltz	a0,80001c66 <fetchstr+0x3c>
  return strlen(buf);
    80001c52:	8526                	mv	a0,s1
    80001c54:	e82fe0ef          	jal	800002d6 <strlen>
}
    80001c58:	70a2                	ld	ra,40(sp)
    80001c5a:	7402                	ld	s0,32(sp)
    80001c5c:	64e2                	ld	s1,24(sp)
    80001c5e:	6942                	ld	s2,16(sp)
    80001c60:	69a2                	ld	s3,8(sp)
    80001c62:	6145                	addi	sp,sp,48
    80001c64:	8082                	ret
    return -1;
    80001c66:	557d                	li	a0,-1
    80001c68:	bfc5                	j	80001c58 <fetchstr+0x2e>

0000000080001c6a <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001c6a:	1101                	addi	sp,sp,-32
    80001c6c:	ec06                	sd	ra,24(sp)
    80001c6e:	e822                	sd	s0,16(sp)
    80001c70:	e426                	sd	s1,8(sp)
    80001c72:	1000                	addi	s0,sp,32
    80001c74:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c76:	f0bff0ef          	jal	80001b80 <argraw>
    80001c7a:	c088                	sw	a0,0(s1)
}
    80001c7c:	60e2                	ld	ra,24(sp)
    80001c7e:	6442                	ld	s0,16(sp)
    80001c80:	64a2                	ld	s1,8(sp)
    80001c82:	6105                	addi	sp,sp,32
    80001c84:	8082                	ret

0000000080001c86 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001c86:	1101                	addi	sp,sp,-32
    80001c88:	ec06                	sd	ra,24(sp)
    80001c8a:	e822                	sd	s0,16(sp)
    80001c8c:	e426                	sd	s1,8(sp)
    80001c8e:	1000                	addi	s0,sp,32
    80001c90:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001c92:	eefff0ef          	jal	80001b80 <argraw>
    80001c96:	e088                	sd	a0,0(s1)
}
    80001c98:	60e2                	ld	ra,24(sp)
    80001c9a:	6442                	ld	s0,16(sp)
    80001c9c:	64a2                	ld	s1,8(sp)
    80001c9e:	6105                	addi	sp,sp,32
    80001ca0:	8082                	ret

0000000080001ca2 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001ca2:	1101                	addi	sp,sp,-32
    80001ca4:	ec06                	sd	ra,24(sp)
    80001ca6:	e822                	sd	s0,16(sp)
    80001ca8:	e426                	sd	s1,8(sp)
    80001caa:	e04a                	sd	s2,0(sp)
    80001cac:	1000                	addi	s0,sp,32
    80001cae:	84ae                	mv	s1,a1
    80001cb0:	8932                	mv	s2,a2
  *ip = argraw(n);
    80001cb2:	ecfff0ef          	jal	80001b80 <argraw>
  uint64 addr;
  argaddr(n, &addr);
  return fetchstr(addr, buf, max);
    80001cb6:	864a                	mv	a2,s2
    80001cb8:	85a6                	mv	a1,s1
    80001cba:	f71ff0ef          	jal	80001c2a <fetchstr>
}
    80001cbe:	60e2                	ld	ra,24(sp)
    80001cc0:	6442                	ld	s0,16(sp)
    80001cc2:	64a2                	ld	s1,8(sp)
    80001cc4:	6902                	ld	s2,0(sp)
    80001cc6:	6105                	addi	sp,sp,32
    80001cc8:	8082                	ret

0000000080001cca <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80001cca:	1101                	addi	sp,sp,-32
    80001ccc:	ec06                	sd	ra,24(sp)
    80001cce:	e822                	sd	s0,16(sp)
    80001cd0:	e426                	sd	s1,8(sp)
    80001cd2:	e04a                	sd	s2,0(sp)
    80001cd4:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001cd6:	89aff0ef          	jal	80000d70 <myproc>
    80001cda:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001cdc:	05853903          	ld	s2,88(a0)
    80001ce0:	0a893783          	ld	a5,168(s2)
    80001ce4:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001ce8:	37fd                	addiw	a5,a5,-1
    80001cea:	4751                	li	a4,20
    80001cec:	00f76f63          	bltu	a4,a5,80001d0a <syscall+0x40>
    80001cf0:	00369713          	slli	a4,a3,0x3
    80001cf4:	00006797          	auipc	a5,0x6
    80001cf8:	a6478793          	addi	a5,a5,-1436 # 80007758 <syscalls>
    80001cfc:	97ba                	add	a5,a5,a4
    80001cfe:	639c                	ld	a5,0(a5)
    80001d00:	c789                	beqz	a5,80001d0a <syscall+0x40>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    80001d02:	9782                	jalr	a5
    80001d04:	06a93823          	sd	a0,112(s2)
    80001d08:	a829                	j	80001d22 <syscall+0x58>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001d0a:	15848613          	addi	a2,s1,344
    80001d0e:	588c                	lw	a1,48(s1)
    80001d10:	00005517          	auipc	a0,0x5
    80001d14:	60050513          	addi	a0,a0,1536 # 80007310 <etext+0x310>
    80001d18:	5aa030ef          	jal	800052c2 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001d1c:	6cbc                	ld	a5,88(s1)
    80001d1e:	577d                	li	a4,-1
    80001d20:	fbb8                	sd	a4,112(a5)
  }
}
    80001d22:	60e2                	ld	ra,24(sp)
    80001d24:	6442                	ld	s0,16(sp)
    80001d26:	64a2                	ld	s1,8(sp)
    80001d28:	6902                	ld	s2,0(sp)
    80001d2a:	6105                	addi	sp,sp,32
    80001d2c:	8082                	ret

0000000080001d2e <sys_exit>:
#include "proc.h"
#include "vm.h"

uint64
sys_exit(void)
{
    80001d2e:	1101                	addi	sp,sp,-32
    80001d30:	ec06                	sd	ra,24(sp)
    80001d32:	e822                	sd	s0,16(sp)
    80001d34:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80001d36:	fec40593          	addi	a1,s0,-20
    80001d3a:	4501                	li	a0,0
    80001d3c:	f2fff0ef          	jal	80001c6a <argint>
  kexit(n);
    80001d40:	fec42503          	lw	a0,-20(s0)
    80001d44:	f30ff0ef          	jal	80001474 <kexit>
  return 0;  // not reached
}
    80001d48:	4501                	li	a0,0
    80001d4a:	60e2                	ld	ra,24(sp)
    80001d4c:	6442                	ld	s0,16(sp)
    80001d4e:	6105                	addi	sp,sp,32
    80001d50:	8082                	ret

0000000080001d52 <sys_getpid>:

uint64
sys_getpid(void)
{
    80001d52:	1141                	addi	sp,sp,-16
    80001d54:	e406                	sd	ra,8(sp)
    80001d56:	e022                	sd	s0,0(sp)
    80001d58:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80001d5a:	816ff0ef          	jal	80000d70 <myproc>
}
    80001d5e:	5908                	lw	a0,48(a0)
    80001d60:	60a2                	ld	ra,8(sp)
    80001d62:	6402                	ld	s0,0(sp)
    80001d64:	0141                	addi	sp,sp,16
    80001d66:	8082                	ret

0000000080001d68 <sys_fork>:

uint64
sys_fork(void)
{
    80001d68:	1141                	addi	sp,sp,-16
    80001d6a:	e406                	sd	ra,8(sp)
    80001d6c:	e022                	sd	s0,0(sp)
    80001d6e:	0800                	addi	s0,sp,16
  return kfork();
    80001d70:	b52ff0ef          	jal	800010c2 <kfork>
}
    80001d74:	60a2                	ld	ra,8(sp)
    80001d76:	6402                	ld	s0,0(sp)
    80001d78:	0141                	addi	sp,sp,16
    80001d7a:	8082                	ret

0000000080001d7c <sys_wait>:

uint64
sys_wait(void)
{
    80001d7c:	1101                	addi	sp,sp,-32
    80001d7e:	ec06                	sd	ra,24(sp)
    80001d80:	e822                	sd	s0,16(sp)
    80001d82:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    80001d84:	fe840593          	addi	a1,s0,-24
    80001d88:	4501                	li	a0,0
    80001d8a:	efdff0ef          	jal	80001c86 <argaddr>
  return kwait(p);
    80001d8e:	fe843503          	ld	a0,-24(s0)
    80001d92:	839ff0ef          	jal	800015ca <kwait>
}
    80001d96:	60e2                	ld	ra,24(sp)
    80001d98:	6442                	ld	s0,16(sp)
    80001d9a:	6105                	addi	sp,sp,32
    80001d9c:	8082                	ret

0000000080001d9e <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80001d9e:	7179                	addi	sp,sp,-48
    80001da0:	f406                	sd	ra,40(sp)
    80001da2:	f022                	sd	s0,32(sp)
    80001da4:	ec26                	sd	s1,24(sp)
    80001da6:	1800                	addi	s0,sp,48
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
    80001da8:	fd840593          	addi	a1,s0,-40
    80001dac:	4501                	li	a0,0
    80001dae:	ebdff0ef          	jal	80001c6a <argint>
  argint(1, &t);
    80001db2:	fdc40593          	addi	a1,s0,-36
    80001db6:	4505                	li	a0,1
    80001db8:	eb3ff0ef          	jal	80001c6a <argint>
  addr = myproc()->sz;
    80001dbc:	fb5fe0ef          	jal	80000d70 <myproc>
    80001dc0:	6524                	ld	s1,72(a0)

  if(t == SBRK_EAGER || n < 0) {
    80001dc2:	fdc42703          	lw	a4,-36(s0)
    80001dc6:	4785                	li	a5,1
    80001dc8:	02f70163          	beq	a4,a5,80001dea <sys_sbrk+0x4c>
    80001dcc:	fd842783          	lw	a5,-40(s0)
    80001dd0:	0007cd63          	bltz	a5,80001dea <sys_sbrk+0x4c>
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
    80001dd4:	97a6                	add	a5,a5,s1
    80001dd6:	0297e863          	bltu	a5,s1,80001e06 <sys_sbrk+0x68>
      return -1;
    myproc()->sz += n;
    80001dda:	f97fe0ef          	jal	80000d70 <myproc>
    80001dde:	fd842703          	lw	a4,-40(s0)
    80001de2:	653c                	ld	a5,72(a0)
    80001de4:	97ba                	add	a5,a5,a4
    80001de6:	e53c                	sd	a5,72(a0)
    80001de8:	a039                	j	80001df6 <sys_sbrk+0x58>
    if(growproc(n) < 0) {
    80001dea:	fd842503          	lw	a0,-40(s0)
    80001dee:	a84ff0ef          	jal	80001072 <growproc>
    80001df2:	00054863          	bltz	a0,80001e02 <sys_sbrk+0x64>
  }
  return addr;
}
    80001df6:	8526                	mv	a0,s1
    80001df8:	70a2                	ld	ra,40(sp)
    80001dfa:	7402                	ld	s0,32(sp)
    80001dfc:	64e2                	ld	s1,24(sp)
    80001dfe:	6145                	addi	sp,sp,48
    80001e00:	8082                	ret
      return -1;
    80001e02:	54fd                	li	s1,-1
    80001e04:	bfcd                	j	80001df6 <sys_sbrk+0x58>
      return -1;
    80001e06:	54fd                	li	s1,-1
    80001e08:	b7fd                	j	80001df6 <sys_sbrk+0x58>

0000000080001e0a <sys_pause>:

uint64
sys_pause(void)
{
    80001e0a:	7139                	addi	sp,sp,-64
    80001e0c:	fc06                	sd	ra,56(sp)
    80001e0e:	f822                	sd	s0,48(sp)
    80001e10:	f04a                	sd	s2,32(sp)
    80001e12:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80001e14:	fcc40593          	addi	a1,s0,-52
    80001e18:	4501                	li	a0,0
    80001e1a:	e51ff0ef          	jal	80001c6a <argint>
  if(n < 0)
    80001e1e:	fcc42783          	lw	a5,-52(s0)
    80001e22:	0607c763          	bltz	a5,80001e90 <sys_pause+0x86>
    n = 0;
  acquire(&tickslock);
    80001e26:	0000e517          	auipc	a0,0xe
    80001e2a:	26a50513          	addi	a0,a0,618 # 80010090 <tickslock>
    80001e2e:	235030ef          	jal	80005862 <acquire>
  ticks0 = ticks;
    80001e32:	00008917          	auipc	s2,0x8
    80001e36:	3f692903          	lw	s2,1014(s2) # 8000a228 <ticks>
  while(ticks - ticks0 < n){
    80001e3a:	fcc42783          	lw	a5,-52(s0)
    80001e3e:	cf8d                	beqz	a5,80001e78 <sys_pause+0x6e>
    80001e40:	f426                	sd	s1,40(sp)
    80001e42:	ec4e                	sd	s3,24(sp)
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80001e44:	0000e997          	auipc	s3,0xe
    80001e48:	24c98993          	addi	s3,s3,588 # 80010090 <tickslock>
    80001e4c:	00008497          	auipc	s1,0x8
    80001e50:	3dc48493          	addi	s1,s1,988 # 8000a228 <ticks>
    if(killed(myproc())){
    80001e54:	f1dfe0ef          	jal	80000d70 <myproc>
    80001e58:	f48ff0ef          	jal	800015a0 <killed>
    80001e5c:	ed0d                	bnez	a0,80001e96 <sys_pause+0x8c>
    sleep(&ticks, &tickslock);
    80001e5e:	85ce                	mv	a1,s3
    80001e60:	8526                	mv	a0,s1
    80001e62:	d06ff0ef          	jal	80001368 <sleep>
  while(ticks - ticks0 < n){
    80001e66:	409c                	lw	a5,0(s1)
    80001e68:	412787bb          	subw	a5,a5,s2
    80001e6c:	fcc42703          	lw	a4,-52(s0)
    80001e70:	fee7e2e3          	bltu	a5,a4,80001e54 <sys_pause+0x4a>
    80001e74:	74a2                	ld	s1,40(sp)
    80001e76:	69e2                	ld	s3,24(sp)
  }
  release(&tickslock);
    80001e78:	0000e517          	auipc	a0,0xe
    80001e7c:	21850513          	addi	a0,a0,536 # 80010090 <tickslock>
    80001e80:	277030ef          	jal	800058f6 <release>
  return 0;
    80001e84:	4501                	li	a0,0
}
    80001e86:	70e2                	ld	ra,56(sp)
    80001e88:	7442                	ld	s0,48(sp)
    80001e8a:	7902                	ld	s2,32(sp)
    80001e8c:	6121                	addi	sp,sp,64
    80001e8e:	8082                	ret
    n = 0;
    80001e90:	fc042623          	sw	zero,-52(s0)
    80001e94:	bf49                	j	80001e26 <sys_pause+0x1c>
      release(&tickslock);
    80001e96:	0000e517          	auipc	a0,0xe
    80001e9a:	1fa50513          	addi	a0,a0,506 # 80010090 <tickslock>
    80001e9e:	259030ef          	jal	800058f6 <release>
      return -1;
    80001ea2:	557d                	li	a0,-1
    80001ea4:	74a2                	ld	s1,40(sp)
    80001ea6:	69e2                	ld	s3,24(sp)
    80001ea8:	bff9                	j	80001e86 <sys_pause+0x7c>

0000000080001eaa <sys_kill>:

uint64
sys_kill(void)
{
    80001eaa:	1101                	addi	sp,sp,-32
    80001eac:	ec06                	sd	ra,24(sp)
    80001eae:	e822                	sd	s0,16(sp)
    80001eb0:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    80001eb2:	fec40593          	addi	a1,s0,-20
    80001eb6:	4501                	li	a0,0
    80001eb8:	db3ff0ef          	jal	80001c6a <argint>
  return kkill(pid);
    80001ebc:	fec42503          	lw	a0,-20(s0)
    80001ec0:	e56ff0ef          	jal	80001516 <kkill>
}
    80001ec4:	60e2                	ld	ra,24(sp)
    80001ec6:	6442                	ld	s0,16(sp)
    80001ec8:	6105                	addi	sp,sp,32
    80001eca:	8082                	ret

0000000080001ecc <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80001ecc:	1101                	addi	sp,sp,-32
    80001ece:	ec06                	sd	ra,24(sp)
    80001ed0:	e822                	sd	s0,16(sp)
    80001ed2:	e426                	sd	s1,8(sp)
    80001ed4:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80001ed6:	0000e517          	auipc	a0,0xe
    80001eda:	1ba50513          	addi	a0,a0,442 # 80010090 <tickslock>
    80001ede:	185030ef          	jal	80005862 <acquire>
  xticks = ticks;
    80001ee2:	00008497          	auipc	s1,0x8
    80001ee6:	3464a483          	lw	s1,838(s1) # 8000a228 <ticks>
  release(&tickslock);
    80001eea:	0000e517          	auipc	a0,0xe
    80001eee:	1a650513          	addi	a0,a0,422 # 80010090 <tickslock>
    80001ef2:	205030ef          	jal	800058f6 <release>
  return xticks;
}
    80001ef6:	02049513          	slli	a0,s1,0x20
    80001efa:	9101                	srli	a0,a0,0x20
    80001efc:	60e2                	ld	ra,24(sp)
    80001efe:	6442                	ld	s0,16(sp)
    80001f00:	64a2                	ld	s1,8(sp)
    80001f02:	6105                	addi	sp,sp,32
    80001f04:	8082                	ret

0000000080001f06 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80001f06:	7179                	addi	sp,sp,-48
    80001f08:	f406                	sd	ra,40(sp)
    80001f0a:	f022                	sd	s0,32(sp)
    80001f0c:	ec26                	sd	s1,24(sp)
    80001f0e:	e84a                	sd	s2,16(sp)
    80001f10:	e44e                	sd	s3,8(sp)
    80001f12:	e052                	sd	s4,0(sp)
    80001f14:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80001f16:	00005597          	auipc	a1,0x5
    80001f1a:	41a58593          	addi	a1,a1,1050 # 80007330 <etext+0x330>
    80001f1e:	0000e517          	auipc	a0,0xe
    80001f22:	18a50513          	addi	a0,a0,394 # 800100a8 <bcache>
    80001f26:	0b9030ef          	jal	800057de <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80001f2a:	00016797          	auipc	a5,0x16
    80001f2e:	17e78793          	addi	a5,a5,382 # 800180a8 <bcache+0x8000>
    80001f32:	00016717          	auipc	a4,0x16
    80001f36:	3de70713          	addi	a4,a4,990 # 80018310 <bcache+0x8268>
    80001f3a:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80001f3e:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001f42:	0000e497          	auipc	s1,0xe
    80001f46:	17e48493          	addi	s1,s1,382 # 800100c0 <bcache+0x18>
    b->next = bcache.head.next;
    80001f4a:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80001f4c:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80001f4e:	00005a17          	auipc	s4,0x5
    80001f52:	3eaa0a13          	addi	s4,s4,1002 # 80007338 <etext+0x338>
    b->next = bcache.head.next;
    80001f56:	2b893783          	ld	a5,696(s2)
    80001f5a:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80001f5c:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80001f60:	85d2                	mv	a1,s4
    80001f62:	01048513          	addi	a0,s1,16
    80001f66:	31c010ef          	jal	80003282 <initsleeplock>
    bcache.head.next->prev = b;
    80001f6a:	2b893783          	ld	a5,696(s2)
    80001f6e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80001f70:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80001f74:	45848493          	addi	s1,s1,1112
    80001f78:	fd349fe3          	bne	s1,s3,80001f56 <binit+0x50>
  }
}
    80001f7c:	70a2                	ld	ra,40(sp)
    80001f7e:	7402                	ld	s0,32(sp)
    80001f80:	64e2                	ld	s1,24(sp)
    80001f82:	6942                	ld	s2,16(sp)
    80001f84:	69a2                	ld	s3,8(sp)
    80001f86:	6a02                	ld	s4,0(sp)
    80001f88:	6145                	addi	sp,sp,48
    80001f8a:	8082                	ret

0000000080001f8c <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80001f8c:	7179                	addi	sp,sp,-48
    80001f8e:	f406                	sd	ra,40(sp)
    80001f90:	f022                	sd	s0,32(sp)
    80001f92:	ec26                	sd	s1,24(sp)
    80001f94:	e84a                	sd	s2,16(sp)
    80001f96:	e44e                	sd	s3,8(sp)
    80001f98:	1800                	addi	s0,sp,48
    80001f9a:	892a                	mv	s2,a0
    80001f9c:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80001f9e:	0000e517          	auipc	a0,0xe
    80001fa2:	10a50513          	addi	a0,a0,266 # 800100a8 <bcache>
    80001fa6:	0bd030ef          	jal	80005862 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80001faa:	00016497          	auipc	s1,0x16
    80001fae:	3b64b483          	ld	s1,950(s1) # 80018360 <bcache+0x82b8>
    80001fb2:	00016797          	auipc	a5,0x16
    80001fb6:	35e78793          	addi	a5,a5,862 # 80018310 <bcache+0x8268>
    80001fba:	02f48b63          	beq	s1,a5,80001ff0 <bread+0x64>
    80001fbe:	873e                	mv	a4,a5
    80001fc0:	a021                	j	80001fc8 <bread+0x3c>
    80001fc2:	68a4                	ld	s1,80(s1)
    80001fc4:	02e48663          	beq	s1,a4,80001ff0 <bread+0x64>
    if(b->dev == dev && b->blockno == blockno){
    80001fc8:	449c                	lw	a5,8(s1)
    80001fca:	ff279ce3          	bne	a5,s2,80001fc2 <bread+0x36>
    80001fce:	44dc                	lw	a5,12(s1)
    80001fd0:	ff3799e3          	bne	a5,s3,80001fc2 <bread+0x36>
      b->refcnt++;
    80001fd4:	40bc                	lw	a5,64(s1)
    80001fd6:	2785                	addiw	a5,a5,1
    80001fd8:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80001fda:	0000e517          	auipc	a0,0xe
    80001fde:	0ce50513          	addi	a0,a0,206 # 800100a8 <bcache>
    80001fe2:	115030ef          	jal	800058f6 <release>
      acquiresleep(&b->lock);
    80001fe6:	01048513          	addi	a0,s1,16
    80001fea:	2ce010ef          	jal	800032b8 <acquiresleep>
      return b;
    80001fee:	a889                	j	80002040 <bread+0xb4>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80001ff0:	00016497          	auipc	s1,0x16
    80001ff4:	3684b483          	ld	s1,872(s1) # 80018358 <bcache+0x82b0>
    80001ff8:	00016797          	auipc	a5,0x16
    80001ffc:	31878793          	addi	a5,a5,792 # 80018310 <bcache+0x8268>
    80002000:	00f48863          	beq	s1,a5,80002010 <bread+0x84>
    80002004:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002006:	40bc                	lw	a5,64(s1)
    80002008:	cb91                	beqz	a5,8000201c <bread+0x90>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000200a:	64a4                	ld	s1,72(s1)
    8000200c:	fee49de3          	bne	s1,a4,80002006 <bread+0x7a>
  panic("bget: no buffers");
    80002010:	00005517          	auipc	a0,0x5
    80002014:	33050513          	addi	a0,a0,816 # 80007340 <etext+0x340>
    80002018:	58e030ef          	jal	800055a6 <panic>
      b->dev = dev;
    8000201c:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002020:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002024:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002028:	4785                	li	a5,1
    8000202a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000202c:	0000e517          	auipc	a0,0xe
    80002030:	07c50513          	addi	a0,a0,124 # 800100a8 <bcache>
    80002034:	0c3030ef          	jal	800058f6 <release>
      acquiresleep(&b->lock);
    80002038:	01048513          	addi	a0,s1,16
    8000203c:	27c010ef          	jal	800032b8 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002040:	409c                	lw	a5,0(s1)
    80002042:	cb89                	beqz	a5,80002054 <bread+0xc8>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002044:	8526                	mv	a0,s1
    80002046:	70a2                	ld	ra,40(sp)
    80002048:	7402                	ld	s0,32(sp)
    8000204a:	64e2                	ld	s1,24(sp)
    8000204c:	6942                	ld	s2,16(sp)
    8000204e:	69a2                	ld	s3,8(sp)
    80002050:	6145                	addi	sp,sp,48
    80002052:	8082                	ret
    virtio_disk_rw(b, 0);
    80002054:	4581                	li	a1,0
    80002056:	8526                	mv	a0,s1
    80002058:	2d9020ef          	jal	80004b30 <virtio_disk_rw>
    b->valid = 1;
    8000205c:	4785                	li	a5,1
    8000205e:	c09c                	sw	a5,0(s1)
  return b;
    80002060:	b7d5                	j	80002044 <bread+0xb8>

0000000080002062 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002062:	1101                	addi	sp,sp,-32
    80002064:	ec06                	sd	ra,24(sp)
    80002066:	e822                	sd	s0,16(sp)
    80002068:	e426                	sd	s1,8(sp)
    8000206a:	1000                	addi	s0,sp,32
    8000206c:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000206e:	0541                	addi	a0,a0,16
    80002070:	2c6010ef          	jal	80003336 <holdingsleep>
    80002074:	c911                	beqz	a0,80002088 <bwrite+0x26>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002076:	4585                	li	a1,1
    80002078:	8526                	mv	a0,s1
    8000207a:	2b7020ef          	jal	80004b30 <virtio_disk_rw>
}
    8000207e:	60e2                	ld	ra,24(sp)
    80002080:	6442                	ld	s0,16(sp)
    80002082:	64a2                	ld	s1,8(sp)
    80002084:	6105                	addi	sp,sp,32
    80002086:	8082                	ret
    panic("bwrite");
    80002088:	00005517          	auipc	a0,0x5
    8000208c:	2d050513          	addi	a0,a0,720 # 80007358 <etext+0x358>
    80002090:	516030ef          	jal	800055a6 <panic>

0000000080002094 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002094:	1101                	addi	sp,sp,-32
    80002096:	ec06                	sd	ra,24(sp)
    80002098:	e822                	sd	s0,16(sp)
    8000209a:	e426                	sd	s1,8(sp)
    8000209c:	e04a                	sd	s2,0(sp)
    8000209e:	1000                	addi	s0,sp,32
    800020a0:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800020a2:	01050913          	addi	s2,a0,16
    800020a6:	854a                	mv	a0,s2
    800020a8:	28e010ef          	jal	80003336 <holdingsleep>
    800020ac:	c125                	beqz	a0,8000210c <brelse+0x78>
    panic("brelse");

  releasesleep(&b->lock);
    800020ae:	854a                	mv	a0,s2
    800020b0:	24e010ef          	jal	800032fe <releasesleep>

  acquire(&bcache.lock);
    800020b4:	0000e517          	auipc	a0,0xe
    800020b8:	ff450513          	addi	a0,a0,-12 # 800100a8 <bcache>
    800020bc:	7a6030ef          	jal	80005862 <acquire>
  b->refcnt--;
    800020c0:	40bc                	lw	a5,64(s1)
    800020c2:	37fd                	addiw	a5,a5,-1
    800020c4:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800020c6:	e79d                	bnez	a5,800020f4 <brelse+0x60>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800020c8:	68b8                	ld	a4,80(s1)
    800020ca:	64bc                	ld	a5,72(s1)
    800020cc:	e73c                	sd	a5,72(a4)
    b->prev->next = b->next;
    800020ce:	68b8                	ld	a4,80(s1)
    800020d0:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800020d2:	00016797          	auipc	a5,0x16
    800020d6:	fd678793          	addi	a5,a5,-42 # 800180a8 <bcache+0x8000>
    800020da:	2b87b703          	ld	a4,696(a5)
    800020de:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800020e0:	00016717          	auipc	a4,0x16
    800020e4:	23070713          	addi	a4,a4,560 # 80018310 <bcache+0x8268>
    800020e8:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    800020ea:	2b87b703          	ld	a4,696(a5)
    800020ee:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    800020f0:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    800020f4:	0000e517          	auipc	a0,0xe
    800020f8:	fb450513          	addi	a0,a0,-76 # 800100a8 <bcache>
    800020fc:	7fa030ef          	jal	800058f6 <release>
}
    80002100:	60e2                	ld	ra,24(sp)
    80002102:	6442                	ld	s0,16(sp)
    80002104:	64a2                	ld	s1,8(sp)
    80002106:	6902                	ld	s2,0(sp)
    80002108:	6105                	addi	sp,sp,32
    8000210a:	8082                	ret
    panic("brelse");
    8000210c:	00005517          	auipc	a0,0x5
    80002110:	25450513          	addi	a0,a0,596 # 80007360 <etext+0x360>
    80002114:	492030ef          	jal	800055a6 <panic>

0000000080002118 <bpin>:

void
bpin(struct buf *b) {
    80002118:	1101                	addi	sp,sp,-32
    8000211a:	ec06                	sd	ra,24(sp)
    8000211c:	e822                	sd	s0,16(sp)
    8000211e:	e426                	sd	s1,8(sp)
    80002120:	1000                	addi	s0,sp,32
    80002122:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002124:	0000e517          	auipc	a0,0xe
    80002128:	f8450513          	addi	a0,a0,-124 # 800100a8 <bcache>
    8000212c:	736030ef          	jal	80005862 <acquire>
  b->refcnt++;
    80002130:	40bc                	lw	a5,64(s1)
    80002132:	2785                	addiw	a5,a5,1
    80002134:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002136:	0000e517          	auipc	a0,0xe
    8000213a:	f7250513          	addi	a0,a0,-142 # 800100a8 <bcache>
    8000213e:	7b8030ef          	jal	800058f6 <release>
}
    80002142:	60e2                	ld	ra,24(sp)
    80002144:	6442                	ld	s0,16(sp)
    80002146:	64a2                	ld	s1,8(sp)
    80002148:	6105                	addi	sp,sp,32
    8000214a:	8082                	ret

000000008000214c <bunpin>:

void
bunpin(struct buf *b) {
    8000214c:	1101                	addi	sp,sp,-32
    8000214e:	ec06                	sd	ra,24(sp)
    80002150:	e822                	sd	s0,16(sp)
    80002152:	e426                	sd	s1,8(sp)
    80002154:	1000                	addi	s0,sp,32
    80002156:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002158:	0000e517          	auipc	a0,0xe
    8000215c:	f5050513          	addi	a0,a0,-176 # 800100a8 <bcache>
    80002160:	702030ef          	jal	80005862 <acquire>
  b->refcnt--;
    80002164:	40bc                	lw	a5,64(s1)
    80002166:	37fd                	addiw	a5,a5,-1
    80002168:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000216a:	0000e517          	auipc	a0,0xe
    8000216e:	f3e50513          	addi	a0,a0,-194 # 800100a8 <bcache>
    80002172:	784030ef          	jal	800058f6 <release>
}
    80002176:	60e2                	ld	ra,24(sp)
    80002178:	6442                	ld	s0,16(sp)
    8000217a:	64a2                	ld	s1,8(sp)
    8000217c:	6105                	addi	sp,sp,32
    8000217e:	8082                	ret

0000000080002180 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002180:	1101                	addi	sp,sp,-32
    80002182:	ec06                	sd	ra,24(sp)
    80002184:	e822                	sd	s0,16(sp)
    80002186:	e426                	sd	s1,8(sp)
    80002188:	e04a                	sd	s2,0(sp)
    8000218a:	1000                	addi	s0,sp,32
    8000218c:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000218e:	00d5d79b          	srliw	a5,a1,0xd
    80002192:	00016597          	auipc	a1,0x16
    80002196:	5f25a583          	lw	a1,1522(a1) # 80018784 <sb+0x1c>
    8000219a:	9dbd                	addw	a1,a1,a5
    8000219c:	df1ff0ef          	jal	80001f8c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800021a0:	0074f713          	andi	a4,s1,7
    800021a4:	4785                	li	a5,1
    800021a6:	00e797bb          	sllw	a5,a5,a4
  bi = b % BPB;
    800021aa:	14ce                	slli	s1,s1,0x33
  if((bp->data[bi/8] & m) == 0)
    800021ac:	90d9                	srli	s1,s1,0x36
    800021ae:	00950733          	add	a4,a0,s1
    800021b2:	05874703          	lbu	a4,88(a4)
    800021b6:	00e7f6b3          	and	a3,a5,a4
    800021ba:	c29d                	beqz	a3,800021e0 <bfree+0x60>
    800021bc:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800021be:	94aa                	add	s1,s1,a0
    800021c0:	fff7c793          	not	a5,a5
    800021c4:	8f7d                	and	a4,a4,a5
    800021c6:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800021ca:	7f7000ef          	jal	800031c0 <log_write>
  brelse(bp);
    800021ce:	854a                	mv	a0,s2
    800021d0:	ec5ff0ef          	jal	80002094 <brelse>
}
    800021d4:	60e2                	ld	ra,24(sp)
    800021d6:	6442                	ld	s0,16(sp)
    800021d8:	64a2                	ld	s1,8(sp)
    800021da:	6902                	ld	s2,0(sp)
    800021dc:	6105                	addi	sp,sp,32
    800021de:	8082                	ret
    panic("freeing free block");
    800021e0:	00005517          	auipc	a0,0x5
    800021e4:	18850513          	addi	a0,a0,392 # 80007368 <etext+0x368>
    800021e8:	3be030ef          	jal	800055a6 <panic>

00000000800021ec <balloc>:
{
    800021ec:	715d                	addi	sp,sp,-80
    800021ee:	e486                	sd	ra,72(sp)
    800021f0:	e0a2                	sd	s0,64(sp)
    800021f2:	fc26                	sd	s1,56(sp)
    800021f4:	0880                	addi	s0,sp,80
  for(b = 0; b < sb.size; b += BPB){
    800021f6:	00016797          	auipc	a5,0x16
    800021fa:	5767a783          	lw	a5,1398(a5) # 8001876c <sb+0x4>
    800021fe:	0e078863          	beqz	a5,800022ee <balloc+0x102>
    80002202:	f84a                	sd	s2,48(sp)
    80002204:	f44e                	sd	s3,40(sp)
    80002206:	f052                	sd	s4,32(sp)
    80002208:	ec56                	sd	s5,24(sp)
    8000220a:	e85a                	sd	s6,16(sp)
    8000220c:	e45e                	sd	s7,8(sp)
    8000220e:	e062                	sd	s8,0(sp)
    80002210:	8baa                	mv	s7,a0
    80002212:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002214:	00016b17          	auipc	s6,0x16
    80002218:	554b0b13          	addi	s6,s6,1364 # 80018768 <sb>
      m = 1 << (bi % 8);
    8000221c:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000221e:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002220:	6c09                	lui	s8,0x2
    80002222:	a09d                	j	80002288 <balloc+0x9c>
        bp->data[bi/8] |= m;  // Mark block in use.
    80002224:	97ca                	add	a5,a5,s2
    80002226:	8e55                	or	a2,a2,a3
    80002228:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    8000222c:	854a                	mv	a0,s2
    8000222e:	793000ef          	jal	800031c0 <log_write>
        brelse(bp);
    80002232:	854a                	mv	a0,s2
    80002234:	e61ff0ef          	jal	80002094 <brelse>
  bp = bread(dev, bno);
    80002238:	85a6                	mv	a1,s1
    8000223a:	855e                	mv	a0,s7
    8000223c:	d51ff0ef          	jal	80001f8c <bread>
    80002240:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002242:	40000613          	li	a2,1024
    80002246:	4581                	li	a1,0
    80002248:	05850513          	addi	a0,a0,88
    8000224c:	f03fd0ef          	jal	8000014e <memset>
  log_write(bp);
    80002250:	854a                	mv	a0,s2
    80002252:	76f000ef          	jal	800031c0 <log_write>
  brelse(bp);
    80002256:	854a                	mv	a0,s2
    80002258:	e3dff0ef          	jal	80002094 <brelse>
}
    8000225c:	7942                	ld	s2,48(sp)
    8000225e:	79a2                	ld	s3,40(sp)
    80002260:	7a02                	ld	s4,32(sp)
    80002262:	6ae2                	ld	s5,24(sp)
    80002264:	6b42                	ld	s6,16(sp)
    80002266:	6ba2                	ld	s7,8(sp)
    80002268:	6c02                	ld	s8,0(sp)
}
    8000226a:	8526                	mv	a0,s1
    8000226c:	60a6                	ld	ra,72(sp)
    8000226e:	6406                	ld	s0,64(sp)
    80002270:	74e2                	ld	s1,56(sp)
    80002272:	6161                	addi	sp,sp,80
    80002274:	8082                	ret
    brelse(bp);
    80002276:	854a                	mv	a0,s2
    80002278:	e1dff0ef          	jal	80002094 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000227c:	015c0abb          	addw	s5,s8,s5
    80002280:	004b2783          	lw	a5,4(s6)
    80002284:	04fafe63          	bgeu	s5,a5,800022e0 <balloc+0xf4>
    bp = bread(dev, BBLOCK(b, sb));
    80002288:	41fad79b          	sraiw	a5,s5,0x1f
    8000228c:	0137d79b          	srliw	a5,a5,0x13
    80002290:	015787bb          	addw	a5,a5,s5
    80002294:	40d7d79b          	sraiw	a5,a5,0xd
    80002298:	01cb2583          	lw	a1,28(s6)
    8000229c:	9dbd                	addw	a1,a1,a5
    8000229e:	855e                	mv	a0,s7
    800022a0:	cedff0ef          	jal	80001f8c <bread>
    800022a4:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022a6:	004b2503          	lw	a0,4(s6)
    800022aa:	84d6                	mv	s1,s5
    800022ac:	4701                	li	a4,0
    800022ae:	fca4f4e3          	bgeu	s1,a0,80002276 <balloc+0x8a>
      m = 1 << (bi % 8);
    800022b2:	00777693          	andi	a3,a4,7
    800022b6:	00d996bb          	sllw	a3,s3,a3
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800022ba:	41f7579b          	sraiw	a5,a4,0x1f
    800022be:	01d7d79b          	srliw	a5,a5,0x1d
    800022c2:	9fb9                	addw	a5,a5,a4
    800022c4:	4037d79b          	sraiw	a5,a5,0x3
    800022c8:	00f90633          	add	a2,s2,a5
    800022cc:	05864603          	lbu	a2,88(a2)
    800022d0:	00c6f5b3          	and	a1,a3,a2
    800022d4:	d9a1                	beqz	a1,80002224 <balloc+0x38>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800022d6:	2705                	addiw	a4,a4,1
    800022d8:	2485                	addiw	s1,s1,1
    800022da:	fd471ae3          	bne	a4,s4,800022ae <balloc+0xc2>
    800022de:	bf61                	j	80002276 <balloc+0x8a>
    800022e0:	7942                	ld	s2,48(sp)
    800022e2:	79a2                	ld	s3,40(sp)
    800022e4:	7a02                	ld	s4,32(sp)
    800022e6:	6ae2                	ld	s5,24(sp)
    800022e8:	6b42                	ld	s6,16(sp)
    800022ea:	6ba2                	ld	s7,8(sp)
    800022ec:	6c02                	ld	s8,0(sp)
  printf("balloc: out of blocks\n");
    800022ee:	00005517          	auipc	a0,0x5
    800022f2:	09250513          	addi	a0,a0,146 # 80007380 <etext+0x380>
    800022f6:	7cd020ef          	jal	800052c2 <printf>
  return 0;
    800022fa:	4481                	li	s1,0
    800022fc:	b7bd                	j	8000226a <balloc+0x7e>

00000000800022fe <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800022fe:	7179                	addi	sp,sp,-48
    80002300:	f406                	sd	ra,40(sp)
    80002302:	f022                	sd	s0,32(sp)
    80002304:	ec26                	sd	s1,24(sp)
    80002306:	e84a                	sd	s2,16(sp)
    80002308:	e44e                	sd	s3,8(sp)
    8000230a:	1800                	addi	s0,sp,48
    8000230c:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000230e:	47ad                	li	a5,11
    80002310:	02b7e363          	bltu	a5,a1,80002336 <bmap+0x38>
    if((addr = ip->addrs[bn]) == 0){
    80002314:	02059793          	slli	a5,a1,0x20
    80002318:	01e7d593          	srli	a1,a5,0x1e
    8000231c:	00b504b3          	add	s1,a0,a1
    80002320:	0504a903          	lw	s2,80(s1)
    80002324:	06091363          	bnez	s2,8000238a <bmap+0x8c>
      addr = balloc(ip->dev);
    80002328:	4108                	lw	a0,0(a0)
    8000232a:	ec3ff0ef          	jal	800021ec <balloc>
    8000232e:	892a                	mv	s2,a0
      if(addr == 0)
    80002330:	cd29                	beqz	a0,8000238a <bmap+0x8c>
        return 0;
      ip->addrs[bn] = addr;
    80002332:	c8a8                	sw	a0,80(s1)
    80002334:	a899                	j	8000238a <bmap+0x8c>
    }
    return addr;
  }
  bn -= NDIRECT;
    80002336:	ff45849b          	addiw	s1,a1,-12

  if(bn < NINDIRECT){
    8000233a:	0ff00793          	li	a5,255
    8000233e:	0697e963          	bltu	a5,s1,800023b0 <bmap+0xb2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002342:	08052903          	lw	s2,128(a0)
    80002346:	00091b63          	bnez	s2,8000235c <bmap+0x5e>
      addr = balloc(ip->dev);
    8000234a:	4108                	lw	a0,0(a0)
    8000234c:	ea1ff0ef          	jal	800021ec <balloc>
    80002350:	892a                	mv	s2,a0
      if(addr == 0)
    80002352:	cd05                	beqz	a0,8000238a <bmap+0x8c>
    80002354:	e052                	sd	s4,0(sp)
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002356:	08a9a023          	sw	a0,128(s3)
    8000235a:	a011                	j	8000235e <bmap+0x60>
    8000235c:	e052                	sd	s4,0(sp)
    }
    bp = bread(ip->dev, addr);
    8000235e:	85ca                	mv	a1,s2
    80002360:	0009a503          	lw	a0,0(s3)
    80002364:	c29ff0ef          	jal	80001f8c <bread>
    80002368:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    8000236a:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000236e:	02049713          	slli	a4,s1,0x20
    80002372:	01e75593          	srli	a1,a4,0x1e
    80002376:	00b784b3          	add	s1,a5,a1
    8000237a:	0004a903          	lw	s2,0(s1)
    8000237e:	00090e63          	beqz	s2,8000239a <bmap+0x9c>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    80002382:	8552                	mv	a0,s4
    80002384:	d11ff0ef          	jal	80002094 <brelse>
    return addr;
    80002388:	6a02                	ld	s4,0(sp)
  }

  panic("bmap: out of range");
}
    8000238a:	854a                	mv	a0,s2
    8000238c:	70a2                	ld	ra,40(sp)
    8000238e:	7402                	ld	s0,32(sp)
    80002390:	64e2                	ld	s1,24(sp)
    80002392:	6942                	ld	s2,16(sp)
    80002394:	69a2                	ld	s3,8(sp)
    80002396:	6145                	addi	sp,sp,48
    80002398:	8082                	ret
      addr = balloc(ip->dev);
    8000239a:	0009a503          	lw	a0,0(s3)
    8000239e:	e4fff0ef          	jal	800021ec <balloc>
    800023a2:	892a                	mv	s2,a0
      if(addr){
    800023a4:	dd79                	beqz	a0,80002382 <bmap+0x84>
        a[bn] = addr;
    800023a6:	c088                	sw	a0,0(s1)
        log_write(bp);
    800023a8:	8552                	mv	a0,s4
    800023aa:	617000ef          	jal	800031c0 <log_write>
    800023ae:	bfd1                	j	80002382 <bmap+0x84>
    800023b0:	e052                	sd	s4,0(sp)
  panic("bmap: out of range");
    800023b2:	00005517          	auipc	a0,0x5
    800023b6:	fe650513          	addi	a0,a0,-26 # 80007398 <etext+0x398>
    800023ba:	1ec030ef          	jal	800055a6 <panic>

00000000800023be <iget>:
{
    800023be:	7179                	addi	sp,sp,-48
    800023c0:	f406                	sd	ra,40(sp)
    800023c2:	f022                	sd	s0,32(sp)
    800023c4:	ec26                	sd	s1,24(sp)
    800023c6:	e84a                	sd	s2,16(sp)
    800023c8:	e44e                	sd	s3,8(sp)
    800023ca:	e052                	sd	s4,0(sp)
    800023cc:	1800                	addi	s0,sp,48
    800023ce:	89aa                	mv	s3,a0
    800023d0:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800023d2:	00016517          	auipc	a0,0x16
    800023d6:	3b650513          	addi	a0,a0,950 # 80018788 <itable>
    800023da:	488030ef          	jal	80005862 <acquire>
  empty = 0;
    800023de:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800023e0:	00016497          	auipc	s1,0x16
    800023e4:	3c048493          	addi	s1,s1,960 # 800187a0 <itable+0x18>
    800023e8:	00018697          	auipc	a3,0x18
    800023ec:	e4868693          	addi	a3,a3,-440 # 8001a230 <log>
    800023f0:	a039                	j	800023fe <iget+0x40>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800023f2:	02090963          	beqz	s2,80002424 <iget+0x66>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800023f6:	08848493          	addi	s1,s1,136
    800023fa:	02d48863          	beq	s1,a3,8000242a <iget+0x6c>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800023fe:	449c                	lw	a5,8(s1)
    80002400:	fef059e3          	blez	a5,800023f2 <iget+0x34>
    80002404:	4098                	lw	a4,0(s1)
    80002406:	ff3716e3          	bne	a4,s3,800023f2 <iget+0x34>
    8000240a:	40d8                	lw	a4,4(s1)
    8000240c:	ff4713e3          	bne	a4,s4,800023f2 <iget+0x34>
      ip->ref++;
    80002410:	2785                	addiw	a5,a5,1
    80002412:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002414:	00016517          	auipc	a0,0x16
    80002418:	37450513          	addi	a0,a0,884 # 80018788 <itable>
    8000241c:	4da030ef          	jal	800058f6 <release>
      return ip;
    80002420:	8926                	mv	s2,s1
    80002422:	a02d                	j	8000244c <iget+0x8e>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002424:	fbe9                	bnez	a5,800023f6 <iget+0x38>
      empty = ip;
    80002426:	8926                	mv	s2,s1
    80002428:	b7f9                	j	800023f6 <iget+0x38>
  if(empty == 0)
    8000242a:	02090a63          	beqz	s2,8000245e <iget+0xa0>
  ip->dev = dev;
    8000242e:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002432:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002436:	4785                	li	a5,1
    80002438:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    8000243c:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002440:	00016517          	auipc	a0,0x16
    80002444:	34850513          	addi	a0,a0,840 # 80018788 <itable>
    80002448:	4ae030ef          	jal	800058f6 <release>
}
    8000244c:	854a                	mv	a0,s2
    8000244e:	70a2                	ld	ra,40(sp)
    80002450:	7402                	ld	s0,32(sp)
    80002452:	64e2                	ld	s1,24(sp)
    80002454:	6942                	ld	s2,16(sp)
    80002456:	69a2                	ld	s3,8(sp)
    80002458:	6a02                	ld	s4,0(sp)
    8000245a:	6145                	addi	sp,sp,48
    8000245c:	8082                	ret
    panic("iget: no inodes");
    8000245e:	00005517          	auipc	a0,0x5
    80002462:	f5250513          	addi	a0,a0,-174 # 800073b0 <etext+0x3b0>
    80002466:	140030ef          	jal	800055a6 <panic>

000000008000246a <iinit>:
{
    8000246a:	7179                	addi	sp,sp,-48
    8000246c:	f406                	sd	ra,40(sp)
    8000246e:	f022                	sd	s0,32(sp)
    80002470:	ec26                	sd	s1,24(sp)
    80002472:	e84a                	sd	s2,16(sp)
    80002474:	e44e                	sd	s3,8(sp)
    80002476:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002478:	00005597          	auipc	a1,0x5
    8000247c:	f4858593          	addi	a1,a1,-184 # 800073c0 <etext+0x3c0>
    80002480:	00016517          	auipc	a0,0x16
    80002484:	30850513          	addi	a0,a0,776 # 80018788 <itable>
    80002488:	356030ef          	jal	800057de <initlock>
  for(i = 0; i < NINODE; i++) {
    8000248c:	00016497          	auipc	s1,0x16
    80002490:	32448493          	addi	s1,s1,804 # 800187b0 <itable+0x28>
    80002494:	00018997          	auipc	s3,0x18
    80002498:	dac98993          	addi	s3,s3,-596 # 8001a240 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000249c:	00005917          	auipc	s2,0x5
    800024a0:	f2c90913          	addi	s2,s2,-212 # 800073c8 <etext+0x3c8>
    800024a4:	85ca                	mv	a1,s2
    800024a6:	8526                	mv	a0,s1
    800024a8:	5db000ef          	jal	80003282 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800024ac:	08848493          	addi	s1,s1,136
    800024b0:	ff349ae3          	bne	s1,s3,800024a4 <iinit+0x3a>
}
    800024b4:	70a2                	ld	ra,40(sp)
    800024b6:	7402                	ld	s0,32(sp)
    800024b8:	64e2                	ld	s1,24(sp)
    800024ba:	6942                	ld	s2,16(sp)
    800024bc:	69a2                	ld	s3,8(sp)
    800024be:	6145                	addi	sp,sp,48
    800024c0:	8082                	ret

00000000800024c2 <ialloc>:
{
    800024c2:	7139                	addi	sp,sp,-64
    800024c4:	fc06                	sd	ra,56(sp)
    800024c6:	f822                	sd	s0,48(sp)
    800024c8:	0080                	addi	s0,sp,64
  for(inum = 1; inum < sb.ninodes; inum++){
    800024ca:	00016717          	auipc	a4,0x16
    800024ce:	2aa72703          	lw	a4,682(a4) # 80018774 <sb+0xc>
    800024d2:	4785                	li	a5,1
    800024d4:	06e7f063          	bgeu	a5,a4,80002534 <ialloc+0x72>
    800024d8:	f426                	sd	s1,40(sp)
    800024da:	f04a                	sd	s2,32(sp)
    800024dc:	ec4e                	sd	s3,24(sp)
    800024de:	e852                	sd	s4,16(sp)
    800024e0:	e456                	sd	s5,8(sp)
    800024e2:	e05a                	sd	s6,0(sp)
    800024e4:	8aaa                	mv	s5,a0
    800024e6:	8b2e                	mv	s6,a1
    800024e8:	893e                	mv	s2,a5
    bp = bread(dev, IBLOCK(inum, sb));
    800024ea:	00016a17          	auipc	s4,0x16
    800024ee:	27ea0a13          	addi	s4,s4,638 # 80018768 <sb>
    800024f2:	00495593          	srli	a1,s2,0x4
    800024f6:	018a2783          	lw	a5,24(s4)
    800024fa:	9dbd                	addw	a1,a1,a5
    800024fc:	8556                	mv	a0,s5
    800024fe:	a8fff0ef          	jal	80001f8c <bread>
    80002502:	84aa                	mv	s1,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002504:	05850993          	addi	s3,a0,88
    80002508:	00f97793          	andi	a5,s2,15
    8000250c:	079a                	slli	a5,a5,0x6
    8000250e:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002510:	00099783          	lh	a5,0(s3)
    80002514:	cb9d                	beqz	a5,8000254a <ialloc+0x88>
    brelse(bp);
    80002516:	b7fff0ef          	jal	80002094 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000251a:	0905                	addi	s2,s2,1
    8000251c:	00ca2703          	lw	a4,12(s4)
    80002520:	0009079b          	sext.w	a5,s2
    80002524:	fce7e7e3          	bltu	a5,a4,800024f2 <ialloc+0x30>
    80002528:	74a2                	ld	s1,40(sp)
    8000252a:	7902                	ld	s2,32(sp)
    8000252c:	69e2                	ld	s3,24(sp)
    8000252e:	6a42                	ld	s4,16(sp)
    80002530:	6aa2                	ld	s5,8(sp)
    80002532:	6b02                	ld	s6,0(sp)
  printf("ialloc: no inodes\n");
    80002534:	00005517          	auipc	a0,0x5
    80002538:	e9c50513          	addi	a0,a0,-356 # 800073d0 <etext+0x3d0>
    8000253c:	587020ef          	jal	800052c2 <printf>
  return 0;
    80002540:	4501                	li	a0,0
}
    80002542:	70e2                	ld	ra,56(sp)
    80002544:	7442                	ld	s0,48(sp)
    80002546:	6121                	addi	sp,sp,64
    80002548:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    8000254a:	04000613          	li	a2,64
    8000254e:	4581                	li	a1,0
    80002550:	854e                	mv	a0,s3
    80002552:	bfdfd0ef          	jal	8000014e <memset>
      dip->type = type;
    80002556:	01699023          	sh	s6,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000255a:	8526                	mv	a0,s1
    8000255c:	465000ef          	jal	800031c0 <log_write>
      brelse(bp);
    80002560:	8526                	mv	a0,s1
    80002562:	b33ff0ef          	jal	80002094 <brelse>
      return iget(dev, inum);
    80002566:	0009059b          	sext.w	a1,s2
    8000256a:	8556                	mv	a0,s5
    8000256c:	e53ff0ef          	jal	800023be <iget>
    80002570:	74a2                	ld	s1,40(sp)
    80002572:	7902                	ld	s2,32(sp)
    80002574:	69e2                	ld	s3,24(sp)
    80002576:	6a42                	ld	s4,16(sp)
    80002578:	6aa2                	ld	s5,8(sp)
    8000257a:	6b02                	ld	s6,0(sp)
    8000257c:	b7d9                	j	80002542 <ialloc+0x80>

000000008000257e <iupdate>:
{
    8000257e:	1101                	addi	sp,sp,-32
    80002580:	ec06                	sd	ra,24(sp)
    80002582:	e822                	sd	s0,16(sp)
    80002584:	e426                	sd	s1,8(sp)
    80002586:	e04a                	sd	s2,0(sp)
    80002588:	1000                	addi	s0,sp,32
    8000258a:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000258c:	415c                	lw	a5,4(a0)
    8000258e:	0047d79b          	srliw	a5,a5,0x4
    80002592:	00016597          	auipc	a1,0x16
    80002596:	1ee5a583          	lw	a1,494(a1) # 80018780 <sb+0x18>
    8000259a:	9dbd                	addw	a1,a1,a5
    8000259c:	4108                	lw	a0,0(a0)
    8000259e:	9efff0ef          	jal	80001f8c <bread>
    800025a2:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800025a4:	05850793          	addi	a5,a0,88
    800025a8:	40d8                	lw	a4,4(s1)
    800025aa:	8b3d                	andi	a4,a4,15
    800025ac:	071a                	slli	a4,a4,0x6
    800025ae:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    800025b0:	04449703          	lh	a4,68(s1)
    800025b4:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    800025b8:	04649703          	lh	a4,70(s1)
    800025bc:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    800025c0:	04849703          	lh	a4,72(s1)
    800025c4:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    800025c8:	04a49703          	lh	a4,74(s1)
    800025cc:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    800025d0:	44f8                	lw	a4,76(s1)
    800025d2:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    800025d4:	03400613          	li	a2,52
    800025d8:	05048593          	addi	a1,s1,80
    800025dc:	00c78513          	addi	a0,a5,12
    800025e0:	bd3fd0ef          	jal	800001b2 <memmove>
  log_write(bp);
    800025e4:	854a                	mv	a0,s2
    800025e6:	3db000ef          	jal	800031c0 <log_write>
  brelse(bp);
    800025ea:	854a                	mv	a0,s2
    800025ec:	aa9ff0ef          	jal	80002094 <brelse>
}
    800025f0:	60e2                	ld	ra,24(sp)
    800025f2:	6442                	ld	s0,16(sp)
    800025f4:	64a2                	ld	s1,8(sp)
    800025f6:	6902                	ld	s2,0(sp)
    800025f8:	6105                	addi	sp,sp,32
    800025fa:	8082                	ret

00000000800025fc <idup>:
{
    800025fc:	1101                	addi	sp,sp,-32
    800025fe:	ec06                	sd	ra,24(sp)
    80002600:	e822                	sd	s0,16(sp)
    80002602:	e426                	sd	s1,8(sp)
    80002604:	1000                	addi	s0,sp,32
    80002606:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002608:	00016517          	auipc	a0,0x16
    8000260c:	18050513          	addi	a0,a0,384 # 80018788 <itable>
    80002610:	252030ef          	jal	80005862 <acquire>
  ip->ref++;
    80002614:	449c                	lw	a5,8(s1)
    80002616:	2785                	addiw	a5,a5,1
    80002618:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000261a:	00016517          	auipc	a0,0x16
    8000261e:	16e50513          	addi	a0,a0,366 # 80018788 <itable>
    80002622:	2d4030ef          	jal	800058f6 <release>
}
    80002626:	8526                	mv	a0,s1
    80002628:	60e2                	ld	ra,24(sp)
    8000262a:	6442                	ld	s0,16(sp)
    8000262c:	64a2                	ld	s1,8(sp)
    8000262e:	6105                	addi	sp,sp,32
    80002630:	8082                	ret

0000000080002632 <ilock>:
{
    80002632:	1101                	addi	sp,sp,-32
    80002634:	ec06                	sd	ra,24(sp)
    80002636:	e822                	sd	s0,16(sp)
    80002638:	e426                	sd	s1,8(sp)
    8000263a:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    8000263c:	cd19                	beqz	a0,8000265a <ilock+0x28>
    8000263e:	84aa                	mv	s1,a0
    80002640:	451c                	lw	a5,8(a0)
    80002642:	00f05c63          	blez	a5,8000265a <ilock+0x28>
  acquiresleep(&ip->lock);
    80002646:	0541                	addi	a0,a0,16
    80002648:	471000ef          	jal	800032b8 <acquiresleep>
  if(ip->valid == 0){
    8000264c:	40bc                	lw	a5,64(s1)
    8000264e:	cf89                	beqz	a5,80002668 <ilock+0x36>
}
    80002650:	60e2                	ld	ra,24(sp)
    80002652:	6442                	ld	s0,16(sp)
    80002654:	64a2                	ld	s1,8(sp)
    80002656:	6105                	addi	sp,sp,32
    80002658:	8082                	ret
    8000265a:	e04a                	sd	s2,0(sp)
    panic("ilock");
    8000265c:	00005517          	auipc	a0,0x5
    80002660:	d8c50513          	addi	a0,a0,-628 # 800073e8 <etext+0x3e8>
    80002664:	743020ef          	jal	800055a6 <panic>
    80002668:	e04a                	sd	s2,0(sp)
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    8000266a:	40dc                	lw	a5,4(s1)
    8000266c:	0047d79b          	srliw	a5,a5,0x4
    80002670:	00016597          	auipc	a1,0x16
    80002674:	1105a583          	lw	a1,272(a1) # 80018780 <sb+0x18>
    80002678:	9dbd                	addw	a1,a1,a5
    8000267a:	4088                	lw	a0,0(s1)
    8000267c:	911ff0ef          	jal	80001f8c <bread>
    80002680:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002682:	05850593          	addi	a1,a0,88
    80002686:	40dc                	lw	a5,4(s1)
    80002688:	8bbd                	andi	a5,a5,15
    8000268a:	079a                	slli	a5,a5,0x6
    8000268c:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    8000268e:	00059783          	lh	a5,0(a1)
    80002692:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002696:	00259783          	lh	a5,2(a1)
    8000269a:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    8000269e:	00459783          	lh	a5,4(a1)
    800026a2:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    800026a6:	00659783          	lh	a5,6(a1)
    800026aa:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    800026ae:	459c                	lw	a5,8(a1)
    800026b0:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    800026b2:	03400613          	li	a2,52
    800026b6:	05b1                	addi	a1,a1,12
    800026b8:	05048513          	addi	a0,s1,80
    800026bc:	af7fd0ef          	jal	800001b2 <memmove>
    brelse(bp);
    800026c0:	854a                	mv	a0,s2
    800026c2:	9d3ff0ef          	jal	80002094 <brelse>
    ip->valid = 1;
    800026c6:	4785                	li	a5,1
    800026c8:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    800026ca:	04449783          	lh	a5,68(s1)
    800026ce:	c399                	beqz	a5,800026d4 <ilock+0xa2>
    800026d0:	6902                	ld	s2,0(sp)
    800026d2:	bfbd                	j	80002650 <ilock+0x1e>
      panic("ilock: no type");
    800026d4:	00005517          	auipc	a0,0x5
    800026d8:	d1c50513          	addi	a0,a0,-740 # 800073f0 <etext+0x3f0>
    800026dc:	6cb020ef          	jal	800055a6 <panic>

00000000800026e0 <iunlock>:
{
    800026e0:	1101                	addi	sp,sp,-32
    800026e2:	ec06                	sd	ra,24(sp)
    800026e4:	e822                	sd	s0,16(sp)
    800026e6:	e426                	sd	s1,8(sp)
    800026e8:	e04a                	sd	s2,0(sp)
    800026ea:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    800026ec:	c505                	beqz	a0,80002714 <iunlock+0x34>
    800026ee:	84aa                	mv	s1,a0
    800026f0:	01050913          	addi	s2,a0,16
    800026f4:	854a                	mv	a0,s2
    800026f6:	441000ef          	jal	80003336 <holdingsleep>
    800026fa:	cd09                	beqz	a0,80002714 <iunlock+0x34>
    800026fc:	449c                	lw	a5,8(s1)
    800026fe:	00f05b63          	blez	a5,80002714 <iunlock+0x34>
  releasesleep(&ip->lock);
    80002702:	854a                	mv	a0,s2
    80002704:	3fb000ef          	jal	800032fe <releasesleep>
}
    80002708:	60e2                	ld	ra,24(sp)
    8000270a:	6442                	ld	s0,16(sp)
    8000270c:	64a2                	ld	s1,8(sp)
    8000270e:	6902                	ld	s2,0(sp)
    80002710:	6105                	addi	sp,sp,32
    80002712:	8082                	ret
    panic("iunlock");
    80002714:	00005517          	auipc	a0,0x5
    80002718:	cec50513          	addi	a0,a0,-788 # 80007400 <etext+0x400>
    8000271c:	68b020ef          	jal	800055a6 <panic>

0000000080002720 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002720:	7179                	addi	sp,sp,-48
    80002722:	f406                	sd	ra,40(sp)
    80002724:	f022                	sd	s0,32(sp)
    80002726:	ec26                	sd	s1,24(sp)
    80002728:	e84a                	sd	s2,16(sp)
    8000272a:	e44e                	sd	s3,8(sp)
    8000272c:	1800                	addi	s0,sp,48
    8000272e:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002730:	05050493          	addi	s1,a0,80
    80002734:	08050913          	addi	s2,a0,128
    80002738:	a021                	j	80002740 <itrunc+0x20>
    8000273a:	0491                	addi	s1,s1,4
    8000273c:	01248b63          	beq	s1,s2,80002752 <itrunc+0x32>
    if(ip->addrs[i]){
    80002740:	408c                	lw	a1,0(s1)
    80002742:	dde5                	beqz	a1,8000273a <itrunc+0x1a>
      bfree(ip->dev, ip->addrs[i]);
    80002744:	0009a503          	lw	a0,0(s3)
    80002748:	a39ff0ef          	jal	80002180 <bfree>
      ip->addrs[i] = 0;
    8000274c:	0004a023          	sw	zero,0(s1)
    80002750:	b7ed                	j	8000273a <itrunc+0x1a>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002752:	0809a583          	lw	a1,128(s3)
    80002756:	ed89                	bnez	a1,80002770 <itrunc+0x50>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002758:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    8000275c:	854e                	mv	a0,s3
    8000275e:	e21ff0ef          	jal	8000257e <iupdate>
}
    80002762:	70a2                	ld	ra,40(sp)
    80002764:	7402                	ld	s0,32(sp)
    80002766:	64e2                	ld	s1,24(sp)
    80002768:	6942                	ld	s2,16(sp)
    8000276a:	69a2                	ld	s3,8(sp)
    8000276c:	6145                	addi	sp,sp,48
    8000276e:	8082                	ret
    80002770:	e052                	sd	s4,0(sp)
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002772:	0009a503          	lw	a0,0(s3)
    80002776:	817ff0ef          	jal	80001f8c <bread>
    8000277a:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    8000277c:	05850493          	addi	s1,a0,88
    80002780:	45850913          	addi	s2,a0,1112
    80002784:	a021                	j	8000278c <itrunc+0x6c>
    80002786:	0491                	addi	s1,s1,4
    80002788:	01248963          	beq	s1,s2,8000279a <itrunc+0x7a>
      if(a[j])
    8000278c:	408c                	lw	a1,0(s1)
    8000278e:	dde5                	beqz	a1,80002786 <itrunc+0x66>
        bfree(ip->dev, a[j]);
    80002790:	0009a503          	lw	a0,0(s3)
    80002794:	9edff0ef          	jal	80002180 <bfree>
    80002798:	b7fd                	j	80002786 <itrunc+0x66>
    brelse(bp);
    8000279a:	8552                	mv	a0,s4
    8000279c:	8f9ff0ef          	jal	80002094 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    800027a0:	0809a583          	lw	a1,128(s3)
    800027a4:	0009a503          	lw	a0,0(s3)
    800027a8:	9d9ff0ef          	jal	80002180 <bfree>
    ip->addrs[NDIRECT] = 0;
    800027ac:	0809a023          	sw	zero,128(s3)
    800027b0:	6a02                	ld	s4,0(sp)
    800027b2:	b75d                	j	80002758 <itrunc+0x38>

00000000800027b4 <iput>:
{
    800027b4:	1101                	addi	sp,sp,-32
    800027b6:	ec06                	sd	ra,24(sp)
    800027b8:	e822                	sd	s0,16(sp)
    800027ba:	e426                	sd	s1,8(sp)
    800027bc:	1000                	addi	s0,sp,32
    800027be:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    800027c0:	00016517          	auipc	a0,0x16
    800027c4:	fc850513          	addi	a0,a0,-56 # 80018788 <itable>
    800027c8:	09a030ef          	jal	80005862 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800027cc:	4498                	lw	a4,8(s1)
    800027ce:	4785                	li	a5,1
    800027d0:	02f70063          	beq	a4,a5,800027f0 <iput+0x3c>
  ip->ref--;
    800027d4:	449c                	lw	a5,8(s1)
    800027d6:	37fd                	addiw	a5,a5,-1
    800027d8:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    800027da:	00016517          	auipc	a0,0x16
    800027de:	fae50513          	addi	a0,a0,-82 # 80018788 <itable>
    800027e2:	114030ef          	jal	800058f6 <release>
}
    800027e6:	60e2                	ld	ra,24(sp)
    800027e8:	6442                	ld	s0,16(sp)
    800027ea:	64a2                	ld	s1,8(sp)
    800027ec:	6105                	addi	sp,sp,32
    800027ee:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    800027f0:	40bc                	lw	a5,64(s1)
    800027f2:	d3ed                	beqz	a5,800027d4 <iput+0x20>
    800027f4:	04a49783          	lh	a5,74(s1)
    800027f8:	fff1                	bnez	a5,800027d4 <iput+0x20>
    800027fa:	e04a                	sd	s2,0(sp)
    acquiresleep(&ip->lock);
    800027fc:	01048913          	addi	s2,s1,16
    80002800:	854a                	mv	a0,s2
    80002802:	2b7000ef          	jal	800032b8 <acquiresleep>
    release(&itable.lock);
    80002806:	00016517          	auipc	a0,0x16
    8000280a:	f8250513          	addi	a0,a0,-126 # 80018788 <itable>
    8000280e:	0e8030ef          	jal	800058f6 <release>
    itrunc(ip);
    80002812:	8526                	mv	a0,s1
    80002814:	f0dff0ef          	jal	80002720 <itrunc>
    ip->type = 0;
    80002818:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    8000281c:	8526                	mv	a0,s1
    8000281e:	d61ff0ef          	jal	8000257e <iupdate>
    ip->valid = 0;
    80002822:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002826:	854a                	mv	a0,s2
    80002828:	2d7000ef          	jal	800032fe <releasesleep>
    acquire(&itable.lock);
    8000282c:	00016517          	auipc	a0,0x16
    80002830:	f5c50513          	addi	a0,a0,-164 # 80018788 <itable>
    80002834:	02e030ef          	jal	80005862 <acquire>
    80002838:	6902                	ld	s2,0(sp)
    8000283a:	bf69                	j	800027d4 <iput+0x20>

000000008000283c <iunlockput>:
{
    8000283c:	1101                	addi	sp,sp,-32
    8000283e:	ec06                	sd	ra,24(sp)
    80002840:	e822                	sd	s0,16(sp)
    80002842:	e426                	sd	s1,8(sp)
    80002844:	1000                	addi	s0,sp,32
    80002846:	84aa                	mv	s1,a0
  iunlock(ip);
    80002848:	e99ff0ef          	jal	800026e0 <iunlock>
  iput(ip);
    8000284c:	8526                	mv	a0,s1
    8000284e:	f67ff0ef          	jal	800027b4 <iput>
}
    80002852:	60e2                	ld	ra,24(sp)
    80002854:	6442                	ld	s0,16(sp)
    80002856:	64a2                	ld	s1,8(sp)
    80002858:	6105                	addi	sp,sp,32
    8000285a:	8082                	ret

000000008000285c <ireclaim>:
  for (int inum = 1; inum < sb.ninodes; inum++) {
    8000285c:	00016717          	auipc	a4,0x16
    80002860:	f1872703          	lw	a4,-232(a4) # 80018774 <sb+0xc>
    80002864:	4785                	li	a5,1
    80002866:	0ae7fe63          	bgeu	a5,a4,80002922 <ireclaim+0xc6>
{
    8000286a:	7139                	addi	sp,sp,-64
    8000286c:	fc06                	sd	ra,56(sp)
    8000286e:	f822                	sd	s0,48(sp)
    80002870:	f426                	sd	s1,40(sp)
    80002872:	f04a                	sd	s2,32(sp)
    80002874:	ec4e                	sd	s3,24(sp)
    80002876:	e852                	sd	s4,16(sp)
    80002878:	e456                	sd	s5,8(sp)
    8000287a:	e05a                	sd	s6,0(sp)
    8000287c:	0080                	addi	s0,sp,64
    8000287e:	8aaa                	mv	s5,a0
  for (int inum = 1; inum < sb.ninodes; inum++) {
    80002880:	84be                	mv	s1,a5
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    80002882:	00016a17          	auipc	s4,0x16
    80002886:	ee6a0a13          	addi	s4,s4,-282 # 80018768 <sb>
      printf("ireclaim: orphaned inode %d\n", inum);
    8000288a:	00005b17          	auipc	s6,0x5
    8000288e:	b7eb0b13          	addi	s6,s6,-1154 # 80007408 <etext+0x408>
    80002892:	a099                	j	800028d8 <ireclaim+0x7c>
    80002894:	85ce                	mv	a1,s3
    80002896:	855a                	mv	a0,s6
    80002898:	22b020ef          	jal	800052c2 <printf>
      ip = iget(dev, inum);
    8000289c:	85ce                	mv	a1,s3
    8000289e:	8556                	mv	a0,s5
    800028a0:	b1fff0ef          	jal	800023be <iget>
    800028a4:	89aa                	mv	s3,a0
    brelse(bp);
    800028a6:	854a                	mv	a0,s2
    800028a8:	fecff0ef          	jal	80002094 <brelse>
    if (ip) {
    800028ac:	00098f63          	beqz	s3,800028ca <ireclaim+0x6e>
      begin_op();
    800028b0:	786000ef          	jal	80003036 <begin_op>
      ilock(ip);
    800028b4:	854e                	mv	a0,s3
    800028b6:	d7dff0ef          	jal	80002632 <ilock>
      iunlock(ip);
    800028ba:	854e                	mv	a0,s3
    800028bc:	e25ff0ef          	jal	800026e0 <iunlock>
      iput(ip);
    800028c0:	854e                	mv	a0,s3
    800028c2:	ef3ff0ef          	jal	800027b4 <iput>
      end_op();
    800028c6:	7da000ef          	jal	800030a0 <end_op>
  for (int inum = 1; inum < sb.ninodes; inum++) {
    800028ca:	0485                	addi	s1,s1,1
    800028cc:	00ca2703          	lw	a4,12(s4)
    800028d0:	0004879b          	sext.w	a5,s1
    800028d4:	02e7fd63          	bgeu	a5,a4,8000290e <ireclaim+0xb2>
    800028d8:	0004899b          	sext.w	s3,s1
    struct buf *bp = bread(dev, IBLOCK(inum, sb));
    800028dc:	0044d593          	srli	a1,s1,0x4
    800028e0:	018a2783          	lw	a5,24(s4)
    800028e4:	9dbd                	addw	a1,a1,a5
    800028e6:	8556                	mv	a0,s5
    800028e8:	ea4ff0ef          	jal	80001f8c <bread>
    800028ec:	892a                	mv	s2,a0
    struct dinode *dip = (struct dinode *)bp->data + inum % IPB;
    800028ee:	05850793          	addi	a5,a0,88
    800028f2:	00f9f713          	andi	a4,s3,15
    800028f6:	071a                	slli	a4,a4,0x6
    800028f8:	97ba                	add	a5,a5,a4
    if (dip->type != 0 && dip->nlink == 0) {  // is an orphaned inode
    800028fa:	00079703          	lh	a4,0(a5)
    800028fe:	c701                	beqz	a4,80002906 <ireclaim+0xaa>
    80002900:	00679783          	lh	a5,6(a5)
    80002904:	dbc1                	beqz	a5,80002894 <ireclaim+0x38>
    brelse(bp);
    80002906:	854a                	mv	a0,s2
    80002908:	f8cff0ef          	jal	80002094 <brelse>
    if (ip) {
    8000290c:	bf7d                	j	800028ca <ireclaim+0x6e>
}
    8000290e:	70e2                	ld	ra,56(sp)
    80002910:	7442                	ld	s0,48(sp)
    80002912:	74a2                	ld	s1,40(sp)
    80002914:	7902                	ld	s2,32(sp)
    80002916:	69e2                	ld	s3,24(sp)
    80002918:	6a42                	ld	s4,16(sp)
    8000291a:	6aa2                	ld	s5,8(sp)
    8000291c:	6b02                	ld	s6,0(sp)
    8000291e:	6121                	addi	sp,sp,64
    80002920:	8082                	ret
    80002922:	8082                	ret

0000000080002924 <fsinit>:
fsinit(int dev) {
    80002924:	7179                	addi	sp,sp,-48
    80002926:	f406                	sd	ra,40(sp)
    80002928:	f022                	sd	s0,32(sp)
    8000292a:	ec26                	sd	s1,24(sp)
    8000292c:	e84a                	sd	s2,16(sp)
    8000292e:	e44e                	sd	s3,8(sp)
    80002930:	1800                	addi	s0,sp,48
    80002932:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002934:	4585                	li	a1,1
    80002936:	e56ff0ef          	jal	80001f8c <bread>
    8000293a:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    8000293c:	00016997          	auipc	s3,0x16
    80002940:	e2c98993          	addi	s3,s3,-468 # 80018768 <sb>
    80002944:	02000613          	li	a2,32
    80002948:	05850593          	addi	a1,a0,88
    8000294c:	854e                	mv	a0,s3
    8000294e:	865fd0ef          	jal	800001b2 <memmove>
  brelse(bp);
    80002952:	8526                	mv	a0,s1
    80002954:	f40ff0ef          	jal	80002094 <brelse>
  if(sb.magic != FSMAGIC)
    80002958:	0009a703          	lw	a4,0(s3)
    8000295c:	102037b7          	lui	a5,0x10203
    80002960:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002964:	02f71363          	bne	a4,a5,8000298a <fsinit+0x66>
  initlog(dev, &sb);
    80002968:	00016597          	auipc	a1,0x16
    8000296c:	e0058593          	addi	a1,a1,-512 # 80018768 <sb>
    80002970:	854a                	mv	a0,s2
    80002972:	646000ef          	jal	80002fb8 <initlog>
  ireclaim(dev);
    80002976:	854a                	mv	a0,s2
    80002978:	ee5ff0ef          	jal	8000285c <ireclaim>
}
    8000297c:	70a2                	ld	ra,40(sp)
    8000297e:	7402                	ld	s0,32(sp)
    80002980:	64e2                	ld	s1,24(sp)
    80002982:	6942                	ld	s2,16(sp)
    80002984:	69a2                	ld	s3,8(sp)
    80002986:	6145                	addi	sp,sp,48
    80002988:	8082                	ret
    panic("invalid file system");
    8000298a:	00005517          	auipc	a0,0x5
    8000298e:	a9e50513          	addi	a0,a0,-1378 # 80007428 <etext+0x428>
    80002992:	415020ef          	jal	800055a6 <panic>

0000000080002996 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002996:	1141                	addi	sp,sp,-16
    80002998:	e406                	sd	ra,8(sp)
    8000299a:	e022                	sd	s0,0(sp)
    8000299c:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    8000299e:	411c                	lw	a5,0(a0)
    800029a0:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    800029a2:	415c                	lw	a5,4(a0)
    800029a4:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    800029a6:	04451783          	lh	a5,68(a0)
    800029aa:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    800029ae:	04a51783          	lh	a5,74(a0)
    800029b2:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    800029b6:	04c56783          	lwu	a5,76(a0)
    800029ba:	e99c                	sd	a5,16(a1)
}
    800029bc:	60a2                	ld	ra,8(sp)
    800029be:	6402                	ld	s0,0(sp)
    800029c0:	0141                	addi	sp,sp,16
    800029c2:	8082                	ret

00000000800029c4 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    800029c4:	457c                	lw	a5,76(a0)
    800029c6:	0ed7e663          	bltu	a5,a3,80002ab2 <readi+0xee>
{
    800029ca:	7159                	addi	sp,sp,-112
    800029cc:	f486                	sd	ra,104(sp)
    800029ce:	f0a2                	sd	s0,96(sp)
    800029d0:	eca6                	sd	s1,88(sp)
    800029d2:	e0d2                	sd	s4,64(sp)
    800029d4:	fc56                	sd	s5,56(sp)
    800029d6:	f85a                	sd	s6,48(sp)
    800029d8:	f45e                	sd	s7,40(sp)
    800029da:	1880                	addi	s0,sp,112
    800029dc:	8b2a                	mv	s6,a0
    800029de:	8bae                	mv	s7,a1
    800029e0:	8a32                	mv	s4,a2
    800029e2:	84b6                	mv	s1,a3
    800029e4:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    800029e6:	9f35                	addw	a4,a4,a3
    return 0;
    800029e8:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    800029ea:	0ad76b63          	bltu	a4,a3,80002aa0 <readi+0xdc>
    800029ee:	e4ce                	sd	s3,72(sp)
  if(off + n > ip->size)
    800029f0:	00e7f463          	bgeu	a5,a4,800029f8 <readi+0x34>
    n = ip->size - off;
    800029f4:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800029f8:	080a8b63          	beqz	s5,80002a8e <readi+0xca>
    800029fc:	e8ca                	sd	s2,80(sp)
    800029fe:	f062                	sd	s8,32(sp)
    80002a00:	ec66                	sd	s9,24(sp)
    80002a02:	e86a                	sd	s10,16(sp)
    80002a04:	e46e                	sd	s11,8(sp)
    80002a06:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a08:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002a0c:	5c7d                	li	s8,-1
    80002a0e:	a80d                	j	80002a40 <readi+0x7c>
    80002a10:	020d1d93          	slli	s11,s10,0x20
    80002a14:	020ddd93          	srli	s11,s11,0x20
    80002a18:	05890613          	addi	a2,s2,88
    80002a1c:	86ee                	mv	a3,s11
    80002a1e:	963e                	add	a2,a2,a5
    80002a20:	85d2                	mv	a1,s4
    80002a22:	855e                	mv	a0,s7
    80002a24:	c9bfe0ef          	jal	800016be <either_copyout>
    80002a28:	05850363          	beq	a0,s8,80002a6e <readi+0xaa>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002a2c:	854a                	mv	a0,s2
    80002a2e:	e66ff0ef          	jal	80002094 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a32:	013d09bb          	addw	s3,s10,s3
    80002a36:	009d04bb          	addw	s1,s10,s1
    80002a3a:	9a6e                	add	s4,s4,s11
    80002a3c:	0559f363          	bgeu	s3,s5,80002a82 <readi+0xbe>
    uint addr = bmap(ip, off/BSIZE);
    80002a40:	00a4d59b          	srliw	a1,s1,0xa
    80002a44:	855a                	mv	a0,s6
    80002a46:	8b9ff0ef          	jal	800022fe <bmap>
    80002a4a:	85aa                	mv	a1,a0
    if(addr == 0)
    80002a4c:	c139                	beqz	a0,80002a92 <readi+0xce>
    bp = bread(ip->dev, addr);
    80002a4e:	000b2503          	lw	a0,0(s6)
    80002a52:	d3aff0ef          	jal	80001f8c <bread>
    80002a56:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002a58:	3ff4f793          	andi	a5,s1,1023
    80002a5c:	40fc873b          	subw	a4,s9,a5
    80002a60:	413a86bb          	subw	a3,s5,s3
    80002a64:	8d3a                	mv	s10,a4
    80002a66:	fae6f5e3          	bgeu	a3,a4,80002a10 <readi+0x4c>
    80002a6a:	8d36                	mv	s10,a3
    80002a6c:	b755                	j	80002a10 <readi+0x4c>
      brelse(bp);
    80002a6e:	854a                	mv	a0,s2
    80002a70:	e24ff0ef          	jal	80002094 <brelse>
      tot = -1;
    80002a74:	59fd                	li	s3,-1
      break;
    80002a76:	6946                	ld	s2,80(sp)
    80002a78:	7c02                	ld	s8,32(sp)
    80002a7a:	6ce2                	ld	s9,24(sp)
    80002a7c:	6d42                	ld	s10,16(sp)
    80002a7e:	6da2                	ld	s11,8(sp)
    80002a80:	a831                	j	80002a9c <readi+0xd8>
    80002a82:	6946                	ld	s2,80(sp)
    80002a84:	7c02                	ld	s8,32(sp)
    80002a86:	6ce2                	ld	s9,24(sp)
    80002a88:	6d42                	ld	s10,16(sp)
    80002a8a:	6da2                	ld	s11,8(sp)
    80002a8c:	a801                	j	80002a9c <readi+0xd8>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002a8e:	89d6                	mv	s3,s5
    80002a90:	a031                	j	80002a9c <readi+0xd8>
    80002a92:	6946                	ld	s2,80(sp)
    80002a94:	7c02                	ld	s8,32(sp)
    80002a96:	6ce2                	ld	s9,24(sp)
    80002a98:	6d42                	ld	s10,16(sp)
    80002a9a:	6da2                	ld	s11,8(sp)
  }
  return tot;
    80002a9c:	854e                	mv	a0,s3
    80002a9e:	69a6                	ld	s3,72(sp)
}
    80002aa0:	70a6                	ld	ra,104(sp)
    80002aa2:	7406                	ld	s0,96(sp)
    80002aa4:	64e6                	ld	s1,88(sp)
    80002aa6:	6a06                	ld	s4,64(sp)
    80002aa8:	7ae2                	ld	s5,56(sp)
    80002aaa:	7b42                	ld	s6,48(sp)
    80002aac:	7ba2                	ld	s7,40(sp)
    80002aae:	6165                	addi	sp,sp,112
    80002ab0:	8082                	ret
    return 0;
    80002ab2:	4501                	li	a0,0
}
    80002ab4:	8082                	ret

0000000080002ab6 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002ab6:	457c                	lw	a5,76(a0)
    80002ab8:	0ed7eb63          	bltu	a5,a3,80002bae <writei+0xf8>
{
    80002abc:	7159                	addi	sp,sp,-112
    80002abe:	f486                	sd	ra,104(sp)
    80002ac0:	f0a2                	sd	s0,96(sp)
    80002ac2:	e8ca                	sd	s2,80(sp)
    80002ac4:	e0d2                	sd	s4,64(sp)
    80002ac6:	fc56                	sd	s5,56(sp)
    80002ac8:	f85a                	sd	s6,48(sp)
    80002aca:	f45e                	sd	s7,40(sp)
    80002acc:	1880                	addi	s0,sp,112
    80002ace:	8aaa                	mv	s5,a0
    80002ad0:	8bae                	mv	s7,a1
    80002ad2:	8a32                	mv	s4,a2
    80002ad4:	8936                	mv	s2,a3
    80002ad6:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002ad8:	00e687bb          	addw	a5,a3,a4
    80002adc:	0cd7eb63          	bltu	a5,a3,80002bb2 <writei+0xfc>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002ae0:	00043737          	lui	a4,0x43
    80002ae4:	0cf76963          	bltu	a4,a5,80002bb6 <writei+0x100>
    80002ae8:	e4ce                	sd	s3,72(sp)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002aea:	0a0b0a63          	beqz	s6,80002b9e <writei+0xe8>
    80002aee:	eca6                	sd	s1,88(sp)
    80002af0:	f062                	sd	s8,32(sp)
    80002af2:	ec66                	sd	s9,24(sp)
    80002af4:	e86a                	sd	s10,16(sp)
    80002af6:	e46e                	sd	s11,8(sp)
    80002af8:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002afa:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002afe:	5c7d                	li	s8,-1
    80002b00:	a825                	j	80002b38 <writei+0x82>
    80002b02:	020d1d93          	slli	s11,s10,0x20
    80002b06:	020ddd93          	srli	s11,s11,0x20
    80002b0a:	05848513          	addi	a0,s1,88
    80002b0e:	86ee                	mv	a3,s11
    80002b10:	8652                	mv	a2,s4
    80002b12:	85de                	mv	a1,s7
    80002b14:	953e                	add	a0,a0,a5
    80002b16:	bf3fe0ef          	jal	80001708 <either_copyin>
    80002b1a:	05850663          	beq	a0,s8,80002b66 <writei+0xb0>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002b1e:	8526                	mv	a0,s1
    80002b20:	6a0000ef          	jal	800031c0 <log_write>
    brelse(bp);
    80002b24:	8526                	mv	a0,s1
    80002b26:	d6eff0ef          	jal	80002094 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b2a:	013d09bb          	addw	s3,s10,s3
    80002b2e:	012d093b          	addw	s2,s10,s2
    80002b32:	9a6e                	add	s4,s4,s11
    80002b34:	0369fc63          	bgeu	s3,s6,80002b6c <writei+0xb6>
    uint addr = bmap(ip, off/BSIZE);
    80002b38:	00a9559b          	srliw	a1,s2,0xa
    80002b3c:	8556                	mv	a0,s5
    80002b3e:	fc0ff0ef          	jal	800022fe <bmap>
    80002b42:	85aa                	mv	a1,a0
    if(addr == 0)
    80002b44:	c505                	beqz	a0,80002b6c <writei+0xb6>
    bp = bread(ip->dev, addr);
    80002b46:	000aa503          	lw	a0,0(s5)
    80002b4a:	c42ff0ef          	jal	80001f8c <bread>
    80002b4e:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002b50:	3ff97793          	andi	a5,s2,1023
    80002b54:	40fc873b          	subw	a4,s9,a5
    80002b58:	413b06bb          	subw	a3,s6,s3
    80002b5c:	8d3a                	mv	s10,a4
    80002b5e:	fae6f2e3          	bgeu	a3,a4,80002b02 <writei+0x4c>
    80002b62:	8d36                	mv	s10,a3
    80002b64:	bf79                	j	80002b02 <writei+0x4c>
      brelse(bp);
    80002b66:	8526                	mv	a0,s1
    80002b68:	d2cff0ef          	jal	80002094 <brelse>
  }

  if(off > ip->size)
    80002b6c:	04caa783          	lw	a5,76(s5)
    80002b70:	0327f963          	bgeu	a5,s2,80002ba2 <writei+0xec>
    ip->size = off;
    80002b74:	052aa623          	sw	s2,76(s5)
    80002b78:	64e6                	ld	s1,88(sp)
    80002b7a:	7c02                	ld	s8,32(sp)
    80002b7c:	6ce2                	ld	s9,24(sp)
    80002b7e:	6d42                	ld	s10,16(sp)
    80002b80:	6da2                	ld	s11,8(sp)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002b82:	8556                	mv	a0,s5
    80002b84:	9fbff0ef          	jal	8000257e <iupdate>

  return tot;
    80002b88:	854e                	mv	a0,s3
    80002b8a:	69a6                	ld	s3,72(sp)
}
    80002b8c:	70a6                	ld	ra,104(sp)
    80002b8e:	7406                	ld	s0,96(sp)
    80002b90:	6946                	ld	s2,80(sp)
    80002b92:	6a06                	ld	s4,64(sp)
    80002b94:	7ae2                	ld	s5,56(sp)
    80002b96:	7b42                	ld	s6,48(sp)
    80002b98:	7ba2                	ld	s7,40(sp)
    80002b9a:	6165                	addi	sp,sp,112
    80002b9c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002b9e:	89da                	mv	s3,s6
    80002ba0:	b7cd                	j	80002b82 <writei+0xcc>
    80002ba2:	64e6                	ld	s1,88(sp)
    80002ba4:	7c02                	ld	s8,32(sp)
    80002ba6:	6ce2                	ld	s9,24(sp)
    80002ba8:	6d42                	ld	s10,16(sp)
    80002baa:	6da2                	ld	s11,8(sp)
    80002bac:	bfd9                	j	80002b82 <writei+0xcc>
    return -1;
    80002bae:	557d                	li	a0,-1
}
    80002bb0:	8082                	ret
    return -1;
    80002bb2:	557d                	li	a0,-1
    80002bb4:	bfe1                	j	80002b8c <writei+0xd6>
    return -1;
    80002bb6:	557d                	li	a0,-1
    80002bb8:	bfd1                	j	80002b8c <writei+0xd6>

0000000080002bba <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002bba:	1141                	addi	sp,sp,-16
    80002bbc:	e406                	sd	ra,8(sp)
    80002bbe:	e022                	sd	s0,0(sp)
    80002bc0:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002bc2:	4639                	li	a2,14
    80002bc4:	e62fd0ef          	jal	80000226 <strncmp>
}
    80002bc8:	60a2                	ld	ra,8(sp)
    80002bca:	6402                	ld	s0,0(sp)
    80002bcc:	0141                	addi	sp,sp,16
    80002bce:	8082                	ret

0000000080002bd0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002bd0:	711d                	addi	sp,sp,-96
    80002bd2:	ec86                	sd	ra,88(sp)
    80002bd4:	e8a2                	sd	s0,80(sp)
    80002bd6:	e4a6                	sd	s1,72(sp)
    80002bd8:	e0ca                	sd	s2,64(sp)
    80002bda:	fc4e                	sd	s3,56(sp)
    80002bdc:	f852                	sd	s4,48(sp)
    80002bde:	f456                	sd	s5,40(sp)
    80002be0:	f05a                	sd	s6,32(sp)
    80002be2:	ec5e                	sd	s7,24(sp)
    80002be4:	1080                	addi	s0,sp,96
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002be6:	04451703          	lh	a4,68(a0)
    80002bea:	4785                	li	a5,1
    80002bec:	00f71f63          	bne	a4,a5,80002c0a <dirlookup+0x3a>
    80002bf0:	892a                	mv	s2,a0
    80002bf2:	8aae                	mv	s5,a1
    80002bf4:	8bb2                	mv	s7,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002bf6:	457c                	lw	a5,76(a0)
    80002bf8:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002bfa:	fa040a13          	addi	s4,s0,-96
    80002bfe:	49c1                	li	s3,16
      panic("dirlookup read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
    80002c00:	fa240b13          	addi	s6,s0,-94
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002c04:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c06:	e39d                	bnez	a5,80002c2c <dirlookup+0x5c>
    80002c08:	a8b9                	j	80002c66 <dirlookup+0x96>
    panic("dirlookup not DIR");
    80002c0a:	00005517          	auipc	a0,0x5
    80002c0e:	83650513          	addi	a0,a0,-1994 # 80007440 <etext+0x440>
    80002c12:	195020ef          	jal	800055a6 <panic>
      panic("dirlookup read");
    80002c16:	00005517          	auipc	a0,0x5
    80002c1a:	84250513          	addi	a0,a0,-1982 # 80007458 <etext+0x458>
    80002c1e:	189020ef          	jal	800055a6 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002c22:	24c1                	addiw	s1,s1,16
    80002c24:	04c92783          	lw	a5,76(s2)
    80002c28:	02f4fe63          	bgeu	s1,a5,80002c64 <dirlookup+0x94>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002c2c:	874e                	mv	a4,s3
    80002c2e:	86a6                	mv	a3,s1
    80002c30:	8652                	mv	a2,s4
    80002c32:	4581                	li	a1,0
    80002c34:	854a                	mv	a0,s2
    80002c36:	d8fff0ef          	jal	800029c4 <readi>
    80002c3a:	fd351ee3          	bne	a0,s3,80002c16 <dirlookup+0x46>
    if(de.inum == 0)
    80002c3e:	fa045783          	lhu	a5,-96(s0)
    80002c42:	d3e5                	beqz	a5,80002c22 <dirlookup+0x52>
    if(namecmp(name, de.name) == 0){
    80002c44:	85da                	mv	a1,s6
    80002c46:	8556                	mv	a0,s5
    80002c48:	f73ff0ef          	jal	80002bba <namecmp>
    80002c4c:	f979                	bnez	a0,80002c22 <dirlookup+0x52>
      if(poff)
    80002c4e:	000b8463          	beqz	s7,80002c56 <dirlookup+0x86>
        *poff = off;
    80002c52:	009ba023          	sw	s1,0(s7)
      return iget(dp->dev, inum);
    80002c56:	fa045583          	lhu	a1,-96(s0)
    80002c5a:	00092503          	lw	a0,0(s2)
    80002c5e:	f60ff0ef          	jal	800023be <iget>
    80002c62:	a011                	j	80002c66 <dirlookup+0x96>
  return 0;
    80002c64:	4501                	li	a0,0
}
    80002c66:	60e6                	ld	ra,88(sp)
    80002c68:	6446                	ld	s0,80(sp)
    80002c6a:	64a6                	ld	s1,72(sp)
    80002c6c:	6906                	ld	s2,64(sp)
    80002c6e:	79e2                	ld	s3,56(sp)
    80002c70:	7a42                	ld	s4,48(sp)
    80002c72:	7aa2                	ld	s5,40(sp)
    80002c74:	7b02                	ld	s6,32(sp)
    80002c76:	6be2                	ld	s7,24(sp)
    80002c78:	6125                	addi	sp,sp,96
    80002c7a:	8082                	ret

0000000080002c7c <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80002c7c:	711d                	addi	sp,sp,-96
    80002c7e:	ec86                	sd	ra,88(sp)
    80002c80:	e8a2                	sd	s0,80(sp)
    80002c82:	e4a6                	sd	s1,72(sp)
    80002c84:	e0ca                	sd	s2,64(sp)
    80002c86:	fc4e                	sd	s3,56(sp)
    80002c88:	f852                	sd	s4,48(sp)
    80002c8a:	f456                	sd	s5,40(sp)
    80002c8c:	f05a                	sd	s6,32(sp)
    80002c8e:	ec5e                	sd	s7,24(sp)
    80002c90:	e862                	sd	s8,16(sp)
    80002c92:	e466                	sd	s9,8(sp)
    80002c94:	e06a                	sd	s10,0(sp)
    80002c96:	1080                	addi	s0,sp,96
    80002c98:	84aa                	mv	s1,a0
    80002c9a:	8b2e                	mv	s6,a1
    80002c9c:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80002c9e:	00054703          	lbu	a4,0(a0)
    80002ca2:	02f00793          	li	a5,47
    80002ca6:	00f70f63          	beq	a4,a5,80002cc4 <namex+0x48>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80002caa:	8c6fe0ef          	jal	80000d70 <myproc>
    80002cae:	15053503          	ld	a0,336(a0)
    80002cb2:	94bff0ef          	jal	800025fc <idup>
    80002cb6:	8a2a                	mv	s4,a0
  while(*path == '/')
    80002cb8:	02f00913          	li	s2,47
  if(len >= DIRSIZ)
    80002cbc:	4c35                	li	s8,13
    memmove(name, s, DIRSIZ);
    80002cbe:	4cb9                	li	s9,14

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80002cc0:	4b85                	li	s7,1
    80002cc2:	a879                	j	80002d60 <namex+0xe4>
    ip = iget(ROOTDEV, ROOTINO);
    80002cc4:	4585                	li	a1,1
    80002cc6:	852e                	mv	a0,a1
    80002cc8:	ef6ff0ef          	jal	800023be <iget>
    80002ccc:	8a2a                	mv	s4,a0
    80002cce:	b7ed                	j	80002cb8 <namex+0x3c>
      iunlockput(ip);
    80002cd0:	8552                	mv	a0,s4
    80002cd2:	b6bff0ef          	jal	8000283c <iunlockput>
      return 0;
    80002cd6:	4a01                	li	s4,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80002cd8:	8552                	mv	a0,s4
    80002cda:	60e6                	ld	ra,88(sp)
    80002cdc:	6446                	ld	s0,80(sp)
    80002cde:	64a6                	ld	s1,72(sp)
    80002ce0:	6906                	ld	s2,64(sp)
    80002ce2:	79e2                	ld	s3,56(sp)
    80002ce4:	7a42                	ld	s4,48(sp)
    80002ce6:	7aa2                	ld	s5,40(sp)
    80002ce8:	7b02                	ld	s6,32(sp)
    80002cea:	6be2                	ld	s7,24(sp)
    80002cec:	6c42                	ld	s8,16(sp)
    80002cee:	6ca2                	ld	s9,8(sp)
    80002cf0:	6d02                	ld	s10,0(sp)
    80002cf2:	6125                	addi	sp,sp,96
    80002cf4:	8082                	ret
      iunlock(ip);
    80002cf6:	8552                	mv	a0,s4
    80002cf8:	9e9ff0ef          	jal	800026e0 <iunlock>
      return ip;
    80002cfc:	bff1                	j	80002cd8 <namex+0x5c>
      iunlockput(ip);
    80002cfe:	8552                	mv	a0,s4
    80002d00:	b3dff0ef          	jal	8000283c <iunlockput>
      return 0;
    80002d04:	8a4e                	mv	s4,s3
    80002d06:	bfc9                	j	80002cd8 <namex+0x5c>
  len = path - s;
    80002d08:	40998633          	sub	a2,s3,s1
    80002d0c:	00060d1b          	sext.w	s10,a2
  if(len >= DIRSIZ)
    80002d10:	09ac5063          	bge	s8,s10,80002d90 <namex+0x114>
    memmove(name, s, DIRSIZ);
    80002d14:	8666                	mv	a2,s9
    80002d16:	85a6                	mv	a1,s1
    80002d18:	8556                	mv	a0,s5
    80002d1a:	c98fd0ef          	jal	800001b2 <memmove>
    80002d1e:	84ce                	mv	s1,s3
  while(*path == '/')
    80002d20:	0004c783          	lbu	a5,0(s1)
    80002d24:	01279763          	bne	a5,s2,80002d32 <namex+0xb6>
    path++;
    80002d28:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002d2a:	0004c783          	lbu	a5,0(s1)
    80002d2e:	ff278de3          	beq	a5,s2,80002d28 <namex+0xac>
    ilock(ip);
    80002d32:	8552                	mv	a0,s4
    80002d34:	8ffff0ef          	jal	80002632 <ilock>
    if(ip->type != T_DIR){
    80002d38:	044a1783          	lh	a5,68(s4)
    80002d3c:	f9779ae3          	bne	a5,s7,80002cd0 <namex+0x54>
    if(nameiparent && *path == '\0'){
    80002d40:	000b0563          	beqz	s6,80002d4a <namex+0xce>
    80002d44:	0004c783          	lbu	a5,0(s1)
    80002d48:	d7dd                	beqz	a5,80002cf6 <namex+0x7a>
    if((next = dirlookup(ip, name, 0)) == 0){
    80002d4a:	4601                	li	a2,0
    80002d4c:	85d6                	mv	a1,s5
    80002d4e:	8552                	mv	a0,s4
    80002d50:	e81ff0ef          	jal	80002bd0 <dirlookup>
    80002d54:	89aa                	mv	s3,a0
    80002d56:	d545                	beqz	a0,80002cfe <namex+0x82>
    iunlockput(ip);
    80002d58:	8552                	mv	a0,s4
    80002d5a:	ae3ff0ef          	jal	8000283c <iunlockput>
    ip = next;
    80002d5e:	8a4e                	mv	s4,s3
  while(*path == '/')
    80002d60:	0004c783          	lbu	a5,0(s1)
    80002d64:	01279763          	bne	a5,s2,80002d72 <namex+0xf6>
    path++;
    80002d68:	0485                	addi	s1,s1,1
  while(*path == '/')
    80002d6a:	0004c783          	lbu	a5,0(s1)
    80002d6e:	ff278de3          	beq	a5,s2,80002d68 <namex+0xec>
  if(*path == 0)
    80002d72:	cb8d                	beqz	a5,80002da4 <namex+0x128>
  while(*path != '/' && *path != 0)
    80002d74:	0004c783          	lbu	a5,0(s1)
    80002d78:	89a6                	mv	s3,s1
  len = path - s;
    80002d7a:	4d01                	li	s10,0
    80002d7c:	4601                	li	a2,0
  while(*path != '/' && *path != 0)
    80002d7e:	01278963          	beq	a5,s2,80002d90 <namex+0x114>
    80002d82:	d3d9                	beqz	a5,80002d08 <namex+0x8c>
    path++;
    80002d84:	0985                	addi	s3,s3,1
  while(*path != '/' && *path != 0)
    80002d86:	0009c783          	lbu	a5,0(s3)
    80002d8a:	ff279ce3          	bne	a5,s2,80002d82 <namex+0x106>
    80002d8e:	bfad                	j	80002d08 <namex+0x8c>
    memmove(name, s, len);
    80002d90:	2601                	sext.w	a2,a2
    80002d92:	85a6                	mv	a1,s1
    80002d94:	8556                	mv	a0,s5
    80002d96:	c1cfd0ef          	jal	800001b2 <memmove>
    name[len] = 0;
    80002d9a:	9d56                	add	s10,s10,s5
    80002d9c:	000d0023          	sb	zero,0(s10) # fffffffffffff000 <end+0xffffffff7ffdbab8>
    80002da0:	84ce                	mv	s1,s3
    80002da2:	bfbd                	j	80002d20 <namex+0xa4>
  if(nameiparent){
    80002da4:	f20b0ae3          	beqz	s6,80002cd8 <namex+0x5c>
    iput(ip);
    80002da8:	8552                	mv	a0,s4
    80002daa:	a0bff0ef          	jal	800027b4 <iput>
    return 0;
    80002dae:	4a01                	li	s4,0
    80002db0:	b725                	j	80002cd8 <namex+0x5c>

0000000080002db2 <dirlink>:
{
    80002db2:	715d                	addi	sp,sp,-80
    80002db4:	e486                	sd	ra,72(sp)
    80002db6:	e0a2                	sd	s0,64(sp)
    80002db8:	f84a                	sd	s2,48(sp)
    80002dba:	ec56                	sd	s5,24(sp)
    80002dbc:	e85a                	sd	s6,16(sp)
    80002dbe:	0880                	addi	s0,sp,80
    80002dc0:	892a                	mv	s2,a0
    80002dc2:	8aae                	mv	s5,a1
    80002dc4:	8b32                	mv	s6,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80002dc6:	4601                	li	a2,0
    80002dc8:	e09ff0ef          	jal	80002bd0 <dirlookup>
    80002dcc:	ed1d                	bnez	a0,80002e0a <dirlink+0x58>
    80002dce:	fc26                	sd	s1,56(sp)
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002dd0:	04c92483          	lw	s1,76(s2)
    80002dd4:	c4b9                	beqz	s1,80002e22 <dirlink+0x70>
    80002dd6:	f44e                	sd	s3,40(sp)
    80002dd8:	f052                	sd	s4,32(sp)
    80002dda:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002ddc:	fb040a13          	addi	s4,s0,-80
    80002de0:	49c1                	li	s3,16
    80002de2:	874e                	mv	a4,s3
    80002de4:	86a6                	mv	a3,s1
    80002de6:	8652                	mv	a2,s4
    80002de8:	4581                	li	a1,0
    80002dea:	854a                	mv	a0,s2
    80002dec:	bd9ff0ef          	jal	800029c4 <readi>
    80002df0:	03351163          	bne	a0,s3,80002e12 <dirlink+0x60>
    if(de.inum == 0)
    80002df4:	fb045783          	lhu	a5,-80(s0)
    80002df8:	c39d                	beqz	a5,80002e1e <dirlink+0x6c>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002dfa:	24c1                	addiw	s1,s1,16
    80002dfc:	04c92783          	lw	a5,76(s2)
    80002e00:	fef4e1e3          	bltu	s1,a5,80002de2 <dirlink+0x30>
    80002e04:	79a2                	ld	s3,40(sp)
    80002e06:	7a02                	ld	s4,32(sp)
    80002e08:	a829                	j	80002e22 <dirlink+0x70>
    iput(ip);
    80002e0a:	9abff0ef          	jal	800027b4 <iput>
    return -1;
    80002e0e:	557d                	li	a0,-1
    80002e10:	a83d                	j	80002e4e <dirlink+0x9c>
      panic("dirlink read");
    80002e12:	00004517          	auipc	a0,0x4
    80002e16:	65650513          	addi	a0,a0,1622 # 80007468 <etext+0x468>
    80002e1a:	78c020ef          	jal	800055a6 <panic>
    80002e1e:	79a2                	ld	s3,40(sp)
    80002e20:	7a02                	ld	s4,32(sp)
  strncpy(de.name, name, DIRSIZ);
    80002e22:	4639                	li	a2,14
    80002e24:	85d6                	mv	a1,s5
    80002e26:	fb240513          	addi	a0,s0,-78
    80002e2a:	c36fd0ef          	jal	80000260 <strncpy>
  de.inum = inum;
    80002e2e:	fb641823          	sh	s6,-80(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80002e32:	4741                	li	a4,16
    80002e34:	86a6                	mv	a3,s1
    80002e36:	fb040613          	addi	a2,s0,-80
    80002e3a:	4581                	li	a1,0
    80002e3c:	854a                	mv	a0,s2
    80002e3e:	c79ff0ef          	jal	80002ab6 <writei>
    80002e42:	1541                	addi	a0,a0,-16
    80002e44:	00a03533          	snez	a0,a0
    80002e48:	40a0053b          	negw	a0,a0
    80002e4c:	74e2                	ld	s1,56(sp)
}
    80002e4e:	60a6                	ld	ra,72(sp)
    80002e50:	6406                	ld	s0,64(sp)
    80002e52:	7942                	ld	s2,48(sp)
    80002e54:	6ae2                	ld	s5,24(sp)
    80002e56:	6b42                	ld	s6,16(sp)
    80002e58:	6161                	addi	sp,sp,80
    80002e5a:	8082                	ret

0000000080002e5c <namei>:

struct inode*
namei(char *path)
{
    80002e5c:	1101                	addi	sp,sp,-32
    80002e5e:	ec06                	sd	ra,24(sp)
    80002e60:	e822                	sd	s0,16(sp)
    80002e62:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80002e64:	fe040613          	addi	a2,s0,-32
    80002e68:	4581                	li	a1,0
    80002e6a:	e13ff0ef          	jal	80002c7c <namex>
}
    80002e6e:	60e2                	ld	ra,24(sp)
    80002e70:	6442                	ld	s0,16(sp)
    80002e72:	6105                	addi	sp,sp,32
    80002e74:	8082                	ret

0000000080002e76 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80002e76:	1141                	addi	sp,sp,-16
    80002e78:	e406                	sd	ra,8(sp)
    80002e7a:	e022                	sd	s0,0(sp)
    80002e7c:	0800                	addi	s0,sp,16
    80002e7e:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80002e80:	4585                	li	a1,1
    80002e82:	dfbff0ef          	jal	80002c7c <namex>
}
    80002e86:	60a2                	ld	ra,8(sp)
    80002e88:	6402                	ld	s0,0(sp)
    80002e8a:	0141                	addi	sp,sp,16
    80002e8c:	8082                	ret

0000000080002e8e <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80002e8e:	1101                	addi	sp,sp,-32
    80002e90:	ec06                	sd	ra,24(sp)
    80002e92:	e822                	sd	s0,16(sp)
    80002e94:	e426                	sd	s1,8(sp)
    80002e96:	e04a                	sd	s2,0(sp)
    80002e98:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80002e9a:	00017917          	auipc	s2,0x17
    80002e9e:	39690913          	addi	s2,s2,918 # 8001a230 <log>
    80002ea2:	01892583          	lw	a1,24(s2)
    80002ea6:	02492503          	lw	a0,36(s2)
    80002eaa:	8e2ff0ef          	jal	80001f8c <bread>
    80002eae:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80002eb0:	02892603          	lw	a2,40(s2)
    80002eb4:	cd30                	sw	a2,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80002eb6:	00c05f63          	blez	a2,80002ed4 <write_head+0x46>
    80002eba:	00017717          	auipc	a4,0x17
    80002ebe:	3a270713          	addi	a4,a4,930 # 8001a25c <log+0x2c>
    80002ec2:	87aa                	mv	a5,a0
    80002ec4:	060a                	slli	a2,a2,0x2
    80002ec6:	962a                	add	a2,a2,a0
    hb->block[i] = log.lh.block[i];
    80002ec8:	4314                	lw	a3,0(a4)
    80002eca:	cff4                	sw	a3,92(a5)
  for (i = 0; i < log.lh.n; i++) {
    80002ecc:	0711                	addi	a4,a4,4
    80002ece:	0791                	addi	a5,a5,4
    80002ed0:	fec79ce3          	bne	a5,a2,80002ec8 <write_head+0x3a>
  }
  bwrite(buf);
    80002ed4:	8526                	mv	a0,s1
    80002ed6:	98cff0ef          	jal	80002062 <bwrite>
  brelse(buf);
    80002eda:	8526                	mv	a0,s1
    80002edc:	9b8ff0ef          	jal	80002094 <brelse>
}
    80002ee0:	60e2                	ld	ra,24(sp)
    80002ee2:	6442                	ld	s0,16(sp)
    80002ee4:	64a2                	ld	s1,8(sp)
    80002ee6:	6902                	ld	s2,0(sp)
    80002ee8:	6105                	addi	sp,sp,32
    80002eea:	8082                	ret

0000000080002eec <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80002eec:	00017797          	auipc	a5,0x17
    80002ef0:	36c7a783          	lw	a5,876(a5) # 8001a258 <log+0x28>
    80002ef4:	0cf05163          	blez	a5,80002fb6 <install_trans+0xca>
{
    80002ef8:	715d                	addi	sp,sp,-80
    80002efa:	e486                	sd	ra,72(sp)
    80002efc:	e0a2                	sd	s0,64(sp)
    80002efe:	fc26                	sd	s1,56(sp)
    80002f00:	f84a                	sd	s2,48(sp)
    80002f02:	f44e                	sd	s3,40(sp)
    80002f04:	f052                	sd	s4,32(sp)
    80002f06:	ec56                	sd	s5,24(sp)
    80002f08:	e85a                	sd	s6,16(sp)
    80002f0a:	e45e                	sd	s7,8(sp)
    80002f0c:	e062                	sd	s8,0(sp)
    80002f0e:	0880                	addi	s0,sp,80
    80002f10:	8b2a                	mv	s6,a0
    80002f12:	00017a97          	auipc	s5,0x17
    80002f16:	34aa8a93          	addi	s5,s5,842 # 8001a25c <log+0x2c>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f1a:	4981                	li	s3,0
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002f1c:	00004c17          	auipc	s8,0x4
    80002f20:	55cc0c13          	addi	s8,s8,1372 # 80007478 <etext+0x478>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002f24:	00017a17          	auipc	s4,0x17
    80002f28:	30ca0a13          	addi	s4,s4,780 # 8001a230 <log>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002f2c:	40000b93          	li	s7,1024
    80002f30:	a025                	j	80002f58 <install_trans+0x6c>
      printf("recovering tail %d dst %d\n", tail, log.lh.block[tail]);
    80002f32:	000aa603          	lw	a2,0(s5)
    80002f36:	85ce                	mv	a1,s3
    80002f38:	8562                	mv	a0,s8
    80002f3a:	388020ef          	jal	800052c2 <printf>
    80002f3e:	a839                	j	80002f5c <install_trans+0x70>
    brelse(lbuf);
    80002f40:	854a                	mv	a0,s2
    80002f42:	952ff0ef          	jal	80002094 <brelse>
    brelse(dbuf);
    80002f46:	8526                	mv	a0,s1
    80002f48:	94cff0ef          	jal	80002094 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80002f4c:	2985                	addiw	s3,s3,1
    80002f4e:	0a91                	addi	s5,s5,4
    80002f50:	028a2783          	lw	a5,40(s4)
    80002f54:	04f9d563          	bge	s3,a5,80002f9e <install_trans+0xb2>
    if(recovering) {
    80002f58:	fc0b1de3          	bnez	s6,80002f32 <install_trans+0x46>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80002f5c:	018a2583          	lw	a1,24(s4)
    80002f60:	013585bb          	addw	a1,a1,s3
    80002f64:	2585                	addiw	a1,a1,1
    80002f66:	024a2503          	lw	a0,36(s4)
    80002f6a:	822ff0ef          	jal	80001f8c <bread>
    80002f6e:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80002f70:	000aa583          	lw	a1,0(s5)
    80002f74:	024a2503          	lw	a0,36(s4)
    80002f78:	814ff0ef          	jal	80001f8c <bread>
    80002f7c:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80002f7e:	865e                	mv	a2,s7
    80002f80:	05890593          	addi	a1,s2,88
    80002f84:	05850513          	addi	a0,a0,88
    80002f88:	a2afd0ef          	jal	800001b2 <memmove>
    bwrite(dbuf);  // write dst to disk
    80002f8c:	8526                	mv	a0,s1
    80002f8e:	8d4ff0ef          	jal	80002062 <bwrite>
    if(recovering == 0)
    80002f92:	fa0b17e3          	bnez	s6,80002f40 <install_trans+0x54>
      bunpin(dbuf);
    80002f96:	8526                	mv	a0,s1
    80002f98:	9b4ff0ef          	jal	8000214c <bunpin>
    80002f9c:	b755                	j	80002f40 <install_trans+0x54>
}
    80002f9e:	60a6                	ld	ra,72(sp)
    80002fa0:	6406                	ld	s0,64(sp)
    80002fa2:	74e2                	ld	s1,56(sp)
    80002fa4:	7942                	ld	s2,48(sp)
    80002fa6:	79a2                	ld	s3,40(sp)
    80002fa8:	7a02                	ld	s4,32(sp)
    80002faa:	6ae2                	ld	s5,24(sp)
    80002fac:	6b42                	ld	s6,16(sp)
    80002fae:	6ba2                	ld	s7,8(sp)
    80002fb0:	6c02                	ld	s8,0(sp)
    80002fb2:	6161                	addi	sp,sp,80
    80002fb4:	8082                	ret
    80002fb6:	8082                	ret

0000000080002fb8 <initlog>:
{
    80002fb8:	7179                	addi	sp,sp,-48
    80002fba:	f406                	sd	ra,40(sp)
    80002fbc:	f022                	sd	s0,32(sp)
    80002fbe:	ec26                	sd	s1,24(sp)
    80002fc0:	e84a                	sd	s2,16(sp)
    80002fc2:	e44e                	sd	s3,8(sp)
    80002fc4:	1800                	addi	s0,sp,48
    80002fc6:	892a                	mv	s2,a0
    80002fc8:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80002fca:	00017497          	auipc	s1,0x17
    80002fce:	26648493          	addi	s1,s1,614 # 8001a230 <log>
    80002fd2:	00004597          	auipc	a1,0x4
    80002fd6:	4c658593          	addi	a1,a1,1222 # 80007498 <etext+0x498>
    80002fda:	8526                	mv	a0,s1
    80002fdc:	003020ef          	jal	800057de <initlock>
  log.start = sb->logstart;
    80002fe0:	0149a583          	lw	a1,20(s3)
    80002fe4:	cc8c                	sw	a1,24(s1)
  log.dev = dev;
    80002fe6:	0324a223          	sw	s2,36(s1)
  struct buf *buf = bread(log.dev, log.start);
    80002fea:	854a                	mv	a0,s2
    80002fec:	fa1fe0ef          	jal	80001f8c <bread>
  log.lh.n = lh->n;
    80002ff0:	4d30                	lw	a2,88(a0)
    80002ff2:	d490                	sw	a2,40(s1)
  for (i = 0; i < log.lh.n; i++) {
    80002ff4:	00c05f63          	blez	a2,80003012 <initlog+0x5a>
    80002ff8:	87aa                	mv	a5,a0
    80002ffa:	00017717          	auipc	a4,0x17
    80002ffe:	26270713          	addi	a4,a4,610 # 8001a25c <log+0x2c>
    80003002:	060a                	slli	a2,a2,0x2
    80003004:	962a                	add	a2,a2,a0
    log.lh.block[i] = lh->block[i];
    80003006:	4ff4                	lw	a3,92(a5)
    80003008:	c314                	sw	a3,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000300a:	0791                	addi	a5,a5,4
    8000300c:	0711                	addi	a4,a4,4
    8000300e:	fec79ce3          	bne	a5,a2,80003006 <initlog+0x4e>
  brelse(buf);
    80003012:	882ff0ef          	jal	80002094 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80003016:	4505                	li	a0,1
    80003018:	ed5ff0ef          	jal	80002eec <install_trans>
  log.lh.n = 0;
    8000301c:	00017797          	auipc	a5,0x17
    80003020:	2207ae23          	sw	zero,572(a5) # 8001a258 <log+0x28>
  write_head(); // clear the log
    80003024:	e6bff0ef          	jal	80002e8e <write_head>
}
    80003028:	70a2                	ld	ra,40(sp)
    8000302a:	7402                	ld	s0,32(sp)
    8000302c:	64e2                	ld	s1,24(sp)
    8000302e:	6942                	ld	s2,16(sp)
    80003030:	69a2                	ld	s3,8(sp)
    80003032:	6145                	addi	sp,sp,48
    80003034:	8082                	ret

0000000080003036 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003036:	1101                	addi	sp,sp,-32
    80003038:	ec06                	sd	ra,24(sp)
    8000303a:	e822                	sd	s0,16(sp)
    8000303c:	e426                	sd	s1,8(sp)
    8000303e:	e04a                	sd	s2,0(sp)
    80003040:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003042:	00017517          	auipc	a0,0x17
    80003046:	1ee50513          	addi	a0,a0,494 # 8001a230 <log>
    8000304a:	019020ef          	jal	80005862 <acquire>
  while(1){
    if(log.committing){
    8000304e:	00017497          	auipc	s1,0x17
    80003052:	1e248493          	addi	s1,s1,482 # 8001a230 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    80003056:	4979                	li	s2,30
    80003058:	a029                	j	80003062 <begin_op+0x2c>
      sleep(&log, &log.lock);
    8000305a:	85a6                	mv	a1,s1
    8000305c:	8526                	mv	a0,s1
    8000305e:	b0afe0ef          	jal	80001368 <sleep>
    if(log.committing){
    80003062:	509c                	lw	a5,32(s1)
    80003064:	fbfd                	bnez	a5,8000305a <begin_op+0x24>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGBLOCKS){
    80003066:	4cd8                	lw	a4,28(s1)
    80003068:	2705                	addiw	a4,a4,1
    8000306a:	0027179b          	slliw	a5,a4,0x2
    8000306e:	9fb9                	addw	a5,a5,a4
    80003070:	0017979b          	slliw	a5,a5,0x1
    80003074:	5494                	lw	a3,40(s1)
    80003076:	9fb5                	addw	a5,a5,a3
    80003078:	00f95763          	bge	s2,a5,80003086 <begin_op+0x50>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    8000307c:	85a6                	mv	a1,s1
    8000307e:	8526                	mv	a0,s1
    80003080:	ae8fe0ef          	jal	80001368 <sleep>
    80003084:	bff9                	j	80003062 <begin_op+0x2c>
    } else {
      log.outstanding += 1;
    80003086:	00017517          	auipc	a0,0x17
    8000308a:	1aa50513          	addi	a0,a0,426 # 8001a230 <log>
    8000308e:	cd58                	sw	a4,28(a0)
      release(&log.lock);
    80003090:	067020ef          	jal	800058f6 <release>
      break;
    }
  }
}
    80003094:	60e2                	ld	ra,24(sp)
    80003096:	6442                	ld	s0,16(sp)
    80003098:	64a2                	ld	s1,8(sp)
    8000309a:	6902                	ld	s2,0(sp)
    8000309c:	6105                	addi	sp,sp,32
    8000309e:	8082                	ret

00000000800030a0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800030a0:	7139                	addi	sp,sp,-64
    800030a2:	fc06                	sd	ra,56(sp)
    800030a4:	f822                	sd	s0,48(sp)
    800030a6:	f426                	sd	s1,40(sp)
    800030a8:	f04a                	sd	s2,32(sp)
    800030aa:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800030ac:	00017497          	auipc	s1,0x17
    800030b0:	18448493          	addi	s1,s1,388 # 8001a230 <log>
    800030b4:	8526                	mv	a0,s1
    800030b6:	7ac020ef          	jal	80005862 <acquire>
  log.outstanding -= 1;
    800030ba:	4cdc                	lw	a5,28(s1)
    800030bc:	37fd                	addiw	a5,a5,-1
    800030be:	893e                	mv	s2,a5
    800030c0:	ccdc                	sw	a5,28(s1)
  if(log.committing)
    800030c2:	509c                	lw	a5,32(s1)
    800030c4:	ef9d                	bnez	a5,80003102 <end_op+0x62>
    panic("log.committing");
  if(log.outstanding == 0){
    800030c6:	04091863          	bnez	s2,80003116 <end_op+0x76>
    do_commit = 1;
    log.committing = 1;
    800030ca:	00017497          	auipc	s1,0x17
    800030ce:	16648493          	addi	s1,s1,358 # 8001a230 <log>
    800030d2:	4785                	li	a5,1
    800030d4:	d09c                	sw	a5,32(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    800030d6:	8526                	mv	a0,s1
    800030d8:	01f020ef          	jal	800058f6 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    800030dc:	549c                	lw	a5,40(s1)
    800030de:	04f04c63          	bgtz	a5,80003136 <end_op+0x96>
    acquire(&log.lock);
    800030e2:	00017497          	auipc	s1,0x17
    800030e6:	14e48493          	addi	s1,s1,334 # 8001a230 <log>
    800030ea:	8526                	mv	a0,s1
    800030ec:	776020ef          	jal	80005862 <acquire>
    log.committing = 0;
    800030f0:	0204a023          	sw	zero,32(s1)
    wakeup(&log);
    800030f4:	8526                	mv	a0,s1
    800030f6:	abefe0ef          	jal	800013b4 <wakeup>
    release(&log.lock);
    800030fa:	8526                	mv	a0,s1
    800030fc:	7fa020ef          	jal	800058f6 <release>
}
    80003100:	a02d                	j	8000312a <end_op+0x8a>
    80003102:	ec4e                	sd	s3,24(sp)
    80003104:	e852                	sd	s4,16(sp)
    80003106:	e456                	sd	s5,8(sp)
    80003108:	e05a                	sd	s6,0(sp)
    panic("log.committing");
    8000310a:	00004517          	auipc	a0,0x4
    8000310e:	39650513          	addi	a0,a0,918 # 800074a0 <etext+0x4a0>
    80003112:	494020ef          	jal	800055a6 <panic>
    wakeup(&log);
    80003116:	00017497          	auipc	s1,0x17
    8000311a:	11a48493          	addi	s1,s1,282 # 8001a230 <log>
    8000311e:	8526                	mv	a0,s1
    80003120:	a94fe0ef          	jal	800013b4 <wakeup>
  release(&log.lock);
    80003124:	8526                	mv	a0,s1
    80003126:	7d0020ef          	jal	800058f6 <release>
}
    8000312a:	70e2                	ld	ra,56(sp)
    8000312c:	7442                	ld	s0,48(sp)
    8000312e:	74a2                	ld	s1,40(sp)
    80003130:	7902                	ld	s2,32(sp)
    80003132:	6121                	addi	sp,sp,64
    80003134:	8082                	ret
    80003136:	ec4e                	sd	s3,24(sp)
    80003138:	e852                	sd	s4,16(sp)
    8000313a:	e456                	sd	s5,8(sp)
    8000313c:	e05a                	sd	s6,0(sp)
  for (tail = 0; tail < log.lh.n; tail++) {
    8000313e:	00017a97          	auipc	s5,0x17
    80003142:	11ea8a93          	addi	s5,s5,286 # 8001a25c <log+0x2c>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003146:	00017a17          	auipc	s4,0x17
    8000314a:	0eaa0a13          	addi	s4,s4,234 # 8001a230 <log>
    memmove(to->data, from->data, BSIZE);
    8000314e:	40000b13          	li	s6,1024
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    80003152:	018a2583          	lw	a1,24(s4)
    80003156:	012585bb          	addw	a1,a1,s2
    8000315a:	2585                	addiw	a1,a1,1
    8000315c:	024a2503          	lw	a0,36(s4)
    80003160:	e2dfe0ef          	jal	80001f8c <bread>
    80003164:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    80003166:	000aa583          	lw	a1,0(s5)
    8000316a:	024a2503          	lw	a0,36(s4)
    8000316e:	e1ffe0ef          	jal	80001f8c <bread>
    80003172:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    80003174:	865a                	mv	a2,s6
    80003176:	05850593          	addi	a1,a0,88
    8000317a:	05848513          	addi	a0,s1,88
    8000317e:	834fd0ef          	jal	800001b2 <memmove>
    bwrite(to);  // write the log
    80003182:	8526                	mv	a0,s1
    80003184:	edffe0ef          	jal	80002062 <bwrite>
    brelse(from);
    80003188:	854e                	mv	a0,s3
    8000318a:	f0bfe0ef          	jal	80002094 <brelse>
    brelse(to);
    8000318e:	8526                	mv	a0,s1
    80003190:	f05fe0ef          	jal	80002094 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003194:	2905                	addiw	s2,s2,1
    80003196:	0a91                	addi	s5,s5,4
    80003198:	028a2783          	lw	a5,40(s4)
    8000319c:	faf94be3          	blt	s2,a5,80003152 <end_op+0xb2>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    800031a0:	cefff0ef          	jal	80002e8e <write_head>
    install_trans(0); // Now install writes to home locations
    800031a4:	4501                	li	a0,0
    800031a6:	d47ff0ef          	jal	80002eec <install_trans>
    log.lh.n = 0;
    800031aa:	00017797          	auipc	a5,0x17
    800031ae:	0a07a723          	sw	zero,174(a5) # 8001a258 <log+0x28>
    write_head();    // Erase the transaction from the log
    800031b2:	cddff0ef          	jal	80002e8e <write_head>
    800031b6:	69e2                	ld	s3,24(sp)
    800031b8:	6a42                	ld	s4,16(sp)
    800031ba:	6aa2                	ld	s5,8(sp)
    800031bc:	6b02                	ld	s6,0(sp)
    800031be:	b715                	j	800030e2 <end_op+0x42>

00000000800031c0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    800031c0:	1101                	addi	sp,sp,-32
    800031c2:	ec06                	sd	ra,24(sp)
    800031c4:	e822                	sd	s0,16(sp)
    800031c6:	e426                	sd	s1,8(sp)
    800031c8:	e04a                	sd	s2,0(sp)
    800031ca:	1000                	addi	s0,sp,32
    800031cc:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    800031ce:	00017917          	auipc	s2,0x17
    800031d2:	06290913          	addi	s2,s2,98 # 8001a230 <log>
    800031d6:	854a                	mv	a0,s2
    800031d8:	68a020ef          	jal	80005862 <acquire>
  if (log.lh.n >= LOGBLOCKS)
    800031dc:	02892603          	lw	a2,40(s2)
    800031e0:	47f5                	li	a5,29
    800031e2:	04c7cc63          	blt	a5,a2,8000323a <log_write+0x7a>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800031e6:	00017797          	auipc	a5,0x17
    800031ea:	0667a783          	lw	a5,102(a5) # 8001a24c <log+0x1c>
    800031ee:	04f05c63          	blez	a5,80003246 <log_write+0x86>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800031f2:	4781                	li	a5,0
    800031f4:	04c05f63          	blez	a2,80003252 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800031f8:	44cc                	lw	a1,12(s1)
    800031fa:	00017717          	auipc	a4,0x17
    800031fe:	06270713          	addi	a4,a4,98 # 8001a25c <log+0x2c>
  for (i = 0; i < log.lh.n; i++) {
    80003202:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003204:	4314                	lw	a3,0(a4)
    80003206:	04b68663          	beq	a3,a1,80003252 <log_write+0x92>
  for (i = 0; i < log.lh.n; i++) {
    8000320a:	2785                	addiw	a5,a5,1
    8000320c:	0711                	addi	a4,a4,4
    8000320e:	fef61be3          	bne	a2,a5,80003204 <log_write+0x44>
      break;
  }
  log.lh.block[i] = b->blockno;
    80003212:	0621                	addi	a2,a2,8
    80003214:	060a                	slli	a2,a2,0x2
    80003216:	00017797          	auipc	a5,0x17
    8000321a:	01a78793          	addi	a5,a5,26 # 8001a230 <log>
    8000321e:	97b2                	add	a5,a5,a2
    80003220:	44d8                	lw	a4,12(s1)
    80003222:	c7d8                	sw	a4,12(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    80003224:	8526                	mv	a0,s1
    80003226:	ef3fe0ef          	jal	80002118 <bpin>
    log.lh.n++;
    8000322a:	00017717          	auipc	a4,0x17
    8000322e:	00670713          	addi	a4,a4,6 # 8001a230 <log>
    80003232:	571c                	lw	a5,40(a4)
    80003234:	2785                	addiw	a5,a5,1
    80003236:	d71c                	sw	a5,40(a4)
    80003238:	a80d                	j	8000326a <log_write+0xaa>
    panic("too big a transaction");
    8000323a:	00004517          	auipc	a0,0x4
    8000323e:	27650513          	addi	a0,a0,630 # 800074b0 <etext+0x4b0>
    80003242:	364020ef          	jal	800055a6 <panic>
    panic("log_write outside of trans");
    80003246:	00004517          	auipc	a0,0x4
    8000324a:	28250513          	addi	a0,a0,642 # 800074c8 <etext+0x4c8>
    8000324e:	358020ef          	jal	800055a6 <panic>
  log.lh.block[i] = b->blockno;
    80003252:	00878693          	addi	a3,a5,8
    80003256:	068a                	slli	a3,a3,0x2
    80003258:	00017717          	auipc	a4,0x17
    8000325c:	fd870713          	addi	a4,a4,-40 # 8001a230 <log>
    80003260:	9736                	add	a4,a4,a3
    80003262:	44d4                	lw	a3,12(s1)
    80003264:	c754                	sw	a3,12(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003266:	faf60fe3          	beq	a2,a5,80003224 <log_write+0x64>
  }
  release(&log.lock);
    8000326a:	00017517          	auipc	a0,0x17
    8000326e:	fc650513          	addi	a0,a0,-58 # 8001a230 <log>
    80003272:	684020ef          	jal	800058f6 <release>
}
    80003276:	60e2                	ld	ra,24(sp)
    80003278:	6442                	ld	s0,16(sp)
    8000327a:	64a2                	ld	s1,8(sp)
    8000327c:	6902                	ld	s2,0(sp)
    8000327e:	6105                	addi	sp,sp,32
    80003280:	8082                	ret

0000000080003282 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003282:	1101                	addi	sp,sp,-32
    80003284:	ec06                	sd	ra,24(sp)
    80003286:	e822                	sd	s0,16(sp)
    80003288:	e426                	sd	s1,8(sp)
    8000328a:	e04a                	sd	s2,0(sp)
    8000328c:	1000                	addi	s0,sp,32
    8000328e:	84aa                	mv	s1,a0
    80003290:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003292:	00004597          	auipc	a1,0x4
    80003296:	25658593          	addi	a1,a1,598 # 800074e8 <etext+0x4e8>
    8000329a:	0521                	addi	a0,a0,8
    8000329c:	542020ef          	jal	800057de <initlock>
  lk->name = name;
    800032a0:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    800032a4:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800032a8:	0204a423          	sw	zero,40(s1)
}
    800032ac:	60e2                	ld	ra,24(sp)
    800032ae:	6442                	ld	s0,16(sp)
    800032b0:	64a2                	ld	s1,8(sp)
    800032b2:	6902                	ld	s2,0(sp)
    800032b4:	6105                	addi	sp,sp,32
    800032b6:	8082                	ret

00000000800032b8 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    800032b8:	1101                	addi	sp,sp,-32
    800032ba:	ec06                	sd	ra,24(sp)
    800032bc:	e822                	sd	s0,16(sp)
    800032be:	e426                	sd	s1,8(sp)
    800032c0:	e04a                	sd	s2,0(sp)
    800032c2:	1000                	addi	s0,sp,32
    800032c4:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800032c6:	00850913          	addi	s2,a0,8
    800032ca:	854a                	mv	a0,s2
    800032cc:	596020ef          	jal	80005862 <acquire>
  while (lk->locked) {
    800032d0:	409c                	lw	a5,0(s1)
    800032d2:	c799                	beqz	a5,800032e0 <acquiresleep+0x28>
    sleep(lk, &lk->lk);
    800032d4:	85ca                	mv	a1,s2
    800032d6:	8526                	mv	a0,s1
    800032d8:	890fe0ef          	jal	80001368 <sleep>
  while (lk->locked) {
    800032dc:	409c                	lw	a5,0(s1)
    800032de:	fbfd                	bnez	a5,800032d4 <acquiresleep+0x1c>
  }
  lk->locked = 1;
    800032e0:	4785                	li	a5,1
    800032e2:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800032e4:	a8dfd0ef          	jal	80000d70 <myproc>
    800032e8:	591c                	lw	a5,48(a0)
    800032ea:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800032ec:	854a                	mv	a0,s2
    800032ee:	608020ef          	jal	800058f6 <release>
}
    800032f2:	60e2                	ld	ra,24(sp)
    800032f4:	6442                	ld	s0,16(sp)
    800032f6:	64a2                	ld	s1,8(sp)
    800032f8:	6902                	ld	s2,0(sp)
    800032fa:	6105                	addi	sp,sp,32
    800032fc:	8082                	ret

00000000800032fe <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800032fe:	1101                	addi	sp,sp,-32
    80003300:	ec06                	sd	ra,24(sp)
    80003302:	e822                	sd	s0,16(sp)
    80003304:	e426                	sd	s1,8(sp)
    80003306:	e04a                	sd	s2,0(sp)
    80003308:	1000                	addi	s0,sp,32
    8000330a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000330c:	00850913          	addi	s2,a0,8
    80003310:	854a                	mv	a0,s2
    80003312:	550020ef          	jal	80005862 <acquire>
  lk->locked = 0;
    80003316:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000331a:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    8000331e:	8526                	mv	a0,s1
    80003320:	894fe0ef          	jal	800013b4 <wakeup>
  release(&lk->lk);
    80003324:	854a                	mv	a0,s2
    80003326:	5d0020ef          	jal	800058f6 <release>
}
    8000332a:	60e2                	ld	ra,24(sp)
    8000332c:	6442                	ld	s0,16(sp)
    8000332e:	64a2                	ld	s1,8(sp)
    80003330:	6902                	ld	s2,0(sp)
    80003332:	6105                	addi	sp,sp,32
    80003334:	8082                	ret

0000000080003336 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003336:	7179                	addi	sp,sp,-48
    80003338:	f406                	sd	ra,40(sp)
    8000333a:	f022                	sd	s0,32(sp)
    8000333c:	ec26                	sd	s1,24(sp)
    8000333e:	e84a                	sd	s2,16(sp)
    80003340:	1800                	addi	s0,sp,48
    80003342:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003344:	00850913          	addi	s2,a0,8
    80003348:	854a                	mv	a0,s2
    8000334a:	518020ef          	jal	80005862 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    8000334e:	409c                	lw	a5,0(s1)
    80003350:	ef81                	bnez	a5,80003368 <holdingsleep+0x32>
    80003352:	4481                	li	s1,0
  release(&lk->lk);
    80003354:	854a                	mv	a0,s2
    80003356:	5a0020ef          	jal	800058f6 <release>
  return r;
}
    8000335a:	8526                	mv	a0,s1
    8000335c:	70a2                	ld	ra,40(sp)
    8000335e:	7402                	ld	s0,32(sp)
    80003360:	64e2                	ld	s1,24(sp)
    80003362:	6942                	ld	s2,16(sp)
    80003364:	6145                	addi	sp,sp,48
    80003366:	8082                	ret
    80003368:	e44e                	sd	s3,8(sp)
  r = lk->locked && (lk->pid == myproc()->pid);
    8000336a:	0284a983          	lw	s3,40(s1)
    8000336e:	a03fd0ef          	jal	80000d70 <myproc>
    80003372:	5904                	lw	s1,48(a0)
    80003374:	413484b3          	sub	s1,s1,s3
    80003378:	0014b493          	seqz	s1,s1
    8000337c:	69a2                	ld	s3,8(sp)
    8000337e:	bfd9                	j	80003354 <holdingsleep+0x1e>

0000000080003380 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003380:	1141                	addi	sp,sp,-16
    80003382:	e406                	sd	ra,8(sp)
    80003384:	e022                	sd	s0,0(sp)
    80003386:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003388:	00004597          	auipc	a1,0x4
    8000338c:	17058593          	addi	a1,a1,368 # 800074f8 <etext+0x4f8>
    80003390:	00017517          	auipc	a0,0x17
    80003394:	fe850513          	addi	a0,a0,-24 # 8001a378 <ftable>
    80003398:	446020ef          	jal	800057de <initlock>
}
    8000339c:	60a2                	ld	ra,8(sp)
    8000339e:	6402                	ld	s0,0(sp)
    800033a0:	0141                	addi	sp,sp,16
    800033a2:	8082                	ret

00000000800033a4 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800033a4:	1101                	addi	sp,sp,-32
    800033a6:	ec06                	sd	ra,24(sp)
    800033a8:	e822                	sd	s0,16(sp)
    800033aa:	e426                	sd	s1,8(sp)
    800033ac:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800033ae:	00017517          	auipc	a0,0x17
    800033b2:	fca50513          	addi	a0,a0,-54 # 8001a378 <ftable>
    800033b6:	4ac020ef          	jal	80005862 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800033ba:	00017497          	auipc	s1,0x17
    800033be:	fd648493          	addi	s1,s1,-42 # 8001a390 <ftable+0x18>
    800033c2:	00018717          	auipc	a4,0x18
    800033c6:	f6e70713          	addi	a4,a4,-146 # 8001b330 <disk>
    if(f->ref == 0){
    800033ca:	40dc                	lw	a5,4(s1)
    800033cc:	cf89                	beqz	a5,800033e6 <filealloc+0x42>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800033ce:	02848493          	addi	s1,s1,40
    800033d2:	fee49ce3          	bne	s1,a4,800033ca <filealloc+0x26>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800033d6:	00017517          	auipc	a0,0x17
    800033da:	fa250513          	addi	a0,a0,-94 # 8001a378 <ftable>
    800033de:	518020ef          	jal	800058f6 <release>
  return 0;
    800033e2:	4481                	li	s1,0
    800033e4:	a809                	j	800033f6 <filealloc+0x52>
      f->ref = 1;
    800033e6:	4785                	li	a5,1
    800033e8:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800033ea:	00017517          	auipc	a0,0x17
    800033ee:	f8e50513          	addi	a0,a0,-114 # 8001a378 <ftable>
    800033f2:	504020ef          	jal	800058f6 <release>
}
    800033f6:	8526                	mv	a0,s1
    800033f8:	60e2                	ld	ra,24(sp)
    800033fa:	6442                	ld	s0,16(sp)
    800033fc:	64a2                	ld	s1,8(sp)
    800033fe:	6105                	addi	sp,sp,32
    80003400:	8082                	ret

0000000080003402 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003402:	1101                	addi	sp,sp,-32
    80003404:	ec06                	sd	ra,24(sp)
    80003406:	e822                	sd	s0,16(sp)
    80003408:	e426                	sd	s1,8(sp)
    8000340a:	1000                	addi	s0,sp,32
    8000340c:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000340e:	00017517          	auipc	a0,0x17
    80003412:	f6a50513          	addi	a0,a0,-150 # 8001a378 <ftable>
    80003416:	44c020ef          	jal	80005862 <acquire>
  if(f->ref < 1)
    8000341a:	40dc                	lw	a5,4(s1)
    8000341c:	02f05063          	blez	a5,8000343c <filedup+0x3a>
    panic("filedup");
  f->ref++;
    80003420:	2785                	addiw	a5,a5,1
    80003422:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003424:	00017517          	auipc	a0,0x17
    80003428:	f5450513          	addi	a0,a0,-172 # 8001a378 <ftable>
    8000342c:	4ca020ef          	jal	800058f6 <release>
  return f;
}
    80003430:	8526                	mv	a0,s1
    80003432:	60e2                	ld	ra,24(sp)
    80003434:	6442                	ld	s0,16(sp)
    80003436:	64a2                	ld	s1,8(sp)
    80003438:	6105                	addi	sp,sp,32
    8000343a:	8082                	ret
    panic("filedup");
    8000343c:	00004517          	auipc	a0,0x4
    80003440:	0c450513          	addi	a0,a0,196 # 80007500 <etext+0x500>
    80003444:	162020ef          	jal	800055a6 <panic>

0000000080003448 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003448:	7139                	addi	sp,sp,-64
    8000344a:	fc06                	sd	ra,56(sp)
    8000344c:	f822                	sd	s0,48(sp)
    8000344e:	f426                	sd	s1,40(sp)
    80003450:	0080                	addi	s0,sp,64
    80003452:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003454:	00017517          	auipc	a0,0x17
    80003458:	f2450513          	addi	a0,a0,-220 # 8001a378 <ftable>
    8000345c:	406020ef          	jal	80005862 <acquire>
  if(f->ref < 1)
    80003460:	40dc                	lw	a5,4(s1)
    80003462:	04f05863          	blez	a5,800034b2 <fileclose+0x6a>
    panic("fileclose");
  if(--f->ref > 0){
    80003466:	37fd                	addiw	a5,a5,-1
    80003468:	c0dc                	sw	a5,4(s1)
    8000346a:	04f04e63          	bgtz	a5,800034c6 <fileclose+0x7e>
    8000346e:	f04a                	sd	s2,32(sp)
    80003470:	ec4e                	sd	s3,24(sp)
    80003472:	e852                	sd	s4,16(sp)
    80003474:	e456                	sd	s5,8(sp)
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003476:	0004a903          	lw	s2,0(s1)
    8000347a:	0094ca83          	lbu	s5,9(s1)
    8000347e:	0104ba03          	ld	s4,16(s1)
    80003482:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003486:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    8000348a:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000348e:	00017517          	auipc	a0,0x17
    80003492:	eea50513          	addi	a0,a0,-278 # 8001a378 <ftable>
    80003496:	460020ef          	jal	800058f6 <release>

  if(ff.type == FD_PIPE){
    8000349a:	4785                	li	a5,1
    8000349c:	04f90063          	beq	s2,a5,800034dc <fileclose+0x94>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800034a0:	3979                	addiw	s2,s2,-2
    800034a2:	4785                	li	a5,1
    800034a4:	0527f563          	bgeu	a5,s2,800034ee <fileclose+0xa6>
    800034a8:	7902                	ld	s2,32(sp)
    800034aa:	69e2                	ld	s3,24(sp)
    800034ac:	6a42                	ld	s4,16(sp)
    800034ae:	6aa2                	ld	s5,8(sp)
    800034b0:	a00d                	j	800034d2 <fileclose+0x8a>
    800034b2:	f04a                	sd	s2,32(sp)
    800034b4:	ec4e                	sd	s3,24(sp)
    800034b6:	e852                	sd	s4,16(sp)
    800034b8:	e456                	sd	s5,8(sp)
    panic("fileclose");
    800034ba:	00004517          	auipc	a0,0x4
    800034be:	04e50513          	addi	a0,a0,78 # 80007508 <etext+0x508>
    800034c2:	0e4020ef          	jal	800055a6 <panic>
    release(&ftable.lock);
    800034c6:	00017517          	auipc	a0,0x17
    800034ca:	eb250513          	addi	a0,a0,-334 # 8001a378 <ftable>
    800034ce:	428020ef          	jal	800058f6 <release>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
    800034d2:	70e2                	ld	ra,56(sp)
    800034d4:	7442                	ld	s0,48(sp)
    800034d6:	74a2                	ld	s1,40(sp)
    800034d8:	6121                	addi	sp,sp,64
    800034da:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800034dc:	85d6                	mv	a1,s5
    800034de:	8552                	mv	a0,s4
    800034e0:	340000ef          	jal	80003820 <pipeclose>
    800034e4:	7902                	ld	s2,32(sp)
    800034e6:	69e2                	ld	s3,24(sp)
    800034e8:	6a42                	ld	s4,16(sp)
    800034ea:	6aa2                	ld	s5,8(sp)
    800034ec:	b7dd                	j	800034d2 <fileclose+0x8a>
    begin_op();
    800034ee:	b49ff0ef          	jal	80003036 <begin_op>
    iput(ff.ip);
    800034f2:	854e                	mv	a0,s3
    800034f4:	ac0ff0ef          	jal	800027b4 <iput>
    end_op();
    800034f8:	ba9ff0ef          	jal	800030a0 <end_op>
    800034fc:	7902                	ld	s2,32(sp)
    800034fe:	69e2                	ld	s3,24(sp)
    80003500:	6a42                	ld	s4,16(sp)
    80003502:	6aa2                	ld	s5,8(sp)
    80003504:	b7f9                	j	800034d2 <fileclose+0x8a>

0000000080003506 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003506:	715d                	addi	sp,sp,-80
    80003508:	e486                	sd	ra,72(sp)
    8000350a:	e0a2                	sd	s0,64(sp)
    8000350c:	fc26                	sd	s1,56(sp)
    8000350e:	f44e                	sd	s3,40(sp)
    80003510:	0880                	addi	s0,sp,80
    80003512:	84aa                	mv	s1,a0
    80003514:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003516:	85bfd0ef          	jal	80000d70 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    8000351a:	409c                	lw	a5,0(s1)
    8000351c:	37f9                	addiw	a5,a5,-2
    8000351e:	4705                	li	a4,1
    80003520:	04f76263          	bltu	a4,a5,80003564 <filestat+0x5e>
    80003524:	f84a                	sd	s2,48(sp)
    80003526:	f052                	sd	s4,32(sp)
    80003528:	892a                	mv	s2,a0
    ilock(f->ip);
    8000352a:	6c88                	ld	a0,24(s1)
    8000352c:	906ff0ef          	jal	80002632 <ilock>
    stati(f->ip, &st);
    80003530:	fb840a13          	addi	s4,s0,-72
    80003534:	85d2                	mv	a1,s4
    80003536:	6c88                	ld	a0,24(s1)
    80003538:	c5eff0ef          	jal	80002996 <stati>
    iunlock(f->ip);
    8000353c:	6c88                	ld	a0,24(s1)
    8000353e:	9a2ff0ef          	jal	800026e0 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003542:	46e1                	li	a3,24
    80003544:	8652                	mv	a2,s4
    80003546:	85ce                	mv	a1,s3
    80003548:	05093503          	ld	a0,80(s2)
    8000354c:	d56fd0ef          	jal	80000aa2 <copyout>
    80003550:	41f5551b          	sraiw	a0,a0,0x1f
    80003554:	7942                	ld	s2,48(sp)
    80003556:	7a02                	ld	s4,32(sp)
      return -1;
    return 0;
  }
  return -1;
}
    80003558:	60a6                	ld	ra,72(sp)
    8000355a:	6406                	ld	s0,64(sp)
    8000355c:	74e2                	ld	s1,56(sp)
    8000355e:	79a2                	ld	s3,40(sp)
    80003560:	6161                	addi	sp,sp,80
    80003562:	8082                	ret
  return -1;
    80003564:	557d                	li	a0,-1
    80003566:	bfcd                	j	80003558 <filestat+0x52>

0000000080003568 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003568:	7179                	addi	sp,sp,-48
    8000356a:	f406                	sd	ra,40(sp)
    8000356c:	f022                	sd	s0,32(sp)
    8000356e:	e84a                	sd	s2,16(sp)
    80003570:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003572:	00854783          	lbu	a5,8(a0)
    80003576:	cfd1                	beqz	a5,80003612 <fileread+0xaa>
    80003578:	ec26                	sd	s1,24(sp)
    8000357a:	e44e                	sd	s3,8(sp)
    8000357c:	84aa                	mv	s1,a0
    8000357e:	89ae                	mv	s3,a1
    80003580:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003582:	411c                	lw	a5,0(a0)
    80003584:	4705                	li	a4,1
    80003586:	04e78363          	beq	a5,a4,800035cc <fileread+0x64>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000358a:	470d                	li	a4,3
    8000358c:	04e78763          	beq	a5,a4,800035da <fileread+0x72>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003590:	4709                	li	a4,2
    80003592:	06e79a63          	bne	a5,a4,80003606 <fileread+0x9e>
    ilock(f->ip);
    80003596:	6d08                	ld	a0,24(a0)
    80003598:	89aff0ef          	jal	80002632 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000359c:	874a                	mv	a4,s2
    8000359e:	5094                	lw	a3,32(s1)
    800035a0:	864e                	mv	a2,s3
    800035a2:	4585                	li	a1,1
    800035a4:	6c88                	ld	a0,24(s1)
    800035a6:	c1eff0ef          	jal	800029c4 <readi>
    800035aa:	892a                	mv	s2,a0
    800035ac:	00a05563          	blez	a0,800035b6 <fileread+0x4e>
      f->off += r;
    800035b0:	509c                	lw	a5,32(s1)
    800035b2:	9fa9                	addw	a5,a5,a0
    800035b4:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800035b6:	6c88                	ld	a0,24(s1)
    800035b8:	928ff0ef          	jal	800026e0 <iunlock>
    800035bc:	64e2                	ld	s1,24(sp)
    800035be:	69a2                	ld	s3,8(sp)
  } else {
    panic("fileread");
  }

  return r;
}
    800035c0:	854a                	mv	a0,s2
    800035c2:	70a2                	ld	ra,40(sp)
    800035c4:	7402                	ld	s0,32(sp)
    800035c6:	6942                	ld	s2,16(sp)
    800035c8:	6145                	addi	sp,sp,48
    800035ca:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800035cc:	6908                	ld	a0,16(a0)
    800035ce:	3a2000ef          	jal	80003970 <piperead>
    800035d2:	892a                	mv	s2,a0
    800035d4:	64e2                	ld	s1,24(sp)
    800035d6:	69a2                	ld	s3,8(sp)
    800035d8:	b7e5                	j	800035c0 <fileread+0x58>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800035da:	02451783          	lh	a5,36(a0)
    800035de:	03079693          	slli	a3,a5,0x30
    800035e2:	92c1                	srli	a3,a3,0x30
    800035e4:	4725                	li	a4,9
    800035e6:	02d76863          	bltu	a4,a3,80003616 <fileread+0xae>
    800035ea:	0792                	slli	a5,a5,0x4
    800035ec:	00017717          	auipc	a4,0x17
    800035f0:	cec70713          	addi	a4,a4,-788 # 8001a2d8 <devsw>
    800035f4:	97ba                	add	a5,a5,a4
    800035f6:	639c                	ld	a5,0(a5)
    800035f8:	c39d                	beqz	a5,8000361e <fileread+0xb6>
    r = devsw[f->major].read(1, addr, n);
    800035fa:	4505                	li	a0,1
    800035fc:	9782                	jalr	a5
    800035fe:	892a                	mv	s2,a0
    80003600:	64e2                	ld	s1,24(sp)
    80003602:	69a2                	ld	s3,8(sp)
    80003604:	bf75                	j	800035c0 <fileread+0x58>
    panic("fileread");
    80003606:	00004517          	auipc	a0,0x4
    8000360a:	f1250513          	addi	a0,a0,-238 # 80007518 <etext+0x518>
    8000360e:	799010ef          	jal	800055a6 <panic>
    return -1;
    80003612:	597d                	li	s2,-1
    80003614:	b775                	j	800035c0 <fileread+0x58>
      return -1;
    80003616:	597d                	li	s2,-1
    80003618:	64e2                	ld	s1,24(sp)
    8000361a:	69a2                	ld	s3,8(sp)
    8000361c:	b755                	j	800035c0 <fileread+0x58>
    8000361e:	597d                	li	s2,-1
    80003620:	64e2                	ld	s1,24(sp)
    80003622:	69a2                	ld	s3,8(sp)
    80003624:	bf71                	j	800035c0 <fileread+0x58>

0000000080003626 <filewrite>:
int
filewrite(struct file *f, uint64 addr, int n)
{
  int r, ret = 0;

  if(f->writable == 0)
    80003626:	00954783          	lbu	a5,9(a0)
    8000362a:	10078e63          	beqz	a5,80003746 <filewrite+0x120>
{
    8000362e:	711d                	addi	sp,sp,-96
    80003630:	ec86                	sd	ra,88(sp)
    80003632:	e8a2                	sd	s0,80(sp)
    80003634:	e0ca                	sd	s2,64(sp)
    80003636:	f456                	sd	s5,40(sp)
    80003638:	f05a                	sd	s6,32(sp)
    8000363a:	1080                	addi	s0,sp,96
    8000363c:	892a                	mv	s2,a0
    8000363e:	8b2e                	mv	s6,a1
    80003640:	8ab2                	mv	s5,a2
    return -1;

  if(f->type == FD_PIPE){
    80003642:	411c                	lw	a5,0(a0)
    80003644:	4705                	li	a4,1
    80003646:	02e78963          	beq	a5,a4,80003678 <filewrite+0x52>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    8000364a:	470d                	li	a4,3
    8000364c:	02e78a63          	beq	a5,a4,80003680 <filewrite+0x5a>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003650:	4709                	li	a4,2
    80003652:	0ce79e63          	bne	a5,a4,8000372e <filewrite+0x108>
    80003656:	f852                	sd	s4,48(sp)
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003658:	0ac05963          	blez	a2,8000370a <filewrite+0xe4>
    8000365c:	e4a6                	sd	s1,72(sp)
    8000365e:	fc4e                	sd	s3,56(sp)
    80003660:	ec5e                	sd	s7,24(sp)
    80003662:	e862                	sd	s8,16(sp)
    80003664:	e466                	sd	s9,8(sp)
    int i = 0;
    80003666:	4a01                	li	s4,0
      int n1 = n - i;
      if(n1 > max)
    80003668:	6b85                	lui	s7,0x1
    8000366a:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    8000366e:	6c85                	lui	s9,0x1
    80003670:	c00c8c9b          	addiw	s9,s9,-1024 # c00 <_entry-0x7ffff400>
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003674:	4c05                	li	s8,1
    80003676:	a8ad                	j	800036f0 <filewrite+0xca>
    ret = pipewrite(f->pipe, addr, n);
    80003678:	6908                	ld	a0,16(a0)
    8000367a:	1fe000ef          	jal	80003878 <pipewrite>
    8000367e:	a04d                	j	80003720 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003680:	02451783          	lh	a5,36(a0)
    80003684:	03079693          	slli	a3,a5,0x30
    80003688:	92c1                	srli	a3,a3,0x30
    8000368a:	4725                	li	a4,9
    8000368c:	0ad76f63          	bltu	a4,a3,8000374a <filewrite+0x124>
    80003690:	0792                	slli	a5,a5,0x4
    80003692:	00017717          	auipc	a4,0x17
    80003696:	c4670713          	addi	a4,a4,-954 # 8001a2d8 <devsw>
    8000369a:	97ba                	add	a5,a5,a4
    8000369c:	679c                	ld	a5,8(a5)
    8000369e:	cbc5                	beqz	a5,8000374e <filewrite+0x128>
    ret = devsw[f->major].write(1, addr, n);
    800036a0:	4505                	li	a0,1
    800036a2:	9782                	jalr	a5
    800036a4:	a8b5                	j	80003720 <filewrite+0xfa>
      if(n1 > max)
    800036a6:	2981                	sext.w	s3,s3
      begin_op();
    800036a8:	98fff0ef          	jal	80003036 <begin_op>
      ilock(f->ip);
    800036ac:	01893503          	ld	a0,24(s2)
    800036b0:	f83fe0ef          	jal	80002632 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800036b4:	874e                	mv	a4,s3
    800036b6:	02092683          	lw	a3,32(s2)
    800036ba:	016a0633          	add	a2,s4,s6
    800036be:	85e2                	mv	a1,s8
    800036c0:	01893503          	ld	a0,24(s2)
    800036c4:	bf2ff0ef          	jal	80002ab6 <writei>
    800036c8:	84aa                	mv	s1,a0
    800036ca:	00a05763          	blez	a0,800036d8 <filewrite+0xb2>
        f->off += r;
    800036ce:	02092783          	lw	a5,32(s2)
    800036d2:	9fa9                	addw	a5,a5,a0
    800036d4:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    800036d8:	01893503          	ld	a0,24(s2)
    800036dc:	804ff0ef          	jal	800026e0 <iunlock>
      end_op();
    800036e0:	9c1ff0ef          	jal	800030a0 <end_op>

      if(r != n1){
    800036e4:	02999563          	bne	s3,s1,8000370e <filewrite+0xe8>
        // error from writei
        break;
      }
      i += r;
    800036e8:	01448a3b          	addw	s4,s1,s4
    while(i < n){
    800036ec:	015a5963          	bge	s4,s5,800036fe <filewrite+0xd8>
      int n1 = n - i;
    800036f0:	414a87bb          	subw	a5,s5,s4
    800036f4:	89be                	mv	s3,a5
      if(n1 > max)
    800036f6:	fafbd8e3          	bge	s7,a5,800036a6 <filewrite+0x80>
    800036fa:	89e6                	mv	s3,s9
    800036fc:	b76d                	j	800036a6 <filewrite+0x80>
    800036fe:	64a6                	ld	s1,72(sp)
    80003700:	79e2                	ld	s3,56(sp)
    80003702:	6be2                	ld	s7,24(sp)
    80003704:	6c42                	ld	s8,16(sp)
    80003706:	6ca2                	ld	s9,8(sp)
    80003708:	a801                	j	80003718 <filewrite+0xf2>
    int i = 0;
    8000370a:	4a01                	li	s4,0
    8000370c:	a031                	j	80003718 <filewrite+0xf2>
    8000370e:	64a6                	ld	s1,72(sp)
    80003710:	79e2                	ld	s3,56(sp)
    80003712:	6be2                	ld	s7,24(sp)
    80003714:	6c42                	ld	s8,16(sp)
    80003716:	6ca2                	ld	s9,8(sp)
    }
    ret = (i == n ? n : -1);
    80003718:	034a9d63          	bne	s5,s4,80003752 <filewrite+0x12c>
    8000371c:	8556                	mv	a0,s5
    8000371e:	7a42                	ld	s4,48(sp)
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003720:	60e6                	ld	ra,88(sp)
    80003722:	6446                	ld	s0,80(sp)
    80003724:	6906                	ld	s2,64(sp)
    80003726:	7aa2                	ld	s5,40(sp)
    80003728:	7b02                	ld	s6,32(sp)
    8000372a:	6125                	addi	sp,sp,96
    8000372c:	8082                	ret
    8000372e:	e4a6                	sd	s1,72(sp)
    80003730:	fc4e                	sd	s3,56(sp)
    80003732:	f852                	sd	s4,48(sp)
    80003734:	ec5e                	sd	s7,24(sp)
    80003736:	e862                	sd	s8,16(sp)
    80003738:	e466                	sd	s9,8(sp)
    panic("filewrite");
    8000373a:	00004517          	auipc	a0,0x4
    8000373e:	dee50513          	addi	a0,a0,-530 # 80007528 <etext+0x528>
    80003742:	665010ef          	jal	800055a6 <panic>
    return -1;
    80003746:	557d                	li	a0,-1
}
    80003748:	8082                	ret
      return -1;
    8000374a:	557d                	li	a0,-1
    8000374c:	bfd1                	j	80003720 <filewrite+0xfa>
    8000374e:	557d                	li	a0,-1
    80003750:	bfc1                	j	80003720 <filewrite+0xfa>
    ret = (i == n ? n : -1);
    80003752:	557d                	li	a0,-1
    80003754:	7a42                	ld	s4,48(sp)
    80003756:	b7e9                	j	80003720 <filewrite+0xfa>

0000000080003758 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003758:	7179                	addi	sp,sp,-48
    8000375a:	f406                	sd	ra,40(sp)
    8000375c:	f022                	sd	s0,32(sp)
    8000375e:	ec26                	sd	s1,24(sp)
    80003760:	e052                	sd	s4,0(sp)
    80003762:	1800                	addi	s0,sp,48
    80003764:	84aa                	mv	s1,a0
    80003766:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003768:	0005b023          	sd	zero,0(a1)
    8000376c:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003770:	c35ff0ef          	jal	800033a4 <filealloc>
    80003774:	e088                	sd	a0,0(s1)
    80003776:	c549                	beqz	a0,80003800 <pipealloc+0xa8>
    80003778:	c2dff0ef          	jal	800033a4 <filealloc>
    8000377c:	00aa3023          	sd	a0,0(s4)
    80003780:	cd25                	beqz	a0,800037f8 <pipealloc+0xa0>
    80003782:	e84a                	sd	s2,16(sp)
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003784:	97bfc0ef          	jal	800000fe <kalloc>
    80003788:	892a                	mv	s2,a0
    8000378a:	c12d                	beqz	a0,800037ec <pipealloc+0x94>
    8000378c:	e44e                	sd	s3,8(sp)
    goto bad;
  pi->readopen = 1;
    8000378e:	4985                	li	s3,1
    80003790:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003794:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003798:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    8000379c:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    800037a0:	00004597          	auipc	a1,0x4
    800037a4:	d9858593          	addi	a1,a1,-616 # 80007538 <etext+0x538>
    800037a8:	036020ef          	jal	800057de <initlock>
  (*f0)->type = FD_PIPE;
    800037ac:	609c                	ld	a5,0(s1)
    800037ae:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800037b2:	609c                	ld	a5,0(s1)
    800037b4:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800037b8:	609c                	ld	a5,0(s1)
    800037ba:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800037be:	609c                	ld	a5,0(s1)
    800037c0:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800037c4:	000a3783          	ld	a5,0(s4)
    800037c8:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800037cc:	000a3783          	ld	a5,0(s4)
    800037d0:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800037d4:	000a3783          	ld	a5,0(s4)
    800037d8:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    800037dc:	000a3783          	ld	a5,0(s4)
    800037e0:	0127b823          	sd	s2,16(a5)
  return 0;
    800037e4:	4501                	li	a0,0
    800037e6:	6942                	ld	s2,16(sp)
    800037e8:	69a2                	ld	s3,8(sp)
    800037ea:	a01d                	j	80003810 <pipealloc+0xb8>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    800037ec:	6088                	ld	a0,0(s1)
    800037ee:	c119                	beqz	a0,800037f4 <pipealloc+0x9c>
    800037f0:	6942                	ld	s2,16(sp)
    800037f2:	a029                	j	800037fc <pipealloc+0xa4>
    800037f4:	6942                	ld	s2,16(sp)
    800037f6:	a029                	j	80003800 <pipealloc+0xa8>
    800037f8:	6088                	ld	a0,0(s1)
    800037fa:	c10d                	beqz	a0,8000381c <pipealloc+0xc4>
    fileclose(*f0);
    800037fc:	c4dff0ef          	jal	80003448 <fileclose>
  if(*f1)
    80003800:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003804:	557d                	li	a0,-1
  if(*f1)
    80003806:	c789                	beqz	a5,80003810 <pipealloc+0xb8>
    fileclose(*f1);
    80003808:	853e                	mv	a0,a5
    8000380a:	c3fff0ef          	jal	80003448 <fileclose>
  return -1;
    8000380e:	557d                	li	a0,-1
}
    80003810:	70a2                	ld	ra,40(sp)
    80003812:	7402                	ld	s0,32(sp)
    80003814:	64e2                	ld	s1,24(sp)
    80003816:	6a02                	ld	s4,0(sp)
    80003818:	6145                	addi	sp,sp,48
    8000381a:	8082                	ret
  return -1;
    8000381c:	557d                	li	a0,-1
    8000381e:	bfcd                	j	80003810 <pipealloc+0xb8>

0000000080003820 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003820:	1101                	addi	sp,sp,-32
    80003822:	ec06                	sd	ra,24(sp)
    80003824:	e822                	sd	s0,16(sp)
    80003826:	e426                	sd	s1,8(sp)
    80003828:	e04a                	sd	s2,0(sp)
    8000382a:	1000                	addi	s0,sp,32
    8000382c:	84aa                	mv	s1,a0
    8000382e:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003830:	032020ef          	jal	80005862 <acquire>
  if(writable){
    80003834:	02090763          	beqz	s2,80003862 <pipeclose+0x42>
    pi->writeopen = 0;
    80003838:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    8000383c:	21848513          	addi	a0,s1,536
    80003840:	b75fd0ef          	jal	800013b4 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003844:	2204b783          	ld	a5,544(s1)
    80003848:	e785                	bnez	a5,80003870 <pipeclose+0x50>
    release(&pi->lock);
    8000384a:	8526                	mv	a0,s1
    8000384c:	0aa020ef          	jal	800058f6 <release>
    kfree((char*)pi);
    80003850:	8526                	mv	a0,s1
    80003852:	fcafc0ef          	jal	8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003856:	60e2                	ld	ra,24(sp)
    80003858:	6442                	ld	s0,16(sp)
    8000385a:	64a2                	ld	s1,8(sp)
    8000385c:	6902                	ld	s2,0(sp)
    8000385e:	6105                	addi	sp,sp,32
    80003860:	8082                	ret
    pi->readopen = 0;
    80003862:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003866:	21c48513          	addi	a0,s1,540
    8000386a:	b4bfd0ef          	jal	800013b4 <wakeup>
    8000386e:	bfd9                	j	80003844 <pipeclose+0x24>
    release(&pi->lock);
    80003870:	8526                	mv	a0,s1
    80003872:	084020ef          	jal	800058f6 <release>
}
    80003876:	b7c5                	j	80003856 <pipeclose+0x36>

0000000080003878 <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003878:	7159                	addi	sp,sp,-112
    8000387a:	f486                	sd	ra,104(sp)
    8000387c:	f0a2                	sd	s0,96(sp)
    8000387e:	eca6                	sd	s1,88(sp)
    80003880:	e8ca                	sd	s2,80(sp)
    80003882:	e4ce                	sd	s3,72(sp)
    80003884:	e0d2                	sd	s4,64(sp)
    80003886:	fc56                	sd	s5,56(sp)
    80003888:	1880                	addi	s0,sp,112
    8000388a:	84aa                	mv	s1,a0
    8000388c:	8aae                	mv	s5,a1
    8000388e:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003890:	ce0fd0ef          	jal	80000d70 <myproc>
    80003894:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003896:	8526                	mv	a0,s1
    80003898:	7cb010ef          	jal	80005862 <acquire>
  while(i < n){
    8000389c:	0d405263          	blez	s4,80003960 <pipewrite+0xe8>
    800038a0:	f85a                	sd	s6,48(sp)
    800038a2:	f45e                	sd	s7,40(sp)
    800038a4:	f062                	sd	s8,32(sp)
    800038a6:	ec66                	sd	s9,24(sp)
    800038a8:	e86a                	sd	s10,16(sp)
  int i = 0;
    800038aa:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800038ac:	f9f40c13          	addi	s8,s0,-97
    800038b0:	4b85                	li	s7,1
    800038b2:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800038b4:	21848d13          	addi	s10,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800038b8:	21c48c93          	addi	s9,s1,540
    800038bc:	a82d                	j	800038f6 <pipewrite+0x7e>
      release(&pi->lock);
    800038be:	8526                	mv	a0,s1
    800038c0:	036020ef          	jal	800058f6 <release>
      return -1;
    800038c4:	597d                	li	s2,-1
    800038c6:	7b42                	ld	s6,48(sp)
    800038c8:	7ba2                	ld	s7,40(sp)
    800038ca:	7c02                	ld	s8,32(sp)
    800038cc:	6ce2                	ld	s9,24(sp)
    800038ce:	6d42                	ld	s10,16(sp)
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    800038d0:	854a                	mv	a0,s2
    800038d2:	70a6                	ld	ra,104(sp)
    800038d4:	7406                	ld	s0,96(sp)
    800038d6:	64e6                	ld	s1,88(sp)
    800038d8:	6946                	ld	s2,80(sp)
    800038da:	69a6                	ld	s3,72(sp)
    800038dc:	6a06                	ld	s4,64(sp)
    800038de:	7ae2                	ld	s5,56(sp)
    800038e0:	6165                	addi	sp,sp,112
    800038e2:	8082                	ret
      wakeup(&pi->nread);
    800038e4:	856a                	mv	a0,s10
    800038e6:	acffd0ef          	jal	800013b4 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    800038ea:	85a6                	mv	a1,s1
    800038ec:	8566                	mv	a0,s9
    800038ee:	a7bfd0ef          	jal	80001368 <sleep>
  while(i < n){
    800038f2:	05495a63          	bge	s2,s4,80003946 <pipewrite+0xce>
    if(pi->readopen == 0 || killed(pr)){
    800038f6:	2204a783          	lw	a5,544(s1)
    800038fa:	d3f1                	beqz	a5,800038be <pipewrite+0x46>
    800038fc:	854e                	mv	a0,s3
    800038fe:	ca3fd0ef          	jal	800015a0 <killed>
    80003902:	fd55                	bnez	a0,800038be <pipewrite+0x46>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003904:	2184a783          	lw	a5,536(s1)
    80003908:	21c4a703          	lw	a4,540(s1)
    8000390c:	2007879b          	addiw	a5,a5,512
    80003910:	fcf70ae3          	beq	a4,a5,800038e4 <pipewrite+0x6c>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003914:	86de                	mv	a3,s7
    80003916:	01590633          	add	a2,s2,s5
    8000391a:	85e2                	mv	a1,s8
    8000391c:	0509b503          	ld	a0,80(s3)
    80003920:	a40fd0ef          	jal	80000b60 <copyin>
    80003924:	05650063          	beq	a0,s6,80003964 <pipewrite+0xec>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003928:	21c4a783          	lw	a5,540(s1)
    8000392c:	0017871b          	addiw	a4,a5,1
    80003930:	20e4ae23          	sw	a4,540(s1)
    80003934:	1ff7f793          	andi	a5,a5,511
    80003938:	97a6                	add	a5,a5,s1
    8000393a:	f9f44703          	lbu	a4,-97(s0)
    8000393e:	00e78c23          	sb	a4,24(a5)
      i++;
    80003942:	2905                	addiw	s2,s2,1
    80003944:	b77d                	j	800038f2 <pipewrite+0x7a>
    80003946:	7b42                	ld	s6,48(sp)
    80003948:	7ba2                	ld	s7,40(sp)
    8000394a:	7c02                	ld	s8,32(sp)
    8000394c:	6ce2                	ld	s9,24(sp)
    8000394e:	6d42                	ld	s10,16(sp)
  wakeup(&pi->nread);
    80003950:	21848513          	addi	a0,s1,536
    80003954:	a61fd0ef          	jal	800013b4 <wakeup>
  release(&pi->lock);
    80003958:	8526                	mv	a0,s1
    8000395a:	79d010ef          	jal	800058f6 <release>
  return i;
    8000395e:	bf8d                	j	800038d0 <pipewrite+0x58>
  int i = 0;
    80003960:	4901                	li	s2,0
    80003962:	b7fd                	j	80003950 <pipewrite+0xd8>
    80003964:	7b42                	ld	s6,48(sp)
    80003966:	7ba2                	ld	s7,40(sp)
    80003968:	7c02                	ld	s8,32(sp)
    8000396a:	6ce2                	ld	s9,24(sp)
    8000396c:	6d42                	ld	s10,16(sp)
    8000396e:	b7cd                	j	80003950 <pipewrite+0xd8>

0000000080003970 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003970:	711d                	addi	sp,sp,-96
    80003972:	ec86                	sd	ra,88(sp)
    80003974:	e8a2                	sd	s0,80(sp)
    80003976:	e4a6                	sd	s1,72(sp)
    80003978:	e0ca                	sd	s2,64(sp)
    8000397a:	fc4e                	sd	s3,56(sp)
    8000397c:	f852                	sd	s4,48(sp)
    8000397e:	f456                	sd	s5,40(sp)
    80003980:	1080                	addi	s0,sp,96
    80003982:	84aa                	mv	s1,a0
    80003984:	892e                	mv	s2,a1
    80003986:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003988:	be8fd0ef          	jal	80000d70 <myproc>
    8000398c:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    8000398e:	8526                	mv	a0,s1
    80003990:	6d3010ef          	jal	80005862 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003994:	2184a703          	lw	a4,536(s1)
    80003998:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    8000399c:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800039a0:	02f71763          	bne	a4,a5,800039ce <piperead+0x5e>
    800039a4:	2244a783          	lw	a5,548(s1)
    800039a8:	cf85                	beqz	a5,800039e0 <piperead+0x70>
    if(killed(pr)){
    800039aa:	8552                	mv	a0,s4
    800039ac:	bf5fd0ef          	jal	800015a0 <killed>
    800039b0:	e11d                	bnez	a0,800039d6 <piperead+0x66>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800039b2:	85a6                	mv	a1,s1
    800039b4:	854e                	mv	a0,s3
    800039b6:	9b3fd0ef          	jal	80001368 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800039ba:	2184a703          	lw	a4,536(s1)
    800039be:	21c4a783          	lw	a5,540(s1)
    800039c2:	fef701e3          	beq	a4,a5,800039a4 <piperead+0x34>
    800039c6:	f05a                	sd	s6,32(sp)
    800039c8:	ec5e                	sd	s7,24(sp)
    800039ca:	e862                	sd	s8,16(sp)
    800039cc:	a829                	j	800039e6 <piperead+0x76>
    800039ce:	f05a                	sd	s6,32(sp)
    800039d0:	ec5e                	sd	s7,24(sp)
    800039d2:	e862                	sd	s8,16(sp)
    800039d4:	a809                	j	800039e6 <piperead+0x76>
      release(&pi->lock);
    800039d6:	8526                	mv	a0,s1
    800039d8:	71f010ef          	jal	800058f6 <release>
      return -1;
    800039dc:	59fd                	li	s3,-1
    800039de:	a0a5                	j	80003a46 <piperead+0xd6>
    800039e0:	f05a                	sd	s6,32(sp)
    800039e2:	ec5e                	sd	s7,24(sp)
    800039e4:	e862                	sd	s8,16(sp)
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800039e6:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    800039e8:	faf40c13          	addi	s8,s0,-81
    800039ec:	4b85                	li	s7,1
    800039ee:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800039f0:	05505163          	blez	s5,80003a32 <piperead+0xc2>
    if(pi->nread == pi->nwrite)
    800039f4:	2184a783          	lw	a5,536(s1)
    800039f8:	21c4a703          	lw	a4,540(s1)
    800039fc:	02f70b63          	beq	a4,a5,80003a32 <piperead+0xc2>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003a00:	0017871b          	addiw	a4,a5,1
    80003a04:	20e4ac23          	sw	a4,536(s1)
    80003a08:	1ff7f793          	andi	a5,a5,511
    80003a0c:	97a6                	add	a5,a5,s1
    80003a0e:	0187c783          	lbu	a5,24(a5)
    80003a12:	faf407a3          	sb	a5,-81(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003a16:	86de                	mv	a3,s7
    80003a18:	8662                	mv	a2,s8
    80003a1a:	85ca                	mv	a1,s2
    80003a1c:	050a3503          	ld	a0,80(s4)
    80003a20:	882fd0ef          	jal	80000aa2 <copyout>
    80003a24:	01650763          	beq	a0,s6,80003a32 <piperead+0xc2>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003a28:	2985                	addiw	s3,s3,1
    80003a2a:	0905                	addi	s2,s2,1
    80003a2c:	fd3a94e3          	bne	s5,s3,800039f4 <piperead+0x84>
    80003a30:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003a32:	21c48513          	addi	a0,s1,540
    80003a36:	97ffd0ef          	jal	800013b4 <wakeup>
  release(&pi->lock);
    80003a3a:	8526                	mv	a0,s1
    80003a3c:	6bb010ef          	jal	800058f6 <release>
    80003a40:	7b02                	ld	s6,32(sp)
    80003a42:	6be2                	ld	s7,24(sp)
    80003a44:	6c42                	ld	s8,16(sp)
  return i;
}
    80003a46:	854e                	mv	a0,s3
    80003a48:	60e6                	ld	ra,88(sp)
    80003a4a:	6446                	ld	s0,80(sp)
    80003a4c:	64a6                	ld	s1,72(sp)
    80003a4e:	6906                	ld	s2,64(sp)
    80003a50:	79e2                	ld	s3,56(sp)
    80003a52:	7a42                	ld	s4,48(sp)
    80003a54:	7aa2                	ld	s5,40(sp)
    80003a56:	6125                	addi	sp,sp,96
    80003a58:	8082                	ret

0000000080003a5a <flags2perm>:

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

// map ELF permissions to PTE permission bits.
int flags2perm(int flags)
{
    80003a5a:	1141                	addi	sp,sp,-16
    80003a5c:	e406                	sd	ra,8(sp)
    80003a5e:	e022                	sd	s0,0(sp)
    80003a60:	0800                	addi	s0,sp,16
    80003a62:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003a64:	0035151b          	slliw	a0,a0,0x3
    80003a68:	8921                	andi	a0,a0,8
      perm = PTE_X;
    if(flags & 0x2)
    80003a6a:	8b89                	andi	a5,a5,2
    80003a6c:	c399                	beqz	a5,80003a72 <flags2perm+0x18>
      perm |= PTE_W;
    80003a6e:	00456513          	ori	a0,a0,4
    return perm;
}
    80003a72:	60a2                	ld	ra,8(sp)
    80003a74:	6402                	ld	s0,0(sp)
    80003a76:	0141                	addi	sp,sp,16
    80003a78:	8082                	ret

0000000080003a7a <kexec>:
//
// the implementation of the exec() system call
//
int
kexec(char *path, char **argv)
{
    80003a7a:	de010113          	addi	sp,sp,-544
    80003a7e:	20113c23          	sd	ra,536(sp)
    80003a82:	20813823          	sd	s0,528(sp)
    80003a86:	20913423          	sd	s1,520(sp)
    80003a8a:	21213023          	sd	s2,512(sp)
    80003a8e:	1400                	addi	s0,sp,544
    80003a90:	892a                	mv	s2,a0
    80003a92:	dea43823          	sd	a0,-528(s0)
    80003a96:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80003a9a:	ad6fd0ef          	jal	80000d70 <myproc>
    80003a9e:	84aa                	mv	s1,a0

  begin_op();
    80003aa0:	d96ff0ef          	jal	80003036 <begin_op>

  // Open the executable file.
  if((ip = namei(path)) == 0){
    80003aa4:	854a                	mv	a0,s2
    80003aa6:	bb6ff0ef          	jal	80002e5c <namei>
    80003aaa:	cd21                	beqz	a0,80003b02 <kexec+0x88>
    80003aac:	fbd2                	sd	s4,496(sp)
    80003aae:	8a2a                	mv	s4,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80003ab0:	b83fe0ef          	jal	80002632 <ilock>

  // Read the ELF header.
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80003ab4:	04000713          	li	a4,64
    80003ab8:	4681                	li	a3,0
    80003aba:	e5040613          	addi	a2,s0,-432
    80003abe:	4581                	li	a1,0
    80003ac0:	8552                	mv	a0,s4
    80003ac2:	f03fe0ef          	jal	800029c4 <readi>
    80003ac6:	04000793          	li	a5,64
    80003aca:	00f51a63          	bne	a0,a5,80003ade <kexec+0x64>
    goto bad;

  // Is this really an ELF file?
  if(elf.magic != ELF_MAGIC)
    80003ace:	e5042703          	lw	a4,-432(s0)
    80003ad2:	464c47b7          	lui	a5,0x464c4
    80003ad6:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80003ada:	02f70863          	beq	a4,a5,80003b0a <kexec+0x90>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80003ade:	8552                	mv	a0,s4
    80003ae0:	d5dfe0ef          	jal	8000283c <iunlockput>
    end_op();
    80003ae4:	dbcff0ef          	jal	800030a0 <end_op>
  }
  return -1;
    80003ae8:	557d                	li	a0,-1
    80003aea:	7a5e                	ld	s4,496(sp)
}
    80003aec:	21813083          	ld	ra,536(sp)
    80003af0:	21013403          	ld	s0,528(sp)
    80003af4:	20813483          	ld	s1,520(sp)
    80003af8:	20013903          	ld	s2,512(sp)
    80003afc:	22010113          	addi	sp,sp,544
    80003b00:	8082                	ret
    end_op();
    80003b02:	d9eff0ef          	jal	800030a0 <end_op>
    return -1;
    80003b06:	557d                	li	a0,-1
    80003b08:	b7d5                	j	80003aec <kexec+0x72>
    80003b0a:	f3da                	sd	s6,480(sp)
  if((pagetable = proc_pagetable(p)) == 0)
    80003b0c:	8526                	mv	a0,s1
    80003b0e:	b68fd0ef          	jal	80000e76 <proc_pagetable>
    80003b12:	8b2a                	mv	s6,a0
    80003b14:	26050d63          	beqz	a0,80003d8e <kexec+0x314>
    80003b18:	ffce                	sd	s3,504(sp)
    80003b1a:	f7d6                	sd	s5,488(sp)
    80003b1c:	efde                	sd	s7,472(sp)
    80003b1e:	ebe2                	sd	s8,464(sp)
    80003b20:	e7e6                	sd	s9,456(sp)
    80003b22:	e3ea                	sd	s10,448(sp)
    80003b24:	ff6e                	sd	s11,440(sp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b26:	e7042683          	lw	a3,-400(s0)
    80003b2a:	e8845783          	lhu	a5,-376(s0)
    80003b2e:	0e078763          	beqz	a5,80003c1c <kexec+0x1a2>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003b32:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b34:	4d01                	li	s10,0
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003b36:	03800d93          	li	s11,56
    if(ph.vaddr % PGSIZE != 0)
    80003b3a:	6c85                	lui	s9,0x1
    80003b3c:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    80003b40:	def43423          	sd	a5,-536(s0)

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    if(sz - i < PGSIZE)
    80003b44:	6a85                	lui	s5,0x1
    80003b46:	a085                	j	80003ba6 <kexec+0x12c>
      panic("loadseg: address should exist");
    80003b48:	00004517          	auipc	a0,0x4
    80003b4c:	9f850513          	addi	a0,a0,-1544 # 80007540 <etext+0x540>
    80003b50:	257010ef          	jal	800055a6 <panic>
    if(sz - i < PGSIZE)
    80003b54:	2901                	sext.w	s2,s2
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80003b56:	874a                	mv	a4,s2
    80003b58:	009c06bb          	addw	a3,s8,s1
    80003b5c:	4581                	li	a1,0
    80003b5e:	8552                	mv	a0,s4
    80003b60:	e65fe0ef          	jal	800029c4 <readi>
    80003b64:	22a91963          	bne	s2,a0,80003d96 <kexec+0x31c>
  for(i = 0; i < sz; i += PGSIZE){
    80003b68:	009a84bb          	addw	s1,s5,s1
    80003b6c:	0334f263          	bgeu	s1,s3,80003b90 <kexec+0x116>
    pa = walkaddr(pagetable, va + i);
    80003b70:	02049593          	slli	a1,s1,0x20
    80003b74:	9181                	srli	a1,a1,0x20
    80003b76:	95de                	add	a1,a1,s7
    80003b78:	855a                	mv	a0,s6
    80003b7a:	903fc0ef          	jal	8000047c <walkaddr>
    80003b7e:	862a                	mv	a2,a0
    if(pa == 0)
    80003b80:	d561                	beqz	a0,80003b48 <kexec+0xce>
    if(sz - i < PGSIZE)
    80003b82:	409987bb          	subw	a5,s3,s1
    80003b86:	893e                	mv	s2,a5
    80003b88:	fcfcf6e3          	bgeu	s9,a5,80003b54 <kexec+0xda>
    80003b8c:	8956                	mv	s2,s5
    80003b8e:	b7d9                	j	80003b54 <kexec+0xda>
    sz = sz1;
    80003b90:	df843903          	ld	s2,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80003b94:	2d05                	addiw	s10,s10,1
    80003b96:	e0843783          	ld	a5,-504(s0)
    80003b9a:	0387869b          	addiw	a3,a5,56
    80003b9e:	e8845783          	lhu	a5,-376(s0)
    80003ba2:	06fd5e63          	bge	s10,a5,80003c1e <kexec+0x1a4>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80003ba6:	e0d43423          	sd	a3,-504(s0)
    80003baa:	876e                	mv	a4,s11
    80003bac:	e1840613          	addi	a2,s0,-488
    80003bb0:	4581                	li	a1,0
    80003bb2:	8552                	mv	a0,s4
    80003bb4:	e11fe0ef          	jal	800029c4 <readi>
    80003bb8:	1db51d63          	bne	a0,s11,80003d92 <kexec+0x318>
    if(ph.type != ELF_PROG_LOAD)
    80003bbc:	e1842783          	lw	a5,-488(s0)
    80003bc0:	4705                	li	a4,1
    80003bc2:	fce799e3          	bne	a5,a4,80003b94 <kexec+0x11a>
    if(ph.memsz < ph.filesz)
    80003bc6:	e4043483          	ld	s1,-448(s0)
    80003bca:	e3843783          	ld	a5,-456(s0)
    80003bce:	1ef4e263          	bltu	s1,a5,80003db2 <kexec+0x338>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80003bd2:	e2843783          	ld	a5,-472(s0)
    80003bd6:	94be                	add	s1,s1,a5
    80003bd8:	1ef4e063          	bltu	s1,a5,80003db8 <kexec+0x33e>
    if(ph.vaddr % PGSIZE != 0)
    80003bdc:	de843703          	ld	a4,-536(s0)
    80003be0:	8ff9                	and	a5,a5,a4
    80003be2:	1c079e63          	bnez	a5,80003dbe <kexec+0x344>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80003be6:	e1c42503          	lw	a0,-484(s0)
    80003bea:	e71ff0ef          	jal	80003a5a <flags2perm>
    80003bee:	86aa                	mv	a3,a0
    80003bf0:	8626                	mv	a2,s1
    80003bf2:	85ca                	mv	a1,s2
    80003bf4:	855a                	mv	a0,s6
    80003bf6:	b5ffc0ef          	jal	80000754 <uvmalloc>
    80003bfa:	dea43c23          	sd	a0,-520(s0)
    80003bfe:	1c050363          	beqz	a0,80003dc4 <kexec+0x34a>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80003c02:	e2843b83          	ld	s7,-472(s0)
    80003c06:	e2042c03          	lw	s8,-480(s0)
    80003c0a:	e3842983          	lw	s3,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80003c0e:	00098463          	beqz	s3,80003c16 <kexec+0x19c>
    80003c12:	4481                	li	s1,0
    80003c14:	bfb1                	j	80003b70 <kexec+0xf6>
    sz = sz1;
    80003c16:	df843903          	ld	s2,-520(s0)
    80003c1a:	bfad                	j	80003b94 <kexec+0x11a>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80003c1c:	4901                	li	s2,0
  iunlockput(ip);
    80003c1e:	8552                	mv	a0,s4
    80003c20:	c1dfe0ef          	jal	8000283c <iunlockput>
  end_op();
    80003c24:	c7cff0ef          	jal	800030a0 <end_op>
  p = myproc();
    80003c28:	948fd0ef          	jal	80000d70 <myproc>
    80003c2c:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80003c2e:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80003c32:	6985                	lui	s3,0x1
    80003c34:	19fd                	addi	s3,s3,-1 # fff <_entry-0x7ffff001>
    80003c36:	99ca                	add	s3,s3,s2
    80003c38:	77fd                	lui	a5,0xfffff
    80003c3a:	00f9f9b3          	and	s3,s3,a5
  if((sz1 = uvmalloc(pagetable, sz, sz + (USERSTACK+1)*PGSIZE, PTE_W)) == 0)
    80003c3e:	4691                	li	a3,4
    80003c40:	660d                	lui	a2,0x3
    80003c42:	964e                	add	a2,a2,s3
    80003c44:	85ce                	mv	a1,s3
    80003c46:	855a                	mv	a0,s6
    80003c48:	b0dfc0ef          	jal	80000754 <uvmalloc>
    80003c4c:	8a2a                	mv	s4,a0
    80003c4e:	e105                	bnez	a0,80003c6e <kexec+0x1f4>
    proc_freepagetable(pagetable, sz);
    80003c50:	85ce                	mv	a1,s3
    80003c52:	855a                	mv	a0,s6
    80003c54:	aa6fd0ef          	jal	80000efa <proc_freepagetable>
  return -1;
    80003c58:	557d                	li	a0,-1
    80003c5a:	79fe                	ld	s3,504(sp)
    80003c5c:	7a5e                	ld	s4,496(sp)
    80003c5e:	7abe                	ld	s5,488(sp)
    80003c60:	7b1e                	ld	s6,480(sp)
    80003c62:	6bfe                	ld	s7,472(sp)
    80003c64:	6c5e                	ld	s8,464(sp)
    80003c66:	6cbe                	ld	s9,456(sp)
    80003c68:	6d1e                	ld	s10,448(sp)
    80003c6a:	7dfa                	ld	s11,440(sp)
    80003c6c:	b541                	j	80003aec <kexec+0x72>
  uvmclear(pagetable, sz-(USERSTACK+1)*PGSIZE);
    80003c6e:	75f5                	lui	a1,0xffffd
    80003c70:	95aa                	add	a1,a1,a0
    80003c72:	855a                	mv	a0,s6
    80003c74:	cc3fc0ef          	jal	80000936 <uvmclear>
  stackbase = sp - USERSTACK*PGSIZE;
    80003c78:	7bf9                	lui	s7,0xffffe
    80003c7a:	9bd2                	add	s7,s7,s4
  for(argc = 0; argv[argc]; argc++) {
    80003c7c:	e0043783          	ld	a5,-512(s0)
    80003c80:	6388                	ld	a0,0(a5)
  sp = sz;
    80003c82:	8952                	mv	s2,s4
  for(argc = 0; argv[argc]; argc++) {
    80003c84:	4481                	li	s1,0
    ustack[argc] = sp;
    80003c86:	e9040c93          	addi	s9,s0,-368
    if(argc >= MAXARG)
    80003c8a:	02000c13          	li	s8,32
  for(argc = 0; argv[argc]; argc++) {
    80003c8e:	cd21                	beqz	a0,80003ce6 <kexec+0x26c>
    sp -= strlen(argv[argc]) + 1;
    80003c90:	e46fc0ef          	jal	800002d6 <strlen>
    80003c94:	0015079b          	addiw	a5,a0,1
    80003c98:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80003c9c:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    80003ca0:	13796563          	bltu	s2,s7,80003dca <kexec+0x350>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80003ca4:	e0043d83          	ld	s11,-512(s0)
    80003ca8:	000db983          	ld	s3,0(s11)
    80003cac:	854e                	mv	a0,s3
    80003cae:	e28fc0ef          	jal	800002d6 <strlen>
    80003cb2:	0015069b          	addiw	a3,a0,1
    80003cb6:	864e                	mv	a2,s3
    80003cb8:	85ca                	mv	a1,s2
    80003cba:	855a                	mv	a0,s6
    80003cbc:	de7fc0ef          	jal	80000aa2 <copyout>
    80003cc0:	10054763          	bltz	a0,80003dce <kexec+0x354>
    ustack[argc] = sp;
    80003cc4:	00349793          	slli	a5,s1,0x3
    80003cc8:	97e6                	add	a5,a5,s9
    80003cca:	0127b023          	sd	s2,0(a5) # fffffffffffff000 <end+0xffffffff7ffdbab8>
  for(argc = 0; argv[argc]; argc++) {
    80003cce:	0485                	addi	s1,s1,1
    80003cd0:	008d8793          	addi	a5,s11,8
    80003cd4:	e0f43023          	sd	a5,-512(s0)
    80003cd8:	008db503          	ld	a0,8(s11)
    80003cdc:	c509                	beqz	a0,80003ce6 <kexec+0x26c>
    if(argc >= MAXARG)
    80003cde:	fb8499e3          	bne	s1,s8,80003c90 <kexec+0x216>
  sz = sz1;
    80003ce2:	89d2                	mv	s3,s4
    80003ce4:	b7b5                	j	80003c50 <kexec+0x1d6>
  ustack[argc] = 0;
    80003ce6:	00349793          	slli	a5,s1,0x3
    80003cea:	f9078793          	addi	a5,a5,-112
    80003cee:	97a2                	add	a5,a5,s0
    80003cf0:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80003cf4:	00148693          	addi	a3,s1,1
    80003cf8:	068e                	slli	a3,a3,0x3
    80003cfa:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80003cfe:	ff097913          	andi	s2,s2,-16
  sz = sz1;
    80003d02:	89d2                	mv	s3,s4
  if(sp < stackbase)
    80003d04:	f57966e3          	bltu	s2,s7,80003c50 <kexec+0x1d6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80003d08:	e9040613          	addi	a2,s0,-368
    80003d0c:	85ca                	mv	a1,s2
    80003d0e:	855a                	mv	a0,s6
    80003d10:	d93fc0ef          	jal	80000aa2 <copyout>
    80003d14:	f2054ee3          	bltz	a0,80003c50 <kexec+0x1d6>
  p->trapframe->a1 = sp;
    80003d18:	058ab783          	ld	a5,88(s5) # 1058 <_entry-0x7fffefa8>
    80003d1c:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80003d20:	df043783          	ld	a5,-528(s0)
    80003d24:	0007c703          	lbu	a4,0(a5)
    80003d28:	cf11                	beqz	a4,80003d44 <kexec+0x2ca>
    80003d2a:	0785                	addi	a5,a5,1
    if(*s == '/')
    80003d2c:	02f00693          	li	a3,47
    80003d30:	a029                	j	80003d3a <kexec+0x2c0>
  for(last=s=path; *s; s++)
    80003d32:	0785                	addi	a5,a5,1
    80003d34:	fff7c703          	lbu	a4,-1(a5)
    80003d38:	c711                	beqz	a4,80003d44 <kexec+0x2ca>
    if(*s == '/')
    80003d3a:	fed71ce3          	bne	a4,a3,80003d32 <kexec+0x2b8>
      last = s+1;
    80003d3e:	def43823          	sd	a5,-528(s0)
    80003d42:	bfc5                	j	80003d32 <kexec+0x2b8>
  safestrcpy(p->name, last, sizeof(p->name));
    80003d44:	4641                	li	a2,16
    80003d46:	df043583          	ld	a1,-528(s0)
    80003d4a:	158a8513          	addi	a0,s5,344
    80003d4e:	d52fc0ef          	jal	800002a0 <safestrcpy>
  oldpagetable = p->pagetable;
    80003d52:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80003d56:	056ab823          	sd	s6,80(s5)
  p->sz = sz;
    80003d5a:	054ab423          	sd	s4,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80003d5e:	058ab783          	ld	a5,88(s5)
    80003d62:	e6843703          	ld	a4,-408(s0)
    80003d66:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80003d68:	058ab783          	ld	a5,88(s5)
    80003d6c:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80003d70:	85ea                	mv	a1,s10
    80003d72:	988fd0ef          	jal	80000efa <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80003d76:	0004851b          	sext.w	a0,s1
    80003d7a:	79fe                	ld	s3,504(sp)
    80003d7c:	7a5e                	ld	s4,496(sp)
    80003d7e:	7abe                	ld	s5,488(sp)
    80003d80:	7b1e                	ld	s6,480(sp)
    80003d82:	6bfe                	ld	s7,472(sp)
    80003d84:	6c5e                	ld	s8,464(sp)
    80003d86:	6cbe                	ld	s9,456(sp)
    80003d88:	6d1e                	ld	s10,448(sp)
    80003d8a:	7dfa                	ld	s11,440(sp)
    80003d8c:	b385                	j	80003aec <kexec+0x72>
    80003d8e:	7b1e                	ld	s6,480(sp)
    80003d90:	b3b9                	j	80003ade <kexec+0x64>
    80003d92:	df243c23          	sd	s2,-520(s0)
    proc_freepagetable(pagetable, sz);
    80003d96:	df843583          	ld	a1,-520(s0)
    80003d9a:	855a                	mv	a0,s6
    80003d9c:	95efd0ef          	jal	80000efa <proc_freepagetable>
  if(ip){
    80003da0:	79fe                	ld	s3,504(sp)
    80003da2:	7abe                	ld	s5,488(sp)
    80003da4:	7b1e                	ld	s6,480(sp)
    80003da6:	6bfe                	ld	s7,472(sp)
    80003da8:	6c5e                	ld	s8,464(sp)
    80003daa:	6cbe                	ld	s9,456(sp)
    80003dac:	6d1e                	ld	s10,448(sp)
    80003dae:	7dfa                	ld	s11,440(sp)
    80003db0:	b33d                	j	80003ade <kexec+0x64>
    80003db2:	df243c23          	sd	s2,-520(s0)
    80003db6:	b7c5                	j	80003d96 <kexec+0x31c>
    80003db8:	df243c23          	sd	s2,-520(s0)
    80003dbc:	bfe9                	j	80003d96 <kexec+0x31c>
    80003dbe:	df243c23          	sd	s2,-520(s0)
    80003dc2:	bfd1                	j	80003d96 <kexec+0x31c>
    80003dc4:	df243c23          	sd	s2,-520(s0)
    80003dc8:	b7f9                	j	80003d96 <kexec+0x31c>
  sz = sz1;
    80003dca:	89d2                	mv	s3,s4
    80003dcc:	b551                	j	80003c50 <kexec+0x1d6>
    80003dce:	89d2                	mv	s3,s4
    80003dd0:	b541                	j	80003c50 <kexec+0x1d6>

0000000080003dd2 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80003dd2:	7179                	addi	sp,sp,-48
    80003dd4:	f406                	sd	ra,40(sp)
    80003dd6:	f022                	sd	s0,32(sp)
    80003dd8:	ec26                	sd	s1,24(sp)
    80003dda:	e84a                	sd	s2,16(sp)
    80003ddc:	1800                	addi	s0,sp,48
    80003dde:	892e                	mv	s2,a1
    80003de0:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    80003de2:	fdc40593          	addi	a1,s0,-36
    80003de6:	e85fd0ef          	jal	80001c6a <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80003dea:	fdc42703          	lw	a4,-36(s0)
    80003dee:	47bd                	li	a5,15
    80003df0:	02e7e963          	bltu	a5,a4,80003e22 <argfd+0x50>
    80003df4:	f7dfc0ef          	jal	80000d70 <myproc>
    80003df8:	fdc42703          	lw	a4,-36(s0)
    80003dfc:	01a70793          	addi	a5,a4,26
    80003e00:	078e                	slli	a5,a5,0x3
    80003e02:	953e                	add	a0,a0,a5
    80003e04:	611c                	ld	a5,0(a0)
    80003e06:	c385                	beqz	a5,80003e26 <argfd+0x54>
    return -1;
  if(pfd)
    80003e08:	00090463          	beqz	s2,80003e10 <argfd+0x3e>
    *pfd = fd;
    80003e0c:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80003e10:	4501                	li	a0,0
  if(pf)
    80003e12:	c091                	beqz	s1,80003e16 <argfd+0x44>
    *pf = f;
    80003e14:	e09c                	sd	a5,0(s1)
}
    80003e16:	70a2                	ld	ra,40(sp)
    80003e18:	7402                	ld	s0,32(sp)
    80003e1a:	64e2                	ld	s1,24(sp)
    80003e1c:	6942                	ld	s2,16(sp)
    80003e1e:	6145                	addi	sp,sp,48
    80003e20:	8082                	ret
    return -1;
    80003e22:	557d                	li	a0,-1
    80003e24:	bfcd                	j	80003e16 <argfd+0x44>
    80003e26:	557d                	li	a0,-1
    80003e28:	b7fd                	j	80003e16 <argfd+0x44>

0000000080003e2a <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80003e2a:	1101                	addi	sp,sp,-32
    80003e2c:	ec06                	sd	ra,24(sp)
    80003e2e:	e822                	sd	s0,16(sp)
    80003e30:	e426                	sd	s1,8(sp)
    80003e32:	1000                	addi	s0,sp,32
    80003e34:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80003e36:	f3bfc0ef          	jal	80000d70 <myproc>
    80003e3a:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80003e3c:	0d050793          	addi	a5,a0,208
    80003e40:	4501                	li	a0,0
    80003e42:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80003e44:	6398                	ld	a4,0(a5)
    80003e46:	cb19                	beqz	a4,80003e5c <fdalloc+0x32>
  for(fd = 0; fd < NOFILE; fd++){
    80003e48:	2505                	addiw	a0,a0,1
    80003e4a:	07a1                	addi	a5,a5,8
    80003e4c:	fed51ce3          	bne	a0,a3,80003e44 <fdalloc+0x1a>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80003e50:	557d                	li	a0,-1
}
    80003e52:	60e2                	ld	ra,24(sp)
    80003e54:	6442                	ld	s0,16(sp)
    80003e56:	64a2                	ld	s1,8(sp)
    80003e58:	6105                	addi	sp,sp,32
    80003e5a:	8082                	ret
      p->ofile[fd] = f;
    80003e5c:	01a50793          	addi	a5,a0,26
    80003e60:	078e                	slli	a5,a5,0x3
    80003e62:	963e                	add	a2,a2,a5
    80003e64:	e204                	sd	s1,0(a2)
      return fd;
    80003e66:	b7f5                	j	80003e52 <fdalloc+0x28>

0000000080003e68 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80003e68:	715d                	addi	sp,sp,-80
    80003e6a:	e486                	sd	ra,72(sp)
    80003e6c:	e0a2                	sd	s0,64(sp)
    80003e6e:	fc26                	sd	s1,56(sp)
    80003e70:	f84a                	sd	s2,48(sp)
    80003e72:	f44e                	sd	s3,40(sp)
    80003e74:	ec56                	sd	s5,24(sp)
    80003e76:	e85a                	sd	s6,16(sp)
    80003e78:	0880                	addi	s0,sp,80
    80003e7a:	8b2e                	mv	s6,a1
    80003e7c:	89b2                	mv	s3,a2
    80003e7e:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80003e80:	fb040593          	addi	a1,s0,-80
    80003e84:	ff3fe0ef          	jal	80002e76 <nameiparent>
    80003e88:	84aa                	mv	s1,a0
    80003e8a:	10050a63          	beqz	a0,80003f9e <create+0x136>
    return 0;

  ilock(dp);
    80003e8e:	fa4fe0ef          	jal	80002632 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80003e92:	4601                	li	a2,0
    80003e94:	fb040593          	addi	a1,s0,-80
    80003e98:	8526                	mv	a0,s1
    80003e9a:	d37fe0ef          	jal	80002bd0 <dirlookup>
    80003e9e:	8aaa                	mv	s5,a0
    80003ea0:	c129                	beqz	a0,80003ee2 <create+0x7a>
    iunlockput(dp);
    80003ea2:	8526                	mv	a0,s1
    80003ea4:	999fe0ef          	jal	8000283c <iunlockput>
    ilock(ip);
    80003ea8:	8556                	mv	a0,s5
    80003eaa:	f88fe0ef          	jal	80002632 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80003eae:	4789                	li	a5,2
    80003eb0:	02fb1463          	bne	s6,a5,80003ed8 <create+0x70>
    80003eb4:	044ad783          	lhu	a5,68(s5)
    80003eb8:	37f9                	addiw	a5,a5,-2
    80003eba:	17c2                	slli	a5,a5,0x30
    80003ebc:	93c1                	srli	a5,a5,0x30
    80003ebe:	4705                	li	a4,1
    80003ec0:	00f76c63          	bltu	a4,a5,80003ed8 <create+0x70>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    80003ec4:	8556                	mv	a0,s5
    80003ec6:	60a6                	ld	ra,72(sp)
    80003ec8:	6406                	ld	s0,64(sp)
    80003eca:	74e2                	ld	s1,56(sp)
    80003ecc:	7942                	ld	s2,48(sp)
    80003ece:	79a2                	ld	s3,40(sp)
    80003ed0:	6ae2                	ld	s5,24(sp)
    80003ed2:	6b42                	ld	s6,16(sp)
    80003ed4:	6161                	addi	sp,sp,80
    80003ed6:	8082                	ret
    iunlockput(ip);
    80003ed8:	8556                	mv	a0,s5
    80003eda:	963fe0ef          	jal	8000283c <iunlockput>
    return 0;
    80003ede:	4a81                	li	s5,0
    80003ee0:	b7d5                	j	80003ec4 <create+0x5c>
    80003ee2:	f052                	sd	s4,32(sp)
  if((ip = ialloc(dp->dev, type)) == 0){
    80003ee4:	85da                	mv	a1,s6
    80003ee6:	4088                	lw	a0,0(s1)
    80003ee8:	ddafe0ef          	jal	800024c2 <ialloc>
    80003eec:	8a2a                	mv	s4,a0
    80003eee:	cd15                	beqz	a0,80003f2a <create+0xc2>
  ilock(ip);
    80003ef0:	f42fe0ef          	jal	80002632 <ilock>
  ip->major = major;
    80003ef4:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    80003ef8:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    80003efc:	4905                	li	s2,1
    80003efe:	052a1523          	sh	s2,74(s4)
  iupdate(ip);
    80003f02:	8552                	mv	a0,s4
    80003f04:	e7afe0ef          	jal	8000257e <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80003f08:	032b0763          	beq	s6,s2,80003f36 <create+0xce>
  if(dirlink(dp, name, ip->inum) < 0)
    80003f0c:	004a2603          	lw	a2,4(s4)
    80003f10:	fb040593          	addi	a1,s0,-80
    80003f14:	8526                	mv	a0,s1
    80003f16:	e9dfe0ef          	jal	80002db2 <dirlink>
    80003f1a:	06054563          	bltz	a0,80003f84 <create+0x11c>
  iunlockput(dp);
    80003f1e:	8526                	mv	a0,s1
    80003f20:	91dfe0ef          	jal	8000283c <iunlockput>
  return ip;
    80003f24:	8ad2                	mv	s5,s4
    80003f26:	7a02                	ld	s4,32(sp)
    80003f28:	bf71                	j	80003ec4 <create+0x5c>
    iunlockput(dp);
    80003f2a:	8526                	mv	a0,s1
    80003f2c:	911fe0ef          	jal	8000283c <iunlockput>
    return 0;
    80003f30:	8ad2                	mv	s5,s4
    80003f32:	7a02                	ld	s4,32(sp)
    80003f34:	bf41                	j	80003ec4 <create+0x5c>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80003f36:	004a2603          	lw	a2,4(s4)
    80003f3a:	00003597          	auipc	a1,0x3
    80003f3e:	62658593          	addi	a1,a1,1574 # 80007560 <etext+0x560>
    80003f42:	8552                	mv	a0,s4
    80003f44:	e6ffe0ef          	jal	80002db2 <dirlink>
    80003f48:	02054e63          	bltz	a0,80003f84 <create+0x11c>
    80003f4c:	40d0                	lw	a2,4(s1)
    80003f4e:	00003597          	auipc	a1,0x3
    80003f52:	61a58593          	addi	a1,a1,1562 # 80007568 <etext+0x568>
    80003f56:	8552                	mv	a0,s4
    80003f58:	e5bfe0ef          	jal	80002db2 <dirlink>
    80003f5c:	02054463          	bltz	a0,80003f84 <create+0x11c>
  if(dirlink(dp, name, ip->inum) < 0)
    80003f60:	004a2603          	lw	a2,4(s4)
    80003f64:	fb040593          	addi	a1,s0,-80
    80003f68:	8526                	mv	a0,s1
    80003f6a:	e49fe0ef          	jal	80002db2 <dirlink>
    80003f6e:	00054b63          	bltz	a0,80003f84 <create+0x11c>
    dp->nlink++;  // for ".."
    80003f72:	04a4d783          	lhu	a5,74(s1)
    80003f76:	2785                	addiw	a5,a5,1
    80003f78:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80003f7c:	8526                	mv	a0,s1
    80003f7e:	e00fe0ef          	jal	8000257e <iupdate>
    80003f82:	bf71                	j	80003f1e <create+0xb6>
  ip->nlink = 0;
    80003f84:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80003f88:	8552                	mv	a0,s4
    80003f8a:	df4fe0ef          	jal	8000257e <iupdate>
  iunlockput(ip);
    80003f8e:	8552                	mv	a0,s4
    80003f90:	8adfe0ef          	jal	8000283c <iunlockput>
  iunlockput(dp);
    80003f94:	8526                	mv	a0,s1
    80003f96:	8a7fe0ef          	jal	8000283c <iunlockput>
  return 0;
    80003f9a:	7a02                	ld	s4,32(sp)
    80003f9c:	b725                	j	80003ec4 <create+0x5c>
    return 0;
    80003f9e:	8aaa                	mv	s5,a0
    80003fa0:	b715                	j	80003ec4 <create+0x5c>

0000000080003fa2 <sys_dup>:
{
    80003fa2:	7179                	addi	sp,sp,-48
    80003fa4:	f406                	sd	ra,40(sp)
    80003fa6:	f022                	sd	s0,32(sp)
    80003fa8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80003faa:	fd840613          	addi	a2,s0,-40
    80003fae:	4581                	li	a1,0
    80003fb0:	4501                	li	a0,0
    80003fb2:	e21ff0ef          	jal	80003dd2 <argfd>
    return -1;
    80003fb6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    80003fb8:	02054363          	bltz	a0,80003fde <sys_dup+0x3c>
    80003fbc:	ec26                	sd	s1,24(sp)
    80003fbe:	e84a                	sd	s2,16(sp)
  if((fd=fdalloc(f)) < 0)
    80003fc0:	fd843903          	ld	s2,-40(s0)
    80003fc4:	854a                	mv	a0,s2
    80003fc6:	e65ff0ef          	jal	80003e2a <fdalloc>
    80003fca:	84aa                	mv	s1,a0
    return -1;
    80003fcc:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80003fce:	00054d63          	bltz	a0,80003fe8 <sys_dup+0x46>
  filedup(f);
    80003fd2:	854a                	mv	a0,s2
    80003fd4:	c2eff0ef          	jal	80003402 <filedup>
  return fd;
    80003fd8:	87a6                	mv	a5,s1
    80003fda:	64e2                	ld	s1,24(sp)
    80003fdc:	6942                	ld	s2,16(sp)
}
    80003fde:	853e                	mv	a0,a5
    80003fe0:	70a2                	ld	ra,40(sp)
    80003fe2:	7402                	ld	s0,32(sp)
    80003fe4:	6145                	addi	sp,sp,48
    80003fe6:	8082                	ret
    80003fe8:	64e2                	ld	s1,24(sp)
    80003fea:	6942                	ld	s2,16(sp)
    80003fec:	bfcd                	j	80003fde <sys_dup+0x3c>

0000000080003fee <sys_read>:
{
    80003fee:	7179                	addi	sp,sp,-48
    80003ff0:	f406                	sd	ra,40(sp)
    80003ff2:	f022                	sd	s0,32(sp)
    80003ff4:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80003ff6:	fd840593          	addi	a1,s0,-40
    80003ffa:	4505                	li	a0,1
    80003ffc:	c8bfd0ef          	jal	80001c86 <argaddr>
  argint(2, &n);
    80004000:	fe440593          	addi	a1,s0,-28
    80004004:	4509                	li	a0,2
    80004006:	c65fd0ef          	jal	80001c6a <argint>
  if(argfd(0, 0, &f) < 0)
    8000400a:	fe840613          	addi	a2,s0,-24
    8000400e:	4581                	li	a1,0
    80004010:	4501                	li	a0,0
    80004012:	dc1ff0ef          	jal	80003dd2 <argfd>
    80004016:	87aa                	mv	a5,a0
    return -1;
    80004018:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000401a:	0007ca63          	bltz	a5,8000402e <sys_read+0x40>
  return fileread(f, p, n);
    8000401e:	fe442603          	lw	a2,-28(s0)
    80004022:	fd843583          	ld	a1,-40(s0)
    80004026:	fe843503          	ld	a0,-24(s0)
    8000402a:	d3eff0ef          	jal	80003568 <fileread>
}
    8000402e:	70a2                	ld	ra,40(sp)
    80004030:	7402                	ld	s0,32(sp)
    80004032:	6145                	addi	sp,sp,48
    80004034:	8082                	ret

0000000080004036 <sys_write>:
{
    80004036:	7179                	addi	sp,sp,-48
    80004038:	f406                	sd	ra,40(sp)
    8000403a:	f022                	sd	s0,32(sp)
    8000403c:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    8000403e:	fd840593          	addi	a1,s0,-40
    80004042:	4505                	li	a0,1
    80004044:	c43fd0ef          	jal	80001c86 <argaddr>
  argint(2, &n);
    80004048:	fe440593          	addi	a1,s0,-28
    8000404c:	4509                	li	a0,2
    8000404e:	c1dfd0ef          	jal	80001c6a <argint>
  if(argfd(0, 0, &f) < 0)
    80004052:	fe840613          	addi	a2,s0,-24
    80004056:	4581                	li	a1,0
    80004058:	4501                	li	a0,0
    8000405a:	d79ff0ef          	jal	80003dd2 <argfd>
    8000405e:	87aa                	mv	a5,a0
    return -1;
    80004060:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004062:	0007ca63          	bltz	a5,80004076 <sys_write+0x40>
  return filewrite(f, p, n);
    80004066:	fe442603          	lw	a2,-28(s0)
    8000406a:	fd843583          	ld	a1,-40(s0)
    8000406e:	fe843503          	ld	a0,-24(s0)
    80004072:	db4ff0ef          	jal	80003626 <filewrite>
}
    80004076:	70a2                	ld	ra,40(sp)
    80004078:	7402                	ld	s0,32(sp)
    8000407a:	6145                	addi	sp,sp,48
    8000407c:	8082                	ret

000000008000407e <sys_close>:
{
    8000407e:	1101                	addi	sp,sp,-32
    80004080:	ec06                	sd	ra,24(sp)
    80004082:	e822                	sd	s0,16(sp)
    80004084:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004086:	fe040613          	addi	a2,s0,-32
    8000408a:	fec40593          	addi	a1,s0,-20
    8000408e:	4501                	li	a0,0
    80004090:	d43ff0ef          	jal	80003dd2 <argfd>
    return -1;
    80004094:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004096:	02054063          	bltz	a0,800040b6 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
    8000409a:	cd7fc0ef          	jal	80000d70 <myproc>
    8000409e:	fec42783          	lw	a5,-20(s0)
    800040a2:	07e9                	addi	a5,a5,26
    800040a4:	078e                	slli	a5,a5,0x3
    800040a6:	953e                	add	a0,a0,a5
    800040a8:	00053023          	sd	zero,0(a0)
  fileclose(f);
    800040ac:	fe043503          	ld	a0,-32(s0)
    800040b0:	b98ff0ef          	jal	80003448 <fileclose>
  return 0;
    800040b4:	4781                	li	a5,0
}
    800040b6:	853e                	mv	a0,a5
    800040b8:	60e2                	ld	ra,24(sp)
    800040ba:	6442                	ld	s0,16(sp)
    800040bc:	6105                	addi	sp,sp,32
    800040be:	8082                	ret

00000000800040c0 <sys_fstat>:
{
    800040c0:	1101                	addi	sp,sp,-32
    800040c2:	ec06                	sd	ra,24(sp)
    800040c4:	e822                	sd	s0,16(sp)
    800040c6:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    800040c8:	fe040593          	addi	a1,s0,-32
    800040cc:	4505                	li	a0,1
    800040ce:	bb9fd0ef          	jal	80001c86 <argaddr>
  if(argfd(0, 0, &f) < 0)
    800040d2:	fe840613          	addi	a2,s0,-24
    800040d6:	4581                	li	a1,0
    800040d8:	4501                	li	a0,0
    800040da:	cf9ff0ef          	jal	80003dd2 <argfd>
    800040de:	87aa                	mv	a5,a0
    return -1;
    800040e0:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    800040e2:	0007c863          	bltz	a5,800040f2 <sys_fstat+0x32>
  return filestat(f, st);
    800040e6:	fe043583          	ld	a1,-32(s0)
    800040ea:	fe843503          	ld	a0,-24(s0)
    800040ee:	c18ff0ef          	jal	80003506 <filestat>
}
    800040f2:	60e2                	ld	ra,24(sp)
    800040f4:	6442                	ld	s0,16(sp)
    800040f6:	6105                	addi	sp,sp,32
    800040f8:	8082                	ret

00000000800040fa <sys_link>:
{
    800040fa:	7169                	addi	sp,sp,-304
    800040fc:	f606                	sd	ra,296(sp)
    800040fe:	f222                	sd	s0,288(sp)
    80004100:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004102:	08000613          	li	a2,128
    80004106:	ed040593          	addi	a1,s0,-304
    8000410a:	4501                	li	a0,0
    8000410c:	b97fd0ef          	jal	80001ca2 <argstr>
    return -1;
    80004110:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004112:	0c054e63          	bltz	a0,800041ee <sys_link+0xf4>
    80004116:	08000613          	li	a2,128
    8000411a:	f5040593          	addi	a1,s0,-176
    8000411e:	4505                	li	a0,1
    80004120:	b83fd0ef          	jal	80001ca2 <argstr>
    return -1;
    80004124:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004126:	0c054463          	bltz	a0,800041ee <sys_link+0xf4>
    8000412a:	ee26                	sd	s1,280(sp)
  begin_op();
    8000412c:	f0bfe0ef          	jal	80003036 <begin_op>
  if((ip = namei(old)) == 0){
    80004130:	ed040513          	addi	a0,s0,-304
    80004134:	d29fe0ef          	jal	80002e5c <namei>
    80004138:	84aa                	mv	s1,a0
    8000413a:	c53d                	beqz	a0,800041a8 <sys_link+0xae>
  ilock(ip);
    8000413c:	cf6fe0ef          	jal	80002632 <ilock>
  if(ip->type == T_DIR){
    80004140:	04449703          	lh	a4,68(s1)
    80004144:	4785                	li	a5,1
    80004146:	06f70663          	beq	a4,a5,800041b2 <sys_link+0xb8>
    8000414a:	ea4a                	sd	s2,272(sp)
  ip->nlink++;
    8000414c:	04a4d783          	lhu	a5,74(s1)
    80004150:	2785                	addiw	a5,a5,1
    80004152:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004156:	8526                	mv	a0,s1
    80004158:	c26fe0ef          	jal	8000257e <iupdate>
  iunlock(ip);
    8000415c:	8526                	mv	a0,s1
    8000415e:	d82fe0ef          	jal	800026e0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004162:	fd040593          	addi	a1,s0,-48
    80004166:	f5040513          	addi	a0,s0,-176
    8000416a:	d0dfe0ef          	jal	80002e76 <nameiparent>
    8000416e:	892a                	mv	s2,a0
    80004170:	cd21                	beqz	a0,800041c8 <sys_link+0xce>
  ilock(dp);
    80004172:	cc0fe0ef          	jal	80002632 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004176:	00092703          	lw	a4,0(s2)
    8000417a:	409c                	lw	a5,0(s1)
    8000417c:	04f71363          	bne	a4,a5,800041c2 <sys_link+0xc8>
    80004180:	40d0                	lw	a2,4(s1)
    80004182:	fd040593          	addi	a1,s0,-48
    80004186:	854a                	mv	a0,s2
    80004188:	c2bfe0ef          	jal	80002db2 <dirlink>
    8000418c:	02054b63          	bltz	a0,800041c2 <sys_link+0xc8>
  iunlockput(dp);
    80004190:	854a                	mv	a0,s2
    80004192:	eaafe0ef          	jal	8000283c <iunlockput>
  iput(ip);
    80004196:	8526                	mv	a0,s1
    80004198:	e1cfe0ef          	jal	800027b4 <iput>
  end_op();
    8000419c:	f05fe0ef          	jal	800030a0 <end_op>
  return 0;
    800041a0:	4781                	li	a5,0
    800041a2:	64f2                	ld	s1,280(sp)
    800041a4:	6952                	ld	s2,272(sp)
    800041a6:	a0a1                	j	800041ee <sys_link+0xf4>
    end_op();
    800041a8:	ef9fe0ef          	jal	800030a0 <end_op>
    return -1;
    800041ac:	57fd                	li	a5,-1
    800041ae:	64f2                	ld	s1,280(sp)
    800041b0:	a83d                	j	800041ee <sys_link+0xf4>
    iunlockput(ip);
    800041b2:	8526                	mv	a0,s1
    800041b4:	e88fe0ef          	jal	8000283c <iunlockput>
    end_op();
    800041b8:	ee9fe0ef          	jal	800030a0 <end_op>
    return -1;
    800041bc:	57fd                	li	a5,-1
    800041be:	64f2                	ld	s1,280(sp)
    800041c0:	a03d                	j	800041ee <sys_link+0xf4>
    iunlockput(dp);
    800041c2:	854a                	mv	a0,s2
    800041c4:	e78fe0ef          	jal	8000283c <iunlockput>
  ilock(ip);
    800041c8:	8526                	mv	a0,s1
    800041ca:	c68fe0ef          	jal	80002632 <ilock>
  ip->nlink--;
    800041ce:	04a4d783          	lhu	a5,74(s1)
    800041d2:	37fd                	addiw	a5,a5,-1
    800041d4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800041d8:	8526                	mv	a0,s1
    800041da:	ba4fe0ef          	jal	8000257e <iupdate>
  iunlockput(ip);
    800041de:	8526                	mv	a0,s1
    800041e0:	e5cfe0ef          	jal	8000283c <iunlockput>
  end_op();
    800041e4:	ebdfe0ef          	jal	800030a0 <end_op>
  return -1;
    800041e8:	57fd                	li	a5,-1
    800041ea:	64f2                	ld	s1,280(sp)
    800041ec:	6952                	ld	s2,272(sp)
}
    800041ee:	853e                	mv	a0,a5
    800041f0:	70b2                	ld	ra,296(sp)
    800041f2:	7412                	ld	s0,288(sp)
    800041f4:	6155                	addi	sp,sp,304
    800041f6:	8082                	ret

00000000800041f8 <sys_unlink>:
{
    800041f8:	7111                	addi	sp,sp,-256
    800041fa:	fd86                	sd	ra,248(sp)
    800041fc:	f9a2                	sd	s0,240(sp)
    800041fe:	0200                	addi	s0,sp,256
  if(argstr(0, path, MAXPATH) < 0)
    80004200:	08000613          	li	a2,128
    80004204:	f2040593          	addi	a1,s0,-224
    80004208:	4501                	li	a0,0
    8000420a:	a99fd0ef          	jal	80001ca2 <argstr>
    8000420e:	16054663          	bltz	a0,8000437a <sys_unlink+0x182>
    80004212:	f5a6                	sd	s1,232(sp)
  begin_op();
    80004214:	e23fe0ef          	jal	80003036 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004218:	fa040593          	addi	a1,s0,-96
    8000421c:	f2040513          	addi	a0,s0,-224
    80004220:	c57fe0ef          	jal	80002e76 <nameiparent>
    80004224:	84aa                	mv	s1,a0
    80004226:	c955                	beqz	a0,800042da <sys_unlink+0xe2>
  ilock(dp);
    80004228:	c0afe0ef          	jal	80002632 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000422c:	00003597          	auipc	a1,0x3
    80004230:	33458593          	addi	a1,a1,820 # 80007560 <etext+0x560>
    80004234:	fa040513          	addi	a0,s0,-96
    80004238:	983fe0ef          	jal	80002bba <namecmp>
    8000423c:	12050463          	beqz	a0,80004364 <sys_unlink+0x16c>
    80004240:	00003597          	auipc	a1,0x3
    80004244:	32858593          	addi	a1,a1,808 # 80007568 <etext+0x568>
    80004248:	fa040513          	addi	a0,s0,-96
    8000424c:	96ffe0ef          	jal	80002bba <namecmp>
    80004250:	10050a63          	beqz	a0,80004364 <sys_unlink+0x16c>
    80004254:	f1ca                	sd	s2,224(sp)
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004256:	f1c40613          	addi	a2,s0,-228
    8000425a:	fa040593          	addi	a1,s0,-96
    8000425e:	8526                	mv	a0,s1
    80004260:	971fe0ef          	jal	80002bd0 <dirlookup>
    80004264:	892a                	mv	s2,a0
    80004266:	0e050e63          	beqz	a0,80004362 <sys_unlink+0x16a>
    8000426a:	edce                	sd	s3,216(sp)
  ilock(ip);
    8000426c:	bc6fe0ef          	jal	80002632 <ilock>
  if(ip->nlink < 1)
    80004270:	04a91783          	lh	a5,74(s2)
    80004274:	06f05863          	blez	a5,800042e4 <sys_unlink+0xec>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004278:	04491703          	lh	a4,68(s2)
    8000427c:	4785                	li	a5,1
    8000427e:	06f70b63          	beq	a4,a5,800042f4 <sys_unlink+0xfc>
  memset(&de, 0, sizeof(de));
    80004282:	fb040993          	addi	s3,s0,-80
    80004286:	4641                	li	a2,16
    80004288:	4581                	li	a1,0
    8000428a:	854e                	mv	a0,s3
    8000428c:	ec3fb0ef          	jal	8000014e <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004290:	4741                	li	a4,16
    80004292:	f1c42683          	lw	a3,-228(s0)
    80004296:	864e                	mv	a2,s3
    80004298:	4581                	li	a1,0
    8000429a:	8526                	mv	a0,s1
    8000429c:	81bfe0ef          	jal	80002ab6 <writei>
    800042a0:	47c1                	li	a5,16
    800042a2:	08f51f63          	bne	a0,a5,80004340 <sys_unlink+0x148>
  if(ip->type == T_DIR){
    800042a6:	04491703          	lh	a4,68(s2)
    800042aa:	4785                	li	a5,1
    800042ac:	0af70263          	beq	a4,a5,80004350 <sys_unlink+0x158>
  iunlockput(dp);
    800042b0:	8526                	mv	a0,s1
    800042b2:	d8afe0ef          	jal	8000283c <iunlockput>
  ip->nlink--;
    800042b6:	04a95783          	lhu	a5,74(s2)
    800042ba:	37fd                	addiw	a5,a5,-1
    800042bc:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800042c0:	854a                	mv	a0,s2
    800042c2:	abcfe0ef          	jal	8000257e <iupdate>
  iunlockput(ip);
    800042c6:	854a                	mv	a0,s2
    800042c8:	d74fe0ef          	jal	8000283c <iunlockput>
  end_op();
    800042cc:	dd5fe0ef          	jal	800030a0 <end_op>
  return 0;
    800042d0:	4501                	li	a0,0
    800042d2:	74ae                	ld	s1,232(sp)
    800042d4:	790e                	ld	s2,224(sp)
    800042d6:	69ee                	ld	s3,216(sp)
    800042d8:	a869                	j	80004372 <sys_unlink+0x17a>
    end_op();
    800042da:	dc7fe0ef          	jal	800030a0 <end_op>
    return -1;
    800042de:	557d                	li	a0,-1
    800042e0:	74ae                	ld	s1,232(sp)
    800042e2:	a841                	j	80004372 <sys_unlink+0x17a>
    800042e4:	e9d2                	sd	s4,208(sp)
    800042e6:	e5d6                	sd	s5,200(sp)
    panic("unlink: nlink < 1");
    800042e8:	00003517          	auipc	a0,0x3
    800042ec:	28850513          	addi	a0,a0,648 # 80007570 <etext+0x570>
    800042f0:	2b6010ef          	jal	800055a6 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800042f4:	04c92703          	lw	a4,76(s2)
    800042f8:	02000793          	li	a5,32
    800042fc:	f8e7f3e3          	bgeu	a5,a4,80004282 <sys_unlink+0x8a>
    80004300:	e9d2                	sd	s4,208(sp)
    80004302:	e5d6                	sd	s5,200(sp)
    80004304:	89be                	mv	s3,a5
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004306:	f0840a93          	addi	s5,s0,-248
    8000430a:	4a41                	li	s4,16
    8000430c:	8752                	mv	a4,s4
    8000430e:	86ce                	mv	a3,s3
    80004310:	8656                	mv	a2,s5
    80004312:	4581                	li	a1,0
    80004314:	854a                	mv	a0,s2
    80004316:	eaefe0ef          	jal	800029c4 <readi>
    8000431a:	01451d63          	bne	a0,s4,80004334 <sys_unlink+0x13c>
    if(de.inum != 0)
    8000431e:	f0845783          	lhu	a5,-248(s0)
    80004322:	efb1                	bnez	a5,8000437e <sys_unlink+0x186>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004324:	29c1                	addiw	s3,s3,16
    80004326:	04c92783          	lw	a5,76(s2)
    8000432a:	fef9e1e3          	bltu	s3,a5,8000430c <sys_unlink+0x114>
    8000432e:	6a4e                	ld	s4,208(sp)
    80004330:	6aae                	ld	s5,200(sp)
    80004332:	bf81                	j	80004282 <sys_unlink+0x8a>
      panic("isdirempty: readi");
    80004334:	00003517          	auipc	a0,0x3
    80004338:	25450513          	addi	a0,a0,596 # 80007588 <etext+0x588>
    8000433c:	26a010ef          	jal	800055a6 <panic>
    80004340:	e9d2                	sd	s4,208(sp)
    80004342:	e5d6                	sd	s5,200(sp)
    panic("unlink: writei");
    80004344:	00003517          	auipc	a0,0x3
    80004348:	25c50513          	addi	a0,a0,604 # 800075a0 <etext+0x5a0>
    8000434c:	25a010ef          	jal	800055a6 <panic>
    dp->nlink--;
    80004350:	04a4d783          	lhu	a5,74(s1)
    80004354:	37fd                	addiw	a5,a5,-1
    80004356:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    8000435a:	8526                	mv	a0,s1
    8000435c:	a22fe0ef          	jal	8000257e <iupdate>
    80004360:	bf81                	j	800042b0 <sys_unlink+0xb8>
    80004362:	790e                	ld	s2,224(sp)
  iunlockput(dp);
    80004364:	8526                	mv	a0,s1
    80004366:	cd6fe0ef          	jal	8000283c <iunlockput>
  end_op();
    8000436a:	d37fe0ef          	jal	800030a0 <end_op>
  return -1;
    8000436e:	557d                	li	a0,-1
    80004370:	74ae                	ld	s1,232(sp)
}
    80004372:	70ee                	ld	ra,248(sp)
    80004374:	744e                	ld	s0,240(sp)
    80004376:	6111                	addi	sp,sp,256
    80004378:	8082                	ret
    return -1;
    8000437a:	557d                	li	a0,-1
    8000437c:	bfdd                	j	80004372 <sys_unlink+0x17a>
    iunlockput(ip);
    8000437e:	854a                	mv	a0,s2
    80004380:	cbcfe0ef          	jal	8000283c <iunlockput>
    goto bad;
    80004384:	790e                	ld	s2,224(sp)
    80004386:	69ee                	ld	s3,216(sp)
    80004388:	6a4e                	ld	s4,208(sp)
    8000438a:	6aae                	ld	s5,200(sp)
    8000438c:	bfe1                	j	80004364 <sys_unlink+0x16c>

000000008000438e <sys_open>:

uint64
sys_open(void)
{
    8000438e:	7131                	addi	sp,sp,-192
    80004390:	fd06                	sd	ra,184(sp)
    80004392:	f922                	sd	s0,176(sp)
    80004394:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004396:	f4c40593          	addi	a1,s0,-180
    8000439a:	4505                	li	a0,1
    8000439c:	8cffd0ef          	jal	80001c6a <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    800043a0:	08000613          	li	a2,128
    800043a4:	f5040593          	addi	a1,s0,-176
    800043a8:	4501                	li	a0,0
    800043aa:	8f9fd0ef          	jal	80001ca2 <argstr>
    800043ae:	87aa                	mv	a5,a0
    return -1;
    800043b0:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    800043b2:	0a07c363          	bltz	a5,80004458 <sys_open+0xca>
    800043b6:	f526                	sd	s1,168(sp)

  begin_op();
    800043b8:	c7ffe0ef          	jal	80003036 <begin_op>

  if(omode & O_CREATE){
    800043bc:	f4c42783          	lw	a5,-180(s0)
    800043c0:	2007f793          	andi	a5,a5,512
    800043c4:	c3dd                	beqz	a5,8000446a <sys_open+0xdc>
    ip = create(path, T_FILE, 0, 0);
    800043c6:	4681                	li	a3,0
    800043c8:	4601                	li	a2,0
    800043ca:	4589                	li	a1,2
    800043cc:	f5040513          	addi	a0,s0,-176
    800043d0:	a99ff0ef          	jal	80003e68 <create>
    800043d4:	84aa                	mv	s1,a0
    if(ip == 0){
    800043d6:	c549                	beqz	a0,80004460 <sys_open+0xd2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    800043d8:	04449703          	lh	a4,68(s1)
    800043dc:	478d                	li	a5,3
    800043de:	00f71763          	bne	a4,a5,800043ec <sys_open+0x5e>
    800043e2:	0464d703          	lhu	a4,70(s1)
    800043e6:	47a5                	li	a5,9
    800043e8:	0ae7ee63          	bltu	a5,a4,800044a4 <sys_open+0x116>
    800043ec:	f14a                	sd	s2,160(sp)
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    800043ee:	fb7fe0ef          	jal	800033a4 <filealloc>
    800043f2:	892a                	mv	s2,a0
    800043f4:	c561                	beqz	a0,800044bc <sys_open+0x12e>
    800043f6:	ed4e                	sd	s3,152(sp)
    800043f8:	a33ff0ef          	jal	80003e2a <fdalloc>
    800043fc:	89aa                	mv	s3,a0
    800043fe:	0a054b63          	bltz	a0,800044b4 <sys_open+0x126>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004402:	04449703          	lh	a4,68(s1)
    80004406:	478d                	li	a5,3
    80004408:	0cf70363          	beq	a4,a5,800044ce <sys_open+0x140>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    8000440c:	4789                	li	a5,2
    8000440e:	00f92023          	sw	a5,0(s2)
    f->off = 0;
    80004412:	02092023          	sw	zero,32(s2)
  }
  f->ip = ip;
    80004416:	00993c23          	sd	s1,24(s2)
  f->readable = !(omode & O_WRONLY);
    8000441a:	f4c42783          	lw	a5,-180(s0)
    8000441e:	0017f713          	andi	a4,a5,1
    80004422:	00174713          	xori	a4,a4,1
    80004426:	00e90423          	sb	a4,8(s2)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000442a:	0037f713          	andi	a4,a5,3
    8000442e:	00e03733          	snez	a4,a4
    80004432:	00e904a3          	sb	a4,9(s2)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004436:	4007f793          	andi	a5,a5,1024
    8000443a:	c791                	beqz	a5,80004446 <sys_open+0xb8>
    8000443c:	04449703          	lh	a4,68(s1)
    80004440:	4789                	li	a5,2
    80004442:	08f70d63          	beq	a4,a5,800044dc <sys_open+0x14e>
    itrunc(ip);
  }

  iunlock(ip);
    80004446:	8526                	mv	a0,s1
    80004448:	a98fe0ef          	jal	800026e0 <iunlock>
  end_op();
    8000444c:	c55fe0ef          	jal	800030a0 <end_op>

  return fd;
    80004450:	854e                	mv	a0,s3
    80004452:	74aa                	ld	s1,168(sp)
    80004454:	790a                	ld	s2,160(sp)
    80004456:	69ea                	ld	s3,152(sp)
}
    80004458:	70ea                	ld	ra,184(sp)
    8000445a:	744a                	ld	s0,176(sp)
    8000445c:	6129                	addi	sp,sp,192
    8000445e:	8082                	ret
      end_op();
    80004460:	c41fe0ef          	jal	800030a0 <end_op>
      return -1;
    80004464:	557d                	li	a0,-1
    80004466:	74aa                	ld	s1,168(sp)
    80004468:	bfc5                	j	80004458 <sys_open+0xca>
    if((ip = namei(path)) == 0){
    8000446a:	f5040513          	addi	a0,s0,-176
    8000446e:	9effe0ef          	jal	80002e5c <namei>
    80004472:	84aa                	mv	s1,a0
    80004474:	c11d                	beqz	a0,8000449a <sys_open+0x10c>
    ilock(ip);
    80004476:	9bcfe0ef          	jal	80002632 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    8000447a:	04449703          	lh	a4,68(s1)
    8000447e:	4785                	li	a5,1
    80004480:	f4f71ce3          	bne	a4,a5,800043d8 <sys_open+0x4a>
    80004484:	f4c42783          	lw	a5,-180(s0)
    80004488:	d3b5                	beqz	a5,800043ec <sys_open+0x5e>
      iunlockput(ip);
    8000448a:	8526                	mv	a0,s1
    8000448c:	bb0fe0ef          	jal	8000283c <iunlockput>
      end_op();
    80004490:	c11fe0ef          	jal	800030a0 <end_op>
      return -1;
    80004494:	557d                	li	a0,-1
    80004496:	74aa                	ld	s1,168(sp)
    80004498:	b7c1                	j	80004458 <sys_open+0xca>
      end_op();
    8000449a:	c07fe0ef          	jal	800030a0 <end_op>
      return -1;
    8000449e:	557d                	li	a0,-1
    800044a0:	74aa                	ld	s1,168(sp)
    800044a2:	bf5d                	j	80004458 <sys_open+0xca>
    iunlockput(ip);
    800044a4:	8526                	mv	a0,s1
    800044a6:	b96fe0ef          	jal	8000283c <iunlockput>
    end_op();
    800044aa:	bf7fe0ef          	jal	800030a0 <end_op>
    return -1;
    800044ae:	557d                	li	a0,-1
    800044b0:	74aa                	ld	s1,168(sp)
    800044b2:	b75d                	j	80004458 <sys_open+0xca>
      fileclose(f);
    800044b4:	854a                	mv	a0,s2
    800044b6:	f93fe0ef          	jal	80003448 <fileclose>
    800044ba:	69ea                	ld	s3,152(sp)
    iunlockput(ip);
    800044bc:	8526                	mv	a0,s1
    800044be:	b7efe0ef          	jal	8000283c <iunlockput>
    end_op();
    800044c2:	bdffe0ef          	jal	800030a0 <end_op>
    return -1;
    800044c6:	557d                	li	a0,-1
    800044c8:	74aa                	ld	s1,168(sp)
    800044ca:	790a                	ld	s2,160(sp)
    800044cc:	b771                	j	80004458 <sys_open+0xca>
    f->type = FD_DEVICE;
    800044ce:	00f92023          	sw	a5,0(s2)
    f->major = ip->major;
    800044d2:	04649783          	lh	a5,70(s1)
    800044d6:	02f91223          	sh	a5,36(s2)
    800044da:	bf35                	j	80004416 <sys_open+0x88>
    itrunc(ip);
    800044dc:	8526                	mv	a0,s1
    800044de:	a42fe0ef          	jal	80002720 <itrunc>
    800044e2:	b795                	j	80004446 <sys_open+0xb8>

00000000800044e4 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    800044e4:	7175                	addi	sp,sp,-144
    800044e6:	e506                	sd	ra,136(sp)
    800044e8:	e122                	sd	s0,128(sp)
    800044ea:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    800044ec:	b4bfe0ef          	jal	80003036 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    800044f0:	08000613          	li	a2,128
    800044f4:	f7040593          	addi	a1,s0,-144
    800044f8:	4501                	li	a0,0
    800044fa:	fa8fd0ef          	jal	80001ca2 <argstr>
    800044fe:	02054363          	bltz	a0,80004524 <sys_mkdir+0x40>
    80004502:	4681                	li	a3,0
    80004504:	4601                	li	a2,0
    80004506:	4585                	li	a1,1
    80004508:	f7040513          	addi	a0,s0,-144
    8000450c:	95dff0ef          	jal	80003e68 <create>
    80004510:	c911                	beqz	a0,80004524 <sys_mkdir+0x40>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004512:	b2afe0ef          	jal	8000283c <iunlockput>
  end_op();
    80004516:	b8bfe0ef          	jal	800030a0 <end_op>
  return 0;
    8000451a:	4501                	li	a0,0
}
    8000451c:	60aa                	ld	ra,136(sp)
    8000451e:	640a                	ld	s0,128(sp)
    80004520:	6149                	addi	sp,sp,144
    80004522:	8082                	ret
    end_op();
    80004524:	b7dfe0ef          	jal	800030a0 <end_op>
    return -1;
    80004528:	557d                	li	a0,-1
    8000452a:	bfcd                	j	8000451c <sys_mkdir+0x38>

000000008000452c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000452c:	7135                	addi	sp,sp,-160
    8000452e:	ed06                	sd	ra,152(sp)
    80004530:	e922                	sd	s0,144(sp)
    80004532:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004534:	b03fe0ef          	jal	80003036 <begin_op>
  argint(1, &major);
    80004538:	f6c40593          	addi	a1,s0,-148
    8000453c:	4505                	li	a0,1
    8000453e:	f2cfd0ef          	jal	80001c6a <argint>
  argint(2, &minor);
    80004542:	f6840593          	addi	a1,s0,-152
    80004546:	4509                	li	a0,2
    80004548:	f22fd0ef          	jal	80001c6a <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    8000454c:	08000613          	li	a2,128
    80004550:	f7040593          	addi	a1,s0,-144
    80004554:	4501                	li	a0,0
    80004556:	f4cfd0ef          	jal	80001ca2 <argstr>
    8000455a:	02054563          	bltz	a0,80004584 <sys_mknod+0x58>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    8000455e:	f6841683          	lh	a3,-152(s0)
    80004562:	f6c41603          	lh	a2,-148(s0)
    80004566:	458d                	li	a1,3
    80004568:	f7040513          	addi	a0,s0,-144
    8000456c:	8fdff0ef          	jal	80003e68 <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004570:	c911                	beqz	a0,80004584 <sys_mknod+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004572:	acafe0ef          	jal	8000283c <iunlockput>
  end_op();
    80004576:	b2bfe0ef          	jal	800030a0 <end_op>
  return 0;
    8000457a:	4501                	li	a0,0
}
    8000457c:	60ea                	ld	ra,152(sp)
    8000457e:	644a                	ld	s0,144(sp)
    80004580:	610d                	addi	sp,sp,160
    80004582:	8082                	ret
    end_op();
    80004584:	b1dfe0ef          	jal	800030a0 <end_op>
    return -1;
    80004588:	557d                	li	a0,-1
    8000458a:	bfcd                	j	8000457c <sys_mknod+0x50>

000000008000458c <sys_chdir>:

uint64
sys_chdir(void)
{
    8000458c:	7135                	addi	sp,sp,-160
    8000458e:	ed06                	sd	ra,152(sp)
    80004590:	e922                	sd	s0,144(sp)
    80004592:	e14a                	sd	s2,128(sp)
    80004594:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004596:	fdafc0ef          	jal	80000d70 <myproc>
    8000459a:	892a                	mv	s2,a0
  
  begin_op();
    8000459c:	a9bfe0ef          	jal	80003036 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    800045a0:	08000613          	li	a2,128
    800045a4:	f6040593          	addi	a1,s0,-160
    800045a8:	4501                	li	a0,0
    800045aa:	ef8fd0ef          	jal	80001ca2 <argstr>
    800045ae:	04054363          	bltz	a0,800045f4 <sys_chdir+0x68>
    800045b2:	e526                	sd	s1,136(sp)
    800045b4:	f6040513          	addi	a0,s0,-160
    800045b8:	8a5fe0ef          	jal	80002e5c <namei>
    800045bc:	84aa                	mv	s1,a0
    800045be:	c915                	beqz	a0,800045f2 <sys_chdir+0x66>
    end_op();
    return -1;
  }
  ilock(ip);
    800045c0:	872fe0ef          	jal	80002632 <ilock>
  if(ip->type != T_DIR){
    800045c4:	04449703          	lh	a4,68(s1)
    800045c8:	4785                	li	a5,1
    800045ca:	02f71963          	bne	a4,a5,800045fc <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    800045ce:	8526                	mv	a0,s1
    800045d0:	910fe0ef          	jal	800026e0 <iunlock>
  iput(p->cwd);
    800045d4:	15093503          	ld	a0,336(s2)
    800045d8:	9dcfe0ef          	jal	800027b4 <iput>
  end_op();
    800045dc:	ac5fe0ef          	jal	800030a0 <end_op>
  p->cwd = ip;
    800045e0:	14993823          	sd	s1,336(s2)
  return 0;
    800045e4:	4501                	li	a0,0
    800045e6:	64aa                	ld	s1,136(sp)
}
    800045e8:	60ea                	ld	ra,152(sp)
    800045ea:	644a                	ld	s0,144(sp)
    800045ec:	690a                	ld	s2,128(sp)
    800045ee:	610d                	addi	sp,sp,160
    800045f0:	8082                	ret
    800045f2:	64aa                	ld	s1,136(sp)
    end_op();
    800045f4:	aadfe0ef          	jal	800030a0 <end_op>
    return -1;
    800045f8:	557d                	li	a0,-1
    800045fa:	b7fd                	j	800045e8 <sys_chdir+0x5c>
    iunlockput(ip);
    800045fc:	8526                	mv	a0,s1
    800045fe:	a3efe0ef          	jal	8000283c <iunlockput>
    end_op();
    80004602:	a9ffe0ef          	jal	800030a0 <end_op>
    return -1;
    80004606:	557d                	li	a0,-1
    80004608:	64aa                	ld	s1,136(sp)
    8000460a:	bff9                	j	800045e8 <sys_chdir+0x5c>

000000008000460c <sys_exec>:

uint64
sys_exec(void)
{
    8000460c:	7105                	addi	sp,sp,-480
    8000460e:	ef86                	sd	ra,472(sp)
    80004610:	eba2                	sd	s0,464(sp)
    80004612:	1380                	addi	s0,sp,480
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004614:	e2840593          	addi	a1,s0,-472
    80004618:	4505                	li	a0,1
    8000461a:	e6cfd0ef          	jal	80001c86 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    8000461e:	08000613          	li	a2,128
    80004622:	f3040593          	addi	a1,s0,-208
    80004626:	4501                	li	a0,0
    80004628:	e7afd0ef          	jal	80001ca2 <argstr>
    8000462c:	87aa                	mv	a5,a0
    return -1;
    8000462e:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80004630:	0e07c063          	bltz	a5,80004710 <sys_exec+0x104>
    80004634:	e7a6                	sd	s1,456(sp)
    80004636:	e3ca                	sd	s2,448(sp)
    80004638:	ff4e                	sd	s3,440(sp)
    8000463a:	fb52                	sd	s4,432(sp)
    8000463c:	f756                	sd	s5,424(sp)
    8000463e:	f35a                	sd	s6,416(sp)
    80004640:	ef5e                	sd	s7,408(sp)
  }
  memset(argv, 0, sizeof(argv));
    80004642:	e3040a13          	addi	s4,s0,-464
    80004646:	10000613          	li	a2,256
    8000464a:	4581                	li	a1,0
    8000464c:	8552                	mv	a0,s4
    8000464e:	b01fb0ef          	jal	8000014e <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004652:	84d2                	mv	s1,s4
  memset(argv, 0, sizeof(argv));
    80004654:	89d2                	mv	s3,s4
    80004656:	4901                	li	s2,0
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004658:	e2040a93          	addi	s5,s0,-480
      break;
    }
    argv[i] = kalloc();
    if(argv[i] == 0)
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    8000465c:	6b05                	lui	s6,0x1
    if(i >= NELEM(argv)){
    8000465e:	02000b93          	li	s7,32
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004662:	00391513          	slli	a0,s2,0x3
    80004666:	85d6                	mv	a1,s5
    80004668:	e2843783          	ld	a5,-472(s0)
    8000466c:	953e                	add	a0,a0,a5
    8000466e:	d72fd0ef          	jal	80001be0 <fetchaddr>
    80004672:	02054663          	bltz	a0,8000469e <sys_exec+0x92>
    if(uarg == 0){
    80004676:	e2043783          	ld	a5,-480(s0)
    8000467a:	c7a1                	beqz	a5,800046c2 <sys_exec+0xb6>
    argv[i] = kalloc();
    8000467c:	a83fb0ef          	jal	800000fe <kalloc>
    80004680:	85aa                	mv	a1,a0
    80004682:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004686:	cd01                	beqz	a0,8000469e <sys_exec+0x92>
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004688:	865a                	mv	a2,s6
    8000468a:	e2043503          	ld	a0,-480(s0)
    8000468e:	d9cfd0ef          	jal	80001c2a <fetchstr>
    80004692:	00054663          	bltz	a0,8000469e <sys_exec+0x92>
    if(i >= NELEM(argv)){
    80004696:	0905                	addi	s2,s2,1
    80004698:	09a1                	addi	s3,s3,8
    8000469a:	fd7914e3          	bne	s2,s7,80004662 <sys_exec+0x56>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    8000469e:	100a0a13          	addi	s4,s4,256
    800046a2:	6088                	ld	a0,0(s1)
    800046a4:	cd31                	beqz	a0,80004700 <sys_exec+0xf4>
    kfree(argv[i]);
    800046a6:	977fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046aa:	04a1                	addi	s1,s1,8
    800046ac:	ff449be3          	bne	s1,s4,800046a2 <sys_exec+0x96>
  return -1;
    800046b0:	557d                	li	a0,-1
    800046b2:	64be                	ld	s1,456(sp)
    800046b4:	691e                	ld	s2,448(sp)
    800046b6:	79fa                	ld	s3,440(sp)
    800046b8:	7a5a                	ld	s4,432(sp)
    800046ba:	7aba                	ld	s5,424(sp)
    800046bc:	7b1a                	ld	s6,416(sp)
    800046be:	6bfa                	ld	s7,408(sp)
    800046c0:	a881                	j	80004710 <sys_exec+0x104>
      argv[i] = 0;
    800046c2:	0009079b          	sext.w	a5,s2
    800046c6:	e3040593          	addi	a1,s0,-464
    800046ca:	078e                	slli	a5,a5,0x3
    800046cc:	97ae                	add	a5,a5,a1
    800046ce:	0007b023          	sd	zero,0(a5)
  int ret = kexec(path, argv);
    800046d2:	f3040513          	addi	a0,s0,-208
    800046d6:	ba4ff0ef          	jal	80003a7a <kexec>
    800046da:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046dc:	100a0a13          	addi	s4,s4,256
    800046e0:	6088                	ld	a0,0(s1)
    800046e2:	c511                	beqz	a0,800046ee <sys_exec+0xe2>
    kfree(argv[i]);
    800046e4:	939fb0ef          	jal	8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800046e8:	04a1                	addi	s1,s1,8
    800046ea:	ff449be3          	bne	s1,s4,800046e0 <sys_exec+0xd4>
  return ret;
    800046ee:	854a                	mv	a0,s2
    800046f0:	64be                	ld	s1,456(sp)
    800046f2:	691e                	ld	s2,448(sp)
    800046f4:	79fa                	ld	s3,440(sp)
    800046f6:	7a5a                	ld	s4,432(sp)
    800046f8:	7aba                	ld	s5,424(sp)
    800046fa:	7b1a                	ld	s6,416(sp)
    800046fc:	6bfa                	ld	s7,408(sp)
    800046fe:	a809                	j	80004710 <sys_exec+0x104>
  return -1;
    80004700:	557d                	li	a0,-1
    80004702:	64be                	ld	s1,456(sp)
    80004704:	691e                	ld	s2,448(sp)
    80004706:	79fa                	ld	s3,440(sp)
    80004708:	7a5a                	ld	s4,432(sp)
    8000470a:	7aba                	ld	s5,424(sp)
    8000470c:	7b1a                	ld	s6,416(sp)
    8000470e:	6bfa                	ld	s7,408(sp)
}
    80004710:	60fe                	ld	ra,472(sp)
    80004712:	645e                	ld	s0,464(sp)
    80004714:	613d                	addi	sp,sp,480
    80004716:	8082                	ret

0000000080004718 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004718:	7139                	addi	sp,sp,-64
    8000471a:	fc06                	sd	ra,56(sp)
    8000471c:	f822                	sd	s0,48(sp)
    8000471e:	f426                	sd	s1,40(sp)
    80004720:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004722:	e4efc0ef          	jal	80000d70 <myproc>
    80004726:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004728:	fd840593          	addi	a1,s0,-40
    8000472c:	4501                	li	a0,0
    8000472e:	d58fd0ef          	jal	80001c86 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80004732:	fc840593          	addi	a1,s0,-56
    80004736:	fd040513          	addi	a0,s0,-48
    8000473a:	81eff0ef          	jal	80003758 <pipealloc>
    return -1;
    8000473e:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004740:	0a054463          	bltz	a0,800047e8 <sys_pipe+0xd0>
  fd0 = -1;
    80004744:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004748:	fd043503          	ld	a0,-48(s0)
    8000474c:	edeff0ef          	jal	80003e2a <fdalloc>
    80004750:	fca42223          	sw	a0,-60(s0)
    80004754:	08054163          	bltz	a0,800047d6 <sys_pipe+0xbe>
    80004758:	fc843503          	ld	a0,-56(s0)
    8000475c:	eceff0ef          	jal	80003e2a <fdalloc>
    80004760:	fca42023          	sw	a0,-64(s0)
    80004764:	06054063          	bltz	a0,800047c4 <sys_pipe+0xac>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004768:	4691                	li	a3,4
    8000476a:	fc440613          	addi	a2,s0,-60
    8000476e:	fd843583          	ld	a1,-40(s0)
    80004772:	68a8                	ld	a0,80(s1)
    80004774:	b2efc0ef          	jal	80000aa2 <copyout>
    80004778:	00054e63          	bltz	a0,80004794 <sys_pipe+0x7c>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000477c:	4691                	li	a3,4
    8000477e:	fc040613          	addi	a2,s0,-64
    80004782:	fd843583          	ld	a1,-40(s0)
    80004786:	95b6                	add	a1,a1,a3
    80004788:	68a8                	ld	a0,80(s1)
    8000478a:	b18fc0ef          	jal	80000aa2 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    8000478e:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004790:	04055c63          	bgez	a0,800047e8 <sys_pipe+0xd0>
    p->ofile[fd0] = 0;
    80004794:	fc442783          	lw	a5,-60(s0)
    80004798:	07e9                	addi	a5,a5,26
    8000479a:	078e                	slli	a5,a5,0x3
    8000479c:	97a6                	add	a5,a5,s1
    8000479e:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800047a2:	fc042783          	lw	a5,-64(s0)
    800047a6:	07e9                	addi	a5,a5,26
    800047a8:	078e                	slli	a5,a5,0x3
    800047aa:	94be                	add	s1,s1,a5
    800047ac:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    800047b0:	fd043503          	ld	a0,-48(s0)
    800047b4:	c95fe0ef          	jal	80003448 <fileclose>
    fileclose(wf);
    800047b8:	fc843503          	ld	a0,-56(s0)
    800047bc:	c8dfe0ef          	jal	80003448 <fileclose>
    return -1;
    800047c0:	57fd                	li	a5,-1
    800047c2:	a01d                	j	800047e8 <sys_pipe+0xd0>
    if(fd0 >= 0)
    800047c4:	fc442783          	lw	a5,-60(s0)
    800047c8:	0007c763          	bltz	a5,800047d6 <sys_pipe+0xbe>
      p->ofile[fd0] = 0;
    800047cc:	07e9                	addi	a5,a5,26
    800047ce:	078e                	slli	a5,a5,0x3
    800047d0:	97a6                	add	a5,a5,s1
    800047d2:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800047d6:	fd043503          	ld	a0,-48(s0)
    800047da:	c6ffe0ef          	jal	80003448 <fileclose>
    fileclose(wf);
    800047de:	fc843503          	ld	a0,-56(s0)
    800047e2:	c67fe0ef          	jal	80003448 <fileclose>
    return -1;
    800047e6:	57fd                	li	a5,-1
}
    800047e8:	853e                	mv	a0,a5
    800047ea:	70e2                	ld	ra,56(sp)
    800047ec:	7442                	ld	s0,48(sp)
    800047ee:	74a2                	ld	s1,40(sp)
    800047f0:	6121                	addi	sp,sp,64
    800047f2:	8082                	ret
	...

0000000080004800 <kernelvec>:
.globl kerneltrap
.globl kernelvec
.align 4
kernelvec:
        # make room to save registers.
        addi sp, sp, -256
    80004800:	7111                	addi	sp,sp,-256

        # save caller-saved registers.
        sd ra, 0(sp)
    80004802:	e006                	sd	ra,0(sp)
        # sd sp, 8(sp)
        sd gp, 16(sp)
    80004804:	e80e                	sd	gp,16(sp)
        sd tp, 24(sp)
    80004806:	ec12                	sd	tp,24(sp)
        sd t0, 32(sp)
    80004808:	f016                	sd	t0,32(sp)
        sd t1, 40(sp)
    8000480a:	f41a                	sd	t1,40(sp)
        sd t2, 48(sp)
    8000480c:	f81e                	sd	t2,48(sp)
        sd a0, 72(sp)
    8000480e:	e4aa                	sd	a0,72(sp)
        sd a1, 80(sp)
    80004810:	e8ae                	sd	a1,80(sp)
        sd a2, 88(sp)
    80004812:	ecb2                	sd	a2,88(sp)
        sd a3, 96(sp)
    80004814:	f0b6                	sd	a3,96(sp)
        sd a4, 104(sp)
    80004816:	f4ba                	sd	a4,104(sp)
        sd a5, 112(sp)
    80004818:	f8be                	sd	a5,112(sp)
        sd a6, 120(sp)
    8000481a:	fcc2                	sd	a6,120(sp)
        sd a7, 128(sp)
    8000481c:	e146                	sd	a7,128(sp)
        sd t3, 216(sp)
    8000481e:	edf2                	sd	t3,216(sp)
        sd t4, 224(sp)
    80004820:	f1f6                	sd	t4,224(sp)
        sd t5, 232(sp)
    80004822:	f5fa                	sd	t5,232(sp)
        sd t6, 240(sp)
    80004824:	f9fe                	sd	t6,240(sp)

        # call the C trap handler in trap.c
        call kerneltrap
    80004826:	acafd0ef          	jal	80001af0 <kerneltrap>

        # restore registers.
        ld ra, 0(sp)
    8000482a:	6082                	ld	ra,0(sp)
        # ld sp, 8(sp)
        ld gp, 16(sp)
    8000482c:	61c2                	ld	gp,16(sp)
        # not tp (contains hartid), in case we moved CPUs
        ld t0, 32(sp)
    8000482e:	7282                	ld	t0,32(sp)
        ld t1, 40(sp)
    80004830:	7322                	ld	t1,40(sp)
        ld t2, 48(sp)
    80004832:	73c2                	ld	t2,48(sp)
        ld a0, 72(sp)
    80004834:	6526                	ld	a0,72(sp)
        ld a1, 80(sp)
    80004836:	65c6                	ld	a1,80(sp)
        ld a2, 88(sp)
    80004838:	6666                	ld	a2,88(sp)
        ld a3, 96(sp)
    8000483a:	7686                	ld	a3,96(sp)
        ld a4, 104(sp)
    8000483c:	7726                	ld	a4,104(sp)
        ld a5, 112(sp)
    8000483e:	77c6                	ld	a5,112(sp)
        ld a6, 120(sp)
    80004840:	7866                	ld	a6,120(sp)
        ld a7, 128(sp)
    80004842:	688a                	ld	a7,128(sp)
        ld t3, 216(sp)
    80004844:	6e6e                	ld	t3,216(sp)
        ld t4, 224(sp)
    80004846:	7e8e                	ld	t4,224(sp)
        ld t5, 232(sp)
    80004848:	7f2e                	ld	t5,232(sp)
        ld t6, 240(sp)
    8000484a:	7fce                	ld	t6,240(sp)

        addi sp, sp, 256
    8000484c:	6111                	addi	sp,sp,256

        # return to whatever we were doing in the kernel.
        sret
    8000484e:	10200073          	sret
    80004852:	00000013          	nop
    80004856:	00000013          	nop
    8000485a:	00000013          	nop

000000008000485e <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000485e:	1141                	addi	sp,sp,-16
    80004860:	e406                	sd	ra,8(sp)
    80004862:	e022                	sd	s0,0(sp)
    80004864:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80004866:	0c000737          	lui	a4,0xc000
    8000486a:	4785                	li	a5,1
    8000486c:	d71c                	sw	a5,40(a4)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    8000486e:	c35c                	sw	a5,4(a4)
}
    80004870:	60a2                	ld	ra,8(sp)
    80004872:	6402                	ld	s0,0(sp)
    80004874:	0141                	addi	sp,sp,16
    80004876:	8082                	ret

0000000080004878 <plicinithart>:

void
plicinithart(void)
{
    80004878:	1141                	addi	sp,sp,-16
    8000487a:	e406                	sd	ra,8(sp)
    8000487c:	e022                	sd	s0,0(sp)
    8000487e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80004880:	cbcfc0ef          	jal	80000d3c <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80004884:	0085171b          	slliw	a4,a0,0x8
    80004888:	0c0027b7          	lui	a5,0xc002
    8000488c:	97ba                	add	a5,a5,a4
    8000488e:	40200713          	li	a4,1026
    80004892:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80004896:	00d5151b          	slliw	a0,a0,0xd
    8000489a:	0c2017b7          	lui	a5,0xc201
    8000489e:	97aa                	add	a5,a5,a0
    800048a0:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800048a4:	60a2                	ld	ra,8(sp)
    800048a6:	6402                	ld	s0,0(sp)
    800048a8:	0141                	addi	sp,sp,16
    800048aa:	8082                	ret

00000000800048ac <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800048ac:	1141                	addi	sp,sp,-16
    800048ae:	e406                	sd	ra,8(sp)
    800048b0:	e022                	sd	s0,0(sp)
    800048b2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800048b4:	c88fc0ef          	jal	80000d3c <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800048b8:	00d5151b          	slliw	a0,a0,0xd
    800048bc:	0c2017b7          	lui	a5,0xc201
    800048c0:	97aa                	add	a5,a5,a0
  return irq;
}
    800048c2:	43c8                	lw	a0,4(a5)
    800048c4:	60a2                	ld	ra,8(sp)
    800048c6:	6402                	ld	s0,0(sp)
    800048c8:	0141                	addi	sp,sp,16
    800048ca:	8082                	ret

00000000800048cc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800048cc:	1101                	addi	sp,sp,-32
    800048ce:	ec06                	sd	ra,24(sp)
    800048d0:	e822                	sd	s0,16(sp)
    800048d2:	e426                	sd	s1,8(sp)
    800048d4:	1000                	addi	s0,sp,32
    800048d6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800048d8:	c64fc0ef          	jal	80000d3c <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800048dc:	00d5179b          	slliw	a5,a0,0xd
    800048e0:	0c201737          	lui	a4,0xc201
    800048e4:	97ba                	add	a5,a5,a4
    800048e6:	c3c4                	sw	s1,4(a5)
}
    800048e8:	60e2                	ld	ra,24(sp)
    800048ea:	6442                	ld	s0,16(sp)
    800048ec:	64a2                	ld	s1,8(sp)
    800048ee:	6105                	addi	sp,sp,32
    800048f0:	8082                	ret

00000000800048f2 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800048f2:	1141                	addi	sp,sp,-16
    800048f4:	e406                	sd	ra,8(sp)
    800048f6:	e022                	sd	s0,0(sp)
    800048f8:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800048fa:	479d                	li	a5,7
    800048fc:	04a7ca63          	blt	a5,a0,80004950 <free_desc+0x5e>
    panic("free_desc 1");
  if(disk.free[i])
    80004900:	00017797          	auipc	a5,0x17
    80004904:	a3078793          	addi	a5,a5,-1488 # 8001b330 <disk>
    80004908:	97aa                	add	a5,a5,a0
    8000490a:	0187c783          	lbu	a5,24(a5)
    8000490e:	e7b9                	bnez	a5,8000495c <free_desc+0x6a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80004910:	00451693          	slli	a3,a0,0x4
    80004914:	00017797          	auipc	a5,0x17
    80004918:	a1c78793          	addi	a5,a5,-1508 # 8001b330 <disk>
    8000491c:	6398                	ld	a4,0(a5)
    8000491e:	9736                	add	a4,a4,a3
    80004920:	00073023          	sd	zero,0(a4) # c201000 <_entry-0x73dff000>
  disk.desc[i].len = 0;
    80004924:	6398                	ld	a4,0(a5)
    80004926:	9736                	add	a4,a4,a3
    80004928:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    8000492c:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80004930:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80004934:	97aa                	add	a5,a5,a0
    80004936:	4705                	li	a4,1
    80004938:	00e78c23          	sb	a4,24(a5)
  wakeup(&disk.free[0]);
    8000493c:	00017517          	auipc	a0,0x17
    80004940:	a0c50513          	addi	a0,a0,-1524 # 8001b348 <disk+0x18>
    80004944:	a71fc0ef          	jal	800013b4 <wakeup>
}
    80004948:	60a2                	ld	ra,8(sp)
    8000494a:	6402                	ld	s0,0(sp)
    8000494c:	0141                	addi	sp,sp,16
    8000494e:	8082                	ret
    panic("free_desc 1");
    80004950:	00003517          	auipc	a0,0x3
    80004954:	c6050513          	addi	a0,a0,-928 # 800075b0 <etext+0x5b0>
    80004958:	44f000ef          	jal	800055a6 <panic>
    panic("free_desc 2");
    8000495c:	00003517          	auipc	a0,0x3
    80004960:	c6450513          	addi	a0,a0,-924 # 800075c0 <etext+0x5c0>
    80004964:	443000ef          	jal	800055a6 <panic>

0000000080004968 <virtio_disk_init>:
{
    80004968:	1101                	addi	sp,sp,-32
    8000496a:	ec06                	sd	ra,24(sp)
    8000496c:	e822                	sd	s0,16(sp)
    8000496e:	e426                	sd	s1,8(sp)
    80004970:	e04a                	sd	s2,0(sp)
    80004972:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80004974:	00003597          	auipc	a1,0x3
    80004978:	c5c58593          	addi	a1,a1,-932 # 800075d0 <etext+0x5d0>
    8000497c:	00017517          	auipc	a0,0x17
    80004980:	adc50513          	addi	a0,a0,-1316 # 8001b458 <disk+0x128>
    80004984:	65b000ef          	jal	800057de <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80004988:	100017b7          	lui	a5,0x10001
    8000498c:	4398                	lw	a4,0(a5)
    8000498e:	2701                	sext.w	a4,a4
    80004990:	747277b7          	lui	a5,0x74727
    80004994:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80004998:	14f71863          	bne	a4,a5,80004ae8 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    8000499c:	100017b7          	lui	a5,0x10001
    800049a0:	43dc                	lw	a5,4(a5)
    800049a2:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800049a4:	4709                	li	a4,2
    800049a6:	14e79163          	bne	a5,a4,80004ae8 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800049aa:	100017b7          	lui	a5,0x10001
    800049ae:	479c                	lw	a5,8(a5)
    800049b0:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800049b2:	12e79b63          	bne	a5,a4,80004ae8 <virtio_disk_init+0x180>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800049b6:	100017b7          	lui	a5,0x10001
    800049ba:	47d8                	lw	a4,12(a5)
    800049bc:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800049be:	554d47b7          	lui	a5,0x554d4
    800049c2:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800049c6:	12f71163          	bne	a4,a5,80004ae8 <virtio_disk_init+0x180>
  *R(VIRTIO_MMIO_STATUS) = status;
    800049ca:	100017b7          	lui	a5,0x10001
    800049ce:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800049d2:	4705                	li	a4,1
    800049d4:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800049d6:	470d                	li	a4,3
    800049d8:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800049da:	10001737          	lui	a4,0x10001
    800049de:	4b18                	lw	a4,16(a4)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800049e0:	c7ffe6b7          	lui	a3,0xc7ffe
    800049e4:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fdb217>
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800049e8:	8f75                	and	a4,a4,a3
    800049ea:	100016b7          	lui	a3,0x10001
    800049ee:	d298                	sw	a4,32(a3)
  *R(VIRTIO_MMIO_STATUS) = status;
    800049f0:	472d                	li	a4,11
    800049f2:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800049f4:	07078793          	addi	a5,a5,112
  status = *R(VIRTIO_MMIO_STATUS);
    800049f8:	439c                	lw	a5,0(a5)
    800049fa:	0007891b          	sext.w	s2,a5
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    800049fe:	8ba1                	andi	a5,a5,8
    80004a00:	0e078a63          	beqz	a5,80004af4 <virtio_disk_init+0x18c>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80004a04:	100017b7          	lui	a5,0x10001
    80004a08:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80004a0c:	43fc                	lw	a5,68(a5)
    80004a0e:	2781                	sext.w	a5,a5
    80004a10:	0e079863          	bnez	a5,80004b00 <virtio_disk_init+0x198>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80004a14:	100017b7          	lui	a5,0x10001
    80004a18:	5bdc                	lw	a5,52(a5)
    80004a1a:	2781                	sext.w	a5,a5
  if(max == 0)
    80004a1c:	0e078863          	beqz	a5,80004b0c <virtio_disk_init+0x1a4>
  if(max < NUM)
    80004a20:	471d                	li	a4,7
    80004a22:	0ef77b63          	bgeu	a4,a5,80004b18 <virtio_disk_init+0x1b0>
  disk.desc = kalloc();
    80004a26:	ed8fb0ef          	jal	800000fe <kalloc>
    80004a2a:	00017497          	auipc	s1,0x17
    80004a2e:	90648493          	addi	s1,s1,-1786 # 8001b330 <disk>
    80004a32:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80004a34:	ecafb0ef          	jal	800000fe <kalloc>
    80004a38:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    80004a3a:	ec4fb0ef          	jal	800000fe <kalloc>
    80004a3e:	87aa                	mv	a5,a0
    80004a40:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    80004a42:	6088                	ld	a0,0(s1)
    80004a44:	0e050063          	beqz	a0,80004b24 <virtio_disk_init+0x1bc>
    80004a48:	00017717          	auipc	a4,0x17
    80004a4c:	8f073703          	ld	a4,-1808(a4) # 8001b338 <disk+0x8>
    80004a50:	cb71                	beqz	a4,80004b24 <virtio_disk_init+0x1bc>
    80004a52:	cbe9                	beqz	a5,80004b24 <virtio_disk_init+0x1bc>
  memset(disk.desc, 0, PGSIZE);
    80004a54:	6605                	lui	a2,0x1
    80004a56:	4581                	li	a1,0
    80004a58:	ef6fb0ef          	jal	8000014e <memset>
  memset(disk.avail, 0, PGSIZE);
    80004a5c:	00017497          	auipc	s1,0x17
    80004a60:	8d448493          	addi	s1,s1,-1836 # 8001b330 <disk>
    80004a64:	6605                	lui	a2,0x1
    80004a66:	4581                	li	a1,0
    80004a68:	6488                	ld	a0,8(s1)
    80004a6a:	ee4fb0ef          	jal	8000014e <memset>
  memset(disk.used, 0, PGSIZE);
    80004a6e:	6605                	lui	a2,0x1
    80004a70:	4581                	li	a1,0
    80004a72:	6888                	ld	a0,16(s1)
    80004a74:	edafb0ef          	jal	8000014e <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80004a78:	100017b7          	lui	a5,0x10001
    80004a7c:	4721                	li	a4,8
    80004a7e:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    80004a80:	4098                	lw	a4,0(s1)
    80004a82:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    80004a86:	40d8                	lw	a4,4(s1)
    80004a88:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    80004a8c:	649c                	ld	a5,8(s1)
    80004a8e:	0007869b          	sext.w	a3,a5
    80004a92:	10001737          	lui	a4,0x10001
    80004a96:	08d72823          	sw	a3,144(a4) # 10001090 <_entry-0x6fffef70>
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    80004a9a:	9781                	srai	a5,a5,0x20
    80004a9c:	08f72a23          	sw	a5,148(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    80004aa0:	689c                	ld	a5,16(s1)
    80004aa2:	0007869b          	sext.w	a3,a5
    80004aa6:	0ad72023          	sw	a3,160(a4)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    80004aaa:	9781                	srai	a5,a5,0x20
    80004aac:	0af72223          	sw	a5,164(a4)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    80004ab0:	4785                	li	a5,1
    80004ab2:	c37c                	sw	a5,68(a4)
    disk.free[i] = 1;
    80004ab4:	00f48c23          	sb	a5,24(s1)
    80004ab8:	00f48ca3          	sb	a5,25(s1)
    80004abc:	00f48d23          	sb	a5,26(s1)
    80004ac0:	00f48da3          	sb	a5,27(s1)
    80004ac4:	00f48e23          	sb	a5,28(s1)
    80004ac8:	00f48ea3          	sb	a5,29(s1)
    80004acc:	00f48f23          	sb	a5,30(s1)
    80004ad0:	00f48fa3          	sb	a5,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    80004ad4:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    80004ad8:	07272823          	sw	s2,112(a4)
}
    80004adc:	60e2                	ld	ra,24(sp)
    80004ade:	6442                	ld	s0,16(sp)
    80004ae0:	64a2                	ld	s1,8(sp)
    80004ae2:	6902                	ld	s2,0(sp)
    80004ae4:	6105                	addi	sp,sp,32
    80004ae6:	8082                	ret
    panic("could not find virtio disk");
    80004ae8:	00003517          	auipc	a0,0x3
    80004aec:	af850513          	addi	a0,a0,-1288 # 800075e0 <etext+0x5e0>
    80004af0:	2b7000ef          	jal	800055a6 <panic>
    panic("virtio disk FEATURES_OK unset");
    80004af4:	00003517          	auipc	a0,0x3
    80004af8:	b0c50513          	addi	a0,a0,-1268 # 80007600 <etext+0x600>
    80004afc:	2ab000ef          	jal	800055a6 <panic>
    panic("virtio disk should not be ready");
    80004b00:	00003517          	auipc	a0,0x3
    80004b04:	b2050513          	addi	a0,a0,-1248 # 80007620 <etext+0x620>
    80004b08:	29f000ef          	jal	800055a6 <panic>
    panic("virtio disk has no queue 0");
    80004b0c:	00003517          	auipc	a0,0x3
    80004b10:	b3450513          	addi	a0,a0,-1228 # 80007640 <etext+0x640>
    80004b14:	293000ef          	jal	800055a6 <panic>
    panic("virtio disk max queue too short");
    80004b18:	00003517          	auipc	a0,0x3
    80004b1c:	b4850513          	addi	a0,a0,-1208 # 80007660 <etext+0x660>
    80004b20:	287000ef          	jal	800055a6 <panic>
    panic("virtio disk kalloc");
    80004b24:	00003517          	auipc	a0,0x3
    80004b28:	b5c50513          	addi	a0,a0,-1188 # 80007680 <etext+0x680>
    80004b2c:	27b000ef          	jal	800055a6 <panic>

0000000080004b30 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80004b30:	711d                	addi	sp,sp,-96
    80004b32:	ec86                	sd	ra,88(sp)
    80004b34:	e8a2                	sd	s0,80(sp)
    80004b36:	e4a6                	sd	s1,72(sp)
    80004b38:	e0ca                	sd	s2,64(sp)
    80004b3a:	fc4e                	sd	s3,56(sp)
    80004b3c:	f852                	sd	s4,48(sp)
    80004b3e:	f456                	sd	s5,40(sp)
    80004b40:	f05a                	sd	s6,32(sp)
    80004b42:	ec5e                	sd	s7,24(sp)
    80004b44:	e862                	sd	s8,16(sp)
    80004b46:	1080                	addi	s0,sp,96
    80004b48:	89aa                	mv	s3,a0
    80004b4a:	8b2e                	mv	s6,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80004b4c:	00c52b83          	lw	s7,12(a0)
    80004b50:	001b9b9b          	slliw	s7,s7,0x1
    80004b54:	1b82                	slli	s7,s7,0x20
    80004b56:	020bdb93          	srli	s7,s7,0x20

  acquire(&disk.vdisk_lock);
    80004b5a:	00017517          	auipc	a0,0x17
    80004b5e:	8fe50513          	addi	a0,a0,-1794 # 8001b458 <disk+0x128>
    80004b62:	501000ef          	jal	80005862 <acquire>
  for(int i = 0; i < NUM; i++){
    80004b66:	44a1                	li	s1,8
      disk.free[i] = 0;
    80004b68:	00016a97          	auipc	s5,0x16
    80004b6c:	7c8a8a93          	addi	s5,s5,1992 # 8001b330 <disk>
  for(int i = 0; i < 3; i++){
    80004b70:	4a0d                	li	s4,3
    idx[i] = alloc_desc();
    80004b72:	5c7d                	li	s8,-1
    80004b74:	a095                	j	80004bd8 <virtio_disk_rw+0xa8>
      disk.free[i] = 0;
    80004b76:	00fa8733          	add	a4,s5,a5
    80004b7a:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    80004b7e:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80004b80:	0207c563          	bltz	a5,80004baa <virtio_disk_rw+0x7a>
  for(int i = 0; i < 3; i++){
    80004b84:	2905                	addiw	s2,s2,1
    80004b86:	0611                	addi	a2,a2,4 # 1004 <_entry-0x7fffeffc>
    80004b88:	05490c63          	beq	s2,s4,80004be0 <virtio_disk_rw+0xb0>
    idx[i] = alloc_desc();
    80004b8c:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    80004b8e:	00016717          	auipc	a4,0x16
    80004b92:	7a270713          	addi	a4,a4,1954 # 8001b330 <disk>
    80004b96:	4781                	li	a5,0
    if(disk.free[i]){
    80004b98:	01874683          	lbu	a3,24(a4)
    80004b9c:	fee9                	bnez	a3,80004b76 <virtio_disk_rw+0x46>
  for(int i = 0; i < NUM; i++){
    80004b9e:	2785                	addiw	a5,a5,1
    80004ba0:	0705                	addi	a4,a4,1
    80004ba2:	fe979be3          	bne	a5,s1,80004b98 <virtio_disk_rw+0x68>
    idx[i] = alloc_desc();
    80004ba6:	0185a023          	sw	s8,0(a1)
      for(int j = 0; j < i; j++)
    80004baa:	01205d63          	blez	s2,80004bc4 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004bae:	fa042503          	lw	a0,-96(s0)
    80004bb2:	d41ff0ef          	jal	800048f2 <free_desc>
      for(int j = 0; j < i; j++)
    80004bb6:	4785                	li	a5,1
    80004bb8:	0127d663          	bge	a5,s2,80004bc4 <virtio_disk_rw+0x94>
        free_desc(idx[j]);
    80004bbc:	fa442503          	lw	a0,-92(s0)
    80004bc0:	d33ff0ef          	jal	800048f2 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80004bc4:	00017597          	auipc	a1,0x17
    80004bc8:	89458593          	addi	a1,a1,-1900 # 8001b458 <disk+0x128>
    80004bcc:	00016517          	auipc	a0,0x16
    80004bd0:	77c50513          	addi	a0,a0,1916 # 8001b348 <disk+0x18>
    80004bd4:	f94fc0ef          	jal	80001368 <sleep>
  for(int i = 0; i < 3; i++){
    80004bd8:	fa040613          	addi	a2,s0,-96
    80004bdc:	4901                	li	s2,0
    80004bde:	b77d                	j	80004b8c <virtio_disk_rw+0x5c>
  }

  // format the three descriptors.
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004be0:	fa042503          	lw	a0,-96(s0)
    80004be4:	00451693          	slli	a3,a0,0x4

  if(write)
    80004be8:	00016797          	auipc	a5,0x16
    80004bec:	74878793          	addi	a5,a5,1864 # 8001b330 <disk>
    80004bf0:	00a50713          	addi	a4,a0,10
    80004bf4:	0712                	slli	a4,a4,0x4
    80004bf6:	973e                	add	a4,a4,a5
    80004bf8:	01603633          	snez	a2,s6
    80004bfc:	c710                	sw	a2,8(a4)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80004bfe:	00072623          	sw	zero,12(a4)
  buf0->sector = sector;
    80004c02:	01773823          	sd	s7,16(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80004c06:	6398                	ld	a4,0(a5)
    80004c08:	9736                	add	a4,a4,a3
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80004c0a:	0a868613          	addi	a2,a3,168 # 100010a8 <_entry-0x6fffef58>
    80004c0e:	963e                	add	a2,a2,a5
  disk.desc[idx[0]].addr = (uint64) buf0;
    80004c10:	e310                	sd	a2,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80004c12:	6390                	ld	a2,0(a5)
    80004c14:	00d605b3          	add	a1,a2,a3
    80004c18:	4741                	li	a4,16
    80004c1a:	c598                	sw	a4,8(a1)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80004c1c:	4805                	li	a6,1
    80004c1e:	01059623          	sh	a6,12(a1)
  disk.desc[idx[0]].next = idx[1];
    80004c22:	fa442703          	lw	a4,-92(s0)
    80004c26:	00e59723          	sh	a4,14(a1)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80004c2a:	0712                	slli	a4,a4,0x4
    80004c2c:	963a                	add	a2,a2,a4
    80004c2e:	05898593          	addi	a1,s3,88
    80004c32:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80004c34:	0007b883          	ld	a7,0(a5)
    80004c38:	9746                	add	a4,a4,a7
    80004c3a:	40000613          	li	a2,1024
    80004c3e:	c710                	sw	a2,8(a4)
  if(write)
    80004c40:	001b3613          	seqz	a2,s6
    80004c44:	0016161b          	slliw	a2,a2,0x1
    disk.desc[idx[1]].flags = 0; // device reads b->data
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80004c48:	01066633          	or	a2,a2,a6
    80004c4c:	00c71623          	sh	a2,12(a4)
  disk.desc[idx[1]].next = idx[2];
    80004c50:	fa842583          	lw	a1,-88(s0)
    80004c54:	00b71723          	sh	a1,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80004c58:	00250613          	addi	a2,a0,2
    80004c5c:	0612                	slli	a2,a2,0x4
    80004c5e:	963e                	add	a2,a2,a5
    80004c60:	577d                	li	a4,-1
    80004c62:	00e60823          	sb	a4,16(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80004c66:	0592                	slli	a1,a1,0x4
    80004c68:	98ae                	add	a7,a7,a1
    80004c6a:	03068713          	addi	a4,a3,48
    80004c6e:	973e                	add	a4,a4,a5
    80004c70:	00e8b023          	sd	a4,0(a7)
  disk.desc[idx[2]].len = 1;
    80004c74:	6398                	ld	a4,0(a5)
    80004c76:	972e                	add	a4,a4,a1
    80004c78:	01072423          	sw	a6,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80004c7c:	4689                	li	a3,2
    80004c7e:	00d71623          	sh	a3,12(a4)
  disk.desc[idx[2]].next = 0;
    80004c82:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80004c86:	0109a223          	sw	a6,4(s3)
  disk.info[idx[0]].b = b;
    80004c8a:	01363423          	sd	s3,8(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80004c8e:	6794                	ld	a3,8(a5)
    80004c90:	0026d703          	lhu	a4,2(a3)
    80004c94:	8b1d                	andi	a4,a4,7
    80004c96:	0706                	slli	a4,a4,0x1
    80004c98:	96ba                	add	a3,a3,a4
    80004c9a:	00a69223          	sh	a0,4(a3)

  __sync_synchronize();
    80004c9e:	0330000f          	fence	rw,rw

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80004ca2:	6798                	ld	a4,8(a5)
    80004ca4:	00275783          	lhu	a5,2(a4)
    80004ca8:	2785                	addiw	a5,a5,1
    80004caa:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80004cae:	0330000f          	fence	rw,rw

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80004cb2:	100017b7          	lui	a5,0x10001
    80004cb6:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80004cba:	0049a783          	lw	a5,4(s3)
    sleep(b, &disk.vdisk_lock);
    80004cbe:	00016917          	auipc	s2,0x16
    80004cc2:	79a90913          	addi	s2,s2,1946 # 8001b458 <disk+0x128>
  while(b->disk == 1) {
    80004cc6:	84c2                	mv	s1,a6
    80004cc8:	01079a63          	bne	a5,a6,80004cdc <virtio_disk_rw+0x1ac>
    sleep(b, &disk.vdisk_lock);
    80004ccc:	85ca                	mv	a1,s2
    80004cce:	854e                	mv	a0,s3
    80004cd0:	e98fc0ef          	jal	80001368 <sleep>
  while(b->disk == 1) {
    80004cd4:	0049a783          	lw	a5,4(s3)
    80004cd8:	fe978ae3          	beq	a5,s1,80004ccc <virtio_disk_rw+0x19c>
  }

  disk.info[idx[0]].b = 0;
    80004cdc:	fa042903          	lw	s2,-96(s0)
    80004ce0:	00290713          	addi	a4,s2,2
    80004ce4:	0712                	slli	a4,a4,0x4
    80004ce6:	00016797          	auipc	a5,0x16
    80004cea:	64a78793          	addi	a5,a5,1610 # 8001b330 <disk>
    80004cee:	97ba                	add	a5,a5,a4
    80004cf0:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    80004cf4:	00016997          	auipc	s3,0x16
    80004cf8:	63c98993          	addi	s3,s3,1596 # 8001b330 <disk>
    80004cfc:	00491713          	slli	a4,s2,0x4
    80004d00:	0009b783          	ld	a5,0(s3)
    80004d04:	97ba                	add	a5,a5,a4
    80004d06:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80004d0a:	854a                	mv	a0,s2
    80004d0c:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80004d10:	be3ff0ef          	jal	800048f2 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80004d14:	8885                	andi	s1,s1,1
    80004d16:	f0fd                	bnez	s1,80004cfc <virtio_disk_rw+0x1cc>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80004d18:	00016517          	auipc	a0,0x16
    80004d1c:	74050513          	addi	a0,a0,1856 # 8001b458 <disk+0x128>
    80004d20:	3d7000ef          	jal	800058f6 <release>
}
    80004d24:	60e6                	ld	ra,88(sp)
    80004d26:	6446                	ld	s0,80(sp)
    80004d28:	64a6                	ld	s1,72(sp)
    80004d2a:	6906                	ld	s2,64(sp)
    80004d2c:	79e2                	ld	s3,56(sp)
    80004d2e:	7a42                	ld	s4,48(sp)
    80004d30:	7aa2                	ld	s5,40(sp)
    80004d32:	7b02                	ld	s6,32(sp)
    80004d34:	6be2                	ld	s7,24(sp)
    80004d36:	6c42                	ld	s8,16(sp)
    80004d38:	6125                	addi	sp,sp,96
    80004d3a:	8082                	ret

0000000080004d3c <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80004d3c:	1101                	addi	sp,sp,-32
    80004d3e:	ec06                	sd	ra,24(sp)
    80004d40:	e822                	sd	s0,16(sp)
    80004d42:	e426                	sd	s1,8(sp)
    80004d44:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80004d46:	00016497          	auipc	s1,0x16
    80004d4a:	5ea48493          	addi	s1,s1,1514 # 8001b330 <disk>
    80004d4e:	00016517          	auipc	a0,0x16
    80004d52:	70a50513          	addi	a0,a0,1802 # 8001b458 <disk+0x128>
    80004d56:	30d000ef          	jal	80005862 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80004d5a:	100017b7          	lui	a5,0x10001
    80004d5e:	53bc                	lw	a5,96(a5)
    80004d60:	8b8d                	andi	a5,a5,3
    80004d62:	10001737          	lui	a4,0x10001
    80004d66:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80004d68:	0330000f          	fence	rw,rw

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80004d6c:	689c                	ld	a5,16(s1)
    80004d6e:	0204d703          	lhu	a4,32(s1)
    80004d72:	0027d783          	lhu	a5,2(a5) # 10001002 <_entry-0x6fffeffe>
    80004d76:	04f70663          	beq	a4,a5,80004dc2 <virtio_disk_intr+0x86>
    __sync_synchronize();
    80004d7a:	0330000f          	fence	rw,rw
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80004d7e:	6898                	ld	a4,16(s1)
    80004d80:	0204d783          	lhu	a5,32(s1)
    80004d84:	8b9d                	andi	a5,a5,7
    80004d86:	078e                	slli	a5,a5,0x3
    80004d88:	97ba                	add	a5,a5,a4
    80004d8a:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80004d8c:	00278713          	addi	a4,a5,2
    80004d90:	0712                	slli	a4,a4,0x4
    80004d92:	9726                	add	a4,a4,s1
    80004d94:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80004d98:	e321                	bnez	a4,80004dd8 <virtio_disk_intr+0x9c>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80004d9a:	0789                	addi	a5,a5,2
    80004d9c:	0792                	slli	a5,a5,0x4
    80004d9e:	97a6                	add	a5,a5,s1
    80004da0:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    80004da2:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80004da6:	e0efc0ef          	jal	800013b4 <wakeup>

    disk.used_idx += 1;
    80004daa:	0204d783          	lhu	a5,32(s1)
    80004dae:	2785                	addiw	a5,a5,1
    80004db0:	17c2                	slli	a5,a5,0x30
    80004db2:	93c1                	srli	a5,a5,0x30
    80004db4:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80004db8:	6898                	ld	a4,16(s1)
    80004dba:	00275703          	lhu	a4,2(a4)
    80004dbe:	faf71ee3          	bne	a4,a5,80004d7a <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80004dc2:	00016517          	auipc	a0,0x16
    80004dc6:	69650513          	addi	a0,a0,1686 # 8001b458 <disk+0x128>
    80004dca:	32d000ef          	jal	800058f6 <release>
}
    80004dce:	60e2                	ld	ra,24(sp)
    80004dd0:	6442                	ld	s0,16(sp)
    80004dd2:	64a2                	ld	s1,8(sp)
    80004dd4:	6105                	addi	sp,sp,32
    80004dd6:	8082                	ret
      panic("virtio_disk_intr status");
    80004dd8:	00003517          	auipc	a0,0x3
    80004ddc:	8c050513          	addi	a0,a0,-1856 # 80007698 <etext+0x698>
    80004de0:	7c6000ef          	jal	800055a6 <panic>

0000000080004de4 <timerinit>:
}

// ask each hart to generate timer interrupts.
void
timerinit()
{
    80004de4:	1141                	addi	sp,sp,-16
    80004de6:	e406                	sd	ra,8(sp)
    80004de8:	e022                	sd	s0,0(sp)
    80004dea:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mie" : "=r" (x) );
    80004dec:	304027f3          	csrr	a5,mie
  // enable supervisor-mode timer interrupts.
  w_mie(r_mie() | MIE_STIE);
    80004df0:	0207e793          	ori	a5,a5,32
  asm volatile("csrw mie, %0" : : "r" (x));
    80004df4:	30479073          	csrw	mie,a5
  asm volatile("csrr %0, 0x30a" : "=r" (x) );
    80004df8:	30a027f3          	csrr	a5,0x30a
  
  // enable the sstc extension (i.e. stimecmp).
  w_menvcfg(r_menvcfg() | (1L << 63)); 
    80004dfc:	577d                	li	a4,-1
    80004dfe:	177e                	slli	a4,a4,0x3f
    80004e00:	8fd9                	or	a5,a5,a4
  asm volatile("csrw 0x30a, %0" : : "r" (x));
    80004e02:	30a79073          	csrw	0x30a,a5
  asm volatile("csrr %0, mcounteren" : "=r" (x) );
    80004e06:	306027f3          	csrr	a5,mcounteren
  
  // allow supervisor to use stimecmp and time.
  w_mcounteren(r_mcounteren() | 2);
    80004e0a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw mcounteren, %0" : : "r" (x));
    80004e0e:	30679073          	csrw	mcounteren,a5
  asm volatile("csrr %0, time" : "=r" (x) );
    80004e12:	c01027f3          	rdtime	a5
  
  // ask for the very first timer interrupt.
  w_stimecmp(r_time() + 1000000);
    80004e16:	000f4737          	lui	a4,0xf4
    80004e1a:	24070713          	addi	a4,a4,576 # f4240 <_entry-0x7ff0bdc0>
    80004e1e:	97ba                	add	a5,a5,a4
  asm volatile("csrw 0x14d, %0" : : "r" (x));
    80004e20:	14d79073          	csrw	stimecmp,a5
}
    80004e24:	60a2                	ld	ra,8(sp)
    80004e26:	6402                	ld	s0,0(sp)
    80004e28:	0141                	addi	sp,sp,16
    80004e2a:	8082                	ret

0000000080004e2c <start>:
{
    80004e2c:	1141                	addi	sp,sp,-16
    80004e2e:	e406                	sd	ra,8(sp)
    80004e30:	e022                	sd	s0,0(sp)
    80004e32:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80004e34:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80004e38:	7779                	lui	a4,0xffffe
    80004e3a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdb2b7>
    80004e3e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80004e40:	6705                	lui	a4,0x1
    80004e42:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80004e46:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80004e48:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80004e4c:	ffffb797          	auipc	a5,0xffffb
    80004e50:	4b878793          	addi	a5,a5,1208 # 80000304 <main>
    80004e54:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80004e58:	4781                	li	a5,0
    80004e5a:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80004e5e:	67c1                	lui	a5,0x10
    80004e60:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    80004e62:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80004e66:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80004e6a:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE);
    80004e6e:	2207e793          	ori	a5,a5,544
  asm volatile("csrw sie, %0" : : "r" (x));
    80004e72:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80004e76:	57fd                	li	a5,-1
    80004e78:	83a9                	srli	a5,a5,0xa
    80004e7a:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80004e7e:	47bd                	li	a5,15
    80004e80:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80004e84:	f61ff0ef          	jal	80004de4 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80004e88:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80004e8c:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80004e8e:	823e                	mv	tp,a5
  asm volatile("mret");
    80004e90:	30200073          	mret
}
    80004e94:	60a2                	ld	ra,8(sp)
    80004e96:	6402                	ld	s0,0(sp)
    80004e98:	0141                	addi	sp,sp,16
    80004e9a:	8082                	ret

0000000080004e9c <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80004e9c:	7119                	addi	sp,sp,-128
    80004e9e:	fc86                	sd	ra,120(sp)
    80004ea0:	f8a2                	sd	s0,112(sp)
    80004ea2:	f4a6                	sd	s1,104(sp)
    80004ea4:	0100                	addi	s0,sp,128
  char buf[32];
  int i = 0;

  while(i < n){
    80004ea6:	06c05b63          	blez	a2,80004f1c <consolewrite+0x80>
    80004eaa:	f0ca                	sd	s2,96(sp)
    80004eac:	ecce                	sd	s3,88(sp)
    80004eae:	e8d2                	sd	s4,80(sp)
    80004eb0:	e4d6                	sd	s5,72(sp)
    80004eb2:	e0da                	sd	s6,64(sp)
    80004eb4:	fc5e                	sd	s7,56(sp)
    80004eb6:	f862                	sd	s8,48(sp)
    80004eb8:	f466                	sd	s9,40(sp)
    80004eba:	f06a                	sd	s10,32(sp)
    80004ebc:	8b2a                	mv	s6,a0
    80004ebe:	8bae                	mv	s7,a1
    80004ec0:	8a32                	mv	s4,a2
  int i = 0;
    80004ec2:	4481                	li	s1,0
    int nn = sizeof(buf);
    if(nn > n - i)
    80004ec4:	02000c93          	li	s9,32
    80004ec8:	02000d13          	li	s10,32
      nn = n - i;
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004ecc:	f8040a93          	addi	s5,s0,-128
    80004ed0:	5c7d                	li	s8,-1
    80004ed2:	a025                	j	80004efa <consolewrite+0x5e>
    if(nn > n - i)
    80004ed4:	0009099b          	sext.w	s3,s2
    if(either_copyin(buf, user_src, src+i, nn) == -1)
    80004ed8:	86ce                	mv	a3,s3
    80004eda:	01748633          	add	a2,s1,s7
    80004ede:	85da                	mv	a1,s6
    80004ee0:	8556                	mv	a0,s5
    80004ee2:	827fc0ef          	jal	80001708 <either_copyin>
    80004ee6:	03850d63          	beq	a0,s8,80004f20 <consolewrite+0x84>
      break;
    uartwrite(buf, nn);
    80004eea:	85ce                	mv	a1,s3
    80004eec:	8556                	mv	a0,s5
    80004eee:	76e000ef          	jal	8000565c <uartwrite>
    i += nn;
    80004ef2:	009904bb          	addw	s1,s2,s1
  while(i < n){
    80004ef6:	0144d963          	bge	s1,s4,80004f08 <consolewrite+0x6c>
    if(nn > n - i)
    80004efa:	409a07bb          	subw	a5,s4,s1
    80004efe:	893e                	mv	s2,a5
    80004f00:	fcfcdae3          	bge	s9,a5,80004ed4 <consolewrite+0x38>
    80004f04:	896a                	mv	s2,s10
    80004f06:	b7f9                	j	80004ed4 <consolewrite+0x38>
    80004f08:	7906                	ld	s2,96(sp)
    80004f0a:	69e6                	ld	s3,88(sp)
    80004f0c:	6a46                	ld	s4,80(sp)
    80004f0e:	6aa6                	ld	s5,72(sp)
    80004f10:	6b06                	ld	s6,64(sp)
    80004f12:	7be2                	ld	s7,56(sp)
    80004f14:	7c42                	ld	s8,48(sp)
    80004f16:	7ca2                	ld	s9,40(sp)
    80004f18:	7d02                	ld	s10,32(sp)
    80004f1a:	a821                	j	80004f32 <consolewrite+0x96>
  int i = 0;
    80004f1c:	4481                	li	s1,0
    80004f1e:	a811                	j	80004f32 <consolewrite+0x96>
    80004f20:	7906                	ld	s2,96(sp)
    80004f22:	69e6                	ld	s3,88(sp)
    80004f24:	6a46                	ld	s4,80(sp)
    80004f26:	6aa6                	ld	s5,72(sp)
    80004f28:	6b06                	ld	s6,64(sp)
    80004f2a:	7be2                	ld	s7,56(sp)
    80004f2c:	7c42                	ld	s8,48(sp)
    80004f2e:	7ca2                	ld	s9,40(sp)
    80004f30:	7d02                	ld	s10,32(sp)
  }

  return i;
}
    80004f32:	8526                	mv	a0,s1
    80004f34:	70e6                	ld	ra,120(sp)
    80004f36:	7446                	ld	s0,112(sp)
    80004f38:	74a6                	ld	s1,104(sp)
    80004f3a:	6109                	addi	sp,sp,128
    80004f3c:	8082                	ret

0000000080004f3e <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80004f3e:	711d                	addi	sp,sp,-96
    80004f40:	ec86                	sd	ra,88(sp)
    80004f42:	e8a2                	sd	s0,80(sp)
    80004f44:	e4a6                	sd	s1,72(sp)
    80004f46:	e0ca                	sd	s2,64(sp)
    80004f48:	fc4e                	sd	s3,56(sp)
    80004f4a:	f852                	sd	s4,48(sp)
    80004f4c:	f456                	sd	s5,40(sp)
    80004f4e:	f05a                	sd	s6,32(sp)
    80004f50:	1080                	addi	s0,sp,96
    80004f52:	8aaa                	mv	s5,a0
    80004f54:	8a2e                	mv	s4,a1
    80004f56:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80004f58:	8b32                	mv	s6,a2
  acquire(&cons.lock);
    80004f5a:	0001e517          	auipc	a0,0x1e
    80004f5e:	51650513          	addi	a0,a0,1302 # 80023470 <cons>
    80004f62:	101000ef          	jal	80005862 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80004f66:	0001e497          	auipc	s1,0x1e
    80004f6a:	50a48493          	addi	s1,s1,1290 # 80023470 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80004f6e:	0001e917          	auipc	s2,0x1e
    80004f72:	59a90913          	addi	s2,s2,1434 # 80023508 <cons+0x98>
  while(n > 0){
    80004f76:	0b305b63          	blez	s3,8000502c <consoleread+0xee>
    while(cons.r == cons.w){
    80004f7a:	0984a783          	lw	a5,152(s1)
    80004f7e:	09c4a703          	lw	a4,156(s1)
    80004f82:	0af71063          	bne	a4,a5,80005022 <consoleread+0xe4>
      if(killed(myproc())){
    80004f86:	debfb0ef          	jal	80000d70 <myproc>
    80004f8a:	e16fc0ef          	jal	800015a0 <killed>
    80004f8e:	e12d                	bnez	a0,80004ff0 <consoleread+0xb2>
      sleep(&cons.r, &cons.lock);
    80004f90:	85a6                	mv	a1,s1
    80004f92:	854a                	mv	a0,s2
    80004f94:	bd4fc0ef          	jal	80001368 <sleep>
    while(cons.r == cons.w){
    80004f98:	0984a783          	lw	a5,152(s1)
    80004f9c:	09c4a703          	lw	a4,156(s1)
    80004fa0:	fef703e3          	beq	a4,a5,80004f86 <consoleread+0x48>
    80004fa4:	ec5e                	sd	s7,24(sp)
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    80004fa6:	0001e717          	auipc	a4,0x1e
    80004faa:	4ca70713          	addi	a4,a4,1226 # 80023470 <cons>
    80004fae:	0017869b          	addiw	a3,a5,1
    80004fb2:	08d72c23          	sw	a3,152(a4)
    80004fb6:	07f7f693          	andi	a3,a5,127
    80004fba:	9736                	add	a4,a4,a3
    80004fbc:	01874703          	lbu	a4,24(a4)
    80004fc0:	00070b9b          	sext.w	s7,a4

    if(c == C('D')){  // end-of-file
    80004fc4:	4691                	li	a3,4
    80004fc6:	04db8663          	beq	s7,a3,80005012 <consoleread+0xd4>
      }
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    80004fca:	fae407a3          	sb	a4,-81(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80004fce:	4685                	li	a3,1
    80004fd0:	faf40613          	addi	a2,s0,-81
    80004fd4:	85d2                	mv	a1,s4
    80004fd6:	8556                	mv	a0,s5
    80004fd8:	ee6fc0ef          	jal	800016be <either_copyout>
    80004fdc:	57fd                	li	a5,-1
    80004fde:	04f50663          	beq	a0,a5,8000502a <consoleread+0xec>
      break;

    dst++;
    80004fe2:	0a05                	addi	s4,s4,1
    --n;
    80004fe4:	39fd                	addiw	s3,s3,-1

    if(c == '\n'){
    80004fe6:	47a9                	li	a5,10
    80004fe8:	04fb8b63          	beq	s7,a5,8000503e <consoleread+0x100>
    80004fec:	6be2                	ld	s7,24(sp)
    80004fee:	b761                	j	80004f76 <consoleread+0x38>
        release(&cons.lock);
    80004ff0:	0001e517          	auipc	a0,0x1e
    80004ff4:	48050513          	addi	a0,a0,1152 # 80023470 <cons>
    80004ff8:	0ff000ef          	jal	800058f6 <release>
        return -1;
    80004ffc:	557d                	li	a0,-1
    }
  }
  release(&cons.lock);

  return target - n;
}
    80004ffe:	60e6                	ld	ra,88(sp)
    80005000:	6446                	ld	s0,80(sp)
    80005002:	64a6                	ld	s1,72(sp)
    80005004:	6906                	ld	s2,64(sp)
    80005006:	79e2                	ld	s3,56(sp)
    80005008:	7a42                	ld	s4,48(sp)
    8000500a:	7aa2                	ld	s5,40(sp)
    8000500c:	7b02                	ld	s6,32(sp)
    8000500e:	6125                	addi	sp,sp,96
    80005010:	8082                	ret
      if(n < target){
    80005012:	0169fa63          	bgeu	s3,s6,80005026 <consoleread+0xe8>
        cons.r--;
    80005016:	0001e717          	auipc	a4,0x1e
    8000501a:	4ef72923          	sw	a5,1266(a4) # 80023508 <cons+0x98>
    8000501e:	6be2                	ld	s7,24(sp)
    80005020:	a031                	j	8000502c <consoleread+0xee>
    80005022:	ec5e                	sd	s7,24(sp)
    80005024:	b749                	j	80004fa6 <consoleread+0x68>
    80005026:	6be2                	ld	s7,24(sp)
    80005028:	a011                	j	8000502c <consoleread+0xee>
    8000502a:	6be2                	ld	s7,24(sp)
  release(&cons.lock);
    8000502c:	0001e517          	auipc	a0,0x1e
    80005030:	44450513          	addi	a0,a0,1092 # 80023470 <cons>
    80005034:	0c3000ef          	jal	800058f6 <release>
  return target - n;
    80005038:	413b053b          	subw	a0,s6,s3
    8000503c:	b7c9                	j	80004ffe <consoleread+0xc0>
    8000503e:	6be2                	ld	s7,24(sp)
    80005040:	b7f5                	j	8000502c <consoleread+0xee>

0000000080005042 <consputc>:
{
    80005042:	1141                	addi	sp,sp,-16
    80005044:	e406                	sd	ra,8(sp)
    80005046:	e022                	sd	s0,0(sp)
    80005048:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    8000504a:	10000793          	li	a5,256
    8000504e:	00f50863          	beq	a0,a5,8000505e <consputc+0x1c>
    uartputc_sync(c);
    80005052:	69e000ef          	jal	800056f0 <uartputc_sync>
}
    80005056:	60a2                	ld	ra,8(sp)
    80005058:	6402                	ld	s0,0(sp)
    8000505a:	0141                	addi	sp,sp,16
    8000505c:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    8000505e:	4521                	li	a0,8
    80005060:	690000ef          	jal	800056f0 <uartputc_sync>
    80005064:	02000513          	li	a0,32
    80005068:	688000ef          	jal	800056f0 <uartputc_sync>
    8000506c:	4521                	li	a0,8
    8000506e:	682000ef          	jal	800056f0 <uartputc_sync>
    80005072:	b7d5                	j	80005056 <consputc+0x14>

0000000080005074 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005074:	7179                	addi	sp,sp,-48
    80005076:	f406                	sd	ra,40(sp)
    80005078:	f022                	sd	s0,32(sp)
    8000507a:	ec26                	sd	s1,24(sp)
    8000507c:	1800                	addi	s0,sp,48
    8000507e:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005080:	0001e517          	auipc	a0,0x1e
    80005084:	3f050513          	addi	a0,a0,1008 # 80023470 <cons>
    80005088:	7da000ef          	jal	80005862 <acquire>

  switch(c){
    8000508c:	47d5                	li	a5,21
    8000508e:	08f48e63          	beq	s1,a5,8000512a <consoleintr+0xb6>
    80005092:	0297c563          	blt	a5,s1,800050bc <consoleintr+0x48>
    80005096:	47a1                	li	a5,8
    80005098:	0ef48863          	beq	s1,a5,80005188 <consoleintr+0x114>
    8000509c:	47c1                	li	a5,16
    8000509e:	10f49963          	bne	s1,a5,800051b0 <consoleintr+0x13c>
  case C('P'):  // Print process list.
    procdump();
    800050a2:	eb0fc0ef          	jal	80001752 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800050a6:	0001e517          	auipc	a0,0x1e
    800050aa:	3ca50513          	addi	a0,a0,970 # 80023470 <cons>
    800050ae:	049000ef          	jal	800058f6 <release>
}
    800050b2:	70a2                	ld	ra,40(sp)
    800050b4:	7402                	ld	s0,32(sp)
    800050b6:	64e2                	ld	s1,24(sp)
    800050b8:	6145                	addi	sp,sp,48
    800050ba:	8082                	ret
  switch(c){
    800050bc:	07f00793          	li	a5,127
    800050c0:	0cf48463          	beq	s1,a5,80005188 <consoleintr+0x114>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800050c4:	0001e717          	auipc	a4,0x1e
    800050c8:	3ac70713          	addi	a4,a4,940 # 80023470 <cons>
    800050cc:	0a072783          	lw	a5,160(a4)
    800050d0:	09872703          	lw	a4,152(a4)
    800050d4:	9f99                	subw	a5,a5,a4
    800050d6:	07f00713          	li	a4,127
    800050da:	fcf766e3          	bltu	a4,a5,800050a6 <consoleintr+0x32>
      c = (c == '\r') ? '\n' : c;
    800050de:	47b5                	li	a5,13
    800050e0:	0cf48b63          	beq	s1,a5,800051b6 <consoleintr+0x142>
      consputc(c);
    800050e4:	8526                	mv	a0,s1
    800050e6:	f5dff0ef          	jal	80005042 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800050ea:	0001e797          	auipc	a5,0x1e
    800050ee:	38678793          	addi	a5,a5,902 # 80023470 <cons>
    800050f2:	0a07a683          	lw	a3,160(a5)
    800050f6:	0016871b          	addiw	a4,a3,1
    800050fa:	863a                	mv	a2,a4
    800050fc:	0ae7a023          	sw	a4,160(a5)
    80005100:	07f6f693          	andi	a3,a3,127
    80005104:	97b6                	add	a5,a5,a3
    80005106:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    8000510a:	47a9                	li	a5,10
    8000510c:	0cf48963          	beq	s1,a5,800051de <consoleintr+0x16a>
    80005110:	4791                	li	a5,4
    80005112:	0cf48663          	beq	s1,a5,800051de <consoleintr+0x16a>
    80005116:	0001e797          	auipc	a5,0x1e
    8000511a:	3f27a783          	lw	a5,1010(a5) # 80023508 <cons+0x98>
    8000511e:	9f1d                	subw	a4,a4,a5
    80005120:	08000793          	li	a5,128
    80005124:	f8f711e3          	bne	a4,a5,800050a6 <consoleintr+0x32>
    80005128:	a85d                	j	800051de <consoleintr+0x16a>
    8000512a:	e84a                	sd	s2,16(sp)
    8000512c:	e44e                	sd	s3,8(sp)
    while(cons.e != cons.w &&
    8000512e:	0001e717          	auipc	a4,0x1e
    80005132:	34270713          	addi	a4,a4,834 # 80023470 <cons>
    80005136:	0a072783          	lw	a5,160(a4)
    8000513a:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    8000513e:	0001e497          	auipc	s1,0x1e
    80005142:	33248493          	addi	s1,s1,818 # 80023470 <cons>
    while(cons.e != cons.w &&
    80005146:	4929                	li	s2,10
      consputc(BACKSPACE);
    80005148:	10000993          	li	s3,256
    while(cons.e != cons.w &&
    8000514c:	02f70863          	beq	a4,a5,8000517c <consoleintr+0x108>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005150:	37fd                	addiw	a5,a5,-1
    80005152:	07f7f713          	andi	a4,a5,127
    80005156:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005158:	01874703          	lbu	a4,24(a4)
    8000515c:	03270363          	beq	a4,s2,80005182 <consoleintr+0x10e>
      cons.e--;
    80005160:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005164:	854e                	mv	a0,s3
    80005166:	eddff0ef          	jal	80005042 <consputc>
    while(cons.e != cons.w &&
    8000516a:	0a04a783          	lw	a5,160(s1)
    8000516e:	09c4a703          	lw	a4,156(s1)
    80005172:	fcf71fe3          	bne	a4,a5,80005150 <consoleintr+0xdc>
    80005176:	6942                	ld	s2,16(sp)
    80005178:	69a2                	ld	s3,8(sp)
    8000517a:	b735                	j	800050a6 <consoleintr+0x32>
    8000517c:	6942                	ld	s2,16(sp)
    8000517e:	69a2                	ld	s3,8(sp)
    80005180:	b71d                	j	800050a6 <consoleintr+0x32>
    80005182:	6942                	ld	s2,16(sp)
    80005184:	69a2                	ld	s3,8(sp)
    80005186:	b705                	j	800050a6 <consoleintr+0x32>
    if(cons.e != cons.w){
    80005188:	0001e717          	auipc	a4,0x1e
    8000518c:	2e870713          	addi	a4,a4,744 # 80023470 <cons>
    80005190:	0a072783          	lw	a5,160(a4)
    80005194:	09c72703          	lw	a4,156(a4)
    80005198:	f0f707e3          	beq	a4,a5,800050a6 <consoleintr+0x32>
      cons.e--;
    8000519c:	37fd                	addiw	a5,a5,-1
    8000519e:	0001e717          	auipc	a4,0x1e
    800051a2:	36f72923          	sw	a5,882(a4) # 80023510 <cons+0xa0>
      consputc(BACKSPACE);
    800051a6:	10000513          	li	a0,256
    800051aa:	e99ff0ef          	jal	80005042 <consputc>
    800051ae:	bde5                	j	800050a6 <consoleintr+0x32>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800051b0:	ee048be3          	beqz	s1,800050a6 <consoleintr+0x32>
    800051b4:	bf01                	j	800050c4 <consoleintr+0x50>
      consputc(c);
    800051b6:	4529                	li	a0,10
    800051b8:	e8bff0ef          	jal	80005042 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800051bc:	0001e797          	auipc	a5,0x1e
    800051c0:	2b478793          	addi	a5,a5,692 # 80023470 <cons>
    800051c4:	0a07a703          	lw	a4,160(a5)
    800051c8:	0017069b          	addiw	a3,a4,1
    800051cc:	8636                	mv	a2,a3
    800051ce:	0ad7a023          	sw	a3,160(a5)
    800051d2:	07f77713          	andi	a4,a4,127
    800051d6:	97ba                	add	a5,a5,a4
    800051d8:	4729                	li	a4,10
    800051da:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    800051de:	0001e797          	auipc	a5,0x1e
    800051e2:	32c7a723          	sw	a2,814(a5) # 8002350c <cons+0x9c>
        wakeup(&cons.r);
    800051e6:	0001e517          	auipc	a0,0x1e
    800051ea:	32250513          	addi	a0,a0,802 # 80023508 <cons+0x98>
    800051ee:	9c6fc0ef          	jal	800013b4 <wakeup>
    800051f2:	bd55                	j	800050a6 <consoleintr+0x32>

00000000800051f4 <consoleinit>:

void
consoleinit(void)
{
    800051f4:	1141                	addi	sp,sp,-16
    800051f6:	e406                	sd	ra,8(sp)
    800051f8:	e022                	sd	s0,0(sp)
    800051fa:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    800051fc:	00002597          	auipc	a1,0x2
    80005200:	4b458593          	addi	a1,a1,1204 # 800076b0 <etext+0x6b0>
    80005204:	0001e517          	auipc	a0,0x1e
    80005208:	26c50513          	addi	a0,a0,620 # 80023470 <cons>
    8000520c:	5d2000ef          	jal	800057de <initlock>

  uartinit();
    80005210:	3f6000ef          	jal	80005606 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005214:	00015797          	auipc	a5,0x15
    80005218:	0c478793          	addi	a5,a5,196 # 8001a2d8 <devsw>
    8000521c:	00000717          	auipc	a4,0x0
    80005220:	d2270713          	addi	a4,a4,-734 # 80004f3e <consoleread>
    80005224:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005226:	00000717          	auipc	a4,0x0
    8000522a:	c7670713          	addi	a4,a4,-906 # 80004e9c <consolewrite>
    8000522e:	ef98                	sd	a4,24(a5)
}
    80005230:	60a2                	ld	ra,8(sp)
    80005232:	6402                	ld	s0,0(sp)
    80005234:	0141                	addi	sp,sp,16
    80005236:	8082                	ret

0000000080005238 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(long long xx, int base, int sign)
{
    80005238:	7139                	addi	sp,sp,-64
    8000523a:	fc06                	sd	ra,56(sp)
    8000523c:	f822                	sd	s0,48(sp)
    8000523e:	f426                	sd	s1,40(sp)
    80005240:	f04a                	sd	s2,32(sp)
    80005242:	0080                	addi	s0,sp,64
  char buf[20];
  int i;
  unsigned long long x;

  if(sign && (sign = (xx < 0)))
    80005244:	c219                	beqz	a2,8000524a <printint+0x12>
    80005246:	06054a63          	bltz	a0,800052ba <printint+0x82>
    x = -xx;
  else
    x = xx;
    8000524a:	4e01                	li	t3,0

  i = 0;
    8000524c:	fc840313          	addi	t1,s0,-56
    x = xx;
    80005250:	869a                	mv	a3,t1
  i = 0;
    80005252:	4781                	li	a5,0
  do {
    buf[i++] = digits[x % base];
    80005254:	00002817          	auipc	a6,0x2
    80005258:	5b480813          	addi	a6,a6,1460 # 80007808 <digits>
    8000525c:	88be                	mv	a7,a5
    8000525e:	0017861b          	addiw	a2,a5,1
    80005262:	87b2                	mv	a5,a2
    80005264:	02b57733          	remu	a4,a0,a1
    80005268:	9742                	add	a4,a4,a6
    8000526a:	00074703          	lbu	a4,0(a4)
    8000526e:	00e68023          	sb	a4,0(a3)
  } while((x /= base) != 0);
    80005272:	872a                	mv	a4,a0
    80005274:	02b55533          	divu	a0,a0,a1
    80005278:	0685                	addi	a3,a3,1
    8000527a:	feb771e3          	bgeu	a4,a1,8000525c <printint+0x24>

  if(sign)
    8000527e:	000e0c63          	beqz	t3,80005296 <printint+0x5e>
    buf[i++] = '-';
    80005282:	fe060793          	addi	a5,a2,-32
    80005286:	00878633          	add	a2,a5,s0
    8000528a:	02d00793          	li	a5,45
    8000528e:	fef60423          	sb	a5,-24(a2)
    80005292:	0028879b          	addiw	a5,a7,2

  while(--i >= 0)
    80005296:	fff7891b          	addiw	s2,a5,-1
    8000529a:	006784b3          	add	s1,a5,t1
    consputc(buf[i]);
    8000529e:	fff4c503          	lbu	a0,-1(s1)
    800052a2:	da1ff0ef          	jal	80005042 <consputc>
  while(--i >= 0)
    800052a6:	397d                	addiw	s2,s2,-1
    800052a8:	14fd                	addi	s1,s1,-1
    800052aa:	fe095ae3          	bgez	s2,8000529e <printint+0x66>
}
    800052ae:	70e2                	ld	ra,56(sp)
    800052b0:	7442                	ld	s0,48(sp)
    800052b2:	74a2                	ld	s1,40(sp)
    800052b4:	7902                	ld	s2,32(sp)
    800052b6:	6121                	addi	sp,sp,64
    800052b8:	8082                	ret
    x = -xx;
    800052ba:	40a00533          	neg	a0,a0
  if(sign && (sign = (xx < 0)))
    800052be:	4e05                	li	t3,1
    x = -xx;
    800052c0:	b771                	j	8000524c <printint+0x14>

00000000800052c2 <printf>:
}

// Print to the console.
int
printf(char *fmt, ...)
{
    800052c2:	7131                	addi	sp,sp,-192
    800052c4:	fc86                	sd	ra,120(sp)
    800052c6:	f8a2                	sd	s0,112(sp)
    800052c8:	e8d2                	sd	s4,80(sp)
    800052ca:	0100                	addi	s0,sp,128
    800052cc:	8a2a                	mv	s4,a0
    800052ce:	e40c                	sd	a1,8(s0)
    800052d0:	e810                	sd	a2,16(s0)
    800052d2:	ec14                	sd	a3,24(s0)
    800052d4:	f018                	sd	a4,32(s0)
    800052d6:	f41c                	sd	a5,40(s0)
    800052d8:	03043823          	sd	a6,48(s0)
    800052dc:	03143c23          	sd	a7,56(s0)
  va_list ap;
  int i, cx, c0, c1, c2;
  char *s;

  if(panicking == 0)
    800052e0:	00005797          	auipc	a5,0x5
    800052e4:	f507a783          	lw	a5,-176(a5) # 8000a230 <panicking>
    800052e8:	c3a1                	beqz	a5,80005328 <printf+0x66>
    acquire(&pr.lock);

  va_start(ap, fmt);
    800052ea:	00840793          	addi	a5,s0,8
    800052ee:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    800052f2:	000a4503          	lbu	a0,0(s4)
    800052f6:	28050663          	beqz	a0,80005582 <printf+0x2c0>
    800052fa:	f4a6                	sd	s1,104(sp)
    800052fc:	f0ca                	sd	s2,96(sp)
    800052fe:	ecce                	sd	s3,88(sp)
    80005300:	e4d6                	sd	s5,72(sp)
    80005302:	e0da                	sd	s6,64(sp)
    80005304:	f862                	sd	s8,48(sp)
    80005306:	f466                	sd	s9,40(sp)
    80005308:	f06a                	sd	s10,32(sp)
    8000530a:	ec6e                	sd	s11,24(sp)
    8000530c:	4901                	li	s2,0
    if(cx != '%'){
    8000530e:	02500a93          	li	s5,37
    i++;
    c0 = fmt[i+0] & 0xff;
    c1 = c2 = 0;
    if(c0) c1 = fmt[i+1] & 0xff;
    if(c1) c2 = fmt[i+2] & 0xff;
    if(c0 == 'd'){
    80005312:	06400b13          	li	s6,100
      printint(va_arg(ap, int), 10, 1);
    } else if(c0 == 'l' && c1 == 'd'){
    80005316:	06c00c13          	li	s8,108
      printint(va_arg(ap, uint64), 10, 1);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
      printint(va_arg(ap, uint64), 10, 1);
      i += 2;
    } else if(c0 == 'u'){
    8000531a:	07500c93          	li	s9,117
      printint(va_arg(ap, uint64), 10, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
      printint(va_arg(ap, uint64), 10, 0);
      i += 2;
    } else if(c0 == 'x'){
    8000531e:	07800d13          	li	s10,120
      printint(va_arg(ap, uint64), 16, 0);
      i += 1;
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
      printint(va_arg(ap, uint64), 16, 0);
      i += 2;
    } else if(c0 == 'p'){
    80005322:	07000d93          	li	s11,112
    80005326:	a015                	j	8000534a <printf+0x88>
    acquire(&pr.lock);
    80005328:	0001e517          	auipc	a0,0x1e
    8000532c:	1f050513          	addi	a0,a0,496 # 80023518 <pr>
    80005330:	532000ef          	jal	80005862 <acquire>
    80005334:	bf5d                	j	800052ea <printf+0x28>
      consputc(cx);
    80005336:	d0dff0ef          	jal	80005042 <consputc>
      continue;
    8000533a:	84ca                	mv	s1,s2
  for(i = 0; (cx = fmt[i] & 0xff) != 0; i++){
    8000533c:	2485                	addiw	s1,s1,1
    8000533e:	8926                	mv	s2,s1
    80005340:	94d2                	add	s1,s1,s4
    80005342:	0004c503          	lbu	a0,0(s1)
    80005346:	20050b63          	beqz	a0,8000555c <printf+0x29a>
    if(cx != '%'){
    8000534a:	ff5516e3          	bne	a0,s5,80005336 <printf+0x74>
    i++;
    8000534e:	0019079b          	addiw	a5,s2,1
    80005352:	84be                	mv	s1,a5
    c0 = fmt[i+0] & 0xff;
    80005354:	00fa0733          	add	a4,s4,a5
    80005358:	00074983          	lbu	s3,0(a4)
    if(c0) c1 = fmt[i+1] & 0xff;
    8000535c:	20098a63          	beqz	s3,80005570 <printf+0x2ae>
    80005360:	00174703          	lbu	a4,1(a4)
    c1 = c2 = 0;
    80005364:	86ba                	mv	a3,a4
    if(c1) c2 = fmt[i+2] & 0xff;
    80005366:	c701                	beqz	a4,8000536e <printf+0xac>
    80005368:	97d2                	add	a5,a5,s4
    8000536a:	0027c683          	lbu	a3,2(a5)
    if(c0 == 'd'){
    8000536e:	03698963          	beq	s3,s6,800053a0 <printf+0xde>
    } else if(c0 == 'l' && c1 == 'd'){
    80005372:	05898363          	beq	s3,s8,800053b8 <printf+0xf6>
    } else if(c0 == 'u'){
    80005376:	0d998663          	beq	s3,s9,80005442 <printf+0x180>
    } else if(c0 == 'x'){
    8000537a:	11a98d63          	beq	s3,s10,80005494 <printf+0x1d2>
    } else if(c0 == 'p'){
    8000537e:	15b98663          	beq	s3,s11,800054ca <printf+0x208>
      printptr(va_arg(ap, uint64));
    } else if(c0 == 'c'){
    80005382:	06300793          	li	a5,99
    80005386:	18f98563          	beq	s3,a5,80005510 <printf+0x24e>
      consputc(va_arg(ap, uint));
    } else if(c0 == 's'){
    8000538a:	07300793          	li	a5,115
    8000538e:	18f98b63          	beq	s3,a5,80005524 <printf+0x262>
      if((s = va_arg(ap, char*)) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
    } else if(c0 == '%'){
    80005392:	03599b63          	bne	s3,s5,800053c8 <printf+0x106>
      consputc('%');
    80005396:	02500513          	li	a0,37
    8000539a:	ca9ff0ef          	jal	80005042 <consputc>
    8000539e:	bf79                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, int), 10, 1);
    800053a0:	f8843783          	ld	a5,-120(s0)
    800053a4:	00878713          	addi	a4,a5,8
    800053a8:	f8e43423          	sd	a4,-120(s0)
    800053ac:	4605                	li	a2,1
    800053ae:	45a9                	li	a1,10
    800053b0:	4388                	lw	a0,0(a5)
    800053b2:	e87ff0ef          	jal	80005238 <printint>
    800053b6:	b759                	j	8000533c <printf+0x7a>
    } else if(c0 == 'l' && c1 == 'd'){
    800053b8:	01670f63          	beq	a4,s6,800053d6 <printf+0x114>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    800053bc:	03870b63          	beq	a4,s8,800053f2 <printf+0x130>
    } else if(c0 == 'l' && c1 == 'u'){
    800053c0:	09970e63          	beq	a4,s9,8000545c <printf+0x19a>
    } else if(c0 == 'l' && c1 == 'x'){
    800053c4:	0fa70563          	beq	a4,s10,800054ae <printf+0x1ec>
    } else if(c0 == 0){
      break;
    } else {
      // Print unknown % sequence to draw attention.
      consputc('%');
    800053c8:	8556                	mv	a0,s5
    800053ca:	c79ff0ef          	jal	80005042 <consputc>
      consputc(c0);
    800053ce:	854e                	mv	a0,s3
    800053d0:	c73ff0ef          	jal	80005042 <consputc>
    800053d4:	b7a5                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 1);
    800053d6:	f8843783          	ld	a5,-120(s0)
    800053da:	00878713          	addi	a4,a5,8
    800053de:	f8e43423          	sd	a4,-120(s0)
    800053e2:	4605                	li	a2,1
    800053e4:	45a9                	li	a1,10
    800053e6:	6388                	ld	a0,0(a5)
    800053e8:	e51ff0ef          	jal	80005238 <printint>
      i += 1;
    800053ec:	0029049b          	addiw	s1,s2,2
    800053f0:	b7b1                	j	8000533c <printf+0x7a>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
    800053f2:	06400793          	li	a5,100
    800053f6:	02f68863          	beq	a3,a5,80005426 <printf+0x164>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
    800053fa:	07500793          	li	a5,117
    800053fe:	06f68d63          	beq	a3,a5,80005478 <printf+0x1b6>
    } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
    80005402:	07800793          	li	a5,120
    80005406:	fcf691e3          	bne	a3,a5,800053c8 <printf+0x106>
      printint(va_arg(ap, uint64), 16, 0);
    8000540a:	f8843783          	ld	a5,-120(s0)
    8000540e:	00878713          	addi	a4,a5,8
    80005412:	f8e43423          	sd	a4,-120(s0)
    80005416:	4601                	li	a2,0
    80005418:	45c1                	li	a1,16
    8000541a:	6388                	ld	a0,0(a5)
    8000541c:	e1dff0ef          	jal	80005238 <printint>
      i += 2;
    80005420:	0039049b          	addiw	s1,s2,3
    80005424:	bf21                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 1);
    80005426:	f8843783          	ld	a5,-120(s0)
    8000542a:	00878713          	addi	a4,a5,8
    8000542e:	f8e43423          	sd	a4,-120(s0)
    80005432:	4605                	li	a2,1
    80005434:	45a9                	li	a1,10
    80005436:	6388                	ld	a0,0(a5)
    80005438:	e01ff0ef          	jal	80005238 <printint>
      i += 2;
    8000543c:	0039049b          	addiw	s1,s2,3
    80005440:	bdf5                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint32), 10, 0);
    80005442:	f8843783          	ld	a5,-120(s0)
    80005446:	00878713          	addi	a4,a5,8
    8000544a:	f8e43423          	sd	a4,-120(s0)
    8000544e:	4601                	li	a2,0
    80005450:	45a9                	li	a1,10
    80005452:	0007e503          	lwu	a0,0(a5)
    80005456:	de3ff0ef          	jal	80005238 <printint>
    8000545a:	b5cd                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 0);
    8000545c:	f8843783          	ld	a5,-120(s0)
    80005460:	00878713          	addi	a4,a5,8
    80005464:	f8e43423          	sd	a4,-120(s0)
    80005468:	4601                	li	a2,0
    8000546a:	45a9                	li	a1,10
    8000546c:	6388                	ld	a0,0(a5)
    8000546e:	dcbff0ef          	jal	80005238 <printint>
      i += 1;
    80005472:	0029049b          	addiw	s1,s2,2
    80005476:	b5d9                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint64), 10, 0);
    80005478:	f8843783          	ld	a5,-120(s0)
    8000547c:	00878713          	addi	a4,a5,8
    80005480:	f8e43423          	sd	a4,-120(s0)
    80005484:	4601                	li	a2,0
    80005486:	45a9                	li	a1,10
    80005488:	6388                	ld	a0,0(a5)
    8000548a:	dafff0ef          	jal	80005238 <printint>
      i += 2;
    8000548e:	0039049b          	addiw	s1,s2,3
    80005492:	b56d                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint32), 16, 0);
    80005494:	f8843783          	ld	a5,-120(s0)
    80005498:	00878713          	addi	a4,a5,8
    8000549c:	f8e43423          	sd	a4,-120(s0)
    800054a0:	4601                	li	a2,0
    800054a2:	45c1                	li	a1,16
    800054a4:	0007e503          	lwu	a0,0(a5)
    800054a8:	d91ff0ef          	jal	80005238 <printint>
    800054ac:	bd41                	j	8000533c <printf+0x7a>
      printint(va_arg(ap, uint64), 16, 0);
    800054ae:	f8843783          	ld	a5,-120(s0)
    800054b2:	00878713          	addi	a4,a5,8
    800054b6:	f8e43423          	sd	a4,-120(s0)
    800054ba:	4601                	li	a2,0
    800054bc:	45c1                	li	a1,16
    800054be:	6388                	ld	a0,0(a5)
    800054c0:	d79ff0ef          	jal	80005238 <printint>
      i += 1;
    800054c4:	0029049b          	addiw	s1,s2,2
    800054c8:	bd95                	j	8000533c <printf+0x7a>
    800054ca:	fc5e                	sd	s7,56(sp)
      printptr(va_arg(ap, uint64));
    800054cc:	f8843783          	ld	a5,-120(s0)
    800054d0:	00878713          	addi	a4,a5,8
    800054d4:	f8e43423          	sd	a4,-120(s0)
    800054d8:	0007b983          	ld	s3,0(a5)
  consputc('0');
    800054dc:	03000513          	li	a0,48
    800054e0:	b63ff0ef          	jal	80005042 <consputc>
  consputc('x');
    800054e4:	07800513          	li	a0,120
    800054e8:	b5bff0ef          	jal	80005042 <consputc>
    800054ec:	4941                	li	s2,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800054ee:	00002b97          	auipc	s7,0x2
    800054f2:	31ab8b93          	addi	s7,s7,794 # 80007808 <digits>
    800054f6:	03c9d793          	srli	a5,s3,0x3c
    800054fa:	97de                	add	a5,a5,s7
    800054fc:	0007c503          	lbu	a0,0(a5)
    80005500:	b43ff0ef          	jal	80005042 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005504:	0992                	slli	s3,s3,0x4
    80005506:	397d                	addiw	s2,s2,-1
    80005508:	fe0917e3          	bnez	s2,800054f6 <printf+0x234>
    8000550c:	7be2                	ld	s7,56(sp)
    8000550e:	b53d                	j	8000533c <printf+0x7a>
      consputc(va_arg(ap, uint));
    80005510:	f8843783          	ld	a5,-120(s0)
    80005514:	00878713          	addi	a4,a5,8
    80005518:	f8e43423          	sd	a4,-120(s0)
    8000551c:	4388                	lw	a0,0(a5)
    8000551e:	b25ff0ef          	jal	80005042 <consputc>
    80005522:	bd29                	j	8000533c <printf+0x7a>
      if((s = va_arg(ap, char*)) == 0)
    80005524:	f8843783          	ld	a5,-120(s0)
    80005528:	00878713          	addi	a4,a5,8
    8000552c:	f8e43423          	sd	a4,-120(s0)
    80005530:	0007b903          	ld	s2,0(a5)
    80005534:	00090d63          	beqz	s2,8000554e <printf+0x28c>
      for(; *s; s++)
    80005538:	00094503          	lbu	a0,0(s2)
    8000553c:	e00500e3          	beqz	a0,8000533c <printf+0x7a>
        consputc(*s);
    80005540:	b03ff0ef          	jal	80005042 <consputc>
      for(; *s; s++)
    80005544:	0905                	addi	s2,s2,1
    80005546:	00094503          	lbu	a0,0(s2)
    8000554a:	f97d                	bnez	a0,80005540 <printf+0x27e>
    8000554c:	bbc5                	j	8000533c <printf+0x7a>
        s = "(null)";
    8000554e:	00002917          	auipc	s2,0x2
    80005552:	16a90913          	addi	s2,s2,362 # 800076b8 <etext+0x6b8>
      for(; *s; s++)
    80005556:	02800513          	li	a0,40
    8000555a:	b7dd                	j	80005540 <printf+0x27e>
    8000555c:	74a6                	ld	s1,104(sp)
    8000555e:	7906                	ld	s2,96(sp)
    80005560:	69e6                	ld	s3,88(sp)
    80005562:	6aa6                	ld	s5,72(sp)
    80005564:	6b06                	ld	s6,64(sp)
    80005566:	7c42                	ld	s8,48(sp)
    80005568:	7ca2                	ld	s9,40(sp)
    8000556a:	7d02                	ld	s10,32(sp)
    8000556c:	6de2                	ld	s11,24(sp)
    8000556e:	a811                	j	80005582 <printf+0x2c0>
    80005570:	74a6                	ld	s1,104(sp)
    80005572:	7906                	ld	s2,96(sp)
    80005574:	69e6                	ld	s3,88(sp)
    80005576:	6aa6                	ld	s5,72(sp)
    80005578:	6b06                	ld	s6,64(sp)
    8000557a:	7c42                	ld	s8,48(sp)
    8000557c:	7ca2                	ld	s9,40(sp)
    8000557e:	7d02                	ld	s10,32(sp)
    80005580:	6de2                	ld	s11,24(sp)
    }

  }
  va_end(ap);

  if(panicking == 0)
    80005582:	00005797          	auipc	a5,0x5
    80005586:	cae7a783          	lw	a5,-850(a5) # 8000a230 <panicking>
    8000558a:	c799                	beqz	a5,80005598 <printf+0x2d6>
    release(&pr.lock);

  return 0;
}
    8000558c:	4501                	li	a0,0
    8000558e:	70e6                	ld	ra,120(sp)
    80005590:	7446                	ld	s0,112(sp)
    80005592:	6a46                	ld	s4,80(sp)
    80005594:	6129                	addi	sp,sp,192
    80005596:	8082                	ret
    release(&pr.lock);
    80005598:	0001e517          	auipc	a0,0x1e
    8000559c:	f8050513          	addi	a0,a0,-128 # 80023518 <pr>
    800055a0:	356000ef          	jal	800058f6 <release>
  return 0;
    800055a4:	b7e5                	j	8000558c <printf+0x2ca>

00000000800055a6 <panic>:

void
panic(char *s)
{
    800055a6:	1101                	addi	sp,sp,-32
    800055a8:	ec06                	sd	ra,24(sp)
    800055aa:	e822                	sd	s0,16(sp)
    800055ac:	e426                	sd	s1,8(sp)
    800055ae:	e04a                	sd	s2,0(sp)
    800055b0:	1000                	addi	s0,sp,32
    800055b2:	84aa                	mv	s1,a0
  panicking = 1;
    800055b4:	4905                	li	s2,1
    800055b6:	00005797          	auipc	a5,0x5
    800055ba:	c727ad23          	sw	s2,-902(a5) # 8000a230 <panicking>
  printf("panic: ");
    800055be:	00002517          	auipc	a0,0x2
    800055c2:	10250513          	addi	a0,a0,258 # 800076c0 <etext+0x6c0>
    800055c6:	cfdff0ef          	jal	800052c2 <printf>
  printf("%s\n", s);
    800055ca:	85a6                	mv	a1,s1
    800055cc:	00002517          	auipc	a0,0x2
    800055d0:	0fc50513          	addi	a0,a0,252 # 800076c8 <etext+0x6c8>
    800055d4:	cefff0ef          	jal	800052c2 <printf>
  panicked = 1; // freeze uart output from other CPUs
    800055d8:	00005797          	auipc	a5,0x5
    800055dc:	c527aa23          	sw	s2,-940(a5) # 8000a22c <panicked>
  for(;;)
    800055e0:	a001                	j	800055e0 <panic+0x3a>

00000000800055e2 <printfinit>:
    ;
}

void
printfinit(void)
{
    800055e2:	1141                	addi	sp,sp,-16
    800055e4:	e406                	sd	ra,8(sp)
    800055e6:	e022                	sd	s0,0(sp)
    800055e8:	0800                	addi	s0,sp,16
  initlock(&pr.lock, "pr");
    800055ea:	00002597          	auipc	a1,0x2
    800055ee:	0e658593          	addi	a1,a1,230 # 800076d0 <etext+0x6d0>
    800055f2:	0001e517          	auipc	a0,0x1e
    800055f6:	f2650513          	addi	a0,a0,-218 # 80023518 <pr>
    800055fa:	1e4000ef          	jal	800057de <initlock>
}
    800055fe:	60a2                	ld	ra,8(sp)
    80005600:	6402                	ld	s0,0(sp)
    80005602:	0141                	addi	sp,sp,16
    80005604:	8082                	ret

0000000080005606 <uartinit>:
extern volatile int panicking; // from printf.c
extern volatile int panicked; // from printf.c

void
uartinit(void)
{
    80005606:	1141                	addi	sp,sp,-16
    80005608:	e406                	sd	ra,8(sp)
    8000560a:	e022                	sd	s0,0(sp)
    8000560c:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000560e:	100007b7          	lui	a5,0x10000
    80005612:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005616:	10000737          	lui	a4,0x10000
    8000561a:	f8000693          	li	a3,-128
    8000561e:	00d701a3          	sb	a3,3(a4) # 10000003 <_entry-0x6ffffffd>

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005622:	468d                	li	a3,3
    80005624:	10000637          	lui	a2,0x10000
    80005628:	00d60023          	sb	a3,0(a2) # 10000000 <_entry-0x70000000>

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    8000562c:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005630:	00d701a3          	sb	a3,3(a4)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005634:	8732                	mv	a4,a2
    80005636:	461d                	li	a2,7
    80005638:	00c70123          	sb	a2,2(a4)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    8000563c:	00d780a3          	sb	a3,1(a5)

  initlock(&tx_lock, "uart");
    80005640:	00002597          	auipc	a1,0x2
    80005644:	09858593          	addi	a1,a1,152 # 800076d8 <etext+0x6d8>
    80005648:	0001e517          	auipc	a0,0x1e
    8000564c:	ee850513          	addi	a0,a0,-280 # 80023530 <tx_lock>
    80005650:	18e000ef          	jal	800057de <initlock>
}
    80005654:	60a2                	ld	ra,8(sp)
    80005656:	6402                	ld	s0,0(sp)
    80005658:	0141                	addi	sp,sp,16
    8000565a:	8082                	ret

000000008000565c <uartwrite>:
// transmit buf[] to the uart. it blocks if the
// uart is busy, so it cannot be called from
// interrupts, only from write() system calls.
void
uartwrite(char buf[], int n)
{
    8000565c:	715d                	addi	sp,sp,-80
    8000565e:	e486                	sd	ra,72(sp)
    80005660:	e0a2                	sd	s0,64(sp)
    80005662:	fc26                	sd	s1,56(sp)
    80005664:	ec56                	sd	s5,24(sp)
    80005666:	0880                	addi	s0,sp,80
    80005668:	8aaa                	mv	s5,a0
    8000566a:	84ae                	mv	s1,a1
  acquire(&tx_lock);
    8000566c:	0001e517          	auipc	a0,0x1e
    80005670:	ec450513          	addi	a0,a0,-316 # 80023530 <tx_lock>
    80005674:	1ee000ef          	jal	80005862 <acquire>

  int i = 0;
  while(i < n){ 
    80005678:	06905063          	blez	s1,800056d8 <uartwrite+0x7c>
    8000567c:	f84a                	sd	s2,48(sp)
    8000567e:	f44e                	sd	s3,40(sp)
    80005680:	f052                	sd	s4,32(sp)
    80005682:	e85a                	sd	s6,16(sp)
    80005684:	e45e                	sd	s7,8(sp)
    80005686:	8a56                	mv	s4,s5
    80005688:	9aa6                	add	s5,s5,s1
    while(tx_busy != 0){
    8000568a:	00005497          	auipc	s1,0x5
    8000568e:	bae48493          	addi	s1,s1,-1106 # 8000a238 <tx_busy>
      // wait for a UART transmit-complete interrupt
      // to set tx_busy to 0.
      sleep(&tx_chan, &tx_lock);
    80005692:	0001e997          	auipc	s3,0x1e
    80005696:	e9e98993          	addi	s3,s3,-354 # 80023530 <tx_lock>
    8000569a:	00005917          	auipc	s2,0x5
    8000569e:	b9a90913          	addi	s2,s2,-1126 # 8000a234 <tx_chan>
    }   
      
    WriteReg(THR, buf[i]);
    800056a2:	10000bb7          	lui	s7,0x10000
    i += 1;
    tx_busy = 1;
    800056a6:	4b05                	li	s6,1
    800056a8:	a005                	j	800056c8 <uartwrite+0x6c>
      sleep(&tx_chan, &tx_lock);
    800056aa:	85ce                	mv	a1,s3
    800056ac:	854a                	mv	a0,s2
    800056ae:	cbbfb0ef          	jal	80001368 <sleep>
    while(tx_busy != 0){
    800056b2:	409c                	lw	a5,0(s1)
    800056b4:	fbfd                	bnez	a5,800056aa <uartwrite+0x4e>
    WriteReg(THR, buf[i]);
    800056b6:	000a4783          	lbu	a5,0(s4)
    800056ba:	00fb8023          	sb	a5,0(s7) # 10000000 <_entry-0x70000000>
    tx_busy = 1;
    800056be:	0164a023          	sw	s6,0(s1)
  while(i < n){ 
    800056c2:	0a05                	addi	s4,s4,1
    800056c4:	015a0563          	beq	s4,s5,800056ce <uartwrite+0x72>
    while(tx_busy != 0){
    800056c8:	409c                	lw	a5,0(s1)
    800056ca:	f3e5                	bnez	a5,800056aa <uartwrite+0x4e>
    800056cc:	b7ed                	j	800056b6 <uartwrite+0x5a>
    800056ce:	7942                	ld	s2,48(sp)
    800056d0:	79a2                	ld	s3,40(sp)
    800056d2:	7a02                	ld	s4,32(sp)
    800056d4:	6b42                	ld	s6,16(sp)
    800056d6:	6ba2                	ld	s7,8(sp)
  }

  release(&tx_lock);
    800056d8:	0001e517          	auipc	a0,0x1e
    800056dc:	e5850513          	addi	a0,a0,-424 # 80023530 <tx_lock>
    800056e0:	216000ef          	jal	800058f6 <release>
}
    800056e4:	60a6                	ld	ra,72(sp)
    800056e6:	6406                	ld	s0,64(sp)
    800056e8:	74e2                	ld	s1,56(sp)
    800056ea:	6ae2                	ld	s5,24(sp)
    800056ec:	6161                	addi	sp,sp,80
    800056ee:	8082                	ret

00000000800056f0 <uartputc_sync>:
// interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800056f0:	1101                	addi	sp,sp,-32
    800056f2:	ec06                	sd	ra,24(sp)
    800056f4:	e822                	sd	s0,16(sp)
    800056f6:	e426                	sd	s1,8(sp)
    800056f8:	1000                	addi	s0,sp,32
    800056fa:	84aa                	mv	s1,a0
  if(panicking == 0)
    800056fc:	00005797          	auipc	a5,0x5
    80005700:	b347a783          	lw	a5,-1228(a5) # 8000a230 <panicking>
    80005704:	cf95                	beqz	a5,80005740 <uartputc_sync+0x50>
    push_off();

  if(panicked){
    80005706:	00005797          	auipc	a5,0x5
    8000570a:	b267a783          	lw	a5,-1242(a5) # 8000a22c <panicked>
    8000570e:	ef85                	bnez	a5,80005746 <uartputc_sync+0x56>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005710:	10000737          	lui	a4,0x10000
    80005714:	0715                	addi	a4,a4,5 # 10000005 <_entry-0x6ffffffb>
    80005716:	00074783          	lbu	a5,0(a4)
    8000571a:	0207f793          	andi	a5,a5,32
    8000571e:	dfe5                	beqz	a5,80005716 <uartputc_sync+0x26>
    ;
  WriteReg(THR, c);
    80005720:	0ff4f513          	zext.b	a0,s1
    80005724:	100007b7          	lui	a5,0x10000
    80005728:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  if(panicking == 0)
    8000572c:	00005797          	auipc	a5,0x5
    80005730:	b047a783          	lw	a5,-1276(a5) # 8000a230 <panicking>
    80005734:	cb91                	beqz	a5,80005748 <uartputc_sync+0x58>
    pop_off();
}
    80005736:	60e2                	ld	ra,24(sp)
    80005738:	6442                	ld	s0,16(sp)
    8000573a:	64a2                	ld	s1,8(sp)
    8000573c:	6105                	addi	sp,sp,32
    8000573e:	8082                	ret
    push_off();
    80005740:	0e2000ef          	jal	80005822 <push_off>
    80005744:	b7c9                	j	80005706 <uartputc_sync+0x16>
    for(;;)
    80005746:	a001                	j	80005746 <uartputc_sync+0x56>
    pop_off();
    80005748:	15e000ef          	jal	800058a6 <pop_off>
}
    8000574c:	b7ed                	j	80005736 <uartputc_sync+0x46>

000000008000574e <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000574e:	1141                	addi	sp,sp,-16
    80005750:	e406                	sd	ra,8(sp)
    80005752:	e022                	sd	s0,0(sp)
    80005754:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & LSR_RX_READY){
    80005756:	100007b7          	lui	a5,0x10000
    8000575a:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000575e:	8b85                	andi	a5,a5,1
    80005760:	cb89                	beqz	a5,80005772 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80005762:	100007b7          	lui	a5,0x10000
    80005766:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    8000576a:	60a2                	ld	ra,8(sp)
    8000576c:	6402                	ld	s0,0(sp)
    8000576e:	0141                	addi	sp,sp,16
    80005770:	8082                	ret
    return -1;
    80005772:	557d                	li	a0,-1
    80005774:	bfdd                	j	8000576a <uartgetc+0x1c>

0000000080005776 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    80005776:	1101                	addi	sp,sp,-32
    80005778:	ec06                	sd	ra,24(sp)
    8000577a:	e822                	sd	s0,16(sp)
    8000577c:	e426                	sd	s1,8(sp)
    8000577e:	1000                	addi	s0,sp,32
  ReadReg(ISR); // acknowledge the interrupt
    80005780:	100007b7          	lui	a5,0x10000
    80005784:	0027c783          	lbu	a5,2(a5) # 10000002 <_entry-0x6ffffffe>

  acquire(&tx_lock);
    80005788:	0001e517          	auipc	a0,0x1e
    8000578c:	da850513          	addi	a0,a0,-600 # 80023530 <tx_lock>
    80005790:	0d2000ef          	jal	80005862 <acquire>
  if(ReadReg(LSR) & LSR_TX_IDLE){
    80005794:	100007b7          	lui	a5,0x10000
    80005798:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000579c:	0207f793          	andi	a5,a5,32
    800057a0:	ef99                	bnez	a5,800057be <uartintr+0x48>
    // UART finished transmitting; wake up sending thread.
    tx_busy = 0;
    wakeup(&tx_chan);
  }
  release(&tx_lock);
    800057a2:	0001e517          	auipc	a0,0x1e
    800057a6:	d8e50513          	addi	a0,a0,-626 # 80023530 <tx_lock>
    800057aa:	14c000ef          	jal	800058f6 <release>

  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800057ae:	54fd                	li	s1,-1
    int c = uartgetc();
    800057b0:	f9fff0ef          	jal	8000574e <uartgetc>
    if(c == -1)
    800057b4:	02950063          	beq	a0,s1,800057d4 <uartintr+0x5e>
      break;
    consoleintr(c);
    800057b8:	8bdff0ef          	jal	80005074 <consoleintr>
  while(1){
    800057bc:	bfd5                	j	800057b0 <uartintr+0x3a>
    tx_busy = 0;
    800057be:	00005797          	auipc	a5,0x5
    800057c2:	a607ad23          	sw	zero,-1414(a5) # 8000a238 <tx_busy>
    wakeup(&tx_chan);
    800057c6:	00005517          	auipc	a0,0x5
    800057ca:	a6e50513          	addi	a0,a0,-1426 # 8000a234 <tx_chan>
    800057ce:	be7fb0ef          	jal	800013b4 <wakeup>
    800057d2:	bfc1                	j	800057a2 <uartintr+0x2c>
  }
}
    800057d4:	60e2                	ld	ra,24(sp)
    800057d6:	6442                	ld	s0,16(sp)
    800057d8:	64a2                	ld	s1,8(sp)
    800057da:	6105                	addi	sp,sp,32
    800057dc:	8082                	ret

00000000800057de <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    800057de:	1141                	addi	sp,sp,-16
    800057e0:	e406                	sd	ra,8(sp)
    800057e2:	e022                	sd	s0,0(sp)
    800057e4:	0800                	addi	s0,sp,16
  lk->name = name;
    800057e6:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    800057e8:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    800057ec:	00053823          	sd	zero,16(a0)
}
    800057f0:	60a2                	ld	ra,8(sp)
    800057f2:	6402                	ld	s0,0(sp)
    800057f4:	0141                	addi	sp,sp,16
    800057f6:	8082                	ret

00000000800057f8 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800057f8:	411c                	lw	a5,0(a0)
    800057fa:	e399                	bnez	a5,80005800 <holding+0x8>
    800057fc:	4501                	li	a0,0
  return r;
}
    800057fe:	8082                	ret
{
    80005800:	1101                	addi	sp,sp,-32
    80005802:	ec06                	sd	ra,24(sp)
    80005804:	e822                	sd	s0,16(sp)
    80005806:	e426                	sd	s1,8(sp)
    80005808:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    8000580a:	6904                	ld	s1,16(a0)
    8000580c:	d44fb0ef          	jal	80000d50 <mycpu>
    80005810:	40a48533          	sub	a0,s1,a0
    80005814:	00153513          	seqz	a0,a0
}
    80005818:	60e2                	ld	ra,24(sp)
    8000581a:	6442                	ld	s0,16(sp)
    8000581c:	64a2                	ld	s1,8(sp)
    8000581e:	6105                	addi	sp,sp,32
    80005820:	8082                	ret

0000000080005822 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80005822:	1101                	addi	sp,sp,-32
    80005824:	ec06                	sd	ra,24(sp)
    80005826:	e822                	sd	s0,16(sp)
    80005828:	e426                	sd	s1,8(sp)
    8000582a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000582c:	100024f3          	csrr	s1,sstatus
    80005830:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80005834:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80005836:	10079073          	csrw	sstatus,a5

  // disable interrupts to prevent an involuntary context
  // switch while using mycpu().
  intr_off();

  if(mycpu()->noff == 0)
    8000583a:	d16fb0ef          	jal	80000d50 <mycpu>
    8000583e:	5d3c                	lw	a5,120(a0)
    80005840:	cb99                	beqz	a5,80005856 <push_off+0x34>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80005842:	d0efb0ef          	jal	80000d50 <mycpu>
    80005846:	5d3c                	lw	a5,120(a0)
    80005848:	2785                	addiw	a5,a5,1
    8000584a:	dd3c                	sw	a5,120(a0)
}
    8000584c:	60e2                	ld	ra,24(sp)
    8000584e:	6442                	ld	s0,16(sp)
    80005850:	64a2                	ld	s1,8(sp)
    80005852:	6105                	addi	sp,sp,32
    80005854:	8082                	ret
    mycpu()->intena = old;
    80005856:	cfafb0ef          	jal	80000d50 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000585a:	8085                	srli	s1,s1,0x1
    8000585c:	8885                	andi	s1,s1,1
    8000585e:	dd64                	sw	s1,124(a0)
    80005860:	b7cd                	j	80005842 <push_off+0x20>

0000000080005862 <acquire>:
{
    80005862:	1101                	addi	sp,sp,-32
    80005864:	ec06                	sd	ra,24(sp)
    80005866:	e822                	sd	s0,16(sp)
    80005868:	e426                	sd	s1,8(sp)
    8000586a:	1000                	addi	s0,sp,32
    8000586c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000586e:	fb5ff0ef          	jal	80005822 <push_off>
  if(holding(lk))
    80005872:	8526                	mv	a0,s1
    80005874:	f85ff0ef          	jal	800057f8 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80005878:	4705                	li	a4,1
  if(holding(lk))
    8000587a:	e105                	bnez	a0,8000589a <acquire+0x38>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000587c:	87ba                	mv	a5,a4
    8000587e:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80005882:	2781                	sext.w	a5,a5
    80005884:	ffe5                	bnez	a5,8000587c <acquire+0x1a>
  __sync_synchronize();
    80005886:	0330000f          	fence	rw,rw
  lk->cpu = mycpu();
    8000588a:	cc6fb0ef          	jal	80000d50 <mycpu>
    8000588e:	e888                	sd	a0,16(s1)
}
    80005890:	60e2                	ld	ra,24(sp)
    80005892:	6442                	ld	s0,16(sp)
    80005894:	64a2                	ld	s1,8(sp)
    80005896:	6105                	addi	sp,sp,32
    80005898:	8082                	ret
    panic("acquire");
    8000589a:	00002517          	auipc	a0,0x2
    8000589e:	e4650513          	addi	a0,a0,-442 # 800076e0 <etext+0x6e0>
    800058a2:	d05ff0ef          	jal	800055a6 <panic>

00000000800058a6 <pop_off>:

void
pop_off(void)
{
    800058a6:	1141                	addi	sp,sp,-16
    800058a8:	e406                	sd	ra,8(sp)
    800058aa:	e022                	sd	s0,0(sp)
    800058ac:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800058ae:	ca2fb0ef          	jal	80000d50 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800058b2:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800058b6:	8b89                	andi	a5,a5,2
  if(intr_get())
    800058b8:	e39d                	bnez	a5,800058de <pop_off+0x38>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800058ba:	5d3c                	lw	a5,120(a0)
    800058bc:	02f05763          	blez	a5,800058ea <pop_off+0x44>
    panic("pop_off");
  c->noff -= 1;
    800058c0:	37fd                	addiw	a5,a5,-1
    800058c2:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    800058c4:	eb89                	bnez	a5,800058d6 <pop_off+0x30>
    800058c6:	5d7c                	lw	a5,124(a0)
    800058c8:	c799                	beqz	a5,800058d6 <pop_off+0x30>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800058ca:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800058ce:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800058d2:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800058d6:	60a2                	ld	ra,8(sp)
    800058d8:	6402                	ld	s0,0(sp)
    800058da:	0141                	addi	sp,sp,16
    800058dc:	8082                	ret
    panic("pop_off - interruptible");
    800058de:	00002517          	auipc	a0,0x2
    800058e2:	e0a50513          	addi	a0,a0,-502 # 800076e8 <etext+0x6e8>
    800058e6:	cc1ff0ef          	jal	800055a6 <panic>
    panic("pop_off");
    800058ea:	00002517          	auipc	a0,0x2
    800058ee:	e1650513          	addi	a0,a0,-490 # 80007700 <etext+0x700>
    800058f2:	cb5ff0ef          	jal	800055a6 <panic>

00000000800058f6 <release>:
{
    800058f6:	1101                	addi	sp,sp,-32
    800058f8:	ec06                	sd	ra,24(sp)
    800058fa:	e822                	sd	s0,16(sp)
    800058fc:	e426                	sd	s1,8(sp)
    800058fe:	1000                	addi	s0,sp,32
    80005900:	84aa                	mv	s1,a0
  if(!holding(lk))
    80005902:	ef7ff0ef          	jal	800057f8 <holding>
    80005906:	c105                	beqz	a0,80005926 <release+0x30>
  lk->cpu = 0;
    80005908:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    8000590c:	0330000f          	fence	rw,rw
  __sync_lock_release(&lk->locked);
    80005910:	0310000f          	fence	rw,w
    80005914:	0004a023          	sw	zero,0(s1)
  pop_off();
    80005918:	f8fff0ef          	jal	800058a6 <pop_off>
}
    8000591c:	60e2                	ld	ra,24(sp)
    8000591e:	6442                	ld	s0,16(sp)
    80005920:	64a2                	ld	s1,8(sp)
    80005922:	6105                	addi	sp,sp,32
    80005924:	8082                	ret
    panic("release");
    80005926:	00002517          	auipc	a0,0x2
    8000592a:	de250513          	addi	a0,a0,-542 # 80007708 <etext+0x708>
    8000592e:	c79ff0ef          	jal	800055a6 <panic>
	...

0000000080006000 <_trampoline>:
    80006000:	14051073          	csrw	sscratch,a0
    80006004:	02000537          	lui	a0,0x2000
    80006008:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    8000600a:	0536                	slli	a0,a0,0xd
    8000600c:	02153423          	sd	ra,40(a0)
    80006010:	02253823          	sd	sp,48(a0)
    80006014:	02353c23          	sd	gp,56(a0)
    80006018:	04453023          	sd	tp,64(a0)
    8000601c:	04553423          	sd	t0,72(a0)
    80006020:	04653823          	sd	t1,80(a0)
    80006024:	04753c23          	sd	t2,88(a0)
    80006028:	f120                	sd	s0,96(a0)
    8000602a:	f524                	sd	s1,104(a0)
    8000602c:	fd2c                	sd	a1,120(a0)
    8000602e:	e150                	sd	a2,128(a0)
    80006030:	e554                	sd	a3,136(a0)
    80006032:	e958                	sd	a4,144(a0)
    80006034:	ed5c                	sd	a5,152(a0)
    80006036:	0b053023          	sd	a6,160(a0)
    8000603a:	0b153423          	sd	a7,168(a0)
    8000603e:	0b253823          	sd	s2,176(a0)
    80006042:	0b353c23          	sd	s3,184(a0)
    80006046:	0d453023          	sd	s4,192(a0)
    8000604a:	0d553423          	sd	s5,200(a0)
    8000604e:	0d653823          	sd	s6,208(a0)
    80006052:	0d753c23          	sd	s7,216(a0)
    80006056:	0f853023          	sd	s8,224(a0)
    8000605a:	0f953423          	sd	s9,232(a0)
    8000605e:	0fa53823          	sd	s10,240(a0)
    80006062:	0fb53c23          	sd	s11,248(a0)
    80006066:	11c53023          	sd	t3,256(a0)
    8000606a:	11d53423          	sd	t4,264(a0)
    8000606e:	11e53823          	sd	t5,272(a0)
    80006072:	11f53c23          	sd	t6,280(a0)
    80006076:	140022f3          	csrr	t0,sscratch
    8000607a:	06553823          	sd	t0,112(a0)
    8000607e:	00853103          	ld	sp,8(a0)
    80006082:	02053203          	ld	tp,32(a0)
    80006086:	01053283          	ld	t0,16(a0)
    8000608a:	00053303          	ld	t1,0(a0)
    8000608e:	12000073          	sfence.vma
    80006092:	18031073          	csrw	satp,t1
    80006096:	12000073          	sfence.vma
    8000609a:	9282                	jalr	t0

000000008000609c <userret>:
    8000609c:	12000073          	sfence.vma
    800060a0:	18051073          	csrw	satp,a0
    800060a4:	12000073          	sfence.vma
    800060a8:	02000537          	lui	a0,0x2000
    800060ac:	357d                	addiw	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    800060ae:	0536                	slli	a0,a0,0xd
    800060b0:	02853083          	ld	ra,40(a0)
    800060b4:	03053103          	ld	sp,48(a0)
    800060b8:	03853183          	ld	gp,56(a0)
    800060bc:	04053203          	ld	tp,64(a0)
    800060c0:	04853283          	ld	t0,72(a0)
    800060c4:	05053303          	ld	t1,80(a0)
    800060c8:	05853383          	ld	t2,88(a0)
    800060cc:	7120                	ld	s0,96(a0)
    800060ce:	7524                	ld	s1,104(a0)
    800060d0:	7d2c                	ld	a1,120(a0)
    800060d2:	6150                	ld	a2,128(a0)
    800060d4:	6554                	ld	a3,136(a0)
    800060d6:	6958                	ld	a4,144(a0)
    800060d8:	6d5c                	ld	a5,152(a0)
    800060da:	0a053803          	ld	a6,160(a0)
    800060de:	0a853883          	ld	a7,168(a0)
    800060e2:	0b053903          	ld	s2,176(a0)
    800060e6:	0b853983          	ld	s3,184(a0)
    800060ea:	0c053a03          	ld	s4,192(a0)
    800060ee:	0c853a83          	ld	s5,200(a0)
    800060f2:	0d053b03          	ld	s6,208(a0)
    800060f6:	0d853b83          	ld	s7,216(a0)
    800060fa:	0e053c03          	ld	s8,224(a0)
    800060fe:	0e853c83          	ld	s9,232(a0)
    80006102:	0f053d03          	ld	s10,240(a0)
    80006106:	0f853d83          	ld	s11,248(a0)
    8000610a:	10053e03          	ld	t3,256(a0)
    8000610e:	10853e83          	ld	t4,264(a0)
    80006112:	11053f03          	ld	t5,272(a0)
    80006116:	11853f83          	ld	t6,280(a0)
    8000611a:	7928                	ld	a0,112(a0)
    8000611c:	10200073          	sret
	...
