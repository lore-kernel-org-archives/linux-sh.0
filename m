From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 29 May 2014 07:49:45 +0000
Subject: [PATCH 7/7] ARM: shmobile: Enable CPUFREQ configuration
Message-Id: <5386E699.2000107@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This changes of configuration is multiplatform build only for r8a7790/r8a7791.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/configs/shmobile_defconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 94d7736..5360c2a 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -147,3 +147,15 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_GOV_COMMON=y
+CONFIG_CPU_FREQ_STAT=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_THERMAL=y
+CONFIG_GENERIC_CPUFREQ_CPU0=y
-- 
1.7.9.5

