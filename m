From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Dec 2011 08:21:45 +0000
Subject: [PATCH] ARM: mach-shmobile: r8a7779 SGX-over-UIO test code
Message-Id: <20111222082145.12151.31074.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This prototype code exports the SGX hardware block in r8a7779
to user space via UIO. Clocks are associated with the device
as well as a power domain. By adding a #define DEBUG in the
pm-r8a7779.c file it is possible to watch the power domain
going on and off when starting a user space UIO driver.

Submitted to the mailing list as a test bench.
Not for upstream merge.

Never-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the r8a7779 base plus the power domain code:
 [PATCH] ARM: mach-shmobile: r8a7779 power domain support

 Should be rebased on top of Morimoto-san's clock patches.

 arch/arm/mach-shmobile/clock-r8a7779.c |    6 +++++
 arch/arm/mach-shmobile/setup-r8a7779.c |   38 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

--- 0014/arch/arm/mach-shmobile/clock-r8a7779.c
+++ work/arch/arm/mach-shmobile/clock-r8a7779.c	2011-12-21 15:39:59.000000000 +0900
@@ -57,6 +57,7 @@ static struct clk *main_clks[] = {
 
 enum { MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015, MSTP014,
+       MSTP105, MSTP319,
 	MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -72,6 +73,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP016] = MSTP(&clkp, MSTPCR0, 16, 0), /* TMU0 */
 	[MSTP015] = MSTP(&clkp, MSTPCR0, 15, 0), /* TMU1 */
 	[MSTP014] = MSTP(&clkp, MSTPCR0, 14, 0), /* TMU2 */
+	[MSTP105] = MSTP(&clkp, MSTPCR1, 5, 0), /* SGX */
+	[MSTP319] = MSTP(&clkp, MSTPCR3, 19, 0), /* SGX */
 };
 
 static struct clk_lookup lookups[] = {
@@ -84,6 +87,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
+
+	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP105]), /* SGX */
+	CLKDEV_ICK_ID("scr", "uio_pdrv_genirq.0", &mstp_clks[MSTP319]),
 };
 
 void __init r8a7779_clock_init(void)
--- 0022/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2011-12-21 15:41:31.000000000 +0900
@@ -22,12 +22,14 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/uio_driver.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
+#include <linux/pm_clock.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -203,6 +205,38 @@ static struct platform_device tmu01_devi
 	.num_resources	= ARRAY_SIZE(tmu01_resources),
 };
 
+/* SGX */
+static struct uio_info sgx_platform_data = {
+	.name = "SGX",
+	.version = "0",
+	.irq = UIO_IRQ_NONE,
+};
+
+static struct resource sgx_resources[] = {
+	[0] = {
+		.name	= "SGX",
+		.start	= 0xfff12000,
+		.end	= 0xfff12fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= "SGX",
+		.start	= 0xfce00000,
+		.end	= 0xfcffffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device sgx_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &sgx_platform_data,
+	},
+	.resource	= sgx_resources,
+	.num_resources	= ARRAY_SIZE(sgx_resources),
+};
+
 static struct platform_device *r8a7779_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -215,6 +249,7 @@ static struct platform_device *r8a7779_e
 };
 
 static struct platform_device *r8a7779_late_devices[] __initdata = {
+	&sgx_device,
 };
 
 void __init r8a7779_add_standard_devices(void)
@@ -230,6 +265,9 @@ void __init r8a7779_add_standard_devices
 			    ARRAY_SIZE(r8a7779_early_devices));
 	platform_add_devices(r8a7779_late_devices,
 			    ARRAY_SIZE(r8a7779_late_devices));
+
+	r8a7779_add_device_to_domain(&r8a7779_sgx, &sgx_device);
+	pm_clk_add(&sgx_device.dev, "scr");
 }
 
 void __init r8a7779_add_early_devices(void)
