From: Karl Nasrallah <knnspeed@aol.com>
Date: Wed, 18 Dec 2019 03:56:03 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <2107393677.694216.1576641363699@mail.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <339916914.636876.1576627652112.ref@mail.yahoo.com> <339916914.636876.1576627652112@mail.yahoo.com> <87tv5yjssb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tv5yjssb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: kuninori.morimoto.gx@renesas.com
Cc: dalias@libc.org, geert@linux-m68k.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello,

Though ultimately I do not have a say in that, it would appear that string_32.h is in arch/sh/include/asm and has been there for a very long time. In fact, it appears that x86 also has similar utility functions defined in inline assembly: see arch/x86/include/asm. As straightforward as it would be to make C versions, there may be a reason that they are in inline assembly--optimization would be my guess--and converting it all to C may require an overhaul of the string.h backend (something I would not be much help with given that I am unable to get modern Linux booting on my machine, which is a Sega Dreamcast). I also do not know what the performance implications of switching it all to C would be, if there even are any.

Hopefully this information may be useful and my asm version is alright for the time being; I have not been able to unearth much more on the topic of why this is structured the way it is,
-Karl Nasrallah

-----Original Message-----
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Karl Nasrallah <knnspeed@aol.com>
Cc: dalias <dalias@libc.org>; geert <geert@linux-m68k.org>; ysato <ysato@users.sourceforge.jp>; linux-sh <linux-sh@vger.kernel.org>; linux-renesas-soc <linux-renesas-soc@vger.kernel.org>
Sent: Tue, Dec 17, 2019 9:01 pm
Subject: Re: can someone solve string_32.h issue for SH ?



Hi

> You're using r0 explicitly in the asm but I don't see where you're
> reserving it for your use. You need it either on the clobbers or bound
> to a dummy output with earlyclobber.
(snip)

>     __asm__ __volatile__ (
>                     "strncpy_start:\n\t"
>                             "mov.b @%[src]+,%[r0_reg]\n\t"
>                             "cmp/eq #0,%[r0_reg]\n\t"
>                             "bt.s strncpy_pad\n\t"
>                             "cmp/eq %[dest],%[dest_end]\n\t"
>                             "bt.s strncpy_end\n\t"
>                             "mov.b %[r0_reg],@%[dest]\n\t"
>                             "bra strncpy_start\n\t"
>                             "add #1,%[dest]\n\t"
>                     "strncpy_pad:\n\t"
>                             "bt.s strncpy_end\n\t"
>                             "mov.b %[r0_reg],@%[dest]\n\t"
>                             "add #1,%[dest]\n\t"
>                             "bra strncpy_pad\n\t"
>                             "cmp/eq %[dest],%[dest_end]\n\t"
>                     "strncpy_end:\n\t"
>         : [src] "+r" (__src), [dest] "+r" (__dest), [r0_reg] "+&z" (r0_register)
>         : [dest_end] "r" (__dest_end)
>         : "t","memory"

>     );

Or, can we use general strncpy() instead of SH assemble one ?

Thank you for your help !!
Best regards
---
Kuninori Morimoto
