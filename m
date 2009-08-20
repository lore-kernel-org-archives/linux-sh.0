From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 20 Aug 2009 18:58:36 +0000
Subject: Re: [alsa-devel] [PATCH v2 2/4] Add ak464x codec support
Message-Id: <20090820185835.GE5032@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <uws4yd793.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws4yd793.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Aug 20, 2009 at 09:01:12PM +0900, Kuninori Morimoto wrote:
> This is very simple driver for ALSA
> It supprt headphone output and stereo input only
> This patch is tested by ms7724se

Thanks, this looks good but it needs updating for a recent change in the
current ASoC tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

sound/soc/codecs/ak4642.c: In function ‘ak4642_read’:
sound/soc/codecs/ak4642.c:130: warning: passing argument 2 of ‘codec->hw_read’ makes integer from pointer without a cast
sound/soc/codecs/ak4642.c:130: error: too many arguments to function ‘codec->hw_read’
sound/soc/codecs/ak4642.c: In function ‘ak4642_init’:
sound/soc/codecs/ak4642.c:332: warning: assignment from incompatible pointer type

Also, a couple of minor issues:

> +static const struct i2c_device_id ak4642_i2c_id[] = {
> +	{ "ak4642", 0 },
> +	{ }
> +};

Since the ak4643 is also supported you should add an entry for it to
this table.

> +struct ak4642_setup_data {
> +	int            i2c_bus;
> +	unsigned short i2c_address;
> +};

This struct isn't used any more and so should be removed.
