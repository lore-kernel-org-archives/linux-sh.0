From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:25:25 +0000
Subject: [PATCH 3/5] arch/sh: pcie-sh7786: properly wait for PHY operations ACK
Message-Id: <20180326212527.12565-4-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When doing a PHY write, the following sequence must be done:

 - Write the PCIEPHYDOUTR and PCIEPHYADDR registers
 - Wait for the ACK bit to be set
 - Clear the PCIEPHYDOUTR and PCIEPHYADDR registers
 - Wait for the ACK bit to clear

However, in the last step, the current code waits for the ACK bit to
be set, which is not correct, and does not match the SH7786 datasheet.

This commit fixes that by improving the phy_wait_for_ack() to indicate
whether we want to wait for the ACK bit to be set or cleared, and then
use this new argument in phy_write_reg().

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 29df5c6fe22c..01a45ce8b2da 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -152,12 +152,17 @@ static void sh7786_pci_fixup(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RENESAS, PCI_DEVICE_ID_RENESAS_SH7786,
 			 sh7786_pci_fixup);
 
-static int __init phy_wait_for_ack(struct pci_channel *chan)
+static int phy_wait_for_ack(struct pci_channel *chan, bool set)
 {
 	unsigned int timeout = 100;
 
 	while (timeout--) {
-		if (pci_read_reg(chan, SH4A_PCIEPHYADRR) & (1 << BITS_ACK))
+		int state +			pci_read_reg(chan, SH4A_PCIEPHYADRR) & (1 << BITS_ACK);
+		if (set && state)
+			return 0;
+
+		if (!set && !state)
 			return 0;
 
 		udelay(100);
@@ -192,13 +197,13 @@ static void __init phy_write_reg(struct pci_channel *chan, unsigned int addr,
 	pci_write_reg(chan, data, SH4A_PCIEPHYDOUTR);
 	pci_write_reg(chan, phyaddr, SH4A_PCIEPHYADRR);
 
-	phy_wait_for_ack(chan);
+	phy_wait_for_ack(chan, true);
 
 	/* Clear command */
 	pci_write_reg(chan, 0, SH4A_PCIEPHYDOUTR);
 	pci_write_reg(chan, 0, SH4A_PCIEPHYADRR);
 
-	phy_wait_for_ack(chan);
+	phy_wait_for_ack(chan, false);
 }
 
 static int __init pcie_clk_init(struct sh7786_pcie_port *port)
-- 
2.14.3

