From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 05 Jan 2016 13:00:27 +0000
Subject: [PATCH v2 0/4] Various R-Car PCIe patches
Message-Id: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

The first patch removes code that is no longer used. The next two allow us to
use runtim PM. The last patch is for PHY setup in order to get PCIe compliance
apparently. For that last patch, I've been told that this is what I must set.

v2:
 PATCH 2/4 - Use readl_poll_timeout_atomic when waiting until we are in L1.
 PATCh 4/4 - Added comment about where the PHY settings come from.

Phil Edworthy (4):
  PCI: rcar: remove unused pci_sys_data structure in pcie-rcar
  PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
  PCI: rcar: Add runtime PM support to pcie-rcar
  PCI: rcar: Add Gen2 PHY setup to pcie-rcar

 drivers/pci/host/pcie-rcar.c | 115 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 91 insertions(+), 24 deletions(-)

-- 
2.5.0

