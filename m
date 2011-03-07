From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 07 Mar 2011 13:30:21 +0000
Subject: [PATCH 0/2] tmio_mmc: improve DMA reliability
Message-Id: <Pine.LNX.4.64.1103071417340.29543@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>

On my test hardware I am getting different results with different SD and 
SDIO cards on different boards in different slots. The first patch in this 
series fixes DMA for all my available hardware, the second one is a 
further improvement to make switching between DMA and PIO possible at 
run-time on a per-transfer basis and uses PIO for short transfers also 
when DMA is available.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
