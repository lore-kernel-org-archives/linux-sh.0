From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 19 Jun 2012 04:36:39 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
Message-Id: <4FE001D7.9070207@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa00t4y2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa00t4y2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, morimoto-san

After applying this patch, I can mount and read/write to eMMC.
Is it enough to test?
Or how do I know DMAEngine is working properly?


(2012/06/19 11:23), Kuninori Morimoto wrote:
> It is possible to reduce CPU load if MMCIF used DMAEngine.
> This patch enabled it.
>
> Signed-off-by: Kuninori Morimoto<kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/board-kzm9g.c |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index d2feee1..ba80e72 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -197,6 +197,8 @@ static struct resource sh_mmcif_resources[] = {
>   static struct sh_mmcif_plat_data sh_mmcif_platdata = {
>   	.ocr		= MMC_VDD_165_195,
>   	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
> +	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
> +	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
>   };
>
>   static struct platform_device mmc_device = {

