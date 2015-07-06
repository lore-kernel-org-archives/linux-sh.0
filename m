From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 06 Jul 2015 13:29:33 +0000
Subject: Re: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property
Message-Id: <15966074.zDS67FO48r@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436180132-26190-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436180132-26190-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

Thank you for the patch.

On Monday 06 July 2015 12:55:32 Geert Uytterhoeven wrote:
> Replace the deprecated generic "adi,adxl34x" compatible value by the
> adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
> i2c: Deprecate adi,adxl34x compatible string").
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
> Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
> support"), which is in v4.2-rc1.
> 
> This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
> property".
> 
> v2:
>   - Drop deprecated "adi,adxl34x"
> ---
>  arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> b/arch/arm/boot/dts/sh73a0-kzm9g.dts index
> 24b4cd24dceb2f9e..7fc5602810ad0da1 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> @@ -206,7 +206,7 @@
>  	};
> 
>  	accelerometer@1d {
> -		compatible = "adi,adxl34x";
> +		compatible = "adi,adxl345";
>  		reg = <0x1d>;
>  		interrupt-parent = <&irqpin3>;
>  		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,

-- 
Regards,

Laurent Pinchart

