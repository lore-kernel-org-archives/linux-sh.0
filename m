From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 Sep 2015 09:33:48 +0000
Subject: Re: [PATCH][RFC] clk: Use node name and index for clock name
Message-Id: <CANqRtoTWT-ZALYDFMRy_cGNQHb30jWe-X5CeKG-zV0PN7L6vDA@mail.gmail.com>
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
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, SH-Linux <linux-sh@vger.kernel.org>, "Simon Horman [Horms]" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Stephen,

Thanks for your feedback!

On Thu, Sep 10, 2015 at 6:39 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
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
>>
>
> We've been murmuring about moving away from string based parent
> child relationship descriptions for some time now. Nothing very
> concrete has come out though and I haven't thought about it in
> too much detail.

My half-cooked attempt to fix this was posted yesterday:
[PATCH 00/05][RFC] Clock registration without parent name
http://www.spinics.net/lists/linux-clk/msg02960.html

If you have any ideas how that series can be beaten into something you
like then please let me know.

> Why can't we call clk_get() for the clocks that we need to find
> the name of, and then call __clk_get_name() on them? Doing
> clk_get() has the nice side-effect of ordering probe for
> different clock controller drivers so that things like
> suspend/resume are done in the correct order.

I think __get_clk_name() makes sense in general as long as we can
produce some sane names for the clocks while registering.

In my mind the choices we have for naming clocks for registration are:
a) Based on the DT clock-output-names property
b) Hard coded string defined in C code
c) Built on DT node name and DT clock-indices property (if present -
and no clock-output-names in DT)

Maybe there are other options? I don't mind so much in general which
one to go with, but at the same time I can see the beauty of not
making the DT clock-output-names property mandatory from a DT
perspective. So I like the approach of defaulting to c) but allow DT
to override using a). In my mind all of a) -> c) above should work
with the core clock code. Please let me know if my understanding is
wrong.

Like mentioned in earlier email, the case c) above does not work when
using of_clk_get_parent_name(). Especially the function
of_fixed_factor_clk_setup() tries to point out the parent using
of_clk_get_parent_name() which prevents it from working if the parent
clock is named following the style in c). So we cannot use fixed
factor clocks without local patches if we go with c)..

As for clk_get() vs of_clk_get() (that my patch series above is
using), this seems to be tightly related to the driver model and how
to register clocks. clk_get() takes a struct device pointer while
of_clk_get() takes a struct device_node pointer.

I've always been a fan of using the standard driver model (initially
with platform devices with platform data, now DT). Over the years
various DT-specific init methods have creeped into the kernel - I
clearly recall such ones for clocksources, irqchip and clocks, but
gpio and pinctrl may also be affected. I've never really understood
the reason behind them - shouldn't using the regular driver model with
initcall order, linking order and deferred probing be enough?

Anyway, if you have time please share your ideas about naming a) - >c)
above and what your expectation is for new drivers. Same goes for
driver model usage - do you want us to move away from of_clk_init() to
regular driver model? of_clk_init() seems to manage probe order
correctly what I can tell, not sure about suspend/resume though.

From my side I mainly want to make our DT interface stable. So either
we use clock-output-names in DT to begin with and fix things
incrementally, or we omit clock-output-names from DT from the
beginning but if so we need to fix the clock core code so we can use
c) (or any other options).

Thanks for your help,

/ magnus
