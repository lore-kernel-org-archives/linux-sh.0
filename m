From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Jan 2012 09:31:26 +0000
Subject: Re: [PATCH] sh: se7724: fix compile breakage
Message-Id: <201201251031.29476.laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201250909220.18778@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201250909220.18778@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thanks for the patch.

On Wednesday 25 January 2012 09:10:29 Guennadi Liakhovetski wrote:
> Fix compilation breakage
> 
> arch/sh/boards/mach-se/7724/setup.c:182: error: 'V4L2_PIX_FMT_RGB565'
> undeclared here (not in a function) make[3]: ***
> [arch/sh/boards/mach-se/7724/setup.o] Error 1
> 
> caused by commit "fbdev: sh_mobile_lcdc: Support FOURCC-based format API"

My bad. The following files also need to include linux/videovdev2.h. Should I 
send a separate patch, or do you want to include them in your patch ?

arch/sh/boards/mach-kfr2r09/setup.c
arch/sh/boards/mach-ap325rxa/setup.c
arch/sh/boards/mach-migor/setup.c
arch/sh/boards/mach-ecovec24/setup.c

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-se/7724/setup.c
> b/arch/sh/boards/mach-se/7724/setup.c index 036fe1a..2b07fc0 100644
> --- a/arch/sh/boards/mach-se/7724/setup.c
> +++ b/arch/sh/boards/mach-se/7724/setup.c
> @@ -24,6 +24,7 @@
>  #include <linux/input/sh_keysc.h>
>  #include <linux/usb/r8a66597.h>
>  #include <linux/sh_eth.h>
> +#include <linux/videodev2.h>
>  #include <video/sh_mobile_lcdc.h>
>  #include <media/sh_mobile_ceu.h>
>  #include <sound/sh_fsi.h>

-- 
Regards,

Laurent Pinchart
