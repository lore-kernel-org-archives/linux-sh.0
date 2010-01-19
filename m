From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 19 Jan 2010 12:34:16 +0000
Subject: Re: [PATCH 2/4] ASoC: add DAI and platform drivers for SH SIU and
Message-Id: <20100119123416.GA3040@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>

On Tue, Jan 19, 2010 at 09:09:01AM +0100, Guennadi Liakhovetski wrote:

> Several SuperH platforms, including sh7722, sh7343, sh7354, sh7367 include a
> Sound Interface Unit (SIU). This patch adds drivers for this interface and
> support for the sh7722 Migo-R board.

Normally you'd split the board support into a separate patch, and
splitting the DMA and DAI drivers wouldn't hurt either.  It makes the
review easier by keeping the patches smaller and more focused.

> +config SND_SIU_MIGOR
> +	tristate "SIU sound support on Migo-R"
> +	depends on SND_SOC_SH4_SIU && SH_MIGOR
> +	select SND_SOC_WM8978
> +	help
> +	  This option enables generic sound support for the
> +	  SH7722 Migo-R board
> +

I'd be tempted to just make SND_SOC_SH4_SIU a hidden variable and select
it from here.  I know that most of the CPU DAIs are exposed but it
doesn't actually seem to buy us anything.

> +/* Default 8000Hz sampling frequency */
> +static unsigned long codec_freq = 49152350 / 12;

Perhaps a #define for the input clock rate (I'm assuming that this is
what the 49152350 is)?

> +	switch (rate) {
> +	case 48000:
> +		mclk_div = 0x40;
> +		opclk_div = 0;
> +		/* f2 = 98304000, was 98304050 */

Like Liam says either remove these comments or clarify them please :)

> +	/*
> +	 * Calculate f2, according to Figure 40 "PLL and Clock Select Circuit"
> +	 * in WM8978 datasheet
> +	 */
> +	f2 = rate * 256 * 4 * mclk_numerator[mclk_idx] /
> +		mclk_denominator[mclk_idx];

Figure 40 of the current datasheet is the DSP mode B clock diagram -
it's now figure 41.  Better to include a datasheet revision.

> +	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_MCLKDIV,
> +				     mclk_div & 0xe0);
> +	if (ret < 0)
> +		return ret;

This doesn't feel like something that the machine driver should have to
figure out, the CODEC driver should be able to figure out the MCLK
division from a set_sysclk() call telling it the PLL/MCLK frequency.
This would mean that the machine driver would need to at most specify
the PLL output frequency.

> +	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_OPCLKDIV, opclk_div);
> +	if (ret < 0)
> +		return ret;

I said add a set_clkdiv() option for the output clock GPIO configuration
- now that I think about it you can probably do this on any configuration
of OPCLKDIV by a machine driver.

> +	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8978_DACCLK, 8);
> +	if (ret < 0)
> +		return ret;

The DAC clock configuration can probably be factored into the CODEC
driver - you should know (or be able to be told) the CODEC system clock
so this should then only have an internal effect.

> +	/* See Figure 40 */
> +	codec_freq = f2 / ((opclk_div >> 4) + 1) >> 2;

This feels like something that should be wrapped up in the CODEC
driver.  In any case, 

> +static int migor_hw_free(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +
> +	/* disable the PLL */
> +	return snd_soc_dai_set_pll(codec_dai, 0, 0, 0, 0);

This will happen for both playback and once for record, meaning that if
you've got both running then the first one to stop will halt the PLL
which probably isn't what you want.

> +static int migor_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_device *socdev = rtd->socdev;
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +	int ret;
> +
> +	/* Activate DAC output routes */
> +	ret = snd_soc_dapm_enable_pin(codec, "Left Speaker Out");
> +	if (ret < 0) {
> +		dev_warn(socdev->dev, "Left err %d\n", ret);
> +		return ret;
> +	}

Why are you doing this?  DAPM will automatically manage the power of the
DAC widget based on the playback state.

> +/* Board specifics */
> +#if defined(CONFIG_CPU_SUBTYPE_SH7722)
> +# define MAX_VOLUME		0x1000
> +#else
> +# define MAX_VOLUME		0x7fff
> +#endif

These defines could do with namespacing.

> +/* SIU registers */
> +#define IFCTL		(0x000 / sizeof(u32))
> +#define SRCTL		(0x004 / sizeof(u32))

As could all these.

> +/*
> + * At the moment only fixed Left-upper, Left-lower, Right-upper, Right-lower
> + * packing is supported

In what way are these supported?  The function appears to always set the
same register value...
 
> +static struct snd_kcontrol_new capture_controls = {
> +	.iface		= SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name		= "PCM Capture Volume",

When we have multi-CODEC support we'll want to integrate these controls
with that since that'll have to be able to sort out the potential
namespace collison issues.

> +/*
> + * SIU can set bus format to I2S / PCM / SPDIF independently for playback and
> + * capture, however, the current API sets the bus format globally for a DAI.
> + */

You should handle this by having separate DAIs for playback and capture
at the ASoC level if you want to support it, if all the signals going
out of the processor are independant there's no need for the rest of the
system to know that they're related internally.  However, forcing
symmetry is fine for now.

> +	parent_clk = clk_get(siu_i2s_dai.dev, parent_name);
> +	if (!IS_ERR(parent_clk)) {
> +		ret = clk_set_parent(siu_clk, parent_clk);
> +		if (!ret)
> +			clk_set_rate(siu_clk, freq);
> +	}

> +	clk_put(parent_clk);

Does clk_put() mind getting fed PTR_ERR() pointers?
