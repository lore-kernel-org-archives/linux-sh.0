From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 04 Nov 2014 01:05:43 +0000
Subject: [PATCH v6 2/4] usb: renesas_usbhs: gadget: fix the behavior of pullup
Message-Id: <1415063145-4200-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch fixes an issue that this driver always enable the D+ pullup
after it detected the VBUS connection even though this usb controller
can control the D+ pullup timing by software. So, this driver should
enable the D+ pullup after a gadget driver called usb_gadget_connect().

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c     |    6 ++++--
 drivers/usb/renesas_usbhs/mod_gadget.c |   30 +++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index b3b6813..7099f17 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -126,13 +126,15 @@ void usbhs_sys_host_ctrl(struct usbhs_priv *priv, int enable)
 void usbhs_sys_function_ctrl(struct usbhs_priv *priv, int enable)
 {
 	u16 mask = DCFM | DRPD | DPRPU | HSE | USBE;
-	u16 val  = DPRPU | HSE | USBE;
+	u16 val  = HSE | USBE;
 
 	/*
 	 * if enable
 	 *
 	 * - select Function mode
-	 * - D+ Line Pull-up
+	 * - D+ Line Pull-up is disabled
+	 *      When D+ Line Pull-up is enabled,
+	 *      calling usbhs_sys_function_pullup(,1)
 	 */
 	usbhs_bset(priv, SYSCFG, mask, enable ? val : 0);
 }
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 294d43c..b27b2bc 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -56,6 +56,7 @@ struct usbhsg_gpriv {
 #define USBHSG_STATUS_REGISTERD		(1 << 1)
 #define USBHSG_STATUS_WEDGE		(1 << 2)
 #define USBHSG_STATUS_SELF_POWERED	(1 << 3)
+#define USBHSG_STATUS_SOFT_CONNECT	(1 << 4)
 };
 
 struct usbhsg_recip_handle {
@@ -726,6 +727,25 @@ static struct usb_ep_ops usbhsg_ep_ops = {
 };
 
 /*
+ *		pullup control
+ */
+static int usbhsg_can_pullup(struct usbhs_priv *priv)
+{
+	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
+
+	return gpriv->driver &&
+	       usbhsg_status_has(gpriv, USBHSG_STATUS_SOFT_CONNECT);
+}
+
+static void usbhsg_update_pullup(struct usbhs_priv *priv)
+{
+	if (usbhsg_can_pullup(priv))
+		usbhs_sys_function_pullup(priv, 1);
+	else
+		usbhs_sys_function_pullup(priv, 0);
+}
+
+/*
  *		usb module start/end
  */
 static int usbhsg_try_start(struct usbhs_priv *priv, u32 status)
@@ -775,6 +795,7 @@ static int usbhsg_try_start(struct usbhs_priv *priv, u32 status)
 	 * - usb module
 	 */
 	usbhs_sys_function_ctrl(priv, 1);
+	usbhsg_update_pullup(priv);
 
 	/*
 	 * enable irq callback
@@ -881,8 +902,15 @@ static int usbhsg_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	unsigned long flags;
 
-	usbhs_sys_function_pullup(priv, is_on);
+	usbhs_lock(priv, flags);
+	if (is_on)
+		usbhsg_status_set(gpriv, USBHSG_STATUS_SOFT_CONNECT);
+	else
+		usbhsg_status_clr(gpriv, USBHSG_STATUS_SOFT_CONNECT);
+	usbhsg_update_pullup(priv);
+	usbhs_unlock(priv, flags);
 
 	return 0;
 }
-- 
1.7.9.5

