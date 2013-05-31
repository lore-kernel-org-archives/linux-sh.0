From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 31 May 2013 03:03:33 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7779: Fix missing MOD_SEL2 entry
Message-Id: <3250480.eOh3enhpdQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1369906266-30205-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1369906266-30205-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Friday 31 May 2013 11:43:18 Simon Horman wrote:
> On Fri, May 31, 2013 at 03:37:15AM +0200, Laurent Pinchart wrote:
> > Hi Phil,
> > 
> > Thank you for the patch.
> > 
> > On Thursday 30 May 2013 10:31:06 Phil Edworthy wrote:
> > > The list of functions selected by the MOD_SEL2 register was missing
> > > an entry. This caused all entries after this to modify the MOD_SEL2
> > > register incorrectly.
> > > 
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks Phil, thanks Laurent,
> 
> can I clarify that this is targeted at v3.11 and not necessary for v3.10 or
> earlier releases.

Pushing the patch to v3.10 and v3.9 stable would be nice, as the bug is 
present there as well.

> > > ---
> > > 
> > >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > > b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index 13feaa0..5dfeb3e 100644
> > > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > > @@ -2525,7 +2525,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[]
> > > = {
> > > 
> > >  	    /* SEL_SCIF [2] */
> > >  	    FN_SEL_SCIF_0, FN_SEL_SCIF_1, FN_SEL_SCIF_2, FN_SEL_SCIF_3,
> > >  	    /* SEL_CANCLK [2] */
> > > 
> > > -	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2,
> > > +	    FN_SEL_CANCLK_0, FN_SEL_CANCLK_1, FN_SEL_CANCLK_2, 0,
> > > 
> > >  	    /* SEL_CAN0 [1] */
> > >  	    FN_SEL_CAN0_0, FN_SEL_CAN0_1,
> > >  	    /* SEL_HSCIF1 [1] */

-- 
Regards,

Laurent Pinchart

