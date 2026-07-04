Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7938C2AA
	for <linux-sh@vger.kernel.org>; Sat,  4 Jul 2026 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144676; cv=none; b=mAicRwt2fEuhWpTayYQOdv3zj1zLxmXvXF3P8YRIFKNc2Mo4jdDuYnMotpjp5dKTy9As1yk4zIoNFvBDkU332gVw0/MIJD9myjqiPXf1ZoE/+oYj8ASVvjtciKHz196SkmVbUqxX/cD77x7KE6hCywtu0iA30o0kcsUGRdYVZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144676; c=relaxed/simple;
	bh=ESZdrdZ2pFZrru/54YpCHZhmVY/KZxg+461Ix4csKsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4JUAZ40Ix7jXY+iZ+Req3zE3+VG7GOYD52z3BawqLTCVNsxoB7h1+g40QxbVLKdLxl9ttSBaMnncHW4X+80nR+9InasyKab4PELLEib8hoMi5TGSzv4S/PoPlU69OWJ/0+kxggh8cTnuHorSLKtTaGbmRkMmMwcSWXb6Ma29pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTaH370n; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTaH370n"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1004117b3a.3
        for <linux-sh@vger.kernel.org>; Fri, 03 Jul 2026 22:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783144673; x=1783749473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07j3He9KyvXqEqK2ACGmojqTsdGGsyBD8B2ZxOHnjt8=;
        b=lTaH370n3BCEDWiDxsyQ7R8kxVpqdPPlFQobwI6tGhtOATyCHt9TKi3SkFkW2Dup6J
         SiByt8qIywKzyrdfjXk89GEhOu4dIfaQ480nff3L9NmoDG0uYFhWbOUzbphN2my+e33L
         FUjERcPLky8Mxqz2rBNq3nyMVe55mGCbWAnVz+S86QvB75OPxm9O97H4NaY1BGpHHFgI
         Ufogt/k7Syi2QcfMk9XtLyu2dU486YwT9uw0JAoBvX8bJC/f56ENq0pY68BibQYHzRx5
         6wLW9++jfkZbntOLrx6lBdH406WtwaLfTUsZmPgRvVGaG0Iy9z4b3CeGZMfCgnmaT7kg
         Ff3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783144673; x=1783749473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=07j3He9KyvXqEqK2ACGmojqTsdGGsyBD8B2ZxOHnjt8=;
        b=mTFyWeInihGpZJHWV1Xf7lQYBicfg8ZX2aTmFXlpb71qsUtLoLJr+dDcGxG4GvFFJx
         qnXh/heDGk9SHKAYLN0SzG2IG6ne4GigCOMwEnuhDz6tjLlxjlSRni0s7HTCuasfgilk
         KtPOblh+bNmbelGKoDYZr3tDG3U4phu3Ld5qFSaoZA+DieUvO1pCgzv136Wqiw1F4/y5
         bV/iuN5lT5Qjzk4AIqWRVoE3N1NI/AaUk57BbQ7I1ns8el6ee2QCA4LPf9773Bvzv3e6
         CsOgcEeB+D/aggzmvpOq8CboA90gEecnGjHgHjFylr8DKwGs8fOvMs2zWDXO4qyP071a
         Setg==
X-Forwarded-Encrypted: i=1; AFNElJ9vwLjOo2Jpg0coUYhnW42j/UYeb+nEAR5Ks4S5ZnkagHbfmwmll/VBMkjfQmVnxCCfZq9TXNKGSg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zSwGluWHfnETI6YCqw0HrpaydTkk8V7d/p7oVPk3PWpnxTdc
	hzgUXr4STe/b6zER5JyQVe9p+H4Hn/Z2Sl731e0PkRVod5qWiOjCCClu
X-Gm-Gg: AfdE7ckvVpLFnWtYu8PyYHrwYIKCWI0AtbedgnECd0PDxtTV/XFk5kps9zsDV8KwnHO
	mKh6c2Rjf3+ploT9GULj0QhwGieIUtXV2oQZ7H0YOaFtBkk5MVA1zeTGzs8UTDnwkpdWTOaA9P4
	O5P6Nk7+wRDwmManbZlBT3iKrBu25ay58/L7fF4kuf54DMeyeb1GYYaN4oy440qCBFVqowLKFCv
	TDG9zY8xVQ1KHkyh0RJV+0Byyfqlilc67hm1pQMUmSxRb/UQvpKbjn6gq6IEuUUz0M/DgKoEc85
	xFDi3I7cvShCnmh8Vfm9bdZqFV+quYvhoHDvnlA71iT3VX3/9mGx15+b2P8yEw+80icnzHmRHnB
	KbHgMipGHAL9pYXZxUE8gBmZpGCf4od4J22RSKWVB2h2PyPgAebaP6TF6BqWtLTIW2ck7/xZAhf
	JHiSO+/o/eVcsv/BhPca5ywh5YNerYFAeIf5Q325+LyjYSGKMc0U9iSMc+UDXWESZ+ID25DCZng
	Cg=
X-Received: by 2002:a05:6a21:2d42:b0:3bf:6c08:fb87 with SMTP id adf61e73a8af0-3c03e51b48emr2391065637.55.1783144672651;
        Fri, 03 Jul 2026 22:57:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:880:86f9:3b00:6746])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm26262412eec.8.2026.07.03.22.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 22:57:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 03 Jul 2026 22:57:35 -0700
Subject: [PATCH 12/26] Input: maplecontrol - remove unused mdev->driver
 assignment
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-b4-maple-cleanup-v1-12-41e424964da5@gmail.com>
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
mdrv variable in probe_maple_controller.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 79cec89ad52a..955e01bcfa0c 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -95,7 +95,6 @@ static int probe_maple_controller(struct device *dev)
 	};
 
 	struct maple_device *mdev = to_maple_dev(dev);
-	struct maple_driver *mdrv = to_maple_driver(dev->driver);
 	int i, error;
 	struct dc_pad *pad;
 	struct input_dev *idev;
@@ -138,9 +137,6 @@ static int probe_maple_controller(struct device *dev)
 	error = input_register_device(idev);
 	if (error)
 		goto fail;
-
-	mdev->driver = mdrv;
-
 	return 0;
 
 fail:

-- 
2.55.0.rc0.799.gd6f94ed593-goog

