From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:13 +0000
Subject: [PATCH 10/11] PCI: rcar: add error interrupt handling
Message-Id: <1391595554-20640-11-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add option to enable interrupts to report any errors from
the AHB-PCI bridge to help find any issues with the bridge
when in use.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v2:
	- removed kconfig entry and use CONFIG_PCI_DEBUG
	- check for irq > 0 before trying to attach irq

Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 drivers/pci/host/pci-rcar-gen2.c | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 674f7fe..ddaa3e8 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -39,9 +39,26 @@
 
 #define RCAR_PCI_INT_ENABLE_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x20)
 #define RCAR_PCI_INT_STATUS_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x24)
+#define RCAR_PCI_INT_SIGTABORT		(1 << 0)
+#define RCAR_PCI_INT_SIGRETABORT	(1 << 1)
+#define RCAR_PCI_INT_REMABORT		(1 << 2)
+#define RCAR_PCI_INT_PERR		(1 << 3)
+#define RCAR_PCI_INT_SIGSERR		(1 << 4)
+#define RCAR_PCI_INT_RESERR		(1 << 5)
+#define RCAR_PCI_INT_WIN1ERR		(1 << 12)
+#define RCAR_PCI_INT_WIN2ERR		(1 << 13)
 #define RCAR_PCI_INT_A			(1 << 16)
 #define RCAR_PCI_INT_B			(1 << 17)
 #define RCAR_PCI_INT_PME		(1 << 19)
+#define RCAR_PCI_INT_ALLERRORS (RCAR_PCI_INT_SIGTABORT		| \
+				RCAR_PCI_INT_SIGRETABORT	| \
+				RCAR_PCI_INT_SIGRETABORT	| \
+				RCAR_PCI_INT_REMABORT		| \
+				RCAR_PCI_INT_PERR		| \
+				RCAR_PCI_INT_SIGSERR		| \
+				RCAR_PCI_INT_RESERR		| \
+				RCAR_PCI_INT_WIN1ERR		| \
+				RCAR_PCI_INT_WIN2ERR)
 
 #define RCAR_AHB_BUS_CTR_REG		(RCAR_AHBPCI_PCICOM_OFFSET + 0x30)
 #define RCAR_AHB_BUS_MMODE_HTRANS	(1 << 0)
@@ -164,6 +181,46 @@ static int __init rcar_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return priv->irq;
 }
 
+#ifdef CONFIG_PCI_DEBUG
+/* if debug enabled, then attach an error handler irq to the bridge */
+
+static irqreturn_t rcar_pci_err_irq(int irq, void *pw)
+{
+	struct rcar_pci_priv *priv = pw;
+	u32 status = ioread32(priv->reg + RCAR_PCI_INT_STATUS_REG);
+
+	if (status & RCAR_PCI_INT_ALLERRORS) {
+		dev_err(priv->dev, "error irq: status %08x\n", status);
+
+		/* clear the error(s) */
+		iowrite32(status & RCAR_PCI_INT_ALLERRORS,
+			  priv->reg + RCAR_PCI_INT_STATUS_REG);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static void rcar_pci_setup_errirq(struct rcar_pci_priv *priv)
+{
+	int ret;
+	u32 val;
+
+	ret = devm_request_irq(priv->dev, priv->irq, rcar_pci_err_irq,
+			       IRQF_SHARED, "error irq", priv);
+	if (ret) {
+		dev_err(priv->dev, "cannot claim IRQ for error handling\n");
+		return;
+	}
+
+	val = ioread32(priv->reg + RCAR_PCI_INT_ENABLE_REG);
+	val |= RCAR_PCI_INT_ALLERRORS;
+	iowrite32(val, priv->reg + RCAR_PCI_INT_ENABLE_REG);
+}
+#else
+static inline void rcar_pci_setup_errirq(struct rcar_pci_priv *priv) { }
+#endif
+
 /* PCI host controller setup */
 static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
 {
@@ -224,6 +281,9 @@ static int __init rcar_pci_setup(int nr, struct pci_sys_data *sys)
 	iowrite32(RCAR_PCI_INT_A | RCAR_PCI_INT_B | RCAR_PCI_INT_PME,
 		  reg + RCAR_PCI_INT_ENABLE_REG);
 
+	if (priv->irq > 0)
+		rcar_pci_setup_errirq(priv);
+
 	/* Add PCI resources */
 	pci_add_resource(&sys->resources, &priv->io_res);
 	pci_add_resource(&sys->resources, &priv->mem_res);
-- 
1.8.5.3

