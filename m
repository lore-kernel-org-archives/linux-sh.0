From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 03 Feb 2010 18:00:17 +0000
Subject: Re: [PATCH] ASoC: fix compilation breakage in sound/soc/sh/fsi.c
Message-Id: <20100203180016.GA25802@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002031735230.6324@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Feb 03, 2010 at 05:37:23PM +0100, Guennadi Liakhovetski wrote:
> ctrl_outl() has become void at some point, which breaks compilation of fsi.c.
> Make writing functions void, as their output is anyway not evaluated, and use
> __raw_writel and __raw_readl instead of deprecated ctrl_outl and ctrl_inl
> respectively.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
