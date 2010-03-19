From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 07:46:56 +0000
Subject: Re: [PATCH 04/05] dmaengine: shdma: Introduce include/linux/sh_dma.h
Message-Id: <Pine.LNX.4.64.1003190837450.4490@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044710.17051.98259.sendpatchset@t400s>
In-Reply-To: <20100319044710.17051.98259.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Mar 2010, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>
> 
> Create a common platform data header file for the
> shdma dmaengine driver. This is done by moving
> common structures from sh asm/dmaengine.h to
> linux/sh_dma.h. DMA registers are also copied from
> sh asm/dma-register.h to make the code architecture
> independent.
> 
> The sh header file asm/dmaengine.h is still kept
> with the slave id enum. This allows us to keep the
> old processor specific code as is and slowly move
> over to slave id enums in per-processor headers.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

...

> --- 0004/arch/sh/include/asm/dmaengine.h
> +++ work/arch/sh/include/asm/dmaengine.h        2010-03-18 23:25:04.000000000 +0900
> @@ -10,12 +10,7 @@
>  #ifndef ASM_DMAENGINE_H
>  #define ASM_DMAENGINE_H
>  
> -#include <linux/dmaengine.h>
> -#include <linux/list.h>
> -
> -#include <asm/dma-register.h>

include/linux/sh_dma_register.h? (see below)

[snip]

> +/* DMA register */
> +#define SAR    0x00
> +#define DAR    0x04
> +#define TCR    0x08
> +#define CHCR   0x0C
> +#define DMAOR  0x40
> +
> +/* DMAOR definitions */
> +#define DMAOR_AE       0x00000004
> +#define DMAOR_NMIF     0x00000002
> +#define DMAOR_DME      0x00000001
> +
> +/* Definitions for the SuperH DMAC */
> +#define REQ_L  0x00000000
> +#define REQ_E  0x00080000
> +#define RACK_H 0x00000000
> +#define RACK_L 0x00040000
> +#define ACK_R  0x00000000
> +#define ACK_W  0x00020000
> +#define ACK_H  0x00000000
> +#define ACK_L  0x00010000
> +#define DM_INC 0x00004000
> +#define DM_DEC 0x00008000
> +#define DM_FIX 0x0000c000
> +#define SM_INC 0x00001000
> +#define SM_DEC 0x00002000
> +#define SM_FIX 0x00003000
> +#define RS_IN  0x00000200
> +#define RS_OUT 0x00000300
> +#define TS_BLK 0x00000040
> +#define TM_BUR 0x00000020
> +#define CHCR_DE        0x00000001
> +#define CHCR_TE        0x00000002
> +#define CHCR_IE        0x00000004

I am still not sure it is a good idea to duplicate these from legacy SH 
DMA driver, maybe we could just move them in a 
include/linux/sh_dma_register.h if they are indeed common?

Ok, I might be lazy on a Friday morning, but could you maybe regenerate 
this one with "-M -C --find-copies-harder" or whatever it takes to make 
git use "git rename" for this? This should work if we don't duplicate 
register names, not sure otherwise...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
