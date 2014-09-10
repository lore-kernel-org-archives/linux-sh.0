From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 10 Sep 2014 10:33:52 +0000
Subject: [PATCH 2/4] usb: renesas_usbhs: gadget: fix the behavior of pullup
Message-Id: <54102910.70703@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that this driver always enable the D+ pullup
after it detected the VBUS connection even though this usb controller
can control the D+ pullup timing by software. So, this driver should
enable the D+ pullup after a gadget driver called usb_gadget_connect().

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c     |    6 ++++--
 drivers/usb/renesas_usbhs/mod_gadget.c |   27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 1b9bf8d..ea89f55 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -124,13 +124,15 @@ void usbhs_sys_host_ctrl(struct usbhs_priv *priv, int enable)
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
index a582222..b80c802 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -56,6 +56,8 @@ struct usbhsg_gpriv {
 #define USBHSG_STATUS_REGISTERD		(1 << 1)
 #define USBHSG_STATUS_WEDGE		(1 << 2)
 #define USBHSG_STATUS_SELF_POWERED	(1 << 3)
+
+	unsigned		softconnect:1;
 };

 struct usbhsg_recip_handle {
@@ -726,6 +728,24 @@ static struct usb_ep_ops usbhsg_ep_ops = {
 };

 /*
+ *		pullup control
+ */
+static int usbhsg_can_pullup(struct usbhs_priv *priv)
+{
+	struct usbhsg_gpriv *gpriv = usbhsg_priv_to_gpriv(priv);
+
+	return gpriv->driver && gpriv->softconnect;
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
@@ -881,8 +902,12 @@ static int usbhsg_pullup(struct usb_gadget *gadget, int is_on)
 {
 	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
 	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
+	unsigned long flags;

-	usbhs_sys_function_pullup(priv, is_on);
+	usbhs_lock(priv, flags);
+	gpriv->softconnect = (is_on != 0);
+	usbhsg_update_pullup(priv);
+	usbhs_unlock(priv, flags);

 	return 0;
 }
-- 
1.7.9.5

