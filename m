Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8A3AD520
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 04:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744315; cv=none; b=mo1vsMbEVdQg7bDxi5aQWRCxeF48dl38/Pv1uhn3sx+NU70OizSfOgDioQk/PeHJ9UC28uofw3HYRhCroc8E+5kSriSx5OXIrz+8tDK/+VhBjj6ph7MmdUSjHF4SeGMYlcEu5kkzNBQRV+2ja3br7UJoUhA0b79cB+lEH44Mfn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744315; c=relaxed/simple;
	bh=+HmdXT+V3VdY88H938k8OL6ZMd616XicDgHEPfMX+Q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTi9KbLlEayuFKdPQO9uuv2B++HpPOd1MOB3qAepAVyCzsfqLyHvbw9/i1zRdTmRmfqGYIrTS/At5Q1NQmGD87scDhGxCQ46hsxPBMzYTxQsT3mmk/nfQ00PByJS4SKJjeZOaI4F8pY7qyBrkX62xJG+QfrD9oKIonVe43CsXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3YLLdGi; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3YLLdGi"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso562354eec.3
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 21:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744313; x=1791349113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ysdOOT1TGhwXZTAjDpt4u3/w8hbcaqTakzQVsdcz7JA=;
        b=g3YLLdGieqGarTwF2iFwDfNweU7bK6oyKVvmbFc51tQbXMh4253LelpyVJK2gRejqJ
         9zs/jmOwR6hb+Bko9vVp+E3FJ5kqzV1lDE/BKN2c0EXfElxJAX0uKk/iqP29KV54QRVu
         M+aLmdKCA5wFSy4arT5JZRBuPlUnzMegiWwViVjBp3Rz6yX5thSdbnem2hbHynD9y7Hz
         Zaf5NTsSuSN9Gwo5P+LwyVsTPRDThalx8EXR4KcBT4qM6SELRZkJTnuszfrn/8ph0KJl
         r9+XS4bl95dr2vMqXcmcPtpsavrjv2WaZa8L1Z0t3OYILqp3EU3cZVWIxEHZoLsPnpXL
         AIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744313; x=1791349113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ysdOOT1TGhwXZTAjDpt4u3/w8hbcaqTakzQVsdcz7JA=;
        b=eFXsPtRBE3Lsho1qncWI5NHDIm7IEpmbpyxuPqgn5bjcBeNDK1pb1tuRoNrPNcCEUb
         qdvdejMCaIWsF/aQmc1YxkEJ0aK3eaHg4vdclFWQVurY7WvSXwQ6NJh8Eb+KfG5T2ahk
         cHkNWHwC4V+JfFToeakuZtiCgQ4L+422IahgVOaAWoT3LPnOr7z6S1O0h64uAFauyqSA
         SZldAJBRcnSFcJDfW2RM03xUFYqY+a07MX0MPHGnRbTmVseurYSeVbse2g3PfPAiXK9b
         C19KMhY/ukTWIt5FksIRNNTXWntd7+8qjj7aBjKZqv0/BsNmJieArTUklfqv5FkMCZC1
         QoWA==
X-Forwarded-Encrypted: i=1; AKwUvBwasR2Qu/17Z0gCsFQ5a1EuEyMtEJNwxOZjVIy7rigLgScKcZRIKFhLsrBEKI25ZGZz+vBebnLSxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJDU4qtnD6zz7Z5M8PFicJuVErBtXGIduQmuBDh+WrxehHI7xa7
	OP5NjzibWJf8sIxW6A9yrD8t7zgLL/QssNPDirsbAFPN1ZJx4XTHj8T9
X-Gm-Gg: AYBFou24RQPghrlvPE56ymnGUPjZtMVs5l55ambQgazOvkn8IkiOu2Qdk4AmPFCGPua
	dX1VpRgR1/g2zuf+1HYeWYZiOwpzbhegCIYcbFaPAfcCWXNF3qoyruMFOCFyRKSRCjNiID2udmH
	V8neDzPaZ2r2onEbRfH2TCKs2DfCKdhccVTHp4pHG+eiIyqPY4Gkrp0u/ndGh1+AY6v/nBCmzmz
	GrzIf5eosrawT0hyof8w9PYjw+hYwjEA61UW7izseusTRG5W2hPGD/92HXKHNDNWB7yzWY5gaM8
	tN+9rvCIo0dmGiD2+FaQDwDPARaTQ7K/scMvNeNbx3gewz3P50ABeX7bQ4Da6dagxx1LjPpJLZ3
	Wealk0wtAD9mEKvzMo2UGs/7JMY2IXY5F4ExQkpjuTA2JmZaBRCTjHSn+MD/BNza6jOpipymyCL
	8uY5w/SaLRLlGQrX4u3Wggs+HmMhwtJ9i4C8Md+AqCEi0fYv53gJ+OGzIINTh2NxNvSieQQ0nY4
	c4c+6W2valKI3OU2MdsHVW+g7TcFsr60iszDB6TVnO609ZLDx//Db+Fu3b+HJyPUgMHnq+W4A==
