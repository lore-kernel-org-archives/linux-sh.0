Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E2F292B54
	for <linux-sh@vger.kernel.org>; Sun,  5 Jul 2026 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783227889; cv=none; b=b0AlA9x0swfgHFOhDtAOYnCEj8p95ccNAYW16ucLXyLwFFlK3rWICdnujMfq0uTlAKD3W0lnv5MKIGZAx/DZrITfBrictTsjJ1cLbYiPO5Pbnjiaze+KdQxLWIwG9UmR9iJQymRhvyw163srzVaw1WgwwvE07G02tAS7eynC5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783227889; c=relaxed/simple;
	bh=BedfOIteKOYG3z+Xq//Vo2A9dlCspS/MPj6qGFGX18g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WODWAxkeGspQfQhsv7KCmeMt0aGulsSJ9TUbwVUZ8T+KHnFd4K8v72i2z1NmkheQTHBC7nhTZ3CQhp6ToqVao01ue+bB2FFdwspP1OP1uiVjDS4GCvW4+LXBPPFCz1ThtEbDuE/R4C+pcsGUq3NYOUWe+7bzA2dlhCSAk7LmraQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foAndG01; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foAndG01"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c8b49639fbaso1333727a12.0
        for <linux-sh@vger.kernel.org>; Sat, 04 Jul 2026 22:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783227888; x=1783832688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLTq0eUz0RhF9YehoJnPp8j8jPu+t93k4BWGF8kUPX0=;
        b=foAndG01DTxh1SUHB6PE+NslfE8eDKKPT0gTK74WbdUfoTD/XRPc9U5/NrhIcgkQE4
         Al5d1Dr+HMS2TQutrXqk0iAHmV7KDKj0TkyXmuzLRt62+d+BdEsEDpUEb+yPcMf2DWlG
         lww3XYI3OBH4eP7ETOc5pmhUJghgRMIdApzz4EPGhZeZsyqOLQP1SSeHXqilcpJlPCLx
         huwXO614BGj7ULXh8NPGMKDpLQ/b63eieNxpymxzzJ+Lh1AX76YXldFvJz20gCmIJYGd
         NzGKIVjakcqfAICn8FROXXGnG4hq3P/w/4p9sv7Sxke598w/hH3HkCz8ZdkARcJBhajn
         gGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783227888; x=1783832688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tLTq0eUz0RhF9YehoJnPp8j8jPu+t93k4BWGF8kUPX0=;
        b=Yc+EawCrtF5itJM8tXqXb4CRw0cxUco0skHE839CVje4mykQ/VaAc/q736/YHLnywz
         HEKD67ORwEWZpGrP5Ra7LDdxYWYmlp89tyOUKGUxVAlzASagOlosJOHk3sF1PL5+5NPc
         5e00xqGY4TA8LZF3YqPkDalRwubGg1LqE+sjdwMYQexAJgeT8V1iMFY6D6rWWrg0+SzL
         R42kyRZqsfLFnpTEkPCZwzt93W2A25kAAUR8s2lrmkC6tvqObCsmIrTHUlg9EPhfnT6v
         GJKhQltgzWykTFLBTPoTpJn7pqsmbdY6Em+2fPE05VYzUt6OxMJ7BApgQmuvF7ujygS0
         LMYw==
X-Forwarded-Encrypted: i=1; AFNElJ94l+tFC6FCtOiWyLLQn2JCQB6Y5Jz2IdOYgu70m99Ue/nIKl0gEt1mSxaEuu0+9DN4gaGOzii6Jg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPcPuY57eLhCN+7v3zPQSDhosKSE9MwOzL9vcr7Pt3BkMFC6p
	xVq2LLcW6d/Jkc+/4VK0TiLGBGI5qNBaQiyPDeIxow67sTthv8aSLXSm
X-Gm-Gg: AfdE7ckEZ8lFibjoSTUEq1DfD/bhSPnFU6oWoNuaK9hjjYjg9LUe9SA6wSdzUrhgldY
	O00UoGGEFTNWUNwQld+Dn/jmuaM3VJYADXEQXC56SDgMtyQe4mJOVAPOFJJkOTiUlcDlvJSlp2H
	gLKOoTXYQ+WTEvn22e4tttbcSlT+HVDGOk737ZZhzzlYpkMeC+QdzMtahJOP9GnW4BfUw23WZL+
	pRGmv5zLGjID0omLyfAi9G3cb8JRS2h0E53Ug5SrxzbkrM6YTfJTO1rErKwy/S5Egu/bdd1w+Qt
	qyhR78Ly8VPovKMos1Tdv+n0HYaa4Q5PJxbrLXEH2CTN/th2zMqKeJ3iNXRRaFZQMgw1daF1PdA
	c2ZI+nVUNV4gc7ggJpm9278+1iV9B2/fhavvaj0zjuKA6L0HsAW97qKIHrD2EaMYPtBAMreZ+CZ
	luKQxi1x9AuqGnQfxHyt5Nn2qK8osL6tnjFdFhjXcJ3nG1rgMwIPhxW1B4RjQeC7yIk+g7RsvsE
	VRP
