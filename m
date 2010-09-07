From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 07 Sep 2010 09:40:48 +0000
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Message-Id: <20100907094047.GA7886@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
	<w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1009060932430.20387@axis700.grange>
	<20100906102557.GE10367@rakim.wolfsonmicro.main>
	<Pine.LNX.4.64.1009070910370.1345@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009070910370.1345@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>

On Tue, Sep 07, 2010 at 09:11:28AM +0200, Guennadi Liakhovetski wrote:
> On Mon, 6 Sep 2010, Mark Brown wrote:

> > > > +static int sh_hdmi_snd_write(struct snd_soc_codec *codec,

> > > Are these two actually needed? As long as you don't have a register cache 
> > > - no need for these?

> > Something needs to translate the ASoC register I/O functions into what
> > the HDMI layer code is expecting.

> AFAICS, with ->reg_cache_size = 0 the ASoC core will not attempt to call 
> them.

Could you please be more explicit here?  Register I/O needs to happen
somehow...
