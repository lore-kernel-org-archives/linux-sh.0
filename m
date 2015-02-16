From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 16 Feb 2015 17:07:38 +0000
Subject: Re: [PATCH v3 08/15] ARM: shmobile: r8a7778: add internal ethernet controller to DT
Message-Id: <3545778.1Gk2Ybio3g@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Monday 16 February 2015 17:58:52 Ulrich Hecht wrote:
> Internal Ethernet controller DT entry with clock information.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7778.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index 5c347e8..c802e72 100644
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

