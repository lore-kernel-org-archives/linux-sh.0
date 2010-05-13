From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 13 May 2010 14:15:34 +0000
Subject: [PATCH 0/9 v4] add DMA support to tmio_mmc, using dmaengine API,
Message-Id: <Pine.LNX.4.64.1005131554030.4671@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, mm-commits@vger.kernel.org, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Russell King <rmk@arm.linux.org.uk>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

This is yet another split of patch

[PATCH 4/9] MMC: add DMA support to tmio_mmc driver, when used on SuperH

whereby per Ian's request patch "4a" has been further split in tmio- and 
sdhi-parts, so that now we have patches 4a/9, 4b/9 and 4c/9.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
