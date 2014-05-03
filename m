From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 03 May 2014 11:15:25 +0000
Subject: Re: [PATCH v3 1/7] adv7180: use async subdev registration
Message-Id: <Pine.LNX.4.64.1405031314480.23253@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Mon, 14 Apr 2014, Ben Dooks wrote:

> Change to using the the async subdev registration API so
> that when soc_camera is using OF to find devices this can
> be found and attached.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

I think you're late with this one:

commit fa5b7945aefdbcd4419f0b8872ce67866d8071e3
Author: Lars-Peter Clausen <lars@metafoo.de>
Date:   Fri Mar 7 13:14:32 2014 -0300

    [media] adv7180: Add support for async device registration

Thanks
Guennadi

> ---
>  drivers/media/i2c/adv7180.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/adv7180.c b/drivers/media/i2c/adv7180.c
> index d7d99f1..215afa0 100644
> --- a/drivers/media/i2c/adv7180.c
> +++ b/drivers/media/i2c/adv7180.c
> @@ -29,6 +29,7 @@
>  #include <linux/videodev2.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ctrls.h>
> +#include <media/v4l2-async.h>
>  #include <linux/mutex.h>
>  
>  #define ADV7180_INPUT_CONTROL_REG			0x00
> @@ -611,6 +612,11 @@ static int adv7180_probe(struct i2c_client *client,
>  	ret = init_device(client, state);
>  	if (ret)
>  		goto err_free_ctrl;
> +
> +	ret = v4l2_async_register_subdev(sd);
> +	if (ret)
> +		goto err_free_ctrl;
> +
>  	return 0;
>  
>  err_free_ctrl:
> @@ -641,7 +647,7 @@ static int adv7180_remove(struct i2c_client *client)
>  	}
>  
>  	mutex_destroy(&state->mutex);
> -	v4l2_device_unregister_subdev(sd);
> +	v4l2_async_unregister_subdev(sd);
>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
