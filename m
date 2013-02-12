From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 Feb 2013 15:45:06 +0000
Subject: [PATCH 03/06] ARM: shmobile: Move EMEV2 CPU boot vector setup code
Message-Id: <20130212154506.13067.19162.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130212154438.13067.77359.sendpatchset@w520>
In-Reply-To: <20130212154438.13067.77359.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the boot vector setup code for the EMEV2 SoC to match
the sh73a0 and r8a7779 implementations. With this in place
all SoC specific SMP implementations for mach-shmobile uses
the ->smp_prepare_cpus() callback to setup the boot vector.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on KZM9D hardware.

 arch/arm/mach-shmobile/smp-emev2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0006/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-02-12 23:57:31.000000000 +0900
@@ -74,9 +74,6 @@ static int __cpuinit emev2_boot_secondar
 	/* enable cache coherency */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 
-	/* Tell ROM loader about our vector (in headsmp.S) */
-	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
-
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 	return 0;
 }
@@ -87,6 +84,9 @@ static void __init emev2_smp_prepare_cpu
 
 	scu_enable(scu_base);
 
+	/* Tell ROM loader about our vector (in headsmp.S) */
+	emev2_set_boot_vector(__pa(shmobile_secondary_vector));
+
 	/* enable cache coherency on CPU0 */
 	modify_scu_cpu_psr(0, 3 << (cpu * 8));
 }
