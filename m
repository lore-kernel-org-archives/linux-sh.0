From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 21 Apr 2010 15:36:45 +0000
Subject: [PATCH 0/8] add DMA support to tmio_mmc, using dmaengine API, use
Message-Id: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>

This patch series adds DMA support to the tmio_mmc SD/MMC host driver, 
using the dmaengine API. So far this is only used on SuperH platforms, 
will also be supported on ARM shmobile boards, both use the sh_mobile_sdhi 
MFD driver. Other TMIO MFD implementations are unaffected. The patch 
transparently falls back to PIO if no DMA is configured by the MFD driver, 
or if DMA initialisation or execution fail.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
