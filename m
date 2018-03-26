From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:25:24 +0000
Subject: [PATCH 2/5] arch/sh: pcie-sh7786: set CLK_SET_TO_ENABLE on the PCIe PHY clock
Message-Id: <20180326212527.12565-3-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PCIe PHY clock (bit 0 of register SH4A_PCIEPHYCTRL) is enabled by
setting the bit, and disabled by clearing the bit, so let's use the
CLK_SET_TO_ENABLE flag to tell this to the SH clock subsystem.

Without this, the clock is effectively disabled when it's needed, and
enabled when not.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 382e7ecf4c82..29df5c6fe22c 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -240,6 +240,7 @@ static int __init pcie_clk_init(struct sh7786_pcie_port *port)
 	clk->parent = &fixed_pciexclkp;
 	clk->enable_reg = (void __iomem *)(chan->reg_base + SH4A_PCIEPHYCTLR);
 	clk->enable_bit = BITS_CKE;
+	clk->flags = CLK_SET_TO_ENABLE;
 
 	ret = sh_clk_mstp_register(clk, 1);
 	if (unlikely(ret < 0))
-- 
2.14.3

