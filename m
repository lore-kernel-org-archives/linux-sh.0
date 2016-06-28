From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 28 Jun 2016 06:36:35 +0000
Subject: [PATCH v3 19/19] sh: Renesas R0P751RLC0011RL (a.k.a R2Dplus) support
Message-Id: <1467095795-5082-20-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../interrupt-controller/renesas-r2dplus.txt       | 41 ++++++++++
 arch/sh/boot/dts/Makefile                          |  1 +
 arch/sh/boot/dts/r2dplus.dts                       | 84 +++++++++++++++++++++
 drivers/irqchip/Makefile                           |  2 +-
 drivers/irqchip/irq-renesas-r2dplus.c              | 88 ++++++++++++++++++++++
 5 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas-r2dplus.txt
 create mode 100644 arch/sh/boot/dts/r2dplus.dts
 create mode 100644 drivers/irqchip/irq-renesas-r2dplus.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas-r2dplus.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas-r2dplus.txt
new file mode 100644
index 0000000..ca2727e
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas-r2dplus.txt
@@ -0,0 +1,41 @@
+DT bindings for the Renesas R0P751RLC0011RL (R2Dplus) interrupt controller
+
+Required properties:
+
+  - compatible: has to be "renesas,r2dplus-intc".
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
+	fpgaintc: fpga@a4000000 {
+		compatible = "renesas,r2dplus-intc";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0xa4000000 0x40>;
+		interrupt-map=<0 &shintc evt2irq(0x200)>,
+		              <1 &shintc evt2irq(0x220)>,
+		              <2 &shintc evt2irq(0x240)>,
+			      <3 &shintc evt2irq(0x260)>,
+		              <4 &shintc evt2irq(0x280)>,
+			      <5 &shintc evt2irq(0x2a0)>,
+		              <6 &shintc evt2irq(0x2c0)>,
+			      <7 &shintc evt2irq(0x2e0)>,
+		              <8 &shintc evt2irq(0x300)>,
+		              <9 &shintc evt2irq(0x320)>,
+			      <10 &shintc evt2irq(0x340)>,
+		              <11 &shintc evt2irq(0x360)>,
+			      <12 &shintc evt2irq(0x380)>,
+		              <13 &shintc evt2irq(0x3a0)>,
+			      <14 &shintc evt2irq(0x3c0)>,
+	};
diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index cf5aec4..e059ce2b 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 
 dtb-y += landisk.dtb
+otb-y += r2dplus.dtb
 
 dtstree		:= $(srctree)/$(src)
 clean-files := *.dtb.S
