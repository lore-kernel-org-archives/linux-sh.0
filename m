From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 25 Jul 2013 02:13:42 +0000
Subject: [PATCH v2 2/3] ARM: shmobile: r8a7779: Rely on DT for SMP CPU info
Message-Id: <1374718423-24230-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Remove r8a7779 specific ->smp_init_cpus() callback and
instead of relying on shmobile_smp_init_cpus() simply
use DT for CPU core information.

Based on work for the sh73a0 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--

Run-time dependency on "ARM: shmobile: marzen: Switch to DT_MACHINE_START".
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index 9bdf810..42170af 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -99,6 +99,9 @@ static int r8a7779_boot_secondary(unsigned int cpu, struct task_struct *idle)
 
 static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
+
+	/* setup r8a7779 specific SCU base */
+	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
 	scu_enable(shmobile_scu_base);
 
 	/* Map the reset vector (in headsmp-scu.S, headsmp.S) */
@@ -117,14 +120,6 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 	r8a7779_platform_cpu_kill(3);
 }
 
-static void __init r8a7779_smp_init_cpus(void)
-{
-	/* setup r8a7779 specific SCU base */
-	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
-
-	shmobile_smp_init_cpus(scu_get_core_count(shmobile_scu_base));
-}
-
 #ifdef CONFIG_HOTPLUG_CPU
 static int r8a7779_scu_psr_core_disabled(int cpu)
 {
@@ -175,7 +170,6 @@ static int r8a7779_cpu_disable(unsigned int cpu)
 #endif /* CONFIG_HOTPLUG_CPU */
 
 struct smp_operations r8a7779_smp_ops  __initdata = {
-	.smp_init_cpus		= r8a7779_smp_init_cpus,
 	.smp_prepare_cpus	= r8a7779_smp_prepare_cpus,
 	.smp_boot_secondary	= r8a7779_boot_secondary,
 #ifdef CONFIG_HOTPLUG_CPU
-- 
1.8.2.1

