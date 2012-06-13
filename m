From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Jun 2012 00:51:43 +0000
Subject: Re: [PATCH 24/27 v2] ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
Message-Id: <20120613005141.GW16686@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878vfsx3ux.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vfsx3ux.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 02:43:22AM -0700, Kuninori Morimoto wrote:
> Current shdmac can support MPDMAC (= sound DMA) on sh73a0.
> This support reduce CPU load when sound was playback.
> 
> On v2.0 manual, MPDMAC MID/RID number were wrong.
> This patch is using the number which seems correct.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As I tested v1 of this patch:

Tested-by: Simon Horman <horms@verge.net.au>

> ---
> v1 -> v2
> 
>  - no change, but based on dma_ts_shift
> 
>  arch/arm/mach-shmobile/clock-sh73a0.c        |    4 +-
>  arch/arm/mach-shmobile/include/mach/sh73a0.h |    7 ++
>  arch/arm/mach-shmobile/setup-sh73a0.c        |  111 ++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 1 deletions(-)
