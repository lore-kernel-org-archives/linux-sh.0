From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Dec 2010 04:03:09 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Mackerel VGA camera support
Message-Id: <20101224040309.GM28151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101222144740.23663.49079.sendpatchset@t400s>
In-Reply-To: <20101222144740.23663.49079.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 22, 2010 at 11:47:40PM +0900, Magnus Damm wrote:
> +static struct soc_camera_link camera_link = {
> +	.bus_id		= 0,
> +	.add_device	= mackerel_camera_add,
> +	.del_device	= mackerel_camera_del,
> +	.module_name	= "soc_camera_platform",
> +	.priv		= &camera_info,
> +};
> +
> +static void dummy_release(struct device *dev)
> +{
> +}
> +
> +static struct platform_device camera_device = {
> +	.name		= "soc_camera_platform",
> +	.dev		= {
> +		.platform_data	= &camera_info,
> +		.release	= dummy_release,
> +	},
> +};
> +
> +static int mackerel_camera_add(struct soc_camera_link *icl,
> +			       struct device *dev)
> +{
> +	if (icl != &camera_link)
> +		return -ENODEV;
> +
> +	camera_info.dev = dev;
> +
> +	return platform_device_register(&camera_device);
> +}
> +
I guess we should probably have the resource request doing here and
tidied up after in the ->release()? The ordering here is pretty magical.

> +static void mackerel_camera_del(struct soc_camera_link *icl)
> +{
> +	if (icl != &camera_link)
> +		return;
> +
> +	platform_device_unregister(&camera_device);
> +	memset(&camera_device.dev.kobj, 0,
> +	       sizeof(camera_device.dev.kobj));
> +}
> +
Any time a board needs to touch a device's kobject resources there's
something horribly horribly wrong. If the kobject is left particually
constructed after unregistration and causing corruption when the camera
is re-attached, then this needs to be corrected in the driver model, not
here.

The camera_link checks also look pretty bogus. This will only be called
in to for non-i2c devices, which already establish the reference to
&camera_link in the platform device's private data.
