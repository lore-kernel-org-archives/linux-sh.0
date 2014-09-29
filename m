From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Mon, 29 Sep 2014 05:05:55 +0000
Subject: [PATCH RFC v2 5/7] ARM: shmobile: Clear External Event Request in system resume
Message-Id: <5428E8B3.3090609@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to datasheet, this step is necessary when waking up
from L2shutdown mode.

Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
---
 arch/arm/mach-shmobile/platsmp-apmu.c |    2 ++
 arch/arm/mach-shmobile/pm-rcar.c      |   22 ++++++++++++++++++++++
 arch/arm/mach-shmobile/pm-rcar.h      |    1 +
 3 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index 5e4dcdb..ef146fa 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -26,6 +26,7 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 #include "common.h"
+#include "pm-rcar.h"
 
 static struct {
 	void __iomem *iomem;
@@ -244,6 +245,7 @@ static int shmobile_smp_apmu_enter_suspend(suspend_state_t state)
 	cpu_leave_lowpower();
 
 	writel_relaxed(0x0, cpucmcr);
+	rcar_sysc_clear_event_status();
 
 	return 0;
 }
diff --git a/arch/arm/mach-shmobile/pm-rcar.c b/arch/arm/mach-shmobile/pm-rcar.c
index 00022ee..9f4ec85 100644
--- a/arch/arm/mach-shmobile/pm-rcar.c
+++ b/arch/arm/mach-shmobile/pm-rcar.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 #include <linux/spinlock.h>
+#include <asm/cputype.h>
 #include <asm/io.h>
 #include "pm-rcar.h"
 
@@ -24,6 +25,10 @@
 #define PWROFFCR_OFFS 0x04
 #define PWRONCR_OFFS 0x0c
 #define PWRER_OFFS 0x14
+#define SYSCEERSR_OFFS  0x20
+#define SYSCEERSCR_OFFS 0x24
+#define SYSCEERSR2_OFFS  0x2C
+#define SYSCEERSCR2_OFFS 0x30
 
 #define SYSCSR_RETRIES 100
 #define SYSCSR_DELAY_US 1
@@ -34,6 +39,23 @@
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
 
+void rcar_sysc_clear_event_status(void)
+{
+	if (read_cpuid_part() = ARM_CPU_PART_CORTEX_A15) {
+		/* Clear External event status regiser */
+		iowrite32(0x111, rcar_sysc_base + SYSCEERSCR_OFFS);
+
+		pr_debug("%s: External event status: 0x%08x\n", __func__,
+			ioread32(rcar_sysc_base + SYSCEERSR_OFFS));
+	} else {
+		/* Clear External event status regiser */
+		iowrite32(0x111, rcar_sysc_base + SYSCEERSCR2_OFFS);
+
+		pr_debug("%s: External event status: 0x%08x\n", __func__,
+			ioread32(rcar_sysc_base + SYSCEERSR2_OFFS));
+	}
+}
+
 static int rcar_sysc_pwr_on_off(struct rcar_sysc_ch *sysc_ch,
 				int sr_bit, int reg_offs)
 {
diff --git a/arch/arm/mach-shmobile/pm-rcar.h b/arch/arm/mach-shmobile/pm-rcar.h
index ef3a1ef..1a349bf 100644
--- a/arch/arm/mach-shmobile/pm-rcar.h
+++ b/arch/arm/mach-shmobile/pm-rcar.h
@@ -11,5 +11,6 @@ int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
 int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
 bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
 void __iomem *rcar_sysc_init(phys_addr_t base);
+void rcar_sysc_clear_event_status(void);
 
 #endif /* PM_RCAR_H */
-- 
1.7.9.5
