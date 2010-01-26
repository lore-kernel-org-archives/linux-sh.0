From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jan 2010 14:08:44 +0000
Subject: Re: [alsa-devel] [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001261440210.4950@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	<Pine.LNX.4.64.1001221659410.4652@axis700.grange>
	<20100123204730.GC4174@sirena.org.uk>
	<Pine.LNX.4.64.1001261341180.4950@axis700.grange>
	<20100126132616.GT15759@rakim.wolfsonmicro.main>
In-Reply-To: <20100126132616.GT15759@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, 26 Jan 2010, Mark Brown wrote:

> On Tue, Jan 26, 2010 at 02:04:45PM +0100, Guennadi Liakhovetski wrote:
> 
> This is mostly good, there's a few relatively small changes needed but
> the broad concept is fine:
> 
> > 1. wm8978 needs an input clock for its operation, and it needs to know its 
> >    frequency. The only way to supply this information to the driver is to 
> >    use
> > 
> > 	snd_soc_dai_set_pll(dai, 0, 0, f_in, f_out);
> > 
> >    where if f_in = 0, input clock is off and the driver has nothing 
> >    better to do but to switch its own clocking off too. f_out is the 
> >    frequency, that the user (board) is asking wm8978 to provide on its 
> >    OPCLK (GPIO1) output. If f_out = 0, this means, the board does not 
> >    need that output _and_ it is asking the codec to switch PLL off. 
> >    Otherwise PLL is immediately configured and switched on.
> 
> The PLL is not tied in with OPCLK.  set_pll() should pay no attention to
> OPCLK, it should just start the PLL when given a configuration and stop
> the PLL when given no input/output frequency.
> 
> Remember, OPCLK may not be being used at all and there are separate
> dividers from the PLL output for it and the main SYSCLK in the CODEC.
> 
> > 2. having configured codec's PLL the board can select, which clock the 
> >    codec shall be using as a source for its system clock - PLL or codec 
> >    input clock directly. The board uses
> 
> > 	snd_soc_dai_set_sysclk(dai, WM8978_PLL, f_sysclk, 0);
> 
> >    or
> > 
> > 	snd_soc_dai_set_sysclk(dai, WM8978_MCLK, f_sysclk, 0);
> 
> This is mostly OK but...
> 
> >    for this. Notice, that f_sysclk is ignored, because in wm8978 it is 
> >    fixed at 256 * fs, and therefore it has to be configured in 
> >    .hw_params().
> 
> If the MCLK is being used as SYSCLK then the frequency should be used -
> if it's recorded then the driver can automatically configure MCLKDIV to
> generate the 256fs by itself (see below).  It could also generate
> constraints for ALSA to let applications know what frequencies are
> supported, though that's less urgent.
> 
> The clock rate passed in needn't be the actual system clock, it's more
> useful if it's the rate of the clock that is used to generate that,
> which is what the outside world can see.
> 
> > 3. in .hw_params() we configure the MCLK divider, based on the system 
> >    clock frequency and baudrate, and set up the selected clock source.
> 
> > This allows for the most flexible clock configuration, one can even 
> > configure to use PLL for output clock and input clock directly for the 
> > system clock, even if such a configuration doesn't make much sense.
> 
> This is why you need the input clock frequency when the MCLK is being
> used directly - you can't configure the divider without knowing what
> MCLK is.

Ok, here's how wm8978 clocking works, when PLL is used to generate the 
system clock:

            ___________                ____________
 f_MCLK    !           !  f_PLLOUT    !            ! f_sys = 256fs
---------->! x PLL_mul !------+------>! / MCLK_div !--------------->
           !___________!      !       !____________!
                              !
                              !
            _____________     !
 f_OPCLK   !             !    !
<----------! / OPCLK_div !----+
           !_____________!


f_PLLOUT = f_MCLK * PLL_mul

f_sys = 256fs = f_PLLOUT / MCLK_div

f_OPCLK = f_PLLOUT / OPCLK_div

here f_MCLK is what is fed into the codec, f_OPCLK is the master clock, 
that the codec is generating for the outside world, PLL_mul, MCLK_div, and 
OPCLK_div are internal coefficients, that have to be configured. So, there 
are 3 equations with 4 unknowns: f_PLLOUT, PLL_mul, MCLK_div, and 
OPCLK_div. Since there are additional constraints on all of them, there 
are usually not too many possible solutions. Still, this system is not 
uniquely resolvable and you have to use some heuristics to select a 
specific solution.

Now, Mark, you are suggesting, that the board code should call

	snd_soc_dai_set_pll(dai, 0, 0, f_in, f_out);

with f_out = f_PLLOUT. This means, the board has to use its own heuristics 
to configure the codec, which I find a bad idea. Especially since there is 
not a single simple recipe like "f_PLLOUT = f_OPCLK, OPCLK_div = 1," you 
really have to vary all those variables to get to a suitable result. Now, 
I can do this. This was actually done in the original code:

	switch (rate) {
	case 48000:
		mclk_div = 0x40;
		opclk_div = 0;
		/* f2 = 98304000, was 98304050 */
		break;
	case 44100:
		mclk_div = 0x40;
		opclk_div = 0;
		/* f2 = 90316800, was 90317500 */
		break;
	case 32000:
		mclk_div = 0x80;
		opclk_div = 0x010;
		/* f2 = 131072000, was 131072500 */
		break;
	case 24000:
		mclk_div = 0x80;
		opclk_div = 0x010;
		/* f2 = 98304000, was 98304700 */
		break;
	case 22050:
		mclk_div = 0x80;
		opclk_div = 0x010;
		/* f2 = 90316800, was 90317500 */
		break;
	case 16000:
		mclk_div = 0xa0;
		opclk_div = 0x020;
		/* f2 = 98304000, was 98304700 */
		break;
	case 11025:
		mclk_div = 0x80;
		opclk_div = 0x010;
		/* f2 = 45158400, was 45158752 */
		break;
	default:
	case 8000:
		mclk_div = 0xa0;
		opclk_div = 0x020;
		/* f2 = 49152000, was 49152350 */
		break;
	}

You remember those superfluous "was-comments," that we have removed. See, 
the board driver chooses an OPCLK_div, and, thereby, f_PLLOUT. And this is 
exactly what I disliked about that code and was quite happy to remove. If 
you insist, I will put it back and switch to using f_PLLOUT for 
.set_pll(), but I emphasise, that I really dislike this approach, and I 
really believe, that the board really should keep its fingers away from 
devices' internals - ever. The only thing that the board knows is input 
clock, required output clock and sampling rate. The rest should be solely 
a matter of specific device drivers.

Now, please, let's make a decision and I'll just obey.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
