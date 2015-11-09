From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Nov 2015 14:16:45 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: gose: Configure PFC in DT
Message-Id: <9791748.jMTWEhtVrm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1447032799-13155-1-git-send-email-horms+renesas@verge.net.au>
 <1447032799-13155-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447032799-13155-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Monday 09 November 2015 10:33:19 Simon Horman wrote:
> Configure PFC for the already enabled scif and ethernet devices
> in the device tree for the gose board.
> 
> Based on similar work for the koelsch board by Laurent Pinchart and
> Sergei Shtylyov.

I can't really comment on the patch due to lack of a schematics for the Goose 
board, but it looks good to me in principle.

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7793-gose.dts | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7793-gose.dts
> b/arch/arm/boot/dts/r8a7793-gose.dts index 96443ec5f6ab..1575ef759047
> 100644
> --- a/arch/arm/boot/dts/r8a7793-gose.dts
> +++ b/arch/arm/boot/dts/r8a7793-gose.dts
> @@ -37,7 +37,32 @@
>  	clock-frequency = <20000000>;
>  };
> 
> +&pfc {
> +	scif0_pins: serial0 {
> +		renesas,groups = "scif0_data_d";
> +		renesas,function = "scif0";
> +	};
> +
> +	scif1_pins: serial1 {
> +		renesas,groups = "scif1_data_d";
> +		renesas,function = "scif1";
> +	};
> +
> +	ether_pins: ether {
> +		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
> +		renesas,function = "eth";
> +	};
> +
> +	phy1_pins: phy1 {
> +		renesas,groups = "intc_irq0";
> +		renesas,function = "intc";
> +	};
> +};
> +
>  &ether {
> +	pinctrl-0 = <&ether_pins &phy1_pins>;
> +	pinctrl-names = "default";
> +
>  	phy-handle = <&phy1>;
>  	renesas,ether-link-active-low;
>  	status = "okay";
> @@ -55,9 +80,15 @@
>  };
> 
>  &scif0 {
> +	pinctrl-0 = <&scif0_pins>;
> +	pinctrl-names = "default";
> +
>  	status = "okay";
>  };
> 
>  &scif1 {
> +	pinctrl-0 = <&scif1_pins>;
> +	pinctrl-names = "default";
> +
>  	status = "okay";
>  };

-- 
Regards,

Laurent Pinchart

