From: Karl Nasrallah <knnspeed@aol.com>
Date: Tue, 17 Dec 2019 22:16:28 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <1933127148.546436.1576620988364@mail.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdUHGXkmKrcZVNQo8nOcGo0h6xYgjZ+XmfGy6bJCPK9ZwQ@mail.gmail.com> <CAMuHMdUc4yyXsp4Y4Xx==3mUMrUn5DO8G-rLA_Mnv-790n6Ehg@mail.gmail.com> <871rt3gwri.wl-kuninori.morimoto.gx@renesas.com> <1850003495.209647.1576573784839@mail.yahoo.com>
In-Reply-To: <1850003495.209647.1576573784839@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: kuninori.morimoto.gx@renesas.com, geert@linux-m68k.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello!

I have a strncpy for you.

static inline char *strncpy(char *__dest, const char *__src, size_t __n)
{
	char * retval = __dest;
	const char * __dest_end = __dest + __n - 1;

	// size_t is always unsigned
	if(__n == 0)
	{
		return retval;
	}

	__asm__ __volatile__ (
					"strncpy_start:\n\t"
							"mov.b @%[src]+,r0\n\t"
							"cmp/eq #0,r0\n\t" // cmp/eq #imm8,r0 is its own instruction
							"bt.s strncpy_pad\n\t" // Done with the string
							"cmp/eq %[dest],%[dest_end]\n\t" // This takes care of the size parameter in only one instruction ;)
							"bt.s strncpy_end\n\t"
							"mov.b r0,@%[dest]\n\t"
							"bra strncpy_start\n\t"
							"add #1,%[dest]\n\t" // mov.b R0,@Rn+ is SH2A only, but we can fill the delay slot with the offset
					"strncpy_pad:\n\t"
							"bt.s strncpy_end\n\t"
							"mov.b r0,@%[dest]\n\t"
							"add #1,%[dest]\n\t"
							"bra strncpy_pad\n\t"
							"cmp/eq %[dest],%[dest_end]\n\t"
					"strncpy_end:\n\t" // All done
		: [src] "+r" (__src), [dest] "+r" (__dest)
		: [dest_end] "r" (__dest_end)
		: "t"
	);

	return retval;
}

Tested with sh4-elf-gcc 9.2.0 on a real SH7750/SH7750R-compatible system. No warnings, behaves exactly as per linux (dot) die (dot) net/man/3/strncpy and I optimized it with some tricks I devised from writing extremely optimized x86. If there are any doubts as to the authenticity, note that I am the sole author of this project: github (dot) com/KNNSpeed/AVX-Memmove

Hope this helps!
-Karl

(P.S. Consider this code public domain. If for whatever reason that doesn't fly, then I give the Linux kernel community explicit permission to use it as they see fit.)

-----Original Message-----
From: Karl Nasrallah <knnspeed@aol.com>
To: kuninori.morimoto.gx <kuninori.morimoto.gx@renesas.com>; geert <geert@linux-m68k.org>
Cc: ysato <ysato@users.sourceforge.jp>; dalias <dalias@libc.org>; linux-sh <linux-sh@vger.kernel.org>; linux-renesas-soc <linux-renesas-soc@vger.kernel.org>
Sent: Tue, Dec 17, 2019 4:09 am
Subject: Re: can someone solve string_32.h issue for SH ?


Hello,

Give me a day or so and I can do the following things:

1) Write you all a brand new standards-conforming strncpy in SH4 asm like this that is easier to read
2) Compile it with sh4-elf-GCC 9.2
3) Test it on a real SH4 (SH7750/SH7750R-like) 

The warning, if it shows up in my test, would likely then be a GCC thing--I have an idea of what it's doing, but I'll be sure after that.
Unfortunately it's 4AM here on the other side of the world right now...
-Karl



-----Original Message-----
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>; Rich Felker <dalias@libc.org>; Linux-SH <linux-sh@vger.kernel.org>; Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Sent: Tue, Dec 17, 2019 3:51 am
Subject: Re: can someone solve string_32.h issue for SH ?



Hi Geert
Cc Yoshinori-san

> > --- a/arch/sh/include/asm/string_32.h
> > +++ b/arch/sh/include/asm/string_32.h
> > @@ -40,15 +40,15 @@ static inline char *strncpy(char *__dest, const
> > char *__src, size_t __n)
> >         __asm__ __volatile__(
> >                 "1:\n"
> >                 "mov.b  @%1+, %2\n\t"
> > -               "mov.b  %2, @%0\n\t"
> > +               "mov.b  %2, @%0+\n\t"
> >                 "cmp/eq #0, %2\n\t"
> >                 "bt/s   2f\n\t"
> > -               " cmp/eq        %5,%1\n\t"
> > +               " cmp/eq        %5,%0\n\t"
> >                 "bf/s   1b\n\t"
> > -               " add   #1, %0\n"
> > +               " nop\n"
> >                 "2:"
> >                 : "=r" (__dest), "=r" (__src), "=&z" (__dummy)
> > -               : "0" (__dest), "1" (__src), "r" (__src+__n)
> > +               : "0" (__dest), "1" (__src), "r" (__dest+__n)
> >                 : "memory", "t");
> >
> >         return __xdest;
> >
> > Does this make sense?
> > Can it be improved, by putting something useful in the delay slot?
> 
> BTW, there seems to be a serious security issue with this strncpy()
> implementation: while it never writes more than n bytes in the
> destination buffer, it doesn't pad the destination buffer with zeroes if
> the source string is shorter than the buffer size.  This will leak
> data.

Yeah...
I can only do is "Reporting issue" to SH ML, unfortunately...

Thank you for your help !!
Best regards

---
Kuninori Morimoto
