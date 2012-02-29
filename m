From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 Feb 2012 20:29:33 +0000
Subject: Re: [PATCH] sh: bonito: Fix compile breakage
Message-Id: <2227428.A4iueEQo4g@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1330523184-8540-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1330523184-8540-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil,

Thanks for the patch.

On Wednesday 29 February 2012 13:46:24 Phil Edworthy wrote:
> arch/arm/mach-shmobile/board-bonito.c:244:3: error: unknown field 'bpp'
> specified in initializer make[2]: ***
> [arch/arm/mach-shmobile/board-bonito.o] Error 1
> 
> caused by commit "fbdev: sh_mobile_lcdc: Support FOURCC-based format API"
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

You were faster than me :-)

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-shmobile/board-bonito.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-bonito.c
> b/arch/arm/mach-shmobile/board-bonito.c index 4d22016..4bd1162 100644
> --- a/arch/arm/mach-shmobile/board-bonito.c
> +++ b/arch/arm/mach-shmobile/board-bonito.c
> @@ -27,6 +27,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
>  #include <linux/smsc911x.h>
> +#include <linux/videodev2.h>
>  #include <mach/common.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
> @@ -241,7 +242,7 @@ static struct sh_mobile_lcdc_info lcdc0_info = {
>  	.clock_source	= LCDC_CLK_BUS,
>  	.ch[0] = {
>  		.chan			= LCDC_CHAN_MAINLCD,
> -		.bpp			= 16,
> +		.fourcc = V4L2_PIX_FMT_RGB565,
>  		.interface_type		= RGB24,
>  		.clock_divider		= 5,
>  		.flags			= 0,

-- 
Regards,

Laurent Pinchart
