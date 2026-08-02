Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC31B85F8
	for <linux-sh@vger.kernel.org>; Sun,  2 Aug 2026 23:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785712697; cv=none; b=RdrgVZS6El+XzQCxxyZpPS5ZOP22/2y3VzsDVoRuLFigCAR6mnE+7PMd9wWGijhwQXNFq0Ti+83lKfaxRSqIe0l217YElUge0mFMX0yPKDuuEBKJj/VvLgtg5wSfuuo0JgeW4w6CqmmoDNPM1VIEEVbDQnnN/bGGsyTA9tABhDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785712697; c=relaxed/simple;
	bh=7pmYFPQJGehZyH3Ohwso5tOys2BIrXZEwM32dbHJiXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p9Slpn0sxiZBl6Wa3ay1aa1y8sK1L2SPzltpcZov9TOkf47jsCD3SYbeU8Tfx2Ck/QYGYGov1rV8wgc6HvkCXbJl8G0tX473j7pnfXoWvNklc9Iml/u9Z5KMV9DqQDotFu0mKwoO2/uyeUjvPZLiz2KVWNT0TpPttw/yD/+f6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4bndBrN; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4bndBrN"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbb85186d43so1233648a12.3
        for <linux-sh@vger.kernel.org>; Sun, 02 Aug 2026 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785712695; x=1786317495; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7B9tMXa07+CB7JN3Svz3aoAI3DRDGiMMgMEML1gdaCo=;
        b=X4bndBrNp8gd+W78HDPKnX0zCE7754dPux0CORlDtRdkfo3DPdtoF+hf81VJXStmva
         196YbyBWsP7CR8Lc92JFBZJjjUdkE4avWZ/Vw5rfl2AsThuo2L9/Qz7xnsHEl0I3q7Dk
         o9+rhbLDQmdIiteDYQCOYgUXJDbFYYdVBMKC1BGtG36Q2jqa37F4I13p3Ga1LPmjE/GU
         QwT9P8hxpjtPyk2bFB1U5EjK8rwiemV7KYvLdOd72ccU2uY/P+zihIFwWPwlbHWhkxVY
         76p17Wm/dFbe9+09Bd53JA9Qzc1eUTdfbcaPZfbQFboHOBcuvGkmr2vBLKRYoJbELPbk
         8dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785712695; x=1786317495;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7B9tMXa07+CB7JN3Svz3aoAI3DRDGiMMgMEML1gdaCo=;
        b=T0OeOgTEMrXvze1LWt4vXJQf0Rq+92cGc1RBEgQfph/QrcRD4SOAW+Lw71LfoeD1z+
         MyyFmTMvwboSBXrVj1/Jtxj9LoGK2hZeHA3YffoCDRCz74XCTPVBIDaHHbZMYEBbNroW
         geeDhhAkW+SSMosARwAjibmT6oQRMdiAeX1SZ+h/dDDRclmWiI6fYY0ZbwZ9YnQN5gGr
         JKI4gJGEqa4KtG4eWUBS1X1uG58mFdV43vPLFylUPI2rVHAJFhU+bd6gVRabYONzciUT
         4q5lTb6VoKGO4EI3u+1MsN1Ko0pjlJnQzxSrFMV41MxHXlLfseSBc8FE7yu/CdvDhZHk
         rjKg==
X-Gm-Message-State: AOJu0YzvjB96nvgn8gpAKA8s820/WvZe6RilBiMwG0jxI6mHIienc2jf
	qamKk3d5KFL/i1KWyWDBQhQPVrlbx61fAqUsKonJplXZaF4a5CWCSOF5
