From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 04 Sep 2015 21:49:31 +0000
Subject: Re: [PATCH 12/25 v7][RFC] arm64: renesas: r8a7795: add EHCI[012] clocks
Message-Id: <6363298.OWXAK0UTR5@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Morimoto-san,

Thank you for the patch.

On Monday 24 August 2015 02:29:16 Kuninori Morimoto wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v5 -> v7
> 
>  - based on Gen3 v7 patch-set
> 
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 10 +++++++---
>  include/dt-bindings/clock/r8a7795-clock.h |  3 +++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi index 77cfcea..c62b57b 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -105,10 +105,14 @@
>  					compatible = "renesas,r8a7795-mstp-clocks",
>  						     "renesas,cpg-mstp-clocks";
>  					reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> -					clocks =  <&s3d4_clk>;
> +					clocks =  <&s3d4_clk>, <&s3d4_clk>, <&s3d4_clk>,
> +						  <&s3d4_clk>;
>  					#clock-cells = <1>;
> -					renesas,clock-indices = <R8A7795_CLK_HSUSB>;
> -					clock-output-names = "hsusb";
> +					renesas,clock-indices = <R8A7795_CLK_HSUSB
> +								 R8A7795_CLK_EHCI0
> +								 R8A7795_CLK_EHCI1
> +								 R8A7795_CLK_EHCI2>;
> +					clock-output-names = "hsusb", "ehci0", "ehci1", "ehci2";
>  				};
>  			};
>  		};
> diff --git a/include/dt-bindings/clock/r8a7795-clock.h
> b/include/dt-bindings/clock/r8a7795-clock.h index ffb0b5b..2bd9d93 100644
> --- a/include/dt-bindings/clock/r8a7795-clock.h
> +++ b/include/dt-bindings/clock/r8a7795-clock.h
> @@ -30,6 +30,9 @@
> 
>  /* MSTP7 */
>  #define R8A7795_CLK_HSUSB		4
> +#define R8A7795_CLK_EHCI0		3
> +#define R8A7795_CLK_EHCI1		2
> +#define R8A7795_CLK_EHCI2		1

Could you please sort the clocks in ascending order as we do in all the Gen2 
clock headers ? Same comment for r8a7795.dtsi.

> 
>  /* MSTP8 */

-- 
Regards,

Laurent Pinchart

