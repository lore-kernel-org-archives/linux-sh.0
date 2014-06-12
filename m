From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 12 Jun 2014 15:35:21 +0000
Subject: Re: [PATCH v2 2/7] ARM: shmobile: r8a7790: Add default PCIe bus clock
Message-Id: <3607511.MYI6i7v7YI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1402484753-7471-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1402484753-7471-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

Thank you for the patch.

On Wednesday 11 June 2014 12:05:48 Phil Edworthy wrote:
> This patch adds a default PCIe bus clock node.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v2:
>  - Use a default PCIe bus clock in the device's dtsi
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7eb882c..13b4e63 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -487,6 +487,14 @@
>  			clock-output-names = "extal";
>  		};
> 
> +		/* External PCIe clock - can be overridden by the board */
> +		pcie_bus_clk: pcie_bus_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;
> +			clock-output-names = "pcie_bus";

As the clock isn't present on all r8a7790 boards, how about making it disabled 
(status = "disabled") by default ?

> +		};
> +
>  		/*
>  		 * The external audio clocks are configured as 0 Hz fixed frequency
> clocks by * default. Boards that provide audio clocks should override them.

-- 
Regards,

Laurent Pinchart

