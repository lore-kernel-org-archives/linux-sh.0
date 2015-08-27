From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 27 Aug 2015 03:13:43 +0000
Subject: RE: [PATCH 16/25 v7][RFC] arm64: renesas: salvator-x: add pfc node and subnodes for usb 2.0
Message-Id: <SG2PR06MB09191BA2AFEFE999FEF82321D86F0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <876145776m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

> Sent: Thursday, August 27, 2015 10:16 AM
< snip >
> So, Morimoto-san, if possible, would you merge this patch in v8?
> 
> Best regards,
> Yoshihiro Shimoda
> 
> ---
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> index 9437e87..1f60f4c 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> @@ -1335,6 +1335,19 @@ static const u16 pinmux_data[] = {
>  	PINMUX_IPSR_DATA(IP15_31_28, SCK5),
> 
>  	/* IPSR16 */
> +	PINMUX_IPSR_DATA(IP16_11_8, USB0_PWEN),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, SIM0_RST_C, SEL_SIMCARD_2),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, TS_SCK1_D, SEL_TSIF1_3),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, STP_ISCLK_1_D, SEL_SSP1_1_3),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, BPFCLK_B, SEL_FM_1),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_11_8, RIF3_CLK_B, SEL_DRIF3_1),
> +
> +	PINMUX_IPSR_DATA(IP16_15_12, USB0_OVC),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, SIM0_D_C, SEL_SIMCARD_2),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, TS_SDAT1_D, SEL_TSIF1_3),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, STP_ISD_1_D, SEL_SSP1_1_3),
> +	PINMUX_IPSR_MODSEL_DATA(IP16_15_12, RIF3_SYNC_B, SEL_DRIF3_1),
> +
>  	PINMUX_IPSR_DATA(IP16_19_16, USB1_PWEN),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_19_16, SIM0_CLK_C, SEL_SIMCARD_2),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_19_16, SSI_SCK1_A, SEL_SSI_0),

Thank you for the point locally :)
Even if I don't add all the "PINMUX_IPSR_MODSEL_DATA" of usb0, it works correctly.
Since I didn't test the pins except USB0_{OVC,PWEN),
all the "PINMUX_IPSR_MODSEL_DATA" of usb0 should be removed.

Best regards,
Yoshihiro Shimoda

