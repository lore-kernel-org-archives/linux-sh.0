From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 22:41:29 +0000
Subject: [Demo/RFC][PATCH 1/2] ARM: shmobile: Software-only testing device for Mackerel
Message-Id: <201208140041.29369.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Add a software-only testing platform device to the Mackerel board
configuration and a driver for that device allowing to turn it
"on" and "off" artificially with the help of a sysfs interface.

Auxiliary material, no sign-off.
---
 arch/arm/mach-shmobile/board-mackerel.c |    9 +
 drivers/misc/Kconfig                    |    7 +
 drivers/misc/Makefile                   |    1 
 drivers/misc/fake_device.c              |  194 ++++++++++++++++++++++++++++++++
 drivers/sh/pm_runtime.c                 |   29 ++++
 5 files changed, 238 insertions(+), 2 deletions(-)

Index: linux/arch/arm/mach-shmobile/board-mackerel.c
=================================--- linux.orig/arch/arm/mach-shmobile/board-mackerel.c
+++ linux/arch/arm/mach-shmobile/board-mackerel.c
@@ -1321,6 +1321,14 @@ static struct platform_device mackerel_c
 	},
 };
 
+static struct platform_device fake_device = {
+	.name	= "fake-device",
+	.id	= 0,
+	.dev	= {
+		.platform_data = "MY FAKE DEVICE",
+	},
+};
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -1343,6 +1351,7 @@ static struct platform_device *mackerel_
 	&hdmi_device,
 	&hdmi_lcdc_device,
 	&meram_device,
+	&fake_device,
 };
 
 /* Keypad Initialization */
Index: linux/drivers/misc/Kconfig
=================================--- linux.orig/drivers/misc/Kconfig
+++ linux/drivers/misc/Kconfig
@@ -509,6 +509,13 @@ config USB_SWITCH_FSA9480
 	  stereo and mono audio, video, microphone and UART data to use
 	  a common connector port.
 
+config MACKEREL_FAKEDEV
+	bool "Mackerel Fake Device Support"
+	depends on MACH_MACKEREL
+	help
+          Enable this if you want to experiment with the demo fake device
+          on the Mackerel board
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
Index: linux/drivers/misc/Makefile
=================================--- linux.orig/drivers/misc/Makefile
+++ linux/drivers/misc/Makefile
@@ -50,3 +50,4 @@ obj-y				+= carma/
 obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
 obj-$(CONFIG_INTEL_MEI)		+= mei/
