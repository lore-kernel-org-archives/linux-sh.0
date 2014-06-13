From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 13 Jun 2014 10:45:49 +0000
Subject: Re: [PATCH v3 2/8] ARM: shmobile: r8a7790: Add default PCIe bus clock
Message-Id: <1554173.xRCyTElBgS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1402652242-16604-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1402652242-16604-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

Thank you for the patch.

On Friday 13 June 2014 10:37:16 Phil Edworthy wrote:
> This patch adds a default PCIe bus clock node.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3:
>  - By default, disable the PCIe bus clock
> 
> v2:
>  - Use a default PCIe bus clock in the device's dtsi
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7eb882c..d0520f1 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -487,6 +487,15 @@
>  			clock-output-names = "extal";
>  		};
> 
> +		/* External PCIe clock - can be overridden by the board */
> +		pcie_bus_clk: pcie_bus_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;
> +			clock-output-names = "pcie_bus";
> +			status = "disabled";
> +		};
> +
>  		/*
>  		 * The external audio clocks are configured as 0 Hz fixed frequency
> clocks by * default. Boards that provide audio clocks should override them.

-- 
Regards,

Laurent Pinchart

