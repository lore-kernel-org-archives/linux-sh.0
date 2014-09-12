From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 12 Sep 2014 08:02:17 +0000
Subject: [PATCH] ARM: shmobile: Fix wrong calculation in shmobile_init_delay()
Message-Id: <5412A889.2000209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The processing to get CPU information loop on all available CPUs
and decide whether calculating preset_lpj for for CA15 or CA7/8/9.
The calculation will go for CA7/8/9 prior to CA15.

The commit 0dc50fd ARM: shmobile: support Cortex-A7 in shmobile_init_delay()
introduced wrong CPU selection in case CA15 and CA7/8/9 coexist, e.g R-CarH2.
At the end, it leads to the wrong calculation of preset_lpj for R-CarH2.

Fix it by selecting the first CPU in DTS file.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/timer.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 87c6be1..9394cad 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -59,10 +59,14 @@ void __init shmobile_init_delay(void)
 
 		if (of_device_is_compatible(np, "arm,cortex-a7") ||
 		    of_device_is_compatible(np, "arm,cortex-a8") ||
-		    of_device_is_compatible(np, "arm,cortex-a9"))
+		    of_device_is_compatible(np, "arm,cortex-a9")) {
 			is_a7_a8_a9 = true;
-		else if (of_device_is_compatible(np, "arm,cortex-a15"))
+			break;
+		}
+		else if (of_device_is_compatible(np, "arm,cortex-a15")) {
 			is_a15 = true;
+			break;
+		}
 	}
 
 	of_node_put(cpus);
-- 
1.7.9.5
