From: Rob Herring <robherring2@gmail.com>
Date: Sat, 30 Apr 2011 02:08:12 +0000
Subject: [PATCH 05/10] ARM: omap: use common scu_init_cpus
Message-Id: <1304129297-6614-6-git-send-email-robherring2@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert omap to use common scu_init_cpus function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-omap2/omap-smp.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index b66cfe8..831c8a0 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -99,25 +99,11 @@ static void __init wakeup_secondary(void)
  */
 void __init smp_init_cpus(void)
 {
-	unsigned int i, ncores;
-
 	/* Never released */
 	scu_base = ioremap(OMAP44XX_SCU_BASE, SZ_256);
 	BUG_ON(!scu_base);
 
-	ncores = scu_get_core_count(scu_base);
-
-	/* sanity check */
-	if (ncores > NR_CPUS) {
-		printk(KERN_WARNING
-		       "OMAP4: no. of cores (%d) greater than configured "
-		       "maximum of %d - clipping\n",
-		       ncores, NR_CPUS);
-		ncores = NR_CPUS;
-	}
-
-	for (i = 0; i < ncores; i++)
-		set_cpu_possible(i, true);
+	scu_init_cpus(scu_base);
 }
 
 void __init platform_smp_prepare_cpus(unsigned int max_cpus)
-- 
1.7.1

