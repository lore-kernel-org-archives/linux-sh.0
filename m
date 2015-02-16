From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 16 Feb 2015 16:58:49 +0000
Subject: [PATCH v3 05/15] ARM: shmobile: r8a7778: implement SoC and board CCF support
Message-Id: <1424105939-4910-6-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Disables the legacy clock framework and passes the mode bits to the CPG
driver if CCF is enabled.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-bockw-reference.c |  2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c         | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index d649ade..9a74efd 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -36,7 +36,9 @@ static void __init bockw_init(void)
 	void __iomem *fpga;
 	void __iomem *pfc;
 
+#ifndef CONFIG_COMMON_CLK
 	r8a7778_clock_init();
+#endif
 	r8a7778_init_irq_extpin_dt(1);
 	r8a7778_add_dt_devices();
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index cef8895..c49aa09 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -15,6 +15,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk/shmobile.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/irqchip/arm-gic.h>
@@ -41,6 +42,21 @@
 #include "irqs.h"
 #include "r8a7778.h"
 
+#define MODEMR 0xffcc0020
+
+#ifdef CONFIG_COMMON_CLK
+static void __init r8a7778_timer_init(void)
+{
+	u32 mode;
+	void __iomem *modemr = ioremap_nocache(MODEMR, 4);
+
+	BUG_ON(!modemr);
+	mode = ioread32(modemr);
+	iounmap(modemr);
+	r8a7778_clocks_init(mode);
+}
+#endif
+
 /* SCIF */
 #define R8A7778_SCIF(index, baseaddr, irq)			\
 static struct plat_sci_port scif##index##_platform_data = {	\
@@ -608,6 +624,9 @@ DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
 	.init_late	= shmobile_init_late,
+#ifdef CONFIG_COMMON_CLK
+	.init_time	= r8a7778_timer_init,
+#endif
 	.dt_compat	= r8a7778_compat_dt,
 MACHINE_END
 
-- 
2.2.2

