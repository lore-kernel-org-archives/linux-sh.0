From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Mar 2013 20:11:14 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <3727288.GPvHJIxomY@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1363271746-9806-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51420A3C.1030305@cogentembedded.com>
In-Reply-To: <51420A3C.1030305@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hi Sergei,

On Thursday 14 March 2013 21:34:52 Sergei Shtylyov wrote:
> On 14-03-2013 18:35, Laurent Pinchart wrote:
> > Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
> > and DU1 LVDS outputs will require information about the panels that will
> > be connected to those outputs.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/configs/marzen_defconfig     |  2 ++
> >   arch/arm/mach-shmobile/board-marzen.c | 65 +++++++++++++++++++++++++++++
> >   2 files changed, 67 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-marzen.c
> > b/arch/arm/mach-shmobile/board-marzen.c index cdcb799..0020506 100644
> > --- a/arch/arm/mach-shmobile/board-marzen.c
> > +++ b/arch/arm/mach-shmobile/board-marzen.c
> 
> [...]
> 
> > @@ -147,6 +148,38 @@ static struct platform_device hspi_device = {
> >   	.num_resources	= ARRAY_SIZE(hspi_resources),
> >   };
> > 
> > +/* DU */
> > +static struct resource rcar_du_resources[] = {
> > +	[0] = {
> > +		.name	= "Display Unit",
> > +		.start	= 0xfff80000,
> > +		.end	= 0xfffb1007,
> > +		.flags	= IORESOURCE_MEM,
> > +	},
> > +	[1] = {
> > +		.start	= gic_spi(31),
> > +		.flags	= IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static struct rcar_du_platform_data rcar_du_pdata = {
> > +	.encoders = {
> > +		[0] = {
> > +			.encoder = RCAR_DU_ENCODER_VGA,
> > +		},
> > +	},
> > +};
> > +
> > +static struct platform_device rcar_du_device = {
> > +	.name		= "rcar-du",
> > +	.num_resources	= ARRAY_SIZE(rcar_du_resources),
> > +	.resource	= rcar_du_resources,
> > +	.dev	= {
> > +		.platform_data = &rcar_du_pdata,
> > +		.coherent_dma_mask = ~0,
> > +	},
> > +};
> > +
> 
> Are we seeing again SoC device declared in the board file? That simply
> doesn't scale...

The goal is obviously to move all that to DT, but there's no DT bindings for 
the DU DRM driver yet.

-- 
Regards,

Laurent Pinchart

