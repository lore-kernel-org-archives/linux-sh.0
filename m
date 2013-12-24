From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Dec 2013 02:59:36 +0000
Subject: Re: [PATCH 2/2] spi: rspi: Fix typo when clearing SPSR_OVRF
Message-Id: <20131224025936.GF22401@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387823664-32318-2-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1387823664-32318-2-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Dec 23, 2013 at 07:34:24PM +0100, Geert Uytterhoeven wrote:
> The overrun flag should be cleared in the SPI Status Register, not in the
> SPI Control Register, based on the SDK sample code.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

I don't believe that I have access to the sample code,
but I do trust your judgement.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/spi/spi-rspi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 9e0301014f48..b04835d809f5 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -517,7 +517,7 @@ static void rspi_receive_init(struct rspi_data *rspi)
>  		rspi_read16(rspi, RSPI_SPDR);	/* dummy read */
>  	if (spsr & SPSR_OVRF)
>  		rspi_write8(rspi, rspi_read8(rspi, RSPI_SPSR) & ~SPSR_OVRF,
> -			    RSPI_SPCR);
> +			    RSPI_SPSR);
>  }
>  
>  static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
