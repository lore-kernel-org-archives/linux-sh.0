From: Simon Horman <horms@verge.net.au>
Date: Wed, 03 Jul 2013 05:48:58 +0000
Subject: Re: [PATCH v3 4/7] ARM: shmobile: r8a7740: add MMCIF DMA definitions
Message-Id: <20130703054858.GA3912@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372257656-9944-1-git-send-email-g.liakhovetski@gmx.de>
 <1372257656-9944-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372257656-9944-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Wed, Jun 26, 2013 at 04:40:53PM +0200, Guennadi Liakhovetski wrote:
> Add DMA channel slave IDs and configuration entries for the r8a7740
> MMCIF controller.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 ++
>  arch/arm/mach-shmobile/setup-r8a7740.c        |   10 ++++++++++
>  2 files changed, 12 insertions(+), 0 deletions(-)

Thanks, I will queue this up for v3.12 in the soc branch.

> 
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> index b34d19b..56f3750 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> @@ -42,6 +42,8 @@ enum {
>  	SHDMA_SLAVE_FSIB_TX,
>  	SHDMA_SLAVE_USBHS_TX,
>  	SHDMA_SLAVE_USBHS_RX,
> +	SHDMA_SLAVE_MMCIF_TX,
> +	SHDMA_SLAVE_MMCIF_RX,
>  };
>  
>  extern void r8a7740_meram_workaround(void);
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
> index 00c5a70..6b3ed42 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -588,6 +588,16 @@ static const struct sh_dmae_slave_config r8a7740_dmae_slaves[] = {
>  		.addr		= 0xfe1f0064,
>  		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
>  		.mid_rid	= 0xb5,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
> +		.addr		= 0xe6bd0034,
> +		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
> +		.mid_rid	= 0xd1,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
> +		.addr		= 0xe6bd0034,
> +		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
> +		.mid_rid	= 0xd2,
>  	},
>  };
>  
> -- 
> 1.7.2.5
> 
