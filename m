Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD35C83F20
	for <linux-sh@archiver.kernel.org>; Wed, 30 Aug 2023 18:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbjH3SqD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbjH3I6d (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 04:58:33 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59748CD7
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 01:58:27 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id a2e55750-1fbb-4a4e-b1c6-5fc82ea759ba;
        Wed, 30 Aug 2023 17:42:22 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 4B03F1C0210;
        Wed, 30 Aug 2023 17:42:22 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [RFC PATCH 08/12] mfd/sm501: Add OF properties.
Date:   Wed, 30 Aug 2023 17:42:09 +0900
Message-Id: <f622670c0af1bf01bf7c2f16241db0c36233a7d9.1693384846.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693384846.git.ysato@users.sourceforge.jp>
References: <cover.1693384846.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Some parameters only platform_device.
Added same parameters in OF property.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 .../devicetree/bindings/display/sm501fb.txt   |  11 ++
 drivers/mfd/sm501.c                           | 113 +++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/sm501fb.txt b/Documentation/devicetree/bindings/display/sm501fb.txt
index 1c79c267a57f..4c4920394431 100644
--- a/Documentation/devicetree/bindings/display/sm501fb.txt
+++ b/Documentation/devicetree/bindings/display/sm501fb.txt
@@ -20,6 +20,17 @@ Optional properties:
   set different foreign endian.
 - big-endian: available on little endian systems, to
   set different foreign endian.
+- sm501,devices: select peripheral functions.
+  available usb-host, usb-gadget, ssp0, ssp,1 uart0, uart1, accel,
+            ac97, i2s, gpio and all.
+- sm501,mclk: SM501 mclk frequency.
+- sm501,m1xclk: SM501 m1xclk frequency.
+- sm501,misc-timing: SM501 Miscellaneous Timing reg value.
+- sm501,misc-control: SM501 Miscellaneous Control reg value.
+- sm501,gpio-low: SM501 GPIO31-0 Control reg value.
+- sm501,gpio-high: SM501 GPIO63-32 Control reg value.
+- sm501,num-i2c: I2C channel number.
+- sm501,gpio-i2c: I2C assigned GPIO.
 
 Example for MPC5200:
 	display@1,0 {
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 28027982cf69..39871ca1b9f7 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -80,6 +80,9 @@ struct sm501_devdata {
 	unsigned int			 irq;
 	void __iomem			*regs;
 	unsigned int			 rev;
+#if defined(CONFIG_OF)
+	struct device_node		*np;
+#endif
 };
 
 
@@ -1370,6 +1373,106 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 	return 0;
 }
 
+static unsigned int sm501_parse_devices_str(const char *str)
+{
+	char *sep;
+	unsigned int device = 0;
+	int i;
+	int len;
+	static const struct {
+		char *devname;
+		unsigned int devid;
+	} devlist[] = {
+		{ "usb-host", SM501_USE_USB_HOST },
+		{ "usb-gadget", SM501_USE_USB_SLAVE },
+		{ "ssp0", SM501_USE_SSP0 },
+		{ "ssp1", SM501_USE_SSP1 },
+		{ "uart0", SM501_USE_UART0 },
+		{ "uart1", SM501_USE_UART1 },
+		{ "accel", SM501_USE_FBACCEL },
+		{ "ac97", SM501_USE_AC97 },
+		{ "i2s", SM501_USE_I2S },
+		{ "gpio", SM501_USE_GPIO },
+		{ "all", SM501_USE_ALL },
+	};
+
+	do {
+		sep = strchr(str, ',');
+		len = sep ? sep - str : strlen(str);
+		for (i = 0; i < ARRAY_SIZE(devlist); i++) {
+			if (strncasecmp(str, devlist[i].devname, len) == 0) {
+				device |= devlist[i].devid;
+				break;
+			}
+		}
+		str = sep + 1;
+	} while (sep);
+	return device;
+}
+
+#if defined(CONFIG_OF)
+static void sm501_of_read_reg_init(struct sm501_devdata *sm,
+				   const char *propname, struct sm501_reg_init *val)
+{
+	u32 u32_val;
+
+	if (!of_property_read_u32_index(sm->np, propname, 0, &u32_val))
+		val->set = u32_val;
+	if (!of_property_read_u32_index(sm->np, propname, 1, &u32_val))
+		val->mask = u32_val;
+}
+
+static int sm501_parse_dt(struct sm501_devdata *sm)
+{
+	struct sm501_platdata *plat;
+	const char *devstr;
+	u32 u32_val;
+
+	if (sm->np == NULL)
+		return 0;
+	plat = kzalloc(sizeof(struct sm501_platdata), GFP_KERNEL);
+	if (plat == NULL)
+		return -ENOMEM;
+	plat->init = kzalloc(sizeof(struct sm501_initdata), GFP_KERNEL);
+	if (plat->init == NULL)
+		goto err;
+
+	if (!of_property_read_string(sm->np, "sm501,devices", &devstr))
+		plat->init->devices = sm501_parse_devices_str(devstr);
+	if (!of_property_read_u32_index(sm->np, "sm501,mclk", 0, &u32_val))
+		plat->init->mclk = u32_val;
+	if (!of_property_read_u32_index(sm->np, "sm501,m1xclk", 0, &u32_val))
+		plat->init->m1xclk = u32_val;
+	sm501_of_read_reg_init(sm, "sm501,misc-timing", &plat->init->misc_timing);
+	sm501_of_read_reg_init(sm, "sm501,misc-control", &plat->init->misc_control);
+	sm501_of_read_reg_init(sm, "sm501,gpio-low", &plat->init->gpio_low);
+	sm501_of_read_reg_init(sm, "sm501,gpio-high", &plat->init->gpio_high);
+
+#ifdef CONFIG_MFD_SM501_GPIO
+	if (plat->init->devices & SM501_USE_GPIO) {
+		if (!of_property_read_u32_index(sm->np, "sm501,num-i2c", 0, &u32_val))
+			plat->gpio_i2c_nr = u32_val;
+	}
+	if (plat->gpio_i2c_nr > 0) {
+		plat->gpio_i2c = kcalloc(plat->gpio_i2c_nr,
+					 sizeof(struct sm501_platdata_gpio_i2c),
+					 GFP_KERNEL);
+		if (plat->gpio_i2c == NULL)
+			goto err;
+		of_property_read_variable_u32(sm->np, "sm501,gpio-i2c",
+					      plat->gpio_i2c,
+					      plat->gpio_i2c_nr * 5);
+	}
+#endif
+	sm->platdata = plat;
+	return 0;
+err:
+	kfree(plat->init);
+	kfree(plat);
+	return -ENOMEM;
+}
+#endif
+
 static int sm501_plat_probe(struct platform_device *dev)
 {
 	struct sm501_devdata *sm;
@@ -1384,7 +1487,6 @@ static int sm501_plat_probe(struct platform_device *dev)
 	sm->dev = &dev->dev;
 	sm->pdev_id = dev->id;
 	sm->platdata = dev_get_platdata(&dev->dev);
-
 	ret = platform_get_irq(dev, 0);
 	if (ret < 0)
 		goto err_res;
@@ -1406,6 +1508,15 @@ static int sm501_plat_probe(struct platform_device *dev)
 		goto err_res;
 	}
 
+#if defined(CONFIG_OF)
+	if (dev->dev.of_node) {
+		sm->np = dev->dev.of_node;
+		ret = sm501_parse_dt(sm);
+		if (ret)
+			goto err_res;
+	}
+#endif
+
 	platform_set_drvdata(dev, sm);
 
 	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
-- 
2.39.2

