From: morimoto.kuninori@renesas.com
Date: Fri, 05 Dec 2008 02:40:54 +0000
Subject: Bug report about udivsi3-0s.S
Message-Id: <ur64ntkcp.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

I notice bug of ${LINUX}/arch/sh/lib/udivsi3-0s.

My environment is

gcc : sh4-unknown-linug-gnu-gcc
OS  : Linux 2.6.28-rc6 (from latest git)
CPU : SH7723

When I use latest Linux 2.6.28-rc6 and sh4-unknown-linug-gnu-gcc,
kernel starts an infinite loop on sh-sci.c :: sci_set_termios

but it works well when I use sh4-linux-gcc

And I found the reason.
I think __udivsi3 should not break r1 register.

following is my kernel.
Kernel starts infinite loop on 88118408.

sh-sci.c :: sci_set_termios
--------------------
(snip)
881183f0:	91 52       	mov.l	@(4,r9),r2
881183f2:	bc 64       	extu.b	r11,r4
881183f4:	1c d0       	mov.l	88118468 <sci_set_termios+0x1a0>,r0	! 880eecb8 <__udivsi3>
881183f6:	a3 65       	mov	r10,r5
881183f8:	1c d1       	mov.l	8811846c <sci_set_termios+0x1a4>,r1	! f423f
881183fa:	04 72       	add	#4,r2
881183fc:	40 22       	mov.b	r4,@r2
881183fe:	a3 64       	mov	r10,r4
88118400:	1c 34       	add	r1,r4
88118402:	1b d1       	mov.l	88118470 <sci_set_termios+0x1a8>,r1	! 880ee414 <__udelay>
88118404:	0b 40       	jsr	@r0
88118406:	09 00       	nop	
88118408:	0b 41       	jsr	@r1
8811840a:	03 64       	mov	r0,r4
8811840c:	d3 61       	mov	r13,r1
(snip)
--------------------

udivsi3-0s.
------------------
(snip)
	.set	__udivsi3, __udivsi3_i4i
	.type	__udivsi3_i4i, @function
	.type	__sdivsi3_i4i, @function
__udivsi3_i4i:
	sts pr,r1               <== **** r1 is broken ****
	mov.l r4,@-r15
	extu.w r5,r0
	cmp/eq r5,r0
	swap.w r4,r0
	shlr16 r4
(snip)
	mov.l @r15+,r4
	jmp @r1                 <== **** return to 88118408 ****
	rotcl r0
(snip)
------------------

Best regards
--
Kuninori Morimoto
 
