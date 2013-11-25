From: Simon Horman <horms@verge.net.au>
Date: Mon, 25 Nov 2013 02:44:33 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add HPBIFx DMAEngine support
Message-Id: <20131125024431.GB2786@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2luxllj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2luxllj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 11:25:32PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |   18 +++++++++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   51 +++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> index 441886c..b497f93 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> @@ -27,6 +27,24 @@ enum {
>  	HPBDMA_SLAVE_DUMMY,
>  	HPBDMA_SLAVE_SDHI0_TX,
>  	HPBDMA_SLAVE_SDHI0_RX,
> +	HPBDMA_SLAVE_HPBIF0_TX,
> +	HPBDMA_SLAVE_HPBIF0_RX,
> +	HPBDMA_SLAVE_HPBIF1_TX,
> +	HPBDMA_SLAVE_HPBIF1_RX,
> +	HPBDMA_SLAVE_HPBIF2_TX,
> +	HPBDMA_SLAVE_HPBIF2_RX,
> +	HPBDMA_SLAVE_HPBIF3_TX,
> +	HPBDMA_SLAVE_HPBIF3_RX,
> +	HPBDMA_SLAVE_HPBIF4_TX,
> +	HPBDMA_SLAVE_HPBIF4_RX,
> +	HPBDMA_SLAVE_HPBIF5_TX,
> +	HPBDMA_SLAVE_HPBIF5_RX,
> +	HPBDMA_SLAVE_HPBIF6_TX,
> +	HPBDMA_SLAVE_HPBIF6_RX,
> +	HPBDMA_SLAVE_HPBIF7_TX,
> +	HPBDMA_SLAVE_HPBIF7_RX,
> +	HPBDMA_SLAVE_HPBIF8_TX,
> +	HPBDMA_SLAVE_HPBIF8_RX,
>  };
>  
>  extern void r8a7778_add_standard_devices(void);
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 03fcc59..81701cf 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -319,6 +319,29 @@ void __init r8a7778_add_dt_devices(void)
>  #define HPB_DMAE_ASYNCMDR_ASMD21_SINGLE	BIT(1)	/* SDHI0 */
>  #define HPB_DMAE_ASYNCMDR_ASMD21_MULTI	0	/* SDHI0 */
>  
> +#define HPBDMA_HPBIF(_id)				\
> +{							\
> +	.id	= HPBDMA_SLAVE_HPBIF## _id ##_TX,	\
> +	.addr	= 0xffda0000 + (_id * 0x1000),		\
> +	.dcr	= HPB_DMAE_DCR_CT |			\
> +		  HPB_DMAE_DCR_DIP |			\
> +		  HPB_DMAE_DCR_SPDS_32BIT |		\
> +		  HPB_DMAE_DCR_DMDL |			\
> +		  HPB_DMAE_DCR_DPDS_32BIT,		\
> +	.port   = 0x1111,				\
> +	.dma_ch = (28 + _id),				\
> +}, {							\
> +	.id	= HPBDMA_SLAVE_HPBIF## _id ##_RX,	\
> +	.addr	= 0xffda0000 + (_id * 0x1000),		\
> +	.dcr	= HPB_DMAE_DCR_CT |			\
> +		  HPB_DMAE_DCR_DIP |			\
> +		  HPB_DMAE_DCR_SMDL |			\
> +		  HPB_DMAE_DCR_SPDS_32BIT |		\
> +		  HPB_DMAE_DCR_DPDS_32BIT,		\
> +	.port   = 0x1111,				\
> +	.dma_ch = (28 + _id),				\
> +}
> +
>  static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
>  	{
>  		.id	= HPBDMA_SLAVE_SDHI0_TX,
> @@ -349,11 +372,39 @@ static const struct hpb_dmae_slave_config hpb_dmae_slaves[] = {
>  		.flags	= HPB_DMAE_SET_ASYNC_RESET | HPB_DMAE_SET_ASYNC_MODE,
>  		.dma_ch	= 22,
>  	},
> +
> +	HPBDMA_HPBIF(0),
> +	HPBDMA_HPBIF(1),
> +	HPBDMA_HPBIF(2),
> +	HPBDMA_HPBIF(3),
> +	HPBDMA_HPBIF(4),
> +	HPBDMA_HPBIF(5),
> +	HPBDMA_HPBIF(6),
> +	HPBDMA_HPBIF(7),
> +	HPBDMA_HPBIF(8),
>  };
>  
>  static const struct hpb_dmae_channel hpb_dmae_channels[] = {
>  	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_TX), /* ch. 21 */
>  	HPB_DMAE_CHANNEL(0x7e, HPBDMA_SLAVE_SDHI0_RX), /* ch. 22 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF0_TX), /* ch. 28 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF0_RX), /* ch. 28 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF1_TX), /* ch. 29 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF1_RX), /* ch. 29 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF2_TX), /* ch. 30 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF2_RX), /* ch. 30 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF3_TX), /* ch. 31 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF3_RX), /* ch. 31 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF4_TX), /* ch. 32 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF4_RX), /* ch. 32 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF5_TX), /* ch. 33 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF5_RX), /* ch. 33 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF6_TX), /* ch. 34 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF6_RX), /* ch. 34 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF7_TX), /* ch. 35 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF7_RX), /* ch. 35 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF8_TX), /* ch. 36 */
> +	HPB_DMAE_CHANNEL(0x7f, HPBDMA_SLAVE_HPBIF8_RX), /* ch. 36 */
>  };
>  
>  static struct hpb_dmae_pdata dma_platform_data __initdata = {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
