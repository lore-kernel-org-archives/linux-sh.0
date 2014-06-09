From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 09 Jun 2014 10:29:15 +0000
Subject: Re: [PATCH 1/8] ARM: shmobile: r8a7790: Add PCIe clock device tree nodes
Message-Id: <8658512.MX7D7qUacA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1401261843-6964-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1401261843-6964-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

Thank you for the patch.

On Wednesday 28 May 2014 08:23:56 Phil Edworthy wrote:
> This patch adds the device tree clock nodes for PCIe
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi            | 6 +++---
>  include/dt-bindings/clock/r8a7790-clock.h | 1 +
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7ff2960..ae7d3da 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -754,17 +754,17 @@
>  			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>  			clocks = <&hp_clk>, <&cp_clk>, <&mmc1_clk>, <&sd3_clk>,
>  				 <&sd2_clk>, <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks
> R8A7790_CLK_SD0>, <&mmc0_clk>,
> -				 <&hp_clk>, <&hp_clk>, <&rclk_clk>;
> +				 <&hp_clk>, <&hp_clk>, <&rclk_clk>, <&mp_clk>;
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
>  				R8A7790_CLK_IIC2 R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1
> R8A7790_CLK_SDHI3
>  				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
> R8A7790_CLK_MMCIF0
> -				R8A7790_CLK_IIC0 R8A7790_CLK_IIC1 R8A7790_CLK_CMT1
> +				R8A7790_CLK_IIC0 R8A7790_CLK_IIC1 R8A7790_CLK_CMT1
> R8A7790_CLK_PCIE

We try to keep the entries sorted by bit number. Could you this please insert 
the PCIE clock at the right position (between IIC0 and IIC1) ? Don't forget to 
update the clocks and clock-output-names properties accordingly.
 
>  			>;
> 
>  			clock-output-names >  				"iic2", "tpu0", "mmcif1", "sdhi3",
>  				"sdhi2", "sdhi1", "sdhi0", "mmcif0",
> -				"iic0", "iic1", "cmt1";
> +				"iic0", "iic1", "cmt1", "pcie";
>  		};
>  		mstp5_clks: mstp5_clks@e6150144 {
>  			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-
clocks";
> diff --git a/include/dt-bindings/clock/r8a7790-clock.h
> b/include/dt-bindings/clock/r8a7790-clock.h index 1118f7a..e0a6e38 100644
> --- a/include/dt-bindings/clock/r8a7790-clock.h
> +++ b/include/dt-bindings/clock/r8a7790-clock.h
> @@ -59,6 +59,7 @@
>  #define R8A7790_CLK_SDHI0		14
>  #define R8A7790_CLK_MMCIF0		15
>  #define R8A7790_CLK_IIC0		18
> +#define R8A7790_CLK_PCIE		19

The datasheet documents the MSTP bit as "PCIEC". Would it make sense to use 
the same name here, and in the clock-output-names property ?

The same comments apply to patch 2/8.

>  #define R8A7790_CLK_IIC1		23
>  #define R8A7790_CLK_SSUSB		28
>  #define R8A7790_CLK_CMT1		29

-- 
Regards,

Laurent Pinchart

