From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 28 Jun 2016 06:36:28 +0000
Subject: [PATCH v3 12/19] sh: irqchip: SH7751 IRQCHIP Driver
Message-Id: <1467095795-5082-13-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../interrupt-controller/renesas,sh7751-intc.txt   |  25 ++++
 arch/sh/Kconfig                                    |   6 +-
 arch/sh/boards/Kconfig                             |   1 +
 drivers/irqchip/Kconfig                            |   5 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-renesas-sh7751.c               | 141 +++++++++++++++++++++
 6 files changed, 176 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
new file mode 100644
index 0000000..2bc6f22f
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
@@ -0,0 +1,25 @@
+DT bindings for the SH7751 interrupt controller
+
+Required properties:
+
+  - compatible: has to be "renesas,sh7751-intc".
+
+  - reg: Base address and length of interrupt controller register
+         and extend register.
+
+  - interrupt-controller: Identifies the node as an interrupt controller.
+
+  - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined
+    in interrupts.txt in this directory.
+
+Example
+-------
+
+	shintc: interrupt-controller@ffd00000 {
+		compatible = "renesas,sh7751-intc";
+		#interrupt-cells = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		interrupt-controller;
+		reg = <0xffd00000 14>, <0xfe080000 128>;
+	};
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d06cac1..fee4333 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -29,7 +29,7 @@ config SUPERH
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select MAY_HAVE_SPARSE_IRQ
+	select MAY_HAVE_SPARSE_IRQ if !SH_DEVICE_TREE
 	select IRQ_FORCED_THREADING
 	select RTC_LIB
 	select GENERIC_ATOMIC64
@@ -69,7 +69,7 @@ config SUPERH32
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
-	select SPARSE_IRQ
+	select SPARSE_IRQ if !SH_DEVICE_TREE
 	select HAVE_CC_STACKPROTECTOR
 
 config SUPERH64
@@ -863,7 +863,7 @@ config PCI
 	depends on SYS_SUPPORTS_PCI
 	select PCI_DOMAINS
 	select GENERIC_PCI_IOMAP
-	select NO_GENERIC_PCI_IOPORT_MAP
+	select NO_GENERIC_PCI_IOPORT_MAP if !SH_DEVICE_TREE
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index cfde921..d33ae46 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -15,6 +15,7 @@ config SH_DEVICE_TREE
 	select GENERIC_IOMAP
 	select COMMON_CLK
 	select SYS_SUPPORTS_PCI
+	select GENERIC_IRQ_CHIP
 	help
 	  Select Board Described by Device Tree to build a kernel that
 	  does not hard-code any board-specific knowledge but instead uses
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index fa33c50..fd7f842 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -251,6 +251,11 @@ config LS_SCFG_MSI
 	depends on PCI && PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 
+config RENESAS_SH_INTC
+	def_bool y if SH_DEVICE_TREE
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+
 config PARTITION_PERCPU
 	bool
 
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 38853a1..2ab5735 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -69,3 +69,4 @@ obj-$(CONFIG_PIC32_EVIC)		+= irq-pic32-evic.o
 obj-$(CONFIG_MVEBU_ODMI)		+= irq-mvebu-odmi.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
