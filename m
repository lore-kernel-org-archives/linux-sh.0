From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Dec 2019 02:01:40 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <87tv5yjssb.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <339916914.636876.1576627652112.ref@mail.yahoo.com>
        <339916914.636876.1576627652112@mail.yahoo.com>
In-Reply-To: <339916914.636876.1576627652112@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Karl Nasrallah <knnspeed@aol.com>
Cc: dalias@libc.org, geert@linux-m68k.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org


Hi

> You're using r0 explicitly in the asm but I don't see where you're
> reserving it for your use. You need it either on the clobbers or bound
> to a dummy output with earlyclobber.
(snip)
> 	__asm__ __volatile__ (
> 					"strncpy_start:\n\t"
> 							"mov.b @%[src]+,%[r0_reg]\n\t"
> 							"cmp/eq #0,%[r0_reg]\n\t"
> 							"bt.s strncpy_pad\n\t"
> 							"cmp/eq %[dest],%[dest_end]\n\t"
> 							"bt.s strncpy_end\n\t"
> 							"mov.b %[r0_reg],@%[dest]\n\t"
> 							"bra strncpy_start\n\t"
> 							"add #1,%[dest]\n\t"
> 					"strncpy_pad:\n\t"
> 							"bt.s strncpy_end\n\t"
> 							"mov.b %[r0_reg],@%[dest]\n\t"
> 							"add #1,%[dest]\n\t"
> 							"bra strncpy_pad\n\t"
> 							"cmp/eq %[dest],%[dest_end]\n\t"
> 					"strncpy_end:\n\t"
> 		: [src] "+r" (__src), [dest] "+r" (__dest), [r0_reg] "+&z" (r0_register)
> 		: [dest_end] "r" (__dest_end)
> 		: "t","memory"
> 	);

Or, can we use general strncpy() instead of SH assemble one ?

Thank you for your help !!
Best regards
---
Kuninori Morimoto
