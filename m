From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 09 Apr 2014 11:04:44 +0000
Subject: [RFC] ARM: shmobile: minimal r8a7740 common clock framework implementation
Message-Id: <1397041484-12552-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This CCF implementation brings up the timer and serial console clocks and
all direct and indirect parents. (Ethernet also happens to work because
the bootloader leaves it on.)

This is closely modeled after the r8a779x implementation, so I hope it
makes some sense. (Please ignore the build system hacks for now.)

The clock initialization call has moved from r8a7740_generic_init()/
eva_init() to r8a7740_init_delay() to make sure the flags are set correctly
before the implicit OF clock initialization happens.

I wonder if it would make sense to eliminate r8a7740_clocks_init()
entirely and put the mode switch parsing in clk-r8a7740.c...

CU
Uli
---
 arch/arm/boot/dts/r8a7740.dtsi                     |  79 ++++++++++++
 arch/arm/mach-shmobile/Kconfig                     |   2 +-
 .../board-armadillo800eva-reference.c              |  10 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |   3 +-
 drivers/clk/Makefile                               |   1 +
 drivers/clk/shmobile/Makefile                      |   2 +
 drivers/clk/shmobile/clk-r8a7740.c                 | 143 +++++++++++++++++++++
 drivers/sh/Makefile                                |   2 +-
 include/dt-bindings/clock/r8a7740-clock.h          |  61 +++++++++
 9 files changed, 297 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/shmobile/clk-r8a7740.c
 create mode 100644 include/dt-bindings/clock/r8a7740-clock.h

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 9f65986..37babce 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -10,6 +10,7 @@
 
 /include/ "skeleton.dtsi"
 
+#include <dt-bindings/clock/r8a7740-clock.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -226,4 +227,82 @@
 		interrupts = <0 9 0x4>;
 		status = "disabled";
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		/* External root clock */
+		extalr_clk: extalr_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "extalr";
+		};
+		extal1_clk: extal1_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <25000000>;
+			clock-output-names = "extal1";
+		};
+		extal2_clk: extal2_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+			clock-output-names = "extal2";
+		};
+		/* Special CPG clocks */
+		cpg_clocks: cpg_clocks@e6150000 {
+			compatible = "renesas,r8a7740-cpg-clocks";
+			reg = <0xe6150000 0x10000>;
+			clocks = <&extal1_clk>, <&extalr_clk>;
+			#clock-cells = <1>;
+			clock-output-names = "system", "pllc0", "pllc1",
+					     "pllc2", "r";
+		};
+
+		/* Variable factor clocks (DIV6) */
+		sub_clk: sub_clk@e6150080 {
+			compatible = "renesas,r8a7740-div6-clock", "renesas,cpg-div6-clock";
+			reg = <0xe6150080 4>;
+			clocks = <&pllc1_div2_clk>;
+			#clock-cells = <0>;
+			clock-output-names = "sub";
+		};
+
+		/* Fixed factor clocks */
+		pllc1_div2_clk: pllc1_div2_clk {
+			compatible = "fixed-factor-clock";
+			clocks = <&cpg_clocks R8A7740_CLK_PLLC1>;
+			#clock-cells = <0>;
+			clock-div = <2>;
+			clock-mult = <1>;
+			clock-output-names = "pllc1_div2";
+		};
+
+		/* Gate clocks */
+		mstp2_clks: mstp2_clks@e6150138 {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe6150138 4>, <0xe6150040 4>;
+			clocks = <&sub_clk>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_SCIFA1
+			>;
+			clock-output-names +				"scifa1";
+		};
+		mstp3_clks: mstp3_clks@e615013c {
+			compatible = "renesas,r8a7740-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0xe615013c 4>, <0xe6150048 4>;
+			clocks = <&cpg_clocks R8A7740_CLK_R>;
+			#clock-cells = <1>;
+			renesas,clock-indices = <
+				R8A7740_CLK_CMT10
+			>;
+			clock-output-names +				"cmt10";
+		};
+	};
 };
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 75ccebf..94a3948 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -91,7 +91,7 @@ config ARCH_R8A7740
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CPU_V7
-	select SH_CLK_CPG
+	select COMMON_CLK
 	select RENESAS_INTC_IRQPIN
 
 config ARCH_R8A7778
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d1a78..e725cf5 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -24,6 +24,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <linux/io.h>
+#include <mach/clock.h>
 #include <mach/common.h>
 #include <mach/r8a7740.h>
 #include <asm/mach/arch.h>
@@ -153,20 +154,23 @@ clock_error:
 		clk_put(fsibck);
 }
 
