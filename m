Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DD7CDB474
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 14:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjJNOyc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 10:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjJNOy0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 10:54:26 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45449D6
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 07:54:24 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-1.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id fcfa4dfa-da8d-4877-b66d-3e402e926e14;
        Sat, 14 Oct 2023 23:54:22 +0900 (JST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id F01F11C04FD;
        Sat, 14 Oct 2023 23:54:20 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de, lee@kernel.org, deller@gmx.de,
        tzimmermann@suse.de, sam@ravnborg.org, robh@kernel.org,
        zhangxuezhi1@coolpad.com, u.kleine-koenig@pengutronix.de
Subject: [RFC PATCH v3 20/35] drivers/mfd: sm501 add some properties.
Date:   Sat, 14 Oct 2023 23:53:55 +0900
Message-Id: <b1bedaea12693d256b2513f72bd39630a69d188a.1697199949.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697199949.git.ysato@users.sourceforge.jp>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

I am changing the target board of SuperH using SM501 to DeviceTree.
This target uses platform_device to configure sm501 and sm501fb.
In order to migrate to DeviceTree, it can now be set in properties.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/mfd/sm501.c           | 113 ++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/sm501fb.c |  92 +++++++++++++++++++++++++++
 2 files changed, 205 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 28027982cf69..e0fdb5237d29 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1370,6 +1370,113 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 	return 0;
 }
 
+#ifdef CONFIG_OF
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
+	nstr = of_property_count_strings(np, "smi,devices");
+	for (i = 0; i < nstr; i++) {
+		if (of_property_read_string_index(np, "smi,devices", i, &devstr))
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
+	plat = devm_kzalloc(sm->dev, sizeof(*plat), GFP_KERNEL);
+	if (!plat)
+		return -ENOMEM;
+
+	plat->init = devm_kzalloc(sm->dev, sizeof(*plat->init), GFP_KERNEL);
+	if (!plat->init)
+		return -ENOMEM;
+
+	plat->init->devices = sm501_parse_devices_str(np);
+
+	if (!of_property_read_u32_index(np, "smi,mclk", 0, &u32_val))
+		plat->init->mclk = u32_val;
+	else
+		plat->init->mclk = 0;
+
+	if (!of_property_read_u32_index(np, "smi,m1xclk", 0, &u32_val))
+		plat->init->m1xclk = u32_val;
+	else
+		plat->init->m1xclk = 0;
+
+	sm501_of_read_reg_init(np, "smi,misc-timing", &plat->init->misc_timing);
+	sm501_of_read_reg_init(np, "smi,misc-control", &plat->init->misc_control);
+	sm501_of_read_reg_init(np, "smi,gpio-low", &plat->init->gpio_low);
+	sm501_of_read_reg_init(np, "smi,gpio-high", &plat->init->gpio_high);
+
+#ifdef CONFIG_MFD_SM501_GPIO
+	if (plat->init->devices & SM501_USE_GPIO) {
+		if (!of_property_read_u32_index(np, "smi,num-i2c", 0, &u32_val))
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
+		of_property_read_variable_u32(np, "smi,gpio-i2c",
+					      plat->gpio_i2c, plat->gpio_i2c_nr * 5);
+	}
+#endif	/* CONFIG_MFD_SM501_GPIO */
+	sm->platdata = plat;
+	return 0;
+}
+#endif	/* CONFIG_OF */
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
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 65c799ac5604..d42f8a15e4ba 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1928,6 +1928,82 @@ static int sm501fb_start_one(struct sm501fb_info *info,
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static struct sm501_platdata_fbsub *read_fbsub(struct device_node *np, const char *ch_name)
+{
+	struct device_node *child;
+	struct sm501_platdata_fbsub *fbsub = NULL;
+	struct fb_videomode *def_mode;
+	u32 bpp;
+	u32 max_mem;
+	u32 flags = 0;
+	static const char * const flag_str[] = {
+		"use_init_mode",
+		"disable_at_exit",
+		"use_hwcursor",
+		"use_hwaccel",
+		"panel_no_fpen",
+		"panel_no_vbiasen",
+		"panel_inv_fpen",
+		"panel_inv_vbiasen",
+	};
+	const char *flag_value;
+	const char *prop;
+	int nr_flags;
+	int i, j;
+	int len;
+
+	child = of_get_child_by_name(np, ch_name);
+	if (child == NULL)
+		return NULL;
+
+	prop = of_get_property(child, "edid", &len);
+	if (prop && len == EDID_LENGTH) {
+		struct fb_monspecs *specs;
+		u8 *edid;
+
+		edid = kmemdup(prop, EDID_LENGTH, GFP_KERNEL);
+		if (edid) {
+			specs = kzalloc(sizeof(*specs), GFP_KERNEL);
+			if (specs) {
+				fb_edid_to_monspecs(edid, specs);
+				def_mode = specs->modedb;
+			}
+			kfree(specs);
+		}
+		kfree(edid);
+	}
+
+	if (of_property_read_u32(child, "bpp", &bpp))
+		bpp = 0;
+	if (of_property_read_u32(child, "max-mem", &max_mem))
+		max_mem = 0;
+
+	nr_flags = of_property_count_strings(child, "flags");
+	for (i = 0; i < nr_flags; i++) {
+		if (of_property_read_string_index(child, "flags", i, &flag_value) < 0)
+			break;
+		for (j = 0; j < ARRAY_SIZE(flag_str); j++) {
+			if (strcasecmp(flag_value, flag_str[j]) == 0) {
+				flags |= 1 << j;
+				break;
+			}
+		}
+	}
+
+	if (def_mode || bpp || max_mem || flags) {
+		fbsub = kzalloc(sizeof(*fbsub), GFP_KERNEL);
+		if (fbsub) {
+			fbsub->def_mode = def_mode;
+			fbsub->def_bpp = bpp;
+			fbsub->max_mem = max_mem;
+			fbsub->flags = flags;
+		}
+	}
+	return fbsub;
+}
+#endif
+
 static int sm501fb_probe(struct platform_device *pdev)
 {
 	struct sm501fb_info *info;
@@ -1956,6 +2032,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 		const u8 *prop;
 		const char *cp;
 		int len;
+		struct sm501_platdata_fbsub *sub;
 
 		info->pdata = &sm501fb_def_pdata;
 		if (np) {
@@ -1970,6 +2047,21 @@ static int sm501fb_probe(struct platform_device *pdev)
 				if (info->edid_data)
 					found = 1;
 			}
+			cp = of_get_property(np, "route", &len);
+			if (cp) {
+				if (strcasecmp(cp, "own") == 0)
+					info->pdata->fb_route = SM501_FB_OWN;
+				else if (strcasecmp(cp, "crt-panel") == 0)
+					info->pdata->fb_route = SM501_FB_CRT_PANEL;
+			}
+			if (of_property_read_bool(np, "swap-fb-endian"))
+				info->pdata->flags |= SM501_FBPD_SWAP_FB_ENDIAN;
+			sub = read_fbsub(np, "crt");
+			if (sub)
+				info->pdata->fb_crt = sub;
+			sub = read_fbsub(np, "panel");
+			if (sub)
+				info->pdata->fb_pnl = sub;
 		}
 #endif
 		if (!found) {
-- 
2.39.2

