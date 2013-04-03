From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Apr 2013 09:18:57 +0000
Subject: [PATCH/RFC 0/2] ARM: shmobile: DT irqpin for r8a7779 and marzen-reference
Message-Id: <Pine.LNX.4.64.1304031103590.10531@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

This 2 patches add DT irqpin support on marzen-reference. Only 
compile-tested due to the lack of hardware. The patches can go 
independently via their respective trees. irqpin on marzen will not work 
if patch 2 is applied before patch 1, but as long as there are no devices, 
using irqpin interrupts, no breakage will be caused.

Guennadi Liakhovetski (2):
      irqchip: renesas-intc-irqpin: DT binding for sense bitfield width
      ARM: shmobile: marzen-reference: add irqpin support in DT

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