+static const struct clk_name clk_names[] __initconst = {
+	{ "cmt10", NULL, "sh_cmt.10" },
+	{ "scifa1", NULL, "sh-sci.1" },
+};
+
 /*
  * board init
  */
 static void __init eva_init(void)
 {
-	r8a7740_clock_init(MD_CK0 | MD_CK2);
-	eva_clock_init();
-
 	r8a7740_meram_workaround();
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
 	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
+	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 
 	r8a7740_add_standard_devices_dt();
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8f3c681..1bde7f7 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -887,8 +887,10 @@ void __init r8a7740_add_standard_devices_dt(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+extern void __init r8a7740_clocks_init(u32 mode);
 void __init r8a7740_init_delay(void)
 {
+	r8a7740_clocks_init(MD_CK0 | MD_CK2);
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
 };
 
@@ -924,7 +926,6 @@ void __init r8a7740_init_irq_of(void)
 
 static void __init r8a7740_generic_init(void)
 {
-	r8a7740_clock_init(0);
 	r8a7740_add_standard_devices_dt();
 }
 
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a367a98..9a11312 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ARCH_MXS)			+= mxs/
 obj-$(CONFIG_COMMON_CLK_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_PLAT_SAMSUNG)		+= samsung/
+obj-$(CONFIG_ARCH_R8A7740)		+= shmobile/
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= shmobile/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 9ecef14..a6973f9 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -1,7 +1,9 @@
 obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
 obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
+obj-$(CONFIG_ARCH_R8A7740)	+= clk-mstp.o clk-div6.o
 # for emply built-in.o
 obj-n	:= dummy
diff --git a/drivers/clk/shmobile/clk-r8a7740.c b/drivers/clk/shmobile/clk-r8a7740.c
new file mode 100644
index 0000000..4d9dcba
--- /dev/null
+++ b/drivers/clk/shmobile/clk-r8a7740.c
@@ -0,0 +1,143 @@
+/*
+ * r8a7740 Core CPG Clocks
+ *
+ * Copyright (C) 2014  Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/clk/shmobile.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/spinlock.h>
+#include <mach/r8a7740.h>
+
+struct r8a7740_cpg {
+	struct clk_onecell_data data;
+	spinlock_t lock;
+	void __iomem *reg;
+};
+
+#define CPG_FRQCRA			0
+#define CPG_FRQCRC			0xe0
+#define CPG_PLLC01CR			0x28
+
+struct cpg_pll_config {
+};
+
+static u32 cpg_mode __initdata;
+
+static struct clk * __init
+r8a7740_cpg_register_clock(struct device_node *np, struct r8a7740_cpg *cpg,
+			     const struct cpg_pll_config *config,
+			     const char *name)
+{
+	const char *parent_name;
+	unsigned int mult = 1;
+	unsigned int div = 1;
+
+	if (!strcmp(name, "r")) {
+		switch (cpg_mode & (MD_CK2 | MD_CK1)) {
+		case MD_CK1 | MD_CK2:
+			parent_name = of_clk_get_parent_name(np, 0);
+			div = 2048;
+			break;
+		case MD_CK2:
+			parent_name = of_clk_get_parent_name(np, 0);
+			div = 1024;
+			break;
+		default:
+			parent_name = of_clk_get_parent_name(np, 1);
+			break;
+		}
+	} else if (!strcmp(name, "system")) {
+		parent_name = of_clk_get_parent_name(np, 0);
+		if (cpg_mode & MD_CK1)
+			div = 2;
+	} else if (!strcmp(name, "pllc0")) {
+		/* PLLC0/1 are configurable multiplier clocks. Register them as
+		 * fixed factor clocks for now as there's no generic multiplier
+		 * clock implementation and we currently have no need to change
+		 * the multiplier value.
+		 */
+		u32 value = clk_readl(cpg->reg + CPG_FRQCRC);
+		parent_name = "system";
+		mult = ((value >> 24) & 0x7f) + 1;
+	} else if (!strcmp(name, "pllc1")) {
+		u32 value = clk_readl(cpg->reg + CPG_FRQCRA);
+		parent_name = "system";
+		mult = ((value >> 24) & 0x7f) + 1;
+		div = 2;
+	} else {
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk_register_fixed_factor(NULL, name, parent_name, 0,
+					 mult, div);
+}
+
+static void __init r8a7740_cpg_clocks_init(struct device_node *np)
+{
+	const struct cpg_pll_config *config;
+	struct r8a7740_cpg *cpg;
+	struct clk **clks;
+	unsigned int i;
+	int num_clks;
+
+	num_clks = of_property_count_strings(np, "clock-output-names");
+	if (num_clks < 0) {
+		pr_err("%s: failed to count clocks\n", __func__);
+		return;
+	}
+
+	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
+	clks = kzalloc(num_clks * sizeof(*clks), GFP_KERNEL);
+	if (cpg = NULL || clks = NULL) {
+		/* We're leaking memory on purpose, there's no point in cleaning
+		 * up as the system won't boot anyway.
+		 */
+		pr_err("%s: failed to allocate cpg\n", __func__);
+		return;
+	}
+
+	spin_lock_init(&cpg->lock);
+
+	cpg->data.clks = clks;
+	cpg->data.clk_num = num_clks;
+
+	cpg->reg = of_iomap(np, 0);
+	if (WARN_ON(cpg->reg = NULL))
+		return;
+
+	for (i = 0; i < num_clks; ++i) {
+		const char *name;
+		struct clk *clk;
+
+		of_property_read_string_index(np, "clock-output-names", i,
+					      &name);
+
+		clk = r8a7740_cpg_register_clock(np, cpg, config, name);
+
+		if (IS_ERR(clk))
+			pr_err("%s: failed to register %s %s clock (%ld)\n",
+			       __func__, np->name, name, PTR_ERR(clk));
+		else
+			cpg->data.clks[i] = clk;
+	}
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+}
+CLK_OF_DECLARE(r8a7740_cpg_clks, "renesas,r8a7740-cpg-clocks",
+	       r8a7740_cpg_clocks_init);
+
+void __init r8a7740_clocks_init(u32 mode)
+{
+	cpg_mode = mode;
+}
diff --git a/drivers/sh/Makefile b/drivers/sh/Makefile
index fc67f56..4e5ccca 100644
--- a/drivers/sh/Makefile
+++ b/drivers/sh/Makefile
@@ -3,7 +3,7 @@
 #
 obj-y	:= intc/
 
