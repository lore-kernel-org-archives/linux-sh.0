Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71E35CBCB
	for <linux-sh@vger.kernel.org>; Mon, 13 Jul 2026 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978897; cv=none; b=kN9UmlF21BJus75cfVW/OqXu0uCK1u7U62RQJdUHgB4FB4Gss3Y/P5ItHzr1aaa+8+Jpdm82FFgr2PtIx2Cfzs+yoAIE9w+MF81x8lOrKRAqOsO5XIx6j+N2O6aUdxmrLx7alA43hGKTmW5x+jomeH3Mv14M8K7aSkwTkgf+jEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978897; c=relaxed/simple;
	bh=W+EwZnLFKVj1h1rZe5PgiDii2PS5+D3kv689Az0HHns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HJplkz2Qrq0CXTlBnAUdn+DUMAzBypou1kxr6t7ECPkAkIFiqV2S/caNJajJx6Elf0NMtrOdO9Jm0bdfLLMtR5cEbtnrm2z+aBUQByIbf7/2rntapw6B0Sdcivp2RRJzKzpNG+RR7BddBJqOIl79tHH4xZpsMF3pWdFXhquLqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxhAkBTg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxhAkBTg"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9aea40d799so138322a12.0
        for <linux-sh@vger.kernel.org>; Mon, 13 Jul 2026 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783978895; x=1784583695; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v+T9ncXsQofNw87dQE5f2mF+cWycslyRRbsUPole34o=;
        b=bxhAkBTgM1Mx7Bf736Hc1nC1egZvJeLXvKmQMFLJo+3SPFTYwFf/VaJt8XH0OYTyM+
         +JfmQxiBQQzmHXTkrAw6f1kXNMTG8/eJkZCKcs2pBgMxnPUFbEGtESTM3i/R+mff8zhV
         zxSy2gBju6ZGkobXHvJD11Q8MRW6TgAvRzFMDEKx/A4/Xl1e2WqZb/yKG6/t1YOA+GsK
         ZjK84TSR7RS1gKf69dqNJqIr+E5lD+Nkm3MGF+8jqAcph1PbWMeOtrPC7wREaMJgy01n
         o/CpfbtM0Q9pKQ3pwzJ+uItyiWGWoor6VdKhN4XCErlqVtz2JVOjiPPcoxtLwij8xcaj
         0jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978895; x=1784583695;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+T9ncXsQofNw87dQE5f2mF+cWycslyRRbsUPole34o=;
        b=neS19fdcz003CBk2LOaYAV9era+xDo8jgRKBVsHNpOBmEourObzCzmEVCV13lSMcq1
         lT1Wch7Dg9VF83CL+N1zno3lF/SJshiCRNzihheQyGwFnkbBntgXZvr9+pxpzUZhHwVi
         ZSn20HJBjTIfPjpsgabuP/aAfEeBGqPv1En7hfr2oK3L3sZkdKZoER3k8bS4LwgEhnEn
         zRGYtZCleLQedr3dDDH4EZx/BpxaMffMdNpm8cOMf/2ka94TvGYNw5QOFm6oi7py+iv0
         JBjEEZdE0mcxeHlnuuc+pZL37oDSircPT9Z07rQHZ8ppBMRy4roMgzaXIzJ80B/cruOX
         UXTQ==
X-Forwarded-Encrypted: i=1; AHgh+RrorvqU8LYlYqERv4D+mnh1aRfl4kFX7XCywOmHTLksKrwVHJf9RtxgTB2NdbwDJxl6RZbvsKvhZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjhLQxtfZZEkMHPRRjQDj3atgHi52ZWjWa/F4q+jLBORz3s4g
	62pxXOVZoKi6GO0OzEjsIxQc2UiMcIBO9Cx5J1cm5RTifEGOnALALUJs
X-Gm-Gg: AfdE7cmNDWWZ5eRsKNnGGCqtPQXwZGbsk1GeJHsUQ1InWW8eb6RI5rQo5b9hj8wug1u
	LQEvkVlYvqCviUsYQO9VUZKMM5kYwStM3wPZgWjwRw+SpfADsOVdzfevj58Wa/tbQ04FGYdrym3
	T4XLGYy18w43iSgKCtP5/SYTzCLEPEj9+vkkLzL51sDKqiQYH0mWEV2zqkDoS9MI0BowL/Y1B5Z
	wcpyMfjSBolUrUeICnhh9TqUbIgguUAaXy6NiOKCM0BSSaRYP2sHkP3iNhDcM7Ynq8BVFL2FSWr
	uWgan4Tgiaw9cS0AmZcv48qg4OPNncWcNf2u+3yhYhTiOe6sbljl9PStl9yOSVNsg3X1yMh/fxO
	+FGiX8yiXn4HDmMbrcz1y2GAohgcF/UwninrL3tmfa+IYX0YQAJeTqw/ti/DQqJmHvwi6c18/nK
	b1FinuYfpFGhZVcfNasc5SmOCZCZYczg+dpyggSnFD10jb8CurIkil1Ea86X/eBj4Y
