From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 Oct 2009 01:22:24 +0000
Subject: Re: [PATCH] sh: add SuperH DAC audio driver for ALSA
Message-Id: <20091009012224.GB31816@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091008013423.GA26059@rafazurita.homelinux.net>
In-Reply-To: <20091008013423.GA26059@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 07, 2009 at 10:34:23PM -0300, Rafael Ignacio Zurita wrote:
> diff --git a/sound/sh/Kconfig b/sound/sh/Kconfig
> index aed0f90..fecb198 100644
> --- a/sound/sh/Kconfig
> +++ b/sound/sh/Kconfig
> @@ -19,5 +19,14 @@ config SND_AICA
>  	help
>  	  ALSA Sound driver for the SEGA Dreamcast console.
>  
> +config SND_SH_DAC_AUDIO
> +	tristate "SuperH DAC audio support"
> +	depends on SND
> +	depends on CPU_SH3 && HIGH_RES_TIMERS
> +	select SND_PCM
> +	help
> +	  Alsa Sound driver for the HP Palmtop 620lx/660lx
> +	  and HP Jornada 680/690.
> +
This Kconfig entry is in need of some help. For starters, there is
nothing hp6xx dependent about this that can't be easily abstracted. The
whole reason this is called SH DAC audio in the first place is because it
is a driver for the on-chip DAC found in many legacy SH parts. While it's
true that hp6xx is the only in-tree user of this at the moment, it's
forseeable that other SH-3 boards may make use of this as well.

> +#include <linux/hrtimer.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/platform_device.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/pcm.h>
> +#include <asm/clock.h>
> +#include <asm/hd64461.h>
> +#include <mach-common/mach/hp6xx.h>

#include <mach/hp6xx.h> only.

> +/* Simple platform device */
> +static struct platform_device *pd;
> +
This shouldn't be in the driver, the board code should be registering its
own platform device.

> +#define SND_SH_DAC_DRIVER "SH_DAC"
> +#define BUFFER_SIZE	64000
> +#define SH_DAC_AUDIO_CHANNEL 1
> +
Buffer size and audio channel are things that ideally belong in platform
data, as these will not be consistent on other platforms.

> +static void dac_audio_sync(struct snd_sh_dac *chip)
> +{
> +	while (!chip->empty)
> +		schedule();

This should have a timeout?

> +static void dac_audio_start(void)
> +{
> +#ifdef CONFIG_SH_HP6XX
> +	u16 v;
> +	u8 v8;
> +
> +	/* HP Jornada 680/690 speaker on */
> +	v = inw(HD64461_GPADR);
> +	v &= ~HD64461_GPADR_SPEAKER;
> +	outw(v, HD64461_GPADR);
> +
> +	/* HP Palmtop 620lx/660lx speaker on */
> +	v8 = inb(PKDR);
> +	v8 &= ~PKDR_SPEAKER;
> +	outb(v8, PKDR);
> +#endif
> +	sh_dac_enable(SH_DAC_AUDIO_CHANNEL);
> +}
> +
> +static void dac_audio_stop(struct snd_sh_dac *chip)
> +{
> +
> +#ifdef CONFIG_SH_HP6XX
> +	u16 v;
> +	u8 v8;
> +#endif
> +
> +	dac_audio_stop_timer(chip);
> +
> +#ifdef CONFIG_SH_HP6XX
> +	/* HP Jornada 680/690 speaker off */
> +	v = inw(HD64461_GPADR);
> +	v |= HD64461_GPADR_SPEAKER;
> +	outw(v, HD64461_GPADR);
> +
> +	/* HP Palmtop 620lx/660lx speaker off */
> +	v8 = inb(PKDR);
> +	v8 |= PKDR_SPEAKER;
> +	outb(v8, PKDR);
> +#endif
> +	sh_dac_output(0, SH_DAC_AUDIO_CHANNEL);
> +	sh_dac_disable(SH_DAC_AUDIO_CHANNEL);
> +}
> +
This shows that at least the start/stop routines need to be defined by
the platform, while the driver only takes care of the hrtimer management.
As such, these need to be moved in to function pointers in the platform
data and moved in to the platform code.

> +static int snd_sh_dac_pcm_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *hw_params)
> +{
> +	return
> +	snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
> +}
> +
This is a very unusual format, please break it up in a more coherent
fashion, ie:

	return snd_pcm_lib_malloc_pages(substream,
			params_buffer_bytes(hw_params));

> +static int __devinit snd_sh_dac_create(struct snd_card *card,
> +				       struct platform_device *devptr,
> +				       struct snd_sh_dac **rchip)
> +{
[snip]
> +	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
> +	if (chip = NULL)
> +		return -ENOMEM;
> +
> +	chip->card = card;
> +
> +	hrtimer_init(&chip->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	chip->hrtimer.function = sh_dac_audio_timer;
> +
> +	dac_audio_reset(chip);
> +	chip->rate = 8000;
> +	dac_audio_set_rate(chip);
> +
> +	chip->data_buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
> +	if (chip->data_buffer = NULL)
> +		return -ENOMEM;
> +
This is insufficient for an error path, chip is leaked.

> +/* clean up the module */
> +static void __exit sh_dac_exit(void)
> +{
> +	platform_device_unregister(pd);
> +	platform_driver_unregister(&driver);
> +}
> +
> +
> +static int __init sh_dac_init(void)
> +{

For some reason you have these defined in reverse order.

> +	int err;
> +
> +	err = platform_driver_register(&driver);
> +	if (unlikely(err < 0))
> +		return err;
> +
> +	pd = platform_device_register_simple(SND_SH_DAC_DRIVER, -1, NULL, 0);
> +	if (unlikely(IS_ERR(pd))) {
> +		platform_driver_unregister(&driver);
> +		return PTR_ERR(pd);
> +	}
> +
> +	return 0;
> +}

Once you kill off the platform device silliness, this can just be a
simple

	return platform_driver_register(&driver);
