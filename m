From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 01:23:22 +0000
Subject: Re: [PATCH v4 5/9] ARM: shmobile: marzen: Enable DU device in DT
Message-Id: <20141027012321.GE30485@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414152241-5390-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 24, 2014 at 03:03:57PM +0300, Laurent Pinchart wrote:
> Specify the DU output topology, enable the DU device and configure the
> related pins.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I have this patch queued up but I notice that it seems to introduce
the following warnings. Can this be addressed somehow?

Warning (reg_format): "reg" property in /lvds-encoder/ports/port@0 has invalid length (4 bytes) (#address-cells = 2, #size-cells = 1)
Warning (reg_format): "reg" property in /lvds-encoder/ports/port@1 has invalid length (4 bytes) (#address-cells = 2, #size-cells = 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value for /lvds-encoder/ports/port@0
Warning (avoid_default_addr_size): Relying on default #size-cells value for /lvds-encoder/ports/port@0
Warning (avoid_default_addr_size): Relying on default #address-cells value for /lvds-encoder/ports/port@1
Warning (avoid_default_addr_size): Relying on default #size-cells value for /lvds-encoder/ports/port@1

> ---
>  arch/arm/boot/dts/r8a7779-marzen.dts | 81 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
> index 9e1b859190ca..64a5d634edc1 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
> @@ -69,6 +69,76 @@
>  			gpios = <&gpio4 31 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
> +
> +	vga-encoder {
> +		compatible = "adi,adv7123";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				vga_enc_in: endpoint {
> +					remote-endpoint = <&du_out_rgb0>;
> +				};
> +			};
> +			port@1 {
> +				reg = <1>;
> +				vga_enc_out: endpoint {
> +					remote-endpoint = <&vga_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	vga {
> +		compatible = "vga-connector";
> +
> +		port {
> +			vga_in: endpoint {
> +				remote-endpoint = <&vga_enc_out>;
> +			};
> +		};
> +	};
> +
> +	lvds-enc {
> +		compatible = "thine,thc63lvdm83d";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ports {
> +			port@0 {
> +				lvds_enc_in: endpoint {
> +					remote-endpoint = <&du_out_rgb1>;
> +				};
> +			};
> +			port@1 {
> +				lvds_connector: endpoint {
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&du {
> +	pinctrl-0 = <&du_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +
> +	ports {
> +		port@0 {
> +			endpoint {
> +				remote-endpoint = <&vga_enc_in>;
> +			};
> +		};
> +		port@1 {
> +			endpoint {
> +				remote-endpoint = <&lvds_enc_in>;
> +			};
> +		};
> +	};
>  };
>  
>  &irqpin0 {
> @@ -84,6 +154,17 @@
>  };
>  
>  &pfc {
> +	du_pins: du {
> +		du0 {
> +			renesas,groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
> +			renesas,function = "du0";
> +		};
> +		du1 {
> +			renesas,groups = "du1_rgb666", "du1_sync_1", "du1_clk_out";
> +			renesas,function = "du1";
> +		};
> +	};
> +
>  	lan0_pins: lan0 {
>  		intc {
>  			renesas,groups = "intc_irq1_b";
> -- 
> 2.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
