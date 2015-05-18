From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 18 May 2015 09:34:25 +0000
Subject: [PATCH 2/2] usb: renesas_usbhs: Add support for R-Car E2
Message-Id: <1431941665-3768-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1431941665-3768-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1431941665-3768-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds a compatible string to support for R-Car E2.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 1 +
 drivers/usb/renesas_usbhs/common.c                      | 6 ++++++
 include/linux/usb/renesas_usbhs.h                       | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index ddbe304..64a4ca6 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible: Must contain one of the following:
 	- "renesas,usbhs-r8a7790"
 	- "renesas,usbhs-r8a7791"
+	- "renesas,usbhs-r8a7794"
   - reg: Base address and length of the register for the USBHS
   - interrupts: Interrupt specifier for the USBHS
   - clocks: A list of phandle + clock specifier pairs
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 0f7e850..954357f 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -472,6 +472,10 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,usbhs-r8a7791",
 		.data = (void *)USBHS_TYPE_R8A7791,
 	},
+	{
+		.compatible = "renesas,usbhs-r8a7794",
+		.data = (void *)USBHS_TYPE_R8A7794,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, usbhs_of_match);
@@ -500,6 +504,7 @@ static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
 	switch (dparam->type) {
 	case USBHS_TYPE_R8A7790:
 	case USBHS_TYPE_R8A7791:
+	case USBHS_TYPE_R8A7794:
 		dparam->has_usb_dmac = 1;
 		break;
 	default:
@@ -561,6 +566,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	switch (priv->dparam.type) {
 	case USBHS_TYPE_R8A7790:
 	case USBHS_TYPE_R8A7791:
+	case USBHS_TYPE_R8A7794:
 		priv->pfunc = usbhs_rcar2_ops;
 		if (!priv->dparam.pipe_type) {
 			priv->dparam.pipe_type = usbhsc_new_pipe_type;
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index e438e72..08c62ba 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -172,6 +172,7 @@ struct renesas_usbhs_driver_param {
 enum {
 	USBHS_TYPE_R8A7790 = 1,
 	USBHS_TYPE_R8A7791,
+	USBHS_TYPE_R8A7794,
 };
 
 /*
-- 
1.9.1

