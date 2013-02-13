From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Feb 2013 16:16:36 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: fix kzm9g-reference compile breakage
Message-Id: <2724030.TJfu2jxRFd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1302121535330.7059@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302121535330.7059@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 13 February 2013 11:31:19 Simon Horman wrote:
> On Tue, Feb 12, 2013 at 03:55:55PM +0100, Guennadi Liakhovetski wrote:
> > Recently many pin function names have been removed, as their users have
> > been switched to use pinctrl. However, kzm9g-reference has been left
> > unchanged, which broke its compilation. Fix this by switching over to
> > pinctrl.
> 
> Thanks.
> 
> I'm rather unsure what to do about this.
> 
> On the one hand I would rather if the basic kzm9g-reference code didn't
> depend on any more pinmux changes to allow it to flow upstream sooner than
> later.
> 
> On the other hand things are clearly broken without some modifications to
> the kzm9g-reference code to accomodate the pinmux changes.

Given that only two small patches are needed to fix the issue, I believe we 
could sort this out in a "first come, first served" way. If the kzm9g-
reference branch gets ready for mainline before my remaining pinctrl changes, 
you can push it as-is, and I'll take the two patches listed below in my tree. 
If the timeline is shifted the other way around, you will just need to take 
the two patches in your tree.

Would that work for you ?

> The approach that I have taken is to incrementally add the changes
> you outline below as patches within the following series.
> 
> 1. Date: Thu, 10 Jan 2013 21:51:33 +0100
>    From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>    Subject: [PATCH 00/16] SCIF, I2C and FSI pinctrl functions for sh73a0
>    Message-Id:
> <1357851109-22103-1-git-send-email-laurent.pinchart+renesas@ideasonboard.co
> m>
> 
> 2. Date: Wed,  9 Jan 2013 02:03:07 +0100
>    From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>    Subject: [PATCH v2 0/8] SH pinctrl DT support
>    Message-Id:
> <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com
> >
> 
> I will post the patches in the form of updates series a little later.
> 
> I have re-rearranged the topic branches as follows.
> 
> * I have created a merge of boards-kzm9g-reference and other dependencies
>   as topic/pinmux-base. This is a new topic branch.
> 
> * I have then applied the following series.
>   This is in topic/pinmux-pinctrl, a new topic branch.
> 
>   Date: Wed,  9 Jan 2013 01:52:20 +0100
>   From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>   Subject: [PATCH v2 00/29] SH pinctrl and pinmux implementation
>   Message-Id:
> <1357692769-1432-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com
> >
> 
>   Actually, this series is git://linuxtv.org/pinchartl/fbdev.git
> pinmux-pinctl It does not seem to differ from what was posted via email.
> 
> * I have then applied "[PATCH 00/16] SCIF, I2C and FSI pinctrl functions
>   for sh73a0" as topic/pinmux-pfc-funcs. This is a new topic branch.
> 
>   Actually, this series is git://linuxtv.org/pinchartl/fbdev.git
> pinmux-pfc-funcs which differs from what was most recently posted to email.
>   I have also added two kzm9g-reference patches. I will post the result
>   for review by yourself, Laurent and others.
> 
> * I have then applied ""[PATCH v2 0/8] SH pinctrl DT support"
>   as topic/pinmux-dt. This is a new topic branch.
> 
>   Actually, this series is git://linuxtv.org/pinchartl/fbdev.git pinmux-dt
>   It does not seem to differ from what was posted via email.
> 
>   I have also added a kzm9g-reference patch. I will post the result
>   for review by yourself, Laurent and others.
> 
> * I have re-merged next and all topic branches into topic/all+next
> 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   12 ++++++++++++
> >  arch/arm/mach-shmobile/board-kzm9g-reference.c |   18 +++++++++---------
> >  2 files changed, 21 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts index 7fad4b9..fe0ee98
> > 100644
> > --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> > @@ -71,6 +71,18 @@
> > 
> >  	};
> >  
> >  };
> > 
> > +&i2c3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c3_pins>;
> > +};
> > +
> > +&gpio {
> > +	i2c3_pins: pfc_i2c3_pins {
> > +		renesas,pins = "i2c3_1";
> > +		renesas,function = "i2c3";
> > +	};
> > +};
> > +
> > 
> >  &mmcif {
> >  
> >  	bus-width = <8>;
> >  	vmmc-supply = <&reg_1p8v>;
> > 
> > diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > b/arch/arm/mach-shmobile/board-kzm9g-reference.c index d86f093..989bdf4
> > 100644
> > --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> > @@ -26,21 +26,25 @@
> > 
> >  #include <linux/irq.h>
> >  #include <linux/input.h>
> >  #include <linux/of_platform.h>
> > 
> > +#include <linux/pinctrl/machine.h>
> > 
> >  #include <mach/sh73a0.h>
> >  #include <mach/common.h>
> >  #include <asm/hardware/cache-l2x0.h>
> >  #include <asm/mach-types.h>
> >  #include <asm/mach/arch.h>
> > 
> > +static const struct pinctrl_map kzm_pinctrl_map[] = {
> > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
> > +				  "scifa4_data", "scifa4"),
> > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
> > +				  "scifa4_ctrl", "scifa4"),
> > +};
> > +
> > 
> >  static void __init kzm_init(void)
> >  {
> >  
> >  	sh73a0_add_standard_devices_dt();
> > 
> > -	/* enable SCIFA4 */
> > -	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
> > -	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
> > -	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
> > -	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
> > +	pinctrl_register_mappings(kzm_pinctrl_map, 
ARRAY_SIZE(kzm_pinctrl_map));
> > 
> >  	/* enable MMCIF */
> >  	gpio_request(GPIO_FN_MMCCLK0,		NULL);
> > 
> > @@ -75,10 +79,6 @@ static void __init kzm_init(void)
> > 
> >  	gpio_request(GPIO_FN_SDHICLK2,		NULL);
> >  	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
> > 
> > -	/* I2C 3 */
> > -	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
> > -	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
> > -
> > 
> >  #ifdef CONFIG_CACHE_L2X0
> >  
> >  	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
> >  	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
Regards,

Laurent Pinchart

