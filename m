From: Simon Horman <horms@verge.net.au>
Date: Wed, 08 Jul 2015 02:05:15 +0000
Subject: Re: [PATCH] ARM: shmobile: rcar-gen2: CONFIG_ARM_ARCH_TIMER is always set
Message-Id: <20150708020511.GB14992@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436277927-20159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Jul 08, 2015 at 10:40:18AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jul 8, 2015 at 10:16 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jul 08, 2015 at 12:34:47AM +0900, Magnus Damm wrote:
> >> Hi Geert,
> >>
> >> On Wed, Jul 8, 2015 at 12:21 AM, Geert Uytterhoeven
> >> <geert@linux-m68k.org> wrote:
> >> > Hi Magnus,
> >> >

[snip]

> >> > HAVE_ARM_ARCH_TIMER used to be user-selectable, but your patch
> >> > "ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig" made that
> >> > unconditional for R-Car Gen2 and APE6 ;-)
> >>
> >> Ouch - my bad! That's not at all what I intended to do.
> >>
> >> I only wanted to express that R-Car Gen2 and APE6 come with arch timer
> >> hardware, and in such case the user shall be able to select it. If
> >> R-Car Gen2 or APE6 isn't selected then there is no point in exposing
> >> such choice to the user. But obviously that wasn't what I ended up
> >> doing...
> >>
> >> What would be a sane way to approach this? I think always enabling it
> >> may not work for CA7-based SoCs from Renesas that at least used to
> >> have setup issues with arch timer...
> >
> > Given the current arrangement in arch/arm/Kconfig:
> >
> > config HAVE_ARM_ARCH_TIMER
> >         bool "Architected timer support"
> >         depends on CPU_V7
> >         select ARM_ARCH_TIMER
> >         select GENERIC_CLOCKEVENTS
> >         help
> >           This option enables support for the ARM architected timer
> >
> > It seems to me that a good solution would be to (go back to?)
> > * not selecting HAVE_ARM_ARCH_TIMER in arch/arm/mach-shmobile/Kconfig and;
> > * enabling HAVE_ARM_ARCH_TIMER in defconfigs as appropriate
> 
> That is one idea for sure.
> 
> > Perhaps that can be achieved by dropping/reverting
> > * 731bde02f622 ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig
> > * b46ddcdf484c ARM: shmobile: Drop HAVE_ARM_ARCH_TIMER from defconfig
> >
> > At this stage I have not sent pull-requests for the above so I would
> > be feasible for me to simply drop them if we agree on that.
> 
> >From my side simply dropping seems the easiest way forward.

Me too.
Lets sit on this for a day or so and see what Geert and others have to say.

> This reminds me of the good old "generating kernel configuration from
> DT", so in the future if we may be able to do so then that could
> perhaps that shmobile_defconfig bit for us.

:)

> > FWIW, I assumed that your patch would achieve its goal.  The arrangement of
> > HAVE_ARM_ARCH_TIMER and ARM_ARCH_TIMER seems entirely intuitive to me. But
> > I'm reluctant to advise opening that Pandora's box.
> 
> Completely agree, but from my side you need to s/intuitive/counter
> intuitive/g. =)

Yes, sorry for that editing error.
