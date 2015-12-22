From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 22 Dec 2015 17:44:36 +0000
Subject: Re: [PATCH v2] adv7604: add direct interrupt handling
Message-Id: <56798C04.1030109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450794087-31153-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1450794087-31153-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk

Hello.

On 12/22/2015 05:21 PM, Ulrich Hecht wrote:

> When probed from device tree, the i2c client driver can handle the
> interrupt on its own.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> This revision implements the suggested style changes and drops the
> IRQF_TRIGGER_LOW flag, which is handled in the device tree.
>
> CU
> Uli
>
>
>   drivers/media/i2c/adv7604.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
> index 5bd81bd..be5980c 100644
> --- a/drivers/media/i2c/adv7604.c
> +++ b/drivers/media/i2c/adv7604.c
> @@ -31,6 +31,7 @@
>   #include <linux/gpio/consumer.h>
>   #include <linux/hdmi.h>
>   #include <linux/i2c.h>
> +#include <linux/interrupt.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
> @@ -1971,6 +1972,16 @@ static int adv76xx_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
>   	return 0;
>   }
>
> +static irqreturn_t adv76xx_irq_handler(int irq, void *devid)
> +{
> +	struct adv76xx_state *state = devid;
> +	bool handled;
> +
> +	adv76xx_isr(&state->sd, 0, &handled);
> +
> +	return handled ? IRQ_HANDLED : IRQ_NONE;

    Just IRQ_RETVAL(handled), maybe?

[...]

MBR, Sergei