X-Received: by 2002:a05:6a21:9f07:b0:3bf:b9de:854d with SMTP id adf61e73a8af0-3c03e2d7b18mr5553441637.23.1783227887595;
        Sat, 04 Jul 2026 22:04:47 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4560:aa1b:b33a:15b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3b252222sm19585414eec.23.2026.07.04.22.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 22:04:46 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 04 Jul 2026 22:04:38 -0700
Subject: [PATCH 2/2] sh: mach-x3proto: convert gpio-keys to software nodes
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-sh-x3proto-swnode-v1-2-0c039549dc46@gmail.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
In-Reply-To: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Convert the legacy gpio-keys platform device on the SH-X3 Prototype
board to use software nodes/properties. This allows us to describe
the GPIO keys and their GPIO bindings using software nodes, so that
support for platform data can eventually be removed from the
gpio-keys driver.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-x3proto/setup.c | 165 +++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 87 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3proto/setup.c
index ca2802d30565..0d9d5982cf0c 100644
--- a/arch/sh/boards/mach-x3proto/setup.c
+++ b/arch/sh/boards/mach-x3proto/setup.c
@@ -16,8 +16,8 @@
 #include <linux/input.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/usb/m66592.h>
-#include <linux/gpio/driver.h>
-#include <linux/gpio_keys.h>
+#include <linux/gpio/machine.h>
+#include <linux/gpio/property.h>
 #include <mach/ilsel.h>
 #include <mach/hardware.h>
 #include <asm/smp-ops.h>
@@ -123,87 +123,74 @@ static struct platform_device m66592_usb_peripheral_device = {
 	.resource	= m66592_usb_peripheral_resources,
 };
 
