From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 15 Jul 2014 22:56:52 +0000
Subject: [PATCH 2/2] PCI: rcar: Fix GPL v2 license string typo
Message-Id: <20140715225652.22578.86359.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20140715225503.22578.32174.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The proper MODULE_LICENSE() string for the GPL v2 is "GPL v2", not "GPLv2".

Based-on-work-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index f7d3de32c9a0..a393cc60b5a3 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -1003,4 +1003,4 @@ module_platform_driver(rcar_pcie_driver);
 
 MODULE_AUTHOR("Phil Edworthy <phil.edworthy@renesas.com>");
 MODULE_DESCRIPTION("Renesas R-Car PCIe driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");

