From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 04 Jan 2016 14:38:19 +0000
Subject: Re: [PATCH RESEND 2/3] drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
Message-Id: <2199297.HWp4hEOABu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1451874827-2531-1-git-send-email-wsa@the-dreams.de>
 <1451874827-2531-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1451874827-2531-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-sh@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

Thank you for the patch.

On Monday 04 January 2016 03:33:46 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This register includes a counter which is decremented by the chip on I2C
> failures. Also, it is reset when powering down.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

A small note though, even though the patch is correct, it will be of limited 
use as the EDID_READ_CTRL register is never accessed by the driver.

> ---
>  drivers/gpu/drm/i2c/adv7511.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511.c
> index 85e994796d96a4..50a861b12346c4 100644
> --- a/drivers/gpu/drm/i2c/adv7511.c
> +++ b/drivers/gpu/drm/i2c/adv7511.c
> @@ -136,6 +136,7 @@ static bool adv7511_register_volatile(struct device
> *dev, unsigned int reg) case ADV7511_REG_BKSV(3):
>  	case ADV7511_REG_BKSV(4):
>  	case ADV7511_REG_DDC_STATUS:
> +	case ADV7511_REG_EDID_READ_CTRL:
>  	case ADV7511_REG_BSTATUS(0):
>  	case ADV7511_REG_BSTATUS(1):
>  	case ADV7511_REG_CHIP_ID_HIGH:

-- 
Regards,

Laurent Pinchart

