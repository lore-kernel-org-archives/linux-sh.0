From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 00:50:40 +0000
Subject: Re: [PATCH] sh: ecovec: fixup compile error on sdhi
Message-Id: <20130925005038.GK26081@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87li2mr4dw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li2mr4dw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ Cc Chris Ball ]

On Tue, Sep 24, 2013 at 01:49:19AM -0700, Kuninori Morimoto wrote:
> afa2c9407f8908e2269b243773cbb0997c553804
> (sh: ecovec24: Use MMC/SDHI CD and RO GPIO)
> added .tmio_flags = TMIO_MMC_USE_GPIO_CD
> on sh_mobile_sdhi_info, but it needs
> <linux/mfd/tmio.h> header.
> This patch adds it
> 
> Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> Simon, Paul, Magnus
> 
>        This patch is for SH, but Paul can pick up it ?
>        Or Simon can ? I'm not sure...

I don't believe Paul is actively working on this code at this time.
While I am happy to pick this up I don't have an obvious
avenue to push it upstream.

Chris has previously taken MMCIF/SDHI related patches to this file
(and only this file) through his tree. Chris, would you consider
taking this one once it has been reviewed?

> 
> Laurent
> 
>         Can you check this patch ?
> 
>  arch/sh/boards/mach-ecovec24/setup.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 1fa8be4..122f737 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -15,6 +15,7 @@
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/mmc/sh_mobile_sdhi.h>
>  #include <linux/mtd/physmap.h>
> +#include <linux/mfd/tmio.h>
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
