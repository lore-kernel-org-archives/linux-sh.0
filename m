Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3113D539
	for <linux-sh@vger.kernel.org>; Sun,  5 Jul 2026 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783227889; cv=none; b=YScNX8ykJkOQ+KN5JD2hODC5QU+IN/6VEKjXFSZl5K6MggfuSDzsWMrkv6umH8b8Gi123xFAr+WyaoY2v8rwhL36CQJl/w1tCR5LlKP4CCutdJuYdpd/pQIcRPAvf5ySTnXelnuPkywOoIVxwiagErmcL1rb6x0MnKit4noJbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783227889; c=relaxed/simple;
	bh=g2IcKpyrWKW2kwgfDe4vrcXDqRs97rHlKyippcALm3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5l9uGQ3yrOViXPPz7rtr/rl4FFsQXAKwzGDlP3q8cUN0k5rjK1FGzpLglvUq5CNmKX9vpcI7rK3tKJ59kerUQVby3ru6AZ1LAc9aBcHhIpUa8fFGrelSdcHR6UXDAUghGLADk2ygBpJ8hL3K0aTNX/dBeUt2XKndP1364F7juc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzAu+iTV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzAu+iTV"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-846970f0acaso1766801b3a.3
        for <linux-sh@vger.kernel.org>; Sat, 04 Jul 2026 22:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783227886; x=1783832686; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3HuwUbG+Mn1Fyekwox0FnTgEFt3jewOA0gc/xR54aY=;
        b=fzAu+iTV2EYMYmFOM9VpUY5l/aokrxpc0k4iihBBae4o/j1yhhwvTCpXK+0tOPgA0b
         /oUelux/4q8DJeKUK8z6tWqNHJAd4xpCjQQdXNM+rBXhXm8OkUUGd3d0EkgSUf4tWuIL
         c+Xq5Viez+kD0CWA713GlZyTQV3DyrFUGs9MNzoXjRc4HcCpQN8MhQmZwJZVzjcDNYFm
         gcT1Oq6jsT9habQdeMpFMG19r/VLW4YrctI0PyE5hSna5NAonJLJmnKUvghQu/B5kHAc
         dz3lMnFCmCXBUp48YbaBrmiCetlbxelIdTqWa3HJ3EiLiclQJZtJCLIisytmt40PxlEq
         wEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783227886; x=1783832686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3HuwUbG+Mn1Fyekwox0FnTgEFt3jewOA0gc/xR54aY=;
        b=JMJksW9xqXXF/x38R88aHJXA1uAdPW2TbG/dUoUsAny21ZVgNPiMJYHDqOj+uRF/jp
         v991VmAu4CQakiiamN+mGK6T6t8Rye88B1sx+yOxhMm6AFrKlKclLvipui2b/YaYpOgQ
         AJJXJ5UNnoJF+HsRCDW/1q/UHTspaaqWlnAu02vZuZLzRIm103Rd/8PGjOYQokIRvMNC
         FLCZxGrLgh+XgF4fG9y2o305qQ8cU81/+CSDtAPHGMzqup0KriDCi2vPBw2tQSe3r0Xw
         i+zKKPRn7zkmOmYNKMUP8ZEHuHQlDpd21l1AkVJ7b93cLf2dshbyB8IksiByJzmjypaf
         FpOQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Jki3EXQidgXBTqC+/h7PG6qyjcBg8SDNkbiGy8QkiJwpQhbiQESnXyONc3ASdSKuDkEFLq24hRw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY4TU0JjShQlUcPoiFB5GNnmB+VDdwZn47OzC2p+9Zk/ZF8wZY
	+J7p/EN5dabsqdmfg+c17pvP5FhxPLpaz9j/Hnb/LgJ69S3HcAAbVTZf
X-Gm-Gg: AfdE7ckwVdikYHEOyieDqQRTOckRHm+Cln4maK4vf12GpXGvl7kE5WjZjXQATwyhF7v
	qvNXvjZ4ygJg7zM2M4j+2OgnOxHM5zybihElIMz21462xaJN+WYUJLZctgWcwkOaM4vPLrF9EGp
	X2LNW6Dj9yIOUsK6u4Y8XkKuoKHx19BrA+00V+NVTYZDiK52QniaiX1pSRUCrFspQJWT4S7T9Mx
	2iH+Nc5TyphjUrYLRGnEJy04euDAXfFBIv1vOvnlH/nWhx4FF3ZZZ+cGDG93BEHO4Zq2+e+jjkN
	bVBQ/6Vr6S2fBEsuxsjuw+vIEkpNspo9eDlobS/UIklnzEhsbUltvWsh9pqaXaO5aeKJhxI1BYN
	3SfIG3nDWeeVQprWCtpRrmTFBre1WSrMH3mzYJjLKKoDoEmIJeuzWFrFGjZ5I4rv/QgdObkKWLt
	31OfRtDhsubAmctfIcYLDd0CWonyqggDGIbyaT/RcGfSPO30W4tkXRZPzcHvKRIeURZBY3nlrdS
	cbO
