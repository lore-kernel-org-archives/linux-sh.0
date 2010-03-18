From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Thu, 18 Mar 2010 09:01:05 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: SIU driver shall select FW_LOADER
Message-Id: <1268902865.3773.15.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003180916590.4485@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1003180916590.4485@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Thu, 2010-03-18 at 09:39 +0100, Guennadi Liakhovetski wrote:
> The SIU ASoC driver must load firmware to program the DSP, therefore it 
> has to select FW_LOADER in its Kconfig entry.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

