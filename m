Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC538F250
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144686; cv=none; b=swJBaGs0UQcjuyjbCJNCha0uHeT6V++PnMyFvQCc7BqZ17bnHOTWTSk0Gm/v8H2ycucrQLkMdzVdwvf4YZ8X8r6Nr3Dvgtr4Lzoqa2szxsSo4QOU9hkydw+VlAt+JqqDK3GFhDrq9Vg3fhQ8D5lkSuk3M3bQuV3OnfzwYBvc9uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144686; c=relaxed/simple;
	bh=V7CkaRPOt1AB4wPWz8UHYq4OEut/rxvDywdfYXf8K4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQ2czbh+JuIgGv99rM7CIJIprQ5tJFoy29UNXnmrgeY0VogRDNS3V1TOk9H0LoER3eT+TVEhpkkIqCRswzkLNOUvUJXRszFcjylsce6p6C+MropyvS6CPe/uyUTyN1rTLRckNWKRPb4Of2SOzLCHxmu1BmSeJB8UbGBt8DIilJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2DIkKEn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2DIkKEn"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3804e42ad5fso1432053a91.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144683; x=1783749483; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uVPHekxxTvV9T4JJnXvyVv5aZspg0AcEDMfkFw+e5yg=;
        b=Z2DIkKEnmWmQdPCZy4SOgXji9aGF8gMC5wfYdELsK2ltymvfgvplRed4ohbVuV1w5Z
         xj9FXhsUyZF3fSrErQ2bfwvmmJVni/hz6+OLWX42Qs4xphe0Y2O6cNgFVIrv1L2FlYIv
         8lNojS+YcyQa5Rm6mvehFyGdnqlSJCIimWpaGHHeNVpZgEfsrTXv0BD6EIu09720ngDv
         of7sSvrauL0SG5csBAbsLmxp9JHMCERZO/yOh1KzNqNtOejkwD8oPn/Cs/PTlfRR7fJT
         L1FXfazCUnxtR1Cr7efG8NOtoVueqbsUjCcNMBhl5I+Br4pnbr2kxisany3cNGQSuDFv
         eZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144683; x=1783749483;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uVPHekxxTvV9T4JJnXvyVv5aZspg0AcEDMfkFw+e5yg=;
        b=Z5muJIHaiUDwlDS5DLbsGUv6CTm0TzBHf0zb1VGllSXwrC11lpDxDlaQcF4k1NQVjf
         XwtVwr9ihAp9r4hR+KGEMCq8TbHPDvixXWzX+XjKTGuYYJR8246uljj4HnjJmVnlGOn6
         /NZs7wqN72O0EKdqH7/g88gvPbVmBck9yfpCW7iwS9BxocTUGmSkC9HT87vD6DMFNm7K
         Q/L3XuNABeHoDAGxGfjfYH6OzJjpgra7WYY/oziwktdsWueZW5FsO51QYM7FEKGgNrgO
         TYtFUWqPkoOFdkeBGrPS3uMHTHEBc4awUrLTWPa+TSiIp5vieWugxV92fEtWiHTUKiWa
         iYXg==
X-Forwarded-Encrypted: i=1; AHgh+RrwRaYmhbVU6Eeyg+aQorB8+GGJij8p9TD9/4ur91oSGkxCpQEwm6mdRYI9Cq7sAaWoa6fdJBLbWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1O2uYdEVhV/bZ8/ziV66a9Y23TGv43AwB92m9eDKj8nFifv1
	G0PKVOCnBpvG1GTWayjV/vTqSa/3Mlk4MgJF0b9NKirNBKLsyECu+67N8XOP7A==
