From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Feb 2015 01:29:52 +0000
Subject: Re: [PATCH 11/15] ARM: shmobile: lager: Add DU HDMI output support
Message-Id: <20150226012952.GA26139@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418254935-13536-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1418254935-13536-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418254935-13536-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Thu, Dec 11, 2014 at 01:42:11AM +0200, Laurent Pinchart wrote:
> Add DT nodes for the ADV7511 HDMI encoder and its HDMI output connector.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 59365bccc945..749fe841aa09 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -222,6 +222,17 @@
>  			};
>  		};
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
> @@ -235,6 +246,11 @@
>  				remote-endpoint = <&adv7123_in>;
>  			};
>  		};
> +		port@1 {
> +			endpoint {
> +				remote-endpoint = <&adv7511_in>;
> +			};
> +		};
>  		port@2 {
>  			lvds_connector: endpoint {
>  			};
> @@ -504,6 +520,38 @@
>  			};
>  		};
>  	};
> +
> +	hdmi@39 {
> +		compatible = "adi,adv7511w";
> +		reg = <0x39>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <15 IRQ_TYPE_EDGE_FALLING>;
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
> +					remote-endpoint = <&du_out_lvds0>;
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
>  };
>  
>  &iic3 {
> -- 
> 2.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
