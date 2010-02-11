From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Feb 2010 16:50:00 +0000
Subject: [PATCH 0/5 v2] sh: dmaengine driver improvements
Message-Id: <Pine.LNX.4.64.1002111647350.4484@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

V2 of this patchset addresses comments to v1 - as is easy to guess;) 
Specific chenges are described in respective patches. One more patch is 
added, described in (4) below. Here again the description from v1:

This patch series introduces several improvements to the shdma SH 
dmaengine driver:

1. (v2) fix handling of DMA error interrupts

2. better use platform-dvice infrastructures, resources to describe DMAC 
implementation details, ioremap address ranges, instead of poking at 
physical addresses directly.

3. separate SH headers for the legacy arch/sh/drivers/dma and the 
dmaengine driver

4. add runtime PM support to shdma dmaengine driver

This series applies on top of my previous ASoC (SIU) and SH / dmaengine 
patches.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
