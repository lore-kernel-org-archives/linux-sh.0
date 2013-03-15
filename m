From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 15 Mar 2013 13:04:04 +0000
Subject: Re: [PATCH v2 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <45447540.Y2s6eErJQT@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1363271746-9806-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <51431A5E.1090308@cogentembedded.com>
In-Reply-To: <51431A5E.1090308@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hi Sergei,

On Friday 15 March 2013 16:55:58 Sergei Shtylyov wrote:
> On 14-03-2013 18:35, Laurent Pinchart wrote:
> > Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
> > and DU1 LVDS outputs will require information about the panels that will
> > be connected to those outputs.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> [...]
> 
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
> 
> Forgot to add: we're supoosed to use the new gic_iid() macro instead.

Thanks for pointing this out. I've based this patch on mainline where 
gic_iid() isn't available yet. I'll make sure to rebase on Simon's tree before 
sending a pull request.

-- 
Regards,

Laurent Pinchart

