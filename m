From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 May 2012 07:35:47 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: sh73a0: bugfix: SY-DMAC number
Message-Id: <87ipfe2ka8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lika2ob7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lika2ob7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for checking patch

> > 681e1b3eeb3606e06a7c4984e8058df84296f8bb
> > (ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC)
> > added SY-DMAC, but the number is 218, not 318
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> With these sorts of changes it is good to note the revision of the data
> sheet used in the changelog so we don't run in to ping-ponging issues
> where it's not obvious which is newest or most correct.

I see.
But it needs double-check by Magnus/Guennadi.
If it got acked-by/tested-by from them,
I will send v2 patch which includes datasheet version and their acked-by/tested-by.

Best regards
---
Kuninori Morimoto
