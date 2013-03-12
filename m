From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Mar 2013 08:31:09 +0000
Subject: [PATCH 2/3 v2] ARM: shmobile: r8a7778 SCIF support
Message-Id: <87ehflrpdh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add SCIF serial port support to the r8a7778 SoC by
adding platform devices together with clock bindings.
DT device description is excluded at this point since
such bindings are still under development.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - SCIF was separated

 arch/arm/mach-shmobile/clock-r8a7778.c |   13 ++++
 arch/arm/mach-shmobile/setup-r8a7778.c |  109 ++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 387e3b7..f1277f4 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -58,16 +58,29 @@ static struct clk *main_clks[] = {
 };
 
 enum {
+	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP026] = SH_CLK_MSTP32(&clkp, MSTPCR0, 26, 0), /* SCIF0 */
+	[MSTP025] = SH_CLK_MSTP32(&clkp, MSTPCR0, 25, 0), /* SCIF1 */
+	[MSTP024] = SH_CLK_MSTP32(&clkp, MSTPCR0, 24, 0), /* SCIF2 */
+	[MSTP023] = SH_CLK_MSTP32(&clkp, MSTPCR0, 23, 0), /* SCIF3 */
+	[MSTP022] = SH_CLK_MSTP32(&clkp, MSTPCR0, 22, 0), /* SCIF4 */
+	[MSTP021] = SH_CLK_MSTP32(&clkp, MSTPCR0, 21, 0), /* SCIF5 */
 	[MSTP016] = SH_CLK_MSTP32(&clkp, MSTPCR0, 16, 0), /* TMU0 */
 	[MSTP015] = SH_CLK_MSTP32(&clkp, MSTPCR0, 15, 0), /* TMU1 */
 };
 
 static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
+	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
+	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
+	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
+	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
+	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP015]), /* TMU01 */
 };
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index d86a907..245aebc 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -25,6 +25,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/irqchip.h>
+#include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
 #include <mach/irqs.h>
 #include <mach/r8a7778.h>
@@ -32,6 +33,108 @@
 #include <asm/mach/arch.h>
 #include <asm/hardware/cache-l2x0.h>
 
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe40000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x66)),
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xffe41000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x67)),
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xffe42000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x68)),
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xffe43000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x69)),
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
+	},
+};
+
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase	= 0xffe44000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x6a)),
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id		= 4,
+	.dev		= {
+		.platform_data	= &scif4_platform_data,
+	},
+};
+
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase	= 0xffe45000,
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+	.type		= PORT_SCIF,
+	.irqs		= SCIx_IRQ_MUXED(gic_iid(0x6b)),
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+	},
+};
+
 /* TMU */
 static struct sh_timer_config tmu00_platform_data = {
 	.name = "TMU00",
@@ -94,6 +197,12 @@ static struct platform_device tmu01_device = {
 };
 
 static struct platform_device *r8a7778_devices_dt[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&tmu00_device,
 	&tmu01_device,
 };
-- 
1.7.9.5

