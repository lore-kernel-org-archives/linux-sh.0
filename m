From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 01 May 2016 05:08:33 +0000
Subject: [PATCH RESEND 09/12] sh: Add I/O DATA HDL-U support drivers.
Message-Id: <1462079316-27771-10-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

PCI host fixup and external interrupt controller.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../interrupt-controller/iodata-landisk.txt        | 28 +++++++++
 drivers/irqchip/irq-io-landisk.c                   | 71 ++++++++++++++++++++++
 drivers/pci/host/pci-sh7751.c                      | 25 ++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
 create mode 100644 drivers/irqchip/irq-io-landisk.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
new file mode 100644
index 0000000..09c2841
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/iodata-landisk.txt
@@ -0,0 +1,28 @@
+DT bindings for the I/O DATA HDL-U interrupt controler
+
+Required properties:
+
+  - compatible: has to be "iodata,landisk-intc".
+
+  - reg: Base address and length of interrupt controller register.
+
+  - interrupt-controller: Identifies the node as an interrupt controller.
+
+  - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined
+    in interrupts.txt in this directory.
+
+  - interrupt-map: Interrupt mapping on parent controler.
+
+Example
+-------
+
+	cpldintc: cpld@b0000000 {
+		compatible = "iodata,landisk-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xb0000000 8>;
+		interrupt-map=<0 &shintc 0 0>, <1 &shintc 1 0>,
+		              <2 &shintc 2 0>, <3 &shintc 3 0>,
+		              <4 &shintc 4 0>, <5 &shintc 5 0>,
+		              <6 &shintc 6 0>, <7 &shintc 7 0>;
+	};
diff --git a/drivers/irqchip/irq-io-landisk.c b/drivers/irqchip/irq-io-landisk.c
new file mode 100644
index 0000000..c351925
--- /dev/null
+++ b/drivers/irqchip/irq-io-landisk.c
@@ -0,0 +1,71 @@
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
+	mask &= !(1 << (data->irq - 5));
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
+	.xlate	= irq_domain_xlate_twocell,
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
+	BUG_ON(!domain);
+	irq_domain_associate_many(domain, 0, 0, 8);
+	return 0;
+}
+
+IRQCHIP_DECLARE(cpld_intc, "iodata,landisk-intc", landisk_intc_of_init);
diff --git a/drivers/pci/host/pci-sh7751.c b/drivers/pci/host/pci-sh7751.c
index fd6548b..3fa0da5 100644
--- a/drivers/pci/host/pci-sh7751.c
+++ b/drivers/pci/host/pci-sh7751.c
@@ -26,10 +26,35 @@ DEFINE_RAW_SPINLOCK(pci_config_lock);
  * PCIC fixups
  */
 
+#define PCIMCR_MRSET 0x40000000
+#define PCIMCR_RFSH  0x00000004
+
+static void __init landisk_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = __raw_readl(bcr + SH7751_BCR1);
+	bcr1 |= 0x00080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	mcr = __raw_readl(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, SH7751_PCICONF5);
+	pcic_writel(0xd0000000, SH7751_PCICONF6);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
 static __initconst const struct fixups {
 	char *compatible;
 	void (*fixup)(void __iomem *, void __iomem *);
 } fixup_list[] = {
+	{
+		.compatible = "iodata,landisk",
+		.fixup = landisk_fixup,
+	},
 };
 
 static __init void pcic_fixups(struct device_node *np,
-- 
2.7.0

