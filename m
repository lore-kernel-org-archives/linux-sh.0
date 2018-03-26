From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:25:27 +0000
Subject: [PATCH 5/5] arch/sh: pcie-sh7786: do not disable MAC data scrambling
Message-Id: <20180326212527.12565-6-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The code enables MAC data scrambling, and then later disables
it. Disabling MAC data is mostly a debugging feature, data scrambling
should normally be enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 88841ceb2f06..ca72e838ce62 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -427,11 +427,6 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 	data |= PCIEDLINTENR_DLL_ACT_ENABLE;
 	pci_write_reg(chan, data, SH4A_PCIEDLINTENR);
 
-	/* Disable MAC data scrambling. */
-	data = pci_read_reg(chan, SH4A_PCIEMACCTLR);
-	data |= PCIEMACCTLR_SCR_DIS | (0xff << 16);
-	pci_write_reg(chan, data, SH4A_PCIEMACCTLR);
-
 	/*
 	 * This will timeout if we don't have a link, but we permit the
 	 * port to register anyways in order to support hotplug on future
-- 
2.14.3

