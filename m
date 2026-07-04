Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510BE3921E9
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144689; cv=none; b=Cxx960YMVnFTivSWy6NQXUDhzwQ6TkfgA/xA63Kzw31q+GWnCkcB1/wXgFIBUX4XmrcjWxtJ4jWKVdprIokbDWcN/4mIIJV4UnJQPfVz6lkzwVTkJLpIeWJ9F6OF43OlAWxttFj3FBT65qbhCZPr0H3rge8jHgMM+1diB/P4u8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144689; c=relaxed/simple;
	bh=apjEFUKjRBYrK4iX2Kg45dCDEie0ZHB8HqcgRhupms0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJb9kHOjjpdet3fBOnf5JCNVkTM8HwuaLidTcxXb/uBNfQwqO+JL7e+wwdkETZoxSo5ytTCmGGpQVbXlsO77POUEmhrNi+reBM/sn3VZJYsTfhVqs3ak6QB6YLYWBaDYmcD31OpQTVOfY06thS2TbDK1s2WxXmsQqEG1911saWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKlPgZ6c; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKlPgZ6c"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so1293213a91.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144686; x=1783749486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtRA/Iz7xW+gdF1+FPWoWbYlNNq+Ml51Iu6T+Ii+D0A=;
        b=YKlPgZ6cqpF8rzc1ezjm8eCWjHv7dbCEE300+iGaKGf2bbUCAgMWGgLoZOuLC611St
         ySAvyK1Xp3d2uMntCSaTvP0YtTf3E68gvnMoy7542rBk/33z1iod0yQFGp25YPhwZVZQ
         a/lYFH+ZwSCkF3+3idAr/bQ99wEK0/XL4pCyl875uqy6bSQ19ZoCOKzcTMmGcroz+QV6
         dAyNqZfvi8DSCx6mkcso29iMt/U1fPr1t2QQqMo/k1rQEUS3peguPLDTkra13H45Mskv
         g6cf/UMmXw1Qe9ZcrODcZA/o3srioIJrV200a1ZQBPt5+bVf77CQ8EDC0UyDlV3wXmaR
         69Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144686; x=1783749486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EtRA/Iz7xW+gdF1+FPWoWbYlNNq+Ml51Iu6T+Ii+D0A=;
        b=bXDqNMkquCu9EqjJfKHoPJHcBfwbBHug3s3ukIv78EAHVFmq3uYTAepNaZfyT/606C
         MMw5WeREwBsm+poTy/QoX1cGls7+OlnVSsa9UwqteJinP9FYcX+pbZ3UzNZm7crWO7Qz
         2J+10fmHAxGt9PsDoC1eIrT7ZrO4Yp+B+goAZTju+UY2jEOAmsp7bPD/ZfPElDi3LLAr
         ZK2vRXcKxl7+0hhlrgF62eBf+hU9HtNj0oQsFYGmQdRPO96tru9APrEjvcq6zwZDUDtE
         7PSafoXzW0+5/18FQZsHmelURByHSUXu3zcvEn78LI1ePQIJJMOFWDnwwraaWm4p6+qT
         sojA==
X-Forwarded-Encrypted: i=1; AHgh+RrIMGS8cEcY465tcPZnhxcOWjBksZHZ11VkaFObtA9fUrLoA1Mog60VxqS6guCS1Dr8PZ8Ge5dWAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4IIpAHIXOQB7i/ltc0/2DFAFSvv9zp7dZsH0UjU++jNBj0LFh
	np/q2w1SI9bnjRfIxKRy3v6t/LnTYKDQ9utArMyeKzhkgS96kliEvGFw
