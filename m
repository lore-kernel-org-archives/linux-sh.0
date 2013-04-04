From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Apr 2013 14:00:59 +0000
Subject: Re: [PATCH 1/6] sh-pfc: r8a7740: Add SCIFA1 data group
Message-Id: <5911848.QnMCxJT6TJ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1365083144-16085-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365083144-16085-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Thursday 04 April 2013 15:45:39 Bastian Hecht wrote:
> Add SCIFA1 as preparation to switch to pinctrl in board files.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c index bbd87d2..6f62ab5 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
> @@ -1658,6 +1658,14 @@ static struct sh_pfc_pin pinmux_pins[] = {
>  	GPIO_PORT_ALL(),
>  };
> 
> +/* - SCIFA1 ------------------------------------------------------------ */
> +static const unsigned int scifa1_data_pins[] = {
> +	/* RXD, TXD */
> +	195, 196,
> +};
> +static const unsigned int scifa1_data_mux[] = {
> +	SCIFA1_RXD_MARK, SCIFA1_TXD_MARK,
> +};

Please keep the entries alphabetically sorted (here and below). The patch 
looks good otherwise.

>  /* - LCD0 -------------------------------------------------------------- */
> static const unsigned int lcd0_data8_pins[] = {
>  	/* D[0:7] */
> @@ -2054,6 +2062,7 @@ static const unsigned int sdhi2_wp_1_mux[] = {
>  };
> 
>  static const struct sh_pfc_pin_group pinmux_groups[] = {
> +	SH_PFC_PIN_GROUP(scifa1_data),
>  	SH_PFC_PIN_GROUP(lcd0_data8),
>  	SH_PFC_PIN_GROUP(lcd0_data9),
>  	SH_PFC_PIN_GROUP(lcd0_data12),
> @@ -2103,7 +2112,12 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(sdhi2_wp_1),
>  };
> 
> +static const char * const scifa1_groups[] = {
> +	"scifa1_data",
> +};
> +
>  static const char * const lcd0_groups[] = {
> +	"scifa1_data",
>  	"lcd0_data8",
>  	"lcd0_data9",
>  	"lcd0_data12",
> @@ -2169,6 +2183,7 @@ static const char * const sdhi2_groups[] = {
>  };
> 
>  static const struct sh_pfc_function pinmux_functions[] = {
> +	SH_PFC_FUNCTION(scifa1),
>  	SH_PFC_FUNCTION(lcd0),
>  	SH_PFC_FUNCTION(lcd1),
>  	SH_PFC_FUNCTION(mmc0),
-- 
Regards,

Laurent Pinchart

