From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 07:59:41 +0000
Subject: Re: [PATCH 05/27] ARM: shmobile: shareing DMAEngine TS_HI/LOW value
Message-Id: <20120611075940.GF30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwa2qzcm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwa2qzcm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:52:45PM -0700, Kuninori Morimoto wrote:
> In SH-ARM CPU (= sh7372/sh73a0/r8a7740),
> DMAC :: CHCR :: TS (= DMA Transfer Size Specify) bit is mapped as
> TS[3:2] = CHCR[21:20]
> TS[1:0] = CHCR[4:3]
> 
> Because of these mapping, shdma needs
> special settings on sh_dmae_pdata / sh_dmae_slave_config.
> 
> But it is easy to understand if these settings use sharing value
> instead of using direct value.
> This patch modify these.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/include/mach/dma-register.h |   11 ++++++++++-
>  arch/arm/mach-shmobile/setup-sh7372.c              |    8 ++++----
>  arch/arm/mach-shmobile/setup-sh73a0.c              |    8 ++++----
>  3 files changed, 18 insertions(+), 9 deletions(-)
