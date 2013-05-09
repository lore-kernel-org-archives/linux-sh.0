From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 09 May 2013 00:05:40 +0000
Subject: [PATCH] ARM: shmobile: r8a7778: correct model name in Kconfig
Message-Id: <201305090405.41053.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The correct model name is R-Car M1A or R8A77781; R8A77780 corresponds to R-Car
M1S which is a SH based SoC.  

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the current Linus' tree.

 arch/arm/mach-shmobile/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/arm/mach-shmobile/Kconfig
=================================--- linux.orig/arch/arm/mach-shmobile/Kconfig
+++ linux/arch/arm/mach-shmobile/Kconfig
@@ -36,7 +36,7 @@ config ARCH_R8A7740
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
-	bool "R-Car M1 (R8A77780)"
+	bool "R-Car M1A (R8A77781)"
 	select CPU_V7
 	select SH_CLK_CPG
 	select ARM_GIC
