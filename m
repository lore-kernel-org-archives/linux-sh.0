From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 02 Dec 2015 22:51:37 +0000
Subject: [PATCH v2 1/4] PCI: rcar-gen2: add gen2 fallback compatibility string
Message-Id: <1449096700-23304-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449096700-23304-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility string for R-Car Gen 2 family.
This is in keeping with the fallback scheme being adopted wherever
appropriate for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Include "rcar-" in new compatibility string
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 11 +++++++++--
 drivers/pci/host/pci-rcar-gen2.c                        |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 891463cb09c2..089a99dcdf10 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -8,7 +8,14 @@ OHCI and EHCI controllers.
 Required properties:
 - compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
-	      "renesas,pci-r8a7794" for the R8A7794 SoC.
+	      "renesas,pci-r8a7794" for the R8A7794 SoC;
+	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device.
+
+
+	      When compatible with the generic version, nodes must list the
+	      SoC-specific version corresponding to the platform first
+	      followed by the generic version.
+
 - reg:	A list of physical regions to access the device: the first is
 	the operational registers for the OHCI/EHCI controllers and the
 	second is for the bridge configuration and control registers.
@@ -32,7 +39,7 @@ Optional properties:
 Example SoC configuration:
 
 	pci0: pci@ee090000  {
-		compatible = "renesas,pci-r8a7790";
+		compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
 		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
 		reg = <0x0 0xee090000 0x0 0xc00>,
 		      <0x0 0xee080000 0x0 0x1100>;
diff --git a/drivers/pci/host/pci-rcar-gen2.c b/drivers/pci/host/pci-rcar-gen2.c
index 62951165dcbb..9980a4bdae7e 100644
--- a/drivers/pci/host/pci-rcar-gen2.c
+++ b/drivers/pci/host/pci-rcar-gen2.c
@@ -430,6 +430,7 @@ static int rcar_pci_probe(struct platform_device *pdev)
 }
 
 static struct of_device_id rcar_pci_of_match[] = {
+	{ .compatible = "renesas,pci-rcar-gen2", },
 	{ .compatible = "renesas,pci-r8a7790", },
 	{ .compatible = "renesas,pci-r8a7791", },
 	{ .compatible = "renesas,pci-r8a7794", },
-- 
2.1.4

