From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 23 Apr 2013 11:07:52 +0000
Subject: Re: [PATCH] sh-pfc: r8a7778: Remove outdated comments
Message-Id: <2250366.VB8doyBIfi@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1366194463-27045-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366194463-27045-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 17 April 2013 17:24:49 Kuninori Morimoto wrote:
> Hi Laurent
> 
> Thank you for your patch
> At first, I'm sorry, these comments created confusion.
> But, these are indicating caution of strange VI pin settings.
> You can find same meaning comments on /* IPSR9 */ category, as /* see
> sel_vi0 */ So, How about this ?
> 
>  /* see VI0_Rx_A_MARK */
> 
> or
> 
>  /* see sel_vi0 */

That sounds good to me. I'll resubmit the patch.

> > Function GPIOs have been removed, remove comments that refer to them.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c index ddbd27b..e9cc040 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> > @@ -376,19 +376,19 @@ enum {
> > 
> >  	AVS1_MARK,
> >  	AVS2_MARK,
> > 
> > -	VI0_R0_C_MARK,  /* see GPIO_FN_VI0_R0_A */
> > -	VI0_R1_C_MARK,  /* see GPIO_FN_VI0_R1_A */
> > -	VI0_R2_C_MARK,  /* see GPIO_FN_VI0_R2_A */
> > -	/* VI0_R3_C_MARK,  see GPIO_FN_VI0_R3_A */
> > -	VI0_R4_C_MARK,  /* see GPIO_FN_VI0_R4_A */
> > -	VI0_R5_C_MARK,  /* see GPIO_FN_VI0_R5_A */
> > -
> > -	VI0_R0_D_MARK,  /* see GPIO_FN_VI0_R0_B */
> > -	VI0_R1_D_MARK,  /* see GPIO_FN_VI0_R1_B */
> > -	VI0_R2_D_MARK,  /* see GPIO_FN_VI0_R2_B */
> > -	VI0_R3_D_MARK,  /* see GPIO_FN_VI0_R3_B */
> > -	VI0_R4_D_MARK,  /* see GPIO_FN_VI0_R4_B */
> > -	VI0_R5_D_MARK,  /* see GPIO_FN_VI0_R5_B */
> > +	VI0_R0_C_MARK,
> > +	VI0_R1_C_MARK,
> > +	VI0_R2_C_MARK,
> > +	/* VI0_R3_C_MARK, */
> > +	VI0_R4_C_MARK,
> > +	VI0_R5_C_MARK,
> > +
> > +	VI0_R0_D_MARK,
> > +	VI0_R1_D_MARK,
> > +	VI0_R2_D_MARK,
> > +	VI0_R3_D_MARK,
> > +	VI0_R4_D_MARK,
> > +	VI0_R5_D_MARK,
> > 
> >  	/* IPSR0 */
> >  	PRESETOUT_MARK,	PWM1_MARK,	AUDATA0_MARK,

-- 
Regards,

Laurent Pinchart

