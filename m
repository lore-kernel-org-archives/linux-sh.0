From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 02 Nov 2015 16:36:15 +0000
Subject: [PATCH 3/3] PCI: pcie-rcar: Add support for R-Car H3.
Message-Id: <1446482175-26507-4-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446482175-26507-1-git-send-email-phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Harunobu Kurokawa <harunobu.kurokawa.dn-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>

R-Car H3 device is r8a7795

Signed-off-by: Harunobu Kurokawa <harunobu.kurokawa.dn@renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 3 ++-
 drivers/pci/host/pcie-rcar.c                       | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 29d3b98..ab2e75f 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -2,7 +2,8 @@
 
 Required properties:
 - compatible: should contain one of the following
-	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
+	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791",
+	"renesas,pcie-r8a7795"
 - reg: base address and length of the pcie controller registers.
 - #address-cells: set to <3>
 - #size-cells: set to <2>
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 27c0521..2377bf0 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -917,6 +917,7 @@ static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
 	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init },
 	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
+	{ .compatible = "renesas,pcie-r8a7795", .data = rcar_pcie_hw_init },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
-- 
1.9.1