+obj-$(CONFIG_RENESAS_SH_INTC)		+= irq-renesas-sh7751.o
diff --git a/drivers/irqchip/irq-renesas-sh7751.c b/drivers/irqchip/irq-renesas-sh7751.c
new file mode 100644
index 0000000..1710978
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751.c
@@ -0,0 +1,141 @@
+/*
+ * SH7751 interrupt contoller driver
+ *
+ * Copyright 2016 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/io.h>
+
+static struct sh7751_intc_regs {
+	void *icr;
+	void *ipr;
+	void *intpri00;
+	void *intreq00;
+	void *intmsk00;
+	void *intmskclr00;
+} sh7751_regs;
+
+static const unsigned int ipr_table[] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, /* 0 - 7 */
+	0x41, 0xff, 0xff, 0x40, 0xff, 0xff, 0xff, 0xff, /* 8 - 15 */
+	0x03, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00, 0x11, /* 16 - 23 */
+	0x11, 0x11, 0x11, 0x13, 0x12, 0x12, 0xff, 0xff, /* 24 - 31 */
+	0x30, 0x33, 0x32, 0x32, 0x32, 0x32, 0x32, 0x21, /* 32 - 39 */
+	0x21, 0x21, 0x21, 0x21, 0x32, 0x32, 0x32, 0x32, /* 40 - 47 */
+	0xff, 0xff, 0xff, 0x40, 0xff, 0xff, 0xff, 0xff, /* 48 - 55 */
+	0xff, 0xff, 0xff, 0x40, 0xff, 0xff, 0xff, 0xff, /* 56 - 63 */
+};
+
+static const unsigned int pri_table[] = {
+	0, 4, 4, 4, 4, 4, 4, 4,
+	8, 32, 32, 32, 12, 32, 32, 32,
+};
+
+static void sh_disable_irq(struct irq_data *data)
+{
+	int pos;
+	unsigned int addr;
+	unsigned long pri;
+	int irq = data->irq;
+	struct sh7751_intc_regs *reg = data->chip_data;
+
+	if (irq < 64) {
+		if (ipr_table[irq] != 0xff) {
+			addr = (ipr_table[irq] & 0xf0) >> 2;
+			pos = (ipr_table[irq] & 0x0f) << 4;
+			pri = ~(0x000f << pos);
+			pri &= __raw_readw(reg->ipr + addr);
+			__raw_writew(pri, reg->ipr + addr);
+		}
+	} else {
+		if (pri_table[irq - 64] < 32) {
+			pos = pri_table[irq - 64];
+			pri = ~(0x000f << pos);
+			pri &= __raw_readw(reg->intpri00);
+			__raw_writew(pri, reg->intpri00);
+		}
+	}
+}
+
+static void sh_enable_irq(struct irq_data *data)
+{
+	int pos;
+	unsigned int addr;
+	unsigned long pri;
+	int irq = data->irq;
+	struct sh7751_intc_regs *reg = data->chip_data;
+
+	if (irq < 64) {
+		if (ipr_table[irq] != 0xff) {
+			addr = (ipr_table[irq] & 0xf0) >> 2;
+			pos = (ipr_table[irq] & 0x0f) * 4;
+			pri = ~(0x000f << pos);
+			pri &= __raw_readw(reg->ipr + addr);
+			pri |= 1 << pos;
+			__raw_writew(pri, reg->ipr + addr);
+		}
+	} else {
+		if (pri_table[irq - 64] < 32) {
+			pos = pri_table[irq - 64];
+			pri = ~(0x000f << pos);
+			pri &= __raw_readw(reg->intpri00);
+			pri |= 1 << pos;
+			__raw_writew(pri, reg->intpri00);
+		}
+	}
+}
+
+static struct irq_chip sh_irq_chip = {
+	.name		= "SH-IPR",
+	.irq_unmask	= sh_enable_irq,
+	.irq_mask	= sh_disable_irq,
+};
+
+static __init int irq_map(struct irq_domain *h, unsigned int virq,
+			  irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &sh_irq_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+
+	return 0;
+}
+
+static struct irq_domain_ops irq_ops = {
+	.map    = irq_map,
+	.xlate  = irq_domain_xlate_onecell,
+};
+
+static int __init sh_intc_7751_init(struct device_node *intc,
+				    struct device_node *parent)
+{
+	struct irq_domain *domain;
+	void *intc_baseaddr;
+	void *intc_baseaddr2;
+
+	intc_baseaddr = of_iomap(intc, 0);
+	intc_baseaddr2 = of_iomap(intc, 1);
+	if (!intc_baseaddr || !intc_baseaddr2)
+		panic("INTC regsiter not defined");
+
+	sh7751_regs.icr = intc_baseaddr;
+	sh7751_regs.ipr = intc_baseaddr + 4;
+	sh7751_regs.intpri00 = intc_baseaddr2;
+	sh7751_regs.intreq00 = intc_baseaddr2 + 0x20;
+	sh7751_regs.intmsk00 = intc_baseaddr2 + 0x40;
+	sh7751_regs.intmskclr00 = intc_baseaddr2 + 0x60;
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, &sh7751_regs);
+	if (!domain)
+		panic("%s: unable to create IRQ domain\n", intc->full_name);
+
+	irq_set_default_host(domain);
+	return 0;
+}
+
+IRQCHIP_DECLARE(sh_7751_intc, "renesas,sh7751-intc", sh_intc_7751_init);
-- 
2.7.0

