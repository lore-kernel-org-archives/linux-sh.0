From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 15 May 2013 10:37:40 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: fix r8a7790 Function Select register tables
Message-Id: <Pine.LNX.4.64.1305151236030.10596@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305151057310.10596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305151057310.10596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 15 May 2013, Laurent Pinchart wrote:

> On Wednesday 15 May 2013 12:00:53 Guennadi Liakhovetski wrote:
> > On Wed, 15 May 2013, Laurent Pinchart wrote:
> > > On Wednesday 15 May 2013 11:07:21 Guennadi Liakhovetski wrote:
> > > > Fix several errors in Peripheral Function Select register tables for
> > > > r8a7790, which prevent various function pins from being correctly
> > > > configured.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > > ---
> > > > 
> > > >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   14 ++++++--------
> > > >  1 files changed, 6 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > > > b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 5be2999..39a9083 100644
> > > > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c

[snip]

> > > > @@ -3441,12 +3441,10 @@ static struct pinmux_cfg_reg
> > > > pinmux_config_regs[] > > > > { FN_SEL_SOF0_0, FN_SEL_SOF0_1, }
> > > >  	},
> > > >  	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
> > > > -			     2, 1, 1, 1, 1, 2, 1, 2, 1,
> > > > -			     2, 1, 1, 1, 3, 3, 2, 3, 2, 2) {
> > > > -		/* RESEVED [2] */
> > > > +			     3, 1, 1, 1, 2, 1, 2, 1,
> > > > +			     3, 1, 1, 3, 3, 2, 3, 2, 2) {
> > > 
> > > Shouldn't it be
> > > 
> > > +			     3, 1, 1, 1, 2, 1, 2, 1, 2,
> > > +			     1, 1, 1, 3, 3, 2, 3, 2, 2) {
> > 
> > 2 + 1 = 3 :) As long as SCIF2 isn't supported it's not too important.
> 
> But 2^2 + 2^1 != 2^3

Argh, overzealous patching :-( I'll update.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
