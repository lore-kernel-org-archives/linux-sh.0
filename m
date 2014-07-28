From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 28 Jul 2014 07:40:40 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: rsnd: Protect register accesses with a	spinlock instead of a mutex
Message-Id: <87vbqi7wy1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<87y4vja9xq.wl%kuninori.morimoto.gx@renesas.com>
	<87tx67a4cf.wl%kuninori.morimoto.gx@gmail.com>
	<53D5E6C2.3060607@metafoo.de>
In-Reply-To: <53D5E6C2.3060607@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


Hi Lars
# added Mark

> > Hmm... rsnd driver is using "regmap_field".
> > regmap-mmio  requests "offset"  on "reg"
> > regmap-filed requests "address" on "reg"
> >
> > So, if rsnd driver uses regmap-mmio,
> > then, it needs tricky initialize like...
> >
> >        regmap_init_mmio(dev, 0, config)
> >
> 
> Create one regmap instance per base address and in the regmap_fields use an 
> relative offset to the base address rather than the absolute address. That's 
> how the API is intended to be used, the current implementation is quite a hack.

Hmm...
But it (= base address mapping was not fixed between Gen1 and Gen2)
was the reason why I was asked to use regmap_fields

