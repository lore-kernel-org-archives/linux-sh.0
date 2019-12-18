From: Karl Nasrallah <knnspeed@aol.com>
Date: Wed, 18 Dec 2019 00:07:32 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <339916914.636876.1576627652112@mail.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <339916914.636876.1576627652112.ref@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dalias@libc.org
Cc: kuninori.morimoto.gx@renesas.com, geert@linux-m68k.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hi Rich,

Thanks for the feedback. I've amended (and tested) it in two possible ways:

First:

static inline char *strncpy(char *__dest, const char *__src, size_t __n)
{
	char * retval = __dest;
	const char * __dest_end = __dest + __n - 1;
	register unsigned int * r0_register __asm__ ("r0");

	/* size_t is always unsigned */
	if(__n == 0)
	{
		return retval;
	}

	/*
	 * Some notes:
	 * - cmp/eq #imm8,r0 is its own instruction
	 * - incrementing dest and comparing to dest_end handles the size parameter in only one instruction
	 * - mov.b R0,@Rn+ is SH2A only, but we can fill a delay slot with "add #1,%[dest]"
	 */

	__asm__ __volatile__ (
					"strncpy_start:\n\t"
							"mov.b @%[src]+,%[r0_reg]\n\t"
							"cmp/eq #0,%[r0_reg]\n\t"
							"bt.s strncpy_pad\n\t"
							"cmp/eq %[dest],%[dest_end]\n\t"
							"bt.s strncpy_end\n\t"
							"mov.b %[r0_reg],@%[dest]\n\t"
							"bra strncpy_start\n\t"
							"add #1,%[dest]\n\t"
					"strncpy_pad:\n\t"
							"bt.s strncpy_end\n\t"
							"mov.b %[r0_reg],@%[dest]\n\t"
							"add #1,%[dest]\n\t"
							"bra strncpy_pad\n\t"
							"cmp/eq %[dest],%[dest_end]\n\t"
					"strncpy_end:\n\t"
		: [src] "+r" (__src), [dest] "+r" (__dest), [r0_reg] "+&z" (r0_register)
		: [dest_end] "r" (__dest_end)
		: "t","memory"
	);

	return retval;
}

Second:

static inline char *sh_strncpy(char *__dest, const char *__src, size_t __n)
{
	char * retval = __dest;
	const char * __dest_end = __dest + __n - 1;

	/* size_t is always unsigned */
	if(__n == 0)
	{
		return retval;
	}

	/*
	 * Some notes:
	 * - cmp/eq #imm8,r0 is its own instruction
	 * - incrementing dest and comparing to dest_end handles the size parameter in only one instruction
	 * - mov.b R0,@Rn+ is SH2A only, but we can fill a delay slot with "add #1,%[dest]"
	 */

	__asm__ __volatile__ (
					"strncpy_start:\n\t"
							"mov.b @%[src]+,r0\n\t"
							"cmp/eq #0,r0\n\t"
							"bt.s strncpy_pad\n\t"
							"cmp/eq %[dest],%[dest_end]\n\t"
							"bt.s strncpy_end\n\t"
							"mov.b r0,@%[dest]\n\t"
							"bra strncpy_start\n\t"
							"add #1,%[dest]\n\t"
					"strncpy_pad:\n\t"
							"bt.s strncpy_end\n\t"
							"mov.b r0,@%[dest]\n\t"
							"add #1,%[dest]\n\t"
							"bra strncpy_pad\n\t"
							"cmp/eq %[dest],%[dest_end]\n\t"
					"strncpy_end:\n\t"
		: [src] "+r" (__src), [dest] "+r" (__dest)
		: [dest_end] "r" (__dest_end)
		: "r0","t","memory"
	);

	return retval;
}

I assume that a "memory" clobber would also be appropriate here?

I was unaware that explicitly using a register in extended asm meant that it would need to be listed in the clobber list or otherwise reserved. Guess I've been doing it wrong for a while!

By the way, thank you for adding -static-pie to GCC & binutils. It's been incredibly useful in writing bare-metal code for x86!
-Karl

-----Original Message-----
From: Rich Felker <dalias@libc.org>
To: Karl Nasrallah <knnspeed@aol.com>
Cc: kuninori.morimoto.gx <kuninori.morimoto.gx@renesas.com>; geert <geert@linux-m68k.org>; ysato <ysato@users.sourceforge.jp>; linux-sh <linux-sh@vger.kernel.org>; linux-renesas-soc <linux-renesas-soc@vger.kernel.org>
Sent: Tue, Dec 17, 2019 6:13 pm
Subject: Re: can someone solve string_32.h issue for SH ?

On Tue, Dec 17, 2019 at 10:16:28PM +0000, Karl Nasrallah wrote:
> Hello!
> 
> I have a strncpy for you.
> 
> static inline char *strncpy(char *__dest, const char *__src, size_t __n)
> {
>     char * retval = __dest;
>     const char * __dest_end = __dest + __n - 1;
> 
>     // size_t is always unsigned
>     if(__n == 0)
>     {
>         return retval;
>     }
> 
>     __asm__ __volatile__ (
>                     "strncpy_start:\n\t"
>                             "mov.b @%[src]+,r0\n\t"
>                             "cmp/eq #0,r0\n\t" // cmp/eq #imm8,r0 is its own instruction
>                             "bt.s strncpy_pad\n\t" // Done with the string
>                             "cmp/eq %[dest],%[dest_end]\n\t" // This takes care of the size parameter in only one instruction ;)
>                             "bt.s strncpy_end\n\t"
>                             "mov.b r0,@%[dest]\n\t"
>                             "bra strncpy_start\n\t"
>                             "add #1,%[dest]\n\t" // mov.b R0,@Rn+ is SH2A only, but we can fill the delay slot with the offset
>                     "strncpy_pad:\n\t"
>                             "bt.s strncpy_end\n\t"
>                             "mov.b r0,@%[dest]\n\t"
>                             "add #1,%[dest]\n\t"
>                             "bra strncpy_pad\n\t"
>                             "cmp/eq %[dest],%[dest_end]\n\t"
>                     "strncpy_end:\n\t" // All done
>         : [src] "+r" (__src), [dest] "+r" (__dest)
>         : [dest_end] "r" (__dest_end)
>         : "t"
>     );
> 
>     return retval;
> }
> 
> Tested with sh4-elf-gcc 9.2.0 on a real SH7750/SH7750R-compatible
> system. No warnings, behaves exactly as per linux (dot) die (dot)
> net/man/3/strncpy and I optimized it with some tricks I devised from
> writing extremely optimized x86. If there are any doubts as to the
> authenticity, note that I am the sole author of this project: github
> (dot) com/KNNSpeed/AVX-Memmove

You're using r0 explicitly in the asm but I don't see where you're
reserving it for your use. You need it either on the clobbers or bound
to a dummy output with earlyclobber.


Rich
