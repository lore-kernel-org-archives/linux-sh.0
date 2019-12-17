From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Dec 2019 08:50:22 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <CAMuHMdUtwFvab08A-Pqzs-33P-V3Ujcfbdx-RypbUwS8wsy5xQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdUHGXkmKrcZVNQo8nOcGo0h6xYgjZ+XmfGy6bJCPK9ZwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUHGXkmKrcZVNQo8nOcGo0h6xYgjZ+XmfGy6bJCPK9ZwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On Tue, Dec 17, 2019 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Dec 17, 2019 at 7:09 AM Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > We get too many below strncpy() warning on SH.
> > Can someone solve it ?
> > I don't remember SH assembler code / can't test it...
>
> I never touched SH assembler code at all.
> But it looks a bit like RISCified m68k, so let's give it a try ;-)
>
> > In file included from /home/morimoto/WORK/linux/arch/sh/include/asm/string.h:3,
> >                  from /home/morimoto/WORK/linux/include/linux/string.h:20,
> >                  from /home/morimoto/WORK/linux/include/linux/bitmap.h:9,
> >                  from /home/morimoto/WORK/linux/include/linux/nodemask.h:95,
> >                  from /home/morimoto/WORK/linux/include/linux/mmzone.h:17,
> >                  from /home/morimoto/WORK/linux/include/linux/gfp.h:6,
> >                  from /home/morimoto/WORK/linux/include/linux/slab.h:15,
> >                  from /home/morimoto/WORK/linux/drivers/mmc/host/vub300.c:38:
> > /home/morimoto/WORK/linux/drivers/mmc/host/vub300.c: In function 'new_system_port_status':
> > /home/morimoto/WORK/linux/arch/sh/include/asm/string_32.h:51:42: warning: array subscript 80 is above array bounds of 'char[26]' [-Warray-bounds]
> >    : "0" (__dest), "1" (__src), "r" (__src+__n)
> >                                      ~~~~~^~~~
>
> Yeah, these array warnings are (sometimes) a PITA.
>
> >         static inline char *strncpy(char *__dest, const char *__src, size_t __n)
> >         {
> >                 register char *__xdest = __dest;
> >                 unsigned long __dummy;
> >
> >                 if (__n = 0)
> >                         return __xdest;
> >
> >                 __asm__ __volatile__(
> >                         "1:\n"
> >                         "mov.b  @%1+, %2\n\t"
> >                         "mov.b  %2, @%0\n\t"
> >                         "cmp/eq #0, %2\n\t"
> >                         "bt/s   2f\n\t"
> >                         " cmp/eq        %5,%1\n\t"
> >                         "bf/s   1b\n\t"
> >                         " add   #1, %0\n"
> >                         "2:"
> >                         : "=r" (__dest), "=r" (__src), "=&z" (__dummy)
> > =>                      : "0" (__dest), "1" (__src), "r" (__src+__n)
> >                         : "memory", "t");
> >
> >                 return __xdest;
> >         }
>
>
> My first thought was to just replace "__src+__n" by "__dest+__n", and
> change the "cmp/eq" from "%1" (current src) to "%0" (current dst).
> However, "%0" isn't incremented until the branch delay slot of the loop.
> So I had to move the increment up, and fill the branch delay slot with a nop.
>
> Untested (it-compiles-so-it-must-be-perfect ;-) whitespace-damaged patch:
>
> --- a/arch/sh/include/asm/string_32.h
> +++ b/arch/sh/include/asm/string_32.h
> @@ -40,15 +40,15 @@ static inline char *strncpy(char *__dest, const
> char *__src, size_t __n)
>         __asm__ __volatile__(
>                 "1:\n"
>                 "mov.b  @%1+, %2\n\t"
> -               "mov.b  %2, @%0\n\t"
> +               "mov.b  %2, @%0+\n\t"

While this compiles for SH2, it doesn't for SH4 :-(

>                 "cmp/eq #0, %2\n\t"
>                 "bt/s   2f\n\t"
> -               " cmp/eq        %5,%1\n\t"
> +               " cmp/eq        %5,%0\n\t"
>                 "bf/s   1b\n\t"
> -               " add   #1, %0\n"
> +               " nop\n"
>                 "2:"
>                 : "=r" (__dest), "=r" (__src), "=&z" (__dummy)
> -               : "0" (__dest), "1" (__src), "r" (__src+__n)
> +               : "0" (__dest), "1" (__src), "r" (__dest+__n)
>                 : "memory", "t");
>
>         return __xdest;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
