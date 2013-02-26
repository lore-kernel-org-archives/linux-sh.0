From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Feb 2013 02:55:10 +0000
Subject: [PATCH 00/03] ARM: shmobile: Use Renesas INTC External IRQ pin driver
Message-Id: <20130226030049.9682.31129.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Use Renesas INTC External IRQ pin driver

[PATCH 01/03] ARM: shmobile: irq_pin() for static IRQ pin assignment
[PATCH 02/03] ARM: shmobile: INTC External IRQ pin driver on sh73a0
[PATCH 03/03] ARM: shmobile: INTC External IRQ pin driver on r8a7779

These patches make use of the INTC External IRQ pin driver
on the sh73a0 and r8a7779 SoC. They have been tested with
the first version of the INTC External IRQ pin driver, but
will most likely be forward compatible.

Judging by the diffstat below this patch set goes against the
recent trend and adds lines instead of deleting them. The reason
for this is that with this patch series the r8a7779 SoC gets
a feature update to make use of external IRQ pins IRQ0->IRQ3.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on:
 [PATCH] irqchip: Renesas INTC External IRQ pin driver

 arch/arm/mach-shmobile/Kconfig               |    2 
 arch/arm/mach-shmobile/board-kzm9g.c         |   14 +-
 arch/arm/mach-shmobile/board-marzen.c        |    3 
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/include/mach/irqs.h   |    4 
 arch/arm/mach-shmobile/intc-r8a7779.c        |   53 ++++++++++
 arch/arm/mach-shmobile/intc-sh73a0.c         |  117 ------------------------
 arch/arm/mach-shmobile/setup-sh73a0.c        |  126 ++++++++++++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c          |    6 -
 9 files changed, 197 insertions(+), 129 deletions(-)
