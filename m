From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 12 Oct 2015 06:54:36 +0000
Subject: [RFC v2 5/5] watchdog: sh_mobile: add driver
Message-Id: <1444632876-2672-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Add basic support for an RCLK watchdog found in at least all RCar-Gen2
based SoCs from Renesas. It probably works even for the "Secure
watchdog" of some of those SoCs according to the specs I have. Setting a
timeout value is not implemented yet, I didn't need it. A restart
handler is in place, though.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/Kconfig         |   8 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/sh_mobile_wdt.c | 187 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/watchdog/sh_mobile_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79e1aa1b0959f1..e42f27692f87a8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -578,6 +578,14 @@ config LPC18XX_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called lpc18xx_wdt.
 
+config SH_MOBILE_WDT
+	tristate "SH Mobile Watchdog"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdog in the
+	  Renesas SH Mobile SoCs.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0c616e3f67bb57..ebc72682fbb070 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
+obj-$(CONFIG_SH_MOBILE_WDT) += sh_mobile_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/sh_mobile_wdt.c b/drivers/watchdog/sh_mobile_wdt.c
new file mode 100644
index 00000000000000..fe5b174db9d1b4
--- /dev/null
+++ b/drivers/watchdog/sh_mobile_wdt.c
@@ -0,0 +1,187 @@
+/*
+ * Watchdog driver for SH mobile based SoC
+ *
+ * Copyright (C) 2015 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/watchdog.h>
+
+#define RWTCNT		0
+#define RWTCSRA		4
+#define RWTCSRA_WOVF	BIT(4)
+#define RWTCSRA_WRFLG	BIT(5)
+#define RWTCSRA_TME	BIT(7)
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, S_IRUGO);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct sh_wdt_priv {
+	void __iomem *base;
+	struct watchdog_device wdev;
+	struct clk *clk;
+	struct notifier_block restart_handler;
+};
+
+static void sh_wdt_write(struct sh_wdt_priv *priv, u32 val, unsigned reg)
+{
+	if (reg = RWTCNT)
+		val |= 0x5a5a0000;
+	else
+		val |= 0xa5a5a500;
+
+	writel_relaxed(val, priv->base + reg);
+}
+
+static int sh_wdt_start(struct watchdog_device *wdev)
+{
+	struct sh_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	clk_prepare_enable(priv->clk);
+
+	sh_wdt_write(priv, 0, RWTCSRA);
+	sh_wdt_write(priv, 0, RWTCNT);
+
+	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
+		cpu_relax();
+
+	sh_wdt_write(priv, RWTCSRA_TME, RWTCSRA);
+
+	return 0;
+}
+
+static int sh_wdt_ping(struct watchdog_device *wdev)
+{
+	struct sh_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	sh_wdt_write(priv, 0, RWTCNT);
+
+	return 0;
+}
+
+static int sh_wdt_stop(struct watchdog_device *wdev)
+{
+	struct sh_wdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	sh_wdt_write(priv, 0, RWTCSRA);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct watchdog_info sh_wdt_ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "SH Mobile Watchdog",
+};
+
+static const struct watchdog_ops sh_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = sh_wdt_start,
+	.ping = sh_wdt_ping,
+	.stop = sh_wdt_stop,
+};
+
+static int sh_mobile_wdt_restart_handler(struct notifier_block *nb,
+					 unsigned long mode, void *cmd)
+{
+	struct sh_wdt_priv *priv = container_of(nb, struct sh_wdt_priv,
+						restart_handler);
+
+	sh_wdt_start(&priv->wdev);
+	sh_wdt_write(priv, 0xffff, RWTCNT);
+
+	return NOTIFY_DONE;
+}
+
+static int sh_wdt_probe(struct platform_device *pdev)
+{
+	struct sh_wdt_priv *priv;
+	struct resource *res;
+	unsigned long rate;
+	u8 status;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	clk_prepare_enable(priv->clk);
+	rate = clk_get_rate(priv->clk);
+	status = readb_relaxed(priv->base + RWTCSRA);
+	clk_disable_unprepare(priv->clk);
+
+	if (!rate)
+		return -ENOENT;
+
+	priv->wdev.info = &sh_wdt_ident,
+	priv->wdev.ops = &sh_wdt_ops,
+	priv->wdev.parent = &pdev->dev;
+	priv->wdev.bootstatus = (status & RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
+	priv->wdev.timeout = 65536 / rate;
+
+	platform_set_drvdata(pdev, priv);
+	watchdog_set_drvdata(&priv->wdev, priv);
+	watchdog_set_nowayout(&priv->wdev, nowayout);
+
+	ret = watchdog_register_device(&priv->wdev);
+	if (ret < 0)
+		return ret;
+
+	priv->restart_handler.notifier_call = sh_mobile_wdt_restart_handler;
+	priv->restart_handler.priority = 192;
+	ret = register_restart_handler(&priv->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to register restart handler (err = %d)\n", ret);
+
+	return 0;
+}
+
+static int sh_wdt_remove(struct platform_device *pdev)
+{
+	struct sh_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&priv->restart_handler);
+	watchdog_unregister_device(&priv->wdev);
+	return 0;
+}
+
+static const struct of_device_id sh_mobile_wdt_ids[] = {
+	{ .compatible = "renesas,rwdt-rcar", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_wdt_ids);
+
+static struct platform_driver sh_wdt_driver = {
+	.driver = {
+		.name = "sh_mobile_wdt",
+		.of_match_table = sh_mobile_wdt_ids,
+	},
+	.probe = sh_wdt_probe,
+	.remove = sh_wdt_remove,
+};
+module_platform_driver(sh_wdt_driver);
+
+MODULE_DESCRIPTION("SH Mobile Watchdog Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
-- 
2.1.4

