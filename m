From: Simon Horman <horms@verge.net.au>
Date: Thu, 07 May 2015 04:26:26 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7740: Fix typo SCIFAB in comment
Message-Id: <20150507042625.GF28846@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430750446-8302-1-git-send-email-geert+renesas@glider.be>
 <1630235.T45TlTl3Ab@avalon>
In-Reply-To: <1630235.T45TlTl3Ab@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, May 06, 2015 at 07:26:07PM +0300, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Monday 04 May 2015 16:40:46 Geert Uytterhoeven wrote:
> > The last serial port is called "SCIFB", not "SCIFAB".
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
> > ---
> >  drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index
> > b486e9d20cc2f7cb..d0bb1459783a16d2 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> > @@ -258,7 +258,7 @@ enum {
> >  	/* SCIFA7 */
> >  	SCIFA7_TXD_MARK,	SCIFA7_RXD_MARK,
> > 
> > -	/* SCIFAB */
> > +	/* SCIFB */
> >  	SCIFB_SCK_PORT190_MARK, /* MSEL5CR_17_0 */
> >  	SCIFB_RXD_PORT191_MARK,
> >  	SCIFB_TXD_PORT192_MARK,
> 
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
