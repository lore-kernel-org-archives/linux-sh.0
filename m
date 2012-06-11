From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 07:58:35 +0000
Subject: Re: [PATCH 24/27] ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
Message-Id: <20120611075833.GC30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87oboqpki4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oboqpki4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:58:47PM -0700, Kuninori Morimoto wrote:
> Current shdmac can support MPDMAC (= sound DMA) on sh73a0.
> This support reduce CPU load when sound was playback.
> 
> On v2.0 manual, MPDMAC MID/RID number were wrong.
> This patch is using the number which seems correct.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/clock-sh73a0.c        |    4 +-
>  arch/arm/mach-shmobile/include/mach/sh73a0.h |    7 ++
>  arch/arm/mach-shmobile/setup-sh73a0.c        |  111 ++++++++++++++++++++++++++
>  3 files changed, 121 insertions(+), 1 deletions(-)
