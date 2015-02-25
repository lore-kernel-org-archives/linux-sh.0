From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Feb 2015 06:56:47 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: Drop useless SERIAL_8250_EXTENDED=y
Message-Id: <20150225065646.GA31211@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424786964-30977-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1424786964-30977-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 24, 2015 at 03:09:24PM +0100, Geert Uytterhoeven wrote:
> SERIAL_8250_EXTENDED only serves as a guard for other Kconfig options,
> none of which is enabled in shmobile_defconfig.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/configs/shmobile_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Thanks, I have queued this up.

> 
> diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> index d206041e822a312a..11554158fa96ca9c 100644
> --- a/arch/arm/configs/shmobile_defconfig
> +++ b/arch/arm/configs/shmobile_defconfig
> @@ -93,7 +93,6 @@ CONFIG_INPUT_ADXL34X=y
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> -CONFIG_SERIAL_8250_EXTENDED=y
>  CONFIG_SERIAL_8250_EM=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_SERIAL_SH_SCI_NR_UARTS 
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
