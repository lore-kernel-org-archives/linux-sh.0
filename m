From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 03 Sep 2014 05:25:56 +0000
Subject: [PATCH v3 2/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <5406A664.2050501@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht@gmail.com>

This driver supports other SoCs, but they need boards/Soc depend code.
So, this patch adds device tree support for R-Car H2 and M2 initially.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c |   44 ++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 1b9bf8d..b3b6813 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -18,6 +18,8 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -438,6 +440,43 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
 /*
  *		platform functions
  */
+static const struct of_device_id usbhs_of_match[] = {
+	{
+		.compatible = "renesas,usbhs-r8a7790",
+		.data = (void *)USBHS_TYPE_R8A7790,
+	},
+	{
+		.compatible = "renesas,usbhs-r8a7791",
+		.data = (void *)USBHS_TYPE_R8A7791,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, usbhs_of_match);
+
+static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
+{
+	struct renesas_usbhs_platform_info *info;
+	struct renesas_usbhs_driver_param *dparam;
+	const struct of_device_id *of_id = of_match_device(usbhs_of_match, dev);
+	u32 tmp;
+	int gpio;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	dparam = &info->driver_param;
+	dparam->type = of_id ? (u32)of_id->data : 0;
+	if (!of_property_read_u32(dev->of_node, "renesas,buswait", &tmp))
+		dparam->buswait_bwait = tmp;
+	gpio = of_get_named_gpio_flags(dev->of_node, "renesas,enable-gpio", 0,
+				       NULL);
+	if (gpio > 0)
+		dparam->enable_gpio = gpio;
+
+	return info;
+}
+
 static int usbhs_probe(struct platform_device *pdev)
 {
 	struct renesas_usbhs_platform_info *info = dev_get_platdata(&pdev->dev);
@@ -446,6 +485,10 @@ static int usbhs_probe(struct platform_device *pdev)
 	struct resource *res, *irq_res;
 	int ret;

+	/* check device node */
+	if (pdev->dev.of_node)
+		info = pdev->dev.platform_data = usbhs_parse_dt(&pdev->dev);
+
 	/* check platform information */
 	if (!info) {
 		dev_err(&pdev->dev, "no platform information\n");
@@ -689,6 +732,7 @@ static struct platform_driver renesas_usbhs_driver = {
 	.driver		= {
 		.name	= "renesas_usbhs",
 		.pm	= &usbhsc_pm_ops,
+		.of_match_table = of_match_ptr(usbhs_of_match),
 	},
 	.probe		= usbhs_probe,
 	.remove		= usbhs_remove,
-- 
1.7.9.5

