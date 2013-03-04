From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 04 Mar 2013 07:18:32 +0000
Subject: [PATCH 1/5] ARM: shmobile: add R8A7778 setup support
Message-Id: <87wqtnpr97.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

based on v1.0 datasheet

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig                |    6 +
 arch/arm/mach-shmobile/Makefile               |    1 +
 arch/arm/mach-shmobile/include/mach/common.h  |    5 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    4 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |  284 +++++++++++++++++++++++++
 5 files changed, 300 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/include/mach/r8a7778.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7778.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ab2bb71..6150cd8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -23,6 +23,12 @@ config ARCH_R8A7740
 	select CPU_V7
 	select SH_CLK_CPG
 
+config ARCH_R8A7778
+	bool "R-Car M1 (R8A77780)"
+	select CPU_V7
+	select SH_CLK_CPG
+	select ARM_GIC
+
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index c621edf..d866f30 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -9,6 +9,7 @@ obj-y				:= timer.o console.o clock.o
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7372.o intc-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o clock-r8a7740.o intc-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o clock-r8a7779.o intc-r8a7779.o
 obj-$(CONFIG_ARCH_EMEV2)	+= setup-emev2.o clock-emev2.o
 
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 1ca1ad9..23b1d4f 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -58,6 +58,11 @@ extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
+extern void r8a7778_add_early_devices(void);
+extern void r8a7778_earlytimer_init(void);
+extern void r8a7778_add_standard_devices(void);
+extern void r8a7778_map_io(void);
+
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq(void);
 extern void r8a7779_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
new file mode 100644
index 0000000..5f5c2f8
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -0,0 +1,4 @@
+#ifndef __ASM_R8A7778_H__
+#define __ASM_R8A7778_H__
+
+#endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
new file mode 100644
index 0000000..639a0a8
--- /dev/null
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -0,0 +1,284 @@
+/*
+ * r8a7778 processor support
+ *
+ * Copyright (C) 2013  Renesas Solutions Corp.
+ * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * based on r8a7779
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/io.h>
+#include <linux/serial_sci.h>
+#include <linux/sh_intc.h>
+#include <linux/sh_timer.h>
+#include <mach/hardware.h>
+#include <mach/irqs.h>
+#include <mach/r8a7778.h>
+#include <mach/common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/mach/map.h>
+#include <asm/hardware/cache-l2x0.h>
+
+static struct map_desc r8a7778_io_desc[] __initdata = {
+	/* 2M entity map for 0xf0000000 (MPCORE) */
+	{
+		.virtual	= 0xf0000000,
+		.pfn		= __phys_to_pfn(0xf0000000),
+		.length		= SZ_2M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+	/* 16M entity map for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
+	{
+		.virtual	= 0xfe000000,
+		.pfn		= __phys_to_pfn(0xfe000000),
+		.length		= SZ_16M,
+		.type		= MT_DEVICE_NONSHARED
+	},
+};
+
+void __init r8a7778_map_io(void)
+{
+	iotable_init(r8a7778_io_desc, ARRAY_SIZE(r8a7778_io_desc));
+}
+
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
+/* TMU */
+static struct sh_timer_config tmu00_platform_data = {
+	.name = "TMU00",
+	.channel_offset = 0x4,
+	.timer_bit = 0,
+	.clockevent_rating = 200,
+};
+
+static struct resource tmu00_resources[] = {
+	[0] = {
+		.name	= "TMU00",
+		.start	= 0xffd80008,
+		.end	= 0xffd80013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x40),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu00_device = {
+	.name		= "sh_tmu",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &tmu00_platform_data,
+	},
+	.resource	= tmu00_resources,
+	.num_resources	= ARRAY_SIZE(tmu00_resources),
+};
+
+static struct sh_timer_config tmu01_platform_data = {
+	.name = "TMU01",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu01_resources[] = {
+	[0] = {
+		.name	= "TMU01",
+		.start	= 0xffd80014,
+		.end	= 0xffd8001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x41),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu01_device = {
+	.name		= "sh_tmu",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &tmu01_platform_data,
+	},
+	.resource	= tmu01_resources,
+	.num_resources	= ARRAY_SIZE(tmu01_resources),
+};
+
+static struct platform_device *r8a7778_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&tmu00_device,
+	&tmu01_device,
+};
+
+static struct platform_device *r8a7778_late_devices[] __initdata = {
+};
+
+void __init r8a7778_add_standard_devices(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
+	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
+#endif
+
+	platform_add_devices(r8a7778_early_devices,
+			    ARRAY_SIZE(r8a7778_early_devices));
+	platform_add_devices(r8a7778_late_devices,
+			    ARRAY_SIZE(r8a7778_late_devices));
+}
+
+void __init r8a7778_earlytimer_init(void)
+{
+	r8a7778_clock_init();
+	shmobile_earlytimer_init();
+}
+
+void __init r8a7778_add_early_devices(void)
+{
+	early_platform_add_devices(r8a7778_early_devices,
+				   ARRAY_SIZE(r8a7778_early_devices));
+
+	/* Early serial console setup is not included here due to
+	 * memory map collisions. The SCIF serial ports in r8a7778
+	 * are difficult to entity map 1:1 due to collision with the
+	 * virtual memory range used by the coherent DMA code on ARM.
+	 *
+	 * Anyone wanting to debug early can remove UPF_IOREMAP from
+	 * the sh-sci serial console platform data, adjust mapbase
+	 * to a static M:N virt:phys mapping that needs to be added to
+	 * the mappings passed with iotable_init() above.
+	 *
+	 * Then add a call to shmobile_setup_console() from this function.
+	 *
+	 * As a final step pass earlyprint=sh-sci.0,115200 on the kernel
+	 * command line in case of the board.
+	 */
+}
-- 
1.7.9.5

