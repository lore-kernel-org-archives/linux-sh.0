From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 05:02:07 +0000
Subject: Re: [PATCH v2 7/7] ARM: shmobile: armadillo-reference: Use low level IRQ for ST1231
Message-Id: <20131121050207.GW31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1384865989-12875-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384865989-12875-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Nov 19, 2013 at 01:59:49PM +0100, Laurent Pinchart wrote:
> The device is configured to generate an active-low interrupt signal that
> needs to be acknowledged by the host. Configure the IRQ to trigger on
> low level.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes since v1:
> 
> - Fixed typo (IRQ_TYPE_LOW_LEVEL -> IRQ_TYPE_LEVEL_LOW)


Thanks, I will queue this up.
Assuming all goes will I plan to push this and other updates
today or tomorrow.

> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> index aef425f..7b80f19 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> @@ -95,7 +95,7 @@
>  		compatible = "sitronix,st1232";
>  		reg = <0x55>;
>  		interrupt-parent = <&irqpin1>;
> -		interrupts = <2 IRQ_TYPE_NONE>; /* IRQ10: hwirq 2 on irqpin1 */
> +		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>  		pinctrl-0 = <&st1232_pins>;
>  		pinctrl-names = "default";
>  		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
