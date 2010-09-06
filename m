From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 06 Sep 2010 10:25:58 +0000
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Message-Id: <20100906102557.GE10367@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
 <w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
 <Pine.LNX.4.64.1009060932430.20387@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009060932430.20387@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>

On Mon, Sep 06, 2010 at 10:27:56AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 31 Aug 2010, Kuninori Morimoto wrote:

> > +static int sh_hdmi_snd_write(struct snd_soc_codec *codec,
> > +			     unsigned int reg,
> > +			     unsigned int value)
> > +{
> > +	struct sh_hdmi *hdmi = snd_soc_codec_get_drvdata(codec);
> > +
> > +	hdmi_write(hdmi, value, reg);
> > +	return 0;
> > +}

> Are these two actually needed? As long as you don't have a register cache 
> - no need for these?

Something needs to translate the ASoC register I/O functions into what
the HDMI layer code is expecting.
