From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 05:52:59 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB phy initialisation function is needed from not only
USB Host but also USB Function too.
This patch adds usb phy common control function.

Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7778.c |   35 ++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 2a101eb..cd98079 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -109,29 +109,44 @@ void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
 					  pdata, sizeof(*pdata));
 }
 
-/* USB */
-static struct usb_phy *phy;
-
-static int usb_power_on(struct platform_device *pdev)
+static int r8a7778_usb_phy_power(int enable)
 {
+	static struct usb_phy *phy = NULL;
+	int ret = 0;
+
+	if (!phy)
+		phy = usb_get_phy(USB_PHY_TYPE_USB2);
+
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
+	if (enable)
+		ret = usb_phy_init(phy);
+	else
+		usb_phy_shutdown(phy);
+
+	return ret;
+}
+
+/* USB */
+static int usb_power_on(struct platform_device *pdev)
+{
+	int ret = r8a7778_usb_phy_power(1);
+
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	usb_phy_init(phy);
-
 	return 0;
 }
 
 static void usb_power_off(struct platform_device *pdev)
 {
-	if (IS_ERR(phy))
+	if (r8a7778_usb_phy_power(0))
 		return;
 
-	usb_phy_shutdown(phy);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
@@ -359,8 +374,6 @@ void __init r8a7778_add_standard_devices(void)
 
 void __init r8a7778_init_late(void)
 {
-	phy = usb_get_phy(USB_PHY_TYPE_USB2);
-
 	platform_device_register_full(&ehci_info);
 	platform_device_register_full(&ohci_info);
 }
-- 
1.7.9.5

