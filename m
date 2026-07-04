Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E776A3939A3
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144690; cv=none; b=hxMOA7sAbRP+ew1R6cPYFSu7o9vucd0BnROyUXDPyFtSHnyyOJhIsR28qs6iL5IiYC3t8O5VCGp2gWZizVVpt1nvsItsqttQdRWu9d5iIjLuft3HcVV2mU1XoiQS+oO9gHD8mKgLtiycEMDOf9iOw++gWz4pnj42HSKwRX0XUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144690; c=relaxed/simple;
	bh=x+qjLATprHWVETyBtguIFSzJzAIa57zeTCo+KlBh1GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vq+fOW1v4xU6y8Wdc0lLTeXmMr4WSSPp0AjMj+qmGRDxCbUKh2x51KnPTy4IYitPhPGiJgUT3UB8uHXWgfUWEs/7VLvKktSx6CYVhLdFOInghWmbiBUOF+eDcJxi06x0HLNHxd+bWE5eaHz7HY58/DAyuzci0nWoaMbjDLKZCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqUKsabw; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqUKsabw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-36b9d265355so910689a91.2
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144688; x=1783749488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LjRXENzhFdJSLRiM6d5V3++2rjRXfCmisZIqwmSzJyg=;
        b=hqUKsabwulssajAcE2+cEgHwYIE9nSin9/+Mx+zD85wAbYUVWWRN3V0unhVqiK3Lds
         QNSulPD8BsFnXyk86M8gYLWW8udBnWTTvLbCLAgZHuoksGqQR0op0/PRuiUB4A11Q5MV
         FywMe/8EHZmlpS57EtE7s013BfqjCnZBggCu8nB54mdza/D0eqbjf4DCRiBlNW4B1mpo
         GcejxH3HnLzGmqEd5LC18flJDrm13TPl0mTzi5WjOGjXvvx9jUMsmt6y9VRWDaCJwhfW
         IKiPtiglm4W/uTnVXRVrirOlROQ0Fy8zRZ8krNSSMLdG+rWEVxLpXuM5+m3kM2+OtQr5
         87hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144688; x=1783749488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LjRXENzhFdJSLRiM6d5V3++2rjRXfCmisZIqwmSzJyg=;
        b=A85P3nCHUz1OzD0w0oYzO4cLa5XclrbRKqpZQWrsfeFmbzL3HX3xPt7OeL+5hls+GI
         bKAFS9RnF4OgRj53wCPL8WMifd6r0Lj26UBjzfXgEy/f93CBWpfRgNGYkt+B/PIz1EBG
         I9uoeNijoExLpRdOpZluEDkuyVJH5YdYzZdfJdR8ARIy418wR3NhJn85EiT68w80UwQx
         IMsuz5APT8mzA6+614wFIs33f/SRCyu/9eqjQqqEF56AaFwBiRKYglHHamohYeczNTt/
         mzUzDWcCKZagUYtBrE2SbaeaPUlTgkGkLvbs8nGo6tIUvPVP7TjSV+moSTyOCPtNDKw2
         v5HA==
X-Forwarded-Encrypted: i=1; AHgh+Rp2iuBt2VMWNjLJb31KZuJjuknJnhSbAnkUMK6riquIP+uaIpA2DuxBfns8/3LrgTCWiHml+uikZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZb0mKr+NoG5WD7WubsALZdDhhAwATS95yw+4pt8rmyWQD24b
	hjmG74TACRbCNVYBUsNbGw9zSyK1tiEH+kYyHI0R5Rvya5isNmsh6mEp
X-Gm-Gg: AfdE7clFvXlIw4yyCId7nWrW+JxYudM+U+4H25v5kiLSsV/7N1HTZw1/hjYASQHRsTC
	6sYzBcojjC0vo5dpX9wq9n7l1w5P7R7YtpU/AzApS4Uo62jLPvkeMASmKs9hZjZFZIJ3kTNfHk9
	gv1QjL8EoKexo4c0W4w8y/+omtcBEaGe31/KrmYZDsqReqrzoH+ejPP9loThVwWtMQkUDuIaMMo
	9ed8BRMtnrRpOPu4u5IbsMBjy9VNhzn1nyU4FPBmX/dWvL9vbgqDgC45EVqKGWjIM6cAlrvY/J9
	p9Ygy/SNHr7ZXk2M0EMIZQkXXtHPpyjtJ/sOg+YjU5fyTHuAc5Rx4D/Y4LfgU9QPAxq7H/vlFNZ
	XiCf5pajG33Un+18VJJjKj4l8GPpz4HMVWh5DihHnu/b2vZD+Lhoqu3y8O1DCOQxkr/wyZJfs+T
	gWC2BfVTeFPfGjLqLc/h41Q8hpDWPD9y5SspMl/r3yvEarm6raL5MPwX261ZA6oFg2wXLmbxXel
	/w=
X-Received: by 2002:a17:90b:2c8e:b0:37f:464d:ea38 with SMTP id 98e67ed59e1d1-3825c50c2ccmr2400537a91.0.1783144688130;
        Fri, 03 Jul 2026 22:58:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:58:07 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:44 -0700
Subject: [PATCH 21/26] Input: maplemouse - convert to devm
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-21-41e424964da5@gmail.com>
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

This eliminates manual error handling in probe() and allows removing
the remove() callback entirely, as all cleanup is handled automatically.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/maplemouse.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/input/mouse/maplemouse.c b/drivers/input/mouse/maplemouse.c
index 03cb666d278d..7842bd46c9a1 100644
--- a/drivers/input/mouse/maplemouse.c
+++ b/drivers/input/mouse/maplemouse.c
@@ -70,17 +70,13 @@ static int probe_maple_mouse(struct maple_device *mdev)
 	struct input_dev *input_dev;
 	struct dc_mouse *mse;
 
-	mse = kzalloc_obj(*mse);
-	if (!mse) {
-		error = -ENOMEM;
-		goto fail;
-	}
-
-	input_dev = input_allocate_device();
-	if (!input_dev) {
-		error = -ENOMEM;
-		goto fail_nomem;
-	}
+	mse = devm_kzalloc(&mdev->dev, sizeof(*mse), GFP_KERNEL);
+	if (!mse)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&mdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
 
 	mse->dev = input_dev;
 	mse->mdev = mdev;
@@ -99,29 +95,14 @@ static int probe_maple_mouse(struct maple_device *mdev)
 	input_dev->id.bustype = BUS_HOST;
 	error =	input_register_device(input_dev);
 	if (error)
-		goto fail_register;
-	return error;
-
-fail_register:
-	input_free_device(input_dev);
-fail_nomem:
-	kfree(mse);
-fail:
-	return error;
-}
+		return error;
 
-static void remove_maple_mouse(struct maple_device *mdev)
-{
-	struct dc_mouse *mse = maple_get_drvdata(mdev);
-
-	input_unregister_device(mse->dev);
-	kfree(mse);
+	return 0;
 }
 
 static struct maple_driver dc_mouse_driver = {
 	.function =	MAPLE_FUNC_MOUSE,
 	.probe =	probe_maple_mouse,
-	.remove =	remove_maple_mouse,
 	.drv = {
 		.name = "Dreamcast_mouse",
 	},

-- 
2.55.0.rc0.799.gd6f94ed593-goog

