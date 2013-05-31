From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 13:58:37 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
Message-Id: <2364919.FdR1Nu0Y37@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <1370008605-3745603-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1370008605-3745603-2-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 31 May 2013 15:56:45 Arnd Bergmann wrote:
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -2,6 +2,7 @@
>  #define LINUX_MMC_SH_MOBILE_SDHI_H
>  
>  #include <linux/types.h>
> +#include <linux/dmaengine.h>
>  
>  struct platform_device;
>  

This hunk should have been in the first patch. I'll
wait for comments before re-sending. Don't apply as-is.

	Arnd