X-Gm-Gg: AR+sD13l8AKeraJd/Sqg0L4OxtuUYzKanH5yn/HqFiPvUPg5IFlCN7vw58U8+8EVi+t
	vDgYTKTmGalsObMkW8MCatKsU05g+6PF2yWrVqhVusnpDKsrJMpf8Ge15OxD6zlJ8hewoWCTu7/
	bdTHi6hfbFUVDi97lajqFU3ssE+gfeOZBvMMRuk5BFddiURA4hVmBIqEkXKOzNC0af66PbZ3ca6
	t6UKTgXUxy7tRes9as5bsHxBZvOj/P3EZEKyh74z0hMiwNTHo4AGjH1sBOlOZo91u938I8Uklm4
	v0RXO9nlq8eElHyxlqH8V6I6zcoPn+NwF26yWt5GKCQvGwV9fMPrEdiBRlkuIMGbZvPrQpTdRPe
	ytb3Ken5LlthtzmlL04DE5NzO6S1x+GEr5Nrw23fO6wd74ue7xCFA+fJJnFNCmbBnKdVl/bQZFV
	7kDBNMEEOHVCglFjxuz558Mq3dxCa2C47y3Yo57A5K5pqRTjvEbJpNX0iq7vzV+tivvvovhjE4Q
	h0ONDhvSJ2yfiOC/JAnJSof4DJk6TREO7rnkeJ1wkGWmgTL+uVj
X-Received: by 2002:a05:6a20:c79a:b0:3c3:b57b:628f with SMTP id adf61e73a8af0-3c92a89bb61mr8000324637.48.1785712695257;
        Sun, 02 Aug 2026 16:18:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9be04sm28961061eec.9.2026.08.02.16.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:18:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 02 Aug 2026 16:18:01 -0700
Subject: [PATCH] sh: mach-rsk: rsk7203: avoid using inline compound
 literals
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-sh-rsk7203-swnode-props-v1-1-7a790cbac9e6@gmail.com>
X-B4-Tracking: v=1; b=H4sIACjQb2oC/yXMSw7CMAxF0a1UHmMpTSEUtoIYlOZBDVIS2fykq
 nsnwPAM7p3JoAKjfTOT4ikmOVW0q4bGaUgXsMRq8s4H1zvPNrHabetdx/ZKOYKL5mK87sJmQIt
 dHyLVuijO8v6dD8e/7XG6Yrx/d7QsHzNFSKV7AAAA
X-Change-ID: 20260802-sh-rsk7203-swnode-props-4365ae1e986d
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.16-dev-b242f

Using inline compound literals for property entries in software node
initializers causes older compilers (GCC < 14) to fail with "initializer
element is not constant".

Under C11 (6.6/6.7.9), initializers for objects with static storage
duration must be constant expressions. Taking the address of an unnamed
compound literal nested inside an anonymous compound literal array is
not guaranteed by standard C to be a compile-time constant address,
causing older GCC versions to reject it.

Fix this by declaring property entry arrays as named static const
variables, ensuring their symbols evaluate to unambiguous compile-time
address constants.

Fixes: 6905cdac0e51 ("sh: mach-rsk: rsk7203: use static device properties for LEDs and GPIO buttons")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608020345.iCwkQ6oH-lkp@intel.com/
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Fix GCC compilation failure ("initializer element is not constant") on
RSK7203 board by declaring property entry arrays as named static const
variables instead of inline compound literals.
---
 arch/sh/boards/mach-rsk/devices-rsk7203.c | 180 +++++++++++++++++-------------
 1 file changed, 101 insertions(+), 79 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index e8a8fc1d2ca9..7a2e73bb9645 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -42,92 +42,108 @@ static const struct software_node rsk7203_gpio_leds_node = {
 	.name = "rsk7203-gpio-leds",
 };
 
+static const struct property_entry rsk7203_green_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "green"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PE10, GPIO_ACTIVE_LOW),
+	{ }
+};
+
 static const struct software_node rsk7203_green_led_node = {
 	.name = "green",
 	.parent = &rsk7203_gpio_leds_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_STRING("label", "green"),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PE10, GPIO_ACTIVE_LOW),
