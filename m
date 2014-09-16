From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Sep 2014 11:20:11 +0000
Subject: [PATCH 01/03] PCI: rcar: Use notifier to hook up IOMMU groups
Message-Id: <20140916112011.14889.71199.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the R-Car Gen2 PCI controller to use a notifier
to add OHCI and EHCI devices to the same IOMMU group
as the PCI host device.

With this patch the PCI host controller driver will
simply assign the same IOMMU group to all children
hanging off the PCI bus that it happens to driver.

Multiple PCI host controllers and IOMMU groups are
known to work.

It is the responsibility of the IOMMU driver to assign
one IOMMU group per PCI host controller and make sure
that when PCI devices are added to IOMMU groups then
such devices need to be handled by the IOMMU as well.

Tested on r8a7790 Lager with a single USB device
connected to USB1 on CN5. Other USB host controllers
and their PCI host controllers on USB0 and USB2 are
known to get unique IOMMU groups but apart from that
no special testing has been done due to lack of
DT-capable USB PHY driver upstream.

Known to compile and work independently of if IOMMU
is enabled in the Kconfig or IPMMU driver available.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pci/host/pci-rcar-gen2.c |   52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

--- 0001/drivers/pci/host/pci-rcar-gen2.c
+++ work/drivers/pci/host/pci-rcar-gen2.c	2014-09-16 16:45:03.000000000 +0900
@@ -13,8 +13,10 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -102,6 +104,7 @@ struct rcar_pci_priv {
 	unsigned busnr;
 	int irq;
 	unsigned long window_size;
+	struct notifier_block bus_notifier;
 };
 
 /* PCI configuration space operations */
@@ -329,6 +332,52 @@ static struct pci_ops rcar_pci_ops = {
 	.write	= rcar_pci_write_config,
 };
 
+static int rcar_pci_bus_notify(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct rcar_pci_priv *priv;
+	struct device *dev = data;
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_sys_data *sys = pci_dev->sysdata;
+	struct iommu_group *iommu_group;
+
+	priv = container_of(nb, struct rcar_pci_priv, bus_notifier);
+	if (priv != sys->private_data)
+		return 0;
+
+	iommu_group = iommu_group_get(priv->dev);
+	if (iommu_group) {
+		switch (action) {
+		case BUS_NOTIFY_BIND_DRIVER:
+			iommu_group_add_device(iommu_group, dev);
+			break;
+
+		case BUS_NOTIFY_UNBOUND_DRIVER:
+			iommu_group_remove_device(dev);
+			break;
+		}
+		iommu_group_put(iommu_group);
+	}
+
+	return 0;
+}
+
+static void rcar_pci_add_bus(struct pci_bus *bus)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct rcar_pci_priv *priv = sys->private_data;
+
+	bus_register_notifier(&pci_bus_type, &priv->bus_notifier);
+}
+
+static void rcar_pci_remove_bus(struct pci_bus *bus)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+	struct rcar_pci_priv *priv = sys->private_data;
+
+	bus_unregister_notifier(&pci_bus_type, &priv->bus_notifier);
+}
+
 static int rcar_pci_probe(struct platform_device *pdev)
 {
 	struct resource *cfg_res, *mem_res;
@@ -372,6 +421,7 @@ static int rcar_pci_probe(struct platfor
 	}
 
 	priv->window_size = SZ_1G;
+	priv->bus_notifier.notifier_call = rcar_pci_bus_notify;
 
 	if (pdev->dev.of_node) {
 		struct resource busnr;
@@ -397,6 +447,8 @@ static int rcar_pci_probe(struct platfor
 	hw.map_irq = rcar_pci_map_irq;
 	hw.ops = &rcar_pci_ops;
 	hw.setup = rcar_pci_setup;
+	hw.add_bus = rcar_pci_add_bus;
+	hw.remove_bus = rcar_pci_remove_bus;
 	pci_common_init_dev(&pdev->dev, &hw);
 	return 0;
 }
