From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Nov 2010 07:40:42 +0000
Subject: [PATCH 0/6] MMC: DMA for SH MMCIF
Message-Id: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>

This patch series slightly cleans up the sh_mmcif MMC driver and adds a 
DMA capability to it. One of the patches is not directly related, but is 
required for a proper DMA functionality.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
