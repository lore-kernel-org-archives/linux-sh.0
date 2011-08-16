From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 16 Aug 2011 07:51:00 +0000
Subject: Re: [PATCH 3/5] mmc: sdhi: Add defines for platform irq indexes
Message-Id: <Pine.LNX.4.64.1108160944130.13154@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
 <1313460499-3377-4-git-send-email-horms@verge.net.au>
In-Reply-To: <1313460499-3377-4-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

On Tue, 16 Aug 2011, Simon Horman wrote:

> This is intended to make it easier to correctly
> order platform defines in platform data and
> the logic that uses them.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  include/linux/mmc/sh_mobile_sdhi.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
> index bd50b36..c66c58c 100644
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -3,6 +3,10 @@
>  
>  #include <linux/types.h>
>  
> +#define SH_MOBILE_SDHI_IRQ_SDCARD	0
> +#define SH_MOBILE_SDHI_IRQ_CARD_DETECT	1
> +#define SH_MOBILE_SDHI_IRQ_SDIO		2
> +

An idea: make this an enum, put SH_MOBILE_SDHI_IRQ_NUMBER as a last item 
and use it in sh_mobile_sdhi_remove() as

	for (i = 0; i < SH_MOBILE_SDHI_IRQ_NUMBER; i++) {

? I would also merge it with PATCH 4/5.

>  struct platform_device;
>  struct tmio_mmc_data;
>  
> -- 
> 1.7.5.4

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