diff --git a/arch/sh/boot/dts/r2dplus.dts b/arch/sh/boot/dts/r2dplus.dts
new file mode 100644
index 0000000..32256f2
--- /dev/null
+++ b/arch/sh/boot/dts/r2dplus.dts
@@ -0,0 +1,84 @@
+/dts-v1/;
+
+#include "sh7751.dtsi"
+
+/ {
+	model = "Renesas RTS7751R2D+";
+	compatible = "renesas,r2dplus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = &sci1;
+		bootargs = "console=ttySC1,115200";
+	};
+	aliases {
+		serial1 = &sci1;
+	};
+
+	memory@0c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+	fpgaintc: fpga@a4000000 {
+		compatible = "renesas,r2dplus-intc";
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		reg = <0xa4000000 0x40>;
+		interrupt-map=<0 &shintc evt2irq(0x200)>,
+		              <1 &shintc evt2irq(0x220)>,
+		              <2 &shintc evt2irq(0x240)>,
+			      <3 &shintc evt2irq(0x260)>,
+		              <4 &shintc evt2irq(0x280)>,
+			      <5 &shintc evt2irq(0x2a0)>,
+		              <6 &shintc evt2irq(0x2c0)>,
+			      <7 &shintc evt2irq(0x2e0)>,
+		              <8 &shintc evt2irq(0x300)>,
+			      <9 &shintc evt2irq(0x320)>,
+		              <10 &shintc evt2irq(0x340)>,
+			      <11 &shintc evt2irq(0x360)>,
+		              <12 &shintc evt2irq(0x380)>,
+			      <13 &shintc evt2irq(0x3a0)>,
+		              <14 &shintc evt2irq(0x3c0)>;
+	};
+	pata: pata@b4001000 {
+		compatible = "ata-generic";
+		reg = <0xb4001000 0x10>, <0xb400080c 0x02>;
+		interrupt-parent = <&fpgaintc>;
+		interrupts = <1 0>;
+		reg-shift = <1>;
+		pio-mode = <0>;
+	};
+	sm501: display@13e00000 {
+		compatible = "smi,sm501";
+		reg = <0x10000000 0x13dfffff>, <0x13e00000 0x13ffffff>;
+		interrupt-parent = <&fpgaintc>;
+		interrupts = <4 0>;
+		mode = "640x480-16@60";
+		edid = [00 ff ff ff ff ff ff 00 04 21 00 00 00 00 00 00
+		        01 00 01 03 80 00 00 00 00 00 00 00 00 00 00 00
+			00 00 00 20 00 00 01 00 01 00 01 00 01 00 01 00
+			01 00 01 00 01 00 f3 0d 7b 69 30 05 23 20 00 60
+			02 00 80 e0 21 00 00 1e 00 00 00 10 00 00 00 00
+			00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 00
+			00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+			00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 b7];
+		smi,devices = <1>;
+	};
+};
+
+&oclk {
+	clock-frequency = <60000000>;
+};
+
+&sci1 {
+	status = "ok";
+};
+
+&pci {
+	compatible = "renesas,sh7751-pci", "renesas.r2dplus-pci";
+	interrupt-map-mask = <0x1800 0 7>;
+	interrupt-map = <0x1000 0 1 &fpgaintc 3 0>;
+	status = "ok";
+};
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 5e225cf..1e0f1c3 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,4 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
-obj-$(CONFIG_RENESAS_SH_INTC)		+= irq-renesas-sh7751.o irq-io-landisk.o
+obj-$(CONFIG_RENESAS_SH_INTC)		+= irq-renesas-sh7751.o irq-io-landisk.o irq-renesas-r2dplus.o
diff --git a/drivers/irqchip/irq-renesas-r2dplus.c b/drivers/irqchip/irq-renesas-r2dplus.c
new file mode 100644
index 0000000..3f80775
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-r2dplus.c
@@ -0,0 +1,88 @@
+/*
+ * Renesas RTS7751R2D+ FPGA IRQ driver
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
+static const u16 mask_bit[] = {
+	BIT(11),
+	BIT(9),
+	BIT(8),
+	BIT(12),
+	BIT(10),
+	BIT(6),
+	BIT(5),
+	BIT(4),
+	BIT(7),
+	BIT(14),
+	BIT(13),
+	BIT(0),
+	BIT(15),
+};
+
+static void r2dplus_mask_irq(struct irq_data *data)
+{
+	u16 mask = __raw_readw(data->chip_data);
+
+	mask &= ~mask_bit[data->irq];
+	__raw_writew(mask, data->chip_data);
+}
+
+static void r2dplus_unmask_irq(struct irq_data *data)
+{
+	u16 mask = __raw_readw(data->chip_data);
+
+	mask |= mask_bit[data->irq];
+	__raw_writew(mask, data->chip_data);
+}
+
+static struct irq_chip fpga_irq_chip = {
+	.name		= "R2DPLUS-FPGA",
+	.irq_unmask	= r2dplus_unmask_irq,
+	.irq_mask	= r2dplus_mask_irq,
+};
+
+static int fpga_map(struct irq_domain *d, unsigned int virq,
+		    irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &fpga_irq_chip,
+				 handle_simple_irq);
+	irq_set_chip_data(virq, d->host_data);
+
+	return 0;
+}
+
+static struct irq_domain_ops irq_ops = {
+	.xlate	= irq_domain_xlate_onecell,
+	.map	= fpga_map,
+};
+
+static int __init r2dplus_intc_of_init(struct device_node *intc,
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
+	domain = irq_domain_create_hierarchy(pdomain, 0, num_irqpin,
+					     of_node_to_fwnode(intc),
+					     &irq_ops, baseaddr);
+	if (!domain)
+		panic("%s: unable to create IRQ domain\n", intc->full_name);
+	irq_domain_associate_many(domain, 0, 0, 16);
+	return 0;
+}
+
+IRQCHIP_DECLARE(cpld_intc, "renesas,r2dplus-intc", r2dplus_intc_of_init);
-- 
2.7.0

