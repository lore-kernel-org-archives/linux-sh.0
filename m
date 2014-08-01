From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Fri, 01 Aug 2014 09:48:23 +0000
Subject: [PATCH 1/6] ARM: shmobile: APMU: Move the shmobile_smp_hook call
Message-Id: <53DB6267.4030002@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net

shmobile_smp_hook() in shmobile_smp_apmu_do_suspend() is used in case
of Suspend to RAM sequence. So, This patch move shmobile_smp_hook() call
to shmobile_smp_apmu_enter_suspend() for Suspend to RAM.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 2c06810..ad6a383 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -227,7 +227,6 @@ int shmobile_smp_apmu_cpu_kill(unsigned int cpu)
 #if defined(CONFIG_SUSPEND)
 static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 {
-	shmobile_smp_hook(cpu, virt_to_phys(cpu_resume), 0);
 	shmobile_smp_apmu_cpu_shutdown(cpu);
 	cpu_do_idle(); /* WFI selects Core Standby */
 	return 1;
@@ -235,6 +234,7 @@ static int shmobile_smp_apmu_do_suspend(unsigned long cpu)

 static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 {
+	shmobile_smp_hook(smp_processor_id(), virt_to_phys(cpu_resume), 0);
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
 	cpu_leave_lowpower();
 	return 0;
-- 
1.7.9.5
