From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jan 2010 20:01:46 +0000
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001202051370.4151@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	<1263897964.3089.54.camel@odin>
In-Reply-To: <1263897964.3089.54.camel@odin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org

On Tue, 19 Jan 2010, Liam Girdwood wrote:

> Looks ok, some questions below.
> 
> On Tue, 2010-01-19 at 09:08 +0100, Guennadi Liakhovetski wrote:
> > The WM8978 codec from Wolfson Microelectronics is very similar to wm8974, but
> > is stereo and also has some differences in pin configuration and internal
> > signal routing. This driver is based on wm8974 and takes the differences into
> > account.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---

[snip]

> > +/* OUT1 - HeadPhones */
> > +SOC_SINGLE("Left HeadPhone Playback ZC Switch",
> > +	   WM8978_LOUT1_HP_CONTROL, 7, 1, 0),
> 
> HeadPhone is usually "Headphone"

Ok

> > +#define MIXER_ARRAY(n, r, s, i, m) SND_SOC_DAPM_MIXER(n, r, s, i, \
> > +							m, ARRAY_SIZE(m))
> 
> I'd be tempted to rename this and add to soc-dapm.h

Please, see my reply to Mark's review.

> > +static void pll_factors(struct wm8978_pll_div *pll_div, unsigned int target,
> > +			unsigned int source)
> > +{
> > +	u64 Kpart;
> > +	unsigned int K, Ndiv, Nmod;
> > +
> > +	Ndiv = target / source;
> > +	if (Ndiv < 6) {
> > +		source >>= 1;
> > +		pll_div->div2 = 1;
> > +		Ndiv = target / source;
> > +	} else {
> > +		pll_div->div2 = 0;
> > +	}
> > +
> 
> I would personally not put the extra { here

That's also what I did a couple of years ago, but this contradicts the 
kernel CodingStyle, and, I think, checkpatch would complain too.

> > +	snd_soc_write(codec, WM8978_AUDIO_INTERFACE, iface_ctl);
> > +	snd_soc_write(codec, WM8978_ADDITIONAL_CONTROL, add_ctl);
> > +
> > +	/* Mic bias */
> > +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1,
> > +		      (snd_soc_read(codec, 1) & ~4) | 0x10);
> > +
> > +	/* Out-1 enabled, left/right input channel enabled */
> > +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_2, 0x1bf);
> > +
> > +	/* Out-2 disabled, right/left output channel enabled, dac enabled */
> > +	snd_soc_write(codec, WM8978_POWER_MANAGEMENT_3, 0x10f);
> 
> Power stuff should be in either dapm or bias functions.

Yes, still working on this.

> > +#define WM8978_LOUT2_SPK_CONTROL		0x36
> > +#define WM8978_ROUT2_SPK_CONTROL		0x37
> > +#define WM8978_OUT3_MIXER_CONTROL		0x38
> > +#define WM8978_OUT4_MIXER_CONTROL		0x39
> > +
> > +#define WM8978_CACHEREGNUM			58
> > +
> 
> It would be nice to have the relevant bits defined here for set_fmt()
> etc instead of just the magic numbers used in the above codec driver. 

As I explained privately, I agree, that using names instead of bits helps 
- but (mostly) only where those bits are reused multiple times in the 
code. If you only have to initialise a register once with some bitmask, I 
think, code like

	/* Enable input X, output Y, set default W polarity to Z */
	__raw_writel(0x123, reg);

looks better than

	__raw_writel(CHIP_INPUT_X_ENABLE | CHIP_OUTPUT_Y_ENABLE | 
			CHIP_SIGNAL_W_POLARITY_Z, reg);

so, unless there strong preferences in ALSA world, I'll try to combine 
both. Let me know if this contradicts the common ALSA style.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
