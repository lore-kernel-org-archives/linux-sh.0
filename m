From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 13:46:43 +0000
Subject: [PATCH 03/05] ARM: shmobile: Let EMEV2 rely on SCU CPU notifier
Message-Id: <20130914134643.19258.63415.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130914134616.19258.27110.sendpatchset@w520>
In-Reply-To: <20130914134616.19258.27110.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when CPU notifiers are used for SCU boot vector
setup shmobile_smp_scu_boot_secondary() is no longer
needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-emev2.c |    6 ------
 1 file changed, 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-09-14 19:34:45.000000000 +0900
@@ -34,12 +34,6 @@
 
 static int emev2_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	int ret;
-
-	ret = shmobile_smp_scu_boot_secondary(cpu, idle);
-	if (ret)
-		return ret;
-
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu_logical_map(cpu)));
 	return 0;
 }
