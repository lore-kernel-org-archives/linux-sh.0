From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 17 Jun 2013 10:58:57 +0000
Subject: Re: [PATCH] gpio-rcar: Use OUTDT when reading GPIOs configured as output
Message-Id: <1599004.HmR35SYjby@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20130616234152.23721.85467.sendpatchset@w520>
In-Reply-To: <20130616234152.23721.85467.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Monday 17 June 2013 08:41:52 Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Testing on r8a7790 shows that INDT does not indicate the correct
> pin state when reading a GPIO configured as output, so update
> the gpio_rcar_get() function to handle this case.

Have you checked whether this is true on the other SoCs as well ? Reading back 
the output register instead of the input register will not allow detection of 
conflicts. If the hardware can't provide that, fine, but otherwise it would be 
a nice feature to keep (although it might not get used in practice).

> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpio/gpio-rcar.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> --- 0001/drivers/gpio/gpio-rcar.c
> +++ work/drivers/gpio/gpio-rcar.c	2013-06-12 09:23:53.000000000 +0900
> @@ -230,7 +230,14 @@ static int gpio_rcar_direction_input(str
> 
>  static int gpio_rcar_get(struct gpio_chip *chip, unsigned offset)
>  {
> -	return (int)(gpio_rcar_read(gpio_to_priv(chip), INDT) & BIT(offset));
> +	u32 bit = BIT(offset);
> +
> +	/* testing on r8a7790 shows that INDT does not show correct pin state
> +	 * when configured as output, so use OUTDT in case of output pins */
> +	if (gpio_rcar_read(gpio_to_priv(chip), INOUTSEL) & bit)
> +		return (int)(gpio_rcar_read(gpio_to_priv(chip), OUTDT) & bit);
> +	else
> +		return (int)(gpio_rcar_read(gpio_to_priv(chip), INDT) & bit);
>  }
> 
>  static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int
> value)
-- 
Regards,

Laurent Pinchart

