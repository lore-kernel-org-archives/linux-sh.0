From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 02 Oct 2015 10:25:04 +0000
Subject: [PATCH 1/4] PCI: rcar-pcie: Make PCI aware of the IO resources
Message-Id: <1443781507-5011-2-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1443781507-5011-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 7678fe0..27e2c20 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -373,8 +373,9 @@ static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
 		if (res->flags & IORESOURCE_IO) {
 			phys_addr_t io_start = pci_pio_to_address(res->start);
 			pci_ioremap_io(nr * SZ_64K, io_start);
-		} else
-			pci_add_resource(&sys->resources, res);
+		}
+
+		pci_add_resource(&sys->resources, res);
 	}
 	pci_add_resource(&sys->resources, &pcie->busn);
 
-- 
1.9.1

