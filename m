From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 18 May 2015 09:33:47 +0000
Subject: [PATCH] phy: rcar-gen2: Add support for R-Car E2
Message-Id: <1431941627-1720-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kishon@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, sergei.shtylyov@cogentembedded.com
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds a compatible string to support for R-Car E2.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 1 +
 drivers/phy/phy-rcar-gen2.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index 00fc52a..d564ba4 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -6,6 +6,7 @@ This file provides information on what the device node for the R-Car generation
 Required properties:
 - compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
+	      "renesas,usb-phy-r8a7794" if the device is a part of R8A7794 SoC.
 - reg: offset and length of the register block.
 - #address-cells: number of address cells for the USB channel subnodes, must
 		  be <1>.
diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index f47bfd8..0050301 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -195,6 +195,7 @@ static struct phy_ops rcar_gen2_phy_ops = {
 static const struct of_device_id rcar_gen2_phy_match_table[] = {
 	{ .compatible = "renesas,usb-phy-r8a7790" },
 	{ .compatible = "renesas,usb-phy-r8a7791" },
+	{ .compatible = "renesas,usb-phy-r8a7794" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_gen2_phy_match_table);
-- 
1.9.1

