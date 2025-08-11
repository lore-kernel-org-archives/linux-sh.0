Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD731F948;
	Mon, 11 Aug 2025 22:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952302; cv=none; b=A3tEqxjAQl80YodUMXSz/RFLCU9lehDlrSwd59ZOhNC9lZPt9dFyLJnT5z1HYudlOZvW7tjl+XMUTUM1U3KLI+pd+SVJFj3X2LYMq23vLE3AUEGdudqNamskwtg2RhvW5N43JzyyuP1bk3I7ghDcvpQrOU5p2qH0GsmZkHuAUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952302; c=relaxed/simple;
	bh=wJvLUTd+FINFwDIf/0PduGgYaHan+DHlP09DeFAv5gI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mUIu2AxhlIPRr0/6HKFvGqz3dYP2ILZJMSoBKgeWfP/Haaieei5gvjtm5L4CKQnjcSZGr0ZPevZAieN0LK3cJDazaQIzIZOfu5I7uvrxYxhFouVMpAidhvJyXLOy7Q6PiTnK2gWZ83/QatYIF8ODB2sPHJEhJIZR+Xa9Pu7e7rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAomEmlU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAomEmlU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-242ff06b130so794795ad.0;
        Mon, 11 Aug 2025 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952300; x=1755557100; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k34tsCzA5ldSeSb5eH/rwHTVFsGocF6mVEh3h7dOMwE=;
        b=kAomEmlUskUvug8/v6Fu+RC139vO8cOFT4MbQPVmlRRfPkBJYpdNeq25tYs0ByEwLX
         mqN4KCFJ5AECknrJkVGTi+u1Ugq1qB317lA1simt7KK0gv98EMSWuijSJLVW6C1ksCm7
         wZs74J8n1issBUq+2b0p/M4G0LbFUgi1ayN726qDmi/UA25mMqGg4FGtnBw0Ll7FO3oF
         EkyABdPzR/1TzP53qKb/G1cuWinwlwqsBA7BnDjDyCptrPg0mMaryEGM26tbbVvW/3yd
         neHzzIic4FiQiU0unrz6bON/HxZRupFChoXz3TVjgiqv65Sur8tcsbIsBB6NzJwNEcT1
         RgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952300; x=1755557100;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k34tsCzA5ldSeSb5eH/rwHTVFsGocF6mVEh3h7dOMwE=;
        b=rVsqfP+nCF/sD/8gQkl0VHek/BNAH5s/rv0VOAiYADW0f5FUmp5PET5daStYC19EBW
         SzghrnCcW07CXF9dHIkYDyM1WEB4JVYBlI8rKg6+tme1m31kWreD795MFEbbU/7v702L
         2MXOnbNBZHZuNqMl3jKtz+/YasZVa7841SOucOcELLO4FxyjcZk2rCyVxSZXQa3/UdGl
         /v5zHfzIC1pikM3NZY817cOIcn82YGNNzrJcCoILwn7bpzdSgCBZEb3FtTMvqpYBJlVW
         1cf8oSBDczth6w1BG8pTf84Amqncq+hFmHmE6opFhGkSr4LbcGSNw76jwRgu8kiOCTtF
         mEOg==
X-Forwarded-Encrypted: i=1; AJvYcCUWlZAkLzCJRgkGo0tK9Bnbt0eF7ZQMIw7f75TdmZH1nhRMxKCPokGcTScKlsDT35nyMO9g2RgdhYQ=@vger.kernel.org, AJvYcCVRlaUrhEAacztWk5Wf287jLGDRaG4Kk5dMvCLgzVQDDXJrdxLBrGR7FbWWiEA3OOybbjgvZkTjba6Bo8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHR6Q1asU7Sc/oGKZrKRGcjbbLD2Q7Aq0dgmVYlfTN86Oa5stY
	pxkJfl8+K+wROK4GCMrbD6P87un0FSDycVVtH2Lq+f2zczsAQ+jIlTLu
X-Gm-Gg: ASbGncvPoWICNLT+ukOoBshWcB2py2L5r+CE9Md+LjAdkEDdlI/bKKdsfTR5SNXZb9c
	ZCnFBmG6hlH8KjJG0ZOfSTEv/3nf5QpIESedosHTw2AJpbpvASlXyQanA7qW/t11L0B2t6sNem9
	B9GRGZP+uDLfTQK8MrbUWSNDtpBJmd5QXNwtCDoG6UQX44WDroF7HBUFVuXx09N4ceveDYexu+6
	vuDMFyMMWJsLi6fE5Kn5ZjbXuLS5a0eg/6HnACuNKtHRgE6oRzFJDciilWC/rtER4qV3h0jVCt5
	+8XD6osi6bJoa22j/d/eAyTQwsAsMU0xg63JTXmlmTj5Z/yj0x4oz7USLFteS3dF9rY+rwzeSfO
	KRTu3aQWGZSVH52WLsRu1Umc=
X-Google-Smtp-Source: AGHT+IH4p/iuyMGqGy8RlTDWB5xz5+fBMNVleFUkEDkRq/2zhmv7im6s2PtathwtV4T3JpgN6Yqp3w==
X-Received: by 2002:a17:902:e544:b0:240:418c:b9f6 with SMTP id d9443c01a7336-242c2262214mr210990145ad.49.1754952299781;
        Mon, 11 Aug 2025 15:44:59 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7933:7499:67d8:279a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaab44sm283722175ad.155.2025.08.11.15.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:44:59 -0700 (PDT)
