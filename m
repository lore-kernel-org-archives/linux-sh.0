From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 22 Sep 2015 07:00:28 +0000
Subject: Re: [PATCH 1/3] pinctrl: sh-pfc: Remove hardcoded IRQ numbers
Message-Id: <3252149.h0VXqpp3so@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1440797837-25516-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1440797837-25516-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 21 September 2015 14:20:20 Geert Uytterhoeven wrote:
> On Fri, Aug 28, 2015 at 11:37 PM, Laurent Pinchart wrote:
> > Now that all ARM-based Renesas SoCs use multiplatform kernels only the
> > hardcoded IRQ numbers can be dropped as they're dynamically allocated.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks for your patch!
> 
> > ---
> > 
> >  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 116  ++++++++++++++---------------
> >  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  68 ++++++++++----------
> >  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  68 ++++++++++----------
> >  drivers/pinctrl/sh-pfc/sh_pfc.h      |   7 +--
> >  4 files changed, 123 insertions(+), 136 deletions(-)
> > 
> > --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> > +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> > @@ -100,13 +100,8 @@ struct pinmux_irq {
> 
> Can you please also remove the "int irq" field that fell out of the diff
> context above, as it's now always zero?
> 
> Should gpio_pin_to_irq() now always return "pfc->irqs[i]", i.e. can we
> remove the check for "pfc->num_irqs", or is there a good reason to keep the
> check and return 0?

Sure, thank you for catching this.

> >         const short *gpios;
> >  };
> > 
> > -#ifdef CONFIG_ARCH_MULTIPLATFORM
> > -#define PINMUX_IRQ(irq_nr, ids...)                        \
> > +#define PINMUX_IRQ(ids...)                        \
> >         { .gpios = (const short []) { ids, -1 } }
> > -#else
> > -#define PINMUX_IRQ(irq_nr, ids...)                        \
> > -       { .irq = irq_nr, .gpios = (const short []) { ids, -1 } }
> > -#endif

-- 
Regards,

Laurent Pinchart

