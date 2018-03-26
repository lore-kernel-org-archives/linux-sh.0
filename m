From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:25:26 +0000
Subject: [PATCH 4/5] arch/sh: pcie-sh7786: add error handling to phy_write_reg()
Message-Id: <20180326212527.12565-5-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Instead of ignoring timeout errors occuring in phy_wait_for_ack(),
propagate them in phy_write_reg(), and check for errors in phy_init().

In phy_init(), we don't really care which PHY write failed, as long as
one of them failed we return an error.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 01a45ce8b2da..88841ceb2f06 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -185,10 +185,11 @@ static int __init pci_wait_for_irq(struct pci_channel *chan, unsigned int mask)
 	return -ETIMEDOUT;
 }
 
-static void __init phy_write_reg(struct pci_channel *chan, unsigned int addr,
-				 unsigned int lane, unsigned int data)
+static int __init phy_write_reg(struct pci_channel *chan, unsigned int addr,
+				unsigned int lane, unsigned int data)
 {
 	unsigned long phyaddr;
+	int ret;
 
 	phyaddr = (1 << BITS_CMD) + ((lane & 0xf) << BITS_LANE) +
 			((addr & 0xff) << BITS_ADR);
@@ -197,13 +198,19 @@ static void __init phy_write_reg(struct pci_channel *chan, unsigned int addr,
 	pci_write_reg(chan, data, SH4A_PCIEPHYDOUTR);
 	pci_write_reg(chan, phyaddr, SH4A_PCIEPHYADRR);
 
-	phy_wait_for_ack(chan, true);
+	ret = phy_wait_for_ack(chan, true);
+	if (ret)
+		return ret;
 
 	/* Clear command */
 	pci_write_reg(chan, 0, SH4A_PCIEPHYDOUTR);
 	pci_write_reg(chan, 0, SH4A_PCIEPHYADRR);
 
-	phy_wait_for_ack(chan, false);
+	ret = phy_wait_for_ack(chan, false);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int __init pcie_clk_init(struct sh7786_pcie_port *port)
@@ -266,25 +273,29 @@ static int __init phy_init(struct sh7786_pcie_port *port)
 {
 	struct pci_channel *chan = port->hose;
 	unsigned int timeout = 100;
+	int ret = 0;
 
 	clk_enable(&port->phy_clk);
 
 	/* Initialize the phy */
-	phy_write_reg(chan, 0x60, 0xf, 0x004b008b);
-	phy_write_reg(chan, 0x61, 0xf, 0x00007b41);
-	phy_write_reg(chan, 0x64, 0xf, 0x00ff4f00);
-	phy_write_reg(chan, 0x65, 0xf, 0x09070907);
-	phy_write_reg(chan, 0x66, 0xf, 0x00000010);
-	phy_write_reg(chan, 0x74, 0xf, 0x0007001c);
-	phy_write_reg(chan, 0x79, 0xf, 0x01fc000d);
-	phy_write_reg(chan, 0xb0, 0xf, 0x00000610);
+	ret |= phy_write_reg(chan, 0x60, 0xf, 0x004b008b);
+	ret |= phy_write_reg(chan, 0x61, 0xf, 0x00007b41);
+	ret |= phy_write_reg(chan, 0x64, 0xf, 0x00ff4f00);
+	ret |= phy_write_reg(chan, 0x65, 0xf, 0x09070907);
+	ret |= phy_write_reg(chan, 0x66, 0xf, 0x00000010);
+	ret |= phy_write_reg(chan, 0x74, 0xf, 0x0007001c);
+	ret |= phy_write_reg(chan, 0x79, 0xf, 0x01fc000d);
+	ret |= phy_write_reg(chan, 0xb0, 0xf, 0x00000610);
 
 	/* Deassert Standby */
-	phy_write_reg(chan, 0x67, 0x1, 0x00000400);
+	ret |= phy_write_reg(chan, 0x67, 0x1, 0x00000400);
 
 	/* Disable clock */
 	clk_disable(&port->phy_clk);
 
+	if (ret)
+		return ret;
+
 	while (timeout--) {
 		if (pci_read_reg(chan, SH4A_PCIEPHYSR))
 			return 0;
-- 
2.14.3

