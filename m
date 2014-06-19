From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 19 Jun 2014 11:06:08 +0000
Subject: [PATCH] ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile
Message-Id: <53A2C420.3080609@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The following commit has removed ARCH_HAS_CPUFREQ config:

 Commit: e49d9b375628e67c9a718f4befaa8e45e5fad21b
 Subject: ARM: Remove ARCH_HAS_CPUFREQ config option

This patch removes the code that is using ARCH_HAS_CPUFREQ
in mach-shmobile.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ec0c89d..4508643 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -12,7 +12,6 @@ menuconfig ARCH_SHMOBILE_MULTI
 	select NO_IOPORT_MAP
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 
 if ARCH_SHMOBILE_MULTI
-- 
1.7.9.5

