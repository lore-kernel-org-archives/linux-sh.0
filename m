From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 22 Jan 2010 10:35:04 +0000
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: add a WM8978 codec driver
Message-Id: <20100122103504.GC10997@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
	<Pine.LNX.4.64.1001190851380.4607@axis700.grange>
	<20100119105729.GA32559@opensource.wolfsonmicro.com::587>
	<Pine.LNX.4.64.1001191445520.4607@axis700.grange>
	<20100120201726.GD7725@sirena.org.uk>
	<Pine.LNX.4.64.1001220934230.4652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001220934230.4652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Jan 22, 2010 at 09:35:44AM +0100, Guennadi Liakhovetski wrote:
> On Wed, 20 Jan 2010, Mark Brown wrote:

> > That seems wrong - if they're being managed in the bias level
> > configuration they ought to be being turned off at some point.  If they
> > should be set all the time then set them during chip init.

> Right, a couple of lines below:

> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);

Yeah, I saw that.  This is one of those cases where numeric bitmask
based updates make things much harder to follow - without referring to
the datasheet and thinking about it it's not clear what's going on and
if it's intentional.

I'd suggest changing all this code to use snd_soc_update_bits() and
symbolic names for the bits that are getting twiddled - it really is a
lot easier to follow.