-		{ }
-	},
+	.properties = rsk7203_green_led_props,
+};
+
+static const struct property_entry rsk7203_orange_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "orange"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "nand-disk"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PE12, GPIO_ACTIVE_LOW),
+	{ }
 };
 
 static const struct software_node rsk7203_orange_led_node = {
 	.name = "orange",
 	.parent = &rsk7203_gpio_leds_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_STRING("label", "orange"),
-		PROPERTY_ENTRY_STRING("linux,default-trigger", "nand-disk"),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PE12, GPIO_ACTIVE_LOW),
-		{ }
-	},
+	.properties = rsk7203_orange_led_props,
+};
+
+static const struct property_entry rsk7203_red1_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "red:timer"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "timer"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PC14, GPIO_ACTIVE_LOW),
+	{ }
 };
 
 static const struct software_node rsk7203_red1_led_node = {
 	.name = "red:timer",
 	.parent = &rsk7203_gpio_leds_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_STRING("label", "red:timer"),
-		PROPERTY_ENTRY_STRING("linux,default-trigger", "timer"),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PC14, GPIO_ACTIVE_LOW),
-		{ }
-	},
+	.properties = rsk7203_red1_led_props,
+};
+
+static const struct property_entry rsk7203_red2_led_props[] = {
+	PROPERTY_ENTRY_STRING("label", "red:heartbeat"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "heartbeat"),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PE11, GPIO_ACTIVE_LOW),
+	{ }
 };
 
 static const struct software_node rsk7203_red2_led_node = {
 	.name = "red:heartbeat",
 	.parent = &rsk7203_gpio_leds_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_STRING("label", "red:heartbeat"),
-		PROPERTY_ENTRY_STRING("linux,default-trigger", "heartbeat"),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PE11, GPIO_ACTIVE_LOW),
-		{ }
-	},
+	.properties = rsk7203_red2_led_props,
+};
+
+static const struct property_entry rsk7203_gpio_keys_props[] = {
+	PROPERTY_ENTRY_U32("poll-interval", 50),
+	{ }
 };
 
 static const struct software_node rsk7203_gpio_keys_node = {
 	.name = "rsk7203-gpio-keys",
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_U32("poll-interval", 50),
-		{ }
-	},
+	.properties = rsk7203_gpio_keys_props,
+};
+
+static const struct property_entry rsk7203_sw1_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_0),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PB0, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW1"),
+	{ }
 };
 
 static const struct software_node rsk7203_sw1_key_node = {
 	.parent = &rsk7203_gpio_keys_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_U32("linux,code", BTN_0),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PB0, GPIO_ACTIVE_LOW),
-		PROPERTY_ENTRY_STRING("label", "SW1"),
-		{ }
-	},
+	.properties = rsk7203_sw1_key_props,
+};
+
+static const struct property_entry rsk7203_sw2_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_1),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PB1, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW2"),
+	{ }
 };
 
 static const struct software_node rsk7203_sw2_key_node = {
 	.parent = &rsk7203_gpio_keys_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_U32("linux,code", BTN_1),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PB1, GPIO_ACTIVE_LOW),
-		PROPERTY_ENTRY_STRING("label", "SW2"),
-		{ }
-	},
+	.properties = rsk7203_sw2_key_props,
+};
+
+static const struct property_entry rsk7203_sw3_key_props[] = {
+	PROPERTY_ENTRY_U32("linux,code", BTN_2),
+	PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
+			    GPIO_PB2, GPIO_ACTIVE_LOW),
+	PROPERTY_ENTRY_STRING("label", "SW3"),
+	{ }
 };
 
 static const struct software_node rsk7203_sw3_key_node = {
 	.parent = &rsk7203_gpio_keys_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_U32("linux,code", BTN_2),
-		PROPERTY_ENTRY_GPIO("gpios", &pfc_gpiochip_node,
-				    GPIO_PB2, GPIO_ACTIVE_LOW),
-		PROPERTY_ENTRY_STRING("label", "SW3"),
-		{ }
-	},
+	.properties = rsk7203_sw3_key_props,
 };
 
 /* The base of the function GPIOs in the flat enum */
