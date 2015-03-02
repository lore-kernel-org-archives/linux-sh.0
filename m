From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Mar 2015 00:03:04 +0000
Subject: Re: [PATCH 7/9 v4] ASoC: rsnd: remove slave_id settings for DMAEngine
Message-Id: <877fv0b6yd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > Current rsnd sets dma_slave_config :: slave_id field for DMAEngine,
> > but it is no longer needed. Let's remove it.
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v3 -> v4
> >
> >  - no change
> 
> i noticed this patch was dropped in v5, and thus not applied by Vinod?
> Did I miss a discussion about that?
> 
> https://patchwork.kernel.org/patch/5732671/

Thank you for pointing it, and sorry I didn't explain about this patch.
Yes, I dropped this patch, because, Renesas sound card can't use
Audio DMA peri peri via DMAEngine anymore.
Sound card is now customized not to use DMAEngine.
Above change (= remove slave_id from sound driver) is done in sound driver
side customize patch-set.
Otherwise, we will have conflict between DMAEngine <-> Sound branch

Best regards
---
Kuninori Morimoto
