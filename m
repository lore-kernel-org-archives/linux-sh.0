From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 29 Sep 2009 05:59:30 +0000
Subject: currect MigoR seems doesn't work
Message-Id: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

currect MigoR seems doesn't work now.
And I can not disassemble it.
why ?

I used CROSS_COMPILE=sh3-linux- for make
and I used ${LINUX}/arch/sh/configs/migor_defconfig
my kernel is latest Paul's git
 => fe1dbfd3f992d5432d7463a5bd6c2fc96d3eccd8

--------------------
> sh3-linux-objdump -d vmlinux > asm
zsh: abort      sh3-linux-objdump -d vmlinux

> sh3-linux-objdump -d vmlinux
...
8c002038 <stack_start>:
8c002038:	00 c0       	mov.b	r0,@(0,gbr)
8c00203a:	32 8c       	ldrs	8c0020a2 <do_one_initcall+0x42>	! 0x2118
8c00203c:	00 00       	.word 0x0000
8c00203e:	38 8c       	ldrs	8c0020b2 <do_one_initcall+0x52>	! 0xd051
8c002040:	20 ce       	xor.b	#32,@(r0,gbr)
8c002042:	3b 8c       	ldrs	8c0020bc <do_one_initcall+0x5c>	! 0x1f2
8c002044:	40 a7       	bra	8c002ec8 <name_to_dev_t+0xb68>
8c002046:	35 8c       	ldrs	8c0020b4 <do_one_initcall+0x54>	! 0xd44f
8c002048:	zsh: abort      sh3-linux-objdump -d vmlinux
--------------------

Best regards
--
Kuninori Morimoto
 
