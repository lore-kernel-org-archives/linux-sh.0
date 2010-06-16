From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 16 Jun 2010 07:43:33 +0000
Subject: Re: [PATCH v2] soc/sh: Fix I2C dependency for SND_FSI_AK4642 and SND_FSI_DA7210
Message-Id: <250A6DE6-BB14-42F7-9500-A479C8FCA9B3@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201006141739.42346.PeterHuewe@gmx.de> <201006151649.07554.PeterHuewe@gmx.de> <20100615151913.GJ14510@rakim.wolfsonmicro.main> <201006151738.56143.PeterHuewe@gmx.de> <20100616035440.GA29614@linux-sh.org> (sfid-20100616_045500_015014_5B5A79AE)
In-Reply-To: <20100616035440.GA29614@linux-sh.org> (sfid-20100616_045500_015014_5B5A79AE)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Peter Huewe <PeterHuewe@gmx.de>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

On 16 Jun 2010, at 04:54, Paul Mundt wrote:

> On Tue, Jun 15, 2010 at 05:38:55PM +0200, Peter Huewe wrote:
>> The config option SND_FSI_AK4642 selects SND_SOC_AK4642 which in turn
>> enables the compilation of ak4642.c - however this codec uses I2C to
>> communicate with the HW.
>> Same applies to DA7210.

> It uses I2C, but it doesn't matter which I2C master it's interfaced with.
> A simple depends on I2C will suffice for this purpose just fine.

Since these are board specific drivers they know which I2C controller they are
hooked up to and so can usefully depend on a specific controller - without the
correct controller driver they will not function.