From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 03 Feb 2010 10:34:07 +0000
Subject: Re: [PATCH 1/4 v4] ASoC: add a WM8978 codec driver
Message-Id: <20100203103406.GC8300@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001271846020.5073@axis700.grange>
	<20100127201755.GA11601@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1001291452110.4613@axis700.grange>
	<20100201143120.GA26011@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1002012047200.4617@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002012047200.4617@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, Feb 01, 2010 at 09:01:41PM +0100, Guennadi Liakhovetski wrote:
> On Mon, 1 Feb 2010, Mark Brown wrote:

> > I don't follow your logic there at all, I'm afraid.  Both options have a
> > table of possible values for the divider (and hence the PLL output
> > frequencies they can use) which they need to additionally constrain
> > based on the PLL operating conditions.

> In principle, yes, both dividers have a table of possible values. But, 
> possible OPCLK dividers are 1, 2, 3, and 4, which makes it possible to 
> just calculate the needed divisor by dividing the target through the 
> source. Whereas possible MCLK divisors are 1, 3/2, 2, 3, 4, 6, 8, 12, so, 
> you cannot compute the index, therefore I just iterate over the table and 
> try each. Of course, the sequence is ascending, so, you could bisection, 
> but I found that to be an overkill for this case;)

You're missing the point here.  It's not the working out the divisor
bit that I'm noticing, it's all the stuff around it imposing the
constraints for the input frequency and the PLL itself.  What's there at
the minute seems to split the OPCLK and non-OPCLK cases too early and
has these very large comments explaining what it's trying to do - a more
step by step approach might be clearer.
