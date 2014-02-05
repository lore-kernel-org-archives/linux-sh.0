From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:04 +0000
Subject: [PATCH 01/11] pci-rcar-gen2: add of match table
Message-Id: <1391595554-20640-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add OF match table for pci-rcar-gen2 driver for device tree support.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/pci/host/pci-rcar-gen2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index ceec147..ea65bac 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -311,9 +311,17 @@ static int __init rcar_pci_probe(struct platform_device *pdev)
 	return rcar_pci_add_controller(priv);
 }
 
+static struct of_device_id rcar_pci_of_match[] = {
+	{ .compatible = "renesas,pci-r8a7790", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, rcar_pci_of_match);
+
 static struct platform_driver rcar_pci_driver = {
 	.driver = {
 		.name = "pci-rcar-gen2",
+		.of_match_table = rcar_pci_of_match,
 	},
 };
 
-- 
1.8.5.3

