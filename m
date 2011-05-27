From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 27 May 2011 10:44:46 +0000
Subject: [PATCH 0/3] fix TMIO DMA regression
Message-Id: <Pine.LNX.4.64.1105271235230.25265@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

A recent commit a197b59a

Author: David Rientjes <rientjes@google.com>

    mm: fail GFP_DMA allocations when ZONE_DMA is not configured

has broken TMIO DMA on SH and ARM. This patch series fixes the regression.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
