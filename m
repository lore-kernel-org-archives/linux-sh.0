From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 11 Dec 2013 00:35:30 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add SSIx DMAEngine support
Message-Id: <87vbywns1c.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > >> Simon
> > 
> > I will send SSI DMAEngine support patch for BockW board,
> > but it needs HPB-DMAC fixup branch merge.
> > It is already exist on
> > 
> > git://git.infradead.org/users/vkoul/slave-dma.git :: dma/fixes
> > 
> > But, is not merged on linus/master yet.
> 
> Thanks. Please let me know if/when it is merged.

Thank you, will do.
But, this patch itself doesn't depend on HPB-DMAC fixup branch.
Sorry for my confusable English.

# BockW board support side only depends on HPB-DMAC fixup
# I will send it when these are merged to linus branch

