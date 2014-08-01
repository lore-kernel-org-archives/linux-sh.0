From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 01 Aug 2014 11:49:24 +0000
Subject: [PATCH 2/2] usb: renesas_usbhs: Add device tree support for R-Car H2 and M2
Message-Id: <53DB7EC4.5010705@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SH-Linux <linux-sh@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>

This driver supports other SoCs, but they need boards/Soc depend code.
So, this patch adds device tree support for R-Car H2 and M2 initially.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c |   43 ++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 1b9bf8d..845a889 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -18,6 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -438,6 +439,34 @@ static int usbhsc_drvcllbck_notify_hotplug(struct platform_device *pdev)
 /*
  *		platform functions
  */
+static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
+{
+	struct renesas_usbhs_platform_info *info;
+	struct renesas_usbhs_driver_param *dparam;
+	u32 tmp;
+	int gpio;
+
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return NULL;
+
+	dparam = &info->driver_param;
+
+	if (of_device_is_compatible(dev->of_node, "renesas,usbhs-r8a7790"))
+		dparam->type = USBHS_TYPE_R8A7790;
+
+	if (of_device_is_compatible(dev->of_node, "renesas,usbhs-r8a7791"))
+		dparam->type = USBHS_TYPE_R8A7791;
+
+	if (!of_property_read_u32(dev->of_node, "buswait_bwait", &tmp))
+		dparam->buswait_bwait = tmp;
+	gpio = of_get_named_gpio_flags(dev->of_node, "enable-gpio", 0, NULL);
+	if (gpio > 0)
+		dparam->enable_gpio = gpio;
+
+	return info;
+}
+
 static int usbhs_probe(struct platform_device *pdev)
 {
 	struct renesas_usbhs_platform_info *info = dev_get_platdata(&pdev->dev);
@@ -446,6 +475,10 @@ static int usbhs_probe(struct platform_device *pdev)
 	struct resource *res, *irq_res;
 	int ret;

+	/* check device node */
+	if (pdev->dev.of_node)
+		info = pdev->dev.platform_data = usbhs_parse_dt(&pdev->dev);
+
 	/* check platform information */
 	if (!info) {
 		dev_err(&pdev->dev, "no platform information\n");
@@ -685,10 +718,20 @@ static const struct dev_pm_ops usbhsc_pm_ops = {
 	.runtime_resume		= usbhsc_runtime_nop,
 };

+#ifdef CONFIG_OF
+static const struct of_device_id usbhs_of_match[] = {
+	{ .compatible = "renesas,usbhs-r8a7790"},
+	{ .compatible = "renesas,usbhs-r8a7791"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, usbhs_of_match);
+#endif
+
 static struct platform_driver renesas_usbhs_driver = {
 	.driver		= {
 		.name	= "renesas_usbhs",
 		.pm	= &usbhsc_pm_ops,
+		.of_match_table = of_match_ptr(usbhs_of_match),
 	},
 	.probe		= usbhs_probe,
 	.remove		= usbhs_remove,
-- 
1.7.9.5

