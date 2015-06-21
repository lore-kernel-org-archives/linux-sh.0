From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 06:35:26 +0000
Subject: [PATCH 01/02] ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig
Message-Id: <20150621063526.6194.24678.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Recent SoCs like R-Car Gen2 series and r8a73a4 include Cortex-A7 and/or
Cortex-A15 hardware including arch timer, so select HAVE_ARM_ARCH_TIMER
in such case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2015-06-20 12:29:15.812366518 +0900
@@ -21,6 +21,7 @@ config ARCH_RCAR_GEN2
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
 	select PCI_DOMAINS if PCI
+	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_RMOBILE
 	bool
@@ -56,6 +57,7 @@ config ARCH_R8A73A4
 	bool "R-Mobile APE6 (R8A73A40)"
 	select ARCH_RMOBILE
 	select RENESAS_IRQC
+	select HAVE_ARM_ARCH_TIMER
 
 config ARCH_R8A7740
 	bool "R-Mobile A1 (R8A77400)"
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
