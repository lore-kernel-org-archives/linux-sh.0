From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Aug 2011 07:17:29 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: ag5evm, ap4: Make use of irq index
Message-Id: <20110819071720.GD16419@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-5-git-send-email-horms@verge.net.au>
 <CANqRtoQL4cw2+71P5+1hU-2TUyV=gQJ9X2NN+_e_S3dgKeWWJA@mail.gmail.com>
 <20110819052004.GB17548@verge.net.au>
 <20110819063857.GC16419@verge.net.au>
 <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
In-Reply-To: <CANqRtoTu6G=Dut8eQb+aZPrQ9pF383tGHnQ6JNbH=R2wcuuNiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 03:51:49PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 3:39 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Aug 19, 2011 at 02:20:11PM +0900, Simon Horman wrote:
> >> On Fri, Aug 19, 2011 at 01:16:09PM +0900, Magnus Damm wrote:
> >> > On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > > This is intended to make it easier to correctly order IRQs.
> >> > >
> >> > > As suggested by Guennadi Liakhovetski.
> >> >
> >> > > --- a/arch/arm/mach-shmobile/board-ag5evm.c
> >> > > +++ b/arch/arm/mach-shmobile/board-ag5evm.c
> >> > > @@ -352,15 +352,15 @@ static struct resource sdhi0_resources[] = {
> >> > >                .end    = 0xee1000ff,
> >> > >                .flags  = IORESOURCE_MEM,
> >> > >        },
> >> > > -       [1] = {
> >> > > +       [1 + SH_MOBILE_SDHI_IRQ_CARD_DETECT] = {
> >> > >                .start  = gic_spi(83),
> >> > >                .flags  = IORESOURCE_IRQ,
> >> > >        },
> >> > > -       [2] = {
> >> > > +       [1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
> >> > >                .start  = gic_spi(84),
> >> > >                .flags  = IORESOURCE_IRQ,
> >> > >        },
> >> > > -       [3] = {
> >> > > +       [1 + SH_MOBILE_SDHI_IRQ_SDIO] = {
> >> > >                .start  = gic_spi(85),
> >> > >                .flags  = IORESOURCE_IRQ,
> >> > >        },
> >> >
> >> > Hm...
> >> >
> >> > So I know you guys have been discussing this back and forth, so I'm
> >> > not sure if jumping in to this thread makes things any better. But
> >> > anyhow, here are my opinions. Feel free to ignore them. =)
> >> >
> >> > First of all, having some kind of association with each IRQ is a good
> >> > thing. I am however not convinced that using the index number of the
> >> > platform device resource irq is the best option. Consider the case
> >> > when someone modifies the SDHI resource in the code above to only
> >> > include this interrupt:
> >> >
> >> >         [1 + SH_MOBILE_SDHI_IRQ_SDCARD] = {
> >> >                 .start  = gic_spi(84),
> >> >                 .flags  = IORESOURCE_IRQ,
> >> >         },
> >> >
> >> > >From my point of view, the common sense for this would be that only
> >> > the SDCARD interrupt would be enabled and the rest would be disabled
> >> > since they are unspecified. However, with the current code the
> >> > behavior would be something else, and since the index number of SDCARD
> >> > is not matching it will be detected as CARD_DETECT.
> >> >
> >> > So isn't it really ugly to depend on the number of IRQs when they are
> >> > supposed to be used as an index? I've been toying around with this
> >> > driver for a few years now, and when I have a hard time creating
> >> > correct platform data then it's _probably_ a sign that there must be
> >> > better ways to implement this.
> >> >
> >> > I would propose just adding interrupts in struct resource [] as usual,
> >> > and then have thee separate flags in the platform data for each
> >> > interrupt type. If the number of IRQ bits set in the platform data
> >> > flags doesn't match the number of interrupt resources then return
> >> > error. If they match then simply go through each flag set in the
> >> > platform data flags and assign next available interrupt resource. And
> >> > if no flags are set then go for the combined interrupt handler for all
> >> > available interrupt resources.
> >> >
> >> > That's what I would do at least. Any other ideas? Perhaps just keep an
> >> > array of interrupt numbers in the platform data as the sh-sci driver
> >> > does and use the fixed indexes there if non-zero?
> >>
> >> Hi Magnus,
> >>
> >> unfortunately during the course of the review of this series a number
> >> of changes have crept in which I regard as being tangential to the
> >> goal of the series - which is to introduce broken-out handlers (I have
> >> already introduce support for broken-out IRQ sources).
> >>
> >> One area where such changes have occurred is in the subtle altering of the
> >> list of IRQ sources that it is valid to supply (again, support for
> >> broken-out IRQ sources is not introduced by this series).
> >>
> >> With regards to your comment and example above. I believe that your
> >> understanding of my code is incorrect. The configuration you suggest will
> >> be rejected because CARD_DETECT is not supplied, not because of an index
> >> miss-match. It could be made acceptable within the current framework by
> >> simply loosening up the logic a little (specifically to allow CARD_DETECT
> >> to be omitted even if only one other IRQ source is supplied).  Incidently,
> >> I think that would make sense but Guennadi specifically asked for that
> >> combination to be regarded as invalid.
> >
> > [snip]
> >
> > After some discussion off-line I now realise that there is a problem
> > with my implementation. Specifically that it assumes that
> > platform_get_irq() takes into account the index of resource entries -
> > it does not.
> 
> Right, this is a thing that only bites you once. =)
> 
> > As we are already on the slippery slope of allowing combinations
> > other than 1 (legacy) or 3 (specific) IRQ sources I plan to implement
> > a variant of your flag idea. The variation being to use names instead
> > because a) that allows the use of platform_get_irq_byname() and b)
> > the flags bits seem to be full and not driver-specific.
> 
> Great, platform_get_irq_byname() seems like a perfect match.
> 
> May I suggest "hotplug", "data" and "sdio" as names? I don't care very
> much about names except keeping them short and precise to prevent
> errors that can only be caught during runtime.

Earlier on in the life of this series Guennadi suggested
the names "card_detect", "sdcard" and "sdio". While I am
not particularly attached to those names the do seem
reasonable and are already used consistently by this series.
So I would prefer to use those names.

> > And as are already on the slippery slope of allowing combinations
> > if IRQ sources beyond 1 and 3 I intend to implement logic to allow
> > any number of unique specific IRQ sources to be handled. In practice
> > hardware for some of these combinations is unlikely to exist. But that
> > doesn't seem to be a particularly good reason to add extra logic
> > to disallow them in the driver - its up to platform data to specify
> > something valid.
> 
> Yes, I totally agree. Thanks a lot for your help!
> 
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
