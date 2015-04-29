From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 Apr 2015 11:53:10 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a73a4: Remove obsolete multi-platform check
Message-Id: <3243684.vmRUTCfuLe@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1430216107-31501-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430216107-31501-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 28 April 2015 12:15:06 Geert Uytterhoeven wrote:
> As of commit 9d07d414d4c33d86 ("ARM: shmobile: r8a73a4: ape6evm: Remove
> legacy platform"), r8a73a4 is only supported in generic ARM
> multi-platform builds.  Hence CONFIG_ARCH_MULTIPLATFORM is always set,
> and the check can be removed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c index
> 280a56f977860272..ba18d2e65e674563 100644
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

-- 
Regards,

Laurent Pinchart

