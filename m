From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Dec 2014 03:23:15 +0000
Subject: Re: [PATCH 11/12 v2] ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
Message-Id: <20141211032312.GG513@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9yl2ie3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87h9yl2ie3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 10, 2014 at 03:51:59AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Thank you for your help
> > > It depends on RCAR-DMAC enable/disable and driver (which want to use DMAEngine).
> > > But, unfortunately, reverting it from v3.19 is very safety. 
> > 
> > Thanks, I think I understand.
> > 
> > I plan to queue-up the following:
> > 
> > From: Simon Horman <horms+renesas@verge.net.au>
> > 
> > [PATCH] Revert "ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig"
> > 
> > This reverts commit 2315f9fce4da7df9362e4baeb5250d14ea48bf63.
> > 
> > Unfortunately enabling RCAR_AUDMAC_PP support this patch breaks dmaengine
> > support on R-Car Gen2 boards. This should be resolved by driver updates
> > in v3.20. But v3.19 was too early for this defconfig change.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> 
> Thank you.
> I will re-send this patch if all are OK

Thanks, please do.

I have sent a pull-request for the reversion above.
