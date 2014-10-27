From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 00:38:29 +0000
Subject: Re: [PATCH 12/12] ARM: shmobile: koelsch: Add DU HDMI output support
Message-Id: <20141027003829.GC32437@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1411589072-28609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1411589072-28609-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1411589072-28609-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Wed, Sep 24, 2014 at 11:04:32PM +0300, Laurent Pinchart wrote:
> Add DT nodes for the ADV7511 HDMI encoder and its HDMI output connector
> and configure the DISP pin group that drives the HDMI transmitter DE
> pin.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Please be careful of any conflicts that may arise if this patch
doesn't go through my renesas tree.

> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 50 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 9051e01..b7d0c41 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -209,6 +209,17 @@
>  		states = <3300000 1
>  			  1800000 0>;
>  	};
> +
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&adv7511_out>;
> +			};
> +		};
> +	};
>  };
>  
>  &du {
> @@ -217,6 +228,11 @@
>  	status = "okay";
>  
>  	ports {
> +		port@0 {
> +			endpoint {
> +				remote-endpoint = <&adv7511_in>;
> +			};
> +		};
>  		port@1 {
>  			lvds_connector: endpoint {
>  			};
> @@ -235,7 +251,7 @@
>  	};
>  
>  	du_pins: du {
> -		renesas,groups = "du_rgb666", "du_sync", "du_clk_out_0";
> +		renesas,groups = "du_rgb666", "du_sync", "du_disp", "du_clk_out_0";
>  		renesas,function = "du";
>  	};
>  
> @@ -439,6 +455,38 @@
>  		};
>  	};
>  
> +	hdmi@39 {
> +		compatible = "adi,adv7511w";
> +		reg = <0x39>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
> +
> +		adi,input-depth = <8>;
> +		adi,input-colorspace = "rgb";
> +		adi,input-clock = "1x";
> +		adi,input-style = <1>;
> +		adi,input-justification = "evenly";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				adv7511_in: endpoint {
> +					remote-endpoint = <&du_out_rgb>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				adv7511_out: endpoint {
> +					remote-endpoint = <&hdmi_con>;
> +				};
> +			};
> +		};
> +	};
> +
>  	eeprom@50 {
>  		compatible = "renesas,24c02";
>  		reg = <0x50>;
> -- 
> 1.8.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