-static struct gpio_keys_button baseboard_buttons[NR_BASEBOARD_GPIOS] = {
-	{
-		.desc		= "key44",
-		.code		= KEY_POWER,
-		.active_low	= 1,
-		.wakeup		= 1,
-	}, {
-		.desc		= "key43",
-		.code		= KEY_SUSPEND,
-		.active_low	= 1,
-		.wakeup		= 1,
-	}, {
-		.desc		= "key42",
-		.code		= KEY_KATAKANAHIRAGANA,
-		.active_low	= 1,
-	}, {
-		.desc		= "key41",
-		.code		= KEY_SWITCHVIDEOMODE,
-		.active_low	= 1,
-	}, {
-		.desc		= "key34",
-		.code		= KEY_F12,
-		.active_low	= 1,
-	}, {
-		.desc		= "key33",
-		.code		= KEY_F11,
-		.active_low	= 1,
-	}, {
-		.desc		= "key32",
-		.code		= KEY_F10,
-		.active_low	= 1,
-	}, {
-		.desc		= "key31",
-		.code		= KEY_F9,
-		.active_low	= 1,
-	}, {
-		.desc		= "key24",
-		.code		= KEY_F8,
-		.active_low	= 1,
-	}, {
-		.desc		= "key23",
-		.code		= KEY_F7,
-		.active_low	= 1,
-	}, {
-		.desc		= "key22",
-		.code		= KEY_F6,
-		.active_low	= 1,
-	}, {
-		.desc		= "key21",
-		.code		= KEY_F5,
-		.active_low	= 1,
-	}, {
-		.desc		= "key14",
-		.code		= KEY_F4,
-		.active_low	= 1,
-	}, {
-		.desc		= "key13",
-		.code		= KEY_F3,
-		.active_low	= 1,
-	}, {
-		.desc		= "key12",
-		.code		= KEY_F2,
-		.active_low	= 1,
-	}, {
-		.desc		= "key11",
-		.code		= KEY_F1,
-		.active_low	= 1,
-	},
+static const struct software_node x3proto_gpio_keys_node = {
+	.name = "x3proto-gpio-keys",
 };
 
-static struct gpio_keys_platform_data baseboard_buttons_data = {
-	.buttons	= baseboard_buttons,
-	.nbuttons	= ARRAY_SIZE(baseboard_buttons),
+#define __X3PROTO_KEY(_id, _code, _gpio, ...)				\
+static const struct property_entry x3proto_key##_id##_props[] = {	\
+	PROPERTY_ENTRY_STRING("label", "key" #_id),			\
+	PROPERTY_ENTRY_U32("linux,code", _code),			\
+	PROPERTY_ENTRY_GPIO("gpios", &x3proto_gpiochip_node,		\
+			    _gpio, GPIO_ACTIVE_LOW),			\
+	__VA_ARGS__							\
+	{ }								\
+};									\
+static const struct software_node x3proto_key##_id##_node = {		\
+	.parent = &x3proto_gpio_keys_node,				\
+	.properties = x3proto_key##_id##_props,				\
+}
+
+#define X3PROTO_KEY(_id, _code, _gpio)					\
+	__X3PROTO_KEY(_id, _code, _gpio)
+
+#define X3PROTO_KEY_WAKEUP(_id, _code, _gpio)				\
+	__X3PROTO_KEY(_id, _code, _gpio,				\
+		      PROPERTY_ENTRY_BOOL("wakeup-source"),		\
+	)
+
+X3PROTO_KEY_WAKEUP(44, KEY_POWER, 0);
+X3PROTO_KEY_WAKEUP(43, KEY_SUSPEND, 1);
+X3PROTO_KEY(42, KEY_KATAKANAHIRAGANA, 2);
+X3PROTO_KEY(41, KEY_SWITCHVIDEOMODE, 3);
+X3PROTO_KEY(34, KEY_F12, 4);
+X3PROTO_KEY(33, KEY_F11, 5);
+X3PROTO_KEY(32, KEY_F10, 6);
+X3PROTO_KEY(31, KEY_F9, 7);
+X3PROTO_KEY(24, KEY_F8, 8);
+X3PROTO_KEY(23, KEY_F7, 9);
+X3PROTO_KEY(22, KEY_F6, 10);
+X3PROTO_KEY(21, KEY_F5, 11);
+X3PROTO_KEY(14, KEY_F4, 12);
+X3PROTO_KEY(13, KEY_F3, 13);
+X3PROTO_KEY(12, KEY_F2, 14);
+X3PROTO_KEY(11, KEY_F1, 15);
+
+static const struct software_node *const x3proto_swnodes[] __initconst = {
+	&x3proto_gpio_keys_node,
+	&x3proto_key44_node,
+	&x3proto_key43_node,
+	&x3proto_key42_node,
+	&x3proto_key41_node,
+	&x3proto_key34_node,
+	&x3proto_key33_node,
+	&x3proto_key32_node,
+	&x3proto_key31_node,
+	&x3proto_key24_node,
+	&x3proto_key23_node,
+	&x3proto_key22_node,
+	&x3proto_key21_node,
+	&x3proto_key14_node,
+	&x3proto_key13_node,
+	&x3proto_key12_node,
+	&x3proto_key11_node,
+	NULL
 };
 
-static struct platform_device baseboard_buttons_device = {
+static const struct platform_device_info x3proto_gpio_keys_device_info __initconst = {
 	.name		= "gpio-keys",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &baseboard_buttons_data,
-	},
+	.id		= PLATFORM_DEVID_NONE,
+	.swnode		= &x3proto_gpio_keys_node,
 };
 
 static struct platform_device *x3proto_devices[] __initdata = {
@@ -211,7 +198,6 @@ static struct platform_device *x3proto_devices[] __initdata = {
 	&smc91x_device,
 	&r8a66597_usb_host_device,
 	&m66592_usb_peripheral_device,
-	&baseboard_buttons_device,
 };
 
 static void __init x3proto_init_irq(void)
@@ -224,7 +210,8 @@ static void __init x3proto_init_irq(void)
 
 static int __init x3proto_devices_setup(void)
 {
-	int ret, i;
+	struct platform_device *pd;
+	int ret;
 
 	/*
 	 * IRLs are only needed for ILSEL mappings, so flip over the INTC
@@ -239,11 +226,11 @@ static int __init x3proto_devices_setup(void)
 	if (unlikely(ret))
 		return ret;
 
-	/*
-	 * Propagate dynamic GPIOs for the baseboard button device.
-	 */
-	for (i = 0; i < ARRAY_SIZE(baseboard_buttons); i++)
-		baseboard_buttons[i].gpio = x3proto_gpio_chip.base + i;
+	ret = software_node_register_node_group(x3proto_swnodes);
+	if (ret) {
+		pr_err("Failed to register software nodes: %d\n", ret);
+		return ret;
+	}
 
 	r8a66597_usb_host_resources[1].start =
 		r8a66597_usb_host_resources[1].end = ilsel_enable(ILSEL_USBH_I);
@@ -254,8 +241,12 @@ static int __init x3proto_devices_setup(void)
 	smc91x_resources[1].start =
 		smc91x_resources[1].end = ilsel_enable(ILSEL_LAN);
 
-	return platform_add_devices(x3proto_devices,
-				    ARRAY_SIZE(x3proto_devices));
+	ret = platform_add_devices(x3proto_devices, ARRAY_SIZE(x3proto_devices));
+	if (ret)
+		return ret;
+
+	pd = platform_device_register_full(&x3proto_gpio_keys_device_info);
+	return PTR_ERR_OR_ZERO(pd);
 }
 device_initcall(x3proto_devices_setup);
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

