From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 10:39:20 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 DT IRQ prototype
Message-Id: <20120328103920.24945.11255.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This prototype patch extends the sh7372 DT support with actual
IRQ support. The heavy lifting is all done by the prototype patch
 "[PATCH] sh: INTC IRQ domain and DT support prototype".

It is worth noting that we have 3 root interrupt controllers on
sh7372 and to set the parent pointer to NULL we let the device
tree point to itself as interrupt-parent. Seems a bit overly
complex so perhaps it is not the right way forward.

All root interrupt controllers are using IRQ domains but their
allocation is kept the same as the non-DT case to allow us to
leave the demux code as-is without any modifications. So in
the DT case INTCA, IRQ16L and IRQ16H are kept at their original
IRQ positions. INTCS is allocated dynamically in case of DT
and at a fixed location as usual for non-DT boards.

Anyone that wants to play with DT with interrupts on sh7372
will need to include this patch. The INTC IRQ domain patch above
needs further work which will delay the merge.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 Dependencies are:
 [PATCH 00/06] mach-shmobile device tree preparation patches V2
 [PATCH] ARM: mach-shmobile: sh7372 generic board support via DT V2
 [PATCH] sh: INTC IRQ domain and DT support prototype
 
 arch/arm/boot/dts/sh7372.dtsi                |   28 +++++++
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/intc-sh7372.c         |   93 ++++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-sh7372.c        |    2 
 4 files changed, 116 insertions(+), 8 deletions(-)

--- 0008/arch/arm/boot/dts/sh7372.dtsi
+++ work/arch/arm/boot/dts/sh7372.dtsi	2012-03-28 17:35:24.000000000 +0900
@@ -18,4 +18,32 @@
 			compatible = "arm,cortex-a8";
 		};
 	};
+
+	intca: interrupt-controller@0 {
+		compatible = "renesas,intca-sh7372";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	irq16l: interrupt-controller@1 {
+		compatible = "renesas,intca-irq-lo-sh7372";
+		interrupt-parent = <&irq16l>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	irq16h: interrupt-controller@2 {
+		compatible = "renesas,intca-irq-hi-sh7372";
+		interrupt-parent = <&irq16h>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
+	intcs: interrupt-controller@3 {
+		compatible = "renesas,intcs-sh7372";
+		interrupt-parent = <&intca>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+
 };
--- 0002/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2012-03-28 17:26:37.000000000 +0900
@@ -35,6 +35,7 @@ extern struct clk sh7377_extalc1_clk;
 extern struct clk sh7377_extal2_clk;
 
 extern void sh7372_init_irq(void);
+extern void sh7372_init_irq_dt(void);
 extern void sh7372_map_io(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
--- 0007/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-03-28 17:26:37.000000000 +0900
@@ -21,8 +21,11 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/sh_intc.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
 #include <mach/intc.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -551,20 +554,15 @@ static void intcs_demux(unsigned int irq
 static void __iomem *intcs_ffd2;
 static void __iomem *intcs_ffd5;
 
-void __init sh7372_init_irq(void)
+static void __init sh7372_init_intcs(void)
 {
 	void __iomem *intevtsa;
 	int n;
 
+	/* ioremap() to allow suspend/resume */
 	intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
-	intevtsa = intcs_ffd2 + 0x100;
 	intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
 
-	register_intc_controller(&intca_desc);
-	register_intc_controller(&intca_irq_pins_lo_desc);
-	register_intc_controller(&intca_irq_pins_hi_desc);
-	register_intc_controller(&intcs_desc);
-
 	/* setup dummy cascade chip for INTCS */
 	n = evt2irq(0xf80);
 	irq_alloc_desc_at(n, numa_node_id());
@@ -573,6 +571,7 @@ void __init sh7372_init_irq(void)
 	set_irq_flags(n, IRQF_VALID); /* yuck */
 
 	/* demux using INTEVTSA */
+	intevtsa = intcs_ffd2 + 0x100;
 	irq_set_handler_data(n, (void *)intevtsa);
 	irq_set_chained_handler(n, intcs_demux);
 
@@ -580,6 +579,86 @@ void __init sh7372_init_irq(void)
 	iowrite16(0, intcs_ffd2 + 0x104);
 }
 
+#ifdef CONFIG_USE_OF
+
+static int __init intca_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	return register_intc_controller_dt(&intca_desc, node, parent, NULL);
+}
+
+static int __init irqhi_of_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return register_intc_controller_dt(&intca_irq_pins_hi_desc,
+					   node, parent, NULL);
+}
+
+static int __init irqlo_of_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return register_intc_controller_dt(&intca_irq_pins_lo_desc,
+					   node, parent, NULL);
+}
+
+static int intcs_irq_domain_dt_translate(struct irq_domain *d,
+					 struct device_node *controller,
+					 const u32 *intspec,
+					 unsigned int intsize,
+					 unsigned long *out_hwirq,
+					 unsigned int *out_type)
+{
+	if (d->of_node != controller)
+		return -EINVAL;
+
+	if (intsize < 1)
+		return -EINVAL;
+
+	*out_hwirq = intcs_evt2irq(intspec[0]);
+	*out_type = 0;
+	return 0;
+}
+
+const struct irq_domain_ops intcs_irq_domain_ops = {
+	.dt_translate = intcs_irq_domain_dt_translate,
+};
+
+static int __init intcs_of_init(struct device_node *node,
+				struct device_node *parent)
+{
+	int ret = register_intc_controller_dt(&intcs_desc, node, parent,
+					      &intcs_irq_domain_ops);
+	if (!ret)
+		sh7372_init_intcs();
+
+	return ret;
+}
+
+static const struct of_device_id sh7372_intc_of_match[] __initconst = {
+	{ .compatible = "renesas,intca-sh7372", .data = intca_of_init },
+	{ .compatible = "renesas,intca-irq-lo-sh7372", .data = irqlo_of_init },
+	{ .compatible = "renesas,intca-irq-hi-sh7372", .data = irqhi_of_init },
+	{ .compatible = "renesas,intcs-sh7372", .data = intcs_of_init },
+	{},
+};
+
+void __init sh7372_init_irq_dt(void)
+{
+	of_irq_init(sh7372_intc_of_match);
+}
+
+#endif /* CONFIG_USE_OF */
+
+void __init sh7372_init_irq(void)
+{
+	register_intc_controller(&intca_desc);
+	register_intc_controller(&intca_irq_pins_lo_desc);
+	register_intc_controller(&intca_irq_pins_hi_desc);
+
+	sh7372_init_intcs();
+	register_intc_controller(&intcs_desc);
+}
+
 static unsigned short ffd2[0x200];
 static unsigned short ffd5[0x100];
 
--- 0008/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2012-03-28 17:26:37.000000000 +0900
@@ -1122,7 +1122,7 @@ DT_MACHINE_START(SH7372_DT, "Generic SH7
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-	.init_irq	= sh7372_init_irq,
+	.init_irq	= sh7372_init_irq_dt,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= sh7372_add_standard_devices_dt,
 	.timer		= &shmobile_timer,
