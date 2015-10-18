From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 18 Oct 2015 11:31:27 +0000
Subject: Re: [PATCH 01/02] ARM: shmobile: r8a7794: Add DU device and MSTP clocks
Message-Id: <5623830F.3000100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151018051328.746.54581.sendpatchset@little-apple>
In-Reply-To: <20151018051328.746.54581.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 10/18/2015 8:13 AM, Magnus Damm wrote:

> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add a DU device tree node for the r8a7794 SoC and hook it up
> to the required MSTP clocks. As usual the device is disabled
> by default and we rely on the board specific code to provide
> more board specific details and enable the device.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>   Written against renesas-devel-20151015-v4.3-rc5
>   No special compile time dependencies.
>   Run time dependency on "drm: rcar-du: Add support for the R8A7794 DU"
>
>   arch/arm/boot/dts/r8a7794.dtsi            |   36 ++++++++++++++++++++++++++---
>   include/dt-bindings/clock/r8a7794-clock.h |    2 +
>   2 files changed, 35 insertions(+), 3 deletions(-)
>
> --- 0001/arch/arm/boot/dts/r8a7794.dtsi
> +++ work/arch/arm/boot/dts/r8a7794.dtsi	2015-10-18 13:44:22.130513000 +0900
[...]
> @@ -1025,19 +1053,21 @@
>   			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
>   			clocks = <&mp_clk>, <&mp_clk>,
>   				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
> -				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
> +				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
> +				 <&p_clk>, <&zx_clk>, <&zx_clk>;
>   			#clock-cells = <1>;
>   			clock-indices = <
>   				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
>   				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
>   				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
>   				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
> -				R8A7794_CLK_SCIF0
> +				R8A7794_CLK_SCIF0 R8A7794_CLK_DU1 R8A7794_CLK_DU0
>   			>;
>   			clock-output-names >   				"ehci", "hsusb",
>   				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
> -				"scif3", "scif2", "scif1", "scif0";
> +				"scif3", "scif2", "scif1", "scif0",
> +				"du2", "du1";

    Why not "du1", "du0"?

>   		};
>   		mstp8_clks: mstp8_clks@e6150990 {
>   			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
> --- 0001/include/dt-bindings/clock/r8a7794-clock.h
> +++ work/include/dt-bindings/clock/r8a7794-clock.h	2015-10-18 13:44:22.130513000 +0900
> @@ -79,6 +79,8 @@
>   #define R8A7794_CLK_SCIF2		19
>   #define R8A7794_CLK_SCIF1		20
>   #define R8A7794_CLK_SCIF0		21
> +#define R8A7794_CLK_DU1			23
> +#define R8A7794_CLK_DU0			24
>
>   /* MSTP8 */
>   #define R8A7794_CLK_VIN1		10

MBR, Sergei

