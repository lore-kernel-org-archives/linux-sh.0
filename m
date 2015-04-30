From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Apr 2015 05:49:10 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a73a4: Remove obsolete multi-platform check
Message-Id: <20150430054910.GN15511@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216072-31412-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430216072-31412-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Tue, Apr 28, 2015 at 12:14:31PM +0200, Geert Uytterhoeven wrote:
> As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> legacy platform"), r8a73a4 is only supported in generic ARM
> multi-platform builds.  Hence CONFIG_ARCH_MULTIPLATFORM is always set,
> and the check can be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on Simon's branch r8a73a4-ccf-and-multiplatform-for-v4.1

Which was tagged as renesas-r8a73a4-ccf-and-multiplatform-for-v4.1 and
is present in v4.0-rc1.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> index 280a56f977860272..ba18d2e65e674563 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> @@ -21,10 +21,6 @@
>  #include <linux/kernel.h>
>  #include <linux/pinctrl/pinconf-generic.h>
>  
> -#ifndef CONFIG_ARCH_MULTIPLATFORM
> -#include <mach/irqs.h>
> -#endif
> -
>  #include "core.h"
>  #include "sh_pfc.h"
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
