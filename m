From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 20 Jun 2012 10:33:54 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel
Message-Id: <201206201233.55097.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, May 24, 2012, Guennadi Liakhovetski wrote:
> SDHI0 card-detect GPIO IRQ on mackarel currently works, because it is the
> default configuration of IRQ26. However, we should not rely on this and
> should configure the function explicitly.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied to the fixes branch of the renesas.git tree.

Thanks,
Rafael


> ---
>  arch/arm/mach-shmobile/board-mackerel.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index b577f7c..150122a 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1512,6 +1512,9 @@ static void __init mackerel_init(void)
>  	gpio_request(GPIO_FN_SDHID0_1, NULL);
>  	gpio_request(GPIO_FN_SDHID0_0, NULL);
>  
> +	/* SDHI0 PORT172 card-detect IRQ26 */
> +	gpio_request(GPIO_FN_IRQ26_172, NULL);
> +
>  #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
>  	/* enable SDHI1 */
>  	gpio_request(GPIO_FN_SDHICMD1, NULL);
> 

