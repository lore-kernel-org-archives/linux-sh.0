Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972C38E8C3
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144681; cv=none; b=fp23McpTrQQwhntGtBJYsWdX9rog4e20lzLfIsALVXFn25Eh7nGTmqVU3F/b10wgmrXJob0nIQ7N3WTrAm2mWVZSCC6VgbXum7u/DwytqmB+AKNJtAYYxZPtA/SvWV1MeX0Kle464bnpyha/iljXMpxSoGrbfCM06s55ELIJuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144681; c=relaxed/simple;
	bh=QOo0UQgUX/IOM3NWe+RQfCjB7ojkPhoknskSJGJzVqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rd4mi9LXc+44FOeQJRCNrrl54XdP2Ba7QcTlNsj9wdlHCBU86Lcr6TiXjQto3ePmELt94DQfWD3TIXBdtwCLILZwXfA1SvxEpvHMEfV0XFAvHRvkrVGGpFx5JU0pYZzCtszWOIFtdSO0xBcP6QU0mYGCxBgKg8l9duLcdaZwSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=shDBuqZF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shDBuqZF"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso1431993a91.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144678; x=1783749478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mshEXDTZ0VEnwp2KN2nTQ9wDHI1nE7UH34EulSApwM8=;
        b=shDBuqZFQWZlRTJs1eE7cWb02YMjQvzompqmi71AcsJBme8DSNq19ilGV6jXGre+iC
         fHb8L+tGtMBngAg/b/ex7aGG5MP2/mQnvA+TLlrwSNRTPZ+Y/d38ViASl8ekNCo0pTHL
         N2ymjjpFNQZwQnnHnQ+GS/SH3/XK4iYYsGofOyTBsyTgM+K3brgCXr/g36mvyo3tAwq5
         z6aTeaOuQfhl0gd23pHvYILLbjyA9WUf51zHoxA+EQnhGF6j38DAwjUqB0lcjxKtoiPb
         VpUdrM9ENGnei8XkEMFuXHBXfXUXgYqW4XkhEfbXYdCMBvno9ruKXILQyExophlDB2GK
         UUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144678; x=1783749478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mshEXDTZ0VEnwp2KN2nTQ9wDHI1nE7UH34EulSApwM8=;
        b=kBsU1w6io+XwTtwZ6IGMel6BJPxei9SmI2nniOozbyI/ah6oTsaNtiWAUT59ONtoHm
         zlhPsujTBYH6zyHqd6Fpaa2ANDwKWJqzgrbVmmkBGFp1CxPg5zxOORQOpwqnOUwMQnIk
         Iyq1vDbqftuLZvpCInlfbMMhsG8wAC0JxutubUVTJo3tvjwYxVQ7uNAQtpce44PxMcGJ
         jjwFM5LckCdKXcIyhoJWbCFv3DrjBUUP+UOUAbuFSAguDg7oQNAb8f9RKKYNjm4VP0tP
         sTdzS5BeOVyEaBtvUwUCanYYQI9eW93vWFkv6y6Ww7C0Dt4RWYV46uxAtmbzia0k5wSp
         uB2Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqidt0DWEQw8ByIMlzq4ByhDi5qPn1zC09YLAObdoKoLbgNTYyfAyEDr83CV9wqBhb/o8qwUSyRfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxhsjDW9G9UKmRUMSpxQ014y45uonrNEewEzH4+wUkANw/SlJAj
	mBbsAbWdM0ksk9Vshy2Yerk6u5V3Ig4d6utTgNxNFlM+AvXxn6I/AE3m
X-Gm-Gg: AfdE7ck38uSvD2jFTbI7lWzTKebySWSD7JLNfEeGLtZ8gHJwNlCQxrMODLEn2UDmIhB
	nQ4u1uzxu7DRED4b3vYbQ3BXkJUOEzBHP11nwyD/qBppzvwiHxKKjQu0txCOlQrTMuLeb6GeihY
	mcshnAVB/0D3C2LHDG37N4eLfYKDDB8KWK/9k0MJfw1P2VmTzSDuwBUhqWZQ2K37GHbhSeAn4zc
	Qb5o7JOrxsfi6cGkdSL3HF8ePYR4Y/sGI9HqaTrOMyN6Ds8Xktw1nqWeLMNaXEH9h7NG+3oZ3ur
	FYlbgO1uaEZx4Ua+KC0PwjMjIayiH3NN6Y+WnKHM6CcWvBtu+0XCaYcsSdrsGjLzjHNGfiRysrH
	ZTBrr7bs9vf6tJMERiEakZkZ0EUKcI4LzAP9mZtcH0/Z1wPixCMzw2yr/YYJFnQaNIz0jCyNU+C
	c/oIx1pxFXFHqPp8Es6pA28IQAWxAV3dxw3UjFBMUaUtQB39ceMrN+h0YtfYJwz7EysneiWunZd
	uXSTx/pFhZOoA==
