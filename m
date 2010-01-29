From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Jan 2010 13:57:34 +0000
Subject: Re: [PATCH 1/4 v4] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001291452110.4613@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
	<20100127201755.GA11601@rakim.wolfsonmicro.main>
In-Reply-To: <20100127201755.GA11601@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, 27 Jan 2010, Mark Brown wrote:

> On Wed, Jan 27, 2010 at 06:56:23PM +0100, Guennadi Liakhovetski wrote:

[snip]

> > +	if (f_opclk) {
> 
> ...
> 
> > +		if (16 * f_opclk < 3 * f_mclk || 4 * f_opclk >= 13 * f_mclk)
> > +			return -EINVAL;
> > +
> > +		if (4 * f_opclk < 3 * f_mclk)
> > +			/* Have to use OPCLKDIV */
> > +			opclk_div = (3 * f_mclk / 4 + f_opclk - 1) / f_opclk;
> > +		else
> > +			opclk_div = 1;
> 
> I'm fairly sure this and the similar logic for SYSCLK can be squashed
> together with some suitable local variables.  Might be more legible
> since this requires some staring at.  I didn't actually go so far as to
> work out what the relevant code is, though.

Well, not really. In one case f_PLLOUT can be derived directly, because 
OPCLKDIV covers the whole its value range 1-4, whereas MCLKDIV takes 
values 1, 3/2, 2, 3, 4, 6, 8, 12, so, you have to apply an iterative 
process to select the best match. I've just sent a patch, that improves 
these calculations. It should be the last patch for my SIU / wm8978 / 
migor support so far.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
