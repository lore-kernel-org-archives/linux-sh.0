From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 29 Oct 2013 16:21:06 +0000
Subject: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB phy controls USB channels 0 and 2 which are shared between
PCI USB host controllers and USBHS/USBSS respectively.

This Initializes USB phy driver earlier because we need it
before PCI USB host controllers are initialized.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 drivers/usb/phy/phy-rcar-gen2-usb.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
index db3ab34..32c8847 100644
--- a/drivers/usb/phy/phy-rcar-gen2-usb.c
+++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
@@ -241,7 +241,17 @@ static struct platform_driver rcar_gen2_usb_phy_driver = {
 	.remove = rcar_gen2_usb_phy_remove,
 };
 
-module_platform_driver(rcar_gen2_usb_phy_driver);
+static int __init rcar_gen2_usb_phy_mod_init(void)
+{
+	return platform_driver_register(&rcar_gen2_usb_phy_driver);
+}
+postcore_initcall(rcar_gen2_usb_phy_mod_init);
+
+static void __exit rcar_gen2_usb_phy_mod_exit(void)
+{
+	platform_driver_unregister(&rcar_gen2_usb_phy_driver);
+}
+module_exit(rcar_gen2_usb_phy_mod_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Renesas R-Car Gen2 USB phy");
-- 
1.8.3.1

