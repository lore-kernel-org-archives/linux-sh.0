From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 06:59:35 +0000
Subject: [PATCH/RFC 4/6] arm: shmobile: r8a7791: Obtain MD pin value using boot-mode-reg
Message-Id: <1444892377-10170-5-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use new boot mode reg infrastructure to obtain the mode pin
value when initialising SMP for r8a7791 SoC.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-r8a7791.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index b2508c0d276b..595499834293 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -20,6 +20,8 @@
 
 #include <asm/smp_plat.h>
 
+#include <misc/boot-mode-reg.h>
+
 #include "common.h"
 #include "platsmp-apmu.h"
 #include "r8a7791.h"
@@ -45,8 +47,17 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 static int r8a7791_smp_boot_secondary(unsigned int cpu,
 				      struct task_struct *idle)
 {
+	int err;
+	u32 mode;
+
+	err = boot_mode_reg_get(&mode);
+	if (err) {
+		pr_warn("Unable retrieve boot mode register\n");
+		return err;
+	}
+
 	/* Error out when hardware debug mode is enabled */
-	if (rcar_gen2_read_mode_pins() & BIT(21)) {
+	if (mode & BIT(21)) {
 		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
 		return -ENOTSUPP;
 	}
-- 
2.1.4

