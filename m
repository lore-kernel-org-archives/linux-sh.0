From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 04:09:56 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <20081020040956.GA20044@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0810142335400.10458@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 17, 2008 at 01:16:40AM +0200, Guennadi Liakhovetski wrote:
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index 714dce9..95459f3 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -312,6 +312,14 @@ static void camera_power_off(void)
>  	ctrl_outb(ctrl_inb(PORT_PTDR) & ~0x08, PORT_PTDR);
>  }
>  
> +static void camera_power(int mode)
> +{
> +	if (mode)
> +		camera_power_on();
> +	else
> +		camera_power_off();
> +}
> +
>  #ifdef CONFIG_I2C
>  static unsigned char camera_ov772x_magic[] >  {
> @@ -391,6 +399,7 @@ static struct soc_camera_platform_info ov772x_info = {
>  	},
>  	.bus_param =  SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
>  	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
> +	.power = camera_power,
>  	.set_capture = ov772x_set_capture,
>  };
>  
> @@ -405,8 +414,6 @@ static struct platform_device migor_camera_device = {
>  static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
>  	.flags = SOCAM_MASTER | SOCAM_DATAWIDTH_8 | SOCAM_PCLK_SAMPLE_RISING \
>  	| SOCAM_HSYNC_ACTIVE_HIGH | SOCAM_VSYNC_ACTIVE_HIGH,
> -	.enable_camera = camera_power_on,
> -	.disable_camera = camera_power_off,
>  };
>  
I don't like this. Keeping the enable and disable_camera interfaces
is really the way we want to go, evident by the fact that your new power
callback is forced to call in to one or the other anyways. I would rather
see these moved in to struct soc_camera_platform_info, rather than having
every single board in existence have to model that if (mode) on; else off
crap.

Also, there is not much point in splitting these changes out. They are
coupled, and splitting them out only causes confusion (especially across
a bisect).
