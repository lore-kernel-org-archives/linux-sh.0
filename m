From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Feb 2015 21:43:00 +0000
Subject: Re: [PATCH v3 03/15] ARM: shmobile: r8a7778: Common clock framework DT description
Message-Id: <20150217214259.GC25707@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 16, 2015 at 05:58:47PM +0100, Ulrich Hecht wrote:
> Declares all r8a7778 clocks supported by the legacy clock framework,
> plus tmu2.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |   1 +
>  arch/arm/boot/dts/r8a7778.dtsi                     | 191 +++++++++++++++++++++

I am planning to queue this up have queued this up after the update to
renesas,cpg-mstp-clocks.txt as it is a driver change.

Please resubmit that change as a separate change, most likely
for Mike Turquette.

>  2 files changed, 192 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 0a80fa7..e163092 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -13,6 +13,7 @@ Required Properties:
>      - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
>      - "renesas,r8a73a4-mstp-clocks" for R8A73A4 (R-Mobile APE6) MSTP gate clocks
>      - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate clocks
> +    - "renesas,r8a7778-mstp-clocks" for R8A7778 (R-Car M1) MSTP gate clocks
>      - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index ef85339..822ba90 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -16,6 +16,7 @@
>  
>  /include/ "skeleton.dtsi"
>  
> +#include <dt-bindings/clock/r8a7778-clock.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  
>  / {
> @@ -294,4 +295,194 @@
>  		#size-cells = <0>;
>  		status = "disabled";
>  	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		/* External input clock */
> +		extal_clk: extal_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <0>;
> +			clock-output-names = "extal";
> +		};
> +
> +		/* Special CPG clocks */
> +		cpg_clocks: cpg_clocks@ffc80000 {
> +			compatible = "renesas,r8a7778-cpg-clocks";
> +			reg = <0xffc80000 0x80>;
> +			#clock-cells = <1>;
> +			clocks = <&extal_clk>;
> +			clock-output-names = "plla", "pllb", "b",
> +					     "out", "p", "s", "s1";
> +		};
> +
> +		/* Audio clocks; frequencies are set by boards if applicable. */
> +		audio_clk_a: audio_clk_a {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-output-names = "audio_clk_a";
> +		};
> +		audio_clk_b: audio_clk_b {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-output-names = "audio_clk_b";
> +		};
> +		audio_clk_c: audio_clk_c {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-output-names = "audio_clk_c";
> +		};
> +
> +		/* Fixed ratio clocks */
> +		g_clk: g_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
> +			#clock-cells = <0>;
> +			clock-div = <12>;
> +			clock-mult = <1>;
> +			clock-output-names = "g";
> +		};
> +		i_clk: i_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
> +			#clock-cells = <0>;
> +			clock-div = <1>;
> +			clock-mult = <1>;
> +			clock-output-names = "i";
> +		};
> +		s3_clk: s3_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
> +			#clock-cells = <0>;
> +			clock-div = <4>;
> +			clock-mult = <1>;
> +			clock-output-names = "s3";
> +		};
> +		s4_clk: s4_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks R8A7778_CLK_PLLA>;
> +			#clock-cells = <0>;
> +			clock-div = <8>;
> +			clock-mult = <1>;
> +			clock-output-names = "s4";
> +		};
> +		z_clk: z_clk {
> +			compatible = "fixed-factor-clock";
> +			clocks = <&cpg_clocks R8A7778_CLK_PLLB>;
> +			#clock-cells = <0>;
> +			clock-div = <1>;
> +			clock-mult = <1>;
> +			clock-output-names = "z";
> +		};
> +
> +		/* Gate clocks */
> +		mstp0_clks: mstp0_clks@ffc80030 {
> +			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0xffc80030 4>;
> +			clocks = <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_S>;
> +			#clock-cells = <1>;
> +			clock-indices = <
> +				R8A7778_CLK_I2C0 R8A7778_CLK_I2C1
> +				R8A7778_CLK_I2C2 R8A7778_CLK_I2C3
> +				R8A7778_CLK_SCIF0 R8A7778_CLK_SCIF1
> +				R8A7778_CLK_SCIF2 R8A7778_CLK_SCIF3
> +				R8A7778_CLK_SCIF4 R8A7778_CLK_SCIF5
> +				R8A7778_CLK_TMU0 R8A7778_CLK_TMU1
> +				R8A7778_CLK_TMU2 R8A7778_CLK_SSI0
> +				R8A7778_CLK_SSI1 R8A7778_CLK_SSI2
> +				R8A7778_CLK_SSI3 R8A7778_CLK_SRU
> +				R8A7778_CLK_HSPI
> +			>;
> +			clock-output-names > +				"i2c0", "i2c1", "i2c2", "i2c3", "scif0",
> +				"scif1", "scif2", "scif3", "scif4", "scif5",
> +				"tmu0", "tmu1", "tmu2", "ssi0", "ssi1",
> +				"ssi2", "ssi3", "sru", "hspi";
> +		};
> +		mstp1_clks: mstp1_clks@ffc80034 {
> +			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0xffc80034 4>, <0xffc80044 4>;
> +			clocks = <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_S>,
> +				 <&cpg_clocks R8A7778_CLK_S>,
> +				 <&cpg_clocks R8A7778_CLK_P>;
> +			#clock-cells = <1>;
> +			clock-indices = <
> +				R8A7778_CLK_ETHER R8A7778_CLK_VIN0
> +				R8A7778_CLK_VIN1 R8A7778_CLK_USB
> +			>;
> +			clock-output-names > +				"ether", "vin0", "vin1", "usb";
> +		};
> +		mstp3_clks: mstp3_clks@ffc8003c {
> +			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0xffc8003c 4>;
> +			clocks = <&s4_clk>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>;
> +			#clock-cells = <1>;
> +			clock-indices = <
> +				R8A7778_CLK_MMC R8A7778_CLK_SDHI0
> +				R8A7778_CLK_SDHI1 R8A7778_CLK_SDHI2
> +				R8A7778_CLK_SSI4 R8A7778_CLK_SSI5
> +				R8A7778_CLK_SSI6 R8A7778_CLK_SSI7
> +				R8A7778_CLK_SSI8
> +			>;
> +			clock-output-names > +				"mmc", "sdhi0", "sdhi1", "sdhi2", "ssi4",
> +				"ssi5", "ssi6", "ssi7", "ssi8";
> +		};
> +		mstp5_clks: mstp5_clks@ffc80054 {
> +			compatible = "renesas,r8a7778-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0xffc80054 4>;
> +			clocks = <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>,
> +				 <&cpg_clocks R8A7778_CLK_P>;
> +			#clock-cells = <1>;
> +			clock-indices = <
> +				R8A7778_CLK_SRU_SRC0 R8A7778_CLK_SRU_SRC1
> +				R8A7778_CLK_SRU_SRC2 R8A7778_CLK_SRU_SRC3
> +				R8A7778_CLK_SRU_SRC4 R8A7778_CLK_SRU_SRC5
> +				R8A7778_CLK_SRU_SRC6 R8A7778_CLK_SRU_SRC7
> +				R8A7778_CLK_SRU_SRC8
> +			>;
> +			clock-output-names > +				"sru-src0", "sru-src1", "sru-src2",
> +				"sru-src3", "sru-src4", "sru-src5",
> +				"sru-src6", "sru-src7", "sru-src8";
> +		};
> +	};
>  };
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
