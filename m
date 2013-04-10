From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 02:17:57 +0000
Subject: Re: [RFC][PATCH 3/4] ARM: shmobile: r8a7778: Register PFC drivce
Message-Id: <20130410021757.GM11105@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 04:24:19PM +0200, Laurent Pinchart wrote:
> Hi Morimoto-san,
> 
> Thank you for the patch.
> 
> On Monday 08 April 2013 22:33:56 Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> With the drivce replaced by device in the subject line,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up in the soc-r7a7778 branch with the subject
corrected.

> > ---
> >  arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
> >  arch/arm/mach-shmobile/setup-r8a7778.c        |   13 +++++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h
> > b/arch/arm/mach-shmobile/include/mach/r8a7778.h index 951149e..68053fc
> > 100644
> > --- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
> > +++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> > @@ -28,5 +28,6 @@ extern void r8a7778_init_irq(void);
> >  extern void r8a7778_init_irq_dt(void);
> >  extern void r8a7778_clock_init(void);
> >  extern void r8a7778_init_irq_extpin(int irlm);
> > +extern void r8a7778_pinmux_init(void);
> > 
> >  #endif /* __ASM_R8A7778_H__ */
> > diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c
> > b/arch/arm/mach-shmobile/setup-r8a7778.c index d6ee521..6c1cc80 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> > @@ -102,6 +102,19 @@ void __init r8a7778_add_ether_device(struct
> > sh_eth_plat_data *pdata) pdata, sizeof(*pdata));
> >  }
> > 
> > +/* PFC */
> > +static struct resource pfc_resources[] = {
> > +	DEFINE_RES_MEM(0xfffc0000, 0x118),
> > +};
> > +
> > +void __init r8a7778_pinmux_init(void)
> > +{
> > +	platform_device_register_simple(
> > +		"pfc-r8a7778", -1,
> > +		pfc_resources,
> > +		ARRAY_SIZE(pfc_resources));
> > +}
> > +
> >  void __init r8a7778_add_standard_devices(void)
> >  {
> >  	int i;
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
