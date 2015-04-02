From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Apr 2015 11:22:34 +0000
Subject: [PATCH] usb: phy: rcar-gen2-usb: Fix USBHS_UGSTS_LOCK value
Message-Id: <1427973754-4868-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to the technical update (No. TN-RCS-B011A/E), the UGSTS LOCK
bit location is bit 8, not bits 9 and 8. So, this patch fixes the
USBHS_UGSTS_LOCK value.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index f838084..f81800b 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -47,7 +47,7 @@ struct rcar_gen2_usb_phy_priv {
 
 /* USB General status register */
 #define USBHS_UGSTS_REG			0x88
-#define USBHS_UGSTS_LOCK		(3 << 8)
+#define USBHS_UGSTS_LOCK		(1 << 8)
 
 /* Enable USBHS internal phy */
 static int __rcar_gen2_usbhs_phy_enable(void __iomem *base)
-- 
1.9.1

