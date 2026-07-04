Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A5338B131
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144665; cv=none; b=Ri9vivyjBPxNiMs3789qM9yxX0qQY3wWzj54VBN3r0DcM5V7L4/eISgoI/ssVtRAKE9A6wVySj3Lf7z0Arlu2Nf8SpJT7SzKR/5h4BfTu8YoqYzRoFGwvhR4JmB7e20lrW9Pfbf5szmwEL7Jl0FtsKiSD5mLJTfqhbFsR+dsl20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144665; c=relaxed/simple;
	bh=odbDvJx6lsIoH8Kr5k7TX6xmqMEZUVoCppIYKyNTnYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7aqfjMl4Kh9he1p42yN8BSpOOBnpJshH2p1cRiy9n5BcXmUeztqiaszbZykLnd0aDSFJbOEZK3cbP2X/+kF5mFqzN7JE0fAeIi0oJ4uhGDLjS/NblK4CH2icwDTLA9+Hq5ORzoHvmT3PGpnI3sCMV7yP5zeH6ofbUl/GUqOxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et3pdl8F; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et3pdl8F"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381507c9380so603415a91.0
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144663; x=1783749463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0JiJbOxq7Ya2dq8srztzHeLNjlbnlC1+4jsRTTFCbAA=;
        b=et3pdl8FnliwRsd9H5b8KUqlW8YtibE0phCQxmZ5RzXTLhQminCltWm7WJ8RYYh20U
         abhE4eLeeQV60Zdooa5TRMPIU6QJ6JQDP7d6J2VTGAbNjW7I/0qPihmoaBwOlTUEYqoN
         F+tGASKXO7AQJy7rb9oZtpWnUcD/2YEFqvKH/ThY3EiNdQG3kn8EyaC6gqYaIHl33Ky3
         B8kwOOMx5lpGcvCzODIc/PUkTVW3jNth0M0WZXjouBJ7apTPiy1aajYGujSv2brxqDR6
         /di0VNkj4ov9CRBurOPE5PFNmDoil4m4Y2F062gPU+0DlDsufJY+56haLN6Nn1zne2aw
         XexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144663; x=1783749463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JiJbOxq7Ya2dq8srztzHeLNjlbnlC1+4jsRTTFCbAA=;
        b=bc8+khBpgBxSb1b9QMee+bdjCDIVlAQkbYTPd/9Ch7HSM+hMpJiRzdSP4TLnpDtxHm
         nUK1Wkzo9NfimtQEZmRhdlRYtAw8E+7er8QP5gTfMqxi0yLYtu/hwr+HZzK7X0DueQw/
         eEA5RNcLTh12BY70p8fOnBZRoeGpdb8bn5+ilZBioZrKPDXb1mvuqu3T8u4Le3RXAY6H
         sRBd06F2RzmRMDFzktH6vCfJQuy/wJCRPK6xQL9UR34ZlqucFQqn3h+WRRO5zv7250WO
         cLPWPjfST1MNfX5oxZVAnNir9IGh8DsxSDlr4+0wvNAPstkKtaj5Vt6YmtX3RulG3S5E
         uaSQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpj7RD4DIbZwierykwKj3ZgqeleUM/2/efJCPYrtXOXrocn/zHAeOt/zfhwbvKEvyzfpeE+MyV+cA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVYWDNqG0NWqbhNqWr4C0EdmIb5VxPLZAaav5Dyy9s0LP9AgD
	p675KimOS7+1oqmwxYKCugSuxIAaZGmlgIEgkxNo0s7gNILWFcvHHaOJ
X-Gm-Gg: AfdE7cnXw+zn1iF+kSxzaeCw83/armoHBdSZvjrNyAcQ8ezZiefFNf6f2IuYNJmS+k+
	HKEHQX01h4GVlQib/xKNNVAlTNuCMwN+av3a3eVy1I8hMPTFNjLru6gimLehRGEGPwFWZbFCOQi
	9xwH3JLeZMqQhyBe7yQx4EDvE8B0w3+M2qUBSfQCteFXReiJr4Tg+qxo2WKDeghH9MbpqrUkzRf
	W+HYH4EaACwzp7sNt3A3DYFU2d7dLJBC6+Oh3KA4LLWbyaTi0S2gomL3h3ldEGEEsJNBXadu8lW
	5wHnsUh7IqdN2R1ancad/NscxJHCWiMlUU6EVA+LCCPN4DuGp9fZcFHklsw4BmJ7MLMviLlZBIX
	kDN+0r6p5wRSu0beJkTPg0Pti+fTFgAaHO0m3/tCHWhkVn6rv4wMjrtOPRJFsdlrq5chtkFatk+
	2xk9ySOv2oX+XalNQSRqhmrjThRBw4Bai6zJgVsmZX3FKYBQRhGBb3uwKvDIEz/vSz01QPCtqUA
	1k=
X-Received: by 2002:a17:90b:510b:b0:37f:c28a:de61 with SMTP id 98e67ed59e1d1-3829eb1e24emr2191947a91.17.1783144662715;
        Fri, 03 Jul 2026 22:57:42 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:42 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:29 -0700
Subject: [PATCH 06/26] Input: maplecontrol - simplify maple_device
 retrieval in open/close
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-6-41e424964da5@gmail.com>
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

Instead of passing the dc_pad structure via platform_data to the
input device to retrieve the maple_device in open/close, store the
maple_device pointer in the input device's private data (drvdata)
and use input_get_drvdata() to retrieve it.

This allows us to remove the platform_data assignment in probe.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index c66b2614e298..9d623c9e8f22 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -62,19 +62,19 @@ static void dc_pad_callback(struct mapleq *mq)
 
 static int dc_pad_open(struct input_dev *dev)
 {
-	struct dc_pad *pad = dev_get_platdata(&dev->dev);
+	struct maple_device *mdev = input_get_drvdata(dev);
 
-	maple_getcond_callback(pad->mdev, dc_pad_callback, HZ/20,
-		MAPLE_FUNC_CONTROLLER);
+	maple_getcond_callback(mdev, dc_pad_callback, HZ / 20,
+			       MAPLE_FUNC_CONTROLLER);
 
 	return 0;
 }
 
 static void dc_pad_close(struct input_dev *dev)
 {
-	struct dc_pad *pad = dev_get_platdata(&dev->dev);
+	struct maple_device *mdev = input_get_drvdata(dev);
 
-	maple_getcond_callback(pad->mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
+	maple_getcond_callback(mdev, NULL, 0, MAPLE_FUNC_CONTROLLER);
 }
 
 /* allow the controller to be used */
@@ -112,6 +112,7 @@ static int probe_maple_controller(struct device *dev)
 	pad->mdev = mdev;
 
 	maple_set_drvdata(mdev, pad);
+	input_set_drvdata(idev, mdev);
 
 	idev->open = dc_pad_open;
 	idev->close = dc_pad_close;
@@ -130,7 +131,6 @@ static int probe_maple_controller(struct device *dev)
 	if (idev->keybit[BIT_WORD(BTN_JOYSTICK)])
 		idev->evbit[0] |= BIT_MASK(EV_KEY);
 
-	idev->dev.platform_data = pad;
 	idev->dev.parent = &mdev->dev;
 	idev->name = mdev->product_name;
 	idev->id.bustype = BUS_HOST;

-- 
2.55.0.rc0.799.gd6f94ed593-goog

