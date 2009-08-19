From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Aug 2009 11:54:18 +0000
Subject: Re: [PATCH 2/3] Add ak464x codec support
Message-Id: <20090819115418.GA20227@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <uk51059ln.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk51059ln.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, Takashi Iwai <tiwai@suse.de>

On Wed, Aug 19, 2009 at 08:25:24PM +0900, Kuninori Morimoto wrote:
> This is very simple driver for ALSA
> It supprt headphone output and stereo input only

> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Looks mostly good, a few comments below the major one being that the
driver should be changed to use the new device model registration
method.

I'm basically OK with the use of fixed register write sequences to get
things going for your platform.  However, it'd be good if you could
document in the changelog or in comments in the code exactly what the
settings you need for your platform are so that if someone comes along
and does implement more complete support for these CODECs they know what
needs to be done to keep your platform working.  There's likely to be
some register bits you're setting simply because they're in the same
register that aren't actually required for your system.  This applies
especially for the clock configuration which will depend on your input
clock rate.

Using snd_soc_update_bits() to set only the bits you need setting might
help, but comments explaining what exactly the setup you have should
cover it.

> +/*
> + * ak464x register cache
> + */
> +static const u16 ak464x_reg[AK464X_CACHEREGNUM] = {
> +    0x0000, 0x0000, 0x0001, 0x0000,
> +    0x0002, 0x0000, 0x0000, 0x0000,
> +    0x00e1, 0x00e1, 0x0018, 0x0000,
> +    0x00e1, 0x0018, 0x0011, 0x0008,
> +    0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000, 0x0000, 0x0000, 0x0000,
> +    0x0000,
> +};

These should be indented with a tab (some of the existing drivers do get
this wrong).

> +/*
> + * read ak464x register cache
> + */
> +static inline unsigned int ak464x_read_reg_cache(struct snd_soc_codec *codec,
> +	unsigned int reg)

It'd be worth considering using the newly added soc-cache.c to factor
out some of this code (you'll need to add new register types).  Not
essential, though.

> +static int ak464x_set_bias_level(struct snd_soc_codec *codec,
> +				 enum snd_soc_bias_level level)
> +{
> +	codec->bias_level = level;
> +	return 0;
> +}

Hrm, the core doesn't take care of that for you if there's no
set_bias_level() - I'll fix that shortly so you can remove this
function.

> +struct snd_soc_dai ak464x_dai = {
> +	.name = "AK464X",
> +	.playback = {
> +		.stream_name = "Playback",
> +		.channels_min = 1,
> +		.channels_max = 2,
> +		.rates = SNDRV_PCM_RATE_8000_48000,
> +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,},

Does the device automatically detect things like the word size or are
your fixed write sequences only handling some cases?

> +
> +static int __init ak464x_modinit(void)
> +{
> +	return snd_soc_register_dai(&ak464x_dai);
> +}
> +module_init(ak464x_modinit);

> +static void __exit ak464x_exit(void)
> +{
> +	snd_soc_unregister_dai(&ak464x_dai);
> +}
> +module_exit(ak464x_exit);

The driver should be converted to use the normal device model
registration methods - the registration of the DAIs in the module
startup is a compatibility hack that's being used for old drivers that
haven't yet made the transition.  The WM8731 driver has a fairly
straightforward example of how the transition can be done.
