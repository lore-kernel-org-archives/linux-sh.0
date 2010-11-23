From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Nov 2010 16:24:07 +0000
Subject: [PATCH 0/3] handle unaligned buffers, when using TMIO-MMC with DMA
Message-Id: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

While testing SDIO on SuperH with TMIO and DMA, it turned out, that 
buffers, submitted to the driver can be arbitrarily aligned, and this is 
not handled by the tmio driver. This patch series fixes this issue.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
