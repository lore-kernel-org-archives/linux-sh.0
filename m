From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 29 May 2014 07:48:49 +0000
Subject: [PATCH 2/7] ARM: shmobile: Make r8a77900 CPUFreq capable
Message-Id: <5386E661.4080900@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Mark r8a77900 platform as CPUFreq capable
on multiplatform build only.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2a7712b..a0b2b7f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -35,6 +35,8 @@ config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select RENESAS_IRQC
 	select SYS_SUPPORTS_SH_CMT
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
-- 
1.7.9.5

