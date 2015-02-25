From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Feb 2015 23:58:07 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: r8a7791: Fix IPMMU-GP clock to device tree
Message-Id: <20150225235806.GM23723@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424352546-27313-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1424352546-27313-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

while I am inclined to take this patch on face value I am wondering
if anyone is able to confirm this change against the documentation:
I have drawn a blank there.

On Thu, Feb 19, 2015 at 10:29:06PM +0900, Yoshihiro Kaneko wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> 
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on devel branch of Simon Horman's renesas tree.
> 
>  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index afba8af..1e75a5f 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1154,7 +1154,7 @@
>  		mstp8_clks: mstp8_clks@e6150990 {
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>  			reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> -			clocks = <&zg_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
> +			clocks = <&zx_clk>, <&hp_clk>, <&zg_clk>, <&zg_clk>,
>  			         <&zg_clk>, <&p_clk>, <&zs_clk>, <&zs_clk>;
>  			#clock-cells = <1>;
>  			clock-indices = <
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
