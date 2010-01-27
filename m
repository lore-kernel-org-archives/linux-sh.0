From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 27 Jan 2010 13:16:37 +0000
Subject: Re: [PATCH 1/4 v3] ASoC: add a WM8978 codec driver
Message-Id: <20100127131636.GI22551@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001270822310.5073@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001270822310.5073@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Wed, Jan 27, 2010 at 12:11:37PM +0100, Guennadi Liakhovetski wrote:

This is mostly OK.  I suspect the clocking may need altering at some
point if someone comes up with additional constraints but it should be
OK for now.

> +	/* Headphone */
> +	SOC_DOUBLE_R("Headphone Mute Switch",
> +		WM8978_LOUT1_HP_CONTROL, WM8978_ROUT1_HP_CONTROL, 6, 1, 1),
> +
> +	/* Speaker */
> +	SOC_DOUBLE_R("Speaker Mute Switch",
> +		WM8978_LOUT2_SPK_CONTROL, WM8978_ROUT2_SPK_CONTROL, 6, 1, 1),

Just "Switch" rather than "Mute Switch".

> +/*
> + * @freq:	f_PLLOUT - output PLL frequency
> + *
> + * Calculate internal frequencies and dividers, according to Figure 40
> + * "PLL and Clock Select Circuit" in WM8978 datasheet Rev. 2.6
> + */
> +static int wm8978_configure_pll(struct snd_soc_codec *codec)

There's no @freq parameter any more.

> +	if (f_opclk) {
> +		/*
> +		 * The user needs OPCLK. Choose OPCLKDIV to put
> +		 * 6 <= R = f2 / f1 < 13, 1 <= OPCLKDIV <= 4.
> +		 * f_opclk = f_mclk * prescale * R / 4 / OPCLKDIV, where
> +		 * prescale = 1, or prescale = 2. Prescale is calculated inside
> +		 * pll_factors((). We have to select f_PLLOUT, such that
> +		 * f_mclk * 3 / 4 <= f_PLLOUT < f_mclk * 13 / 4. Must be
> +		 * f_mclk * 3 / 16 <= f_opclk < f_mclk * 13 / 4.
> +		 */
> +		if (16 * f_opclk < 3 * f_mclk || 4 * f_opclk >= 13 * f_mclk)
> +			return -EINVAL;
> +
> +		if (4 * f_opclk < 3 * f_mclk)
> +			/* Have to use OPCLKDIV */
> +			opclk_div = (3 * f_mclk / 4 + f_opclk - 1) / f_opclk;
> +		else
> +			opclk_div = 1;

I can't help but think that this logic ought to get pulled out and be
applied even if we're only clocking the CODEC and not generating OPCLK.
The constraints on the PLL apply either way and 

> +	/* Turn PLL on */
> +	snd_soc_update_bits(codec, WM8978_POWER_MANAGEMENT_1, 0x20, 0x20);

For bonus fun points the PLL should get stopped before the configuration
gets written out.

> +	case WM8978_MCLKDIV:
> +		if (div & ~0xe0)
> +			return -EINVAL;
> +		snd_soc_update_bits(codec, WM8978_CLOCKING, 0xe0, div);
> +		break;
> +	case WM8978_ADCCLK:
> +		if (div & ~8)
> +			return -EINVAL;
> +		snd_soc_update_bits(codec, WM8978_ADC_CONTROL, 8, div);
> +		break;
> +	case WM8978_DACCLK:
> +		if (div & ~8)
> +			return -EINVAL;
> +		snd_soc_update_bits(codec, WM8978_DAC_CONTROL, 8, div);
> +		break;
> +	case WM8978_BCLKDIV:
> +		if (div & ~0x1c)
> +			return -EINVAL;
> +		snd_soc_update_bits(codec, WM8978_CLOCKING, 0x1c, div);
> +		break;

Given how keen you are on figuring out the configuration automatically
I'm surprised you've left these in :P .

> +	if (diff)
> +		dev_warn(codec->dev, "Imprecise clock: %u%s\n",
> +			 f_sel * mclk_denominator[best] / mclk_numerator[best],
> +			 wm8978->sysclk = WM8978_MCLK ?
> +			 ", consider using PLL" : "");

I'll never understand why people are so fond of the ternery operator :/

> +	if (wm8978->sysclk != current_clk_id) {
> +		if (wm8978->sysclk = WM8978_PLL)
> +			/* Run CODEC from PLL instead of MCLK */
> +			snd_soc_update_bits(codec, WM8978_CLOCKING,
> +					    0x100, 0x100);
> +		else
> +			/* Clock CODEC directly from MCLK */
> +			snd_soc_update_bits(codec, WM8978_CLOCKING, 0x100, 0);
> +	}

Actually, for super bonus fun points what'd be nice would be to only use
the PLL in cases where the input clock is not able to generate the
output directly.

> +static int wm8978_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec = socdev->card->codec;
> +
> +	wm8978_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}

suspend and resume should really take care of stopping and starting the
PLL if it's still running.
