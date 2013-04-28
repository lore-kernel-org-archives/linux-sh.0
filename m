From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 28 Apr 2013 20:47:49 +0000
Subject: Re: [PATCH v3 3/3] sh-pfc: r8a7779: add Ether pin groups
Message-Id: <25803389.4rHaf62G13@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201304270248.22740.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304270248.22740.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Sunday 28 April 2013 20:57:35 Sergei Shtylyov wrote:
> On 27-04-2013 18:33, Sergei Shtylyov wrote:
> >>> Add Ether RMII/LINK/MAGIC pin groups to R8A7779 PFC driver.
> >>> 
> >>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>> 
> >>> ---
> >>> Changes from the original posting:
> >>> - moved all pin groups to stay in the alphabetical order with the
> >>> others.
> >>> 
> >>>   drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   42 ++++++++++++++++++++++++++
> >>>   1 file changed, 42 insertions(+)
> >>> 
> >>> Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >>> =================================> >>> --- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >>> +++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >>> @@ -1640,6 +1640,38 @@ static const unsigned int du1_cde_pins[]
> >>>   static const unsigned int du1_cde_mux[] = {
> >>>       DU1_CDE_MARK
> >>>   };
> >>> 
> >>> +/* - Ether
> >>> ------------------------------------------------------------------ */
> >>> +static const unsigned int ether_rmii_pins[] = {
> >>> +    /*
> >>> +     * ETH_TXD0, ETH_TXD1, ETH_TX_EN,  ETH_REFCLK,
> >>> +     * ETH_RXD0, ETH_RXD1, ETH_CRS_DV, ETH_RX_ER,
> >>> +     * ETH_MDIO, ETH_MDC
> >>> +     */
> >>> +    RCAR_GP_PIN(2, 27), RCAR_GP_PIN(2, 16), RCAR_GP_PIN(2, 18),
> >>> +    RCAR_GP_PIN(2, 26),
> >>> +    RCAR_GP_PIN(2, 20), RCAR_GP_PIN(2, 21), RCAR_GP_PIN(2, 17),
> >>> +    RCAR_GP_PIN(2, 19),
> >>> +    RCAR_GP_PIN(2, 29), RCAR_GP_PIN(2, 28),
> >>> +};
> >>> +static const unsigned int ether_rmii_mux[] = {
> >>> +    ETH_TXD0_MARK, ETH_TXD1_MARK, ETH_TX_EN_MARK,  ETH_REFCLK_MARK,
> >>> +    ETH_RXD0_MARK, ETH_RXD1_MARK, ETH_CRS_DV_MARK, ETH_RX_ER_MARK,
> >>> +    ETH_MDIO_MARK, ETH_MDC_MARK,
> >>> +};
> >>> +static const unsigned int ether_link_pins[] = {
> >>> +    /* ETH_LINK */
> >>> +    RCAR_GP_PIN(2, 24),
> >>> +};
> >>> +static const unsigned int ether_link_mux[] = {
> >>> +    ETH_LINK_MARK,
> >>> +};
> >>> +static const unsigned int ether_magic_pins[] = {
> >>> +    /* ETH_MAGIC */
> >>> +    RCAR_GP_PIN(2, 25),
> >>> +};
> >>> +static const unsigned int ether_magic_mux[] = {
> >>> +    ETH_MAGIC_MARK,
> >>> +};
> >> 
> >> I wonder whether we should rename MAGIC to WOL (Wake On LAN), but that's
> >> out of scope for this patch.
> >> 
> >     I don't think it's a good idea to remove the SoC's signals at will.
> 
>     s/remove/rename/, of course. Would make it harder to find them back in
> the manuals, for example.

Agreed. We should fix the manuals then :-D

-- 
Regards,

Laurent Pinchart

