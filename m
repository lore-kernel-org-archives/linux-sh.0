From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Dec 2019 08:51:45 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <871rt3gwri.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com>
        <CAMuHMdUHGXkmKrcZVNQo8nOcGo0h6xYgjZ+XmfGy6bJCPK9ZwQ@mail.gmail.com>
        <CAMuHMdUc4yyXsp4Y4Xx==3mUMrUn5DO8G-rLA_Mnv-790n6Ehg@mail.gmail.com>
In-Reply-To: <CAMuHMdUc4yyXsp4Y4Xx==3mUMrUn5DO8G-rLA_Mnv-790n6Ehg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


Hi Geert
Cc Yoshinori-san

> > --- a/arch/sh/include/asm/string_32.h
> > +++ b/arch/sh/include/asm/string_32.h
> > @@ -40,15 +40,15 @@ static inline char *strncpy(char *__dest, const
> > char *__src, size_t __n)
> >         __asm__ __volatile__(
> >                 "1:\n"
> >                 "mov.b  @%1+, %2\n\t"
> > -               "mov.b  %2, @%0\n\t"
> > +               "mov.b  %2, @%0+\n\t"
> >                 "cmp/eq #0, %2\n\t"
> >                 "bt/s   2f\n\t"
> > -               " cmp/eq        %5,%1\n\t"
> > +               " cmp/eq        %5,%0\n\t"
> >                 "bf/s   1b\n\t"
> > -               " add   #1, %0\n"
> > +               " nop\n"
> >                 "2:"
> >                 : "=r" (__dest), "=r" (__src), "=&z" (__dummy)
> > -               : "0" (__dest), "1" (__src), "r" (__src+__n)
> > +               : "0" (__dest), "1" (__src), "r" (__dest+__n)
> >                 : "memory", "t");
> >
> >         return __xdest;
> >
> > Does this make sense?
> > Can it be improved, by putting something useful in the delay slot?
> 
> BTW, there seems to be a serious security issue with this strncpy()
> implementation: while it never writes more than n bytes in the
> destination buffer, it doesn't pad the destination buffer with zeroes if
> the source string is shorter than the buffer size.  This will leak
> data.

Yeah...
I can only do is "Reporting issue" to SH ML, unfortunately...

Thank you for your help !!
Best regards
---
Kuninori Morimoto
