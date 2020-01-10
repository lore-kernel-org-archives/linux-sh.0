From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 10 Jan 2020 00:13:53 +0000
Subject: Re: [PATCH][repost] sh: clkfwk: remove r8/r16/r32
Message-Id: <87d0bstbge.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87o8vdsceg.wl-kuninori.morimoto.gx@renesas.com>
        <87lfqhscac.wl-kuninori.morimoto.gx@renesas.com>
        <CAMuHMdWo2w=Uf-yKReg+BMjKk4otGqG0DE4urtWhVOTE9+o1kw@mail.gmail.com>
In-Reply-To: <CAMuHMdWo2w=Uf-yKReg+BMjKk4otGqG0DE4urtWhVOTE9+o1kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


Hi Geert

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > SH will get below warning
> >
> > ${LINUX}/drivers/sh/clk/cpg.c: In function 'r8':
> > ${LINUX}/drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of 'ioread8'
> >  discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
> >   return ioread8(addr);
> >                  ^~~~
> > In file included from ${LINUX}/arch/sh/include/asm/io.h:21,
> >                  from ${LINUX}/include/linux/io.h:13,
> >                  from ${LINUX}/drivers/sh/clk/cpg.c:14:
> > ${LINUX}/include/asm-generic/iomap.h:29:29: note: expected 'void *' but
> > argument is of type 'const void *'
> >  extern unsigned int ioread8(void __iomem *);
> >                              ^~~~~~~~~~~~~~
> >
> > We don't need "const" for r8/r16/r32.
> > And we don't need r8/r16/r32 themselvs.
> > This patch cleanup these.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks

> >  static int sh_clk_mstp_enable(struct clk *clk)
> >  {
> >         sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
> >         if (clk->status_reg) {
> > -               unsigned int (*read)(const void __iomem *addr);
> > +               unsigned int (*read)(void __iomem *addr);
> 
> While it is good to get rid of the wrappers, the change above will conflict with
> [PATCH v2 1/9] iomap: Constify ioreadX() iomem argument (as in generic
> implementation)
> (https://lore.kernel.org/lkml/20200108200528.4614-2-krzk@kernel.org/),
> which will add const to ioread*().

Oh, I see.
Will consider about it, and post v2

Thank you for your help !!
Best regards
---
Kuninori Morimoto
