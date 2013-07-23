From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 16:12:01 +0000
Subject: [PATCH 1/4] net: smsc911x: add support for a reset GPIO
Message-Id: <1374595924-12338-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Steve Glendinning <steve.glendinning@shawell.net>, netdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

If a reset GPIO is specified in platform data, take the controller out of
reset before using it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c |   19 ++++++++++++++++++-
 include/linux/smsc911x.h             |   10 ++++++++++
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index a141921..ca01c03 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2300,6 +2300,9 @@ static int smsc911x_drv_remove(struct platform_device *pdev)
 
 	free_netdev(dev);
 
+	if (pdata->config.reset_gpio_config & SMSC911X_RESET_GPIO_VALID)
+		gpio_free(pdata->config.reset_gpio);
+
 	return 0;
 }
 
@@ -2479,10 +2482,21 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 		goto out_disable_resources;
 	}
 
+	if (pdata->config.reset_gpio_config & SMSC911X_RESET_GPIO_VALID) {
+		/* Take the chip out of hard reset */
+		unsigned long flags = (pdata->config.reset_gpio_config ^
+				       GPIOF_INIT_HIGH) & 0xf;
+		retval = gpio_request_one(pdata->config.reset_gpio,
+					  GPIOF_DIR_OUT | flags,
+					  netdev_name(dev));
+		if (retval < 0)
+			goto out_free_irq;
+	}
+
 	retval = register_netdev(dev);
 	if (retval) {
 		SMSC_WARN(pdata, probe, "Error %i registering device", retval);
-		goto out_free_irq;
+		goto out_free_reset;
 	} else {
 		SMSC_TRACE(pdata, probe,
 			   "Network interface: \"%s\"", dev->name);
@@ -2531,6 +2545,9 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 
 out_unregister_netdev_5:
 	unregister_netdev(dev);
+out_free_reset:
+	if (pdata->config.reset_gpio_config & SMSC911X_RESET_GPIO_VALID)
+		gpio_free(pdata->config.reset_gpio);
 out_free_irq:
 	free_irq(dev->irq, dev);
 out_disable_resources:
diff --git a/include/linux/smsc911x.h b/include/linux/smsc911x.h
index 4dde70e..4e3e49d 100644
--- a/include/linux/smsc911x.h
+++ b/include/linux/smsc911x.h
@@ -32,8 +32,18 @@ struct smsc911x_platform_config {
 	unsigned int shift;
 	phy_interface_t phy_interface;
 	unsigned char mac[6];
+	unsigned int reset_gpio;
+	unsigned int reset_gpio_config;
 };
 
+/*
+ * Bits for platform_device reest GPIO configuration: an OR of any GPIOF_* flags
+ * from <linux/gpio.h>, specifically one of GPIOF_INIT_LOW or GPIOF_INIT_HIGH
+ * and the below SMSC911X_RESET_GPIO_VALID flag. We define GPIOF_INIT_* as the
+ * level, that activates chip reset.
+ */
+#define SMSC911X_RESET_GPIO_VALID		BIT(31)
+
 /* Constants for platform_device irq polarity configuration */
 #define SMSC911X_IRQ_POLARITY_ACTIVE_LOW	0
 #define SMSC911X_IRQ_POLARITY_ACTIVE_HIGH	1
-- 
1.7.2.5