X-Received: by 2002:a05:7300:50d7:b0:339:7572:7b2b with SMTP id 5a478bee46e88-34cdc6c414cmr557932eec.24.1790744313325;
        Tue, 29 Sep 2026 21:58:33 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf514b783sm571056eec.13.2026.09.29.21.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:58:32 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 29 Sep 2026 21:58:04 -0700
Subject: [PATCH v3 5/5] sh: mach-rsk: rsk7203: convert pin configuration to
 using software nodes
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rsk7203-properties-v3-5-02f84aeb8e47@gmail.com>
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

Replace legacy gpio_request() calls used to configure function pins
(SCIF0 TXD/RXD and LAN9118 IRQ) with software nodes describing GPIO
hogs. These hogs are attached to the PFC gpiochip node, allowing the
GPIO subsystem to automatically configure these pins when the driver is
registered.

Assisted-by: LLM
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-rsk/devices-rsk7203.c | 103 ++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 12 deletions(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index 8076c9d15f87..7a2e73bb9645 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -12,7 +12,6 @@
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/gpio/property.h>
 #include <asm/machvec.h>
@@ -147,6 +146,62 @@ static const struct software_node rsk7203_sw3_key_node = {
 	.properties = rsk7203_sw3_key_props,
 };
 
+/* The base of the function GPIOs in the flat enum */
+#define SH7203_FN_BASE GPIO_FN_PINT7_PB
+
+static const struct software_node rsk7203_pfc_functions_node = {
+	.name = "functions",
+	.parent = &pfc_gpiochip_node,
+};
+
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
+static const struct software_node rsk7203_txd0_hog_node = {
+	.name = "txd0-hog",
+	.parent = &rsk7203_pfc_functions_node,
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
+};
+
+static const struct software_node rsk7203_rxd0_hog_node = {
+	.name = "rxd0-hog",
+	.parent = &rsk7203_pfc_functions_node,
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
+};
+
+static const struct software_node rsk7203_irq0_hog_node = {
+	.name = "irq0-hog",
+	.parent = &rsk7203_pfc_functions_node,
+	.properties = rsk7203_irq0_hog_props,
+};
+
 static const struct software_node * const rsk7203_swnodes[] __initconst = {
 	&rsk7203_gpio_leds_node,
 	&rsk7203_green_led_node,
@@ -157,6 +212,10 @@ static const struct software_node * const rsk7203_swnodes[] __initconst = {
 	&rsk7203_sw1_key_node,
 	&rsk7203_sw2_key_node,
 	&rsk7203_sw3_key_node,
+	&rsk7203_pfc_functions_node,
+	&rsk7203_txd0_hog_node,
+	&rsk7203_rxd0_hog_node,
+	&rsk7203_irq0_hog_node,
 	NULL
 };
 
@@ -181,26 +240,46 @@ static const struct platform_device_info rsk7203_devices[] __initconst = {
 	},
 };
 
-static int __init rsk7203_devices_setup(void)
+/*
+ * The pfc-sh7203 device is registered at arch_initcall level, and the
+ * sh-pfc driver (registered at postcore_initcall level) probes as soon
+ * as the device is created.
+ *
+ * We need to register our software nodes at postcore_initcall level so
+ * they are already present in the system when the driver probes and
+ * tries to apply GPIO hogs.
+ */
+static int __init rsk7203_sw_nodes_setup(void)
 {
-	struct platform_device *pd;
 	int error;
-	int i;
 
-	/* Select pins for SCIF0 */
-	gpio_request(GPIO_FN_TXD0, NULL);
-	gpio_request(GPIO_FN_RXD0, NULL);
-
-	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
-	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
-	gpio_request(GPIO_FN_IRQ0_PB, NULL);
+	error = software_node_register(&pfc_gpiochip_node);
+	if (error && error != -EEXIST) {
+		pr_err("RSK7203: failed to register PFC software node: %d\n",
+		       error);
+		return error;
+	}
 
 	error = software_node_register_node_group(rsk7203_swnodes);
 	if (error) {
-		pr_err("failed to register software nodes: %d\n", error);
+		pr_err("RSK7203: failed to register board software nodes: %d\n",
+		       error);
 		return error;
 	}
 
+	return 0;
+}
+postcore_initcall(rsk7203_sw_nodes_setup);
+
+static int __init rsk7203_devices_setup(void)
+{
+	struct platform_device *pd;
+	int error;
+	int i;
+
+	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
+	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
+
 	for (i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
 		pd = platform_device_register_full(&rsk7203_devices[i]);
 		error = PTR_ERR_OR_ZERO(pd);

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

