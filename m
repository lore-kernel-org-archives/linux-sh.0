From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 04:30:37 +0000
Subject: [PATCH v6 2/2] irqchip: add J-Core AIC driver
Message-Id: <c3b89ef74aaa6477575dbe2d410eb1d182503243.147018b6529.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b6529.git.dalias@libc.org>
In-Reply-To: <cover.147018b6529.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

There are two versions of the J-Core interrupt controller in use, aic1
which generates interrupts with programmable priorities, but only
supports 8 irq lines and maps them to cpu traps in the range 17 to 24,
and aic2 which uses traps in the range 64-127 and supports up to 128
irqs, with priorities dependent on the interrupt number. The Linux
driver does not make use of priorities anyway.

For simplicity, there is no aic1-specific logic in the driver beyond
setting the priority register, which is necessary for interrupts to
work at all. Eventually aic1 will likely be phased out, but it's
currently in use in deployments and all released bitstream binaries.

Signed-off-by: Rich Felker <dalias@libc.org>
---
 drivers/irqchip/Kconfig         |  7 +++
 drivers/irqchip/Makefile        |  1 +
 drivers/irqchip/irq-jcore-aic.c | 94 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/irqchip/irq-jcore-aic.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 5495a5b..ab84ce3 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -156,6 +156,13 @@ config PIC32_EVIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config JCORE_AIC
+	bool "J-Core integrated AIC"
+	depends on OF && (SUPERH || COMPILE_TEST)
+	select IRQ_DOMAIN
+	help
+	  Support for the J-Core integrated AIC.
+
 config RENESAS_INTC_IRQPIN
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 4c203b6..ee7e3ca 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_I8259)			+= irq-i8259.o
 obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
 obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
 obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
+obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
 obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
 obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
 obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
new file mode 100644
index 0000000..5e5e3bb
--- /dev/null
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -0,0 +1,94 @@
+/*
+ * J-Core SoC AIC driver
+ *
+ * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/cpu.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define JCORE_AIC_MAX_HWIRQ	127
+#define JCORE_AIC1_MIN_HWIRQ	16
+#define JCORE_AIC2_MIN_HWIRQ	64
+
+#define JCORE_AIC1_INTPRI_REG	8
+
+static struct irq_chip jcore_aic;
+
+static int jcore_aic_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				   irq_hw_number_t hwirq)
+{
+	struct irq_chip *aic = d->host_data;
+
+	irq_set_chip_and_handler(irq, aic, handle_simple_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops jcore_aic_irqdomain_ops = {
+	.map = jcore_aic_irqdomain_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void noop(struct irq_data *data)
+{
+}
+
+int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
+{
+	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
+	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
+	struct irq_domain *domain;
+
+	pr_info("Initializing J-Core AIC\n");
+
+	/* AIC1 needs priority initialization to receive interrupts. */
+	if (of_device_is_compatible(node, "jcore,aic1")) {
+		unsigned cpu;
+
+		for_each_present_cpu(cpu) {
+			void __iomem *base = of_iomap(node, cpu);
+
+			if (!base) {
+				pr_err("Unable to map AIC for cpu %u\n", cpu);
+				return -ENOMEM;
+			}
+			__raw_writel(0xffffffff, base + JCORE_AIC1_INTPRI_REG);
+			iounmap(base);
+		}
+		min_irq = JCORE_AIC1_MIN_HWIRQ;
+	}
+
+	/*
+	 * The irq chip framework requires either mask/unmask or enable/disable
+	 * function pointers to be provided, but the hardware does not have any
+	 * such mechanism; the only interrupt masking is at the cpu level and
+	 * it affects all interrupts. We provide dummy mask/unmask. The hardware
+	 * handles all interrupt control and clears pending status when the cpu
+	 * accepts the interrupt.
+	 */
+	jcore_aic.irq_mask = noop;
+	jcore_aic.irq_unmask = noop;
+	jcore_aic.name = "AIC";
+
+	domain = irq_domain_add_linear(node, dom_sz, &jcore_aic_irqdomain_ops,
+				       &jcore_aic);
+	if (!domain)
+		return -ENOMEM;
+	irq_create_strict_mappings(domain, min_irq, min_irq, dom_sz - min_irq);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(jcore_aic2, "jcore,aic2", aic_irq_of_init);
+IRQCHIP_DECLARE(jcore_aic1, "jcore,aic1", aic_irq_of_init);
-- 
2.8.1

