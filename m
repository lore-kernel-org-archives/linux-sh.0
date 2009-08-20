From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 20 Aug 2009 19:04:07 +0000
Subject: Re: [alsa-devel] [PATCH v2 3/4] Add FSI-AK4642 sound support for
Message-Id: <20090820190407.GG5032@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdkid78r.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdkid78r.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>

On Thu, Aug 20, 2009 at 09:01:24PM +0900, Kuninori Morimoto wrote:

> This patch is tested by ms7724se

This looks good except...

> +struct ak4642_setup_data ak4642_setup = {
> +	.i2c_bus	= 0,
> +	.i2c_address	= 0x12, /* 0x13 */
> +};

...this shouldn't be needed any more due to the updates in the CODEC
driver.
