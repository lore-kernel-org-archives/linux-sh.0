From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 06:38:28 +0000
Subject: Re: [PATCH v3 2/7] ARM: shmobile: ape6evm: add MMCIF support
Message-Id: <20130710063827.GA18130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373298887-9877-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373298887-9877-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 10, 2013 at 12:43:01PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jul 10, 2013 at 11:50 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jul 10, 2013 at 09:35:55AM +0900, Simon Horman wrote:
> >> On Mon, Jul 08, 2013 at 05:54:41PM +0200, Guennadi Liakhovetski wrote:
> >> > Add MMCIF support to the APE6EVM board in both PIO and DMA modes, depending
> >> > on the DMAC driver availability. Power supply is fixed for now, eventually
> >> > support for the tps80032 regulator, also supplying both VDD and VccQ to the
> >> > MMCIF slot should be added to APE6EVM.
> >> >
> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >> > Acked-by: Magnus Damm <damm@opensource.se>
> >> > ---
> >> >  arch/arm/mach-shmobile/board-ape6evm.c |   33 ++++++++++++++++++++++++++++++++
> >> >  1 files changed, 33 insertions(+), 0 deletions(-)
> >>
> >> Thanks, I have queued this up for v3.12 in the boards branch.
> >> It should appear in renesas-next-20130710
> >
> > I have dropped this patch as it depends on SHDMA_SLAVE_MMCIF0_TX
> > and SHDMA_SLAVE_MMCIF0_RX. Will they be available in v3.11-rc1?
> 
> I think the SDMA bits should be provided in patch 1/7 of this series,
> but I believe you pointed out some dependency issue for that file.

Thanks, that makes sense.

> Which makes me wonder, wouldn't it make more sense to submit this
> patch without DMA Engine support to begin with? Then patch 1/7 can be
> dealt with later.

That also makes sense to me.

> Actually, I have a hard time understanding why the DMA dependency is
> there in the first place, but never mind...
> 
> / magnus
> 
