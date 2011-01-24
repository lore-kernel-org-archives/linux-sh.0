From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 24 Jan 2011 10:24:22 +0000
Subject: [PATCH/RFC 0/2] SPI: DMA support for MSIOF
Message-Id: <Pine.LNX.4.64.1101241110400.12760@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general@lists.sourceforge.net
Cc: linux-sh@vger.kernel.org

The MSIOF controller on sh-mobile systems can use DMA for data transfers. 
This patch implements support for it, using the sh_dma dmaengine driver. 
Attention: this is only RFC / for information now, because DMA mode is 
unstable in my stress-tests. So far only tested on ecovec with an SD-card, 
which works stably in PIO mode. Still, it is possible, that this is an 
electric problem and DMA just changes the bus-usage pattern. DMA on MSIOF 
also suffers from the maximum transfer length limit of 256 words. In 8-bit 
mode, which is also used for mmc_spi, with the recent 32-bit consolidation 
we also transmit 256 bytes per transfer, so, in this mode we don't benefit 
from DMA.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