@@ -138,46 +154,52 @@ static const struct software_node rsk7203_pfc_functions_node = {
 	.parent = &pfc_gpiochip_node,
 };
 
+static const struct property_entry rsk7203_txd0_hog_props[] = {
+	PROPERTY_ENTRY_BOOL("gpio-hog"),
+	PROPERTY_ENTRY_U32_ARRAY("gpios", ((u32[]){
+		GPIO_FN_TXD0 - SH7203_FN_BASE, GPIO_ACTIVE_HIGH
+	})),
+	PROPERTY_ENTRY_BOOL("input"),
+	PROPERTY_ENTRY_STRING("line-name", "TXD0"),
+	{ }
+};
+
 static const struct software_node rsk7203_txd0_hog_node = {
 	.name = "txd0-hog",
 	.parent = &rsk7203_pfc_functions_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_BOOL("gpio-hog"),
-		PROPERTY_ENTRY_U32_ARRAY("gpios", ((u32[]){
-			GPIO_FN_TXD0 - SH7203_FN_BASE, GPIO_ACTIVE_HIGH
-		})),
-		PROPERTY_ENTRY_BOOL("input"),
-		PROPERTY_ENTRY_STRING("line-name", "TXD0"),
-		{ }
-	},
+	.properties = rsk7203_txd0_hog_props,
+};
+
+static const struct property_entry rsk7203_rxd0_hog_props[] = {
+	PROPERTY_ENTRY_BOOL("gpio-hog"),
+	PROPERTY_ENTRY_U32_ARRAY("gpios", ((u32[]){
+		GPIO_FN_RXD0 - SH7203_FN_BASE, GPIO_ACTIVE_HIGH
+	})),
+	PROPERTY_ENTRY_BOOL("input"),
+	PROPERTY_ENTRY_STRING("line-name", "RXD0"),
+	{ }
 };
 
 static const struct software_node rsk7203_rxd0_hog_node = {
 	.name = "rxd0-hog",
 	.parent = &rsk7203_pfc_functions_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_BOOL("gpio-hog"),
-		PROPERTY_ENTRY_U32_ARRAY("gpios", ((u32[]){
-			GPIO_FN_RXD0 - SH7203_FN_BASE, GPIO_ACTIVE_HIGH
-		})),
-		PROPERTY_ENTRY_BOOL("input"),
-		PROPERTY_ENTRY_STRING("line-name", "RXD0"),
-		{ }
-	},
+	.properties = rsk7203_rxd0_hog_props,
+};
+
+static const struct property_entry rsk7203_irq0_hog_props[] = {
+	PROPERTY_ENTRY_BOOL("gpio-hog"),
+	PROPERTY_ENTRY_U32_ARRAY("gpios", ((u32[]){
+		GPIO_FN_IRQ0_PB - SH7203_FN_BASE, GPIO_ACTIVE_HIGH
+	})),
+	PROPERTY_ENTRY_BOOL("input"),
+	PROPERTY_ENTRY_STRING("line-name", "IRQ0_PB"),
+	{ }
 };
 
 static const struct software_node rsk7203_irq0_hog_node = {
 	.name = "irq0-hog",
 	.parent = &rsk7203_pfc_functions_node,
-	.properties = (const struct property_entry[]) {
-		PROPERTY_ENTRY_BOOL("gpio-hog"),
-		PROPERTY_ENTRY_U32_ARRAY("gpios", ((u32[]){
-			GPIO_FN_IRQ0_PB - SH7203_FN_BASE, GPIO_ACTIVE_HIGH
-		})),
-		PROPERTY_ENTRY_BOOL("input"),
-		PROPERTY_ENTRY_STRING("line-name", "IRQ0_PB"),
-		{ }
-	},
+	.properties = rsk7203_irq0_hog_props,
 };
 
 static const struct software_node * const rsk7203_swnodes[] __initconst = {

---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260802-sh-rsk7203-swnode-props-4365ae1e986d

Thanks.

-- 
Dmitry

