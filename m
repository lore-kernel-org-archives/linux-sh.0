From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 06:09:30 +0000
Subject: Re: [PATCH 1/6] ARM: shmobile: ape6evm: add DMA support to MMCIF
Message-Id: <20130925060930.GD6663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374498981-5263-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374498981-5263-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 22, 2013 at 03:16:16PM +0200, Guennadi Liakhovetski wrote:
> Add DMA support for MMCIF on APE6EVM, using the shdma dmaengine driver.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-ape6evm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> index 97c0dad..96a6994 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> @@ -75,6 +75,8 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] >  /* MMCIF */
>  static struct sh_mmcif_plat_data mmcif0_pdata = {
>  	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> +	.slave_id_tx	= SHDMA_SLAVE_MMCIF0_TX,
> +	.slave_id_rx	= SHDMA_SLAVE_MMCIF0_RX,
>  	.ccs_unsupported = true,
>  };

Thanks, I have queued this up for v3.13.
Please let me know if any other patches in this series are relevant for v3.13.
