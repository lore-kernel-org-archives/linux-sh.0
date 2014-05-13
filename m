From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 13 May 2014 08:14:20 +0000
Subject: Re: [PATCH 1/6] DMA: shdmac: Keep #include sorted alphabetically
Message-Id: <1399968860.3703.20.camel@smile.fi.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399935736-16854-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1399935736-16854-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 2014-05-13 at 01:02 +0200, Laurent Pinchart wrote:
> This helps detecting duplicate includes.

No need to do that, since we have nice helper
make includecheck

Similar comment to patch 3/6.
But if you have stronger explanation why it's needed besides that... you
are welcome )

> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/dma/sh/shdmac.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index dda7e75..7313537 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -18,21 +18,21 @@
>   *
>   */
>  
> +#include <linux/delay.h>
> +#include <linux/dmaengine.h>
>  #include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kdebug.h>
>  #include <linux/module.h>
> +#include <linux/notifier.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <linux/slab.h>
> -#include <linux/interrupt.h>
> -#include <linux/dmaengine.h>
> -#include <linux/delay.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/rculist.h>
>  #include <linux/sh_dma.h>
> -#include <linux/notifier.h>
> -#include <linux/kdebug.h>
> +#include <linux/slab.h>
>  #include <linux/spinlock.h>
> -#include <linux/rculist.h>
>  
>  #include "../dmaengine.h"
>  #include "shdma.h"


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy

