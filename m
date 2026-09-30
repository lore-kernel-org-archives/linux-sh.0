Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ECD3921ED
	for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744308; cv=none; b=SaGFMmWh8xAIhWCvvl+pRZCB2s+ydKZnIP69RHFcBE5teCBhowi7Nn6SzRKZq/AicfQHeGXLyFXRj9mXfEZgx/pq7aHbUbkO+adP/EK62nM/VmzC9Q3EzSiYXPB4IoEs2izjlqXgxNw3YidceXoczkdJWdOl4t1HbBrFEHfSuxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744308; c=relaxed/simple;
	bh=3oHARtxQHfsUHREzdKvVWsDAoW0EYwl+gURgFaSF9bQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNIxTVN/KAA1zcqIvJjdJxvE+F41ggLePo3oaWxfkM10+9Uiz+3V8qLIu+SzRBIoX0Pe7mCD1B6KQMQbkcInYH9oAotJTMJ5SVhL7O5l8TVpBTYVkOgI4DRR2dQF52oiMF8NbSPPAkOCVWs3wBq96S05fp/ZKH86fMPf2DEUt3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnK/Nl82; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnK/Nl82"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so6287882eec.0
        for <linux-sh@vger.kernel.org>; Tue, 29 Sep 2026 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744305; x=1791349105; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K09LRjHkHWpGqpW/faBJIv1lkbOZda+wruM3qYt96kg=;
        b=JnK/Nl82iDgbSU9Ouulj//XhroR6kxMr9NMVrmkTouoroMQO1y26GG6vkw72LpePCW
         2TtSQ1esr+ZgNBii5p9pAgl9dqhAvqB/u8zMReLszsi9/1+jtNGxssh82yVAccRKe8HF
         2ryvy/rWjxGvfLaTAF6+mieqt3mW5a14RKOfdHSFlXJlyd8ZdQVmfb9orCs3VyuOp96o
         zLDkuOdTubv2c2Dw81pw2YVekkRmpQuFy1/L3WCBreyfyOQJxS634JEqDiqR5a7qYIMF
         i7c7a+7+2anu+s97g5L2nFC08W/Bk2gSjWq2akeSuUc9yNN6eVI8aPHjfKQaHlr+wMT0
         B2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744305; x=1791349105;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K09LRjHkHWpGqpW/faBJIv1lkbOZda+wruM3qYt96kg=;
        b=OK7Lx250a0vf+bDqfsNU4kO3OufGZMQ8GreNpa4EQqTnxx6xSH5l6GdMKuA4S8rwv6
         CHVHzTCqssJMcvrvenaPn8x877ROE3bf4Gkrs68g/wbBQEWl8uzVODLS/eOT2BVRTYGi
         PrVdDQ+O8vg7U34FwsDeaqiGM77+CgM5nbuPIcCTns4Ohf4csZulPHux4WE9IeODlbvl
         HZe8XaxmzNz/pVqYXB+pSRJEw6Os3l7IIr5r4lYmOt1xS2L2Y3WVujDAk36I89k+E3O/
         XZY6paxFpbZPUcPMXtU84Ns91KNVaFce+Onhv70LrS1xYK1i7C0vpCyf2NTkYcUo79hz
         7ung==
X-Forwarded-Encrypted: i=1; AKwUvByV6+NGv96TZkgFHvviDuu5JOnAgXG8vKZ+SsSm3dGAP3chJ+5cwDZtnaDjgD5X7Jn0dP13oXXgIQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI0Jjx3wrGYhWiTVhUuTCogclv02D6rrnlvCV9sbFX5NUHy0VVy
	DYZcvOtSljmcfHguqO5Pl7Q8xtzlnSX3vTwdbytOWcrld4TJQmQNpcZc
X-Gm-Gg: AYBFou3Aa0bvef9lOCqvHiUoBCT3exByT1ErDh+zQT6UN+6a+QxshX9OCypIauF5Mvu
	ke4WmPQVzEpix/SGAgiQZ90/0qH6zeLKoyKZ2r+dX+Gh5xU2yzMtIBIl314VMBzF9XDcWzLUb8a
	lSrUtWN5MEsXCz2rVgZnjEoLjmh9M5LyzwMp4uYzAsAPcbZdleGjpMjh4T8/yGY6Ved2GBnLxzG
	mywekIOVrAyWJvay5S56qUUuV5UkEl1YDikdbTlMJ9d2UUtCNUnbPqWOfXM1txeoGH/3DKIfotk
	6nFwrxJcapd8EpEiDkpGPvEmJ/nkD8Cr6iGPs1JBpR6Jqjsx3mUI9k92Qb50/LUjcGenaOTc8Ya
	axhwZ4SoQHru2FtNkRK6Io2PDfCdszpyIxWxcuCEQAN/T1RYs//bNshoGzkcAEE1k7tElZhBjCw
	ptRw6RcSYm7eApVn1cCppOhqMHatzbia4Q7alGUE1HL/WFrPaq0xkMKF8FY+QsktnBrv+B3ewql
	K+7qBSzNJ5o909BzIoXQO2+1qZdJXaAvjjEbsqDn7h6BQPNdDnmPpBjde4iuXo=
X-Received: by 2002:a05:693c:20c7:20b0:34c:e77c:f92d with SMTP id 5a478bee46e88-34ce77cfa33mr437435eec.33.1790744305241;
        Tue, 29 Sep 2026 21:58:25 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf514b783sm571056eec.13.2026.09.29.21.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 21:58:24 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 29 Sep 2026 21:58:00 -0700
Subject: [PATCH v3 1/5] pinctrl: renesas: gpio: isolate function gpiochip
 from parent fwnode
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-rsk7203-properties-v3-1-02f84aeb8e47@gmail.com>
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

The sh-pfc driver registers two separate gpiochip instances: one for
real GPIOs and another for function GPIOs. Since both share the same
parent platform device, gpiolib's fallback logic causes both chips to
share the same firmware node (fwnode).

This causes ambiguity when using software nodes to describe GPIOs, as
gpiolib may apply hogs meant for one chip to the other if they share the
same node.

Explicitly set gc->fwnode to ERR_PTR(-ENODEV) for the function GPIO
chip. This satisfies gpiolib's check for an existing fwnode and prevents
it from falling back to the parent device's node, while ensuring that no
actual properties or hogs are found on the function chip unless
explicitly assigned later.

Assisted-by: LLM
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pinctrl/renesas/gpio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pinctrl/renesas/gpio.c b/drivers/pinctrl/renesas/gpio.c
index 2293af642849..4e59dadb7364 100644
--- a/drivers/pinctrl/renesas/gpio.c
+++ b/drivers/pinctrl/renesas/gpio.c
@@ -278,6 +278,12 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)
 
 	gc->request = gpio_function_request;
 
+	/*
+	 * Explicitly mask the parent's fwnode to prevent gpiolib from
+	 * reusing it for function GPIOs.
+	 */
+	gc->fwnode = ERR_PTR(-ENODEV);
+
 	gc->label = pfc->info->name;
 	gc->owner = THIS_MODULE;
 	gc->base = pfc->nr_gpio_pins;

-- 
2.56.0.rc1.315.gc6ed9934b7-goog

