From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Thu, 17 Jul 2014 07:37:02 +0000
Subject: Re: [PATCH 1/6] adv7180: Remove duplicate unregister call
Message-Id: <53C77D1E.3000901@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1404599185-12353-1-git-send-email-ben.dooks@codethink.co.uk> <1404599185-12353-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1404599185-12353-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.de, linux-kernel@lists.codethink.co.uk, Ian Molton <ian.molton@codethink.co.uk>

On 07/06/2014 12:26 AM, Ben Dooks wrote:
> From: Ian Molton <ian.molton@codethink.co.uk>
> 
> This driver moved over to v4l2_async_unregister_subdev()
> but still retained a call to v4l2_unregister_subdev(). Remove.
> 
> Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>

Thanks,

	Hans

> ---
>  drivers/media/i2c/adv7180.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index ac1cdbe..821178d 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
> @@ -663,7 +663,6 @@ static int adv7180_remove(struct i2c_client *client)
>  	if (state->irq > 0)
>  		free_irq(client->irq, state);
>  
> -	v4l2_device_unregister_subdev(sd);
>  	adv7180_exit_controls(state);
>  	mutex_destroy(&state->mutex);
>  	return 0;
> 

