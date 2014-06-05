From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:15:53 +0000
Subject: [PATCH 06/08] ARM: shmobile: Setup APMU for suspend in non-SMP case
Message-Id: <20140605051553.18075.47511.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the APMU specific Suspend-to-RAM code to initialize
the APMU when SMP is disabled in the kernel config.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/platsmp-apmu.c |    4 ++++
 1 file changed, 4 insertions(+)

--- 0006/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-06-05 12:52:50.000000000 +0900
@@ -242,6 +242,10 @@ static int shmobile_smp_apmu_enter_suspe
 
 void __init shmobile_smp_apmu_suspend_init(void)
 {
+#ifndef CONFIG_SMP
+	/* initialize APMU for non-SMP case */
+	shmobile_smp_apmu_prepare_cpus(1);
+#endif
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
 #else
