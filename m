From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 05 Jun 2014 03:49:44 +0000
Subject: [PATCH v3] ARM: shmobile: Mark all SoCs in shmobile as CPUFreq, capable
Message-Id: <538FE8D8.3050602@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Benoit Cousson <bcousson@baylibre.com>

Mark all SoCs in shmobile as CPUFreq capable
on multiplatform build only.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
[gaku.inami.xw@bp.renesas.com: Move the definition of cpufreq capable]
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---

Changes since version 1:
- changed "Signed-off-by" and "From" correctly.
- fixed typo.

Changes since version 2:
- moved the definition of cpufreq capable for shmobile.
- reworked based on renesas-devel-v3.15-rc8-20140605.

 arch/arm/mach-shmobile/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2a7712b..3b28bd8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -13,6 +13,8 @@ config ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 
 if ARCH_SHMOBILE_MULTI
 
-- 
1.7.9.5

