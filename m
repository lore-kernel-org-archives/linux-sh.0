From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Apr 2011 18:30:43 +0000
Subject: [PATCH 0/3] MMCIF: power-management, locking
Message-Id: <Pine.LNX.4.64.1104152021510.18593@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>

This patch-series adds locking to the sh-mobile MMCIF driver to protect 
against theoretical races between IO-requests and configuration and 
implements power-management, based on recent experimental patches from 
Magnus for the AP4 (sh7372) SoC.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

