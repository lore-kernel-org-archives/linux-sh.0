From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Jan 2012 05:13:49 +0000
Subject: [PATCH 1/2] usb: renesas_usbhs: add IRQ resource decoding for
Message-Id: <4F05318D.6070505@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c |   11 ++++++-----
 drivers/usb/renesas_usbhs/common.h |    1 +
 drivers/usb/renesas_usbhs/mod.c    |    2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 08c679c..75f7d08 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -410,8 +410,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	struct renesas_usbhs_platform_info *info = pdev->dev.platform_data;
 	struct renesas_usbhs_driver_callback *dfunc;
 	struct usbhs_priv *priv;
-	struct resource *res;
-	unsigned int irq;
+	struct resource *res, *irq_res;
 	int ret;

 	/* check platform information */
@@ -423,8 +422,8 @@ static int usbhs_probe(struct platform_device *pdev)

 	/* platform data */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (!res || (int)irq <= 0) {
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res || !irq_res) {
 		dev_err(&pdev->dev, "Not enough Renesas USB platform resources.\n");
 		return -ENODEV;
 	}
@@ -473,7 +472,9 @@ static int usbhs_probe(struct platform_device *pdev)
 	/*
 	 * priv settings
 	 */
-	priv->irq	= irq;
+	priv->irq	= irq_res->start;
+	if (irq_res->flags & IORESOURCE_IRQ_SHAREABLE)
+		priv->irqflags = IRQF_SHARED;
 	priv->pdev	= pdev;
 	INIT_DELAYED_WORK(&priv->notify_hotplug_work, usbhsc_notify_hotplug);
 	spin_lock_init(usbhs_priv_to_lock(priv));
diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index 8729da5..353ab51 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -241,6 +241,7 @@ struct usbhs_priv {

 	void __iomem *base;
 	unsigned int irq;
+	unsigned long irqflags;

 	struct renesas_usbhs_platform_callback	pfunc;
 	struct renesas_usbhs_driver_param	dparam;
diff --git a/drivers/usb/renesas_usbhs/mod.c b/drivers/usb/renesas_usbhs/mod.c
index ad96a38..9499fae 100644
--- a/drivers/usb/renesas_usbhs/mod.c
+++ b/drivers/usb/renesas_usbhs/mod.c
@@ -150,7 +150,7 @@ int usbhs_mod_probe(struct usbhs_priv *priv)

 	/* irq settings */
 	ret = request_irq(priv->irq, usbhs_interrupt,
-			  0, dev_name(dev), priv);
+			  priv->irqflags, dev_name(dev), priv);
 	if (ret) {
 		dev_err(dev, "irq request err\n");
 		goto mod_init_gadget_err;
-- 
1.7.1
