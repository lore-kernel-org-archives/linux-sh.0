From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 26 Jan 2010 13:26:16 +0000
Subject: Re: [alsa-devel] [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <20100126132616.GT15759@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	<Pine.LNX.4.64.1001221659410.4652@axis700.grange>
	<20100123204730.GC4174@sirena.org.uk>
	<Pine.LNX.4.64.1001261341180.4950@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001261341180.4950@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>

On Tue, Jan 26, 2010 at 02:04:45PM +0100, Guennadi Liakhovetski wrote:

This is mostly good, there's a few relatively small changes needed but
the broad concept is fine:

> 1. wm8978 needs an input clock for its operation, and it needs to know its 
>    frequency. The only way to supply this information to the driver is to 
>    use
> 
> 	snd_soc_dai_set_pll(dai, 0, 0, f_in, f_out);
> 
>    where if f_in = 0, input clock is off and the driver has nothing 
>    better to do but to switch its own clocking off too. f_out is the 
>    frequency, that the user (board) is asking wm8978 to provide on its 
>    OPCLK (GPIO1) output. If f_out = 0, this means, the board does not 
>    need that output _and_ it is asking the codec to switch PLL off. 
>    Otherwise PLL is immediately configured and switched on.

The PLL is not tied in with OPCLK.  set_pll() should pay no attention to
OPCLK, it should just start the PLL when given a configuration and stop
the PLL when given no input/output frequency.

Remember, OPCLK may not be being used at all and there are separate
dividers from the PLL output for it and the main SYSCLK in the CODEC.

> 2. having configured codec's PLL the board can select, which clock the 
>    codec shall be using as a source for its system clock - PLL or codec 
>    input clock directly. The board uses

> 	snd_soc_dai_set_sysclk(dai, WM8978_PLL, f_sysclk, 0);

>    or
> 
> 	snd_soc_dai_set_sysclk(dai, WM8978_MCLK, f_sysclk, 0);

This is mostly OK but...

>    for this. Notice, that f_sysclk is ignored, because in wm8978 it is 
>    fixed at 256 * fs, and therefore it has to be configured in 
>    .hw_params().

If the MCLK is being used as SYSCLK then the frequency should be used -
if it's recorded then the driver can automatically configure MCLKDIV to
generate the 256fs by itself (see below).  It could also generate
constraints for ALSA to let applications know what frequencies are
supported, though that's less urgent.

The clock rate passed in needn't be the actual system clock, it's more
useful if it's the rate of the clock that is used to generate that,
which is what the outside world can see.

> 3. in .hw_params() we configure the MCLK divider, based on the system 
>    clock frequency and baudrate, and set up the selected clock source.

> This allows for the most flexible clock configuration, one can even 
> configure to use PLL for output clock and input clock directly for the 
> system clock, even if such a configuration doesn't make much sense.

This is why you need the input clock frequency when the MCLK is being
used directly - you can't configure the divider without knowing what
MCLK is.
