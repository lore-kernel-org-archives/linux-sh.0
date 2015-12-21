From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 21 Dec 2015 22:01:34 +0000
Subject: Re: [PATCH 03/04] pinctrl: sh-pfc: r8a7794: Add missing dot clock signals
Message-Id: <567876BE.60100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151117031832.24924.60685.sendpatchset@little-apple>
 <20151117031902.24924.4588.sendpatchset@little-apple>
In-Reply-To: <20151117031902.24924.4588.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
Cc: linus.walleij@linaro.org, linux-kernel@vger.kernel.org, koji.matsuoka.xm@renesas.com, linux-gpio@vger.kernel.org, horms@verge.net.au, geert@glider.be, laurent.pinchart@ideasonboard.com

Hello.

On 11/17/2015 06:19 AM, Magnus Damm wrote:

> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add missing r8a7794 DU dot clock output signals and in
> particular the DU1_DOTCLKOUT0 signal on GP4_25 which is
> needed by DU1 on the r8a7794 ALT board.
>
> The groups "du0_clk_out" and "du1_clk_out" are replaced by
> "du0_dotclkout0", "du0_dotclkout1", "du1_dotclkout0" and
> "du1_dotclkout1".
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   drivers/pinctrl/sh-pfc/pfc-r8a7794.c |   34 ++++++++++++++++++++++++++--------
>   1 file changed, 26 insertions(+), 8 deletions(-)
>
> --- 0014/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a7794.c	2015-11-16 22:08:28.230513000 +0900
[...]
> @@ -2942,8 +2956,10 @@ static const struct sh_pfc_pin_group pin
>   	SH_PFC_PIN_GROUP(du0_rgb888),
>   	SH_PFC_PIN_GROUP(du1_rgb666),
>   	SH_PFC_PIN_GROUP(du1_rgb888),
> -	SH_PFC_PIN_GROUP(du0_clk_out),
> -	SH_PFC_PIN_GROUP(du1_clk_out),
> +	SH_PFC_PIN_GROUP(du0_clk0_out),
> +	SH_PFC_PIN_GROUP(du0_clk1_out),
> +	SH_PFC_PIN_GROUP(du1_clk0_out),
> +	SH_PFC_PIN_GROUP(du1_clk1_out),

    Hm, this kinda contradicts your chngnelog, no?

>   	SH_PFC_PIN_GROUP(du0_sync),
>   	SH_PFC_PIN_GROUP(du1_sync),
>   	SH_PFC_PIN_GROUP(du0_cde),
> @@ -3134,8 +3150,10 @@ static const char * const du_groups[] >   	"du0_rgb888",
>   	"du1_rgb666",
>   	"du1_rgb888",
> -	"du0_clk_out",
> -	"du1_clk_out",
> +	"du0_dotclkout0",
> +	"du0_dotclkout1",
> +	"du1_dotclkout0",
> +	"du1_dotclkout1",
>   	"du0_sync",
>   	"du1_sync",
>   	"du0_cde",

    I'm getting the following on the SILK board with this patch:

[drm] Initialized drm 1.1.0 20060810
sh-pfc e6060000.pin-controller: does not have pin group du1_dotclkout0
sh-pfc e6060000.pin-controller: invalid group du1_dotclkout0 in map table
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] No driver support for vblank timestamp query.
rcar-du feb00000.display: fb0:  frame buffer device
[drm] Initialized rcar-du 1.0.0 20130110 on minor 0

MBR, Sergei

