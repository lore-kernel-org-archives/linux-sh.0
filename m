From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 20 Jan 2010 20:17:26 +0000
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: add a WM8978 codec driver
Message-Id: <20100120201726.GD7725@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	<20100119105729.GA32559@opensource.wolfsonmicro.com::587>
	<Pine.LNX.4.64.1001191445520.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001191445520.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>

On Wed, Jan 20, 2010 at 08:50:59PM +0100, Guennadi Liakhovetski wrote:
> On Tue, 19 Jan 2010, Mark Brown wrote:

> > What do these comments refer to - do you mean to say that these are not
> > the actual chip register defaults?  The normal way to deal with those is

> No, I meant, that there's a "Value Update" bit in that register, usually 
> bit 8. So, that bit, of course, is not in default, but it was suggested to 
> me on IRC to set it in cache to force automatic value update.

Right, but it's better to set it in the cache by writing after the fact
rather than by changing the register defaults.  Like I say, that can
easily confuse things since sometimes people want to know the actual
default values.

> 
> > > +#define ARRAY_SINGLE(xreg, xshift, xtexts) SOC_ENUM_SINGLE(xreg, xshift, \
> > > +						ARRAY_SIZE(xtexts), xtexts)
> > 
> > This looks generic - please namespace it and add it to the header file,
> > other drivers can benefit from it.
> 
> SOC_ARRAY_SINGLE()?

How about SOC_ENUM_ARRAY() since it's really only useful for arrays?

> > > +#define MIXER_ARRAY(n, r, s, i, m) SND_SOC_DAPM_MIXER(n, r, s, i, \
> > > +							m, ARRAY_SIZE(m))

> > Again, this should be done somewhere generic.  Probably by going through
> > and changing the SND_SOC_DAPM_MIXER definition.

> Well, having discussed this privately and having looked at the heades, I'm 
> not sure, this is a good idea. First, there are

> SND_SOC_DAPM_PGA()
> SND_SOC_DAPM_MIXER()
> SND_SOC_DAPM_MIXER_NAMED_CTL()
> SND_SOC_DAPM_PGA_E()
> SND_SOC_DAPM_MIXER_E()
> SND_SOC_DAPM_MIXER_NAMED_CTL_E()

> - 6 macros that follow the pattern

> .kcontrols = wcontrols, .num_kcontrols = wncontrols,

That doesn't mean it's a good idea, though for PGAs note that the normal
case is that the array is omitted (and actually, thinking about this we
need an array omitted case for everything anyway).

> Changing only one of them would make the headers and the API look 
> inconsistent. Changing all of them... I really don't think we want to 
> endeavor this now, at least not me;) Besides, doing this locally is very 
> convenient, and is available to everyone - there's no space science 
> involved with this. One can be even as evil as doing

For maintainability of the subsystem it's really nice if a driver doing
bog standard things looks like it's doing bog standard things - neat
local tricks break the pattern recognition that helps a lot when looking
at multiple drivers.

> > > +	u16 power1 = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1) & ~3;
> > 
> > This bitmask maintains everything except the two LSB...
> > 
> > > +	switch (level) {
> > > +	case SND_SOC_BIAS_ON:
> > > +	case SND_SOC_BIAS_PREPARE:
> > > +		power1 |= 1;  /* VMID 75k */
> > > +		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, power1);
> > > +		break;
> > > +	case SND_SOC_BIAS_STANDBY:
> > > +		power1 |= 0xC;
> > 
> > ...but this is also managing other bits.

> Right, bits 7-6 are either kept or set, nothing wrong with that.

That seems wrong - if they're being managed in the bias level
configuration they ought to be being turned off at some point.  If they
should be set all the time then set them during chip init.
