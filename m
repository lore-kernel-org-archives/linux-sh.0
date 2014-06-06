From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 06 Jun 2014 17:27:53 +0000
Subject: Re: [PATCH v3 7/7] soc_camera: initial of code
Message-Id: <5391FA19.7070903@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-8-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-8-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/14/2014 02:36 PM, Ben Dooks wrote:

> Add initial support for OF based soc-camera devices that may be used
> by any of the soc-camera drivers. The driver itself will need converting
> to use OF.

> These changes allow the soc-camera driver to do the connecting of any
> async capable v4l2 device to the soc-camera driver. This has currently
> been tested on the Renesas Lager board.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Changes since v1:

> 	- Updated to make the i2c mclk name compatible with other
> 	  drivers. The issue of having mclk which is not part of
> 	  the drivers/clk interface is something that can be dealt
> 	  with separately.
> ---
>   drivers/media/platform/soc_camera/soc_camera.c | 117 ++++++++++++++++++++++++-
>   1 file changed, 116 insertions(+), 1 deletion(-)

> diff --git a/drivers/media/platform/soc_camera/soc_camera.c b/drivers/media/platform/soc_camera/soc_camera.c
> index 4b8c024..c50ec5c 100644
> --- a/drivers/media/platform/soc_camera/soc_camera.c
> +++ b/drivers/media/platform/soc_camera/soc_camera.c
[...]
> @@ -1579,6 +1580,118 @@ static void scan_async_host(struct soc_camera_host *ici)
>   #define scan_async_host(ici)		do {} while (0)
>   #endif
>
> +#ifdef CONFIG_OF
> +static int soc_of_bind(struct soc_camera_host *ici,
> +		       struct device_node *ep,
> +		       struct device_node *remote)
> +{
> +	struct soc_camera_device *icd;
> +	struct soc_camera_desc sdesc = {.host_desc.bus_id = ici->nr,};
> +	struct soc_camera_async_client *sasc;
> +	struct soc_camera_async_subdev *sasd;
> +	struct v4l2_async_subdev **asd_array;
> +	struct i2c_client *client;
> +	char clk_name[V4L2_SUBDEV_NAME_SIZE];
> +	int ret;
> +
> +	/* alloacte a new subdev and add match info to it */

    s/alloacte/allocate/

> +	sasd = devm_kzalloc(ici->v4l2_dev.dev, sizeof(*sasd), GFP_KERNEL);
> +	if (!sasd)
> +		return -ENOMEM;
> +
> +	asd_array = devm_kzalloc(ici->v4l2_dev.dev,
> +				 sizeof(struct v4l2_async_subdev **),

    Hm, is this a correct size indeed?



> +	client = of_find_i2c_device_by_node(remote);
> +

    I don't think empty line is needed here...

> +	if (client)
> +		snprintf(clk_name, sizeof(clk_name), "%d-%04x",
> +			 client->adapter->nr, client->addr);
> +	else
> +		snprintf(clk_name, sizeof(clk_name), "of-%s",
> +			 of_node_full_name(remote));
[...]

WBR, Sergei

