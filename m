From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 31 Jul 2013 06:19:17 +0000
Subject: [PATCH 1/2 v2] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <87r4efb6al.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB phy initialisation function is needed from not only
USB Host but also USB Function too.
This patch adds usb phy common control function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on renesas-devel-20130731

 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   37 +++++++++++++++++--------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 41fd6da..b5706fb 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -32,4 +32,6 @@ extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
 
+extern int r8a7778_usb_phy_power(bool enable);
+
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 1a154d4..b65044a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -95,29 +95,46 @@ static struct sh_timer_config sh_tmu1_platform_data __initdata = {
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
-/* USB */
-static struct usb_phy *phy;
+int r8a7778_usb_phy_power(bool enable)
+{
+	static struct usb_phy *phy = NULL;
+	int ret = 0;
+
+	if (!phy)
+		phy = usb_get_phy(USB_PHY_TYPE_USB2);
+
+	if (IS_ERR(phy)) {
+		pr_err("it doesn't have usb phy driver\n");
+		return PTR_ERR(phy);
+	}
+
+	if (enable)
+		ret = usb_phy_init(phy);
+	else
+		usb_phy_shutdown(phy);
 
+	return ret;
+}
+
+/* USB */
 static int usb_power_on(struct platform_device *pdev)
 {
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
+	int ret = r8a7778_usb_phy_power(true);
+
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	usb_phy_init(phy);
-
 	return 0;
 }
 
 static void usb_power_off(struct platform_device *pdev)
 {
-	if (IS_ERR(phy))
+	if (r8a7778_usb_phy_power(false))
 		return;
 
-	usb_phy_shutdown(phy);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
@@ -319,8 +336,6 @@ void __init r8a7778_add_standard_devices(void)
 
 void __init r8a7778_init_late(void)
 {
-	phy = usb_get_phy(USB_PHY_TYPE_USB2);
-
 	platform_device_register_full(&ehci_info);
 	platform_device_register_full(&ohci_info);
 }
-- 
1.7.9.5

