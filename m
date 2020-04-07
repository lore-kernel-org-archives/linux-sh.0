From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Apr 2020 07:07:56 +0000
Subject: Re: [PATCH 6/9] clk: Allow the common clk framework to be selectable
Message-Id: <CAMuHMdV=rqpfmxtS+_kFeSiPs7cg6h2nTw4YmBKb=4kn0PuGgg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200405025123.154688-1-sboyd@kernel.org>
 <20200405025123.154688-7-sboyd@kernel.org>
 <CAK8P3a2M54quhRNK4xvwjz9O9oZwgrobc_wtkGaeA2PMYwOUdg@mail.gmail.com>
 <158614207114.88454.6776609424163493475@swboyd.mtv.corp.google.com>
 <CAK8P3a3Yt2woG2LMcQ0jNPGuHdMtFbBmLvtBbrWFQ4J6x3v9aQ@mail.gmail.com>
 <8a2a142a-106a-4241-fca5-5ef12e66cd41@linux-m68k.org>
In-Reply-To: <8a2a142a-106a-4241-fca5-5ef12e66cd41@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Mark Brown <broonie@kernel.org>, Mark Salter <msalter@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Guan Xuetao <gxt@pku.edu.cn>, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org

Hi Greg,

On Tue, Apr 7, 2020 at 6:57 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 6/4/20 5:35 pm, Arnd Bergmann wrote:
> > On Mon, Apr 6, 2020 at 5:01 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >> Quoting Arnd Bergmann (2020-04-05 05:45:20)
> >>> On Sun, Apr 5, 2020 at 4:51 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >>>> There's one snag with doing this, and that's making sure that randconfig
> >>>> builds don't select this option when some architecture or platform
> >>>> implements 'struct clk' outside of the common clk framework. Introduce a
> >>>> new config option 'HAVE_LEGACY_CLK' to indicate those platforms that
> >>>> haven't migrated to the common clk framework and therefore shouldn't be
> >>>> allowed to select this new config option. Also add a note that we hope
> >>>> one day to remove this config entirely.

> >>>> --- a/arch/m68k/Kconfig.cpu
> >>>> +++ b/arch/m68k/Kconfig.cpu
> >>>
> >>>     text    data     bss     dec     hex filename
> >>> 1934726 263616   83284 2281626 22d09a obj/vmlinux-before
> >>> 1971989 266192   83308 2321489 236c51 obj/vmlinux-after
> >>>
> >>> The coldfire clock implementation looks rather simple compared
> >>> to chips from the 2010s: most chips have only fixed clocks,
> >>> and three of them have one of two registers of clock gates.
> >>>
> >>> It shouldn't be hard to convert, but enabling common-clk will
> >>> cause a noticeable kernel size increase on the fairly limited
> >>> hardware.
> >>>
> >>> Simply enabling COMMON_CLK in m5475evb_defconfig
> >>> results in a 1.7% or 40KB growth in kernel size, plus there
> >>> would be additional dynamic memory usage:
> >> There could certainly be some work done to reduce the code size of the
> >> CCF. I haven't looked but perhaps we could save some memory by making
> >> the basic types selectable too and then push a bunch of kconfig updates
> >> through for that.
> >
> > Right, that might help. Another possibility would be to support both
> > the common clk layer and the custom clk implementation on coldfire
> > until we remove the other custom implementations, by which point
> > even fewer people will care about coldfire.
> >
> > Let's see what Geert and Greg think would be the best path for coldfire,
> > maybe the added 40KB is less of a problem after all.
>
> Losing another 40k is not ideal, but not the end of the world.
> It would not stop me running it on any platforms I regularly
> run on. For sure some of the really old hardware just doesn't
> have the RAM to spare.
>
> Any way, I say we have to move forward and and move to using
> the common clock framework for ColdFire sooner than later.

Fine for me.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
