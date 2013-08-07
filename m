From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 07 Aug 2013 22:19:44 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: r8a7779: Add DU support
Message-Id: <3262902.3LSh5HWAFe@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the review.

On Wednesday 07 August 2013 21:20:54 Sergei Shtylyov wrote:
> On 08/07/2013 08:19 PM, Laurent Pinchart wrote:
> > Add a function to register the DU device with board-specific platform
> > data. The DU device is named rcar-du-r8a7779, fix the clock entry
> > accordingly.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h
> > b/arch/arm/mach-shmobile/include/mach/r8a7779.h index f08d6ec..83c47a2
> > 100644
> > --- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
> > +++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
> > @@ -6,6 +6,7 @@
> >   #include <linux/sh_eth.h>
> >   
> >   struct platform_device;
> > +struct rcar_du_platform_data;
> > 
> >   struct r8a7779_pm_ch {
> >   	unsigned long chan_offs;
> > @@ -31,6 +32,7 @@ extern void r8a7779_earlytimer_init(void);
> >   extern void r8a7779_add_early_devices(void);
> >   extern void r8a7779_add_standard_devices(void);
> >   extern void r8a7779_add_standard_devices_dt(void);
> > +extern void r8a7779_add_du_device(struct rcar_du_platform_data *pdata);
> >   extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
> >   extern void r8a7779_init_late(void);
> >   extern void r8a7779_clock_init(void);
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> > b/arch/arm/mach-shmobile/setup-r8a7779.c index 6a99333..c587fc9 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> > @@ -27,6 +27,7 @@
> >   #include <linux/of_platform.h>
> >   #include <linux/platform_data/gpio-rcar.h>
> >   #include <linux/platform_data/irq-renesas-intc-irqpin.h>
> > +#include <linux/platform_data/rcar-du.h>
> 
> Why not just include it in the r8a7779.h?

Because not all users of r8a7779.h needs the rcar-du.h header. Including the 
header only where it is needed speeds up compilation.

> >   #include <linux/platform_device.h>
> >   #include <linux/delay.h>
> >   #include <linux/input.h>
> > @@ -605,6 +606,12 @@ static struct resource ether_resources[] __initdata > > {> 
> >   	},
> >   };
> > 
> > +/* DU */
> > +static struct resource du_resources[] = {
> 
>     Should be annotated with '__initdata'.

Good point, I'll fix that and resubmit (same for the other patches in this 
series).

> > +	DEFINE_RES_MEM(0xfff80000, 0x40000),
> > +	DEFINE_RES_IRQ(gic_iid(0x3f)),
> > +};
> > +

-- 
Regards,

Laurent Pinchart