X-Gm-Gg: AfdE7cle0W6soj2Ht7KTAIjmB8QoLkMWbZD4wVVaOeUDAE4QObgZkbpuNf3c+jlIP9y
	FDz/yije8HowHJ3qTLtmJTvbhvVv+nCwdPXgACMosOmhkaOHLhFqjnlHtGurzK8rGsQxlL1tpn6
	rLbb6ind3lVPJhWutd+uLR5TLwT2AcU8FH61zoqTCr0Qbdn1LRP0/q/5PtpuWdzxF1MRVR47enx
	f4yqc+3lLj5S5NyDpcFhLv9nZHZ/VTZL/PkfoErUWw1xfIBQi3AzyHYGHtg5GE20kS9zfPN6tWV
	Kw8bKawoW3stvZZYRMU1wpMNoyGRjdEZ8Hlmay0IIjCn6rTit2oxPG6eZeqUoLNSVRWHgnELnYd
	qo9ISsNhRAwPAsh5Vhp8J6nxJsVK+EfgXdPKlnB1Jun4eozgvcYKZH0CuaSJFsSdBeEMQL8qDJq
	0ffsUEVP/3rC1eXbLtX61ZG73VO+iRkFz473ixlTRLbZjgJGnbV6SB8VNjN7fR3eRAl+rUHGJ9n
	MHy7RpIkrRqDA==
X-Received: by 2002:a17:90b:224d:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-3829eb1d7a8mr2296385a91.16.1783144682891;
        Fri, 03 Jul 2026 22:58:02 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:01 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:41 -0700
Subject: [PATCH 18/26] sh: maple: introduce callback_mutex in maple_device
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-18-41e424964da5@gmail.com>
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

The Maple bus core invokes client callbacks asynchronously from a
workqueue (maple_dma_handler). If a device is removed (or closed) while
a callback is in flight, it can lead to UAF bugs if the driver's private
data is freed.

Introduce callback_mutex in struct maple_device to synchronize
callback registration/modification and callback invocation.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/sh/maple/maple.c | 9 +++++++--
 include/linux/maple.h    | 2 ++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index c0715e3ace6f..7c82b7a8a280 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -121,6 +121,7 @@ void maple_getcond_callback(struct maple_device *dev,
 			void (*callback) (struct mapleq *mq),
 			unsigned long interval, unsigned long function)
 {
+	guard(mutex)(&dev->callback_mutex);
 	dev->callback = callback;
 	dev->interval = interval;
 	dev->function = cpu_to_be32(function);
@@ -230,11 +231,13 @@ static struct maple_device *maple_alloc_dev(int port, int unit)
 	mdev->dev.bus = &maple_bus_type;
 	mdev->dev.parent = &maple_bus;
 	init_waitqueue_head(&mdev->maple_wait);
+	mutex_init(&mdev->callback_mutex);
 	return mdev;
 }
 
 static void maple_free_dev(struct maple_device *mdev)
 {
+	mutex_destroy(&mdev->callback_mutex);
 	kmem_cache_free(maple_queue_cache, mdev->mq->recvbuf);
 	kfree(mdev->mq);
 	kfree(mdev);
@@ -655,8 +658,10 @@ static void maple_dma_handler(struct work_struct *work)
 				break;
 
 			case MAPLE_RESPONSE_DATATRF:
-				if (mdev->callback)
-					mdev->callback(mq);
+				scoped_guard(mutex, &mdev->callback_mutex) {
+					if (mdev->callback)
+						mdev->callback(mq);
+				}
 				atomic_set(&mdev->busy, 0);
 				wake_up(&mdev->maple_wait);
 				break;
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 641cf3330409..48ed7558b8ab 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -3,6 +3,7 @@
 #define __LINUX_MAPLE_H
 
 #include <linux/device.h>
+#include <linux/mutex.h>
 #include <mach/maple.h>
 
 /* Maple Bus command and response codes */
@@ -75,6 +76,7 @@ struct maple_device {
 	char product_licence[64];
 	atomic_t busy;
 	wait_queue_head_t maple_wait;
+	struct mutex callback_mutex;
 	struct device dev;
 };
 

-- 
2.55.0.rc0.799.gd6f94ed593-goog

