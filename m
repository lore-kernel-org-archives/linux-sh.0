From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Dec 2013 05:36:58 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: armadillo: Fix coherent DMA mask
Message-Id: <20131226053658.GB11739@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387217769-22751-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387217769-22751-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 24, 2013 at 11:26:11PM +0900, Simon Horman wrote:
> On Tue, Dec 24, 2013 at 01:10:33PM +0100, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Thursday 19 December 2013 15:31:20 Simon Horman wrote:
> > > On Mon, Dec 16, 2013 at 03:53:57PM -0800, Kuninori Morimoto wrote:
> > > > Hi
> > > > 
> > > > > Commit 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 ("ARM: DMA-API: better
> > > > > handing of DMA masks for coherent allocations") added an additional
> > > > > check to the coherent DMA mask that results in an error when the mask is
> > > > > larger than what dma_addr_t can address.
> > > > > 
> > > > > Set the LCDC coherent DMA mask to DMA_BIT_MASK(32) instead of ~0 to fix
> > > > > the problem.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > ---
> > > > 
> > > > For all patches
> > > > 
> > > > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Thanks, I have queued these up as fixes for v3.13.
> > 
> > Thank you. Could you please tell me in which branch I can find them ?
> 
> I seem to have missed them somehow.
> I'll fix this up.

I have queued them up in the fixes-for-v3.13 branch and
I intend to push them later this afternoon.