X-Gm-Gg: AfdE7cmRRBw+AYE/bpW2naVwIzR15Xe51+IX2Mn2hlbfINDVGRm36r5bwoiSvErrqJD
	UUvWsczB5Dp67gdi7c0XOxu2qP9U6iLlPkYfZb792bIDGDjPwnJh8SzvQDBZnx89qwnYwaTxSAw
	vn3t1VZjP18sWiB3YPVtzsW6ECDTDVMiMjJ9xrZrd8kHg0GoVaOZFnHkj4/so2XS5HdjrU5IqD/
	2D7gQSyM0KFVZqpcjgJO0ka22Xjkl3DTHBpyW+Bm4XOuAvHB7KHds7Ns6J01O6+2y4bdON9S0IR
	bfXKoPEzRX6H8PjSLZZ5F7MCIrepTsgh4XwPSPHr8jVEBa8liSHw/cYYqAf3kw9VBgnHUi51n1Z
	/7NiVKtvQdTQp7xDvvlnkBlVkYMycik6jwHvUh4yemrwe4O8h/7Th823Ced1zyw0m0orLZX72Lr
	AOQe/DPc+nW2ZQ9HPoygrJhxcZTPjkP6dXiEY7ed/xQ96MQ1obe0M1NiU3gaXg6jyvmyjJw+loD
	kc=
X-Received: by 2002:a17:90b:3f8b:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-38281185463mr2376208a91.14.1783144686491;
        Fri, 03 Jul 2026 22:58:06 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:05 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:43 -0700
Subject: [PATCH 20/26] Input: maple_keyb - convert to devm
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-20-41e424964da5@gmail.com>
References: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
In-Reply-To: <20260703-b4-maple-cleanup-v1-0-41e424964da5@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, 
 Adrian McMenamin <adrianmcmenamin@gmail.com>, linux-kernel@vger.kernel.org, 
 Dmitry Torokhov <dtor@mail.ru>, linux-input@vger.kernel.org, 
 linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
X-Mailer: b4 0.16-dev-6911d

Convert the driver to use managed resources to simplify resource
lifecycle management.

This eliminates manual error handling in probe() and removes manual
input device unregistration and memory freeing from remove().

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/maple_keyb.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/input/keyboard/maple_keyb.c b/drivers/input/keyboard/maple_keyb.c
index aa9a4a80e26f..bd4ce803a13e 100644
--- a/drivers/input/keyboard/maple_keyb.c
+++ b/drivers/input/keyboard/maple_keyb.c
@@ -155,17 +155,13 @@ static int probe_maple_kbd(struct maple_device *mdev)
 	struct dc_kbd *kbd;
 	struct input_dev *idev;
 
-	kbd = kzalloc_obj(*kbd);
-	if (!kbd) {
-		error = -ENOMEM;
-		goto fail;
-	}
+	kbd = devm_kzalloc(&mdev->dev, sizeof(*kbd), GFP_KERNEL);
+	if (!kbd)
+		return -ENOMEM;
 
-	idev = input_allocate_device();
-	if (!idev) {
-		error = -ENOMEM;
-		goto fail_idev_alloc;
-	}
+	idev = devm_input_allocate_device(&mdev->dev);
+	if (!idev)
+		return -ENOMEM;
 
 	kbd->dev = idev;
 	memcpy(kbd->keycode, dc_kbd_keycode, sizeof(kbd->keycode));
@@ -179,7 +175,6 @@ static int probe_maple_kbd(struct maple_device *mdev)
 	idev->keycodesize = sizeof(unsigned short);
 	idev->keycodemax = ARRAY_SIZE(kbd->keycode);
 	idev->id.bustype = BUS_HOST;
-	idev->dev.parent = &mdev->dev;
 	idev->open = dc_kbd_open;
 	idev->close = dc_kbd_close;
 
@@ -191,15 +186,9 @@ static int probe_maple_kbd(struct maple_device *mdev)
 
 	error = input_register_device(idev);
 	if (error)
-		goto fail_register;
-	return error;
-
-fail_register:
-	input_free_device(idev);
-fail_idev_alloc:
-	kfree(kbd);
-fail:
-	return error;
+		return error;
+
+	return 0;
 }
 
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

