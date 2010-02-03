From: Liam Girdwood <lrg@slimlogic.co.uk>
Date: Wed, 03 Feb 2010 16:43:44 +0000
Subject: Re: [PATCH] ASoC: fix compilation breakage in sound/soc/sh/fsi.c
Message-Id: <1265215424.3269.0.camel@odin>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, 2010-02-03 at 17:37 +0100, Guennadi Liakhovetski wrote:
> ctrl_outl() has become void at some point, which breaks compilation of fsi.c.
> Make writing functions void, as their output is anyway not evaluated, and use
> __raw_writel and __raw_readl instead of deprecated ctrl_outl and ctrl_inl
> respectively.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk

