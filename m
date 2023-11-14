Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD30C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjKNIBO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjKNIBN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:01:13 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B4FE19B
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:01:09 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id A88EA1C0465;
        Tue, 14 Nov 2023 17:01:08 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Lee Jones <lee@kernel.org>, Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4 24/37] mfd: sm501: Convert platform_data to OF property
Date:   Tue, 14 Nov 2023 17:00:15 +0900
Message-Id: <478cf6465ab23eaf00515b8d067101bec514358b.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Various parameters of SM501 can be set using platform_data,
so parameters cannot be passed in the DeviceTree target.
Expands the parameters set in platform_data so that they can be
specified using DeviceTree properties.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/mfd/sm501.c           | 70 +++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/sm501fb.c | 70 +++++++++++++++++++++++++++++++++--
 include/linux/sm501.h         |  3 +-
 3 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 28027982cf69..4f9c9c5936ff 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1370,6 +1370,69 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static void sm501_of_read_reg_init(struct device_node *np,
+				   const char *propname, struct sm501_reg_init *val)
+{
+	u32 u32_val[2];
+
+	if (!of_property_read_u32_array(np, propname, u32_val, sizeof(u32_val))) {
+		val->set = u32_val[0];
+		val->mask = u32_val[1];
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
+	if (!of_property_read_u32(np, "smi,devices", &u32_val))
+		plat->init->devices = u32_val;
+
+	if (!of_property_read_u32(np, "smi,mclk", &u32_val))
+		plat->init->mclk = u32_val;
+
+	if (!of_property_read_u32(np, "smi,m1xclk", &u32_val))
+		plat->init->m1xclk = u32_val;
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
+					      plat->gpio_i2c, sz_gpio / sizeof(int));
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
@@ -1406,6 +1469,13 @@ static int sm501_plat_probe(struct platform_device *dev)
 		goto err_res;
 	}
 
+#ifdef CONFIG_OF
+	if (dev->dev.of_node) {
+		ret = sm501_parse_dt(sm, dev->dev.of_node);
+		if (ret)
+			goto err_res;
+	}
+#endif
 	platform_set_drvdata(dev, sm);
 
 	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index d6fdc1737cd2..36a080dd35a1 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1932,10 +1932,62 @@ static int sm501fb_start_one(struct sm501fb_info *info,
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static struct sm501_platdata_fbsub *read_fbsub(struct device_node *np, const char *ch_name)
+{
+	struct sm501_platdata_fbsub *fbsub = NULL;
+	struct fb_videomode *def_mode;
+	struct device_node *child;
+	const void *prop;
+	u32 flags;
+	u32 bpp;
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
+	if (of_property_read_u32(child, "smi,flags", &flags))
+		flags = 0;
+
+	if (def_mode || bpp || flags) {
+		fbsub = kzalloc(sizeof(*fbsub), GFP_KERNEL);
+		if (fbsub) {
+			fbsub->def_mode = def_mode;
+			fbsub->def_bpp = bpp;
+			fbsub->flags = flags;
+		}
+	}
+	return fbsub;
+}
+#endif
+
 static int sm501fb_probe(struct platform_device *pdev)
 {
-	struct sm501fb_info *info;
 	struct device *dev = &pdev->dev;
+	struct sm501fb_info *info;
+	const void *prop;
+	const char *cp;
+	int len;
 	int ret;
 
 	/* allocate our framebuffers */
@@ -1957,9 +2009,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 		int found = 0;
 #if defined(CONFIG_OF)
 		struct device_node *np = pdev->dev.parent->of_node;
-		const u8 *prop;
-		const char *cp;
-		int len;
+		struct sm501_platdata_fbsub *sub;
 
 		info->pdata = &sm501fb_def_pdata;
 		if (np) {
@@ -1974,6 +2024,18 @@ static int sm501fb_probe(struct platform_device *pdev)
 				if (info->edid_data)
 					found = 1;
 			}
+			if (of_property_read_bool(np, "route-crt-panel"))
+				info->pdata->fb_route = SM501_FB_CRT_PANEL;
+			else
+				info->pdata->fb_route = SM501_FB_OWN;
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
diff --git a/include/linux/sm501.h b/include/linux/sm501.h
index 2f3488b2875d..5c9a683b0615 100644
--- a/include/linux/sm501.h
+++ b/include/linux/sm501.h
@@ -6,6 +6,8 @@
  *	Vincent Sanders <vince@simtec.co.uk>
 */
 
+#include <dt-bindings/display/sm501.h>
+
 extern int sm501_unit_power(struct device *dev,
 			    unsigned int unit, unsigned int to);
 
@@ -35,7 +37,6 @@ extern unsigned long sm501_modify_reg(struct device *dev,
 				      unsigned long clear);
 
 
-/* Platform data definitions */
 
 #define SM501FB_FLAG_USE_INIT_MODE	(1<<0)
 #define SM501FB_FLAG_DISABLE_AT_EXIT	(1<<1)
-- 
2.39.2

