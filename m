From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 06:35:15 +0000
Subject: [PATCH 00/02] ARM: shmobile: Update HAVE_ARM_ARCH_TIMER Kconfig bits
Message-Id: <20150621063515.6194.80456.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Update HAVE_ARM_ARCH_TIMER Kconfig bits

[PATCH 01/02] ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig
[PATCH 02/02] ARM: shmobile: Drop HAVE_ARM_ARCH_TIMER from defconfig

Convert ARM mach-shmobile to select HAVE_ARM_ARCH_TIMER from Kconfig
based on if the enabled SoC contains ARM arch timer IP or not.

Recent SoCs like R-Car Gen2 series and r8a73a4 include Cortex-A7 and/or
Cortex-A15 hardware including arch timer, so select HAVE_ARM_ARCH_TIMER
in such case.

In case only older SoCs with Cortex-A9 are enabled then the arch timer
does not have to be enabled.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

Written against renesas-devel-20150619-v4.1-rc8

 arch/arm/configs/shmobile_defconfig |    1 -
 arch/arm/mach-shmobile/Kconfig      |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
