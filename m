From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 14 Jun 2010 16:10:34 +0000
Subject: Re: [PATCH] soc/sh: Fix I2C dependency for SND_FSI_AK4642
Message-Id: <20100614161034.GF14604@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <201006141739.42346.PeterHuewe@gmx.de>
In-Reply-To: <201006141739.42346.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, Jun 14, 2010 at 05:39:41PM +0200, Peter Huewe wrote:

>  	bool "FSI-AK4642 sound support"
>  	depends on SND_SOC_SH4_FSI
>  	select SND_SOC_AK4642
> +	select I2C

I'd have thought a depends was more appropriate.  Arguably you want to
depend on the SH I2C driver since the driver is useless without the
relevant I2C controller.
