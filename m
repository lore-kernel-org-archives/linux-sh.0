From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Jun 2014 12:02:35 +0000
Subject: [PATCH v2 3/8] ARM: shmobile: Make r8a7790 CPUFreq capable
Message-Id: <538DB95B.9030407@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Benoit Cousson <bcousson@baylibre.com>

Mark r8a7790 platform as CPUFreq capable
on multiplatform build only.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---

Changes since version 1:
- changed "Signed-off-by" and "From" correctly.
- fixed typo.

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