Date: Mon, 11 Aug 2025 15:44:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: mach-rsk: rsk7203: use static device properties for LEDs
 and GPIO buttons
Message-ID: <jwtdoptatzfo47mbpmmjwhhhjn4mbw6ekp4gtoopca7azbcelo@uvtz4w2ga5qn>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the board to use static device properties instead of platform
data to describe LEDs and GPIO-connected buttons on the board, so
that support for platform data can be removed from gpio-keys and other
drivers, unifying their behavior.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This compiles but I have not tried this on real hardware.

 arch/sh/boards/mach-rsk/devices-rsk7203.c | 237 +++++++++++++++-------
 1 file changed, 166 insertions(+), 71 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index e6b05d4588b7..b66b142ba84f 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2008 - 2010  Paul Mundt
  */
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/platform_device.h>
@@ -11,7 +12,8 @@
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
-#include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <linux/leds.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
@@ -37,92 +39,165 @@ static struct resource smsc911x_resources[] = {
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
+static const struct software_node rsk7203_gpiochip_node = {
+	.name = "pfc-sh7203",
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
+static const struct software_node rsk7203_gpio_leds_node = {
+	.name = "rsk7203-gpio-leds",
 };
 
-static struct gpio_led_platform_data rsk7203_gpio_leds_info = {
-	.leds		= rsk7203_gpio_leds,
-	.num_leds	= ARRAY_SIZE(rsk7203_gpio_leds),
+static const struct property_entry rsk7203_green_led_props[] = {
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
+			    GPIO_PE10, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct platform_device led_device = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &rsk7203_gpio_leds_info,
-	},
+static const struct software_node rsk7203_green_led_node = {
+	.name = "green",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_green_led_props,
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
+static const struct property_entry rsk7203_orange_led_props[] = {
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "nand-disk"),
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
+			    GPIO_PE12, GPIO_ACTIVE_LOW),
+	{ }
 };
 
-static struct gpio_keys_platform_data rsk7203_gpio_keys_info = {
-	.buttons	= rsk7203_gpio_keys_table,
-	.nbuttons	= ARRAY_SIZE(rsk7203_gpio_keys_table),
-	.poll_interval	= 50, /* default to 50ms */
+static const struct software_node rsk7203_orange_led_node = {
+	.name = "orange",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_orange_led_props,
 };
 
-static struct platform_device keys_device = {
-	.name		= "gpio-keys-polled",
-	.dev		= {
-		.platform_data	= &rsk7203_gpio_keys_info,
-	},
+static const struct property_entry rsk7203_red1_led_props[] = {
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "timer"),
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
+			    GPIO_PC14, GPIO_ACTIVE_LOW),
+	{ }
+};
+
+static const struct software_node rsk7203_red1_led_node = {
+	.name = "red:timer",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = rsk7203_red1_led_props,
+};
+
+static const struct property_entry rsk7203_red2_led_props[] = {
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "heartbeat"),
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
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
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
+			    GPIO_PB0, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW1"),
+	{ }
+};
+
+static const struct software_node rsk7203_sw1_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = rsk7203_sw1_key_props,
+};
+
+static const struct property_entry rsk7203_sw2_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_1),
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
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
+	PROPERTY_ENTRY_GPIO("gpios", &rsk7203_gpiochip_node,
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
+static const struct software_node *rsk7203_swnodes[] __initdata = {
+	&rsk7203_gpiochip_node,
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
+struct rsk7203_device_info {
+	struct platform_device_info info;
+	const struct software_node *node;
 };
 
-static struct platform_device *rsk7203_devices[] __initdata = {
-	&smsc911x_device,
-	&led_device,
-	&keys_device,
+static const struct rsk7203_device_info rsk7203_devices[] __initconst = {
+	{
+		.info = {
+			.name		= "smsc911x",
+			.id		= PLATFORM_DEVID_NONE,
+			.res		= smsc911x_resources,
+			.num_res	= ARRAY_SIZE(smsc911x_resources),
+			.data		= &smsc911x_config,
+			.size_data	= sizeof(smsc911x_config),
+		},
+	},
+	{
+		.info = {
+			.name		= "leds-gpio",
+			.id		= PLATFORM_DEVID_NONE,
+		},
+		.node = &rsk7203_gpio_leds_node,
+	},
+	{
+		.info = {
+			.name		= "gpio-keys-polled",
+		},
+		.node = &rsk7203_gpio_keys_node,
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
@@ -131,7 +206,27 @@ static int __init rsk7203_devices_setup(void)
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
+		struct platform_device_info info = rsk7203_devices[i].info;
+
+		if (rsk7203_devices[i].node)
+			info.fwnode = software_node_fwnode(rsk7203_devices[i].node);
+
+		pd = platform_device_register_full(&info);
+		error = PTR_ERR_OR_ZERO(pd);
+		if (error) {
+			pr_err("failed to create platform device %s: %d\n",
+			       info.name, error);
+			return error;
+		}
+	}
+
+	return 0;
 }
 device_initcall(rsk7203_devices_setup);
-- 
2.51.0.rc0.155.g4a0f42376b-goog


-- 
Dmitry
