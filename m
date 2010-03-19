From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 07:24:10 +0000
Subject: Re: [PATCH 05/05] dmaengine: shdma: Enable on SH-Mobile ARM
Message-Id: <Pine.LNX.4.64.1003190822470.4490@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044719.17051.57155.sendpatchset@t400s>
In-Reply-To: <20100319044719.17051.57155.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Mar 2010, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>
> 
> Enable the shdma dmaengine driver on SH-Mobile ARM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---

[snip]

> --- 0005/include/linux/serial_sci.h
> +++ work/include/linux/serial_sci.h	2010-03-18 23:38:59.000000000 +0900
> @@ -3,7 +3,7 @@
>  
>  #include <linux/serial_core.h>
>  #ifdef CONFIG_SERIAL_SH_SCI_DMA
> -#include <asm/dmaengine.h>
> +#include <linux/sh_dma.h>

Shouldn't this be done in patch "04/05"?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