+obj-$(CONFIG_MACKEREL_FAKEDEV)	+= fake_device.o
Index: linux/drivers/misc/fake_device.c
=================================--- /dev/null
+++ linux/drivers/misc/fake_device.c
@@ -0,0 +1,194 @@
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/slab.h>
+
+struct fake_device_priv {
+	bool enabled;
+};
+
+static int fake_device_stop(struct device *dev)
+{
+	dev_info(dev, "%s: stopped\n", __func__);
+	return 0;
+}
+
+static int fake_device_start(struct device *dev)
+{
+	dev_info(dev, "%s: started\n", __func__);
+	return 0;
+}
+
+static int fake_device_save_state(struct device *dev)
+{
+	dev_info(dev, "%s: state saved\n", __func__);
+	return 0;
+}
+
+static int fake_device_restore_state(struct device *dev)
+{
+	dev_info(dev, "%s: state restored\n", __func__);
+	return 0;
+}
+
+static int fake_device_runtime_suspend(struct device *dev)
+{
+	int ret = fake_device_save_state(dev);
+	return ret ? : fake_device_stop(dev);
+}
+
+static int fake_device_runtime_resume(struct device *dev)
+{
+	int ret = fake_device_start(dev);
+	return ret ? : fake_device_restore_state(dev);
+}
+
+static const struct dev_pm_ops fake_device_pm_ops = {
+	.runtime_suspend = fake_device_runtime_suspend,
+	.runtime_resume = fake_device_runtime_resume,
+};
+
+static bool fake_device_enabled(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fake_device_priv *priv = platform_get_drvdata(pdev);
+
+	return priv->enabled;
+}
+
+static void fake_device_set_status(struct device *dev, bool enabled)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct fake_device_priv *priv = platform_get_drvdata(pdev);
+
+	if (priv->enabled = enabled)
+		return;
+
+	priv->enabled = enabled;
+	if (enabled)
+		pm_runtime_get_sync(dev);
+	else
+		pm_runtime_put_sync(dev);
+}
+
+static const char enabled[] = "enabled";
+static const char disabled[] = "disabled";
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	return sprintf(buf, "%s\n",
+		       fake_device_enabled(dev) ? enabled : disabled);
+}
+
+static ssize_t status_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t n)
+{
+	char *cp;
+	int len = n;
+
+	cp = memchr(buf, '\n', n);
+	if (cp)
+		len = cp - buf;
+
+	if (len = sizeof(enabled) - 1 && strncmp(buf, enabled, len) = 0)
+		fake_device_set_status(dev, true);
+	else if (len = sizeof(disabled) - 1 && strncmp(buf, disabled, len) = 0)
+		fake_device_set_status(dev, false);
+	else
+		return -EINVAL;
+
+	return n;
+}
+
+static DEVICE_ATTR(status, 0644, status_show, status_store);
+
+static struct attribute *manip_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+static struct attribute_group manip_attr_group = {
+	.name	= "manip",
+	.attrs	= manip_attrs,
+};
+
+static int fake_device_remove(struct platform_device *pdev)
+{
+	struct fake_device_priv *priv = platform_get_drvdata(pdev);
+
+	sysfs_remove_group(&pdev->dev.kobj, &manip_attr_group);
+	pm_runtime_disable(&pdev->dev);
+	if (priv->enabled)
+		pm_runtime_put_noidle(&pdev->dev);
+	else
+		pm_runtime_set_active(&pdev->dev);
+
+	pm_genpd_remove_callbacks(&pdev->dev);
+	platform_set_drvdata(pdev, NULL);
+	kfree(priv);
+	return 0;
+}
+
+static int __devinit fake_device_probe(struct platform_device *pdev)
+{
+	struct gpd_dev_ops domain_pm_ops = {
+		.stop = fake_device_stop,
+		.start = fake_device_start,
+		.save_state = fake_device_save_state,
+		.restore_state = fake_device_restore_state,
+	};
+	struct fake_device_priv *priv;
+	int ret;
+
+	if (!pdev->dev.platform_data) {
+		dev_err(&pdev->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	if (strcmp("MY FAKE DEVICE", pdev->dev.platform_data))
+		return -ENODEV;
+
+	dev_info(&pdev->dev, "Fake device %d found\n", pdev->id);
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->enabled = true;
+	platform_set_drvdata(pdev, priv);
+	pm_genpd_add_callbacks(&pdev->dev, &domain_pm_ops, NULL);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &manip_attr_group);
+	if (ret) {
+		pm_runtime_disable(&pdev->dev);
+		platform_set_drvdata(pdev, NULL);
+		kfree(priv);
+		return ret;
+	}
+
+
+	return 0;
+}
+
+static struct platform_driver fake_device_driver = {
+	.driver		= {
+		.name		= "fake-device",
+		.owner		= THIS_MODULE,
+		.pm		= &fake_device_pm_ops,
+	},
+	.probe		= fake_device_probe,
+	.remove		= fake_device_remove,
+};
+
+module_platform_driver(fake_device_driver);
+
+MODULE_DESCRIPTION("Mackerel Fake Device driver");
+MODULE_AUTHOR("Rafael J. Wysocki <rjw@sisk.pl>");
+MODULE_LICENSE("GPL v2");
Index: linux/drivers/sh/pm_runtime.c
=================================--- linux.orig/drivers/sh/pm_runtime.c
+++ linux/drivers/sh/pm_runtime.c
@@ -28,10 +28,35 @@ static int default_platform_runtime_idle
 	return pm_runtime_suspend(dev);
 }
 
+static int default_runtime_suspend(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+
+	if (drv && drv->pm && drv->pm->runtime_suspend) {
+		int ret = drv->pm->runtime_suspend(dev);
+		if (ret)
+			return ret;
+	}
+	return pm_clk_suspend(dev);
+}
+
+static int default_runtime_resume(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int ret;
+
+	ret = pm_clk_resume(dev);
+	if (ret)
+		return ret;
+
+	return drv && drv->pm && drv->pm->runtime_resume ?
+		drv->pm->runtime_resume(dev) : 0;
+}
+
 static struct dev_pm_domain default_pm_domain = {
 	.ops = {
-		.runtime_suspend = pm_clk_suspend,
-		.runtime_resume = pm_clk_resume,
+		.runtime_suspend = default_runtime_suspend,
+		.runtime_resume = default_runtime_resume,
 		.runtime_idle = default_platform_runtime_idle,
 		USE_PLATFORM_PM_SLEEP_OPS
 	},

