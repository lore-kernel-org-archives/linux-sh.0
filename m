From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Feb 2015 23:31:25 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7791: Fix HSUSB clock to hp_clk from mp_clk
Message-Id: <20150225233125.GG23723@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424360590-6556-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1424360590-6556-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 19, 2015 at 10:43:10AM -0500, Simon Horman wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> 
> HSUSB uses hp_clk rather than mp_clk for H/W register access.
> 
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> [horms: updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.

> 
> ---
> v2 [Simon Horman]
> - Updated changelog to remove information about USB-DMAC clock which
>   did not relate to the patch. I will follow up on weather the
>   USB-DMAC clock should be mp_clk as the deleted portion of the
>   changelog stated.
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index afba8af..cb9a9e7 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -1,7 +1,7 @@
>  /*
>   * Device Tree Source for the r8a7791 SoC
>   *
> - * Copyright (C) 2013-2014 Renesas Electronics Corporation
> + * Copyright (C) 2013-2015 Renesas Electronics Corporation
>   * Copyright (C) 2013-2014 Renesas Solutions Corp.
>   * Copyright (C) 2014 Cogent Embedded Inc.
>   *
> @@ -1136,7 +1136,7 @@
>  		mstp7_clks: mstp7_clks@e615014c {
>  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
>  			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> -			clocks = <&mp_clk>,  <&mp_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
> +			clocks = <&mp_clk>,  <&hp_clk>, <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
>  				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
>  				 <&zx_clk>, <&zx_clk>, <&zx_clk>;
>  			#clock-cells = <1>;
> -- 
> 2.1.4
> 
