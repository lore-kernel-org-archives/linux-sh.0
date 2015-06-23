From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Jun 2015 23:50:41 +0000
Subject: Re: [PATCH 2/2] spi: rspi: Remove obsolete qspi platform_device_id entry
Message-Id: <20150623235040.GI9988@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064527-11786-1-git-send-email-geert+renesas@glider.be>
 <1435064527-11786-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064527-11786-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jun 23, 2015 at 03:02:07PM +0200, Geert Uytterhoeven wrote:
> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to match platform
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
> index 56216b205e0f2c34..3e82b84c9ed48b2f 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -1295,7 +1295,6 @@ error1:
>  
>  static const struct platform_device_id spi_driver_ids[] = {
>  	{ "rspi",	(kernel_ulong_t)&rspi_ops },
> -	{ "qspi",	(kernel_ulong_t)&qspi_ops },
>  	{},
>  };
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
