From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 15 May 2013 10:18:20 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: fix r8a7790 Function Select register tables
Message-Id: <1969790.DI6UEX7cOQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305151057310.10596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305151057310.10596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 15 May 2013 12:00:53 Guennadi Liakhovetski wrote:
> On Wed, 15 May 2013, Laurent Pinchart wrote:
> > On Wednesday 15 May 2013 11:07:21 Guennadi Liakhovetski wrote:
> > > Fix several errors in Peripheral Function Select register tables for
> > > r8a7790, which prevent various function pins from being correctly
> > > configured.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > > 
> > >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   14 ++++++--------
> > >  1 files changed, 6 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > > b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 5be2999..39a9083 100644
> > > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> > > @@ -3175,7 +3175,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[]
> > > = {
> > >  		FN_SIM0_D_B, 0, 0, 0, 0, 0, 0, 0, }
> > >  	},
> > >  	{ PINMUX_CFG_REG_VAR("IPSR11", 0xE606004C, 32,
> > > -			     2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3) {
> > > +			     2, 3, 3, 2, 4, 3, 2, 2, 2, 2, 2, 1, 4) {
> > >  		/* IP11_31_30 [2] */
> > >  		FN_SSI_SCK0129, FN_CAN_CLK_B, FN_MOUT0, 0,
> > >  		/* IP11_29_27 [3] */
> > > @@ -3441,12 +3441,10 @@ static struct pinmux_cfg_reg
> > > pinmux_config_regs[] > > > { FN_SEL_SOF0_0, FN_SEL_SOF0_1, }
> > >  	},
> > >  	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xE6060094, 32,
> > > -			     2, 1, 1, 1, 1, 2, 1, 2, 1,
> > > -			     2, 1, 1, 1, 3, 3, 2, 3, 2, 2) {
> > > -		/* RESEVED [2] */
> > > +			     3, 1, 1, 1, 2, 1, 2, 1,
> > > +			     3, 1, 1, 3, 3, 2, 3, 2, 2) {
> > 
> > Shouldn't it be
> > 
> > +			     3, 1, 1, 1, 2, 1, 2, 1, 2,
> > +			     1, 1, 1, 3, 3, 2, 3, 2, 2) {
> 
> 2 + 1 = 3 :) As long as SCIF2 isn't supported it's not too important.

But 2^2 + 2^1 != 2^3

> > > +		/* RESEVED [3] */
> > 
> > While you're at it, what about RESERVED ? :-)
> 
> Ah, that must be a separate patch! :-D
>
> > >  		0, 0, 0, 0, 0, 0, 0, 0,
> > > -		/* RESEVED [1] */
> > > -		0, 0,
> > >  		/* SEL_TMU1 [1] */
> > >  		FN_SEL_TMU1_0, FN_SEL_TMU1_1,
> > >  		/* SEL_HSCIF1 [1] */
> > > @@ -3462,8 +3460,8 @@ static struct pinmux_cfg_reg pinmux_config_regs[]
> > > = {
> > >  		/* SEL_CAN1 [1] */
> > >  		FN_SEL_CAN1_0, FN_SEL_CAN1_1,
> > >  		/* RESEVED [2] */
> > > -		0, 0, 0, 0, 0, 0, 0, 0,
> > > -		/* RESEVED [1] */
> > > +		0, 0, 0, 0,
> > > +		/* RESEVED [1] (actually TX2, RX2 vs. TX2_B, RX2_B of SCIF2) */
> > 
> > Would you like to submit a patch to add SCIF2 support, or should I do it ?
> 
> I won't fight for this honour ;-)
> 
> > >  		0, 0,
> > >  		/* SEL_ADI [1] */
> > >  		FN_SEL_ADI_0, FN_SEL_ADI_1,

-- 
Regards,

Laurent Pinchart

