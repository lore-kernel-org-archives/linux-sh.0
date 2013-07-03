From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Jul 2013 06:23:44 +0000
Subject: Re: [PATCH v3 5/7] ARM: shmobile: r8a7740: add DT nodes for three DMAC instance
Message-Id: <Pine.LNX.4.64.1307030811410.10000@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
 <1372257656-9944-6-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoT6tgy8rzyQtLZpZdjPUK6WptMuBQEfAPqdO_ySFawu-g@mail.gmail.com>
In-Reply-To: <CANqRtoT6tgy8rzyQtLZpZdjPUK6WptMuBQEfAPqdO_ySFawu-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Magnus

On Wed, 3 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> On Wed, Jun 26, 2013 at 11:40 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > This patch adds Device Tree support for the three DMA controller instances
> > on r8a7740 in a DMA multiplexer node.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >  arch/arm/boot/dts/r8a7740.dtsi         |   62 ++++++++++++++++++++++++++++++++
> >  arch/arm/mach-shmobile/setup-r8a7740.c |   12 ++++++
> >  2 files changed, 74 insertions(+), 0 deletions(-)
> 
> Thanks for your work on this.
> 
> > --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> > @@ -996,7 +996,19 @@ void __init r8a7740_add_early_devices(void)
> >
> >  #ifdef CONFIG_USE_OF
> >
> > +static struct of_dev_auxdata r8a7740_dmac_auxdata[] = {
> > +       OF_DEV_AUXDATA("renesas,shdma", 0xfe008020, "sh-dma-engine.0",
> > +                      &dma_platform_data),
> > +       OF_DEV_AUXDATA("renesas,shdma", 0xfe018020, "sh-dma-engine.1",
> > +                      &dma_platform_data),
> > +       OF_DEV_AUXDATA("renesas,shdma", 0xfe028020, "sh-dma-engine.2",
> > +                      &dma_platform_data),
> > +       { }
> > +};
> > +
> >  static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
> > +       OF_DEV_AUXDATA("renesas,shdma-mux", 0, "shdma-of.0",
> > +                      r8a7740_dmac_auxdata),
> >         { }
> >  };
> 
> Uhm, what is the reason for adding AUXDATA? For all other cases we
> have clearly separated the DT reference bits from the C version
> without using AUXDATA. With that approach we can use the default NULL
> callbacks for ->init_machine(). Now with this patch we're going in the
> totally different direction...
> 
> Why can't you use DT only for these?

Short answer - because that's how the SH DMA driver, currently in the 
"next" tree ready for Linus to be pulled, is implemented. We had enough 
time to discuss this back then, I think, it is a pity this question is 
raised only now.

A while ago I read, that it is ok to pass SoC-specific device properties 
via auxdata, as opposed to board-specific ones, that have to go via DT. On 
shmobile this is also easy to implement - all devices, initialised from 
setup-<soc>.c, i.e. having no board-specific configuration, and defined in 
<soc>.dtsi can just take their configuration from the same platform data, 
as in .c case. Another motivation for this is, that we want to get rid of 
board-<name>.c files, but we'll always have setup-<soc>.c files. With that 
in mind I implemented DMAC DT bindings and that also allowed us to so 
quickly get them accepted into the mainline. If we needed to initialise 
DMAC completely from DT, mainlining would certainly take much longer.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
