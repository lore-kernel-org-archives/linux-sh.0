From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Jan 2010 08:35:44 +0000
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: add a WM8978 codec driver
Message-Id: <Pine.LNX.4.64.1001220934230.4652@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190851380.4607@axis700.grange>
 <20100119105729.GA32559@opensource.wolfsonmicro.com::587>
 <Pine.LNX.4.64.1001191445520.4607@axis700.grange> <20100120201726.GD7725@sirena.org.uk>
In-Reply-To: <20100120201726.GD7725@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Magnus Damm <damm@opensource.se>, linux-sh@vger.kernel.org

On Wed, 20 Jan 2010, Mark Brown wrote:

> On Wed, Jan 20, 2010 at 08:50:59PM +0100, Guennadi Liakhovetski wrote:
> > On Tue, 19 Jan 2010, Mark Brown wrote:

[snip]

> > > > +	u16 power1 = snd_soc_read(codec, WM8978_POWER_MANAGEMENT_1) & ~3;
> > > 
> > > This bitmask maintains everything except the two LSB...
> > > 
> > > > +	switch (level) {
> > > > +	case SND_SOC_BIAS_ON:
> > > > +	case SND_SOC_BIAS_PREPARE:
> > > > +		power1 |= 1;  /* VMID 75k */
> > > > +		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, power1);
> > > > +		break;
> > > > +	case SND_SOC_BIAS_STANDBY:
> > > > +		power1 |= 0xC;
> > > 
> > > ...but this is also managing other bits.
> 
> > Right, bits 7-6 are either kept or set, nothing wrong with that.
> 
> That seems wrong - if they're being managed in the bias level
> configuration they ought to be being turned off at some point.  If they
> should be set all the time then set them during chip init.

Right, a couple of lines below:

+	case SND_SOC_BIAS_OFF:
+		snd_soc_write(codec, WM8978_POWER_MANAGEMENT_1, 0);

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
