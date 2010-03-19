From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 07:37:11 +0000
Subject: Re: [PATCH 03/05] serial: sh-sci: Use sg_dma_len() and sg_dma_address()
Message-Id: <Pine.LNX.4.64.1003190836470.4490@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044701.17051.77755.sendpatchset@t400s>
In-Reply-To: <20100319044701.17051.77755.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Mar 2010, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>
> 
> Convert the dmaengine code in sh-sci.c from
> directly accessing the struct scatterlist members
> length, dma_length and dma_address to using the
> macros sg_dma_len() and sg_dma_address().
> 
> Makes the code build for ARM.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
