From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:39 +0000
Subject: [PATCH v5 19/22] sh: IO-DATA HDL-U (a.k.a landisk) IRQCHIP driver
Message-Id: <1467564402-2649-20-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../interrupt-controller/iodata-landisk.txt        | 31 ++++++++++
 drivers/irqchip/Makefile                           |  2 +-
 drivers/irqchip/irq-io-landisk.c                   | 72 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
 create mode 100644 drivers/irqchip/irq-io-landisk.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
new file mode 100644
index 0000000..cf461dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
@@ -0,0 +1,31 @@
+DT bindings for the I/O DATA HDL-U interrupt controller
+
+Required properties:
+
+  - compatible: has to be "iodata,landisk-intc".
+
+  - reg: Base address and length of interrupt controller register.
+
+  - #interrupt-cells: has to be <1>: an interrupt index.
+
+  - #address-cells: has to be <0>
+
+  - interrupt-map: Interrupt mapping on parent controller.
+
+Example
+-------
+
+	cpldintc: cpld@b0000000 {
+		compatible = "iodata,landisk-intc";
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
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
index 0000000..b7f3b41
--- /dev/null
+++ b/drivers/irqchip/irq-io-landisk.c
@@ -0,0 +1,72 @@
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

