From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 22 Aug 2014 04:32:35 +0000
Subject: Re: [PATCH] dma: rcar-audmapp: Fix for no corresponding slave ID
Message-Id: <87egw96t5t.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2buk6j7.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2buk6j7.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> > 
> > In case of no corresponding slave ID, the audmapp_set_slave() returns
> > -ENXIO same as sh_dmae_set_slave() of shdmac.c.
> > DMAEngine might return wrong channel without this patch
> 
> Hi Morimoto-san,
> 
> could you please make a note of which commit introduced this problem
> and if is known to manifest at this time?

This issue happens under non-DT style,
and, upstream code doesn't have it.
So, this patch solved hidden bug for upstream.

Best regards
---
Kuninori Morimoto
