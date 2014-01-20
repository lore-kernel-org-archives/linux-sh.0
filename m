From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 20 Jan 2014 11:26:28 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790.dtsi: ficx i2c[0-3] clock reference
Message-Id: <3288411.rrSBdFQOL7@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1390216964-12693-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390216964-12693-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Monday 20 January 2014 11:22:44 Ben Dooks wrote:
> The R8A7790's dtsi file i2c0, i2c1, i2c2, and i2c3 nodes have clock
> refrences that mstp3_clks clock node,

Do you mean "a clock that references the mstp3_clks clock node," ?

> however these clocks are in the mstp8_clks node.

But the patch replaces mstp3_clks with mstp9_clks :-)

> The error was introducted in 72197ca7a1cb1cea5 ("ARM: shmobile: r8a7790:
>  Reference clocks") which is in Simon's current development tree.
> 
> This patch fixes the following error:
> of_clk_src_onecell_get: invalid clock index 31
> i2c-rcar e6508000.i2c: cannot get clock
> i2c-rcar: probe of e6508000.i2c failed with error -2
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: horms+renesas@verge.net.au
> Cc: laurent.pinchart+renesas@ideasonboard.com
> Cc: linux-sh@vger.kernel.org
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 3cc834b..15e2a97 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -198,7 +198,7 @@
>  		reg = <0 0xe6508000 0 0x40>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp3_clks R8A7790_CLK_I2C0>;
> +		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
>  		status = "disabled";
>  	};
> 
> @@ -209,7 +209,7 @@
>  		reg = <0 0xe6518000 0 0x40>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp3_clks R8A7790_CLK_I2C1>;
> +		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
>  		status = "disabled";
>  	};
> 
> @@ -220,7 +220,7 @@
>  		reg = <0 0xe6530000 0 0x40>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp3_clks R8A7790_CLK_I2C2>;
> +		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
>  		status = "disabled";
>  	};
> 
> @@ -231,7 +231,7 @@
>  		reg = <0 0xe6540000 0 0x40>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&mstp3_clks R8A7790_CLK_I2C3>;
> +		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
>  		status = "disabled";
>  	};
-- 
Regards,

Laurent Pinchart

