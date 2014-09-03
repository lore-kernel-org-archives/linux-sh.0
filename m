From: Mike Turquette <mturquette@linaro.org>
Date: Wed, 03 Sep 2014 14:56:59 +0000
Subject: Re: [PATCH v2 09/10] clk: shmobile: div6: support selectable-input clocks
Message-Id: <20140903145659.11368.60628@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-10-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-10-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Geert Uytterhoeven (2014-09-03 02:03:06)
> Hi Ulrich, Mike,
> 
> On Wed, Sep 3, 2014 at 9:48 AM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
> > On Wed, Sep 3, 2014 at 12:45 AM, Mike Turquette <mturquette@linaro.org> wrote:
> >> Quoting Ulrich Hecht (2014-09-02 02:13:05)
> >>> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> >>>
> >>> Support for setting the parent at initialization time based on the current
> >>> hardware configuration in DIV6 clocks with selectable parents as found in
> >>> the r8a73a4, r8a7740, sh73a0, and other SoCs.
> >>>
> >>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> I still have the same question about switching parents at run-time as I
> >> did in the last posting[0]. Is there a use case for modeling this clocks
> >> as proper muxes and switching parents dynamically?
> >
> > I have no idea, frankly. Laurent, can you comment on that?
> 
> Technically, it seems to be possible to switch parents at run-time.

Cool. You just need to know if switching parents is glitchless or not.
If switching is glitchless then you have nothing to worry about. If not
then you might need to set the CLK_SET_PARENT_GATE flag.

> 
> Of course, if we do that, we need a way to set up the parents.
> It's my understanding this is done explicitly (through clk_set_parent()),
> or implicitly (through clk_set_rate() and propagation). Is that correct?

Correct.

> The default would still be read from the hardware, like is done now, right?

This is done in __clk_init_parent(). This reads the hardware for mux
clocks (which MUST implement the .get_parent callback) and updates the
clock framework bookkeeping to use the correct parent at clock
registration-time.

Regards,
Mike

> 
> It seems we only configure rates explicitly for audio and video.
> For most drivers, we just use the rates as dictated by following the flow
> from the main crystal(s) through the clock topology and the divisors
> present within.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
