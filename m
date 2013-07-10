From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 00:35:55 +0000
Subject: Re: [PATCH v3 2/7] ARM: shmobile: ape6evm: add MMCIF support
Message-Id: <20130710003554.GB15011@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373298887-9877-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373298887-9877-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 08, 2013 at 05:54:41PM +0200, Guennadi Liakhovetski wrote:
> Add MMCIF support to the APE6EVM board in both PIO and DMA modes, depending
> on the DMAC driver availability. Power supply is fixed for now, eventually
> support for the tps80032 regulator, also supplying both VDD and VccQ to the
> MMCIF slot should be added to APE6EVM.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Acked-by: Magnus Damm <damm@opensource.se>
> ---
>  arch/arm/mach-shmobile/board-ape6evm.c |   33 ++++++++++++++++++++++++++++++++
>  1 files changed, 33 insertions(+), 0 deletions(-)

Thanks, I have queued this up for v3.12 in the boards branch.
It should appear in renesas-next-20130710
