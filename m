From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 06 Apr 2020 07:35:34 +0000
Subject: Re: [PATCH 6/9] clk: Allow the common clk framework to be selectable
Message-Id: <CAK8P3a3Yt2woG2LMcQ0jNPGuHdMtFbBmLvtBbrWFQ4J6x3v9aQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200405025123.154688-1-sboyd@kernel.org> <20200405025123.154688-7-sboyd@kernel.org>
 <CAK8P3a2M54quhRNK4xvwjz9O9oZwgrobc_wtkGaeA2PMYwOUdg@mail.gmail.com> <158614207114.88454.6776609424163493475@swboyd.mtv.corp.google.com>
In-Reply-To: <158614207114.88454.6776609424163493475@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Guan Xuetao <gxt@pku.edu.cn>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "open list:BROADCOM NVRAM DRIVER <linux-mips@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org, linux-m68k
        <linux-m68k@lists.linux-m68k.org>, Linux ARM
        <linux-arm-kernel@lists.infradead.org>, Linux-sh list" <linux-sh@vger.kernel.org>, Greg Ungerer <gerg@linux-m68k.org>

On Mon, Apr 6, 2020 at 5:01 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Arnd Bergmann (2020-04-05 05:45:20)
> > On Sun, Apr 5, 2020 at 4:51 AM Stephen Boyd <sboyd@kernel.org> wrote:
> > > There's one snag with doing this, and that's making sure that randconfig
> > > builds don't select this option when some architecture or platform
> > > implements 'struct clk' outside of the common clk framework. Introduce a
> > > new config option 'HAVE_LEGACY_CLK' to indicate those platforms that
> > > haven't migrated to the common clk framework and therefore shouldn't be
> > > allowed to select this new config option. Also add a note that we hope
> > > one day to remove this config entirely.
> >
> > Good idea!
> >
> > I've looked through the individual ones and commented a bit on
> > what I think may or may not happen with them.
> >
> > ralink SOC_MT7621 is the only one that I think you got wrong,
> > as it already has common-clk support.
>
> Ah I missed that it was inside a big if RALINK. Thanks. I suppose I
> should just remove the select then for that config and not worry about
> the duplication of clkdev and common clk configs.

Won't that cause build failures in those configurations that have
both implementations?

According to the Makefile, the clk.c file is built whenever CONFIG_MIPS_GIC
is unset, so I think we need

         select HAVE_LEGACY_CLK if !MIPS_GIC

or maybe move the select into the per-chip configs that need it:
RT288X, RT305X, RT3883, and MT7620.

> > > diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> > > index 60ac1cd8b96f..bd2d29c22a10 100644
> > > --- a/arch/m68k/Kconfig.cpu
> > > +++ b/arch/m68k/Kconfig.cpu
> >
> >    text    data     bss     dec     hex filename
> > 1934726 263616   83284 2281626 22d09a obj/vmlinux-before
> > 1971989 266192   83308 2321489 236c51 obj/vmlinux-after
> >
> > The coldfire clock implementation looks rather simple compared
> > to chips from the 2010s: most chips have only fixed clocks,
> > and three of them have one of two registers of clock gates.
> >
> > It shouldn't be hard to convert, but enabling common-clk will
> > cause a noticeable kernel size increase on the fairly limited
> > hardware.
> >
> > Simply enabling COMMON_CLK in m5475evb_defconfig
> > results in a 1.7% or 40KB growth in kernel size, plus there
> > would be additional dynamic memory usage:
> There could certainly be some work done to reduce the code size of the
> CCF. I haven't looked but perhaps we could save some memory by making
> the basic types selectable too and then push a bunch of kconfig updates
> through for that.

Right, that might help. Another possibility would be to support both
the common clk layer and the custom clk implementation on coldfire
until we remove the other custom implementations, by which point
even fewer people will care about coldfire.

Let's see what Geert and Greg think would be the best path for coldfire,
maybe the added 40KB is less of a problem after all.

       Arnd
