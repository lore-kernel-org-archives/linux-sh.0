From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 10 Jul 2015 20:48:16 +0000
Subject: [PATCH] ARM: shmobile: apmu: silence build warnings
Message-Id: <1436561296-29141-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

With shmobile_defconfig but SMP=n && SUSPEND=n, I get:

arch/arm/mach-shmobile/platsmp-apmu.c:49:12: warning: 'apmu_power_off' defined but not used [-Wunused-function]
arch/arm/mach-shmobile/platsmp-apmu.c:70:12: warning: 'apmu_wrap' defined but not used [-Wunused-function]

Annotate those functions like the functions around it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index b0790fc3228244..4e54512bee3083 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -46,7 +46,7 @@ static int __maybe_unused apmu_power_on(void __iomem *p, int bit)
 	return 0;
 }
 
-static int apmu_power_off(void __iomem *p, int bit)
+static int __maybe_unused apmu_power_off(void __iomem *p, int bit)
 {
 	/* request Core Standby for next WFI */
 	writel_relaxed(3, p + CPUNCR_OFFS(bit));
@@ -67,7 +67,7 @@ static int __maybe_unused apmu_power_off_poll(void __iomem *p, int bit)
 	return 0;
 }
 
-static int apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
+static int __maybe_unused apmu_wrap(int cpu, int (*fn)(void __iomem *p, int cpu))
 {
 	void __iomem *p = apmu_cpus[cpu].iomem;
 
-- 
2.1.4

