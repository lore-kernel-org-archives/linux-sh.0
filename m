From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 06:40:18 +0000
Subject: [PATCH 00/06] mach-shmobile device tree preparation patches
Message-Id: <20120328064018.28557.54004.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

mach-shmobile device tree preparation patches

[PATCH 01/06] ARM: mach-shmobile: Introduce shmobile_setup_delay()
[PATCH 02/06] ARM: mach-shmobile: Use NR_IRQS_LEGACY as IRQ offset
[PATCH 03/06] ARM: mach-shmobile: Introduce INTC_IRQ_PINS_16H
[PATCH 04/06] ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
[PATCH 05/06] ARM: mach-shmobile: Use INTC_IRQ_PINS_16H on sh7372
[PATCH 06/06] ARM: mach-shmobile: Rework sh7372 INTCS demuxer

This series contains various updates for mach-shmobile related to
device tree support. They are built on top of the renesas tree
commit a6e24019468009a21b674e392d74283a90f415dd. There are no
special dependencies apart from patch 05 depending on patch 03.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/entry-intc.S          |    4 +
 arch/arm/mach-shmobile/include/mach/common.h |    2 
 arch/arm/mach-shmobile/include/mach/intc.h   |   88 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/irqs.h   |   16 ++--
 arch/arm/mach-shmobile/intc-sh7372.c         |   90 +++++++++++++++++++-------
 arch/arm/mach-shmobile/timer.c               |   17 ++++
 6 files changed, 187 insertions(+), 30 deletions(-)
