From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:15:43 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <2915363.uaXXQQezT6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1364407550-30652-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364407550-30652-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Wednesday 27 March 2013 23:10:47 Sergei Shtylyov wrote:
> Hello.
> 
> On 03/27/2013 09:05 PM, Laurent Pinchart wrote:
> > Support the DU0 VGA and DU1 LVDS outputs. DU1 is connected to a
> > Mitsubishi AA104XD12 panel (10.4" XGA).
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> [...]
> 
> > diff --git a/arch/arm/mach-shmobile/include/mach/common.h
> > b/arch/arm/mach-shmobile/include/mach/common.h index 4531872..03f73de
> > 100644
> > --- a/arch/arm/mach-shmobile/include/mach/common.h
> > +++ b/arch/arm/mach-shmobile/include/mach/common.h
> > @@ -68,7 +68,6 @@ extern void r8a7779_earlytimer_init(void);
> > 
> >   extern void r8a7779_add_early_devices(void);
> >   extern void r8a7779_add_standard_devices(void);
> >   extern void r8a7779_add_standard_devices_dt(void);
> > 
> > -extern void r8a7779_add_du_device(void *pdata);
> 
>     Er...
> 
> >   extern void r8a7779_clock_init(void);
> >   extern void r8a7779_pinmux_init(void);
> >   extern void r8a7779_pm_init(void);
> > 
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c
> > b/arch/arm/mach-shmobile/setup-r8a7779.c index 2f817d8..a460ba3 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7779.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
> > @@ -393,29 +393,6 @@ static struct platform_device sata_device = {
> >   	},
> >   };
> > 
> > -static struct resource du_resources[] = {
> > -	[0] = {
> > -		.name	= "Display Unit",
> > -		.start	= 0xfff80000,
> > -		.end	= 0xfffb1007,
> > -		.flags	= IORESOURCE_MEM,
> > -	},
> > -	[1] = {
> > -		.start	= gic_iid(0x3f),
> > -		.flags	= IORESOURCE_IRQ,
> > -	},
> > -};
> > -
> > -static struct platform_device du_device = {
> > -	.name		= "rcar-du",
> > -	.num_resources	= ARRAY_SIZE(du_resources),
> > -	.resource	= du_resources,
> > -	.id		= 0,
> > -	.dev	= {
> > -		.coherent_dma_mask = ~0,
> > -	},
> > -};
> > -
> >   static struct platform_device *r8a7779_devices_dt[] __initdata = {
> >   	&scif0_device,
> >   	&scif1_device,
> > @@ -451,13 +428,6 @@ void __init r8a7779_add_standard_devices(void)
> >   			    ARRAY_SIZE(r8a7779_late_devices));
> >   }
> > 
> > -void __init r8a7779_add_du_device(void *pdata)
> > -{
> > -	du_device.dev.platform_data = pdata;
> > -
> > -	platform_device_register(&du_device);
> > -}
> > -
> >   /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
> >   void __init __weak r8a7779_register_twd(void) { }
> 
>     I didn't get this part. Why are you removing the platform device
>   and function?

My bad. That wasn't meant at all. I'll resubmit.

-- 
Regards,

Laurent Pinchart

