From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 01 Oct 2013 02:35:41 +0000
Subject: [PATCH 09/14] ARM: shmobile: Let sh73a0 rely on SCU CPU notifier
Message-Id: <344bc8b0c85a63cd2d946376a391e74f4ea0ae46.1380532277.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380532277.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380532277.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CPU notifiers are used for SCU boot vector
setup shmobile_smp_scu_boot_secondary() is no longer
needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 9a30a3f..13ba36a 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -46,11 +46,6 @@ void __init sh73a0_register_twd(void)
 static int sh73a0_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned int lcpu = cpu_logical_map(cpu);
-	int ret;
-
-	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
-	if (ret)
-		return ret;
 
 	if (((__raw_readl(PSTR) >> (4 * lcpu)) & 3) = 3)
 		__raw_writel(1 << lcpu, WUPCR);	/* wake up */
-- 
1.8.4

