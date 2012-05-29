From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 May 2012 06:46:25 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: tidyup: sound card detection order
Message-Id: <20120529064621.GB6166@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 28, 2012 at 11:38:34PM -0700, Kuninori Morimoto wrote:
> Current sound card is using snd-simple-card,
> but it requests probe deferral when boot, since the detection
> timing of snd-simple-card is earlier than sh.
> 
> Because of this behavior, if platform has some sound cards,
> the postponed probe order was changed
> and it breaks ALSA device list order.
> 
> This patch makes it consistent on mackerel/ap4evb

Hi Morimoto-san,

Is the problem that a previous patch altered the order of the
ALSA index of the sound cards? And this patch restores the previous order?

If so, I wonder if this is really necessary as is should
be possible to set the index using a module parameter if one
is relying on it.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-ap4evb.c   |    2 +-
>  arch/arm/mach-shmobile/board-mackerel.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index d7417f3..2a1e9b5 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -1064,8 +1064,8 @@ static struct platform_device *ap4evb_devices[] __initdata = {
>  	&sdhi1_device,
>  	&usb1_host_device,
>  	&fsi_device,
> -	&fsi_ak4643_device,
>  	&fsi_hdmi_device,
> +	&fsi_ak4643_device,
>  	&sh_mmcif_device,
>  	&hdmi_device,
>  	&lcdc_device,
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 798be2b..2313a6f 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1300,8 +1300,8 @@ static struct platform_device *mackerel_devices[] __initdata = {
>  	&usbhs0_device,
>  	&leds_device,
>  	&fsi_device,
> -	&fsi_ak4643_device,
>  	&fsi_hdmi_device,
> +	&fsi_ak4643_device,
>  	&nand_flash_device,
>  	&sdhi0_device,
>  #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
