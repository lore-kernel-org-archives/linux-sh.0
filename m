From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 12:06:56 +0000
Subject: Re: [PATCH][RFC] clk: Use node name and index for clock name
Message-Id: <CAMuHMdXpwAcx679akueOtTpRVfJHkGsbjp_07qgkPRHTsRpObA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150909050554.27129.68718.sendpatchset@little-apple>
	<13888179.tcIA8DJW1S@avalon>
	<CANqRtoTE+jdavqQ0i5jHu=5REtPhf1xDVfREKC0XD2Bz=rf4kQ@mail.gmail.com>
	<1981230.p8F5aT0ffl@avalon>
	<20150909213910.GU15099@codeaurora.org>
In-Reply-To: <20150909213910.GU15099@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>

Hi Stephen,

On Wed, Sep 9, 2015 at 11:39 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 09/09, Laurent Pinchart wrote:
>> On Wednesday 09 September 2015 14:27:58 Magnus Damm wrote:
>> > On Wed, Sep 9, 2015 at 2:14 PM, Laurent Pinchart wrote:
>> > > Another issue is that this won't guarantee that the names are unique as
>> > > multiple DT nodes can have the same name. Instead of trying to generate
>> > > unique names, would it be possible to handle clock registration and
>> > > lookup without relying on names for DT-based platforms ?
>> >
>> > It would of course make sense to do that for the long run, but at the
>> > same time that sounds like major internal API rework since most
>> > functions operate on string clock names today. So for short term is
>> > the correct approach to use clock-output-names?
>>
>> I think Stephen and Mike should comment on that.
>
> We've been murmuring about moving away from string based parent
> child relationship descriptions for some time now. Nothing very
> concrete has come out though and I haven't thought about it in
> too much detail.

If you want to get rid of the names, clocks could just be numbers, cfr.
interrupts.

Unfortunately debugging interrupt problems became more difficult with the
advent of IRQ domains and the loss of fixed interrupt numbers. as I can no
longer predict which is the right interrupt number for a specific device.

> Why can't we call clk_get() for the clocks that we need to find
> the name of, and then call __clk_get_name() on them? Doing

Who defines the name of the clock?
For e.g. clk-rcar-gen3.c that can be C code.
For e.g. clk-mstp.c we used to take them from "clock-output-names" (old),
or auto-generate them (new?).

> clk_get() has the nice side-effect of ordering probe for
> different clock controller drivers so that things like
> suspend/resume are done in the correct order.

That's true.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
