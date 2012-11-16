From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Nov 2012 10:35:05 +0000
Subject: [PATCH 04/04] ARM: mach-shmobile: sh7372 INTC DT consolidation
Message-Id: <20121116103505.4231.6259.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Rework the sh7372 DT INTC setup code to only make use of
"renesas,sh_intc" instead of using zillions of special cases.

In the future the INTC DT code really wants to be moved to a
separate file that can be shared between multiple SoCs using
INTC as primary interrupt controller like for instance sh7372
and r8a7740.

The major ugly portion left is the intevtsa stuff that really
should be updated to make use of the parent interrupt controller
information in DT. intc_of_init() can be extended to install
the chained interrupt handler directly if the function call to
of_sh_intc_get_intevtsa_vect() succeeds.

When all SoCs are reworked like sh7372 then we can share the
SoC INTC DT code in one place and after that remove unused stuff
from of_intc.c like the following functions:
 - of_sh_intc_get_meminfo()
 - of_sh_intc_get_pint()
 - of_sh_intc_get_intc_pins()

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the devel/of branch of
 git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

 arch/arm/boot/dts/sh7372.dtsi        |    8 -
 arch/arm/mach-shmobile/intc-sh7372.c |  186 ++++++++--------------------------
 drivers/sh/intc/of_intc.c            |    8 -
 3 files changed, 55 insertions(+), 147 deletions(-)

