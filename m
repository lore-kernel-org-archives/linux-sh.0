From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 27 Jul 2015 11:01:29 +0000
Subject: Re: [PATCH] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <2227416.9VeFxpF072@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87bnf2rle6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnf2rle6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Morimoto-san,

Thank you for the patch.

On Friday 24 July 2015 08:52:02 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> The Mitsubishi AA121TD01 panel is commonly used with the Marzen, Lager
> and Koelsch boards. Create a .dtsi file that describe the panel and its
> connection to the board.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi | 41 +++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
> 
> diff --git a/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
> b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi new file mode 100644
> index 0000000..4261e6f
> --- /dev/null
> +++ b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
> @@ -0,0 +1,41 @@
> +/*
> + * Common file for the AA121TD01 panel connected to Renesas R-Car boards
> + *
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/ {
> +	panel {
> +		compatible = "mitsubishi,aa121td01", "panel-dpi";
> +
> +		width-mm = <260>;
> +		height-mm = <165>;

According to 
http://www.eurocomposant.fr/index.php/fr/content/download/4476/46559/file/AA121TD01.pdf 
the display size is 261mm x 163mm.

> +
> +		panel-timing {
> +			/* 1280x800 @71Hz */

With a 71MHz clock, using the typical timings from the above datasheet, the 
vertical refresh frequency will be 60Hz, not 71Hz.

> +			clock-frequency = <71000000>;
> +			hactive = <1280>;
> +			vactive = <800>;
> +			hsync-len = <160>;
> +			hfront-porch = <64>;
> +			hback-porch = <96>;
> +			vfront-porch = <9>;
> +			vback-porch = <15>;
> +			vsync-len = <24>;

Still according to the same datasheet, the typical total horizontal blanking 
time is 160 clock cycles. This is the sum of hsync-len, hfront-porch and 
hback-porch. This patch sets the horizontal blanking time to 320 instead (160 
+ 64 + 96). Similarly, for the vertical direction, the total should be 23, not 
48. The above values would lead to a 52Hz vertical refresh frequency.

> +		};
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds_connector>;
> +			};
> +		};
> +	};
> +};
> +
> +&lvds_connector {
> +	remote-endpoint = <&panel_in>;
> +};

-- 
Regards,

Laurent Pinchart

