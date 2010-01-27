From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 27 Jan 2010 20:17:55 +0000
Subject: Re: [PATCH 1/4 v4] ASoC: add a WM8978 codec driver
Message-Id: <20100127201755.GA11601@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Wed, Jan 27, 2010 at 06:56:23PM +0100, Guennadi Liakhovetski wrote:

> The WM8978 codec from Wolfson Microelectronics is very similar to wm8974, 
> but
> is stereo and also has some differences in pin configuration and internal
> signal routing. This driver is based on wm8974 and takes the differences 
> into
> account.

I suspect something funny with word wrapping :)

There's a few more fairly small issues below but I'll apply the patch
as-is, please send incremental patches to fix these things.

> +	if (f_opclk) {

...

> +		if (16 * f_opclk < 3 * f_mclk || 4 * f_opclk >= 13 * f_mclk)
> +			return -EINVAL;
> +
> +		if (4 * f_opclk < 3 * f_mclk)
> +			/* Have to use OPCLKDIV */
> +			opclk_div = (3 * f_mclk / 4 + f_opclk - 1) / f_opclk;
> +		else
> +			opclk_div = 1;

I'm fairly sure this and the similar logic for SYSCLK can be squashed
together with some suitable local variables.  Might be more legible
since this requires some staring at.  I didn't actually go so far as to
work out what the relevant code is, though.

> +	case WM8978_MCLKDIV:
> +		if (div & ~0xe0)
> +			return -EINVAL;
> +		snd_soc_update_bits(codec, WM8978_CLOCKING, 0xe0, div);
> +		break;

This is now configured automatically isn't it?

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

These should be user visible controls to select the DAC and ADC
oversampling rates.

[suspend..]
> +	/* Put to sleep */
> +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_2, 0x40);

This control isn't going to do much over suspend since it's likely the
device will completely loose power and you've already turned off all the
biases anyway.  However, it would be useful to turn it on when the
device is in BIAS_STANDBY since it should produce a small power saving
then.
