From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 23 Jul 2013 19:54:09 +0000
Subject: Re: [PATCH v4 02/15] DMA: shdma: add r8a7740 DMAC data to the device ID table
Message-Id: <CANqRtoRnMkUjYKp3j2agoN7ufh9DGGbha6xQS8ugibLvK3hGfA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1374576609-27748-1-git-send-email-g.liakhovetski@gmx.de>
	<1374576609-27748-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374576609-27748-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, SH-Linux <linux-sh@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Guennadi,

Thanks for your efforts on this.

On Tue, Jul 23, 2013 at 7:49 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This configuration data will be re-used, when DMAC DT support is added to
> r8a7740, DMAC platform data in setup-r8a7740.c will be removed.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v4: make struct sh_dmae_pdata r8a7740_dma_pdata "const"
>

[snip]

> --- /dev/null
> +++ b/drivers/dma/sh/shdma-r8a7740.c
> @@ -0,0 +1,95 @@
> +#include <linux/sh_dma.h>
> +
> +#include <mach/dma-register.h>
> +#include <mach/r8a7740.h>

Including stuff from <mach/..> isn't really compatible with
MULTIPLATFORM, so please don't write new code like this. Actually we
don't want any code under drivers/ to include stuff from the mach
directory.

I suggest that you arrange your code in a way so the C version of DMAC
support has tables with slave ids as usual under
arch/arm/mach-shmobile/, but the DT bits that operate independently of
C stay in drivers/... Over time we will get rid of the C version, and
until that happens the DT and C version can coexist in parallel.

Cheers,

/ magnus
