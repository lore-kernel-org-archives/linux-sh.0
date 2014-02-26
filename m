From: Benoit Cousson <bcousson@baylibre.com>
Date: Wed, 26 Feb 2014 23:09:50 +0000
Subject: [RFC 4/4] ARM: shmobile: Make r8a77900 CPUFreq capable
Message-Id: <1393456190-7870-5-git-send-email-bcousson@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Mark r8a77900 platform as CPUFreq capable
on multiplatform build only.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 arch/arm/mach-shmobile/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index d27bff3..91faf79 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -32,6 +32,8 @@ config ARCH_R7S72100
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select RENESAS_IRQC
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_OPP
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
-- 
1.8.3.2

