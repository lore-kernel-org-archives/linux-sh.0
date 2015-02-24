From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Feb 2015 00:40:01 +0000
Subject: Re: [PATCH 01/24 v2] dmaengine: export symbol of of_dma_request_slave_channel()
Message-Id: <87egpg16q4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
	<87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdUqJEONj-To7YhLhTqT+1vYnNL6ah8na6+W9VwcVOgwFQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUqJEONj-To7YhLhTqT+1vYnNL6ah8na6+W9VwcVOgwFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org


Hi Geert, Vinod

> > --- a/include/linux/of_dma.h
> > +++ b/include/linux/of_dma.h
> > @@ -37,8 +37,8 @@ extern int of_dma_controller_register(struct device_node *np,
> >                 (struct of_phandle_args *, struct of_dma *),
> >                 void *data);
> >  extern void of_dma_controller_free(struct device_node *np);
> > -extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> > -                                                    const char *name);
> > +struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> > +                                             const char *name);
> 
> Why have you dropped the "extern" keyword? Checkpach?
> All prototypes in the neighborhood have "extern" keywords, so I think it's
> better to keep it for consistency.

OK, I can fix it.
But, this is very large patchset (24 patches !).
I don't want to send all patches if possible.
I will send only [01/24 v3] now.
Please let me know if it is not OK.

Best regards
---
Kuninori Morimoto
