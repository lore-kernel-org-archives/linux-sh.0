From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 03 May 2014 16:54:51 +0000
Subject: Re: [PATCH v3 6/7] rcar_vin: add devicetree support
Message-Id: <Pine.LNX.4.64.1405031850530.26510@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 14 Apr 2014, Ben Dooks wrote:

> Add support for devicetree probe for the rcar-vin
> driver.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

[snip]

> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> index 47516df..72d2504 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
> @@ -24,6 +24,8 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/videodev2.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <media/soc_camera.h>
>  #include <media/soc_mediabus.h>
> @@ -32,6 +34,7 @@
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-mediabus.h>
>  #include <media/v4l2-subdev.h>
> +#include <media/v4l2-of.h>
>  #include <media/videobuf2-dma-contig.h>
>  
>  #include "soc_scale_crop.h"
> @@ -1392,6 +1395,17 @@ static struct soc_camera_host_ops rcar_vin_host_ops = {
>  	.init_videobuf2	= rcar_vin_init_videobuf2,
>  };
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id rcar_vin_of_table[] = {
> +	{ .compatible = "renesas,vin-r8a7791", .data = (void *)RCAR_GEN2 },
> +	{ .compatible = "renesas,vin-r8a7790", .data = (void *)RCAR_GEN2 },
> +	{ .compatible = "renesas,vin-r8a7779", .data = (void *)RCAR_H1 },
> +	{ .compatible = "renesas,vin-r8a7778", .data = (void *)RCAR_M1 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rcar_vin_of_table);
> +#endif
> +
>  static struct platform_device_id rcar_vin_id_table[] = {
>  	{ "r8a7791-vin",  RCAR_GEN2 },
>  	{ "r8a7790-vin",  RCAR_GEN2 },
> @@ -1404,15 +1418,50 @@ MODULE_DEVICE_TABLE(platform, rcar_vin_id_table);
>  
>  static int rcar_vin_probe(struct platform_device *pdev)
>  {
> +	const struct of_device_id *match = NULL;
>  	struct rcar_vin_priv *priv;
>  	struct resource *mem;
>  	struct rcar_vin_platform_data *pdata;
> +	unsigned int pdata_flags;
>  	int irq, ret;
>  
> -	pdata = pdev->dev.platform_data;
> -	if (!pdata || !pdata->flags) {
> -		dev_err(&pdev->dev, "platform data not set\n");
> -		return -EINVAL;
> +	if (pdev->dev.of_node) {
> +		struct v4l2_of_endpoint ep;
> +		struct device_node *np;
> +
> +		match = of_match_device(of_match_ptr(rcar_vin_of_table),
> +					&pdev->dev);
> +
> +		np = v4l2_of_get_next_endpoint(pdev->dev.of_node, NULL);

Failed to mention for your generic soc-camera patch too: the above takes a 
reference to the node, you have to use of_node_put() when you're done.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
