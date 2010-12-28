From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 28 Dec 2010 21:46:25 +0000
Subject: Re: [PATCH] mmc: sh: Add SH_DMAE to depends of sh_mmcif
Message-Id: <Pine.LNX.4.64.1012282243540.21647@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1293502664-26214-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1293502664-26214-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 28 Dec 2010, Nobuhiro Iwamatsu wrote:

> sh_mmcif can choose DMA support.
> But compile error when SH_DMAE is not enable.

This error is fixed by https://patchwork.kernel.org/patch/427351/ so, this 
is not really required. Besides, we want to remove CONFIG_SH_MMCIF_DMA 
completely, i.e., have it always enabled. So, even though this doesn't 
hurt for now, it won't help much in the future.

Thanks
Guennadi

> 
> -----
> drivers/built-in.o: In function `sh_mmcif_start_dma_tx':
> drivers/mmc/host/sh_mmcif.c:856: undefined reference to `dma_release_channel'
> drivers/built-in.o: In function `sh_mmcif_multi_read':
> drivers/mmc/host/sh_mmcif.c:513: undefined reference to `dma_release_channel'
> drivers/built-in.o: In function `sh_mmcif_probe':
> drivers/mmc/host/sh_mmcif.c:1082: undefined reference to `__dma_request_channel'
> drivers/mmc/host/sh_mmcif.c:1082: undefined reference to `dma_release_channel'
> drivers/built-in.o: In function `sh_mmcif_remove':
> drivers/mmc/host/sh_mmcif.c:1109: undefined reference to `dma_release_channel'
> -----
> 
> When we use DMA-support in sh_mmcif, SH_DMAE is necessary.
> 
> Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>
> CC: Chris Ball <cjb@laptop.org>
> CC: Paul Mundt <lethal@linux-sh.org> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 859e352..b400940 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -468,7 +468,7 @@ config MMC_SH_MMCIF
>  
>  config SH_MMCIF_DMA
>  	bool "Use DMA for MMCIF"
> -	depends on MMC_SH_MMCIF
> +	depends on MMC_SH_MMCIF && SH_DMAE
>  	help
>  	  Use SH dma-engine driver for data transfer
>  
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
