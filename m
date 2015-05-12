From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 May 2015 00:09:18 +0000
Subject: Re: [alsa-devel] [PATCH 2/5] ASoC: rsnd: make sure it uses lock when it calls rsnd_dai_call
Message-Id: <87617yd5f8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761948j4f.wl%kuninori.morimoto.gx@renesas.com>
	<8738488j2k.wl%kuninori.morimoto.gx@renesas.com>
	<alpine.DEB.2.10.1505041134140.4711@ayla.of.borg>
	<87iobz506i.wl%kuninori.morimoto.gx@renesas.com>
	<87lhgv33mp.wl%kuninori.morimoto.gx@renesas.com>
	<20150511145743.GD3458@sirena.org.uk>
In-Reply-To: <20150511145743.GD3458@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, linux-sh@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Simon <horms@verge.net.au>, Atsushi Tamaki <atsushi.tamaki.ks@renesas.com>


Hi Mark

> > Mark, is it possible to revert this patch ?
> 
> > e9c390df671fadc829550935ffb6b23549f26ded
> > (ASoC: rsnd: make sure it uses lock when it calls rsnd_dai_call)
> 
> Sure, please send a patch for that with a changelog explaining why the
> revert is being done.

OK, I will send it.


