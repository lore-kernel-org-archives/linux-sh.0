Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DFC3AD503
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744316; cv=none; b=byk9ECufdD/ROLJwinv+TcNEp0n2YS1C20Ql6u4jKVZT45Lk7xwIZ/mx+HHobYJOtqDEG3hJORWEFR3hGPS9pW5hnucqdT2FkjVs89p3ajZbIbt3pcegKQapBkeIyBRq/yYbritBAwgPyRDkti6/ADMNPIq2w3byYmU3hiy0hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744316; c=relaxed/simple;
	bh=/rM8IqPjU+R04n6SZb8x8SO4HoSulmkIegIvRZa7O2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ey3cqWeS9l6byHkdlB59t0l8e5ovRzBaX3eOWcb/bsYBAlmqIHX2mKRSPZYtCJrY6qAq62J4p9PBNUWQdosGArby+XfOY6/r8JGohkISBkRlKa4+e7DPN3f0UrzfUj2w+uL3eygO2bvIm7FBA3R3ocvQ3Rum7dmBboaXuCXWVtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/598yiQ; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/598yiQ"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1460bcc512eso2883982c88.1
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744310; x=1791349110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkhA+8cWYvHqZhY6iLwHv2/LvuwEvb7MG4/tjzgWNo4=;
        b=e/598yiQ2gO3CcvIgkRzqQZQ/1PoxO3UNX9MJVqYn61Ow79ADqgph/BsFEEAhConLF
         khmGcOlCBOX7ijitCDhCINOAFMBKmhUedVckhu3rTxeyxvlK5qi7s7blWZzuXxPTJoxG
         nLF1wG+EJ261fqRLcdUWvAyikiyBTKVRCDEllumf1bDSGuvneYOSGQVJ3MMhbtnd+qwJ
         5JSgm1bFAnaiLPYgS4VBAvUvMhldYzXMbBMG/2Zf8cvsjwcnrPY+pk+x3A7OmsyXVWwe
         4MTxyFZGF3eQdfOXykNSrC2skDDGLJ6qytWeels/WMkCFvMuqHHvYg6Hxz0vZk0Cgl1b
         IlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744310; x=1791349110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WkhA+8cWYvHqZhY6iLwHv2/LvuwEvb7MG4/tjzgWNo4=;
        b=uZIj4sJ6d4c5ui/Ka+HzjqFYpJthaXXyFe02IIf/+hRq9rmIW8duuU170LRxt3HXog
         1WtoCtERfz17E6Rm4fVbiU7n48fzqPlN1A92xCLIoaBoqy8V9gtXvjEOTfOEeMOUow6I
         TzyZjKEfCVSoFRbjet4rYV3brTNAQUKm5F/JPRwSML6Pw1mIZFZWFjIC0TEZ7fMz3+dk
         CBJh5RLS9BQEaS2Lz2bYwOvrWQVvFc6Vgu5bP2niNDRU2djHHNBWP423RnVEbl3DYLn8
         bK45y8q8dvo8q/tiRESbHsE65uRbrnaC00vBTCj+bsZwyiKFM7rznjDwwyuwQDWbiDZL
         ZMUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJo0PbIAt6xMQAb80jz48VPKbhuDIU/GOni4iwDZzsxYv6qX22CNUvb2pcmdlWgSGGuNqAC9rnXw==@vger.kernel.org
X-Gm-Message-State: AFuF++nW/dLKLag2rIoAXBMcoCPGMlIa5ZSWnieBluzMJo4/dw0PO3eV
	QW/xQDtFqOsXU60/Vr2ie0zdoq6LljaJ96MhsGFZxaEU7YtzF1MXG4ee
X-Gm-Gg: AYBFou35mMgETgiZxlh/BswxI2wI50Gg004n6NSuG5/0+FAl+a6QhLc9XQML7AfjTWP
	w6b3RYdbuu8wEFRXlTlgN28Y3/zxs8+5lJq9d5nl0OEgbG9o14qvidHz7FanVXwmJ5qJuvhzZtv
	ClNLgerEDxKcPGLgpjPP9sDORE8yebotW2jgtOJSeh96dX7nM2PgvBH8q2HWjv5V8YiO6vXNT0W
	qHfAOOL7ru40rlw8bosclePD/bmEYOy0CTKjiNWvSOPFQ5znPUhnN4uIst/lAWUnhAKCZqipdcy
	/u9xlCygJf/VPbeRS1THHIIHMydVeG2Bwdd7P5ErjEzzzBtEB8W1mhccjQ4Z9lzGnzEAFjUs/04
	I0U825MCHmSPuBg1fvApawzd4+7eKYZ8QdAD+bC79jFY8N81TVZWeWrsEdJwCkXlXZ0EWIlaguz
	Ee1PNUKMLLTt0Ni+fc9i2v87C2XKWaojsBlYO4bQSPjIPRU3JcQJZ/kZ/GuKe+ImzuAkrcuCstM
	DFo12l3zAE/sb5wb6bEnoBnMehOtmETlqNZNv+MTarmqrn/cYEVNz5a9uZXZD8=
