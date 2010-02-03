From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 15:03:42 +0000
Subject: [PATCH 0/4] sh: dmaengine driver improvements
Message-Id: <Pine.LNX.4.64.1002031547300.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series introduces several improvements to the shdma SH 
dmaengine driver:

1. better use platform-dvice infrastructures, resources to describe DMAC 
implementation details, ioremap address ranges, instead of poking at 
physical addresses directly.

2. separate SH headers for the legacy arch/sh/drivers/dma and the 
dmaengine driver

3. add runtime PM support to shdma dmaengine driver

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
