From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 26 Sep 2014 02:40:00 +0000
Subject: [PATCH RFC 2/7] ARM: shmobile: use signals from SYSC to wake up from Suspend-to-RAM
Message-Id: <5424D200.4050208@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Disable GIC CPU IF so system will only resume by permitted wakeup
signals via System Controller IP.
It improves low-power implementation and prepares for cluster powerdown
in future.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 21f8ddd..f6e4f0b 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/of_address.h>
 #include <linux/smp.h>
 #include <linux/suspend.h>
@@ -214,6 +215,13 @@ static int shmobile_smp_apmu_do_suspend(unsigned long cpu)
 #if defined(CONFIG_SUSPEND)
 static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 {
+	/*
+	 * Disable the CPU interface when a CPU core is entering L2
+	 * shutdown mode, that will help us to prevent spurious CPU
+	 * wakeup to happen upon WFI execution.
+	 */
+	gic_cpu_if_down();
+
 	shmobile_smp_hook(smp_processor_id(), virt_to_phys(cpu_resume), 0);
 	cpu_suspend(smp_processor_id(), shmobile_smp_apmu_do_suspend);
 	cpu_leave_lowpower();
-- 
1.7.9.5
