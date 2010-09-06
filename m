From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 06 Sep 2010 08:27:56 +0000
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Message-Id: <Pine.LNX.4.64.1009060932430.20387@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
 <w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, 31 Aug 2010, Kuninori Morimoto wrote:

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> o based on Mark's latest "for-2.6.37"
> 
>  drivers/video/sh_mobile_hdmi.c |   65 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 65 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
> index d25e348..f14c58a 100644
> --- a/drivers/video/sh_mobile_hdmi.c
> +++ b/drivers/video/sh_mobile_hdmi.c
> @@ -22,6 +22,8 @@
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/initval.h>
>  
>  #include <video/sh_mobile_hdmi.h>
>  #include <video/sh_mobile_lcdc.h>
> @@ -222,6 +224,62 @@ static u8 hdmi_read(struct sh_hdmi *hdmi, u8 reg)
>  	return ioread8(hdmi->base + reg);
>  }
>  
> +/************************************************************************
> +
> +
> +			HDMI sound
> +
> +
> +************************************************************************/

I don't think this comment deserves 7 lines of text, besides breaking the 
multiline comment style. If you think, one line like

/*			HDMI sound			*/

is not enough how about just

/*
 *			HDMI sound
 */

?

> +static unsigned int sh_hdmi_snd_read(struct snd_soc_codec *codec,
> +				     unsigned int reg)
> +{
> +	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
> +
> +	return hdmi_read(hdmi, reg);
> +}
> +
> +static int sh_hdmi_snd_write(struct snd_soc_codec *codec,
> +			     unsigned int reg,
> +			     unsigned int value)
> +{
> +	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
> +
> +	hdmi_write(hdmi, value, reg);
> +	return 0;
> +}

Are these two actually needed? As long as you don't have a register cache 
- no need for these?

> +
> +static struct snd_soc_dai_driver sh_hdmi_dai = {
> +	.name = "sh_mobile_hdmi-hifi",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,

Can it actually do mono? Maybe at probe time you could look at audio flags 
from your previous patch and, e.g., for SPDIF set channels_min to 2?

> +		.channels_max = 2,

That's the "smallest max," yes. With some other interfaces (I2S, DSD) it 
can support up to 8 channels...

> +		.rates = SNDRV_PCM_RATE_8000_48000,

Hm, in the datasheet I see supported frequencies 32kHz to 192kHz. And if 
you promise support for multiple frequencies, don't you want to implement 
.hw_params? Besides, not all of these frequencies will be available, 
depending on your supplied clock and your willingness to implement 
downsampling.

> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,

Again, this I am not sure about. The datasheet says 16 to 32 bit are 
possible, but then I only see configuration for 16 to 24 bits, but in any 
case, I think, you'd want to implement .hw_params to support non-default 
formats.

> +	},
> +};
> +
> +static int sh_hdmi_snd_probe(struct snd_soc_codec *codec)
> +{
> +	dev_info(codec->dev, "SH Mobile HDMI Audio Codec");
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_codec_driver soc_codec_dev_sh_hdmi = {
> +	.probe		= sh_hdmi_snd_probe,
> +	.read		= sh_hdmi_snd_read,
> +	.write		= sh_hdmi_snd_write,
> +};
> +
> +/************************************************************************
> +
> +
> +			HDMI video
> +
> +
> +************************************************************************/

See above - 7 lines seem to be an overkill to me.

>  /* External video parameter settings */
>  static void hdmi_external_video_param(struct sh_hdmi *hdmi)
>  {
> @@ -804,6 +862,11 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	}
>  
> +	ret =  snd_soc_register_codec(&pdev->dev,
> +			&soc_codec_dev_sh_hdmi, &sh_hdmi_dai, 1);
> +	if (ret < 0)
> +		goto egetclk;
> +
>  	hdmi->dev = &pdev->dev;
>  
>  	hdmi->hdmi_clk = clk_get(&pdev->dev, "ick");

NAK. This breaks the error path and has to be fixed. Firstly, please, use 
a new label like "esndreg," secondly, you have to add

 	clk_disable(hdmi->hdmi_clk);
 erate:
 	clk_put(hdmi->hdmi_clk);
 egetclk:
+	snd_soc_unregister_codec(&pdev->dev);
+esndreg:
 	mutex_destroy(&hdmi->mutex);
 	kfree(hdmi);
 

to the error path.

Besides, I think, this will not link without CONFIG_SND_SOC.

> @@ -901,6 +964,8 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	int irq = platform_get_irq(pdev, 0);
>  
> +	snd_soc_unregister_codec(&pdev->dev);
> +
>  	pdata->lcd_chan->board_cfg.display_on = NULL;
>  	pdata->lcd_chan->board_cfg.display_off = NULL;
>  	pdata->lcd_chan->board_cfg.board_data = NULL;
> -- 
> 1.7.0.4

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
