Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05068388E43
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144663; cv=none; b=Hv960IEq1DAu4ZfFyXn8S0b2jajreg5GwSwzjzZ/dHIVIZu2Zow3uGKFEPoa1Qk+XoRBo8fH1WvWBjCx1pAQcYuDmdtPe8qm9l8wRiXhSCc9U5o61DpVyaxbOiuLyPqWh6gS/FrfuChRrycp09gfaeF43XUkla4S30IxYul9BNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144663; c=relaxed/simple;
	bh=UZSM3eWv9Q5ewCC7Mf4OpTsyzSqpcOfv7jMvg20ynLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XKpSogZu1ljigtFWFexwhiwq2FDageXy+R1d01U6KAUSW6foGgdizlpFdztgHD1ZPEKcvhKzgrFJC5LhLQ5dqXshJTp7vw6FukncwBGXFbyTehqCwS00XUnP/OzBIKwNsL442yYHlbVsufbzHQwhnY90b4J9CawtISWAVlepYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBQ660tP; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBQ660tP"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so967525a12.1
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144661; x=1783749461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15hSQeEEYahDoHIjuKW6WN5DINg66LHxIgPA/aX6Wqk=;
        b=EBQ660tPO+qC77gimM2m6DI0qfLh0hXUUlNlAye+sAF6tbl2tTK22GlPT+Lk/VVZhx
         iLoTCplTHhttB1eDSn48C0nFpud98oIhFypd/bACqAhgyXaS2hqUvzmRyrf7i2iRvN2Z
         qExcMzx0H6FX+P2pon5LD90i7BS1277002N3udbKYpIVpvoJlbgVJUbyr7aEnnezW8rG
         tGijeP19gXhqkFmj3X8Z2B/WxAGJL6a9JnoozPWrjJ3IuzG+P3gxizO8AQh+KdNbihrI
         Cw2+XMVENZK3ij8lJzODRK9ytfZUuWYKi1M/qxiHu7ngfYlnGgO4JB1b0H3GaBF3NlRv
         4QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144661; x=1783749461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=15hSQeEEYahDoHIjuKW6WN5DINg66LHxIgPA/aX6Wqk=;
        b=YrvSrAwKIlk88xIp5Ay+llEXilDE33YFcI+YPeC6463QwTTbfOP2JPHIO33uHVbnpK
         M60Q9VwgFgrw/zBDDlsxmf1182fx5TB3GF7KYUvU/slxxlsn2r41f/Ums6G2yYUpjzDD
         UNCvELykeF3uuZh+v9wnL8bCArRo1/GEOy/LSNPLrXTdt9s/EZ5ORyNK0jo6fBGpCFJ0
         aPNXok9H5d1pq7df3YaZ6yYrSt0iDQCersYR6kBl9Uax5H4AwFgY6GU3Ptr3iyQaSqK4
         N37Ay0Bo0eoDf+0cDW47TtKMgz6zfU1Pn1cpDzcJR//9ZHSdYkjDwBOkIt/5XzkImK76
         WOdw==
X-Forwarded-Encrypted: i=1; AFNElJ+WxSWV0kfPn0ursahf3FTJCpLyT7z8ON+TMDUpMGwKzUqnXF/j7glgba5ql6FBwZzYKuadbcjheQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtrMyCnBFSVQjqrwt3g11fDp0K8nuZcUm5J8GxJcmFm0Koh8xz
	9lb6RQ0AE9PD2K1YZzFTFsd7x7pofeDefk7gZBtim04GMR5VMyL1HdEv
X-Gm-Gg: AfdE7ckFq48Nt1K/w2wu/HSWF9l9/UFWhwtcfOEo+Bn7lPqIQmvZ9QVEqAaCr2c07El
	8q+kDbD0ep0RMSk9V66OitgQuLd4LwhS0ES++btRZJ50Ntp+SirEkPEcAHVvkKxe4XfVeKIEvi2
	0xg4m2pbaTYtydBl69TCZX9J6+GNSiYT6Qt5INdf96Cc9/XbwZTDEcvihvXiEEAaKYyZKHGG1uQ
	+hBLxpVpCGCwpwx/5nmz+TV1Nth6V2OmZ4CSKYomT6+yz1pZIT4xz7Q7bA3Zw+uMwjBuHjJPCH3
	IEnSVnN6efbcDPxVPggjI2erjwdGwziYKJoBxQwUdlMJEZJ3sOmq9DV+XcwZJmGQI+zNgEdENOk
	a/tJSdeEXlBJGUP1roAmfuiBaac/pOjXpLXVwRrpDOJ0FDSPJRsrvuWfDKLPdusSaSG2vENOcrz
	98mwDGDHiDHJYdjtieEtXl58k0nDD+QihQ1kOQ/qSjc/DhcoyZGRh2WDF5b6SpWfrLnJi0ynYLB
	DM=
X-Received: by 2002:a05:6a21:44c8:b0:3bf:6c08:2849 with SMTP id adf61e73a8af0-3c03e540d9dmr2322074637.56.1783144661119;
        Fri, 03 Jul 2026 22:57:41 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:40 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:28 -0700
Subject: [PATCH 05/26] Input: maplecontrol - stop polling and clear
 callback on close
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-5-41e424964da5@gmail.com>
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

In dc_pad_close(), pass NULL instead of dc_pad_callback to
maple_getcond_callback() to both stop polling and clear the callback
pointer when the input device is closed.

This makes the manual clearing of mdev->callback in
remove_maple_controller() redundant, as input_unregister_device()
automatically closes the device if it was open. Remove the redundant
assignment.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index a498fc322c4d..c66b2614e298 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -74,8 +74,7 @@ static void dc_pad_close(struct input_dev *dev)
 {
 	struct dc_pad *pad = dev_get_platdata(&dev->dev);
 
-	maple_getcond_callback(pad->mdev, dc_pad_callback, 0,
-		MAPLE_FUNC_CONTROLLER);
+	maple_getcond_callback(pad->mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
 }
 
 /* allow the controller to be used */
@@ -156,7 +155,6 @@ static int remove_maple_controller(struct device *dev)
 	struct maple_device *mdev = to_maple_dev(dev);
 	struct dc_pad *pad = maple_get_drvdata(mdev);
 
-	mdev->callback = NULL;
 	input_unregister_device(pad->dev);
 	maple_set_drvdata(mdev, NULL);
 	kfree(pad);

-- 
2.55.0.rc0.799.gd6f94ed593-goog

