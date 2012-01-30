From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 30 Jan 2012 02:03:49 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 PSTR 32-bit access fix
Message-Id: <20120130020349.20367.65869.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the sh73a0 SMP code to use 32-bit PSTR access.

This fixes wakeup from deep sleep for sh73a0 secondary CPUs.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0009/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2012-01-26 14:37:04.000000000 +0900
@@ -84,7 +84,7 @@ int __cpuinit sh73a0_boot_secondary(unsi
 	/* enable cache coherency */
 	modify_scu_cpu_psr(cpu, 0);
 
-	if (((__raw_readw(__io(PSTR)) >> (4 * cpu)) & 3) = 3)
+	if (((__raw_readl(__io(PSTR)) >> (4 * cpu)) & 3) = 3)
 		__raw_writel(1 << cpu, __io(WUPCR));	/* wake up */
 	else
 		__raw_writel(1 << cpu, __io(SRESCR));	/* reset */
