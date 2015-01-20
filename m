From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 20 Jan 2015 11:38:00 +0000
Subject: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <20150120113800.11062.65299.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
domain."), the APE6EVM legacy board support is know to be broken.

The IRQ numbers of the GIC are now virtual, and no longer match the
hardcoded hardware IRQ numbers in the platform board code.

To fix this, instantiate the GIC from platform board code when compiling
a legacy kernel, like is done for the sh73a0, r8a7740, r8a7778 and r8a7779
legacy code.

Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
thanks to him for the initial work.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20150119-v3.19-rc5

 Untested due to lack of working hardware, testing needed.

 arch/arm/mach-shmobile/board-ape6evm.c |    1 +
 arch/arm/mach-shmobile/r8a73a4.h       |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c |   10 ++++++++++
 3 files changed, 12 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-ape6evm.c
+++ work/arch/arm/mach-shmobile/board-ape6evm.c	2015-01-20 18:49:50.087786672 +0900
@@ -280,6 +280,7 @@ static const char *ape6evm_boards_compat
 
 DT_MACHINE_START(APE6EVM_DT, "ape6evm")
 	.init_early	= shmobile_init_delay,
+	.init_irq	= r8a73a4_init_irq,
 	.init_machine	= ape6evm_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= ape6evm_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/r8a73a4.h
+++ work/arch/arm/mach-shmobile/r8a73a4.h	2015-01-20 18:43:29.027788042 +0900
@@ -10,6 +10,7 @@ enum {
 	SHDMA_SLAVE_MMCIF1_RX,
 };
 
+void r8a73a4_init_irq(void);
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
--- 0001/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ work/arch/arm/mach-shmobile/setup-r8a73a4.c	2015-01-20 18:48:16.427787009 +0900
@@ -14,6 +14,8 @@
  * GNU General Public License for more details.
  */
 #include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
@@ -286,6 +288,14 @@ void __init r8a73a4_add_standard_devices
 	r8a73a4_register_dmac();
 }
 
+void __init r8a73a4_init_irq(void)
+{
+	void __iomem *gic_dist_base = IOMEM(0xf1001000);
+	void __iomem *gic_cpu_base = IOMEM(0xf1002000);
+
+	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+}
+
 #ifdef CONFIG_USE_OF
 
 static const char *r8a73a4_boards_compat_dt[] __initdata = {
