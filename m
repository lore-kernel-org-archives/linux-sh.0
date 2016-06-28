From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 28 Jun 2016 06:36:34 +0000
Subject: [PATCH v3 18/19] sh: IO-DATA HDL-U (a,k.a landisk) support
Message-Id: <1467095795-5082-19-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../interrupt-controller/iodata-landisk.txt        | 34 ++++++++++
 arch/sh/boot/dts/Makefile                          |  2 +
 arch/sh/boot/dts/landisk.dts                       | 62 ++++++++++++++++++
 drivers/irqchip/Makefile                           |  2 +-
 drivers/irqchip/irq-io-landisk.c                   | 73 ++++++++++++++++++++++
 5 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
 create mode 100644 arch/sh/boot/dts/landisk.dts
 create mode 100644 drivers/irqchip/irq-io-landisk.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
new file mode 100644
index 0000000..9f87f2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
@@ -0,0 +1,34 @@
+DT bindings for the I/O DATA HDL-U interrupt controller
+
+Required properties:
+
+  - compatible: has to be "iodata,landisk-intc".
+
+  - reg: Base address and length of interrupt controller register.
+
+  - interrupt-controller: Identifies the node as an interrupt controller.
+
+  - #address-cells: has to be <0>.
+
+  - #interrupt-cells: has to be <1>: an interrupt index.
+
+  - interrupt-map: Interrupt mapping on parent controller.
+
+Example
+-------
+
+	cpldintc: cpld@b0000000 {
+		compatible = "iodata,landisk-intc";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0xb0000000 8>;
+		interrupt-map=<0 &shintc evt2irq(0x2a0)>,
+		              <1 &shintc evt2irq(0x2c0)>,
+		              <2 &shintc evt2irq(0x2e0)>,
+			      <3 &shintc evt2irq(0x300)>,
+		              <4 &shintc evt2irq(0x320)>,
+			      <5 &shintc evt2irq(0x340)>,
+		              <6 &shintc evt2irq(0x360)>,
+			      <7 &shintc evt2irq(0x380)>;
+	};
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 38fdc38..cf5aec4 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,5 +1,7 @@
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 
+dtb-y += landisk.dtb
+
 dtstree		:= $(srctree)/$(src)
 clean-files := *.dtb.S
 always	    := $(dtb-y)
diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
new file mode 100644
index 0000000..240d11b
--- /dev/null
+++ b/arch/sh/boot/dts/landisk.dts
@@ -0,0 +1,62 @@
+/dts-v1/;
+
+#include "sh7751.dtsi"
+
+/ {
+	model = "I/O DATA HDL-U";
+	compatible = "iodata,hdl-u";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = &sci1;
+		bootargs = "console=ttySC1,115200";
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+	};
+
+	memory@0c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+	cpldintc: cpld@b0000000 {
+		compatible = "iodata,landisk-intc";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0xb0000000 8>;
+		interrupt-map=<0 &shintc evt2irq(0x2a0)>,
+		              <1 &shintc evt2irq(0x2c0)>,
+		              <2 &shintc evt2irq(0x2e0)>,
+			      <3 &shintc evt2irq(0x300)>,
+		              <4 &shintc evt2irq(0x320)>,
+			      <5 &shintc evt2irq(0x340)>,
+		              <6 &shintc evt2irq(0x360)>,
+			      <7 &shintc evt2irq(0x380)>;
+	};
+};
+
+&oclk {
+	clock-frequency = <22222222>;
+};
+
+&sci0 {
+	status = "ok";
+};
+
+&sci1 {
+	status = "ok";
+};
+
+&pci {
+	compatible = "renesas,sh7751-pci", "iodata,landisk-pci";
+	interrupt-map-mask = <0x1800 0 7>;
+	interrupt-map = <0x0000 0 1 &cpldintc 0>,
+	                <0x0800 0 1 &cpldintc 1>,
+	                <0x1000 0 1 &cpldintc 2>,
+	                <0x1000 0 2 &cpldintc 3>,
+	                <0x1000 0 3 &cpldintc 0>;
+	status = "ok";
+};
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 2ab5735..5e225cf 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,4 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
-obj-$(CONFIG_RENESAS_SH_INTC)		+= irq-renesas-sh7751.o
+obj-$(CONFIG_RENESAS_SH_INTC)		+= irq-renesas-sh7751.o irq-io-landisk.o
diff --git a/drivers/irqchip/irq-io-landisk.c b/drivers/irqchip/irq-io-landisk.c
new file mode 100644
index 0000000..73419a2
--- /dev/null
+++ b/drivers/irqchip/irq-io-landisk.c
@@ -0,0 +1,73 @@
+/*
+ * IO-DATA LANDISK CPLD IRQ driver
+ *
+ * Copyright 2016 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/io.h>
+
+static void landisk_mask_irq(struct irq_data *data)
+{
+	u8 mask = __raw_readb(data->chip_data + 5);
+
+	mask &= ~(1 << (data->irq - 5));
+	__raw_writeb(mask, data->chip_data + 5);
+}
+
+static void landisk_unmask_irq(struct irq_data *data)
+{
+	u8 mask = __raw_readb(data->chip_data + 5);
+
+	mask |= (1 << (data->irq - 5));
+	__raw_writeb(mask, data->chip_data + 5);
+}
+
+static struct irq_chip cpld_irq_chip = {
+	.name		= "LANDISK-CPLD",
+	.irq_unmask	= landisk_unmask_irq,
+	.irq_mask	= landisk_mask_irq,
+};
+
+static int cpld_map(struct irq_domain *d, unsigned int virq,
+		    irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &cpld_irq_chip,
+				 handle_simple_irq);
+	irq_set_chip_data(virq, d->host_data);
+
+	return 0;
+}
+
+static struct irq_domain_ops irq_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= cpld_map,
+};
+
+static int __init landisk_intc_of_init(struct device_node *intc,
+				    struct device_node *parent)
+{
+	struct irq_domain *domain, *pdomain;
+	int num_irqpin;
+	void *baseaddr;
+
+	baseaddr = of_iomap(intc, 0);
+	pdomain = irq_find_host(parent);
+	of_get_property(intc, "interrupt-map", &num_irqpin);
+	num_irqpin /= sizeof(u32) * 3;
+	printk("%s %d\n", __func__, num_irqpin);
+	domain = irq_domain_create_hierarchy(pdomain, 0, num_irqpin,
+					     of_node_to_fwnode(intc),
+					     &irq_ops, baseaddr);
+	if (!domain)
+		panic("%s: unable to create IRQ domain\n", intc->full_name);
+	irq_domain_associate_many(domain, 5, 0, 8);
+	return 0;
+}
+
+IRQCHIP_DECLARE(cpld_intc, "iodata,landisk-intc", landisk_intc_of_init);
-- 
2.7.0

