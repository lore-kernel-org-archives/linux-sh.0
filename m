From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 26 Mar 2018 21:25:22 +0000
Subject: [PATCH 0/5] arch/sh: additional SH7786 PCIe fixes
Message-Id: <20180326212527.12565-1-thomas.petazzoni@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Now that my first series of SH7786 PCIe fixes has been merged by Rich
Felker, here is an additional smaller series making more SH7786 PCIe
fixes.

Thanks!

Thomas

Thomas Petazzoni (5):
  drivers/sh/clk: add support for CLK_SET_TO_ENABLE flag
  arch/sh: pcie-sh7786: set CLK_SET_TO_ENABLE on the PCIe PHY clock
  arch/sh: pcie-sh7786: properly wait for PHY operations ACK
  arch/sh: pcie-sh7786: add error handling to phy_write_reg()
  arch/sh: pcie-sh7786: do not disable MAC data scrambling

 arch/sh/drivers/pci/pcie-sh7786.c | 52 ++++++++++++++++++++++++---------------
 drivers/sh/clk/cpg.c              | 10 ++++++--
 include/linux/sh_clk.h            |  2 ++
 3 files changed, 42 insertions(+), 22 deletions(-)

-- 
2.14.3

