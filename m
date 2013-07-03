From: Simon Horman <horms@verge.net.au>
Date: Wed, 03 Jul 2013 06:05:44 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: add DMA support to MMCIF
Message-Id: <20130703060543.GB3912@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 02, 2013 at 05:24:58PM +0200, Guennadi Liakhovetski wrote:
> Add DMA slave IDs to MMCIF Tx and Rx channels.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> depends on "ARM: shmobile: r8a7740: add MMCIF DMA definitions"
> http://www.spinics.net/lists/linux-sh/msg20295.html
> 
>  arch/arm/mach-shmobile/board-armadillo800eva.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index ce1c37f..41ff7d65 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -778,6 +778,8 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
>  	.caps		= MMC_CAP_4_BIT_DATA |
>  			  MMC_CAP_8_BIT_DATA |
>  			  MMC_CAP_NONREMOVABLE,
> +	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
> +	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
>  };
>  
>  static struct resource sh_mmcif_resources[] = {

Thanks, I will queue this up for v3.12 in the boards branch.
