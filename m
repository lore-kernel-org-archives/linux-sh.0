From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 18 Sep 2015 06:03:52 +0000
Subject: [PATCH] usb: renesas_usbhs: Add support for R-Car H3
Message-Id: <1442556232-6564-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds a compatible string to support for R-Car H3.

Since the HS-USB controller of R-Car H3 is almost the same specification
with R-Car Gen2 (these have 16 pipes and usb-dmac), this patch
sets the "type" of renesas_usbhs_driver_param to USBHS_TYPE_RCAR_GEN2.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the latest Felipe's usb.git / testing/next
branch (The commit id = b1ede0faf6e4961842f80e5e2fc1bf5373fef235).

 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
 drivers/usb/renesas_usbhs/common.c                      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 64a4ca6..7d48f63 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -5,6 +5,7 @@ Required properties:
 	- "renesas,usbhs-r8a7790"
 	- "renesas,usbhs-r8a7791"
 	- "renesas,usbhs-r8a7794"
+	- "renesas,usbhs-r8a7795"
   - reg: Base address and length of the register for the USBHS
   - interrupts: Interrupt specifier for the USBHS
   - clocks: A list of phandle + clock specifier pairs
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 7b98e1d..2becd6b 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -476,6 +476,10 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,usbhs-r8a7794",
 		.data = (void *)USBHS_TYPE_RCAR_GEN2,
 	},
+	{
+		.compatible = "renesas,usbhs-r8a7795",
+		.data = (void *)USBHS_TYPE_RCAR_GEN2,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, usbhs_of_match);
-- 
1.9.1

