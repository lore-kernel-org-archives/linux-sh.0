From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 17 Jun 2013 10:38:59 +0000
Subject: Re: [PATCH] sh-pfc: r8a7778: tidyup MMC_D1 pin
Message-Id: <5007767.SaBT0HEMrY@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvwo6q8u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvwo6q8u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 17 June 2013 16:05:38 Simon Horman wrote:
> [ Actually CC Laurent ]
> 
> On Wed, Jun 12, 2013 at 05:23:38PM +0900, Simon Horman wrote:
> > On Tue, Jun 11, 2013 at 07:02:20PM -0700, Kuninori Morimoto wrote:
> > > MMC_D1 is RCAR_GP_PIN(1, 8), not RCAR_GP_PIN(2, 8)
> > > 
> > > Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Laurent, could you please review this?

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Remind me next time we meet to show you what to check in the datasheet to 
review this kind of patches ;-)

> > > ---
> > > This patch is based on renesas-next-20130611v2
> > > 
> > >  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > > b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c index 1dcbabc..f903910 100644
> > > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > > @@ -1447,11 +1447,11 @@ MMC_PFC_PINS(mmc_ctrl,		RCAR_GP_PIN(1,
> > > 5),	RCAR_GP_PIN(1, 6));> > 
> > >  MMC_PFC_CTRL(mmc_ctrl,		MMC_CLK,		MMC_CMD);
> > >  MMC_PFC_PINS(mmc_data1,		RCAR_GP_PIN(1, 7));
> > >  MMC_PFC_DAT1(mmc_data1,		MMC_D0);
> > > 
> > > -MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
> > > +MMC_PFC_PINS(mmc_data4,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
> > > 
> > >  				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6));
> > >  
> > >  MMC_PFC_DAT4(mmc_data4,		MMC_D0,			MMC_D1,
> > >  
> > >  				MMC_D2,			MMC_D3);
> > > 
> > > -MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(2, 8),
> > > +MMC_PFC_PINS(mmc_data8,		RCAR_GP_PIN(1, 7),	RCAR_GP_PIN(1, 8),
> > > 
> > >  				RCAR_GP_PIN(0, 5),	RCAR_GP_PIN(0, 6),
> > >  				RCAR_GP_PIN(1, 4),	RCAR_GP_PIN(1, 0),
> > >  				RCAR_GP_PIN(0, 30),	RCAR_GP_PIN(0, 31));

-- 
Regards,

Laurent Pinchart