X-Received: by 2002:a05:6300:4c:b0:3bd:3a53:c147 with SMTP id adf61e73a8af0-3c03e503125mr5654778637.45.1783227886092;
        Sat, 04 Jul 2026 22:04:46 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:4560:aa1b:b33a:15b8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3b252222sm19585414eec.23.2026.07.04.22.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 22:04:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 04 Jul 2026 22:04:37 -0700
Subject: [PATCH 1/2] sh: mach-x3proto: add software node for GPIO
 controller
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-sh-x3proto-swnode-v1-1-0c039549dc46@gmail.com>
References: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
In-Reply-To: <20260704-sh-x3proto-swnode-v1-0-0c039549dc46@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

We want to convert the legacy gpio-keys platform device on the SH-X3
Prototype board to use software nodes. To do this properly and allow
referencing the GPIO controller by address rather than relying on
name-based matching (which is being removed from the gpiolib core),
we need to associate the GPIO controller with a software node.

Introduce x3proto_gpiochip_node, register it, and associate it with
x3proto_gpio_chip.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/boards/mach-x3proto/gpio.c           | 15 ++++++++++++++-
 arch/sh/include/mach-x3proto/mach/hardware.h |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3proto/gpio.c
index c13d51b29702..a09cafc782b4 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <mach/ilsel.h>
 #include <mach/hardware.h>
+#include <linux/property.h>
 
 #define KEYCTLR	0xb81c0000
 #define KEYOUTR	0xb81c0002
@@ -73,6 +74,10 @@ static void x3proto_gpio_irq_handler(struct irq_desc *desc)
 	chip->irq_unmask(data);
 }
 
+const struct software_node x3proto_gpiochip_node = {
+	.name = "x3proto-gpio",
+};
+
 struct gpio_chip x3proto_gpio_chip = {
 	.label			= "x3proto-gpio",
 	.direction_input	= x3proto_gpio_direction_input,
@@ -104,9 +109,15 @@ int __init x3proto_gpio_setup(void)
 	if (unlikely(ilsel < 0))
 		return ilsel;
 
+	ret = software_node_register(&x3proto_gpiochip_node);
+	if (ret)
+		goto err_gpio;
+
+	x3proto_gpio_chip.fwnode = software_node_fwnode(&x3proto_gpiochip_node);
+
 	ret = gpiochip_add_data(&x3proto_gpio_chip, NULL);
 	if (unlikely(ret))
-		goto err_gpio;
+		goto err_swnode;
 
 	x3proto_irq_domain = irq_domain_create_linear(NULL, NR_BASEBOARD_GPIOS,
 						   &x3proto_gpio_irq_ops, NULL);
@@ -127,6 +138,8 @@ int __init x3proto_gpio_setup(void)
 err_irq:
 	gpiochip_remove(&x3proto_gpio_chip);
 	ret = 0;
+err_swnode:
+	software_node_unregister(&x3proto_gpiochip_node);
 err_gpio:
 	synchronize_irq(ilsel);
 
diff --git a/arch/sh/include/mach-x3proto/mach/hardware.h b/arch/sh/include/mach-x3proto/mach/hardware.h
index 57ea4a5cca35..1ee5a404973c 100644
--- a/arch/sh/include/mach-x3proto/mach/hardware.h
+++ b/arch/sh/include/mach-x3proto/mach/hardware.h
@@ -3,10 +3,12 @@
 #define __MACH_X3PROTO_HARDWARE_H
 
 struct gpio_chip;
+struct software_node;
 
 /* arch/sh/boards/mach-x3proto/gpio.c */
 int x3proto_gpio_setup(void);
 extern struct gpio_chip x3proto_gpio_chip;
+extern const struct software_node x3proto_gpiochip_node;
 
 #define NR_BASEBOARD_GPIOS	16
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

