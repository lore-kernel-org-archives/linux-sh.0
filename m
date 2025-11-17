Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84134D383
	for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419620; cv=none; b=Vxurv7QPbH3Pen84lqfQWAhTHZRQ30awH7+ipgvaFDbCph9qOiGy2hPl2VVaUkhnmh3vaoIcKdfh5jaFCrIGpA5vexfFiHPROsJki5TuHbWvqOEdtbA7QEnsJKirQs6uBJEzCLb5YD9AsP/O2HlTtPOJ0TZgwXNOxAdKZ2UDUwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419620; c=relaxed/simple;
	bh=jA/ZHBrEKOSQVARcGtVcJs40DXIXWEQr9YcWzhSwWyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntTPB/V6SJ+68TemPyLC9Z4+CwxNPFCi0JBjJ8ftKfm0w4ivwToykqNokbQhB6faz8Wnlw05wnQBz7ACeNoj2obSRutuJ4uzTCknTLiyultCi2tprfH+1exSz7NReaJ5peHSCmWcvwLHztRMvblfcSmfxyLHq4384X8DNRXq//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZHig/C0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZHig/C0"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b72bf7e703fso805848866b.2
        for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 14:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763419617; x=1764024417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kvi8PD7ux6OLYIZX+/H0obhuKo5+FvClrvPgKMpP5Nk=;
        b=EZHig/C0PhAb0ljNeDdkNanY6rPpOe748w8t9EqH/H6SqV3xAuSV54IkKgsA3TcPSw
         BgQwqZGo0bClxloM2kMaPdoUP9xWHSNozN78/Z0JlhLfS56VGcJ/5zCZt5Kj0EEpcC0B
         GLrlgPSL+HAlbxi/tUyJTUVkuM1Yb9R0v3fz6eRIWNQQiPjm5Jg8jZkSkS8a64MhIcmR
         e4K35Hgrv/twZ74t9ySJwDk6vxDhInV465IpIhSGzjP3p9DKKi0lwe+qk7SISIwQsJes
         Ftc8yMx/mmk+TZXHXHE3xe7pQ+TyE2BczxwhIQ4zPFh/0pJCAyw3+THPCEVDQP4BYFW2
         JdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419617; x=1764024417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kvi8PD7ux6OLYIZX+/H0obhuKo5+FvClrvPgKMpP5Nk=;
        b=HecdT6CgKs+GnhxPEIqH9NgsOqN1fdSH0V4yxCRK/kveFYUczY6vOVb4t6SsqRSbsW
         qRgX220sWHcRn3WZWLvod58+XLCL6+XkUrjkdsXQmDQGJ9bJ4eN+LAdti5pqTz1vdszr
         dx1dlyyae/Qg2Y4F9Qtlqe7b9rkr3tR4dIh13YGXU7MR4SlG/yp9PE8lfwXTYkUHChCf
         fwQZ0v3EMN5CFB9KAiNOC1h5MkqCBCA+y4DO+s1eHvvrNyCYn++NgGgwDTxlJSABSnFk
         BpJUjipD7HcIF5bCqtsP3s/hfF1jQYOW7D85b5B0qXuKq7x3WYl/t1u8/5njnN2vIn9f
         go1w==
X-Gm-Message-State: AOJu0YxwEsqvHrqblx6JX10wjbSdaWDxriUVGDNtrQ9FmTJuUDhE9k3J
	/XqCVCqsYEe3BdWGwu5KwNveRbDO3ecnz7TrJKpY1jvWQ2QOiK9kCAjuju4ox68=
X-Gm-Gg: ASbGncvleM7bYpkgAY1TtZp1ZShqS3ZmduRn+J3WUkyYrtL8q/wn67EETRc0ljPyWhU
	ZvDIeDijFIIaCyXwoOQiQXLcWhGHwidiyAc9+Ho5UweN0sNhVcLw/yTUG73N45YM32sBUyhT/dg
	e5p2ZcrC6K5b6W8xLOlmyr79G+0mbSuXkYu45oSGqGtbzMiWyaf5kkkbzJfGx3Y0EEznbMy+tDz
	V/btrUGUu/0UBF6cXG8FCLryd5m30xOPChzSxe6QSnV3xVxwKsyI9OSLFySv8tYaa0sMMMRhi/U
	uJ5bAxipDbBM4MD/Z6y5oHHsJhe0ClyGXOOb9UXWLQeOPriO8VrdCyJxH1MncBWRp+/hN66M2Je
	WbdRePGQoCeiBfpoQophCPnuaiwAb1HaGKk9JfnfqYsty3ytI+KEE55Gy04tBclygucy64OPrgd
	DjhLq7uFgrbFsIgtobfrUhCP82B7NSnMCAY7OCXXk4dn6f9j2k+YE37msWBmolVT0LLFY1
X-Google-Smtp-Source: AGHT+IES8z9W/ZUewPDopCjp1qbQPjkzW7d/3SgBKJxsPR6cY33LGwmeBi3Hmms3epl6sy2024347A==
X-Received: by 2002:a17:906:fe43:b0:b75:8b9f:de3a with SMTP id a640c23a62f3a-b758b9fe481mr127507866b.59.1763419616710;
        Mon, 17 Nov 2025 14:46:56 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:232f:6d66:f093:4e68])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b734fed9e9fsm1179130666b.69.2025.11.17.14.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 14:46:56 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH 2/3] mtd: maps: vmu-flash: Fix fault in unaligned fixup
Date: Mon, 17 Nov 2025 23:44:07 +0100
Message-ID: <20251117224408.498449-3-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117224408.498449-1-fuchsfl@gmail.com>
References: <20251117224408.498449-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kcalloc() / kzalloc() to allocate the memcard structs, instead of
kmalloc() / kmalloc_array() to prevent access to uninitialized data.

This fixes runtime error: Fault in unaligned fixup: 0000 [#1] at
mtd_get_fact_prot_info.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
 drivers/mtd/maps/vmu-flash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 53019d313db7..d0793f1b0fac 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -609,7 +609,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kmalloc(sizeof(struct memcard), GFP_KERNEL);
+	card = kzalloc(sizeof(struct memcard), GFP_KERNEL);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -627,14 +627,14 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kmalloc_array(card->partitions, sizeof(struct vmupart),
+	card->parts = kcalloc(card->partitions, sizeof(struct vmupart),
 				    GFP_KERNEL);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kmalloc_array(card->partitions, sizeof(struct mtd_info),
+	card->mtd = kcalloc(card->partitions, sizeof(struct mtd_info),
 				  GFP_KERNEL);
 	if (!card->mtd) {
 		error = -ENOMEM;
-- 
2.43.0

