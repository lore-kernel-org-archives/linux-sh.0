From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Mar 2013 12:47:28 +0000
Subject: [PATCH 0/2] ARM: shmobile: sh73a0: SDHI and MMCIF enhancements
Message-Id: <Pine.LNX.4.64.1303191337260.11768@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

A couple of minor SDHI and MMCIF enhancements for sh73a0 / kzm9g. In 
principle independent, but patch 2 wouldn't apply without patch 1. In 
fact, patch "ARM: shmobile: kzm9g: add fixed voltage regulators for SDHI0 
and SDHI2" (http://www.spinics.net/lists/linux-sh/msg17285.html) from 
yesterday depends on the first patch in this series too, sorry for 
confusion.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