X-Received: by 2002:a17:90b:1c8c:b0:37f:9ce1:cda7 with SMTP id 98e67ed59e1d1-3829f9e9bb1mr2379238a91.29.1783144677755;
        Fri, 03 Jul 2026 22:57:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:38 -0700
Subject: [PATCH 15/26] sh: maple: remove not needed
 maple_unsupported_device driver
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-15-41e424964da5@gmail.com>
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

The maple_unsupported_device driver was used as a fallback driver
when no matching driver was found for a device, or for ports with no
devices. However, this is not needed as the driver core handles
devices without drivers.

Remove the no longer needed maple_unsupported_device driver and its
registration and update the shared interrupts (HW_EVENT_MAPLE_DMA and
HW_EVENT_VSYNC) to use &maple_bus as their dev_id instead of
&maple_unsupported_device.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/sh/maple/maple.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 5585f220e495..35aff2e57d2c 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -43,7 +43,6 @@ static LIST_HEAD(maple_sentq);
 /* mutex to protect queue of waiting packets */
 static DEFINE_MUTEX(maple_wlist_lock);
 
-static struct maple_driver maple_unsupported_device;
 static struct device maple_bus;
 static int subdevice_map[MAPLE_PORTS];
 static unsigned long *maple_sendbuf, *maple_sendptr, *maple_lastptr;
@@ -368,7 +367,6 @@ static void maple_attach_driver(struct maple_device *mdev)
 	if (function > 0x200) {
 		/* Do this silently - as not a real device */
 		function = 0;
-		mdev->driver = &maple_unsupported_device;
 		dev_set_name(&mdev->dev, "%d:0.port", mdev->port);
 	} else {
 		matched =
@@ -378,7 +376,6 @@ static void maple_attach_driver(struct maple_device *mdev)
 		if (matched == 0) {
 			/* Driver does not exist yet */
 			dev_info(&mdev->dev, "no driver found\n");
-			mdev->driver = &maple_unsupported_device;
 		}
 		dev_set_name(&mdev->dev, "%d:0%d.%lX", mdev->port,
 			     mdev->unit, function);
@@ -727,13 +724,13 @@ static irqreturn_t maple_vblank_interrupt(int irq, void *dev_id)
 static int maple_set_dma_interrupt_handler(void)
 {
 	return request_irq(HW_EVENT_MAPLE_DMA, maple_dma_interrupt,
-		IRQF_SHARED, "maple bus DMA", &maple_unsupported_device);
+		IRQF_SHARED, "maple bus DMA", &maple_bus);
 }
 
 static int maple_set_vblank_interrupt_handler(void)
 {
 	return request_irq(HW_EVENT_VSYNC, maple_vblank_interrupt,
-		IRQF_SHARED, "maple bus VBLANK", &maple_unsupported_device);
+		IRQF_SHARED, "maple bus VBLANK", &maple_bus);
 }
 
 static int maple_get_dma_buffer(void)
@@ -765,12 +762,6 @@ static void maple_bus_release(struct device *dev)
 {
 }
 
-static struct maple_driver maple_unsupported_device = {
-	.drv = {
-		.name = "maple_unsupported_device",
-		.bus = &maple_bus_type,
-	},
-};
 /*
  * maple_bus_type - core maple bus structure
  */
@@ -799,15 +790,12 @@ static int __init maple_bus_init(void)
 	if (retval)
 		goto cleanup_device;
 
-	retval = driver_register(&maple_unsupported_device.drv);
-	if (retval)
-		goto cleanup_bus;
 
 	/* allocate memory for maple bus dma */
 	retval = maple_get_dma_buffer();
 	if (retval) {
 		dev_err(&maple_bus, "failed to allocate DMA buffers\n");
-		goto cleanup_basic;
+		goto cleanup_bus;
 	}
 
 	/* set up DMA interrupt handler */
@@ -863,17 +851,14 @@ static int __init maple_bus_init(void)
 	kmem_cache_destroy(maple_queue_cache);
 
 cleanup_bothirqs:
-	free_irq(HW_EVENT_VSYNC, 0);
+	free_irq(HW_EVENT_VSYNC, &maple_bus);
 
 cleanup_irq:
-	free_irq(HW_EVENT_MAPLE_DMA, 0);
+	free_irq(HW_EVENT_MAPLE_DMA, &maple_bus);
 
 cleanup_dma:
 	free_pages((unsigned long) maple_sendbuf, MAPLE_DMA_PAGES);
 
-cleanup_basic:
-	driver_unregister(&maple_unsupported_device.drv);
-
 cleanup_bus:
 	bus_unregister(&maple_bus_type);
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

