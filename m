From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 11 Jan 2016 18:27:00 +0000
Subject: Re: [PATCH 2/2] v4l: vsp1: Add missing #include <linux/slab.h>
Message-Id: <5332920.vEP78QP2FI@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452536727-19538-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452536727-19538-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 11 January 2016 19:25:27 Geert Uytterhoeven wrote:
> If CONFIG_SPI=n:
> 
> drivers/media/platform/vsp1/vsp1_dl.c: In function 'vsp1_dl_create':
> drivers/media/platform/vsp1/vsp1_dl.c:271:2: error: implicit declaration of
> function 'kzalloc' [-Werror=implicit-function-declaration] dl > kzalloc(sizeof(*dl), GFP_KERNEL);
>   ^
> drivers/media/platform/vsp1/vsp1_dl.c:271:5: warning: assignment makes
> pointer from integer without a cast dl = kzalloc(sizeof(*dl), GFP_KERNEL);
>      ^
> drivers/media/platform/vsp1/vsp1_dl.c:283:3: error: implicit declaration of
> function 'kfree' [-Werror=implicit-function-declaration] kfree(dl);
>    ^
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I have this in my tree already.

> ---
> Against renesas-drivers-2016-01-05-v4.4-rc8
> 
>  drivers/media/platform/vsp1/vsp1_dl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_dl.c
> b/drivers/media/platform/vsp1/vsp1_dl.c index
> a4dcccf0778bb479..7dc27ac6bd02a38b 100644
> --- a/drivers/media/platform/vsp1/vsp1_dl.c
> +++ b/drivers/media/platform/vsp1/vsp1_dl.c
> @@ -14,6 +14,7 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/gfp.h>
> +#include <linux/slab.h>
> 
>  #include "vsp1.h"
>  #include "vsp1_dl.h"

-- 
Regards,

Laurent Pinchart

