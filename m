From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 01:28:26 +0000
Subject: Re: [PATCH 8/8 v2] ASoC: rsnd: remove slave_id settings for DMAEngine
Message-Id: <87iog0or9q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a91eaxtc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a91eaxtc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> > Current sh-msiof sets dma_slave_config :: slave_id field for DMAEngine,
> 
>     sh-msiof? But this is ALSA patch! :-)
> 
> > but it is no longer needed. Let's remove it.

Grr... Thank you for pointing it.
will fix in v3 patch

Best regards
---
Kuninori Morimoto
