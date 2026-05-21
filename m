Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7F357D01
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340433; cv=none; b=FDhbCug+JMKH6Xiio+HJK5KNzrMUu3nE8Zc3oMtxztKZ6j1rZ0VWbnNG6XofNJ7YPXPEI4hm8G+fBMVQCgMtM+LpDR7ShVkZ6h6syGtCKNghQH3KpZSpxGnUlefElL8uCUp6wOoP93m8gt7zhGvaX0wwCzCWzkaQm12IWoGDbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340433; c=relaxed/simple;
	bh=sqigRYMe9Ei/euDhl7m0Dt51zXJI7/WmeHuh6kLpDkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U++vLcSfWAqZS/bGou16WxNI7xKONB73wCBnDChU74UqgIk6Sd1+B3tFHuB2pMlhZrUzda1qKQXH00qpF5Rls8uAxHaF3sMaqkRXUaZ7LVCJvKugfP+cRy8cf00+9JqR7M/nwkSjeEQcHNiqJ94Zrbd7qM60ghsd4r/r2M3PHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J77fQK3A; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J77fQK3A"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-132c338a537so3991552c88.0
        for <linux-sh@vger.kernel.org>; Wed, 20 May 2026 22:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779340430; x=1779945230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+AeVt9B3IyF1WrSPsCMEkGadYjuCmhfMkRPmef3xtU=;
        b=J77fQK3AadKZDKsyAl9Y1u2JzJuSI1WpB1jR9/FjyYAuBejNkLtiRwkHn+tJVZIsNM
         reNY9DMDSnDS1kUxoxD9BNF/VdNEX4taWNEry6pW/KH9Fai58sV71pLDkLjrgr7dG7/x
         H4QreGF8qle4quVqL6SH//xFFMKzvMoYM+mJV0PcuVESiLqI3hVxKiKgUhH0ZiDiJw/8
         HFwPtYjfIxCanjFGWp5TLKjn2DkEymUkaWGu6X3iyWKNqHHcvcTjvifX0HcwKQZhyGTQ
         /eUDb7IkqlAzJJIcKuzaAsH71BURr/vNWesGmm3n/kWccAh90Zk6YosUOC2ETOjIUP+S
         DaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779340430; x=1779945230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+AeVt9B3IyF1WrSPsCMEkGadYjuCmhfMkRPmef3xtU=;
        b=BrRU7ipco+2z4EnKYtq67JPygSOf/PyFPuUdDPzLFHoFKp20RqNckZo8vJMaYeNLnL
         N5xfo+1Ul2HCIXqPXO04bhbIHpiePzFA0S2CjG4VhErHJnH3AvJeF+tO0juR3vVMc+lM
         q+NDJqrc66FVq6llAKsf0vjJXnZ9z/kw88+mpq0CLGA0acB0GY0zpSfBQUamj3IHsmdw
         D4LmZ+9Cc1/8ybZl66t38lfBcmxk6stjaThhiC4YIfDL9Rg0gyIU2m+Wjaf0JQ6kmHq0
         fLQn+F6gle8Y9yutMYmnS0iSULHB+PjWiKZw5EEayKIHMJ3+kN6hqI5R+dbakClYMVvr
         3OcQ==
X-Forwarded-Encrypted: i=1; AFNElJ+H7pSAK5/CBWQXmZ8lx+iXwp9+zbegZwXkcFl/y/TrBPt6wHrHeoZvTSbvtlGy9l81f73EpTy2OA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnKMWXbx2GtDTk74bMSF4D4GB2lYZCPfB8xkEFYeDP4FZtzg3S
	rQH/hP3efo7WzOdDLgssWgcResY89KfuY/3cY+ukeT8A+duVDYeaDCdh
X-Gm-Gg: Acq92OFMxvIjyl8sgT7CMu1wikjtD9UF2wATwaBBKUJywj8BbIAWUIOL6gSNMiJW9/w
	Q5HCl0PkqcN3/8wcUfcRgm5m2k+Du62cKTKh3tHTWXULVwnYbPajizdn9NZLBLN606RRtbk+8Eg
	rxXpsBViKxL0F9+DymqTCaI7JGPZdGBnQ/OV/t/7tFXTPKIUgJcWaHrqI2i9D8CaHmJn6p9Zo6e
	aUx1yH7Kodm42gNfXVE5S5UaoKh5ZcQ/jyqRlNTBCvuHx3dr1C/1GD3irsDvqs/eMUs6vGU4V3h
	aC4KwxSCKQwOX7XwL8unXat4K65sQDlFIZ0Q+GL4/ywdk9g5bTyZlMmVkPnll/WoxL+Jv61UCnJ
	DzXhMvNcDL17DHiGaPgOs5qy0yrvh3dH6Lpgs4BsNdEY11gT0FCNG05VficcuSkUoNvcSdzECSh
	JNPckhQ+Ty/QVp875rOY3TsNci8KDTuUCbiWLAfOz4Uv3EgE2j+lD0YV8++yDpK5gj9H0iCZeCL
	+RuuGpwo4NCoQ==
