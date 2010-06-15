From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 15 Jun 2010 15:19:13 +0000
Subject: Re: [PATCH] soc/sh: Fix I2C dependency for SND_FSI_AK4642
Message-Id: <20100615151913.GJ14510@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <201006141739.42346.PeterHuewe@gmx.de>
	<20100614161034.GF14604@rakim.wolfsonmicro.main>
	<201006151649.07554.PeterHuewe@gmx.de>
In-Reply-To: <201006151649.07554.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, Jun 15, 2010 at 04:49:07PM +0200, Peter H=FCwe wrote:

> So maybe even move the dependency up to SND_SOC_SH4_FSI=20
> since both codecs rely on I2C?

No, while the two boards in mainline currently may need I2C obviously
other board designs with other control interfaces are possible so it
should be on the individual boards.
