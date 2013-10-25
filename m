From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 25 Oct 2013 17:07:12 +0000
Subject: [PATCH] usb: phy: phy-rcar-gen2-usb: Fix phy initialization
Message-Id: <1382720832-10267-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add missing USB UGCTRL2 register offset.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index a99a695..db3ab34 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -107,10 +107,10 @@ static void __rcar_gen2_usb_phy_init(struct rcar_gen2_usb_phy_priv *priv)
 	clk_prepare_enable(priv->clk);
 
 	/* Set USB channels in the USBHS UGCTRL2 register */
-	val = ioread32(priv->base);
+	val = ioread32(priv->base + USBHS_UGCTRL2_REG);
 	val &= ~(USBHS_UGCTRL2_USB0_HS | USBHS_UGCTRL2_USB2_SS);
 	val |= priv->ugctrl2;
-	iowrite32(val, priv->base);
+	iowrite32(val, priv->base + USBHS_UGCTRL2_REG);
 }
 
 /* Shutdown USB channels */
-- 
1.8.3.1

