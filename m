From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 05 Nov 2014 18:01:37 +0000
Subject: Re: [PATCH v3 4/7] ARM: shmobile: kzm9g-reference: Common clock framework DT description
Message-Id: <7952611.SxaMa6ic34@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Tuesday 28 October 2014 18:02:13 Ulrich Hecht wrote:
> KZM9G-specific clock overrides.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts index 0dac0e6..bad6492
> 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
> @@ -178,6 +178,10 @@
>  	status = "ok";
>  };
> 
> +&extal2_clk {
> +	clock-frequency = <48000000>;
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  	as3711@40 {

-- 
Regards,

Laurent Pinchart