X-Received: by 2002:a05:701b:2712:b0:13f:be10:5168 with SMTP id a92af1059eb24-14d32336ab1mr60544c88.20.1790744310100;
        Tue, 29 Sep 2026 21:58:30 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf514b783sm571056eec.13.2026.09.29.21.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:58:27 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 29 Sep 2026 21:58:02 -0700
Subject: [PATCH v3 3/5] sh: mach-rsk: rsk7203: use static device properties
 for LEDs and GPIO buttons
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rsk7203-properties-v3-3-02f84aeb8e47@gmail.com>
References: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
In-Reply-To: <20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com>
To: Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.17-dev-6c14f

Convert the board to use static device properties instead of platform
data to describe LEDs and GPIO-connected buttons on the board, so
that support for platform data can be removed from gpio-keys and other
drivers, unifying their behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-rsk/devices-rsk7203.c | 225 ++++++++++++++++++++----------
 1 file changed, 152 insertions(+), 73 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index e6b05d4588b7..8076c9d15f87 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -4,17 +4,19 @@
  *
  * Copyright (C) 2008 - 2010  Paul Mundt
  */
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/smsc911x.h>
 #include <linux/input.h>
+#include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/gpio_keys.h>
-#include <linux/leds.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <asm/machvec.h>
-#include <asm/io.h>
+#include <cpu/pfc.h>
 #include <cpu/sh7203.h>
 
 static struct smsc911x_platform_config smsc911x_config = {
@@ -37,92 +39,154 @@ static struct resource smsc911x_resources[] = {
 	},
 };
 
-static struct platform_device smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smsc911x_resources),
-	.resource	= smsc911x_resources,
-	.dev		= {
-		.platform_data = &smsc911x_config,
-	},
+static const struct software_node rsk7203_gpio_leds_node = {
+	.name = "rsk7203-gpio-leds",
 };
 
