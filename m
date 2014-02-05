From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:14 +0000
Subject: [PATCH 11/11] PCI: rcar: fix bridge logic configuration accesses
Message-Id: <1391595554-20640-12-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The bridge logic at slot 0 only supports reads up to 0x40 and the
rest of the PCI configuration space for this slot is marked as
reserved in the manual.

Trying a read from offset 0x100 is producing an error from the
bridge. With error interrupts enabled, the following is printed:

pci-rcar-gen2 ee0d0000.pci: error irq: status 00000014

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
---
 drivers/pci/host/pci-rcar-gen2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index ddaa3e8..4b35ac5 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -119,6 +119,10 @@ static void __iomem *rcar_pci_cfg_base(struct pci_bus *bus, unsigned int devfn,
 	if (slot > 2)
 		return NULL;
 
+	/* bridge logic only has registers to 0x40 */
+	if (slot = 0x0 && where >= 0x40)
+		return NULL;
+
 	val = slot ? RCAR_AHBPCI_WIN1_DEVICE | RCAR_AHBPCI_WIN_CTR_CFG :
 		     RCAR_AHBPCI_WIN1_HOST | RCAR_AHBPCI_WIN_CTR_CFG;
 
-- 
1.8.5.3

