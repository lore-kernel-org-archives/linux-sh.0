From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Jul 2013 00:37:02 +0000
Subject: Re: [PATCH v3 3/7] ARM: shmobile: ape6evm: add SDHI interfaces
Message-Id: <20130710003702.GC15011@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373298887-9877-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373298887-9877-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 08, 2013 at 05:54:42PM +0200, Guennadi Liakhovetski wrote:
> Add support for SDHI0 and SDHI1 on APE6EVM in PIO mode only.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-ape6evm.c |   50 +++++++++++++++++++++++++++++++-
>  1 files changed, 49 insertions(+), 1 deletions(-)

Thanks, I have queued this up for v3.12 in the boards branch.
It should appear in renesas-next-20130710