X-Received: by 2002:a05:7022:609c:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-13633eb60b4mr545331c88.16.1779340425118;
        Wed, 20 May 2026 22:13:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d457:597:d576:1eb8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm6231360c88.14.2026.05.20.22.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:13:44 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 20 May 2026 22:13:19 -0700
Subject: [PATCH v2 3/5] sh: mach-rsk: rsk7203: use static device properties
 for LEDs and GPIO buttons
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rsk7203-properties-v2-3-465f3308021b@gmail.com>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
In-Reply-To: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
To: Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Convert the board to use static device properties instead of platform
data to describe LEDs and GPIO-connected buttons on the board, so
that support for platform data can be removed from gpio-keys and other
drivers, unifying their behavior.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-rsk/devices-rsk7203.c | 199 ++++++++++++++++++++----------
 1 file changed, 131 insertions(+), 68 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index e6b05d4588b7..f8760a91e2f1 100644
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
@@ -37,92 +39,138 @@ static struct resource smsc911x_resources[] = {
 	},
 };
 
-static struct platform_device smsc911x_device = {
-	.name		= "smsc911x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smsc911x_resources),
-	.resource	= smsc911x_resources,
-	.dev		= {
-		.platform_data = &smsc911x_config,
+static const struct software_node rsk7203_gpio_leds_node = {
+	.name = "rsk7203-gpio-leds",
+};
+
+static const struct software_node rsk7203_green_led_node = {
+	.name = "green",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_STRING("label", "green"),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PE10, GPIO_ACTIVE_LOW),
+		{ }
 	},
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
+static const struct software_node rsk7203_orange_led_node = {
+	.name = "orange",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_STRING("label", "orange"),
+		PROPERTY_ENTRY_STRING("linux,default-trigger", "nand-disk"),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PE12, GPIO_ACTIVE_LOW),
+		{ }
 	},
 };
 
-static struct gpio_led_platform_data rsk7203_gpio_leds_info = {
-	.leds		= rsk7203_gpio_leds,
-	.num_leds	= ARRAY_SIZE(rsk7203_gpio_leds),
+static const struct software_node rsk7203_red1_led_node = {
+	.name = "red:timer",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_STRING("label", "red:timer"),
+		PROPERTY_ENTRY_STRING("linux,default-trigger", "timer"),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PC14, GPIO_ACTIVE_LOW),
+		{ }
+	},
 };
 
-static struct platform_device led_device = {
-	.name		= "leds-gpio",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &rsk7203_gpio_leds_info,
+static const struct software_node rsk7203_red2_led_node = {
+	.name = "red:heartbeat",
+	.parent = &rsk7203_gpio_leds_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_STRING("label", "red:heartbeat"),
+		PROPERTY_ENTRY_STRING("linux,default-trigger", "heartbeat"),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PE11, GPIO_ACTIVE_LOW),
+		{ }
 	},
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
+static const struct software_node rsk7203_gpio_keys_node = {
+	.name = "rsk7203-gpio-keys",
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_U32("poll-interval", 50),
+		{ }
 	},
 };
 
-static struct gpio_keys_platform_data rsk7203_gpio_keys_info = {
-	.buttons	= rsk7203_gpio_keys_table,
-	.nbuttons	= ARRAY_SIZE(rsk7203_gpio_keys_table),
-	.poll_interval	= 50, /* default to 50ms */
+static const struct software_node rsk7203_sw1_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_U32("linux,code", BTN_0),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PB0, GPIO_ACTIVE_LOW),
+		PROPERTY_ENTRY_STRING("label", "SW1"),
+		{ }
+	},
 };
 
-static struct platform_device keys_device = {
-	.name		= "gpio-keys-polled",
-	.dev		= {
-		.platform_data	= &rsk7203_gpio_keys_info,
+static const struct software_node rsk7203_sw2_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_U32("linux,code", BTN_1),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PB1, GPIO_ACTIVE_LOW),
+		PROPERTY_ENTRY_STRING("label", "SW2"),
+		{ }
 	},
 };
 
-static struct platform_device *rsk7203_devices[] __initdata = {
-	&smsc911x_device,
-	&led_device,
-	&keys_device,
+static const struct software_node rsk7203_sw3_key_node = {
+	.parent = &rsk7203_gpio_keys_node,
+	.properties = (const struct property_entry[]) {
+		PROPERTY_ENTRY_U32("linux,code", BTN_2),
+		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+				    GPIO_PB2, GPIO_ACTIVE_LOW),
+		PROPERTY_ENTRY_STRING("label", "SW3"),
+		{ }
+	},
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
@@ -131,7 +179,22 @@ static int __init rsk7203_devices_setup(void)
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
2.54.0.669.g59709faab0-goog

