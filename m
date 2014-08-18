From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 18 Aug 2014 15:51:44 +0000
Subject: [PATCH 5/8] ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
Message-Id: <1408377107-3822-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/timer.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 942efdc..0b01770 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -60,7 +60,7 @@ void __init shmobile_setup_delay(unsigned int max_cpu_core_mhz,
 void __init shmobile_init_delay(void)
 {
 	struct device_node *np, *cpus;
-	bool is_a8_a9 = false;
+	bool is_a7_a8_a9 = false;
 	bool is_a15 = false;
 	u32 max_freq = 0;
 
@@ -74,9 +74,10 @@ void __init shmobile_init_delay(void)
 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 
-		if (of_device_is_compatible(np, "arm,cortex-a8") ||
+		if (of_device_is_compatible(np, "arm,cortex-a7") ||
+		    of_device_is_compatible(np, "arm,cortex-a8") ||
 		    of_device_is_compatible(np, "arm,cortex-a9"))
-			is_a8_a9 = true;
+			is_a7_a8_a9 = true;
 		else if (of_device_is_compatible(np, "arm,cortex-a15"))
 			is_a15 = true;
 	}
@@ -86,7 +87,7 @@ void __init shmobile_init_delay(void)
 	if (!max_freq)
 		return;
 
-	if (is_a8_a9)
+	if (is_a7_a8_a9)
 		shmobile_setup_delay_hz(max_freq, 1, 3);
 	else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
 		shmobile_setup_delay_hz(max_freq, 2, 4);
-- 
1.8.4.5