-obj-$(CONFIG_HAVE_CLK)		+= clk/
+#obj-$(CONFIG_HAVE_CLK)		+= clk/
 obj-$(CONFIG_MAPLE)		+= maple/
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 
diff --git a/include/dt-bindings/clock/r8a7740-clock.h b/include/dt-bindings/clock/r8a7740-clock.h
new file mode 100644
index 0000000..c71ca26
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7740-clock.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright 2014 Ulrich Hecht
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7740_H__
+#define __DT_BINDINGS_CLOCK_R8A7740_H__
+
+/* CPG */
+#define R8A7740_CLK_SYSTEM	0
+#define R8A7740_CLK_PLLC0	1
+#define R8A7740_CLK_PLLC1	2
+#define R8A7740_CLK_PLLC2	3
+#define R8A7740_CLK_R		4
+
+/* MSTP1 */
+#define R8A7740_CLK_CEU21	28
+#define R8A7740_CLK_CEU20	27
+#define R8A7740_CLK_TMU0	25
+#define R8A7740_CLK_LCDC1	17
+#define R8A7740_CLK_IIC0	16
+#define R8A7740_CLK_TMU1	11
+#define R8A7740_CLK_LCDC0	0
+
+/* MSTP2 */
+#define R8A7740_CLK_SCIFA6	30
+#define R8A7740_CLK_SCIFA7	22
+#define R8A7740_CLK_DMAC1	18
+#define R8A7740_CLK_DMAC2	17
+#define R8A7740_CLK_DMAC3	16
+#define R8A7740_CLK_USBDMAC	14
+#define R8A7740_CLK_SCIFA5	7
+#define R8A7740_CLK_SCIFB	6
+#define R8A7740_CLK_SCIFA0	4
+#define R8A7740_CLK_SCIFA1	3
+#define R8A7740_CLK_SCIFA2	2
+#define R8A7740_CLK_SCIFA3	1
+#define R8A7740_CLK_SCIFA4	0
+
+/* MSTP3 */
+#define R8A7740_CLK_CMT10	29
+#define R8A7740_CLK_FSI		28
+#define R8A7740_CLK_IIC1	23
+#define R8A7740_CLK_USBF	20
+#define R8A7740_CLK_SDHI0	14
+#define R8A7740_CLK_SDHI1	13
+#define R8A7740_CLK_MMC		12
+#define R8A7740_CLK_GETHER	9
+#define R8A7740_CLK_TPU0	4
+
+/* MSTP4 */
+#define R8A7740_CLK_USBHOST	16
+#define R8A7740_CLK_SDHI2	15
+#define R8A7740_CLK_USBFUNC	7
+#define R8A7740_CLK_USBPHY	6
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7740_H__ */
-- 
1.8.4.5

