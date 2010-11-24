From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 24 Nov 2010 10:05:08 +0000
Subject: [PATCH 0/5 v2] MMC: DMA for SH MMCIF
Message-Id: <Pine.LNX.4.64.1011241048280.18622@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>

This patch series slightly cleans up the sh_mmcif MMC driver and adds a 
DMA capability to it. One of the patches is not directly related, but is 
required for a proper DMA functionality. V2 limits the number of request 
segments, instead of raising the number of DMA descriptors in shdma.c. 
This drops one patch from this series and modifies one further patch, the 
rest remain unchanged.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
