From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 01 Feb 2010 20:01:41 +0000
Subject: Re: [PATCH 1/4 v4] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1002012047200.4617@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
 <20100127201755.GA11601@rakim.wolfsonmicro.main> <Pine.LNX.4.64.1001291452110.4613@axis700.grange>
 <20100201143120.GA26011@rakim.wolfsonmicro.main>
In-Reply-To: <20100201143120.GA26011@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Mon, 1 Feb 2010, Mark Brown wrote:

> On Fri, Jan 29, 2010 at 02:57:34PM +0100, Guennadi Liakhovetski wrote:
> > On Wed, 27 Jan 2010, Mark Brown wrote:
> 
> > > I'm fairly sure this and the similar logic for SYSCLK can be squashed
> > > together with some suitable local variables.  Might be more legible
> > > since this requires some staring at.  I didn't actually go so far as to
> > > work out what the relevant code is, though.
> 
> > Well, not really. In one case f_PLLOUT can be derived directly, because 
> > OPCLKDIV covers the whole its value range 1-4, whereas MCLKDIV takes 
> > values 1, 3/2, 2, 3, 4, 6, 8, 12, so, you have to apply an iterative 
> > process to select the best match. I've just sent a patch, that improves 
> 
> I don't follow your logic there at all, I'm afraid.  Both options have a
> table of possible values for the divider (and hence the PLL output
> frequencies they can use) which they need to additionally constrain
> based on the PLL operating conditions.

In principle, yes, both dividers have a table of possible values. But, 
possible OPCLK dividers are 1, 2, 3, and 4, which makes it possible to 
just calculate the needed divisor by dividing the target through the 
source. Whereas possible MCLK divisors are 1, 3/2, 2, 3, 4, 6, 8, 12, so, 
you cannot compute the index, therefore I just iterate over the table and 
try each. Of course, the sequence is ascending, so, you could bisection, 
but I found that to be an overkill for this case;)

> Looking at the code I think half the issue here is that all the
> constraints that are shared from the PLL and its input path aren't
> factored out but are in per-output conditional cases, making those more
> complex than they need to be.  The magic number heaviness of the code
> and comments accentuates the issue.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
