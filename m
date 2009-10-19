From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 19 Oct 2009 07:01:41 +0000
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA
Message-Id: <20091019070141.GA18597@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091008013423.GA26059@rafazurita.homelinux.net>
In-Reply-To: <20091008013423.GA26059@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 16, 2009 at 12:22:36PM -0300, Rafael Ignacio Zurita wrote:
> Regarding platform bits, let me show you just the current idea to 
> put the platform bits in the proper place : 
> 
>  arch/sh/boards/mach-hp6xx/setup.c        |   58 ++++
>  include/sound/dac_audio.h                |   21 ++
>  sound/sh/snd_sh_dac_audio.c              |  471 ++++++++++++++++++++++++++++++
> 
> diff --git a/arch/sh/boards/mach-hp6xx/setup.c b/arch/sh/boards/mach-hp6xx/setup.c
> index 8f305b3..826a499 100644
> --- a/arch/sh/boards/mach-hp6xx/setup.c
> +++ b/arch/sh/boards/mach-hp6xx/setup.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/irq.h>
> +#include <sound/dac_audio.h>
>  #include <asm/hd64461.h>
>  #include <asm/io.h>
>  #include <mach/hp6xx.h>
> @@ -51,9 +52,66 @@ static struct platform_device jornadakbd_device = {
>  	.id		= -1,
>  };
>  
> +static void dac_audio_start(struct dac_audio_pdata *pdata);
> +static void dac_audio_stop(struct dac_audio_pdata *pdata);
> +
> +static struct dac_audio_pdata dac_audio_platform_data = {
> +	.buffer_size		= 64000,
> +	.channel		= 1,
> +	.start			= dac_audio_start,
> +	.stop			= dac_audio_stop,
> +};
> +
You don't need the prototype definitions, just move the platform data
definition further down.

> Is that idea better for the platform device? The new include/sound/dac_audio.h
> file has the struct for the platform data. Perhaps another platform would like
> to use the same struct, if it needs to use the driver (it should set the values
> for the members in its board code).
> 
Yes, that looks fine.
