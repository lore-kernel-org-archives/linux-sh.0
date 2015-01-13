From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 Jan 2015 07:34:22 +0000
Subject: Re: [PATCH 1/2] sh-pfc: r8a7791: fix typo in MLB_CLK
Message-Id: <2554452.2F2rfmCuIv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1479250.GJuNxlSkHs@wasted.cogentembedded.com>
In-Reply-To: <1479250.GJuNxlSkHs@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Saturday 10 January 2015 21:21:46 Sergei Shtylyov wrote:
> The R8A7791 manual sometimes calls the signal MLB_CLK and sometimes MLB_CK;
> the latter can only be encountered in the PFC section and  is probably 
> just a typo (this  signal is always called MLB_CLK in the R8A7790  manual).
> Fix occurences of MLB_CK throughout the R8A7791 PFC driver.
> 
> Based on original patch by Andrey Gusakov
> <andrey.gusakov@cogentembedded.com>.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>


> 
> ---
> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
> repo.
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
> @@ -378,7 +378,7 @@ enum {
>  	/* IPSR16 */
>  	FN_HRX1, FN_SCIFB1_RXD, FN_VI1_R0_B, FN_GLO_SDATA_C, FN_VI1_DATA6_C,
>  	FN_HTX1, FN_SCIFB1_TXD, FN_VI1_R1_B, FN_GLO_SS_C, FN_VI1_DATA7_C,
> -	FN_HSCK1, FN_SCIFB1_SCK, FN_MLB_CK, FN_GLO_RFON_C,
> +	FN_HSCK1, FN_SCIFB1_SCK, FN_MLB_CLK, FN_GLO_RFON_C,
>  	FN_HCTS1_N, FN_SCIFB1_CTS_N, FN_MLB_SIG, FN_CAN1_TX_B,
>  	FN_HRTS1_N, FN_SCIFB1_RTS_N, FN_MLB_DAT, FN_CAN1_RX_B,
> 
> @@ -764,7 +764,7 @@ enum {
>  	GLO_SDATA_C_MARK, VI1_DATA6_C_MARK,
>  	HTX1_MARK, SCIFB1_TXD_MARK, VI1_R1_B_MARK,
>  	GLO_SS_C_MARK, VI1_DATA7_C_MARK,
> -	HSCK1_MARK, SCIFB1_SCK_MARK, MLB_CK_MARK, GLO_RFON_C_MARK,
> +	HSCK1_MARK, SCIFB1_SCK_MARK, MLB_CLK_MARK, GLO_RFON_C_MARK,
>  	HCTS1_N_MARK, SCIFB1_CTS_N_MARK, MLB_SIG_MARK, CAN1_TX_B_MARK,
>  	HRTS1_N_MARK, SCIFB1_RTS_N_MARK, MLB_DAT_MARK, CAN1_RX_B_MARK,
>  	PINMUX_MARK_END,
> @@ -1664,7 +1664,7 @@ static const u16 pinmux_data[] = {
>  	PINMUX_IPSR_MODSEL_DATA(IP16_5_3, VI1_DATA7_C, SEL_VI1_2),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_7_6, HSCK1, SEL_HSCIF1_0),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_7_6, SCIFB1_SCK, SEL_SCIFB1_0),
> -	PINMUX_IPSR_DATA(IP16_7_6, MLB_CK),
> +	PINMUX_IPSR_DATA(IP16_7_6, MLB_CLK),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_7_6, GLO_RFON_C, SEL_GPS_2),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_9_8, HCTS1_N, SEL_HSCIF1_0),
>  	PINMUX_IPSR_DATA(IP16_9_8, SCIFB1_CTS_N),
> @@ -5974,7 +5974,7 @@ static const struct pinmux_cfg_reg pinmu
>  		/* IP16_9_8 [2] */
>  		FN_HCTS1_N, FN_SCIFB1_CTS_N, FN_MLB_SIG, FN_CAN1_TX_B,
>  		/* IP16_7_6 [2] */
> -		FN_HSCK1, FN_SCIFB1_SCK, FN_MLB_CK, FN_GLO_RFON_C,
> +		FN_HSCK1, FN_SCIFB1_SCK, FN_MLB_CLK, FN_GLO_RFON_C,
>  		/* IP16_5_3 [3] */
>  		FN_HTX1, FN_SCIFB1_TXD, FN_VI1_R1_B,
>  		FN_GLO_SS_C, FN_VI1_DATA7_C,

-- 
Regards,

Laurent Pinchart

