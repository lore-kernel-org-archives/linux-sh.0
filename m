From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 19 Aug 2010 14:39:53 +0000
Subject: [PATCH 0/5] Add API for DMA memory reservation for devices
Message-Id: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch series attempts to solve the problem discussed here: 
http://marc.info/?t8128236400002&r=1&w=2. It is a regression in 
2.6.36-rc1, so, we shall try to fix it ASAP. The series contains a couple 
of clean ups, the actual implementation and an example of using this new 
API. Tested on SuperH. Comments welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