X-Received: by 2002:a05:6a20:431b:b0:3a3:327:c5c8 with SMTP id adf61e73a8af0-3c10fc4dac7mr11212239637.0.1783978895328;
        Mon, 13 Jul 2026 14:41:35 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e15f:5d5f:580b:f2e9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm62379929eec.20.2026.07.13.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:41:34 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:41:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Mark Brown <broonie@kernel.org>, jacopo mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [RESEND PATCH] sh: ecovec24: use static device properties to
 describe the touchscreen
Message-ID: <alUyZ2zVWCPhyHHX@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the board to use static device properties instead of platform
data to describe the touchscreen, so that support for platform data can
be removed from tsc2007 driver (ecovec24 is the last board using this
mechanism of describing tsc2007).

Device properties do not allow custom board methods, so the method for
getting "pen down" state was removed (the driver is capable of working
without it). If this functionality is needed proper pin control/gpio
support needs to be implemented so that the same pin can serve as an
input GPIO and an interrupt.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This is a resend of the patch I sent in August of 2024. My fault of not
noticing reply from Adrian inquiring about potential negative impact
from not having GPIO-based "pen down" detection. I believe this is fine,
the "pen down" is an optional feature and the driver can detect the
touches even when it is not specified. Additionally, this is an
evaluation board, so user impact should be negligible.

However the bigger question is whether ecovec24 board still relevant.
According to my research it has the following regressions currently
unfixed:

5716fb9bd9c6 ("mmc: spi: Convert to use GPIO descriptors")
  - MMC SPI device naming broken (broke SD fallback mode)

9fda6693335c ("spi: sh-msiof: Convert to use GPIO descriptors")
  - SPI CS polarity inverted (broke initialization on the MSIOF0 SPI bus)

c2f9b05fd5c1 ("media: arch: sh: ecovec: Use new renesas-ceu camera driver")
  - Camera array sentinel missing (causes out-of-bounds reads and
    potentially kernel panics)
  - Camera standby polarity inverted (enadvertently keeps cameras
    permanently powered off)
  - Camera disabled iby default (board defconfig points to a deleted
    driver)

They are ~6 years old, so I wonder: do people actually *actively* use
this board with modern kernels? Should it simply be removed?

Thanks!

 arch/sh/boards/mach-ecovec24/setup.c | 38 ++++++++--------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a641e26f8fdf..110a77f903b5 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -26,6 +26,7 @@
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_data/tsc2007.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -589,39 +590,21 @@ static struct platform_device keysc_device = {
 /* TouchScreen */
 #define IRQ0 evt2irq(0x600)
 
-static int ts_get_pendown_state(struct device *dev)
-{
-	int val = 0;
-	gpio_free(GPIO_FN_INTC_IRQ0);
-	gpio_request(GPIO_PTZ0, NULL);
-	gpio_direction_input(GPIO_PTZ0);
-
-	val = gpio_get_value(GPIO_PTZ0);
-
-	gpio_free(GPIO_PTZ0);
-	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
-
-	return val ? 0 : 1;
-}
-
-static int ts_init(void)
-{
-	gpio_request(GPIO_FN_INTC_IRQ0, NULL);
-	return 0;
-}
+static const struct property_entry tsc2007_properties[] = {
+	PROPERTY_ENTRY_U32("ti,x-plate-ohms", 180),
+	{ }
+};
 
-static struct tsc2007_platform_data tsc2007_info = {
-	.model			= 2007,
-	.x_plate_ohms		= 180,
-	.get_pendown_state	= ts_get_pendown_state,
-	.init_platform_hw	= ts_init,
+static const struct software_node tsc2007_swnode = {
+	.name = "tsc2007",
+	.properties = tsc2007_properties,
 };
 
 static struct i2c_board_info ts_i2c_clients = {
 	I2C_BOARD_INFO("tsc2007", 0x48),
 	.type		= "tsc2007",
-	.platform_data	= &tsc2007_info,
 	.irq		= IRQ0,
+	.swnode		= &tsc2007_swnode,
 };
 
 static struct regulator_consumer_supply cn12_power_consumers[] =
@@ -1242,8 +1225,9 @@ static int __init arch_setup(void)
 		gpio_direction_output(GPIO_PTF4, 1);
 
 		/* enable TouchScreen */
-		i2c_register_board_info(0, &ts_i2c_clients, 1);
+		gpio_request(GPIO_FN_INTC_IRQ0, NULL);
 		irq_set_irq_type(IRQ0, IRQ_TYPE_LEVEL_LOW);
+		i2c_register_board_info(0, &ts_i2c_clients, 1);
 	}
 
 	/* enable CEU0 */
-- 
2.55.0.795.g602f6c329a-goog


-- 
Dmitry
