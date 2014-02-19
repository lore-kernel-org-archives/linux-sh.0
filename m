From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Feb 2014 22:39:19 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: fix clock index for i2c5
Message-Id: <2850884.8p95nB0hJd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1392844015-18024-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thanks for the patch.

On Wednesday 19 February 2014 22:06:55 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 1ab4f3d..3b2cdc8 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -731,7 +731,7 @@
>  			#clock-cells = <1>;
>  			renesas,clock-indices = <
>  				R8A7791_CLK_RCAN1 R8A7791_CLK_RCAN0 R8A7791_CLK_QSPI_MOD
> -				R8A7791_CLK_I2C4 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
> +				R8A7791_CLK_I2C5 R8A7791_CLK_I2C4 R8A7791_CLK_I2C3
>  				R8A7791_CLK_I2C2 R8A7791_CLK_I2C1 R8A7791_CLK_I2C0
> 
>  			>;
> 
>  			clock-output-names 
-- 
Regards,

Laurent Pinchart

