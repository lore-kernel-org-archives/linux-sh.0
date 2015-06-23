From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jun 2015 23:50:29 +0000
Subject: Re: [PATCH 1/2] spi: rspi: Remove obsolete rspi-rz platform_device_id entry
Message-Id: <20150623235028.GH9988@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jun 23, 2015 at 03:02:06PM +0200, Geert Uytterhoeven wrote:
> Since commit 05104c266ae9a167 ("ARM: shmobile: r7s72100: genmai: Remove
> legacy board file"), r7s72100 is only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/spi/spi-rspi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index f9189a0c8cec81f2..56216b205e0f2c34 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -1295,7 +1295,6 @@ error1:
>  
>  static const struct platform_device_id spi_driver_ids[] = {
>  	{ "rspi",	(kernel_ulong_t)&rspi_ops },
> -	{ "rspi-rz",	(kernel_ulong_t)&rspi_rz_ops },
>  	{ "qspi",	(kernel_ulong_t)&qspi_ops },
>  	{},
>  };
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
