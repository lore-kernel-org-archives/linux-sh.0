From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 26 Apr 2013 09:54:13 +0000
Subject: Re: [PATCH v4 30/88] ARM: shmobile: armadillo800eva: Register pinctrl mappings for SDHI and MMCIF
Message-Id: <3296309.YXgKFg3aQu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1363215633-4264-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363215633-4264-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Friday 26 April 2013 09:38:42 Guennadi Liakhovetski wrote:
> Hi Laurent
> 
> Maybe we can simplify this a bit by an incremental patch:
> 
> On Wed, 13 Mar 2013, Laurent Pinchart wrote:
> > Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
> > mappings.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/mach-shmobile/board-armadillo800eva.c | 58 ++++++++++-----------
> >  1 file changed, 25 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c
> > b/arch/arm/mach-shmobile/board-armadillo800eva.c index aa812cf..04eff93
> > 100644
> > --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> > +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> > @@ -657,6 +657,17 @@ static struct platform_device sdhi1_device = {
> >  	.resource	= sdhi1_resources,
> >  };
> > 
> > +static const struct pinctrl_map eva_sdhi1_pinctrl_map[] = {
> > +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
> > +				  "sdhi1_data4", "sdhi1"),
> > +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
> > +				  "sdhi1_ctrl", "sdhi1"),
> > +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
> > +				  "sdhi1_cd", "sdhi1"),
> > +	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
> > +				  "sdhi1_wp", "sdhi1"),
> > +};
> > +
> >  /* MMCIF */
> >  static struct sh_mmcif_plat_data sh_mmcif_plat = {
> >  	.sup_pclk	= 0,
> 
> [snip]
> 
> > @@ -1124,14 +1122,8 @@ static void __init eva_init(void)
> >  		/* CON14 enable */
> >  	} else {
> >  		/* CON8 (SDHI1) enable */
> > -		gpio_request(GPIO_FN_SDHI1_CLK,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_CMD,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_D0,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_D1,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_D2,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_D3,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_CD,	NULL);
> > -		gpio_request(GPIO_FN_SDHI1_WP,	NULL);
> > +		pinctrl_register_mappings(eva_sdhi1_pinctrl_map,
> > +					  ARRAY_SIZE(eva_sdhi1_pinctrl_map));
> 
> What if we just add SDHI1 pin mappings in the global array and register
> them together with the rest - it shouldn't hurt, right? They'd only be
> activated if the respective device is probed, and this won't happen unless
> we detect the respective switch position, right? So, we shouldn't need
> this separate map? Yes, I can cook up a patch, just wanted to check with
> you first.

Yes that's a good idea.

-- 
Regards,

Laurent Pinchart

