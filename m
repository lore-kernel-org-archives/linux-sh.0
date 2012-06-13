From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:51:22 +0000
Subject: Re: [PATCH 23/27 v2] ARM: shmobile: armadillo800eva: enable DMAEngine on USB
Message-Id: <20120613005121.GV16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa08x3x8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa08x3x8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:41:59AM -0700, Kuninori Morimoto wrote:
> It is possible to reduce CPU load if USB used DMAEngine.
> This patch enabled it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
