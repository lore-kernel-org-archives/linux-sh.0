From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Dec 2013 00:48:08 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add SSIx DMAEngine support
Message-Id: <20131211004805.GD19992@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 10, 2013 at 04:35:30PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > >> Simon
> > > 
> > > I will send SSI DMAEngine support patch for BockW board,
> > > but it needs HPB-DMAC fixup branch merge.
> > > It is already exist on
> > > 
> > > git://git.infradead.org/users/vkoul/slave-dma.git :: dma/fixes
> > > 
> > > But, is not merged on linus/master yet.
> > 
> > Thanks. Please let me know if/when it is merged.
> 
> Thank you, will do.
> But, this patch itself doesn't depend on HPB-DMAC fixup branch.
> Sorry for my confusable English.

Sorry for my confusion.

To clarify: I can now queue-up this patch?

> # BockW board support side only depends on HPB-DMAC fixup
> # I will send it when these are merged to linus branch
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
