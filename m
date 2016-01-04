From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 04 Jan 2016 14:37:44 +0000
Subject: Re: [PATCH RESEND 1/3] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <1537546.GLmkeJiXH5@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1451874827-2531-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1451874827-2531-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

Thank you for the patch.

On Monday 04 January 2016 03:33:45 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> The interrupts for EDID_READY or DDC_ERROR were never enabled in this
> driver, so reading EDID always timed out when chip was powered down and
> interrupts were used. Fix this and remove clearing the interrupt flags,
> they are cleared in POWER_DOWN mode anyhow (according to docs and my
> tests).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/gpu/drm/i2c/adv7511.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
> index 00416f23b5cb5f..85e994796d96a4 100644
> --- a/drivers/gpu/drm/i2c/adv7511.c
> +++ b/drivers/gpu/drm/i2c/adv7511.c
> @@ -362,12 +362,19 @@ static void adv7511_power_on(struct adv7511 *adv7511)
>  {
>  	adv7511->current_edid_segment = -1;
> 
> -	regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
> -		     ADV7511_INT0_EDID_READY);
> -	regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
> -		     ADV7511_INT1_DDC_ERROR);
>  	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
>  			   ADV7511_POWER_POWER_DOWN, 0);
> +	if (adv7511->i2c_main->irq) {
> +		/*
> +		 * Documentation says the INT_ENABLE registers are reset in
> +		 * POWER_DOWN mode. My tests with a 7511w show something else
> +		 * but let's stick to the documentation.

This contradicts the commit message, which one is correct ?

> +		 */
> +		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
> +			     ADV7511_INT0_EDID_READY);
> +		regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
> +			     ADV7511_INT1_DDC_ERROR);
> +	}
> 
>  	/*
>  	 * Per spec it is allowed to pulse the HDP signal to indicate that the
> @@ -567,12 +574,14 @@ static int adv7511_get_modes(struct drm_encoder
> *encoder,
> 
>  	/* Reading the EDID only works if the device is powered */
>  	if (!adv7511->powered) {
> -		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
> -			     ADV7511_INT0_EDID_READY);
> -		regmap_write(adv7511->regmap, ADV7511_REG_INT(1),
> -			     ADV7511_INT1_DDC_ERROR);
>  		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
>  				   ADV7511_POWER_POWER_DOWN, 0);
> +		if (adv7511->i2c_main->irq) {
> +			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(0),
> +				     ADV7511_INT0_EDID_READY);
> +			regmap_write(adv7511->regmap, ADV7511_REG_INT_ENABLE(1),
> +				     ADV7511_INT1_DDC_ERROR);
> +		}
>  		adv7511->current_edid_segment = -1;
>  	}

-- 
Regards,

Laurent Pinchart

