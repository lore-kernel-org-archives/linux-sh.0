From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Jun 2014 12:03:25 +0000
Subject: [PATCH v2 7/8] ARM: shmobile: Make r8a7791 CPUFreq capable
Message-Id: <538DB98D.20009@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Mark r8a7791 platform as CPUFreq capable
on multiplatform build only.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a0b2b7f..9636f6e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -42,6 +42,8 @@ config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 
 comment "Renesas ARM SoCs Board Type"
 
-- 
1.7.9.5

