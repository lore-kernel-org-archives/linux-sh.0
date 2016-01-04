From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 04 Jan 2016 14:38:35 +0000
Subject: Re: [PATCH RESEND 3/3] drm: adv7511: it's HPD, not HDP
Message-Id: <3387173.Dbm3fEH4di@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1451874827-2531-1-git-send-email-wsa@the-dreams.de>
 <1451874827-2531-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1451874827-2531-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-sh@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

Thank you for the patch.

On Monday 04 January 2016 03:33:47 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Fix this typo, consequently used over both files :)
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/i2c/adv7511.c | 22 +++++++++++-----------
>  drivers/gpu/drm/i2c/adv7511.h | 12 ++++++------
>  2 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
> index 50a861b12346c4..c03c1ea53fd042 100644
> --- a/drivers/gpu/drm/i2c/adv7511.c
> +++ b/drivers/gpu/drm/i2c/adv7511.c
> @@ -378,16 +378,16 @@ static void adv7511_power_on(struct adv7511 *adv7511)
>  	}
> 
>  	/*
> -	 * Per spec it is allowed to pulse the HDP signal to indicate that the
> +	 * Per spec it is allowed to pulse the HPD signal to indicate that the
>  	 * EDID information has changed. Some monitors do this when they wakeup
> -	 * from standby or are enabled. When the HDP goes low the adv7511 is
> +	 * from standby or are enabled. When the HPD goes low the adv7511 is
>  	 * reset and the outputs are disabled which might cause the monitor to
> -	 * go to standby again. To avoid this we ignore the HDP pin for the
> +	 * go to standby again. To avoid this we ignore the HPD pin for the
>  	 * first few seconds after enabling the output.
>  	 */
>  	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
> -			   ADV7511_REG_POWER2_HDP_SRC_MASK,
> -			   ADV7511_REG_POWER2_HDP_SRC_NONE);
> +			   ADV7511_REG_POWER2_HPD_SRC_MASK,
> +			   ADV7511_REG_POWER2_HPD_SRC_NONE);
> 
>  	/*
>  	 * Most of the registers are reset during power down or when HPD is low.
> @@ -421,9 +421,9 @@ static bool adv7511_hpd(struct adv7511 *adv7511)
>  	if (ret < 0)
>  		return false;
> 
> -	if (irq0 & ADV7511_INT0_HDP) {
> +	if (irq0 & ADV7511_INT0_HPD) {
>  		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
> -			     ADV7511_INT0_HDP);
> +			     ADV7511_INT0_HPD);
>  		return true;
>  	}
> 
> @@ -446,7 +446,7 @@ static int adv7511_irq_process(struct adv7511 *adv7511)
>  	regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
>  	regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
> 
> -	if (irq0 & ADV7511_INT0_HDP && adv7511->encoder)
> +	if (irq0 & ADV7511_INT0_HPD && adv7511->encoder)
>  		drm_helper_hpd_irq_event(adv7511->encoder->dev);
> 
>  	if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERROR) {
> @@ -648,10 +648,10 @@ adv7511_encoder_detect(struct drm_encoder *encoder,
>  		if (adv7511->status = connector_status_connected)
>  			status = connector_status_disconnected;
>  	} else {
> -		/* Renable HDP sensing */
> +		/* Renable HPD sensing */
>  		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
> -				   ADV7511_REG_POWER2_HDP_SRC_MASK,
> -				   ADV7511_REG_POWER2_HDP_SRC_BOTH);
> +				   ADV7511_REG_POWER2_HPD_SRC_MASK,
> +				   ADV7511_REG_POWER2_HPD_SRC_BOTH);
>  	}
> 
>  	adv7511->status = status;
> diff --git a/drivers/gpu/drm/i2c/adv7511.h b/drivers/gpu/drm/i2c/adv7511.h
> index 6599ed538426d6..38515b30cedfc8 100644
> --- a/drivers/gpu/drm/i2c/adv7511.h
> +++ b/drivers/gpu/drm/i2c/adv7511.h
> @@ -90,7 +90,7 @@
>  #define ADV7511_CSC_ENABLE			BIT(7)
>  #define ADV7511_CSC_UPDATE_MODE			BIT(5)
> 
> -#define ADV7511_INT0_HDP			BIT(7)
> +#define ADV7511_INT0_HPD			BIT(7)
>  #define ADV7511_INT0_VSYNC			BIT(5)
>  #define ADV7511_INT0_AUDIO_FIFO_FULL		BIT(4)
>  #define ADV7511_INT0_EDID_READY			BIT(2)
> @@ -157,11 +157,11 @@
>  #define ADV7511_PACKET_ENABLE_SPARE2		BIT(1)
>  #define ADV7511_PACKET_ENABLE_SPARE1		BIT(0)
> 
> -#define ADV7511_REG_POWER2_HDP_SRC_MASK		0xc0
> -#define ADV7511_REG_POWER2_HDP_SRC_BOTH		0x00
> -#define ADV7511_REG_POWER2_HDP_SRC_HDP		0x40
> -#define ADV7511_REG_POWER2_HDP_SRC_CEC		0x80
> -#define ADV7511_REG_POWER2_HDP_SRC_NONE		0xc0
> +#define ADV7511_REG_POWER2_HPD_SRC_MASK		0xc0
> +#define ADV7511_REG_POWER2_HPD_SRC_BOTH		0x00
> +#define ADV7511_REG_POWER2_HPD_SRC_HPD		0x40
> +#define ADV7511_REG_POWER2_HPD_SRC_CEC		0x80
> +#define ADV7511_REG_POWER2_HPD_SRC_NONE		0xc0
>  #define ADV7511_REG_POWER2_TDMS_ENABLE		BIT(4)
>  #define ADV7511_REG_POWER2_GATE_INPUT_CLK	BIT(0)

-- 
Regards,

Laurent Pinchart

