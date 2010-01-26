From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jan 2010 13:04:45 +0000
Subject: Re: [alsa-devel] [PATCH 1/4 v2] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001261341180.4950@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
 <Pine.LNX.4.64.1001221659410.4652@axis700.grange> <20100123204730.GC4174@sirena.org.uk>
In-Reply-To: <20100123204730.GC4174@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org

On Sat, 23 Jan 2010, Mark Brown wrote:

> On Fri, Jan 22, 2010 at 05:27:53PM +0100, Guennadi Liakhovetski wrote:

[snip]

> > +	if (freq_in = 0 || freq_out = 0) {
> > +		/* Clock CODEC directly from MCLK */
> > +		reg = snd_soc_read(codec, WM8978_CLOCKING);
> > +		snd_soc_write(codec, WM8978_CLOCKING, reg & ~0x100);
> > +
> > +		/* Turn off PLL */
> > +		reg = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1);
> > +		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, reg & ~0x20);
> > +		return 0;
> > +	}
> 
> Note that ideally the PLL updates will handle the case where the PLL is
> already on and power down the PLL while reconfiguring it, though it's
> not essential.
> 
> > +	opclk_div = ((snd_soc_read(codec, WM8978_GPIO_CONTROL) & 0x30) >> 4) + 1;
> 
> > +	wm8978->f_pllout = freq_out * opclk_div;
> 
> Hrm.  I fear that there's a bit of confusion here - the PLL output is
> used separately as the source for both OPCLK and the system clock for
> the CODEC.  This means that the PLL output frequency that we need to
> refer to later on is that before the OPCLK divide.
> 
> Looking further down the driver f_pllout is also being used as the
> system master clock frequency, meaning that the driver will only work
> when the PLL is in use.  Normally what would happen with this stuff is
> that the system clock used by hw_params() will be set using the
> set_sysclk() API call, which can tell the driver what the clock rate is
> and also select between multiple clock sources.  You'd end up saying
> something like:
> 
> 	snd_soc_dai_set_pll(dai, 0, 0, 12000000, 256 * params_rate(params));
> 	snd_soc_dai_set_sysclk(dai, WM8978_PLL, 256 * params_rate(params), 0);
> 
> in the machine driver (note that this also means that the switchover to
> use of the PLL as the clock would then be managed via set_sysclk() not
> set_pll()).

Ok, my new concept is the following:

1. wm8978 needs an input clock for its operation, and it needs to know its 
   frequency. The only way to supply this information to the driver is to 
   use

	snd_soc_dai_set_pll(dai, 0, 0, f_in, f_out);

   where if f_in = 0, input clock is off and the driver has nothing 
   better to do but to switch its own clocking off too. f_out is the 
   frequency, that the user (board) is asking wm8978 to provide on its 
   OPCLK (GPIO1) output. If f_out = 0, this means, the board does not 
   need that output _and_ it is asking the codec to switch PLL off. 
   Otherwise PLL is immediately configured and switched on.

2. having configured codec's PLL the board can select, which clock the 
   codec shall be using as a source for its system clock - PLL or codec 
   input clock directly. The board uses

	snd_soc_dai_set_sysclk(dai, WM8978_PLL, f_sysclk, 0);

   or

	snd_soc_dai_set_sysclk(dai, WM8978_MCLK, f_sysclk, 0);

   for this. Notice, that f_sysclk is ignored, because in wm8978 it is 
   fixed at 256 * fs, and therefore it has to be configured in 
   .hw_params().

3. in .hw_params() we configure the MCLK divider, based on the system 
   clock frequency and baudrate, and set up the selected clock source.

This allows for the most flexible clock configuration, one can even 
configure to use PLL for output clock and input clock directly for the 
system clock, even if such a configuration doesn't make much sense.

I'll be submitting an updated patch shortly, please, let me know if there 
are any problems with this concept.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
