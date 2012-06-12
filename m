From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jun 2012 02:08:10 +0000
Subject: Re: [PATCH 16/27] ARM: shmobile: r8a7740: add DMAEngine support for USB
Message-Id: <20120612020808.GM3557@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zk8apkll.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zk8apkll.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:56:42PM -0700, Kuninori Morimoto wrote:
> Current shdmac can support USB DMAC on r8a7740.
> This support reduce CPU load when USB access.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/clock-r8a7740.c        |    4 +-
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 +
>  arch/arm/mach-shmobile/setup-r8a7740.c        |   73 +++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 1 deletions(-)
