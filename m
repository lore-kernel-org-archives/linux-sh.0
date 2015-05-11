From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 May 2015 08:44:14 +0000
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: rsnd: make sure it uses lock	when it calls rsnd_dai_call
Message-Id: <87lhgv33mp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761948j4f.wl%kuninori.morimoto.gx@renesas.com>
	<8738488j2k.wl%kuninori.morimoto.gx@renesas.com>
	<alpine.DEB.2.10.1505041134140.4711@ayla.of.borg>
	<87iobz506i.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iobz506i.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, linux-sh@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Simon <horms@verge.net.au>, Atsushi Tamaki <atsushi.tamaki.ks@renesas.com>


Hi Mark, Geert

> > >  static int rsnd_rdai_continuance_probe(struct rsnd_priv *priv,
> > >  				       struct rsnd_dai_stream *io)
> > >  {
> > > +	unsigned long flags;
> > >  	int ret;
> > >  
> > > +	rsnd_lock(priv, flags);
> > > +
> > >  	ret = rsnd_dai_call(probe, io, priv);
> > >  	if (ret = -EAGAIN) {
> > >  		/*
> > 
> > This causes the following warning on r8a7791/koelsch:
> 
> Thank you for pointing this.
> I will check/fixup it.

I checked about this issue.
Indeed these locks are not needed.
# 2 lock have issue when boot,
# 2 lock has issue when unbind/rmmod/probe fail
# 1 lock is not needed

Mark, is it possible to revert this patch ?

e9c390df671fadc829550935ffb6b23549f26ded
(ASoC: rsnd: make sure it uses lock when it calls rsnd_dai_call)

Best regards
---
Kuninori Morimoto
