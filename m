From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Sep 2014 21:50:19 +0000
Subject: Re: [PATCH v2 06/10] ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree
Message-Id: <2605571.HI4GqTov6v@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 04 September 2014 16:10:25 Simon Horman wrote:
> On Tue, Sep 02, 2014 at 11:13:02AM +0200, Ulrich Hecht wrote:
> > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > ---
> > 
> >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  4 ++++
> >  arch/arm/mach-shmobile/setup-sh73a0.c        | 11 +----------
> 
> Please split this into two patches, one per file.

This would break bisection.

> >  2 files changed, 5 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts index e33d698..83c6058
> > 100644
> > --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > @@ -177,6 +177,10 @@
> >  	clock-frequency = <48000000>;
> >  };
> > 
> > +&cmt1 {
> > +	status = "ok";
> > +};
> > +
> >  &i2c0 {
> >  	status = "okay";
> >  	as3711@40 {
> > diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> > b/arch/arm/mach-shmobile/setup-sh73a0.c index 6d73b83..2c6ef79 100644
> > --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> > +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> > @@ -697,10 +697,6 @@ static struct platform_device irqpin3_device = {
> >  	},
> >  };
> > 
> > -static struct platform_device *sh73a0_devices_dt[] __initdata = {
> > -	&cmt1_device,
> > -};
> > -
> >  static struct platform_device *sh73a0_early_devices[] __initdata = {
> >  	&scif0_device,
> >  	&scif1_device,
> > @@ -713,6 +709,7 @@ static struct platform_device *sh73a0_early_devices[]
> > __initdata = {> 
> >  	&scif8_device,
> >  	&tmu0_device,
> >  	&ipmmu_device,
> > +	&cmt1_device,
> >  };
> >  
> >  static struct platform_device *sh73a0_late_devices[] __initdata = {
> > @@ -737,8 +734,6 @@ void __init sh73a0_add_standard_devices(void)
> > 
> >  	/* Clear software reset bit on SY-DMAC module */
> >  	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
> > -	platform_add_devices(sh73a0_devices_dt,
> > -			    ARRAY_SIZE(sh73a0_devices_dt));
> >  	platform_add_devices(sh73a0_early_devices,
> >  			    ARRAY_SIZE(sh73a0_early_devices));
> >  	platform_add_devices(sh73a0_late_devices,
> > @@ -765,8 +760,6 @@ void __init sh73a0_earlytimer_init(void)
> > 
> >  void __init sh73a0_add_early_devices(void)
> >  {
> > -	early_platform_add_devices(sh73a0_devices_dt,
> > -				   ARRAY_SIZE(sh73a0_devices_dt));
> >  	early_platform_add_devices(sh73a0_early_devices,
> >  				   ARRAY_SIZE(sh73a0_early_devices));
> > 
> > @@ -782,8 +775,6 @@ void __init sh73a0_add_standard_devices_dt(void)
> >  #ifndef CONFIG_COMMON_CLK
> >  	sh73a0_clock_init();
> >  #endif
> > -	platform_add_devices(sh73a0_devices_dt,
> > -			     ARRAY_SIZE(sh73a0_devices_dt));
> >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> >  }

-- 
Regards,

Laurent Pinchart

