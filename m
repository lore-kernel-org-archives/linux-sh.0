From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 16:21:42 +0000
Subject: [PATCH v2 0/3] ARM: shmobile: sh73a0: fix spurious irqpin interrupts
Message-Id: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On sh73a0 irqpin interrupts have to be masked on the parent GIC controller.
This can only be done if interrupts are mapped when the first spurious IRQ
occurs. Patch 2 in this series maps all irqpin interrupts at probe time to
fix the problem. The third patch adds support for an irqpin IRQ to
kzm9g-reference.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: shmobile: sh73a0: fix spurious irqpin interrupts in the DT case
  irqchip: intc-irqpin: pre-map all interrupts in the DT case
  ARM: shmobile: kzm9g-reference: use GPIO for card detection on SDHI2

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi                |    2 ++
 drivers/irqchip/irq-renesas-intc-irqpin.c    |   10 +++++++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
