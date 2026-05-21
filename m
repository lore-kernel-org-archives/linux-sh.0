Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0935201E
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 05:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779340425; cv=none; b=fYGcdKas7c5/h+PmSr+h8gxmizw16tRi4n77mZ/5/Grcju2cRMDrTrErFwfBwx5WIIs8OzuzxVz7sFtCfUB1fcNLB2H8Z1XWs5KrRWs3pR4kiZS81JZsLWdTzj7kTKuzAVXP6wMAsVOGrvlt3yy28seP0Dmi4R4i6mv4c+LXv4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779340425; c=relaxed/simple;
	bh=an2XKnw/6oNRYjivHk/fQLnrkcFYlk+CGyiYpwsGnhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RlhSW8yYjlx2uoqqM8p+R+mhAJhm4Fnglf3BCdoHMjA9XlHy9P9FMf3J4v/u6WlUrqXgkREQmoT8pjKRC2+9hO5bzhdsyntfNeD/HLVsnXkmtiVO/VlJta9nCWsdjKlPUpCjPnxwy1rGS11JfSHG5V5WpvFl3oodn8Vpl8fQYbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KezolyL+; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KezolyL+"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-135e88b8e55so5933616c88.0
        for <linux-sh@vger.kernel.org>; Wed, 20 May 2026 22:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779340423; x=1779945223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXtisoK8i0cyvAoaHE4OQcmxs5XHz2jUEn0crM4CfGY=;
        b=KezolyL+vcKcS0eaIMl9nVTayU0vlKDWYQzWJSUqrlkQYefXHEWVu6Az4W+gq2njSz
         E+mK3BZA9DLp+bpJg+AbWc7o82rCzuIkoNrj3RtaMm0Yp753kn0XJ3DFsdVTj8Hw+e7z
         n4Vd8T7kZC89snFgCjMtiNrnk644CM1gf7WWPI4yvs+VVkNiF3t/biR7Rbozw0EaHNfz
         Ge7aWvxCiViZLkKOafU5ZZHLWfuGIuqsVvFuDdMN6oCYo8QMPRoeJCPlzr+FvRRyahEp
         lBEKI5YoUyncn3q+QE0h9NeVdtCIQy7NkimmBT6lK3KzN/9H0jBYqZtxEsAYOvY9s3mS
         o/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779340423; x=1779945223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXtisoK8i0cyvAoaHE4OQcmxs5XHz2jUEn0crM4CfGY=;
        b=L3I4oWyo0Cx3B+R3kE0k/0lr9NhiXGfLiAuDcMuGKyoSFYikozzVxvEa5THtM6QV0p
         dqUQVvo8PtDFDmiX+Fxuj8SFXM7TxKze9cvYuiaq4wjpfSTYrKrTbyXuq6DEyCpe1jv2
         xEP5CXvZjw/yyUOUkYVqKfVkOfZ/oLaFPZT58Y/EEc+twn/bUyP9V2PEgwq6B8hHCmeY
         NHUPpR9psxv67/InaX1ggs/fF+01m9IVuTvlwvVxTaSxUB4jxuKLwyTTz+SqiUcS7zr1
         zn2FwhxgBsNWQPddPwJ8jLgG1NUjyOfcjt9otOln8bv1N+zmcz+lNgKwCLqMrxMpvG1c
         /Klg==
X-Forwarded-Encrypted: i=1; AFNElJ+UcyS3acRwR7DjERCOx2KG7sjMSSkMz9wG38y2nktF0dmVCIjXQ3lQHOfOYQEVXr/l0J+pYzn4Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytsVv+RxIwFU8xQj5pZdGwZy+qfS1mlHBBJHzLdDSiqRvSt8zD
	9AoGnBKCj+E0PDFLPaFw3jN4vxb4av6Cktou9Ava/KrfES3XRBePM5Ce
X-Gm-Gg: Acq92OEzDXERIQFvztB6MNeNLcb5xUYflsIaJ2jpbrYJ7Q80ktDfac95HGSfgw4HYcq
	GfCgH9XbjpYXzecdxRlTlSFzmJVfpPU2Lsjgh2miEfvRY6TdL6b/tQtuk1UOoFbDqRSxx7wXK2l
	MQCTDCCRna/vSl6uROa95Xg9LP1MmVS7db7gxKCeGhdF+WnsMS4n5hWvtDR6vsqHdGg7c9zH6oq
	eIJFc/eJ1ebiRRjk+eZyzcpFUUGaMfyT0uUFnl2mRpPnyRdGBhcFL9SKw5koWh0jnsb6HNHNTTa
	1js0mQ69cFhAfqdIQ7C4pz99gPVpFJelBBPJ2TzyYUzXHMLEHV4CTBfrmzU/MzlYRMMz1EKTbYM
	5bRbL39HZmtjvZx/KE3YrAoOnw3qzjHOyQCeidiNUBGkD50Ov6s4recDkbgxrTxoJ5pJjTIlNJk
	yvSxGtFFltOLCun7j2VP17tCRmQgKctSBYkcssikiwTxT0NP3AxCJZcUm+bbjLDeYX+ttR3Aqm5
	Rpi0WxCyTnSuw==
X-Received: by 2002:a05:7022:61a1:b0:12d:b26f:cafd with SMTP id a92af1059eb24-13632a02cf3mr857042c88.5.1779340423478;
        Wed, 20 May 2026 22:13:43 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:d457:597:d576:1eb8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-135e5c0a918sm6231360c88.14.2026.05.20.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 22:13:42 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Wed, 20 May 2026 22:13:18 -0700
Subject: [PATCH v2 2/5] sh: pfc: attach software node to the GPIO chip
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rsk7203-properties-v2-2-465f3308021b@gmail.com>
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

With commit e5d527be7e69 ("gpio: swnode: don't use the swnode's name as
the key for GPIO lookup") gpiolib requires that firmware nodes from the
GPIO references to match firmware node in gpiochip structure.

Define a software node for the pfc gpiochip so that it can be referenced
by boards using static device properties.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/sh/include/cpu-common/cpu/pfc.h |  3 +++
 arch/sh/kernel/cpu/pfc.c             | 20 ++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index 879d2c9da537..d57e38c05bdb 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -11,6 +11,9 @@
 #include <linux/types.h>
 
 struct resource;
+struct software_node;
+
+extern const struct software_node pfc_gpiochip_node;
 
 int sh_pfc_register(const char *name,
 		    struct resource *resource, u32 num_resources);
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
index 062056ede88d..5a8d804d607b 100644
--- a/arch/sh/kernel/cpu/pfc.c
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -5,21 +5,29 @@
  * Copyright (C) 2012  Renesas Solutions Corp.
  */
 
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <cpu/pfc.h>
 
-static struct platform_device sh_pfc_device = {
-	.id		= -1,
+const struct software_node pfc_gpiochip_node = {
+	.name = "sh-pfc",
 };
 
 int __init sh_pfc_register(const char *name,
 			   struct resource *resource, u32 num_resources)
 {
-	sh_pfc_device.name = name;
-	sh_pfc_device.num_resources = num_resources;
-	sh_pfc_device.resource = resource;
+	struct platform_device_info pdev_info = {
+		.name		= name,
+		.id		= PLATFORM_DEVID_NONE,
+		.res		= resource,
+		.num_res	= num_resources,
+		.swnode		= &pfc_gpiochip_node,
+	};
+	struct platform_device *pdev;
 
-	return platform_device_register(&sh_pfc_device);
+	pdev = platform_device_register_full(&pdev_info);
+	return PTR_ERR_OR_ZERO(pdev);
 }

-- 
2.54.0.669.g59709faab0-goog

