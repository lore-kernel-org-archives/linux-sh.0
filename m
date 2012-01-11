From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Jan 2012 09:05:45 +0000
Subject: Re: [PATCH v4 2/6] sh: add a resource name for shdma
Message-Id: <Pine.LNX.4.64.1201110941180.1191@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D39F5.90208@renesas.com>
In-Reply-To: <4F0D39F5.90208@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unrelated to your patch, just something that caught my eye:

On Wed, 11 Jan 2012, Shimoda, Yoshihiro wrote:

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  about v4:
>   - use defination macros for IRQ resource
> 
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    3 +++
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    6 ++++++
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   16 ++++++++++++++++
>  arch/sh/kernel/cpu/sh4a/setup-sh7780.c |    2 ++
>  arch/sh/kernel/cpu/sh4a/setup-sh7785.c |    2 ++
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c |    2 ++
>  6 files changed, 31 insertions(+), 0 deletions(-)

[snip]

> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
> index 3d4d207..cd8d1e9 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
> @@ -322,6 +322,7 @@ static struct resource sh7780_dmae0_resources[] = {
>  	},
>  	{
>  		/* Real DMA error IRQ is 38, and channel IRQs are 34-37, 44-45 */
> +		.name	= SH_DMA_IRQ_ERROR,
>  		.start	= 34,
>  		.end	= 34,
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> @@ -338,6 +339,7 @@ static struct resource sh7780_dmae1_resources[] = {
>  	/* DMAC1 has no DMARS */
>  	{
>  		/* Real DMA error IRQ is 38, and channel IRQs are 46-47, 92-95 */
> +		.name	= SH_DMA_IRQ_ERROR,
>  		.start	= 46,
>  		.end	= 46,
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
> index b29e634..1cdb9ec 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
> @@ -376,6 +376,7 @@ static struct resource sh7785_dmae0_resources[] = {
>  	},
>  	{
>  		/* Real DMA error IRQ is 39, and channel IRQs are 33-38 */
> +		.name	= SH_DMA_IRQ_ERROR,
>  		.start	= 33,
>  		.end	= 33,
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
> @@ -392,6 +393,7 @@ static struct resource sh7785_dmae1_resources[] = {
>  	/* DMAC1 has no DMARS */
>  	{
>  		/* Real DMA error IRQ is 58, and channel IRQs are 52-57 */
> +		.name	= SH_DMA_IRQ_ERROR,
>  		.start	= 52,
>  		.end	= 52,
>  		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,

The above two platforms seem incorrect. Back then, as I switched sh_dma.c 
to use resources for interrupts [1], I just reproduced the behaviour of 
the original driver, but a verification with the header or the datasheet 
shows, that sh7780 and sh7785 have separate interrupts per channel, so, if 
anyone cares about those platforms, they might need a fix.

Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.ports.sh.devel/7269/focusr70
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
