From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 07 Feb 2013 23:31:35 +0000
Subject: [PATCH 0/3] MMCIF and SDHI for kzm9g- and armadillo800eva-reference
Message-Id: <Pine.LNX.4.64.1302080017430.30556@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add SDHI and MMCIF interfaces to device trees for kzm9g- and 
armadillo800eva-reference boards. Without pinctrl in DT support interface 
pins, card-detect and regulator GPIOs cannot be used. These can be added, 
once pinctrl is available.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
