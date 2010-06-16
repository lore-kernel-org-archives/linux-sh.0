From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 16 Jun 2010 15:43:58 +0000
Subject: Re: [PATCH v2] soc/sh: Fix I2C dependency for SND_FSI_AK4642 and
Message-Id: <20100616154358.GE24491@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <201006141739.42346.PeterHuewe@gmx.de>
 <201006151649.07554.PeterHuewe@gmx.de>
 <20100615151913.GJ14510@rakim.wolfsonmicro.main>
 <201006151738.56143.PeterHuewe@gmx.de>
In-Reply-To: <201006151738.56143.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Huewe <PeterHuewe@gmx.de>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

On Tue, Jun 15, 2010 at 05:38:55PM +0200, Peter Huewe wrote:
> From: Peter Huewe <peterhuewe@gmx.de>
> 
> The config option SND_FSI_AK4642 selects SND_SOC_AK4642 which in turn
> enables the compilation of ak4642.c - however this codec uses I2C to
> communicate with the HW.
> Same applies to DA7210.

Applied, thanks.
