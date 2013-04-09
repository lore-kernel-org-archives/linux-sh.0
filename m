From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Apr 2013 22:50:18 +0000
Subject: [PATCH 1/4] rcar-phy: add R8A7778 support
Message-Id: <201304100250.19197.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The driver currently only supports R8A7779 SoC. Compared to it, R8A7778 USB-PHY
has extra register range containing two high-speed signal quality characteristic
control registers which should be set up  during USB-PHY  startup depending on
whether a ferrite bead is in use or not.  So, we now handle an optional second
memory range in the driver's probe method, add the 'ferrite_bead' field to the
driver's platform data, and add an extra (optional) step to the USB-PHY startup
routine which sets up the extended registers.

Also mark in the driver's Kconfig section  that R8A7778 is  now supported and
generally clarify that section, uppercasing the word "phy", while at it... 

The patch has been tested on the Marzen and BOCK-W boards.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/usb/phy/Kconfig      |    8 ++++----
 drivers/usb/phy/rcar-phy.c   |   31 +++++++++++++++++++++++++++----
 include/linux/usb/rcar-phy.h |    7 +++++--
 3 files changed, 36 insertions(+), 10 deletions(-)

Index: renesas/drivers/usb/phy/Kconfig
=================================--- renesas.orig/drivers/usb/phy/Kconfig
+++ renesas/drivers/usb/phy/Kconfig
@@ -55,13 +55,13 @@ config MV_U3D_PHY
 	  SoC.
 
 config USB_RCAR_PHY
-	tristate "Renesas R-Car USB phy support"
+	tristate "Renesas R-Car USB PHY support"
 	depends on USB || USB_GADGET
 	select USB_OTG_UTILS
 	help
-	  Say Y here to add support for the Renesas R-Car USB phy driver.
-	  This chip is typically used as USB phy for USB host, gadget.
-	  This driver supports: R8A7779
+	  Say Y here to add support for the Renesas R-Car USB common PHY driver.
+	  This device is typically used as USB PHY for USB host, gadget.
+	  This driver supports R8A7778 and R8A7779.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rcar-phy.
Index: renesas/drivers/usb/phy/rcar-phy.c
=================================--- renesas.orig/drivers/usb/phy/rcar-phy.c
+++ renesas/drivers/usb/phy/rcar-phy.c
@@ -26,6 +26,10 @@
 #define USBOH0		0x1C
 #define USBCTL0		0x58
 
+/* High-speed signal quality characteristic control registers (R8A7778 only) */
+#define HSQCTL1		0x24
+#define HSQCTL2		0x28
+
 /* USBPCTRL1 */
 #define PHY_RST		(1 << 2)
 #define PLL_ENB		(1 << 1)
@@ -40,6 +44,7 @@ struct rcar_usb_phy_priv {
 	spinlock_t lock;
 
 	void __iomem *reg0;
+	void __iomem *reg1;
 	int counter;
 };
 
@@ -59,6 +64,7 @@ static int rcar_usb_phy_init(struct usb_
 	struct device *dev = phy->dev;
 	struct rcar_phy_platform_data *pdata = dev->platform_data;
 	void __iomem *reg0 = priv->reg0;
+	void __iomem *reg1 = priv->reg1;
 	int i;
 	u32 val;
 	unsigned long flags;
@@ -76,7 +82,16 @@ static int rcar_usb_phy_init(struct usb_
 		/* (2) start USB-PHY internal PLL */
 		iowrite32(PHY_ENB | PLL_ENB, (reg0 + USBPCTRL1));
 
-		/* (3) USB module status check */
+		/* (3) set USB-PHY in accord with the conditions of usage */
+		if (reg1) {
+			u32 hsqctl1 = pdata->ferrite_bead ? 0x41 : 0;
+			u32 hsqctl2 = pdata->ferrite_bead ? 0x0d : 7;
+
+			iowrite32(hsqctl1, reg1 + HSQCTL1);
+			iowrite32(hsqctl2, reg1 + HSQCTL2);
+		}
+
+		/* (4) USB module status check */
 		for (i = 0; i < 1024; i++) {
 			udelay(10);
 			val = ioread32(reg0 + USBST);
@@ -89,7 +104,7 @@ static int rcar_usb_phy_init(struct usb_
 			goto phy_init_end;
 		}
 
-		/* (4) USB-PHY reset clear */
+		/* (5) USB-PHY reset clear */
 		iowrite32(PHY_ENB | PLL_ENB | PHY_RST, (reg0 + USBPCTRL1));
 
 		/* set platform specific port settings */
@@ -129,9 +144,9 @@ static void rcar_usb_phy_shutdown(struct
 static int rcar_usb_phy_probe(struct platform_device *pdev)
 {
 	struct rcar_usb_phy_priv *priv;
-	struct resource *res0;
+	struct resource *res0, *res1;
 	struct device *dev = &pdev->dev;
-	void __iomem *reg0;
+	void __iomem *reg0, *reg1 = NULL;
 	int ret;
 
 	if (!pdev->dev.platform_data) {
@@ -149,6 +164,13 @@ static int rcar_usb_phy_probe(struct pla
 	if (IS_ERR(reg0))
 		return PTR_ERR(reg0);
 
+	res1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res1) {
+		reg1 = devm_ioremap_resource(dev, res1);
+		if (IS_ERR(reg1))
+			return PTR_ERR(reg1);
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv) {
 		dev_err(dev, "priv data allocation error\n");
@@ -156,6 +178,7 @@ static int rcar_usb_phy_probe(struct pla
 	}
 
 	priv->reg0		= reg0;
+	priv->reg1		= reg1;
 	priv->counter		= 0;
 	priv->phy.dev		= dev;
 	priv->phy.label		= dev_name(dev);
Index: renesas/include/linux/usb/rcar-phy.h
=================================--- renesas.orig/include/linux/usb/rcar-phy.h
+++ renesas/include/linux/usb/rcar-phy.h
@@ -14,13 +14,15 @@
 #include <linux/types.h>
 
 /* USBPCTRL0 register bits */
-#define USBPCTRL0_OVC2	BIT(10)	/* Switches the OVC input pin for port 2: */
+#define USBPCTRL0_OVC2	BIT(10)	/* (R8A7779 only)			*/
+				/* Switches the OVC input pin for port 2: */
 				/* 1: USB_OVC2, 0: OVC2			*/
 #define USBPCTRL0_OVC1_VBUS1 BIT(9) /* Switches the OVC input pin for port 1: */
 				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
 #define USBPCTRL0_OVC0	BIT(8)	/* Switches the OVC input pin for port 0: */
 				/* 1: USB_OVC0 pin, 0: OVC0		*/
-#define USBPCTRL0_OVC2_ACT BIT(6) /* Host mode: OVC2 polarity:		*/
+#define USBPCTRL0_OVC2_ACT BIT(6) /* (R8A7779 only)			*/
+				/* Host mode: OVC2 polarity:		*/
 				/* 1: active-high, 0: active-low	*/
 				/* Function mode: be sure to set to 1	*/
 #define USBPCTRL0_PENC	BIT(4)	/* Function mode: output level of PENC1 pin: */
@@ -35,6 +37,7 @@
 
 struct rcar_phy_platform_data {
 	u32 usbpctrl0;		/* USBPCTRL0 register value */
+	bool ferrite_bead;	/* (R8A7778 only) */
 };
 
 #endif /* __RCAR_PHY_H */
