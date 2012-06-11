From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 07:59:55 +0000
Subject: Re: [PATCH 04/27] ARM: shmobile: shareing DMAEngine definitions
Message-Id: <20120611075954.GG30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87hauiqzd0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hauiqzd0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:52:30PM -0700, Kuninori Morimoto wrote:
> Current shmobile have DMAEngine specific settings on each CPU code,
> but SH-ARM DMAC use same value.
> This patch will share DMAEngine definitions and reduce a waste of code
> on SH-ARM architecture.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/include/mach/dma-register.h |   45 ++++++++++++
>  arch/arm/mach-shmobile/setup-sh7372.c              |   74 +++++++-------------
>  arch/arm/mach-shmobile/setup-sh73a0.c              |   27 +-------
>  3 files changed, 71 insertions(+), 75 deletions(-)
>  create mode 100644 arch/arm/mach-shmobile/include/mach/dma-register.h
