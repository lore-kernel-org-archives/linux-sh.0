From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 08 Jan 2016 21:12:30 +0000
Subject: [RFC v4 1/4] watchdog: renesas-rwdt: add driver
Message-Id: <1452287553-18895-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Add support for an RCLK watchdog found on RCar Gen3 based SoCs from
Renesas. A restart handler is in place, too.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/watchdog/renesas-rwdt.txt  |  18 ++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/renesas_rwdt.c                    | 224 +++++++++++++++++++++
 4 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
 create mode 100644 drivers/watchdog/renesas_rwdt.c

diff --git a/Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
new file mode 100644
index 00000000000000..fd050d5e5e0002
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/renesas-rwdt.txt
@@ -0,0 +1,18 @@
+Renesas RCLK Watchdog Timer (RWDT) Controller
+
+Required properties:
+- compatible : Should be "renesas,rwdt-r8a7795";
+- reg : Should contain WDT registers location and length
+- clocks : the clock feeding the watchdog timer.
+
+Optional properties:
+- timeout-sec : Contains the watchdog timeout in seconds
+
+Examples:
+
+	wdt0: wdt@e6020000 {
+		compatible = "renesas,rwdt-r8a7795";
+		reg = <0 0xe6020000 0 0x0c>;
+		clocks = <&cpg CPG_MOD 402>;
+		timeout-sec = <60>;
+	};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index afb7f91795cb99..04020e84c1a4a2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -636,6 +636,14 @@ config ATLAS7_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called atlas7_wdt.
 
+config RENESAS_RWDT
+	tristate "Renesas RWDT Watchdog"
+	depends on ARCH_SHMOBILE || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdog in the
+	  Renesas RCar and other SH Mobile SoCs.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 2d203fc3cfdbe8..ba243b117757b7 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
+obj-$(CONFIG_RENESAS_RWDT) += renesas_rwdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/renesas_rwdt.c b/drivers/watchdog/renesas_rwdt.c
new file mode 100644
index 00000000000000..9d2a0b68c3ce0b
--- /dev/null
+++ b/drivers/watchdog/renesas_rwdt.c
@@ -0,0 +1,224 @@
+/*
+ * Watchdog driver for Renesas RWDT watchdog
+ *
+ * Copyright (C) 2015-16 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015-16 Renesas Electronics Corporation
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
+#define RWDT_DEFAULT_TIMEOUT 60
+
+static const unsigned clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, S_IRUGO);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct rwdt_priv {
+	void __iomem *base;
+	struct watchdog_device wdev;
+	struct clk *clk;
+	struct notifier_block restart_handler;
+	unsigned clks_per_sec;
+	u8 cks;
+};
+
+static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned reg)
+{
+	if (reg = RWTCNT)
+		val |= 0x5a5a0000;
+	else
+		val |= 0xa5a5a500;
+
+	writel_relaxed(val, priv->base + reg);
+}
+
+static int rwdt_init_timeout(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
+
+	return 0;
+}
+
+static int rwdt_set_timeout(struct watchdog_device *wdev, unsigned new_timeout)
+{
+	wdev->timeout = new_timeout;
+	rwdt_init_timeout(wdev);
+
+	return 0;
+}
+
+static int rwdt_start(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	clk_prepare_enable(priv->clk);
+
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	rwdt_init_timeout(wdev);
+
+	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
+		cpu_relax();
+
+	rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
+
+	return 0;
+}
+
+static int rwdt_stop(struct watchdog_device *wdev)
+{
+	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct watchdog_info rwdt_ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.identity = "Renesas RWDT Watchdog",
+};
+
+static const struct watchdog_ops rwdt_ops = {
+	.owner = THIS_MODULE,
+	.start = rwdt_start,
+	.stop = rwdt_stop,
+	.ping = rwdt_init_timeout,
+	.set_timeout = rwdt_set_timeout,
+};
+
+static int rwdt_restart_handler(struct notifier_block *nb, unsigned long mode, void *cmd)
+{
+	struct rwdt_priv *priv = container_of(nb, struct rwdt_priv, restart_handler);
+
+	rwdt_start(&priv->wdev);
+	rwdt_write(priv, 0xffff, RWTCNT);
+
+	return NOTIFY_DONE;
+}
+
+static int rwdt_probe(struct platform_device *pdev)
+{
+	struct rwdt_priv *priv;
+	struct resource *res;
+	unsigned long rate;
+	unsigned clks_per_sec;
+	int ret, i;
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
+	clk_disable_unprepare(priv->clk);
+
+	if (!rate)
+		return -ENOENT;
+
+	for (i = ARRAY_SIZE(clk_divs); i >= 0; i--) {
+		clks_per_sec = rate / clk_divs[i];
+		if (clks_per_sec) {
+			priv->clks_per_sec = clks_per_sec;
+			priv->cks = i;
+			break;
+		}
+	}
+
+	if (!clks_per_sec) {
+		dev_err(&pdev->dev, "Can't find suitable clock divider!\n");
+		return -ERANGE;
+	}
+
+	priv->wdev.info = &rwdt_ident,
+	priv->wdev.ops = &rwdt_ops,
+	priv->wdev.parent = &pdev->dev;
+	priv->wdev.min_timeout = 1;
+	priv->wdev.max_timeout = 65536 / clks_per_sec;
+	priv->wdev.timeout = min_t(unsigned, priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
+
+	platform_set_drvdata(pdev, priv);
+	watchdog_set_drvdata(&priv->wdev, priv);
+	watchdog_set_nowayout(&priv->wdev, nowayout);
+
+	/* This overrides the default timeout only if DT configuration was found */
+	ret = watchdog_init_timeout(&priv->wdev, 0, &pdev->dev);
+	if (ret)
+		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
+
+	ret = watchdog_register_device(&priv->wdev);
+	if (ret < 0)
+		return ret;
+
+	priv->restart_handler.notifier_call = rwdt_restart_handler;
+	priv->restart_handler.priority = 192;
+	ret = register_restart_handler(&priv->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "Failed to register restart handler (err = %d)\n", ret);
+
+	return 0;
+}
+
+static int rwdt_remove(struct platform_device *pdev)
+{
+	struct rwdt_priv *priv = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&priv->restart_handler);
+	watchdog_unregister_device(&priv->wdev);
+	return 0;
+}
+
+/*
+ * This driver does also fit for RCar Gen2 (r8a779[0-4]) RWDT. However, for SMP
+ * to work there, one also needs a RESET (RST) driver which does not exist yet
+ * due to HW issues. This needs to be solved before adding compatibles here.
+ */
+static const struct of_device_id rwdt_ids[] = {
+	{ .compatible = "renesas,rwdt-r8a7795", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rwdt_ids);
+
+static struct platform_driver rwdt_driver = {
+	.driver = {
+		.name = "renesas_rwdt",
+		.of_match_table = rwdt_ids,
+	},
+	.probe = rwdt_probe,
+	.remove = rwdt_remove,
+};
+module_platform_driver(rwdt_driver);
+
+MODULE_DESCRIPTION("Renesas RWDT Watchdog Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
-- 
2.1.4

