From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 09 Sep 2014 22:03:26 +0000
Subject: Re: [PATCH v2 07/10] ARM: shmobile: kzm9g: require ZB1 clock for Ethernet controller
Message-Id: <1588149.oD0qILfl2F@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Tuesday 02 September 2014 11:13:03 Ulrich Hecht wrote:
> Unlike the legacy stuff, CCF disables the ethernet controller's clock
> unless it is used somewhere.

But the ethernet controller is not clocked by the ZB1 clock.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts index 83c6058..a7e1c46
> 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -90,6 +90,7 @@
>  		interrupt-parent = <&irqpin0>;
>  		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
>  		reg-io-width = <4>;
> +		clocks = <&zb1_clk>;

By the way, that clock is only named zb1 in a single location in the 
datasheet, and just zb everywhere else. I think it should be renamed in patch 
02/10.

>  		smsc,irq-push-pull;
>  		smsc,save-mac-address;
>  		vddvario-supply = <&reg_1p8v>;

-- 
Regards,

Laurent Pinchart

