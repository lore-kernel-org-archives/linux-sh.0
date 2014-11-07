From: Kevin Cernekee <cernekee@gmail.com>
Date: Fri, 07 Nov 2014 06:44:15 +0000
Subject: [PATCH V4 00/14] genirq endian fixes; bcm7120/brcmstb IRQ updates
Message-Id: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

V3->V4:

 - Fix buildbot bisectability warning on patch 02/14 (missing include)

 - Add kernel-doc text for the new reg_{readl,writel} struct members and
   IRQ_GC_BE_IO flag


Kevin Cernekee (14):
  sh: Eliminate unused irq_reg_{readl,writel} accessors
  genirq: Generic chip: Change irq_reg_{readl,writel} arguments
  genirq: Generic chip: Allow irqchip drivers to override
    irq_reg_{readl,writel}
  genirq: Generic chip: Add big endian I/O accessors
  irqchip: brcmstb-l2: Eliminate dependency on ARM code
  irqchip: bcm7120-l2: Eliminate bad IRQ check
  irqchip: bcm7120-l2, brcmstb-l2: Remove ARM Kconfig dependency
  irqchip: bcm7120-l2: Make sure all register accesses use base+offset
  irqchip: bcm7120-l2: Fix missing nibble in gc->unused mask
  irqchip: bcm7120-l2: Use gc->mask_cache to simplify suspend/resume
    functions
  irqchip: bcm7120-l2: Extend driver to support 64+ bit controllers
  irqchip: bcm7120-l2: Decouple driver from brcmstb-l2
  irqchip: bcm7120-l2: Convert driver to use irq_reg_{readl,writel}
  irqchip: brcmstb-l2: Convert driver to use irq_reg_{readl,writel}

 .../interrupt-controller/brcm,bcm7120-l2-intc.txt  |  26 ++-
 arch/arm/mach-bcm/Kconfig                          |   1 +
 arch/sh/boards/mach-se/7343/irq.c                  |   3 -
 arch/sh/boards/mach-se/7722/irq.c                  |   3 -
 drivers/irqchip/Kconfig                            |   6 +-
 drivers/irqchip/Makefile                           |   4 +-
 drivers/irqchip/irq-atmel-aic.c                    |  40 ++---
 drivers/irqchip/irq-atmel-aic5.c                   |  65 ++++----
 drivers/irqchip/irq-bcm7120-l2.c                   | 174 +++++++++++++--------
 drivers/irqchip/irq-brcmstb-l2.c                   |  41 +++--
 drivers/irqchip/irq-sunxi-nmi.c                    |   4 +-
 drivers/irqchip/irq-tb10x.c                        |   4 +-
 include/linux/irq.h                                |  32 +++-
 kernel/irq/generic-chip.c                          |  36 +++--
 14 files changed, 263 insertions(+), 176 deletions(-)

-- 
2.1.1

