From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:52:06 +0000
Subject: Re: [PATCH 25/27 v2] ARM: shmobile: sh73a0: add FSI clock
Message-Id: <20120613005204.GX16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <877gvcx3uf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gvcx3uf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:43:40AM -0700, Kuninori Morimoto wrote:
> This patch is required from FSI sound driver
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
