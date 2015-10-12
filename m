From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:14 +0000
Subject: [RFC/RFT 6/6] cpuidle: big.LITTLE: Add ARCH_SHMOBILE and r8a7790
Message-Id: <1444671674-19275-7-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/cpuidle/Kconfig.arm          | 2 +-
 drivers/cpuidle/cpuidle-big_little.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..1583469 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -13,7 +13,7 @@ config ARM_CPUIDLE
 
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
-	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
+	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS || ARCH_SHMOBILE
 	depends on MCPM && !ARM64
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index db2ede5..4b87357 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -160,6 +160,7 @@ static const struct of_device_id compatible_machine_match[] = {
 	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
 	{ .compatible = "samsung,exynos5420" },
 	{ .compatible = "samsung,exynos5800" },
+	{ .compatible = "renesas,r8a7790" },
 	{},
 };
 
-- 
2.4.5

