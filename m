From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 Jun 2012 07:59:18 +0000
Subject: Re: [PATCH 06/27] ARM: shmobile: shareing DMAEngine USBTS_HI/LOW value
Message-Id: <20120611075917.GE30048@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehpmqzc9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehpmqzc9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:52:58PM -0700, Kuninori Morimoto wrote:
> In SH-ARM CPU (= sh7372/sh73a0/r8a7740),
> USB DMA :: CHCR :: TS (= DMA Transfer Size Specify) bit is mapped as
> TS[1:0] = CHCR[7:6]
> 
> SH-ARM USB DMAEngine uses shdma.
> Then, it is easy to understand if sh_dmae_pdata / sh_dmae_slave_config
> settings are used defined value instead of direct value.
> This patch modify these.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/arm/mach-shmobile/include/mach/dma-register.h |   30 +++++++++++++++++
>  arch/arm/mach-shmobile/setup-sh7372.c              |   35 +++++++------------
>  2 files changed, 43 insertions(+), 22 deletions(-)
