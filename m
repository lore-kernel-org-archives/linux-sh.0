From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:49:33 +0000
Subject: Re: [PATCH 16/27 v2] ARM: shmobile: r8a7740: add DMAEngine support for USB
Message-Id: <20120613004931.GR16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k3zcx42h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3zcx42h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:38:50AM -0700, Kuninori Morimoto wrote:
> Current shdmac can support USB DMAC on r8a7740.
> This support reduce CPU duty when USB access.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change, but based on dma_usbts_shift
> 
>  arch/arm/mach-shmobile/clock-r8a7740.c        |    4 +-
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 +
>  arch/arm/mach-shmobile/setup-r8a7740.c        |   71 +++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 1 deletions(-)
> 
