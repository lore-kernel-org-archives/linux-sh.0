From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 13:04:49 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add USB Func DMAEngine support
Message-Id: <20131212130447.GD30624@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txegnrbf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txegnrbf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 10, 2013 at 07:10:44PM -0800, Kuninori Morimoto wrote:
> Hi Simon
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > HPB-DMAC has 2 channel for USB Func (= D0/D1)
> > > D0 is used as Tx, D1 is used as Rx on this patch
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > > Simon
> > > 
> > > BockW board will use this patch, but it needs
> > > HPB-DMAC fixup patches merge.
> > > I will send it when merged, but this patch
> > > itself doesn't depend on HPB-DMAC fixup branch.
> > 
> > Ok, so I can queue-up this patch now?
> 
> Yes, please

Done
