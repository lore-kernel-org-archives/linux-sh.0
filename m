From: Rob Herring <robherring2@gmail.com>
Date: Sat, 30 Apr 2011 02:08:15 +0000
Subject: [PATCH 08/10] ARM: ux500: use common scu_init_cpus
Message-Id: <1304129297-6614-9-git-send-email-robherring2@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert ux500 to use common scu_init_cpus function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-ux500/platsmp.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 88f30b8..7b19f9d 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -69,22 +69,7 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	void __iomem *scu_base = scu_base_addr();
-	unsigned int i, ncores;
-
-	ncores = scu_base ? scu_get_core_count(scu_base) : 1;
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "U8500: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	scu_init_cpus(scu_base_addr());
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.7.1

