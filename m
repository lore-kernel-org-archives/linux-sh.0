Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D81395AF7
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144694; cv=none; b=s2s3yDoJbjKxF8V+ssGN4wfRqjYn81dl51a5h6SRu6XBHLcY/SzUmfiLTT1cBq5WZWODdSsAJQLHgsOO5Y/8+3qNe+YF1x5WFq17N/liIFOLGv6+4vySm5h61g8G2rSlywawLv5jr/ZvZZ0pmsa4Jw/nlAnn8Jl5lfGle6vaafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144694; c=relaxed/simple;
	bh=+bsOwx9nTrOYEXFntbGCVjJcg5PLsYu5S2ZCTM7LJUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gxwLeDZHzgXv9See3ojqwIVOtsrYKyuwAJDGAI+i31QdJRxH+M+ugS5CJa6rUGna2XLd+4rNCQwsjNODTqWqOHBY5faq5y6NyhvPn++Wz032P/fSO+dD1VicPqQ+wSnptCTqoGzdBvCvtdmjHms65wihbzCn0KKLJHrEi+ncIeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5DB4iPF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5DB4iPF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381b831d535so993854a91.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144693; x=1783749493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U4acdNVktMdF/ZdKGXVy9IqprAtt4e6vm+MUIpvJ+to=;
        b=W5DB4iPFgvIZdwcj8RFIQvb7l9ya/cb8I6lAr8agXnoOs3eJuE8hg1SK9P7Ns+qc+K
         O+4kQduNIISzSQD7FM2U/w2IUqjXkwzGVAnDZnrwSkJk3AMa2ky7r1iFrMwZlO21w4Ps
         Pp9WqcbQWHAc6iJoEqRJeceJbxSkeC8cmU08O8ActvABzq6nwZgq8L+TWe/XY3meackt
         mx/IZrC97WrBnufMliw+blso3tz5jdkTS7uU5+voY1Iy8KwrYn8BL8m1v3IUaXIQYjHa
         6KNd2Y+1Ht59FC5lRFwV1NBWEtZkJ0HvyABxZp2uav4x8HsfJHxMtx1UMeEas6ekitpx
         HSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144693; x=1783749493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U4acdNVktMdF/ZdKGXVy9IqprAtt4e6vm+MUIpvJ+to=;
        b=dtqPdlD/JhBnudohzv5hAVppDnWeytp0TOuMKEJxYCSyJCxiaKwFKeYlAwmJiX+rR0
         +NXHveffnFm9B5LRtYFg51KJ1IsOH/o0DmhSmjX62yxrUO+capx5vUhd7iS1r28yQb/n
         Mwu46aRmWJeFapPc0wJhUik/f/H3Fa6QGiNZMyG8c5W+uuseUPkFkOZyNS8wWXo7X/iT
         DSWudN/TRSkSOJgDQCQGBcp6SNAdXu6eLwn+D8R2mveFi3xGYmUbj3WwsEVxucQvi6fS
         TwRylhryWIGBEOl54443i+2kQgLxKvbDUWLsI7CeKhxXxo9hzfY+76qI+gCZOVU8+VgI
         Nglw==
X-Forwarded-Encrypted: i=1; AHgh+RoJMQG8KjV5oVy1zhNSjUi4RKWz4AC5XQTL5W45di1TdPzMVLbEuQynqSae44++w+8gc7EWOB7gpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1VQQdAnsffB8uknJucFqlK9rpUf3FjflwvHgw2BrvEwM6CfWE
	bxV8fI5+7lsHyXwhXKfVZZAqXY5zrKy/d2ZKJyu/omMfob99u4r3KH43
X-Gm-Gg: AfdE7cl7v4fhC3TYGYW1Y/FRL6dtgEU9Y1gS7n/kPuI9Qhik/3DKs9a0Sq3VdCSddUA
	nH8Hnm7+xQdEnG9Qt19XUw3DNLn1H1YzB5dKE0EkPt4Gky5o72FezsFKjpuIRrcSMlFUX9e0apG
	y7OsRAvZe/m5myKUrOx2//pVKsM0GC0ANslf8AjwkSFWa1PTUeGzH+KnB3CkVJL+10p9d86Qp3Q
	pSWaCjpldb5v/FjUhIRT+mLg3XXkxdjmq/2HchJfdmx/KZ+z8tF2shdallRNHhMsM4JNn7uTMZo
	IJqCd/mefiA0XWHdtifwQ7IJI0KlREAaBsTGDcVSAvOQ/1ov3AFjV24nGt+/pb+AKp4kCDK0kpJ
	njxvcbh1lALvzo6KBHfo2PPUz+lFm8/5QRjt9US3g9k4AWKeCrTgeYEerqszzmYskSiH/oOJ5zZ
	z1BdW4MkE1Tlhw3yOQCXdEATBV5YYt7li7mWDAMz1H3X31hxXY0XeGmCg/bABfddOY6cue5OVTh
	kU=
X-Received: by 2002:a17:90a:d406:b0:37e:144d:7f6e with SMTP id 98e67ed59e1d1-382802becaamr2576630a91.3.1783144692874;
        Fri, 03 Jul 2026 22:58:12 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:47 -0700
Subject: [PATCH 24/26] Input: maplemouse - fix style issues
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-24-41e424964da5@gmail.com>
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

Fix coding style and formatting issues reported by checkpatch.pl.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 7842bd46c9a1..691cf334ae9c 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -50,8 +50,8 @@ static int dc_mouse_open(struct input_dev *dev)
 {
 	struct dc_mouse *mse = input_get_drvdata(dev);
 
-	maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ/50,
-		MAPLE_FUNC_MOUSE);
+	maple_getcond_callback(mse->mdev, dc_mouse_callback, HZ / 50,
+			       MAPLE_FUNC_MOUSE);
 
 	return 0;
 }

-- 
2.55.0.rc0.799.gd6f94ed593-goog

