From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 24 Oct 2012 08:54:16 +0000
Subject: [PATCH 1/3] ARM: shmobile: emev2: Replace modify_scu_cpu_psr with scu_power_mode
Message-Id: <1351068858-7255-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We can remove the extra code of modify_scu_cpu_psr() and use the cleaner
generic ARM helper scu_power_mode(). As every CPU only deals with its
own power register and scu_power_mode() operates with 8-bit accesses,
we save the locking overhead too.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 arch/arm/mach-shmobile/smp-emev2.c |   22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-emev2.c b/arch/arm/mach-shmobile/smp-emev2.c
index f674562..535426c 100644
--- a/arch/arm/mach-shmobile/smp-emev2.c
+++ b/arch/arm/mach-shmobile/smp-emev2.c
@@ -32,24 +32,8 @@
 
 #define EMEV2_SCU_BASE 0x1e000000
 
-static DEFINE_SPINLOCK(scu_lock);
 static void __iomem *scu_base;
 
-static void modify_scu_cpu_psr(unsigned long set, unsigned long clr)
-{
-	unsigned long tmp;
-
-	/* we assume this code is running on a different cpu
-	 * than the one that is changing coherency setting */
-	spin_lock(&scu_lock);
-	tmp = readl(scu_base + 8);
-	tmp &= ~clr;
-	tmp |= set;
-	writel(tmp, scu_base + 8);
-	spin_unlock(&scu_lock);
-
-}
-
 static unsigned int __init emev2_get_core_count(void)
 {
 	if (!scu_base) {
@@ -95,7 +79,7 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 	cpu = cpu_logical_map(cpu);
 
 	/* enable cache coherency */
-	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+	scu_power_mode(scu_base, 0);
 
 	/* Tell ROM loader about our vector (in headsmp.S) */
 	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
@@ -106,12 +90,10 @@ static int __cpuinit emev2_boot_secondary(unsigned int cpu, struct task_struct *
 
 static void __init emev2_smp_prepare_cpus(unsigned int max_cpus)
 {
-	int cpu = cpu_logical_map(0);
-
 	scu_enable(scu_base);
 
 	/* enable cache coherency on CPU0 */
-	modify_scu_cpu_psr(0, 3 << (cpu * 8));
+	scu_power_mode(scu_base, 0);
 }
 
 static void __init emev2_smp_init_cpus(void)
-- 
1.7.9.5

