From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 23 Jan 2010 20:47:30 +0000
Subject: Re: [alsa-devel] [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <20100123204730.GC4174@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
 <Pine.LNX.4.64.1001221659410.4652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001221659410.4652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Fri, Jan 22, 2010 at 05:27:53PM +0100, Guennadi Liakhovetski wrote:

> The WM8978 codec from Wolfson Microelectronics is very similar to wm8974, but
> is stereo and also has some differences in pin configuration and internal
> signal routing. This driver is based on wm8974 and takes the differences into
> account.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

A few issues below remaining, mostly to do with the DAPM updates.

> 1. thanks for the header, Mark, but unfortunately it contains errors 
>    (duplicate register names, duplicate and wrong bitfield names)

Discussion on IRC revealed that this was a case of a small number of
typos and stuff that can be quickly fixed with indent :/

> 3. I am still not convinced, that macro names like WM8978_WL or 
>    WM8978_DLRSWAP or WM8978_MS or... better describe the meaning of the 
>    bitfield than respective comment in the source. Here's an example of a 
>    comment from this patch:

> 	/* bit 3: enable bias, bit 2: enable I/O tie off buffer */
> 	power1 |= 0xc;

The comments and bitfield names do different things here; having words
is useful to explain what you're trying to accomplish while using
symbolic bitmasks is for connecting the bitbashing with the datasheet
when the datasheet names the bitfields.

> +static const int update_reg[] = {
> +	0xb, 0xc, 0xf, 0x10, 0x2d, 0x2e, 0x34, 0x35, 0x36, 0x37
> +};

It would be really helpful to use the symbolic names for the registers
here.  It'd also be nice to move this closer to the point where it's
used or have a comment explaining what will happen with it.

> +static const SOC_ENUM_SINGLE_DECL(adc_compand, WM8978_COMPANDING_CONTROL, 1, wm8978_companding);
> +static const SOC_ENUM_SINGLE_DECL(dac_compand, WM8978_COMPANDING_CONTROL, 3, wm8978_companding);

Line wrapping please.

> +	SOC_SINGLE_TLV("Left PCM Volume",
> +		WM8978_LEFT_DAC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),
> +	SOC_SINGLE_TLV("Right PCM Volume",
> +		WM8978_RIGHT_DAC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),

This should be a single stereo (_DOUBLE) control.

> +	SOC_SINGLE_TLV("Left ADC Volume",
> +	       WM8978_LEFT_ADC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),
> +	SOC_SINGLE_TLV("Right ADC Volume",
> +	       WM8978_RIGHT_ADC_DIGITAL_VOLUME, 0, 255, 0, digital_tlv),

As should this.

> +	SOC_SINGLE_TLV("Left Headphone Playback Volume",
> +		WM8978_LOUT1_HP_CONTROL, 0, 63, 0, spk_tlv),

These also, and the speaker ones too.

> +/* Mixer #3: Boost (Input) mixer */
> +static const struct snd_kcontrol_new wm8978_left_boost_mixer[] = {
> +
> +	SOC_DAPM_SINGLE("PGA Boost (+20dB)",
> +		WM8978_LEFT_ADC_BOOST_CONTROL, 8, 1, 0),

This isn't actually a mute so the connection to the PGA should (unless
there's something extra going on) be unconditional and this should be a
non-DAPM switch.

> +/* Input PGA volume */
> +static const struct snd_kcontrol_new wm8978_left_input_pga_volume[] = {
> +	SOC_DAPM_SINGLE_TLV("Volume",
> +		WM8978_LEFT_INP_PGA_CONTROL, 0, 63, 0, inpga_tlv),
> +};
> +static const struct snd_kcontrol_new wm8978_right_input_pga_volume[] = {
> +	SOC_DAPM_SINGLE_TLV("Volume",
> +		WM8978_RIGHT_INP_PGA_CONTROL, 0, 63, 0, inpga_tlv),
> +};

It's just as well to take these off the PGAs, there's unlikely to be any
actual benefit from handling them with the PGAs on a modern CODEC.

> +/* Headphone */
> +static const struct snd_kcontrol_new wm8978_left_hp_mute[] = {
> +	SOC_DAPM_SINGLE("Mute Switch", WM8978_LOUT1_HP_CONTROL, 6, 1, 1),
> +};
> +static const struct snd_kcontrol_new wm8978_right_hp_mute[] = {
> +	SOC_DAPM_SINGLE("Mute Switch", WM8978_ROUT1_HP_CONTROL, 6, 1, 1),
> +};

Mute switches should always be just "Switch" - ALSA will map "Foo
Switch" and "Foo Volume" together to create a single control in the UI.

These (and the other output nodes) should really be stereo controls
outside of DAPM.  Managing them within DAPM as switches means that if
you mute the output then the path will be powered down.  This is
normally unhelpful since power up and down during playback can produce
audible effects for the listener such as pops and clicks or audible
volume ramps as the power comes on and off.  It's also possible that
some output will leak through when the output is powered down since
normally mutes on PGAs only work when they are powered.

> +	if (freq_in = 0 || freq_out = 0) {
> +		/* Clock CODEC directly from MCLK */
> +		reg = snd_soc_read(codec, WM8978_CLOCKING);
> +		snd_soc_write(codec, WM8978_CLOCKING, reg & ~0x100);
> +
> +		/* Turn off PLL */
> +		reg = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1);
> +		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, reg & ~0x20);
> +		return 0;
> +	}

Note that ideally the PLL updates will handle the case where the PLL is
already on and power down the PLL while reconfiguring it, though it's
not essential.

> +	opclk_div = ((snd_soc_read(codec, WM8978_GPIO_CONTROL) & 0x30) >> 4) + 1;

> +	wm8978->f_pllout = freq_out * opclk_div;

Hrm.  I fear that there's a bit of confusion here - the PLL output is
used separately as the source for both OPCLK and the system clock for
the CODEC.  This means that the PLL output frequency that we need to
refer to later on is that before the OPCLK divide.

Looking further down the driver f_pllout is also being used as the
system master clock frequency, meaning that the driver will only work
when the PLL is in use.  Normally what would happen with this stuff is
that the system clock used by hw_params() will be set using the
set_sysclk() API call, which can tell the driver what the clock rate is
and also select between multiple clock sources.  You'd end up saying
something like:

	snd_soc_dai_set_pll(dai, 0, 0, 12000000, 256 * params_rate(params));
	snd_soc_dai_set_sysclk(dai, WM8978_PLL, 256 * params_rate(params), 0);

in the machine driver (note that this also means that the switchover to
use of the PLL as the clock would then be managed via set_sysclk() not
set_pll()).
