From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 26 Feb 2014 13:20:03 +0000
Subject: Re: [PATCH v3 07/20] ARM: shmobile: marzen: Reference clocks
Message-Id: <3688191.Xd29ih0Rpr@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1393400016-23433-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 26 February 2014 16:33:23 Simon Horman wrote:
> Reference clocks using a "clocks" property in all nodes corresponding to
> devices that require a clock: that is, the lan0 node.
> 
> Based on work by Laurent Pinchart for the r8a7790 and r8a7791 SoCs.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3
> * New
> ---
>  arch/arm/boot/dts/r8a7779-marzen.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts
> b/arch/arm/boot/dts/r8a7779-marzen.dts index 2c727cd..30f57e9 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
> @@ -41,6 +41,7 @@
>  		reg = <0x18000000 0x100>;
>  		pinctrl-0 = <&lan0_pins>;
>  		pinctrl-names = "default";
> +		clocks = <&mstp1_clks R8A7779_CLK_ETHER>;
> 
>  		phy-mode = "mii";
>  		interrupt-parent = <&irqpin0>;

-- 
Regards,

Laurent Pinchart

