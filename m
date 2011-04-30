From: Rob Herring <robherring2@gmail.com>
Date: Sat, 30 Apr 2011 02:08:13 +0000
Subject: [PATCH 06/10] ARM: realview: use common scu_init_cpus
Message-Id: <1304129297-6614-7-git-send-email-robherring2@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1304129297-6614-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Convert realview to use common scu_init_cpus function.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-realview/platsmp.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-realview/platsmp.c b/arch/arm/mach-realview/platsmp.c
index f443ef3..655a93b 100644
--- a/arch/arm/mach-realview/platsmp.c
+++ b/arch/arm/mach-realview/platsmp.c
@@ -43,22 +43,7 @@ static void __iomem *scu_base_addr(void)
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
-		       "Realview: no. of cores (%d) greater than configured "
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

