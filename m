From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 01:08:42 +0000
Subject: Re: [PATCH 7/8 v2] ASoC: fsi: remove slave_id settings for DMAEngine
Message-Id: <87bnlrmxim.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bnluaxtt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnluaxtt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd

> > Thank you for pointing it.
> > But, unfortunately, this FSI driver is not used from DT.
> > (It is supporting DT probe, but no one use it)
> > So, it is assuming that dst_addr/src_addr fields are come
> > from platform data.
> 
> I see. My patch would still be correct, right?
> 
> I think the way that Guennadi Liakhovetski started the conversion of
> shmobile dmaengine drivers, each slave driver either uses a custom
> filter function that relies on the platform data and will not work
> with DT, or it uses dma_request_slave_channel_compat() which will
> work on both, and then uses dmaengine_slave_config() to pass the
> extra settings. This driver is the one exception you have since it
> uses a combination of the two approaches.

I understand.
will fix in v3 patch

Best regards
---
Kuninori Morimoto
