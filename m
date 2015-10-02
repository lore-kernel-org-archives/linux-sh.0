From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 02 Oct 2015 10:25:06 +0000
Subject: [PATCH 3/4] PCI: rcar-pcie: Set root bus nr to that provided in DT
Message-Id: <1443781507-5011-4-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

On ARM64, setting the root bus number to -1 causes probe failure.
Moreover, we should use the bus number specified in the DT as we
could have multiple PCIe controllers with different bus ranges.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 6057e31..8e583c2 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -362,7 +362,7 @@ static int rcar_pcie_setup(int nr, struct list_head *resource, struct rcar_pcie
 	struct resource *res;
 	int i;
 
-	pcie->root_bus_nr = -1;
+	pcie->root_bus_nr = pcie->busn.start;
 
 	/* Setup PCI resources */
 	for (i = 0; i < RCAR_PCI_MAX_RESOURCES; i++) {
-- 
1.9.1

