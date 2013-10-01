From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 01 Oct 2013 18:30:48 +0000
Subject: [PATCH 3/6] arm: shmobile: Add internal PCI support to RCAR Gen2
Message-Id: <1380652251-8143-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds internal PCI controller support to RCAR Gen2 platform.
There are 3 PCI controllers available with only a EHCI/OHCI
device present on each one. The controllers do not support
I/O port space mapping and it is not needed here.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/Kconfig         |   1 +
 arch/arm/mach-shmobile/Makefile        |   4 +
 arch/arm/mach-shmobile/pci-rcar-gen2.c | 339 +++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/pci-rcar-gen2.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index eda2857..355b3be 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -100,6 +100,7 @@ config ARCH_R8A7790
 	select CPU_V7
 	select SH_CLK_CPG
 	select RENESAS_IRQC
+	select MIGHT_HAVE_PCI
 
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d1486e5..5eff7cb 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -33,6 +33,10 @@ obj-$(CONFIG_ARCH_R8A7791)	+= clock-r8a7791.o
 obj-$(CONFIG_ARCH_EMEV2)	+= clock-emev2.o
 endif
 
+ifdef CONFIG_PCI
+obj-$(CONFIG_ARCH_R8A7790)	+= pci-rcar-gen2.o
+endif
+
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
diff --git a/arch/arm/mach-shmobile/pci-rcar-gen2.c b/arch/arm/mach-shmobile/pci-rcar-gen2.c
new file mode 100644
index 0000000..71f3e9b
--- /dev/null
+++ b/arch/arm/mach-shmobile/pci-rcar-gen2.c
@@ -0,0 +1,339 @@
+/*
+ *  pci-rcar-gen2: internal PCI bus support
+ *
+ * Copyright (C) 2013 Cogent Embedded, Inc.
+ * Copyright (C) 2013 Renesas Solutions Corp.
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
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* AHB-PCI Bridge PCI communication registers */
+#define RCAR_AHBPCI_PCICOM_OFFSET	0x800
+
+#define RCAR_PCIAHB_WIN1_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x00)
+#define RCAR_PCIAHB_WIN2_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x04)
+#define RCAR_PCIAHB_PREFETCH0		0x0
+#define RCAR_PCIAHB_PREFETCH4		0x1
+#define RCAR_PCIAHB_PREFETCH8		0x2
+#define RCAR_PCIAHB_PREFETCH16		0x3
+
+#define RCAR_AHBPCI_WIN1_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x10)
+#define RCAR_AHBPCI_WIN2_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x14)
+#define RCAR_AHBPCI_WIN_CTR_MEM		(3 << 1)
+#define RCAR_AHBPCI_WIN_CTR_CFG		(5 << 1)
+#define RCAR_AHBPCI_WIN1_HOST		(1 << 30)
+#define RCAR_AHBPCI_WIN1_DEVICE		(1 << 31)
+
+#define RCAR_PCI_INT_ENABLE_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x20)
+#define RCAR_PCI_INT_STATUS_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x24)
+#define RCAR_PCI_INT_A			(1 << 16)
+#define RCAR_PCI_INT_B			(1 << 17)
+#define RCAR_PCI_INT_PME		(1 << 19)
+
+#define RCAR_AHB_BUS_CTR_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x30)
+#define RCAR_AHB_BUS_MMODE_HTRANS	(1 << 0)
+#define RCAR_AHB_BUS_MMODE_BYTE_BURST	(1 << 1)
+#define RCAR_AHB_BUS_MMODE_WR_INCR	(1 << 2)
+#define RCAR_AHB_BUS_MMODE_HBUS_REQ	(1 << 7)
+#define RCAR_AHB_BUS_SMODE_READYCTR	(1 << 17)
+#define RCAR_AHB_BUS_MODE		(RCAR_AHB_BUS_MMODE_HTRANS |	\
+					RCAR_AHB_BUS_MMODE_BYTE_BURST |	\
+					RCAR_AHB_BUS_MMODE_WR_INCR |	\
+					RCAR_AHB_BUS_MMODE_HBUS_REQ |	\
+					RCAR_AHB_BUS_SMODE_READYCTR)
+
+#define RCAR_USBCTR_REG			(RCAR_AHBPCI_PCICOM_OFFSET + 0x34)
+#define RCAR_USBCTR_USBH_RST		(1 << 0)
+#define RCAR_USBCTR_PCICLK_MASK		(1 << 1)
+#define RCAR_USBCTR_PLL_RST		(1 << 2)
+#define RCAR_USBCTR_DIRPD		(1 << 8)
+#define RCAR_USBCTR_PCIAHB_WIN2_EN	(1 << 9)
+#define RCAR_USBCTR_PCIAHB_WIN1_256M	(0 << 10)
+#define RCAR_USBCTR_PCIAHB_WIN1_512M	(1 << 10)
+#define RCAR_USBCTR_PCIAHB_WIN1_1G	(2 << 10)
+#define RCAR_USBCTR_PCIAHB_WIN1_2G	(3 << 10)
+#define RCAR_USBCTR_PCIAHB_WIN1_MASK	(3 << 10)
+
+#define RCAR_PCI_ARBITER_CTR_REG	(RCAR_AHBPCI_PCICOM_OFFSET + 0x40)
+#define RCAR_PCI_ARBITER_PCIREQ0	(1 << 0)
+#define RCAR_PCI_ARBITER_PCIREQ1	(1 << 1)
+#define RCAR_PCI_ARBITER_PCIBP_MODE	(1 << 12)
+
+#define RCAR_PCI_UNIT_REV_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x48)
+
+/* Maximum number of internal PCI controllers */
+#define RCAR_PCI_NR_CONTROLLERS		3
+
+struct rcar_pci_priv {
+	void __iomem *reg;
+	struct resource io_res;
+	struct resource *mem_res;
+	struct resource *cfg_res;
+	int irq;
+};
+
+/* PCI configuration space operations */
+void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
+				int where)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct rcar_pci_priv *priv = sys->private_data;
+	int slot, val;
+
+	if (sys->busnr != bus->number || PCI_FUNC(devfn))
+		return NULL;
+
+	/* Only one EHCI/OHCI device built-in */
+	slot = PCI_SLOT(devfn);
+	if (slot > 2)
+		return NULL;
+
+	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
+			RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
+
+	iowrite32(val, priv->reg + RCAR_AHBPCI_WIN1_CTR_REG);
+	return priv->reg + (slot >> 1) * 0x100 + where;
+}
+
+static int rcar_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+				int where, int size, u32 *val)
+{
+	void __iomem *reg = rcar_pci_cfg_base(bus, devfn, where);
+
+	if (!reg)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (size) {
+	case 1:
+		*val = ioread8(reg);
+		break;
+	case 2:
+		*val = ioread16(reg);
+		break;
+	default:
+		*val = ioread32(reg);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int rcar_pci_write_config(struct pci_bus *bus, unsigned int devfn,
+					int where, int size, u32 val)
+{
+	void __iomem *reg = rcar_pci_cfg_base(bus, devfn, where);
+
+	if (!reg)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	switch (size) {
+	case 1:
+		iowrite8(val, reg);
+		break;
+	case 2:
+		iowrite16(val, reg);
+		break;
+	default:
+		iowrite32(val, reg);
+		break;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/* PCI interrupt mapping */
+static int __init rcar_pci_map_irq(const struct pci_dev *dev,
+					u8 slot, u8 pin)
+{
+	struct pci_sys_data *sys = dev->bus->sysdata;
+	struct rcar_pci_priv *priv = sys->private_data;
+
+	return priv->irq;
+}
+
+/* PCI host controller setup */
+static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
+{
+	struct rcar_pci_priv *priv = sys->private_data;
+	void __iomem *reg = priv->reg;
+	u32 val;
+
+	val = ioread32(reg + RCAR_PCI_UNIT_REV_REG);
+	pr_info("PCI: bus %u revision %x\n", sys->busnr, val);
+
+	/* Disable Direct Power Down State and assert reset */
+	val = ioread32(reg + RCAR_USBCTR_REG) & ~RCAR_USBCTR_DIRPD;
+	val |= RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST;
+	iowrite32(val, reg + RCAR_USBCTR_REG);
+	udelay(4);
+
+	/* De-assert reset and set PCIAHB window1 size to 1GB */
+	val &= ~(RCAR_USBCTR_PCIAHB_WIN1_MASK | RCAR_USBCTR_PCICLK_MASK |
+		RCAR_USBCTR_USBH_RST | RCAR_USBCTR_PLL_RST);
+	iowrite32(val | RCAR_USBCTR_PCIAHB_WIN1_1G, reg + RCAR_USBCTR_REG);
+
+	/* Configure AHB master and slave modes */
+	iowrite32(RCAR_AHB_BUS_MODE, reg + RCAR_AHB_BUS_CTR_REG);
+
+	/* Configure PCI arbiter */
+	val = ioread32(reg + RCAR_PCI_ARBITER_CTR_REG);
+	val |= RCAR_PCI_ARBITER_PCIREQ0 | RCAR_PCI_ARBITER_PCIREQ1 |
+		RCAR_PCI_ARBITER_PCIBP_MODE;
+	iowrite32(val, reg + RCAR_PCI_ARBITER_CTR_REG);
+
+	/* PCI-AHB mapping: 0x40000000-0x80000000 */
+	iowrite32(0x40000000 | RCAR_PCIAHB_PREFETCH16,
+			reg + RCAR_PCIAHB_WIN1_CTR_REG);
+
+	/* AHB-PCI mapping: OHCI/EHCI registers */
+	val = priv->mem_res->start | RCAR_AHBPCI_WIN_CTR_MEM;
+	iowrite32(val, reg + RCAR_AHBPCI_WIN2_CTR_REG);
+
+	/* Enable AHB-PCI bridge PCI configuration access */
+	iowrite32(RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG,
+			reg + RCAR_AHBPCI_WIN1_CTR_REG);
+	/* Set PCI-AHB Window1 address */
+	iowrite32(0x40000000 | PCI_BASE_ADDRESS_MEM_PREFETCH,
+			reg + PCI_BASE_ADDRESS_1);
+	/* Set AHB-PCI bridge PCI communication area address */
+	val = priv->cfg_res->start + RCAR_AHBPCI_PCICOM_OFFSET;
+	iowrite32(val, reg + PCI_BASE_ADDRESS_0);
+
+	val = ioread32(reg + PCI_COMMAND);
+	val |= PCI_COMMAND_SERR | PCI_COMMAND_PARITY |
+		PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER;
+	iowrite32(val, reg + PCI_COMMAND);
+
+	/* Enable PCI interrupts */
+	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
+			reg + RCAR_PCI_INT_ENABLE_REG);
+
+	/* Add PCI resources */
+	pci_add_resource(&sys->resources, &priv->io_res);
+	pci_add_resource(&sys->resources, priv->mem_res);
+	return 1;
+}
+
+static void *rcar_pci_priv[RCAR_PCI_NR_CONTROLLERS] __initdata;
+
+static struct pci_ops rcar_pci_ops = {
+	.read	= rcar_pci_read_config,
+	.write	= rcar_pci_write_config,
+};
+
+static struct hw_pci rcar_hw_pci __initdata = {
+	.map_irq	= rcar_pci_map_irq,
+	.ops		= &rcar_pci_ops,
+	.setup		= rcar_pci_setup,
+	.private_data	= rcar_pci_priv,
+};
+
+static int __init rcar_pci_probe(struct platform_device *pdev)
+{
+	int i, nr_controllers;
+	struct clk *clk;
+
+	if (rcar_hw_pci.nr_controllers)
+		return -EBUSY;
+
+	clk = clk_get(&pdev->dev, "ehci");
+	if (IS_ERR(clk))
+		return -ENODEV;
+
+	nr_controllers = 0;
+	for (i = 0; i < RCAR_PCI_NR_CONTROLLERS; i++) {
+		struct resource *mem_res, *cfg_res;
+		struct rcar_pci_priv *priv;
+		void __iomem *reg;
+
+		mem_res = platform_get_resource(pdev,
+						IORESOURCE_MEM, i * 2);
+		if (!mem_res)
+			break;
+
+		if (mem_res->flags & IORESOURCE_DISABLED) {
+			dev_info(&pdev->dev, "PCI%u: skipped (disabled)\n", i);
+			continue;
+		}
+
+		cfg_res = platform_get_resource(pdev,
+						IORESOURCE_MEM, i * 2 + 1);
+		if (!cfg_res)
+			break;
+
+		priv = kzalloc(sizeof(struct rcar_pci_priv), GFP_KERNEL);
+		if (!priv) {
+			dev_err(&pdev->dev,
+				"PCI%u: skipped (not enough memory)\n", i);
+			continue;
+		}
+
+		reg = ioremap(cfg_res->start, resource_size(cfg_res));
+		if (!reg) {
+			kfree(priv);
+			dev_err(&pdev->dev,
+				"PCI%u: skipped (ioremap failed)\n", i);
+			continue;
+		}
+
+		/* The controller does not support/use port I/O,
+		 * so setup dummy port I/O region here.
+		 */
+		priv->io_res.start = mem_res->start;
+		priv->io_res.end = mem_res->end;
+		priv->io_res.flags = IORESOURCE_IO;
+
+		priv->mem_res = mem_res;
+		priv->cfg_res = cfg_res;
+
+		priv->irq = platform_get_irq(pdev, i);
+		priv->reg = reg;
+
+		rcar_pci_priv[nr_controllers++] = priv;
+		dev_info(&pdev->dev, "PCI%u: added\n", i);
+	}
+
+	if (!nr_controllers) {
+		clk_put(clk);
+		return -ENODEV;
+	}
+
+	clk_enable(clk);
+	rcar_hw_pci.nr_controllers = nr_controllers;
+	pci_common_init_dev(&pdev->dev, &rcar_hw_pci);
+	return 0;
+}
+
+static struct platform_driver rcar_pci_driver = {
+	.driver = {
+		.name = "pci-rcar-gen2",
+	},
+};
+
+static int __init rcar_pci_init(void)
+{
+	return platform_driver_probe(&rcar_pci_driver, rcar_pci_probe);
+}
+
+subsys_initcall(rcar_pci_init);
-- 
1.8.3.1

