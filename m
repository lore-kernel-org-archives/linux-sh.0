Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF453F86E1
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104836; cv=none; b=ZGmFb+OY5Je7w+zZRYzoPa3uT4Ggwdb6+3t6Ksc6mL3U22FB+EGLNLQcZOpSARixTK8Rw/dNAnh4kwvKclOe4o2j+Aq1Pb0EbToGm+shrjpSwN2gfEPRktnizhnZ+QOzMuRKjvzOJTY728Bf/Q4PKi3nTNfn1nPgt0zZ7sPN+UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104836; c=relaxed/simple;
	bh=1GKxGECc+cPoJ1DVleU9/qymiUPEf3nJCKu1WV+4Q5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYWLjjalxxRZV5jtgFW/viITL2YxVSch7f44v0gl44+SV+bPGBL/Bl7hjPaCtn9CU6sor4ayguHpVm0tyq+BSSWet3pwDuo7YmS5NGMNPAz7EzfC5Dq/JWzYac9lmIomTB4Q09CTDFaUaVgkVLOdolthGDP94NfTWpOsi18jnMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7ic0r9A; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7ic0r9A"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso24869095e9.3
        for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 04:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779104833; x=1779709633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezhWSslS+RucQI+0tAHxOGAEb51o6QdhaggvM2yWnxk=;
        b=h7ic0r9ASC0r1avqvot7zv7rlYcs9qDWIm6KxIcdRGqncy3/dmuY/MPlT+zWJrHcMM
         dPQI3pYQpmBVKtPHZMyGGnwp/O6XPbz0uQYWVgKA/MYK/eZAttWBoaGX3dnff67WdMlA
         ZbcD1pfv8hnZjDm2sp8Ywi51sjznizFk9RqidOm/fcxYEoGjzbZHuWQ90DPkQ4m/Sprz
         sgeHp8ys+dnB45+AHSLuGQaCBi4GSxHZ8rgHfNtLEiewzOrvP61pQ3bruo2QxxBbh+Bh
         mNLpmJEGWVJM0B61NDh7cU8m3PePQi7IYUqdL4scQqIRYk720KwWV7HkI4HwjMkjoXve
         o+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104833; x=1779709633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ezhWSslS+RucQI+0tAHxOGAEb51o6QdhaggvM2yWnxk=;
        b=Ufy6+G9/jXUDMND5XaFUEfVoU4NfZJO/hFufeErwE0uwKLkCP4scseB/fm7vs2cOK3
         7Rz7eg7bwghG9JMwGnAS2YbL/LYEHsaOfkMgEYCupkEMKlUk5HdwCzGO+fI/U5ghNRST
         8Q2Jm/sxEvgtjPJ2r9qSIpO+6ghsn56k+srLSgFFungJSJYgxSY6gNAzR2xgODrCr5Vb
         CsZ3rbqAhT4Oc4GPSK92z7aH5zOnaZKNpzTYOunSztD9f8wxhGG0aS9kjktxNBIqAYsa
         8xwltF7wcPf7hPaqXugMVoiMftwfL1NY6UD3JpTl43AE1wO8KTfSjmCffKNG9+UmCYEL
         HCkg==
X-Gm-Message-State: AOJu0Ywpc6KkZRgwEQyJEvpwHqwsLHCZZOxM3Qze/3V8CLofqYjTRkhu
	PZojrv00ldWI0atV5nOfHe93oFwAAP1pZYnJC3lvhUQG3Na6C7tj5ZSTJmYAYi4=
X-Gm-Gg: Acq92OE6rdqMoCDJaWJ0mDhtDVTc9QG+enW6RuylxyEoUjKFlZeV1ezqfOPnqgkz3PR
	tKlwzf5oEAMu+cuu0VjLq+pPhPiwtMxIYjyIb6PfxKcvdvqB5zg8i6FF42jNLoeDPM1/mIrH/3l
	xbQmRUiNOOVfKcbvlgR/jrfsHeq9SmRrbbm6Zvm2YeEcmFT86S3ADm/RtJ0+QqXi8bhDQXQ7tEQ
	+fk4aJOoZPG/rwkP+R5Bo5OhI+Geq9BP0cVhnN1hvj7sQ24PUbdfvh3yA/o7Ii3G2LVE58Vf0E0
	QT0A8F7bXtI9AqTElxuye2bPqS9URXIiPuhbxzdfsVjAoG2RPsiD5N85d7w5SiH9yOSYn7gtg2f
	0hJUwlU5lHCzEfIl6TVI1LkACej4D9bin8TozUqFMYXIKoPt8aHPmHa0ukq3vi0buk2oUIgU62Q
	5XGshB3Yg4dzFASNf6lrEt1e5HOdiQCsRhAZGxQ/8G/GLkruOGs5MVMlLyxhPh0biD6dJZWhBVH
	kXqmsOG
X-Received: by 2002:a05:600c:4e87:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-48fe60e142emr233996405e9.5.1779104832846;
        Mon, 18 May 2026 04:47:12 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:f15c:fd38:3fe1:9653])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe53ab671sm250281165e9.1.2026.05.18.04.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 04:47:12 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrian@newgolddream.dyndns.info>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 3/3] mtd: maps: vmu-flash: fix NULL pointer dereference in initialization
Date: Mon, 18 May 2026 13:45:21 +0200
Message-ID: <20260518114521.81564-4-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518114521.81564-1-fuchsfl@gmail.com>
References: <20260518114521.81564-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mtd_info contains a struct device, which must be linked to its
parent. Without this, the initialization of the MTD fails with a NULL
pointer dereference.

Fixes: 47a72688fae7 ("mtd: flash mapping support for Dreamcast VMU.")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v2->v3: no functional change, added Fixes, Cc tag according to feedback
v1->v2: no functional change

v2: https://lore.kernel.org/lkml/20260427114750.2480900-4-fuchsfl@gmail.com/
v1: https://lore.kernel.org/lkml/20251117224408.498449-4-fuchsfl@gmail.com/

 drivers/mtd/maps/vmu-flash.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index b76d0609d1b7..10244e6731d0 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -547,6 +547,7 @@ static void vmu_queryblocks(struct mapleq *mq)
 	mpart->partition = card->partition;
 	mtd_cur->priv = mpart;
 	mtd_cur->owner = THIS_MODULE;
+	mtd_cur->dev.parent = &mdev->dev;
 
 	pcache = kzalloc_obj(struct vmu_cache);
 	if (!pcache)
-- 
2.43.0

