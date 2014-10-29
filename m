From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Oct 2014 00:21:33 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <20141029002133.GL20702@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 28, 2014 at 06:02:16PM +0100, Ulrich Hecht wrote:
> Unlike the legacy stuff, CCF disables the ethernet controller's clock
> unless it is used somewhere.

This feels like it should come earlier in the series to avoid
breaking then fixing ethernet support for kzm9g-reference.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> index bad6492..15782f5 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -91,6 +91,7 @@
>  		interrupt-parent = <&irqpin0>;
>  		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
>  		reg-io-width = <4>;
> +		clocks = <&zb_clk>;
>  		smsc,irq-push-pull;
>  		smsc,save-mac-address;
>  		vddvario-supply = <&reg_1p8v>;
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
