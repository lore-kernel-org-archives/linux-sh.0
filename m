From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 28 Apr 2013 20:55:25 +0000
Subject: Re: [PATCH v3 2/3] sh-pfc: r8a7778: add Ether pin groups
Message-Id: <2979636.yc8MXoS86o@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201304270246.43931.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304270246.43931.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Saturday 27 April 2013 18:41:27 Sergei Shtylyov wrote:
> On 27-04-2013 4:48, Laurent Pinchart wrote:
> > Thank you for the patch.
> 
>     Not at all. :-)
> 
> > On Saturday 27 April 2013 02:46:43 Sergei Shtylyov wrote:
> >> Add Ether RMII/LINK/MAGIC pin groups to R8A7778 PFC driver.
> >> 
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> 
> >> ---
> >> Changes from version 2:
> >> - fixed whitespace errors/warnings reported by scripts/checkpatch.pl.
> >> 
> >> Changes from the original posting:
> >> - resolved reject, refreshed the patch;
> >> - moved all pin groups to stay in the alphabetical order with the others;
> >> - made use of SH_PFC_*() macros where possible.
> >> 
> >>   drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   26 ++++++++++++++++++++++++++
> >>   1 file changed, 26 insertions(+)
> >> 
> >> Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> >> =================================> >> --- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> >> +++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> >> @@ -1323,6 +1323,22 @@ static struct sh_pfc_pin pinmux_pins[] > >>   						     arg5##_MARK, arg6##_MARK, \
> >>   						     arg7##_MARK, arg8##_MARK, }
> >> 
> >> +/* - Ether
> >> ------------------------------------------------------------------ */
> >> +SH_PFC_PINS(ether_rmii,		RCAR_GP_PIN(4, 10),	RCAR_GP_PIN(4, 11),
> >> +				RCAR_GP_PIN(4, 13),	RCAR_GP_PIN(4, 9),
> >> +				RCAR_GP_PIN(4, 15),	RCAR_GP_PIN(4, 16),
> >> +				RCAR_GP_PIN(4, 12),	RCAR_GP_PIN(4, 14),
> >> +				RCAR_GP_PIN(4, 18),	RCAR_GP_PIN(4, 17));
> >> +static const unsigned int ether_rmii_mux[] = {
> >> +	ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK,  ETH_REF_CLK_MARK,
> >> +	ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_CRS_DV_MARK, ETH_RX_ER_MARK,
> >> +	ETH_MDIO_MARK, ETH_MDC_MARK,
> >> +};
> >> +SH_PFC_PINS(ether_link,		RCAR_GP_PIN(4, 19));
> >> +SH_PFC_MUX1(ether_link,		ETH_LINK);
> >> +SH_PFC_PINS(ether_magic,	RCAR_GP_PIN(4, 20));
> >> +SH_PFC_MUX1(ether_magic,	ETH_MAGIC);
> > 
> > I really don't think the macros make the code more readable here,
> > especially with the explicit array/macros mix, but I won't nack the patch
> > just for that.
>
> But you won't ACK it either? :-)

I definitely wouldn't have written the code that way, but the patch looks OK 
to me and can be applied. According to Documentation/SubmittingPatches that's 
equivalent to

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

