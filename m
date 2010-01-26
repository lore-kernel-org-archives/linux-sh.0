From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 26 Jan 2010 15:22:06 +0000
Subject: Re: [alsa-devel] [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <20100126152206.GV15759@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
 <Pine.LNX.4.64.1001221659410.4652@axis700.grange>
 <20100123204730.GC4174@sirena.org.uk>
 <Pine.LNX.4.64.1001261341180.4950@axis700.grange>
 <20100126132616.GT15759@rakim.wolfsonmicro.main>
 <Pine.LNX.4.64.1001261440210.4950@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001261440210.4950@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Tue, Jan 26, 2010 at 03:08:44PM +0100, Guennadi Liakhovetski wrote:

> here f_MCLK is what is fed into the codec, f_OPCLK is the master clock, 
> that the codec is generating for the outside world, PLL_mul, MCLK_div, and 
> OPCLK_div are internal coefficients, that have to be configured. So, there 
> are 3 equations with 4 unknowns: f_PLLOUT, PLL_mul, MCLK_div, and 
> OPCLK_div. Since there are additional constraints on all of them, there 
> are usually not too many possible solutions. Still, this system is not 
> uniquely resolvable and you have to use some heuristics to select a 
> specific solution.

Right, the CODEC driver needs something to tell it what frequency to
generate from both the PLL and OPCLK.  Given the PLL configuration it
can work out the CODEC-side bits of things but it has no idea what's
going on with OPCLK or how that is related to the PLL.

> Now, Mark, you are suggesting, that the board code should call

> 	snd_soc_dai_set_pll(dai, 0, 0, f_in, f_out);

> with f_out = f_PLLOUT. This means, the board has to use its own heuristics 
> to configure the codec, which I find a bad idea. Especially since there is 
> not a single simple recipe like "f_PLLOUT = f_OPCLK, OPCLK_div = 1," you 
> really have to vary all those variables to get to a suitable result. Now, 

The CODEC only needs to know OPCLKDIV and the PLL output frequency.  It
doesn't really care that these are related.  There's no way it can know
what the requirements are for OPCLK, when it's safe to vary it or in
what way it's safe to vary it - reconfiguring the PLL requires that the
PLL be stopped, which may be undesirable.  The CODEC driver can't assume
that OPCLK is only needed when the CODEC is handling audio, and 

There's also the fact that set_pll() normally does exactly that - it
configures the PLL.  If you start making it do other magic 

> You remember those superfluous "was-comments," that we have removed. See, 
> the board driver chooses an OPCLK_div, and, thereby, f_PLLOUT. And this is 

I'm not sure how those comments are directly related to this issue?

> exactly what I disliked about that code and was quite happy to remove. If 
> you insist, I will put it back and switch to using f_PLLOUT for 
> .set_pll(), but I emphasise, that I really dislike this approach, and I 
> really believe, that the board really should keep its fingers away from 
> devices' internals - ever. The only thing that the board knows is input 
> clock, required output clock and sampling rate. The rest should be solely 
> a matter of specific device drivers.

The machine driver already needs to know about the clocking scheme for
the system - at the end of the day it's entirely specific to the
combination of CODEC, CPU, whatever other components are there, the
way they've been wired up and anything system level that software has to
be able to achieve.  Solving this sort of problem in a generic fashion
is non-trivial, there's a reason why we don't have an algorithm for it
hidden away in a generic clock API.

If you want to try to do this automatically I'd say that at a bare
minimum you need to remove set_pll() from the driver API and make
configuring OPCLK a bolt on which is not part of the standard flow for
using the device with the PLL.  Use set_sysclk() to specify the input
frequency for the PLL, and use something like the set_clkdiv() API to
specify the OPCLK output rate.

Your previous patches have all treated the PLL output frequency and
OPCLK frequency too interchangibly (or documented themselves as doing
so) - if the normal flow is worrying about what OPCLK is or if the
system clock is being stored as OPCLK something is wrong.
