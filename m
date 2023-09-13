Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0B2CA5521
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 09:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239259AbjIMJYO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 05:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239281AbjIMJYL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 05:24:11 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0299C3
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 02:24:06 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 2c3e2b2b-e026-41ac-995c-cb28c6dd12eb;
        Wed, 13 Sep 2023 18:24:06 +0900 (JST)
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id E8AF71C005D;
        Wed, 13 Sep 2023 18:24:05 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, lee@kernel.org
Subject: [RFC PATCH v2 20/30] drivers/mfd: sm501 add some properties.
Date:   Wed, 13 Sep 2023 18:23:45 +0900
Message-Id: <9c298d2dc42df60fdbbec395a8d790511e35c531.1694596125.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694596125.git.ysato@users.sourceforge.jp>
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

SM501's OF support is not enough parameter in platform device.
This change adds the missing parameter.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/mfd/sm501.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 28027982cf69..82508f6d96da 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1370,6 +1370,113 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static unsigned int sm501_parse_devices_str(struct device_node *np)
+{
+	unsigned int device = 0;
+	unsigned int i, j;
+	unsigned int nstr;
+	const char *devstr;
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
+	nstr = of_property_count_strings(np, "sm501,devices");
+	for (i = 0; i < nstr; i++) {
+		if (of_property_read_string_index(np, "sm501,devices", i, &devstr))
+			break;
+		for (j = 0; j < ARRAY_SIZE(devlist); j++) {
+			if (strcmp(devstr, devlist[j].devname) == 0) {
+				device |= devlist[j].devid;
+				goto next;
+			}
+		}
+next:
+	}
+	return device;
+}
+
+static void sm501_of_read_reg_init(struct device_node *np,
+				   const char *propname, struct sm501_reg_init *val)
+{
+	u32 u32_val[2];
+
+	if (!of_property_read_u32_array(np, propname, u32_val, sizeof(u32_val))) {
+		val->set = u32_val[0];
+		val->mask = u32_val[1];
+	} else {
+		val->set = 0;
+		val->mask = 0;
+	}
+}
+
+static int sm501_parse_dt(struct sm501_devdata *sm, struct device_node *np)
+{
+	struct sm501_platdata *plat;
+	u32 u32_val;
+
+	plat = devm_kzalloc(sm->dev, sizeof(struct sm501_platdata), GFP_KERNEL);
+	if (plat == NULL)
+		return -ENOMEM;
+
+	plat->init = devm_kzalloc(sm->dev, sizeof(struct sm501_initdata), GFP_KERNEL);
+	if (plat->init == NULL)
+		return -ENOMEM;
+
+	plat->init->devices = sm501_parse_devices_str(np);
+
+	if (!of_property_read_u32_index(np, "sm501,mclk", 0, &u32_val))
+		plat->init->mclk = u32_val;
+	else
+		plat->init->mclk = 0;
+
+	if (!of_property_read_u32_index(np, "sm501,m1xclk", 0, &u32_val))
+		plat->init->m1xclk = u32_val;
+	else
+		plat->init->m1xclk = 0;
+
+	sm501_of_read_reg_init(np, "sm501,misc-timing", &plat->init->misc_timing);
+	sm501_of_read_reg_init(np, "sm501,misc-control", &plat->init->misc_control);
+	sm501_of_read_reg_init(np, "sm501,gpio-low", &plat->init->gpio_low);
+	sm501_of_read_reg_init(np, "sm501,gpio-high", &plat->init->gpio_high);
+
+#ifdef CONFIG_MFD_SM501_GPIO
+	if (plat->init->devices & SM501_USE_GPIO) {
+		if (!of_property_read_u32_index(np, "sm501,num-i2c", 0, &u32_val))
+			plat->gpio_i2c_nr = u32_val;
+		else
+			plat->gpio_i2c_nr = 0;
+	}
+	if (plat->gpio_i2c_nr > 0) {
+		int sz_gpio;
+
+		sz_gpio = sizeof(struct sm501_platdata_gpio_i2c) * plat->gpio_i2c_nr;
+		plat->gpio_i2c = devm_kzalloc(sm->dev, sz_gpio, GFP_KERNEL);
+		if (plat->gpio_i2c == NULL)
+			return -ENOMEM;
+
+		of_property_read_variable_u32(np, "sm501,gpio-i2c",
+					      plat->gpio_i2c, plat->gpio_i2c_nr * 5);
+	}
+#endif
+	sm->platdata = plat;
+	return 0;
+}
+#endif
+
 static int sm501_plat_probe(struct platform_device *dev)
 {
 	struct sm501_devdata *sm;
@@ -1406,6 +1513,12 @@ static int sm501_plat_probe(struct platform_device *dev)
 		goto err_res;
 	}
 
+	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
+		ret = sm501_parse_dt(sm, dev->dev.of_node);
+		if (ret)
+			goto err_res;
+	}
+
 	platform_set_drvdata(dev, sm);
 
 	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
-- 
2.39.2

