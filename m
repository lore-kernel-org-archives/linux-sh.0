From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 01 Jun 2013 22:08:47 +0000
Subject: [PATCH v8 1/3] phy-rcar-usb: add R8A7778 support
Message-Id: <201306020208.48360.sergei.shtylyov@cogentembedded.com>
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

Also mark in the driver's Kconfig section  that R8A7778 is now supported and
generally clarify that section, uppercasing the word "phy" and also changing
the module name that got lost in the big driver rename, while at it... 

The patch has been tested on the Marzen and BOCK-W boards.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Felipe Balbi <balbi@ti.com>

---
Changes since version 7:
- renamed the PHY driver and changed the patch subject accordingly;
- changed the module name mentioned in the driver's Kconfig entry;
- resolved rejects.

Changes since version 5:
- renamed the header file into <linux/platform_data/usb-rcar-phy.h>.

Changes since version 3:
- removed stray debugging printk() call.

Changes since version 2:
- moved 'ferrite_bead' bitfield to the start of 'struct rcar_phy_platform_data'
  which allowed to cut the size of the structure from 8 bytes back to 4;
- added a comment about only 2 USB ports on R8A7778'
- added an ACK from Felipe Balbi.

Changes since the original posting:
- made the necessary changes atop of the R8A7779/Marzen pathset version 4.

 drivers/usb/phy/Kconfig                    |   10 +++----
 drivers/usb/phy/phy-rcar-usb.c             |   37 ++++++++++++++++++++++++-----
 include/linux/platform_data/usb-rcar-phy.h |    4 ++-
 3 files changed, 39 insertions(+), 12 deletions(-)

Index: renesas/drivers/usb/phy/Kconfig
=================================--- renesas.orig/drivers/usb/phy/Kconfig
+++ renesas/drivers/usb/phy/Kconfig
@@ -181,15 +181,15 @@ config USB_MXS_PHY
 	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
 
 config USB_RCAR_PHY
-	tristate "Renesas R-Car USB phy support"
+	tristate "Renesas R-Car USB PHY support"
 	depends on USB || USB_GADGET
 	help
-	  Say Y here to add support for the Renesas R-Car USB phy driver.
-	  This chip is typically used as USB phy for USB host, gadget.
-	  This driver supports: R8A7779
+	  Say Y here to add support for the Renesas R-Car USB common PHY driver.
+	  This chip is typically used as USB PHY for USB host, gadget.
+	  This driver supports R8A7778 and R8A7779.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called rcar-phy.
+	  module will be called phy-rcar-usb.
 
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
Index: renesas/drivers/usb/phy/phy-rcar-usb.c
=================================--- renesas.orig/drivers/usb/phy/phy-rcar-usb.c
+++ renesas/drivers/usb/phy/phy-rcar-usb.c
@@ -26,15 +26,21 @@
 #define USBOH0		0x1C
 #define USBCTL0		0x58
 
+/* High-speed signal quality characteristic control registers (R8A7778 only) */
+#define HSQCTL1		0x24
+#define HSQCTL2		0x28
+
 /* USBPCTRL0 */
-#define OVC2		(1 << 10) /* Switches the OVC input pin for port 2: */
+#define OVC2		(1 << 10) /* (R8A7779 only)			*/
+				/* Switches the OVC input pin for port 2: */
 				/* 1: USB_OVC2, 0: OVC2			*/
 #define OVC1_VBUS1	(1 << 9) /* Switches the OVC input pin for port 1: */
 				/* 1: USB_OVC1, 0: OVC1/VBUS1		*/
 				/* Function mode: set to 0		*/
 #define OVC0		(1 << 8) /* Switches the OVC input pin for port 0: */
 				/* 1: USB_OVC0 pin, 0: OVC0		*/
-#define OVC2_ACT 	(1 << 6) /* Host mode: OVC2 polarity:		*/
+#define OVC2_ACT 	(1 << 6) /* (R8A7779 only)			*/
+				/* Host mode: OVC2 polarity:		*/
 				/* 1: active-high, 0: active-low	*/
 #define PENC		(1 << 4) /* Function mode: output level of PENC1 pin: */
 				/* 1: high, 0: low			*/
@@ -59,6 +65,7 @@ struct rcar_usb_phy_priv {
 	spinlock_t lock;
 
 	void __iomem *reg0;
+	void __iomem *reg1;
 	int counter;
 };
 
@@ -78,6 +85,7 @@ static int rcar_usb_phy_init(struct usb_
 	struct device *dev = phy->dev;
 	struct rcar_phy_platform_data *pdata = dev->platform_data;
 	void __iomem *reg0 = priv->reg0;
+	void __iomem *reg1 = priv->reg1;
 	static const u8 ovcn_act[] = { OVC0_ACT, OVC1_ACT, OVC2_ACT };
 	int i;
 	u32 val;
@@ -96,7 +104,16 @@ static int rcar_usb_phy_init(struct usb_
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
@@ -109,7 +126,7 @@ static int rcar_usb_phy_init(struct usb_
 			goto phy_init_end;
 		}
 
-		/* (4) USB-PHY reset clear */
+		/* (5) USB-PHY reset clear */
 		iowrite32(PHY_ENB | PLL_ENB | PHY_RST, (reg0 + USBPCTRL1));
 
 		/* Board specific port settings */
@@ -162,9 +179,9 @@ static void rcar_usb_phy_shutdown(struct
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
@@ -182,6 +199,13 @@ static int rcar_usb_phy_probe(struct pla
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
@@ -189,6 +213,7 @@ static int rcar_usb_phy_probe(struct pla
 	}
 
 	priv->reg0		= reg0;
+	priv->reg1		= reg1;
 	priv->counter		= 0;
 	priv->phy.dev		= dev;
 	priv->phy.label		= dev_name(dev);
Index: renesas/include/linux/platform_data/usb-rcar-phy.h
=================================--- renesas.orig/include/linux/platform_data/usb-rcar-phy.h
+++ renesas/include/linux/platform_data/usb-rcar-phy.h
@@ -13,6 +13,8 @@
 #include <linux/types.h>
 
 struct rcar_phy_platform_data {
+	bool ferrite_bead:1;	/* (R8A7778 only)			*/
+
 	bool port1_func:1;	/* true: port 1 used by function, false: host */
 	unsigned penc1:1;	/* Output of the PENC1 pin in function mode */
 	struct {		/* Overcurrent pin control for ports 0..2 */
@@ -20,7 +22,7 @@ struct rcar_phy_platform_data {
 				/* Set to false on port 1 in function mode */
 		bool active_high:1; /* true: active  high, false: active low */
 				/* Set to true  on port 1 in function mode */
-	} ovc_pin[3];
+	} ovc_pin[3];		/* (R8A7778 only has 2 ports)		*/
 };
 
 #endif /* __USB_RCAR_PHY_H */
