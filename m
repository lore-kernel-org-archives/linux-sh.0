From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Apr 2012 11:28:24 +0000
Subject: [PATCH/RFC 0/6] update MSIOF, MMCIF, SDHI clock management
Message-Id: <Pine.LNX.4.64.1204172345570.27488@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Attention: only compile-tested for SuperH.

This patch set is aiming at fixing two issues: (1) remove the use of 
connection IDs for the above devices, (2) remove manual clock management 
in MSIOF and MMCIF. In SDHI this has been done earlier by the commit "mmc: 
sh_mobile_sdhi: do not manage PM clocks manually." Since I don't have 
access to any of the affected by patch 1/6 platforms, any reviewing and 
testing would be highly appreciated. Lightly tested on ecovec (sh7724) and 
mackerel (sh7372). These patches should also make DT addition to affected 
drivers easier.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