--- 0001/arch/arm/boot/dts/sh7372.dtsi
+++ work/arch/arm/boot/dts/sh7372.dtsi	2012-11-16 18:37:54.000000000 +0900
@@ -26,7 +26,7 @@
 		ranges;
 
 		intca: interrupt-controller@0 {
-			compatible = "renesas,sh_intca";
+			compatible = "renesas,sh_intc";
 			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -583,7 +583,7 @@
 		};
 
 		intcs: interrupt-controller@1 {
-			compatible = "renesas,sh_intcs";
+			compatible = "renesas,sh_intc";
 			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -939,7 +939,7 @@
 		};
 
 		intca_irq_pins_lo: interrupt-controller@2 {
-			compatible = "renesas,sh_intca_irq_pins_lo";
+			compatible = "renesas,sh_intc";
 			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1048,7 +1048,7 @@
 		};
 
 		intca_irq_pins_hi: interrupt-controller@3 {
-			compatible = "renesas,sh_intca_irq_pins_hi";
+			compatible = "renesas,sh_intc";
 			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <1>;
--- 0005/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-11-16 18:37:54.000000000 +0900
@@ -28,137 +28,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#ifdef CONFIG_OF
-
-static struct intc_desc intca_desc __initdata;
-static struct resource intca_resources[2] __initdata;
-static struct intc_desc intcs_desc __initdata;
-static struct resource intcs_resources[2] __initdata;
-static struct intc_desc intca_irq_pins_lo_desc __initdata;
-static struct resource intca_pins_lo_resources[1] __initdata;
-static struct intc_desc intca_irq_pins_hi_desc __initdata;
-static struct resource intca_pins_hi_resources[1] __initdata;
-static unsigned short intevtsa_vect;
-
-static int __init sh7372_intca_of_init(struct device_node *np,
-			struct device_node *parent)
-{
-	int ret;
-
-	if (WARN_ON(!np))
-		return -ENODEV;
-
-	ret = of_sh_intc_get_meminfo(np,
-				intca_resources, ARRAY_SIZE(intca_resources));
-	if (ret)
-		goto error;
-
-	intca_desc.resource = intca_resources;
-	intca_desc.num_resources = ARRAY_SIZE(intca_resources);
-
-	ret = of_sh_intc_get_intc(np, &intca_desc);
-	if (ret)
-		goto error;
-
-	intca_desc.name = "sh7372-intca";
-error:
-	return ret;
-}
-
-static int __init sh7372_intcs_of_init(struct device_node *np,
-			struct device_node *parent)
-{
-	int ret;
-
-	if (WARN_ON(!np))
-		return -ENODEV;
-
-	ret = of_sh_intc_get_meminfo(np,
-				intcs_resources, ARRAY_SIZE(intcs_resources));
-	if (ret)
-		goto error;
-
-	intcs_desc.resource = intcs_resources;
-	intcs_desc.num_resources = ARRAY_SIZE(intcs_resources);
-
-	ret = of_sh_intc_get_intc(np, &intcs_desc);
-	if (ret)
-		goto error;
-
-	of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
-
-	intcs_desc.name = "sh7372-intcs";
-
-error:
-	return ret;
-}
-
-static int __init sh7372_intca_pins_lo_of_init(struct device_node *np,
-				    struct device_node *parent)
-{
-	int ret;
-
-	if (WARN_ON(!np))
-		return -ENODEV;
-
-	ret = of_sh_intc_get_meminfo(np, intca_pins_lo_resources,
-			ARRAY_SIZE(intca_pins_lo_resources));
-	if (ret)
-		goto error;
-
-	intca_irq_pins_lo_desc.resource = intca_pins_lo_resources;
-	intca_irq_pins_lo_desc.num_resources
-			= ARRAY_SIZE(intca_pins_lo_resources);
-
-	ret = of_sh_intc_get_intc_pins(np, &intca_irq_pins_lo_desc);
-	if (ret)
-		goto error;
-
-	intca_irq_pins_lo_desc.name = "sh7372-intca-irq-lo";
-
-error:
-	return ret;
-}
-
-static int __init sh7372_intca_pins_hi_of_init(struct device_node *np,
-				    struct device_node *parent)
-{
-	int ret;
-
-	if (WARN_ON(!np))
-		return -ENODEV;
-
-	ret = of_sh_intc_get_meminfo(np, intca_pins_hi_resources,
-			ARRAY_SIZE(intca_pins_hi_resources));
-	if (ret)
-		goto error;
-
-	intca_irq_pins_hi_desc.resource = intca_pins_hi_resources;
-	intca_irq_pins_hi_desc.num_resources
-			= ARRAY_SIZE(intca_pins_hi_resources);
-
-	ret = of_sh_intc_get_intc_pins(np, &intca_irq_pins_hi_desc);
-	if (ret)
-		goto error;
-
-	intca_irq_pins_hi_desc.name = "sh7372-intca-irq-hi";
-
-error:
-	return ret;
-}
-
-static const struct of_device_id irq_of_match[] __initconst = {
-	{ .compatible = "renesas,sh_intcs", .data = sh7372_intcs_of_init },
-	{ .compatible = "renesas,sh_intca_irq_pins_lo",
-		.data = sh7372_intca_pins_lo_of_init },
-	{ .compatible = "renesas,sh_intca_irq_pins_hi",
-		.data = sh7372_intca_pins_hi_of_init },
-	{ .compatible = "renesas,sh_intca", .data = sh7372_intca_of_init },
-	{ /*sentinel*/ }
-};
-
-#endif /* CONFIG_OF */
-
 enum {
 	UNUSED_INTCA = 0,
 
@@ -694,11 +563,6 @@ static void __init sh7372_init_intc(reso
 	void __iomem *intevtsa;
 	int n;
 
-	register_intc_controller(&intca_desc);
-	register_intc_controller(&intca_irq_pins_lo_desc);
-	register_intc_controller(&intca_irq_pins_hi_desc);
-	register_intc_controller(&intcs_desc);
-
 	intca_e694 = IOMEM(intca0_start);
 	intca_e695 = IOMEM(intca1_start);
 
@@ -723,18 +587,62 @@ static void __init sh7372_init_intc(reso
 }
 
 #ifdef CONFIG_OF
+static unsigned short intevtsa_vect;
+
+#define INTC_RES_MAX 2
+static struct {
+	struct intc_desc intc_desc;
+	struct resource intc_res[INTC_RES_MAX];
+} intc_data __initdata;
+
+static int __init intc_of_init(struct device_node *np,
+			       struct device_node *parent)
+{
+	int ret, i;
+
+	memset(&intc_data, 0, sizeof(intc_data));
+
+	for (i = 0; i < INTC_RES_MAX; i++) {
+		ret = of_address_to_resource(np, i, &intc_data.intc_res[i]);
+		if (ret < 0)
+			break;
+	}
+
+	intc_data.intc_desc.name = (char *)of_node_full_name(np);
+	intc_data.intc_desc.resource = intc_data.intc_res;
+	intc_data.intc_desc.num_resources = i;
+
+	ret = of_sh_intc_get_intc(np, &intc_data.intc_desc);
+	if (ret)
+		return ret;
+
+	of_sh_intc_get_intevtsa_vect(np, &intevtsa_vect);
+
+	register_intc_controller(&intc_data.intc_desc);
+	return 0;
+}
+
+static const struct of_device_id irq_of_match[] __initconst = {
+	{ .compatible = "renesas,sh_intc", .data = intc_of_init },
+	{ /*sentinel*/ }
+};
+
 void __init sh7372_init_irq_of(void)
 {
 	of_irq_init(irq_of_match);
 
-	sh7372_init_intc(intca_resources[0].start, intca_resources[1].start,
-			  intcs_resources[0].start, intcs_resources[1].start,
+	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000,
 			  intevtsa_vect);
 }
-#endif
+#endif /* CONFIG_OF */
 
 void __init sh7372_init_irq(void)
 {
+	register_intc_controller(&intca_desc);
+	register_intc_controller(&intca_irq_pins_lo_desc);
+	register_intc_controller(&intca_irq_pins_hi_desc);
+	register_intc_controller(&intcs_desc);
+
 	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000, 0xf80);
 }
 
--- 0001/drivers/sh/intc/of_intc.c
+++ work/drivers/sh/intc/of_intc.c	2012-11-16 18:37:54.000000000 +0900
@@ -470,7 +470,6 @@ int __init of_sh_intc_get_intevtsa_vect(
 
 	node = of_find_node_by_name(np, "intc_intevtsa");
 	if (!node) {
-		pr_err("intc_intevtsa table not found\n");
 		return -ENOENT;
 	}
 
@@ -580,9 +579,10 @@ int __init of_sh_intc_get_intc(struct de
 	if (ret)
 		return ret;
 
-	ret = of_sh_intc_get_group(np,  &d->hw.groups,
+	ret = of_sh_intc_get_group(np, &d->hw.groups,
 				&d->hw.nr_groups);
-	if (ret)
+	/* INTC may not need groups. */
+	if (ret && ret != -ENOENT)
 		return ret;
 
 	ret = of_sh_intc_get_mask(np, &d->hw.mask_regs,
@@ -597,7 +597,7 @@ int __init of_sh_intc_get_intc(struct de
 
 	ret = of_sh_intc_get_sense(np, &d->hw.sense_regs,
 				&d->hw.nr_sense_regs);
-	/* INTC may not need Sence register. */
+	/* INTC may not need Sense register. */
 	if (ret && ret != -ENOENT)
 		return ret;
 