-static struct gpio_led rsk7203_gpio_leds[] = {
-	{
-		.name			= "green",
-		.gpio			= GPIO_PE10,
-		.active_low		= 1,
-	}, {
-		.name			= "orange",
-		.default_trigger	= "nand-disk",
-		.gpio			= GPIO_PE12,
-		.active_low		= 1,
-	}, {
-		.name			= "red:timer",
-		.default_trigger	= "timer",
-		.gpio			= GPIO_PC14,
-		.active_low		= 1,
-	}, {
-		.name			= "red:heartbeat",
-		.default_trigger	= "heartbeat",
-		.gpio			= GPIO_PE11,
-		.active_low		= 1,
-	},
+static const struct property_entry rsk7203_green_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "green"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PE10, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct gpio_led_platform_data rsk7203_gpio_leds_info = {
-	.leds		= rsk7203_gpio_leds,
-	.num_leds	= ARRAY_SIZE(rsk7203_gpio_leds),
+static const struct software_node rsk7203_green_led_node = {
+	.name = "green",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_green_led_props,
 };
 
-static struct platform_device led_device = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &rsk7203_gpio_leds_info,
-	},
+static const struct property_entry rsk7203_orange_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "orange"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "nand-disk"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PE12, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct gpio_keys_button rsk7203_gpio_keys_table[] = {
-	{
-		.code		= BTN_0,
-		.gpio		= GPIO_PB0,
-		.active_low	= 1,
-		.desc		= "SW1",
-	}, {
-		.code		= BTN_1,
-		.gpio		= GPIO_PB1,
-		.active_low	= 1,
-		.desc		= "SW2",
-	}, {
-		.code		= BTN_2,
-		.gpio		= GPIO_PB2,
-		.active_low	= 1,
-		.desc		= "SW3",
-	},
+static const struct software_node rsk7203_orange_led_node = {
+	.name = "orange",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_orange_led_props,
 };
 
-static struct gpio_keys_platform_data rsk7203_gpio_keys_info = {
-	.buttons	= rsk7203_gpio_keys_table,
-	.nbuttons	= ARRAY_SIZE(rsk7203_gpio_keys_table),
-	.poll_interval	= 50, /* default to 50ms */
+static const struct property_entry rsk7203_red1_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "red:timer"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "timer"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PC14, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct platform_device keys_device = {
-	.name		= "gpio-keys-polled",
-	.dev		= {
-		.platform_data	= &rsk7203_gpio_keys_info,
-	},
+static const struct software_node rsk7203_red1_led_node = {
+	.name = "red:timer",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_red1_led_props,
+};
+
+static const struct property_entry rsk7203_red2_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "red:heartbeat"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "heartbeat"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PE11, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node rsk7203_red2_led_node = {
+	.name = "red:heartbeat",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_red2_led_props,
+};
+
+static const struct property_entry rsk7203_gpio_keys_props[] = {
+	PROPERTY_ENTRY_U32("poll-interval", 50),
+	{ }
+};
+
+static const struct software_node rsk7203_gpio_keys_node = {
+	.name = "rsk7203-gpio-keys",
+	.properties = rsk7203_gpio_keys_props,
+};
+
+static const struct property_entry rsk7203_sw1_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_0),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PB0, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW1"),
+	{ }
+};
+
+static const struct software_node rsk7203_sw1_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = rsk7203_sw1_key_props,
 };
 
-static struct platform_device *rsk7203_devices[] __initdata = {
-	&smsc911x_device,
-	&led_device,
-	&keys_device,
+static const struct property_entry rsk7203_sw2_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_1),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PB1, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW2"),
+	{ }
+};
+
+static const struct software_node rsk7203_sw2_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = rsk7203_sw2_key_props,
+};
+
+static const struct property_entry rsk7203_sw3_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_2),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PB2, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW3"),
+	{ }
+};
+
+static const struct software_node rsk7203_sw3_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = rsk7203_sw3_key_props,
+};
+
+static const struct software_node * const rsk7203_swnodes[] __initconst = {
+	&rsk7203_gpio_leds_node,
+	&rsk7203_green_led_node,
+	&rsk7203_orange_led_node,
+	&rsk7203_red1_led_node,
+	&rsk7203_red2_led_node,
+	&rsk7203_gpio_keys_node,
+	&rsk7203_sw1_key_node,
+	&rsk7203_sw2_key_node,
+	&rsk7203_sw3_key_node,
+	NULL
+};
+
+static const struct platform_device_info rsk7203_devices[] __initconst = {
+	{
+		.name		= "smsc911x",
+		.id		= PLATFORM_DEVID_NONE,
+		.res		= smsc911x_resources,
+		.num_res	= ARRAY_SIZE(smsc911x_resources),
+		.data		= &smsc911x_config,
+		.size_data	= sizeof(smsc911x_config),
+	},
+	{
+		.name		= "leds-gpio",
+		.id		= PLATFORM_DEVID_NONE,
+		.swnode		= &rsk7203_gpio_leds_node,
+	},
+	{
+		.name		= "gpio-keys-polled",
+		.id		= PLATFORM_DEVID_NONE,
+		.swnode		= &rsk7203_gpio_keys_node,
+	},
 };
 
 static int __init rsk7203_devices_setup(void)
 {
+	struct platform_device *pd;
+	int error;
+	int i;
+
 	/* Select pins for SCIF0 */
 	gpio_request(GPIO_FN_TXD0, NULL);
 	gpio_request(GPIO_FN_RXD0, NULL);
@@ -131,7 +195,22 @@ static int __init rsk7203_devices_setup(void)
 	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
 	gpio_request(GPIO_FN_IRQ0_PB, NULL);
 
-	return platform_add_devices(rsk7203_devices,
-				    ARRAY_SIZE(rsk7203_devices));
+	error = software_node_register_node_group(rsk7203_swnodes);
+	if (error) {
+		pr_err("failed to register software nodes: %d\n", error);
+		return error;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
+		pd = platform_device_register_full(&rsk7203_devices[i]);
+		error = PTR_ERR_OR_ZERO(pd);
+		if (error) {
+			pr_err("failed to create platform device %s: %d\n",
+			       rsk7203_devices[i].name, error);
+			return error;
+		}
+	}
+
+	return 0;
 }
 device_initcall(rsk7203_devices_setup);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

