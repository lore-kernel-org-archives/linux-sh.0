From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 19 Jan 2014 11:03:11 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add i2c[0-3] clocks
Message-Id: <1728912.mG9A3XH1lT@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389974082-27677-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389974082-27677-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Friday 17 January 2014 15:54:42 Ben Dooks wrote:
> Add the necessary clocks for i2c0 to i2c3 into the mstp3 clock node. This
> is a pre-cursor to adding the i2c devices themslves.

According to the R8A7790 datasheet the I2C MSTP clocks are handled by MSTP9, 
not MSTP3, and they're already declared in the MSTP9 DT node.

> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index ac16214..aa91f4a 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -697,16 +697,19 @@
>  			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>  			clocks = <&cp_clk>, <&mmc1_clk>, <&sd3_clk>, <&sd2_clk>,
>  				 <&cpg_clocks R8A7790_CLK_SD1>, <&cpg_clocks 
R8A7790_CLK_SD0>,
> -				 <&mmc0_clk>, <&rclk_clk>;
> +				 <&mmc0_clk>, <&rclk_clk>, <&p_clk>, <&p_clk>, 
<&p_clk>,<&p_clk>;
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
>  				R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
>  				R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
>  				R8A7790_CLK_MMCIF0 R8A7790_CLK_CMT1
> +				R8A7790_CLK_I2C3 R8A7790_CLK_I2C2
> +				R8A7790_CLK_I2C1 R8A7790_CLK_I2C0
> 
>  			>;
> 
>  			clock-output-names >  				"tpu0", "mmcif1", "sdhi3", "sdhi2",
> -				"sdhi1", "sdhi0", "mmcif0", "cmt1";
> +				"sdhi1", "sdhi0", "mmcif0", "cmt1",
> +				"i2c3", "i2c2", "i2c1", "i2c0";
>  		};
>  		mstp5_clks: mstp5_clks@e6150144 {
>  			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-
clocks";
-- 
Regards,

Laurent Pinchart

