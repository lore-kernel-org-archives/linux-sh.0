From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Oct 2013 03:16:08 +0000
Subject: [PATCH] ARM: shmobile: Select IRQC in case of the r8a7791 SoC
Message-Id: <20131008031608.10122.53864.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7791 contains IRQC hardware so make sure
the driver gets built by selecting RENESAS_IRQC.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-20131004

 arch/arm/mach-shmobile/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-10-07 13:34:16.000000000 +0900
@@ -100,6 +100,7 @@ config ARCH_R8A7791
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select RENESAS_IRQC
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
