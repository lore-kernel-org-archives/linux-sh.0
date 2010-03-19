From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 07:32:31 +0000
Subject: Re: [PATCH 02/05] dmaengine: shdma: Common SH_DMA_SLAVE_NUMBER
Message-Id: <Pine.LNX.4.64.1003190831240.4490@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044647.17051.25902.sendpatchset@t400s>
In-Reply-To: <20100319044647.17051.25902.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Mar 2010, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>
> 
> Move SHDMA_SLAVE_NUMBER from asm/dmaengine.h to
> shdma.h. Set it to 256 to support a wide range
> of processors. The amount of memory consumed by
> this change is limited to 256 bits.
> 
> While at it, rename to SH_DMA_SLAVE_NUMBER to
> match with the rest of the file.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
