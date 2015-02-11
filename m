From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 11 Feb 2015 03:54:09 +0000
Subject: Re: [PATCH v2 08/15] ARM: shmobile: r8a7778, bockw: add internal ethernet controller to DT
Message-Id: <10488378.OKF7VR51TX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Monday 09 February 2015 17:02:36 Ulrich Hecht wrote:
> Internal Ethernet controller DT entry with pin control and clock
> information.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

I believe Simon would prefer this to be split in two patches.

> ---
>  arch/arm/boot/dts/r8a7778-bockw.dts | 10 ++++++++++
>  arch/arm/boot/dts/r8a7778.dtsi      | 11 +++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts
> b/arch/arm/boot/dts/r8a7778-bockw.dts index 280a922..f28ccbc 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -59,6 +59,11 @@
>  	};
>  };
> 
> +&ether {
> +	pinctrl-0 = <&ether_pins>;
> +	pinctrl-names = "default";

The internal ethernet controller isn't used on the BockW board, its pins are 
used for display. I thus wouldn't add it to r8a7778-bockw.dts.

> +};
> +
>  &i2c0 {
>  	status = "okay";
> 
> @@ -103,6 +108,11 @@
>  };
> 
>  &pfc {
> +	ether_pins: ether {
> +		renesas,groups = "ether_rmii";
> +		renesas,function = "ether";
> +	};
> +
>  	scif0_pins: serial0 {
>  		renesas,groups = "scif0_data_a", "scif0_ctrl";
>  		renesas,function = "scif0";
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 2ddfaa3e..98ad685 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -41,6 +41,17 @@
>  		spi2 = &hspi2;
>  	};
> 
> +	ether: ethernet@fde00000 {
> +		compatible = "renesas,ether-r8a7778";
> +		reg = <0xfde00000 0x400>;
> +		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
> +		phy-mode = "rmii";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "disabled";
> +	};
> +
>  	gic: interrupt-controller@fe438000 {
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;

-- 
Regards,

Laurent Pinchart

