From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 04 May 2010 14:06:15 +0000
Subject: [PATCH 0/9 v2] add DMA support to tmio_mmc, using dmaengine API,
Message-Id: <Pine.LNX.4.64.1005041318200.4925@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>

This patch series adds DMA support to the tmio_mmc SD/MMC host driver, 
using the dmaengine API. DMA is enabled on SuperH platforms and ARM 
shmobile boards, both use the sh_mobile_sdhi MFD driver. Other TMIO MFD 
implementations are unaffected. The patch transparently falls back to PIO 
if no DMA is configured by the MFD driver, or if DMA initialisation or 
execution fails.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
