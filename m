From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Jan 2014 00:20:08 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: r8a7790: Add thermal clock in device tree
Message-Id: <5603225.DfoErgnQlW@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389121036-3555-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

Thank you for the patch.

On Tuesday 07 January 2014 19:57:14 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Add the missing thermal MSTP clock to the thermal device node.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7790.dtsi |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index f48487c2a970..b53834e6a55f 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -168,6 +168,7 @@
>  		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
>  	};
> 
>  	timer {
-- 
Regards,

Laurent Pinchart

