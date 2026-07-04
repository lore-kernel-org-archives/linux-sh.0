Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362F38E10C
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144679; cv=none; b=i7ABcDYYv7SGHxyyfDWnMuQS2xO4zHilzNHHY5PKpbQJZX5hFMNkJB78Qfjg0/tkKNBo5/K6TR5sOLDPoc0orOeRx4D4naH63xI+7a0dMYQjQ0GQ7DMps0z5V1BEwtwH3ozc3tPi3cREyNFovR1mJ3cNvgSEjetTBbxW/n5UbLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144679; c=relaxed/simple;
	bh=kDux37zexnLOGh8VdMuPwY8vE7k5m7s2gavlNWMAuFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EPH9wGvXyjMcEUhq5c4YIeIA+1VJI3/NXrgkN5aatrIyiufsw5/FLi6OoC/3amP/LsmQDhrQbxyitkWHbv/yThk4lmA1qIt/AxMMBqCnj9lzClwCo/kv2NCVX8ocFcWzWOrKJPjZnb6IGcF6B2/DIl9LzekbAYMvWmUB8Tc5IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGJ27AUc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGJ27AUc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-845eb7b96feso1098908b3a.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144676; x=1783749476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdTmxlQdCLPDy6vLV7fvg2daIcNL2JqaHKiT0xd47mo=;
        b=gGJ27AUcClJjXmBNFie4KJbIH/7C4jITwBf7yZ2PH8yEi7Dgyyx2zh8tTdFH2y7sJl
         BDHjsQ/mUo59plB0NsS2xNcEvVy0k6G0bX+g92h+nJzSDzfm81mTTMy1Eg9I/jgsN88C
         6s6W50ZQkqcReNXW7VXEAuwBnDXo3QEJG2HSTzcCx82PfuxPJ1Fll2faf9wvKm+NrkGB
         um94fhpDNj9kut9zyGcoCSA7fNZMVIhr4rwMA2G2DudkUMtKYoya59NeDNhIYqxIuVcG
         Hnl5E0tFHsxZldmF9O3YndjYa5OWpmmq5q5ZMUhiDvfLr8uRQxMZ8NUVqGp+FvooieOv
         W5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144676; x=1783749476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mdTmxlQdCLPDy6vLV7fvg2daIcNL2JqaHKiT0xd47mo=;
        b=rUpqBulxw8mZqHCj8vI14tyZgTxL27nh3yBoaT7/DkTbJcKsU4ostqGUgNQDcPyjOs
         lCJW5HnZ2QJrbWf1ORzszpaAaZEb54cr/UlutVLthk/WFngkxwOe1Yc3tvk5XdxGvS1z
         8SeDWjnDBuNDCdyMQTCF79h1Shi+h4o4muRM2h3pBvqc57PwbsGxuIKn2lJJRH+KlmeS
         tqR6zXcMTpY+cIVs4Iqxityy/Jvl2S/v4w13tuQdPM2+pnSa0RhgWgbYSjgNLMcAVFS0
         4QX0aXVkJHgTBc8oJuQQ/y6dH3nCR6N6vKBVIOl+9s+Qz82THXZwk/HtopFRRvx6uH84
         CgAQ==
X-Forwarded-Encrypted: i=1; AFNElJ82n9GMYjsDRqupTXw2oS3kMnP8lBBopp+2Sim8+XFc0ZRfTXHkEsdo7mIsQWeDZce9jsiBOnMquw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMkyYqmDeiza445+VVe8bRA3da6jLDU8ZU4VPOgkq6tk+OChz
	D+J6esBh4gZzF244ReBtZXtWPmEpjaSfdJdZriTV1gxllxXzh4VY21SA
X-Gm-Gg: AfdE7ckN+FirTVY+bpafH5Hb9tVM96TA+PpIsteD9ZdqueHpwdIs+yXzB/k+/lLEsI1
	wtqL+ZXweWBl+iFQsqz6y3NBoXBVLC2oYq6kY5y5nBX+cQ1wM9d92KLCYj+hh2CQFbQSGIaSBjM
	+26FF8I1C4r0vFDhc/HiHtselafIa47jqPvaRFhubQpsKJrPWFEb8wCN3eph2l4Y2ugi0+NrrJH
	cIGoPQcG8sKiVkqUM5gN7G4UxQi0Kgag9M79Rnzyn3CysW6/d7rIt8YMUL0NzhwLVB2WMOrNmC1
	2kOd/bzWCTH4QfVrlj2l8ZQuzula5zLYURf+qGsqWHuz6D1Zce7WUYHmxsLuNqVEhKm8CauYYCS
	zJbU7hbrxkF01edGBxGQRhssdZAGgkhs1lvjOusCTNZKUIKhhGygAu25jSAujpxzYOBzjh+uw5l
	4sRy2Ylr7a1JSyn8Fx+4vEYQEnXqhRKAFNXT+nkv+BnCiBlm0m4U3aSipEs0eDbd5DSJ6AkKBD8
	9I=
X-Received: by 2002:a05:6a21:1bc3:b0:3bf:7c02:c46f with SMTP id adf61e73a8af0-3c03e21c2e6mr2608163637.14.1783144676040;
        Fri, 03 Jul 2026 22:57:56 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:55 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:37 -0700
Subject: [PATCH 14/26] mtd: maps: vmu-flash: remove unused mdev->driver
 assignment
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-14-41e424964da5@gmail.com>
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

The driver field in struct maple_device is no longer used since
commit 1795cf48b322 ("sh/maple: clean maple bus code") which removed
the reading of this field.

Remove the unused assignment to mdev->driver and the now unused
mdrv variable in probe_maple_vmu.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mtd/maps/vmu-flash.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 10244e6731d0..8f7028ac1b56 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -772,11 +772,9 @@ static void vmu_file_error(struct maple_device *mdev, void *recvbuf)
 static int probe_maple_vmu(struct device *dev)
 {
 	struct maple_device *mdev = to_maple_dev(dev);
-	struct maple_driver *mdrv = to_maple_driver(dev->driver);
 
 	mdev->can_unload = vmu_can_unload;
 	mdev->fileerr_handler = vmu_file_error;
-	mdev->driver = mdrv;
 
 	return vmu_connect(mdev);
 }

-- 
2.55.0.rc0.799.gd6f94ed593-goog

