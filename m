Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D09C38BF61
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144670; cv=none; b=my5TbFD62OrXhKAwk6sAV+FCigBPz7cGAczn0l7+obdMNbsHmzjSEhnseZAj7Tyx6yrqZPP2ze/5V+wXw8jsgHVp/LykeJep4p8J14YMosY8yEb2k3bpkKZQnRQoREJApNU3ROuHV2pup5euzruW0WP/P1NDMsvU36gX2mIBGA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144670; c=relaxed/simple;
	bh=U89bmDnB42n015VBS+JIrR6P2wqCp+hfkJZAF2Zhsw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nrB+K/5B0ri6iewGEczHM2EBLacT1bZgy7+n5K6qR2lvatXIG9ZVvWq4sLenQllW1BFQiM8lrPQm8Xv+wQ/t7xqvXegQBzmETWMJUISLLl5ulo1HssCTKhWPtGtQ6Aj561Od7glBWVjWcQ1oh3ijkn9LWdwLMYxjjDPX774qx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=juBRAZN4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juBRAZN4"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84794e800f4so618433b3a.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144666; x=1783749466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dp1mXo5SNq9TpBKhHNYZae1AakBfR6uJunKVLp5bf8=;
        b=juBRAZN4wWECQgbFAan8foBltK1+P2IZKh8sPbEa7j6j1tMBWEFu4cC6O4YnpQlQoQ
         vASZG9ld6IFf9H0MObdseQcm5+wjjglcG9Zbz/Ay8LgDAQgZmm+uWV1ehemCP/HvE4Q5
         ido8+c5HzsIh70we+DVHG5VIC/170oE38+03OkieZSLl9IkFpPEYcq1wRn7jBsBw+4o5
         KbIQJPWMjUvmjB0CZaSYo3tnm0WZO/yoWThRciZa0o3Mw3jvTCRr4oPdhNqpIcgKmjy0
         90YOHYkyzgCWSgDY4Gfenm+wTLUanaFfbpjgPagN9qYqgvEvoynoMzIlh9CP5qB+OlzS
         zK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144666; x=1783749466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dp1mXo5SNq9TpBKhHNYZae1AakBfR6uJunKVLp5bf8=;
        b=ZsrWOaOBVbS/oxlI9CsJxrurtG7rMCX+ambqIwtcp87xKtPR8B86yusfvzBCxAcTaI
         uH2P5tWCkEw8waqvZWVoBht1ucVUSzGtmp1TwMZltehnUSx/NBR+FVV5COkgsYedQbdG
         f6P75dn4mP1EX4hvQAnbRpab31bLUmJ2SKf5uvkOCxL6tzpgM5mYNKdO0/8ciMW4HjqR
         qny0D/urzEsB7McaQr0EufyLzAKF4Kkj8Jvd6/QIATEteHqRmE7oLwYYz+Hf3uN4Zo7D
         ELaZ8hFmgcXF2MplU3ltsH/JLkhdnbahJEFdEAOATupXk27MYWETrkxeciTwAVWYMWky
         bX6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+qOx7AVA3pjZOhg/DTFYZqlgxINFohmdgWKHWxmzgliMiyYnjMs/lfW+l1mK/nkSoEtmlHh7Oa2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qlNsXoIEJ2eZr7l/UNXJSTDMflpf2smg3bNaoE5mGmb5vFgs
	nKypgBeai1OUx0sshSAiCkQ+zvk034wg2AdXHqiiOdVCATQ7pOZoRvQa
X-Gm-Gg: AfdE7clWJI+PpI+juIoDuC3L85PWUBObn/W80kROUofABTk2m++P49TkHSAhJY9+Bbt
	TkePjkmVx4QHqdvENPl0OKN+kdH+Lzlq5HQvZ07+XajHCdwsgt7wmbRVqT/DNrJOZCg8mOOiiCq
	C1DouZysGVNp4eua2czv+Kv/kzrsmIo3omGj69DCPPNPXJiNodMT+++kAFVi8qbaxqJJ69hFEaa
	POc069ongKvoJKSIuYp71J2ajz2uE8poqxSJ++CNEsk6Lh2+pYNm0hwimNOlji0bsiI+03n1dpH
	k054neWObsqQduU7K0OMP5HRnP/nxx6Abrp2XZzh2Ll3Y2ESKQ+6g0FSKtupN1wo0DI2EyWQCEF
	ESNX4BoJerwq/zCBB+siOKJjpQZbLko+N68S0YsauHwXVy9Lpg4O+clm+jrzeY58JYU5BEmbhoo
	Y2NX0Q7dWiQagObsxRgZfHdwCbigveA37WoULwIiReAUS0+0O8hne0Kh6VuX2FCEYvpY0aNuIFZ
	uA=
X-Received: by 2002:a05:6a20:d43:b0:3bf:e66f:266a with SMTP id adf61e73a8af0-3c03e5b8218mr2447512637.59.1783144665865;
        Fri, 03 Jul 2026 22:57:45 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:31 -0700
Subject: [PATCH 08/26] Input: maplemouse - remove redundant drvdata
 resetting
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-8-41e424964da5@gmail.com>
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

The driver core automatically resets driver data to NULL on probe
failures and device removal, so we can remove it from the driver.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 97d520e7d66d..37f60bbd0ba4 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -109,7 +109,6 @@ static int probe_maple_mouse(struct device *dev)
 
 fail_register:
 	input_free_device(input_dev);
-	maple_set_drvdata(mdev, NULL);
 fail_nomem:
 	kfree(mse);
 fail:
@@ -122,7 +121,6 @@ static int remove_maple_mouse(struct device *dev)
 	struct dc_mouse *mse = maple_get_drvdata(mdev);
 
 	input_unregister_device(mse->dev);
-	maple_set_drvdata(mdev, NULL);
 	kfree(mse);
 
 	return 0;

-- 
2.55.0.rc0.799.gd6f94ed593-goog

