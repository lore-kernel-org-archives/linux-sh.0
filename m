Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E639A04D
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290683; cv=none; b=ryo/OxLRQNEcsTEZnovcn/ej0TYgbaqqp0S08KOGpjFhWq8ymp6BB6hpNk0mvvGo8XvJj63/FZnBjvK8/3zQRTM+OSAw6cbXWoyx8JQn8wkRHoPUYfCZQfzxwAcgOcswJo6wcJ4rb0uRrqRgv+jouV4RSSIf2NG3y8D1ehMLrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290683; c=relaxed/simple;
	bh=gpzLr2lo8G2SJGjZeQZIhgXOcmwkp6/J0e/SaU4sf2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FV8rAMHR8bFCYUWfu5rj58KtvJjudWFmjt+rmrdrSR4JAMFbC7pM9HqDunEpbq8BEScfXsyWgU5GtEhNDQJgi5afyHjIVg8R0jhQU4Ay3AToNk9NjuXlvb19c14DA9tMFEWAvXS35gGqyEfnRXVo+Ki2iTwegvs22k1MmWfEs/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po1DVtkI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po1DVtkI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d64313c39so7954900f8f.3
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777290678; x=1777895478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+Y2aORcPSf7njE0+UeLtYLV0kJ/K7uIhbGCNhCftsw=;
        b=Po1DVtkIZRMyDL7LpYTDWveRO2t/Rkml35WQkG0BJfaLGEQqHuFskOhJmlAnADJV7B
         ZZ9Cz0Et9LMfHDy7wWodQ3kgeBWPEdlE7a0HQUWSxU5TRZJTxLpzk4hsMBE0L69f2ocR
         01yF7Yo5cCIg0wq5UvGb9JUbFj5RSFffS/1PoJrfKqoHvrnxmIpuaP8yZIZQDOjUKMAN
         Bich3290BMRXEdOBpW9NoZrHtIKf8TLHukG98efur2R62OMQh2iXs5PucsiItiGgS0Cf
         j9fjTB22nRrDpuAtpdkSvs6JXr1BA4HtzS9vRUCYD3yrz3PbVq5tMwPay2fz7douIbz7
         M2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290678; x=1777895478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+Y2aORcPSf7njE0+UeLtYLV0kJ/K7uIhbGCNhCftsw=;
        b=X8BHeCdpCyMDE4X9rAGelXuQy++ThvHgcxdnUQaB7PCsNYDzM9U79KddWrhwSQZ/KS
         zvYVeVDIORo/OSN65LDRiyvXj6Xxjq3pZ6Z3SKsLsAjlZWiN1k8oHKYA3cdJ2rlFkXPs
         JZWwtq1Y4THOqODw5WgCpNA3bn4B4GcTDByHdl1PWjkzqRhlB4s1LJXuNklpF2wNFpTx
         wOhOaEdTZRHaGWKm1MME/zO38tAOVtUBNRT9YwSBthtUDsXV66muNeHnlfgGaH7fMh5F
         v/F5K7dsG7nWDs0CrQLRtoBwcHKJt3pYm29bssNjMSNnOaaRI13BvwuTQzjJbICsIm6I
         Pusg==
X-Gm-Message-State: AOJu0YzgqeaGaK19TaBnczqcHlViwH96KHa8tmt2raYf9bq8uKuiew0r
	S09eEAyxXsvfO6UCjYnw4XTr7y7o/YA39oagucids7fD9OwfgHRZksxKeuvlwJI=
X-Gm-Gg: AeBDiesePEorAd/AXGrXFhNJLUZrj4EfQNbWDikeE3WSW5W40HrU8gbTo04Q00YHWt8
	5jm6A8wNagSGlUbqS4tCgn+cLUpVwzezYkahh1GohSwfbvhv1LzY+gWLO5DHv2KefbwGCpSU54s
	CWUyAsAUJBL+xsVIz1k2JWc9WcUujDQ42/B3L/quOez5wCOLKkHsFxlc50PT6voHznJ4uo4IDJg
	aI4YKxs1FHxP8grk0IXA+fE6PG4WQzG7UTeJ0dKBVzM8V5v+zgsTvjtjpkSIlzzxxIuKF/9uGVu
	EqtVM4jy6GVvDpYdWBh8Vo1rwgrkoKZhBy50AUZGLxYESOXqhDiBxMexE7L3imvui/e7cXjYmlE
	8FtkwP1jQpaffJIopsC9BqnBjOUOnRKQpzx7gPcI7u7dz/CtYJIlXo06naZBB2vMnfiVSBWrBZI
	M072helhcXvkuU4Qxv3cq5h+Vr505DexWr37FZzkwU9W5C4BsOqV+zIS6rzHx4vfJQ4X8fn3jbB
	NICQ7SoH6TC8wCA6rCTSO174uJTsQ==
X-Received: by 2002:a05:6000:2dc4:b0:441:37b5:fc04 with SMTP id ffacd0b85a97d-44137b5fc4amr15581103f8f.14.1777290677589;
        Mon, 27 Apr 2026 04:51:17 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:3c87:b0bc:8c35:1ba0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4412150a071sm43651490f8f.21.2026.04.27.04.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 04:51:17 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 2/3] mtd: maps: vmu-flash: fix fault in unaligned fixup
Date: Mon, 27 Apr 2026 13:47:49 +0200
Message-ID: <20260427114750.2480900-3-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427114750.2480900-1-fuchsfl@gmail.com>
References: <20260427114750.2480900-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kzalloc_obj() / kzalloc_objs() to allocate the memcard structs,
instead of kmalloc_obj() / kmalloc_objs() to prevent access to
uninitialized data.

Fixes runtime error: Fault in unaligned fixup: 0000 [#1] at
mtd_get_fact_prot_info.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v1->v2: no functional change, just rebased.

v1: https://lore.kernel.org/lkml/20251117224408.498449-3-fuchsfl@gmail.com/

 drivers/mtd/maps/vmu-flash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 75e06d249ce9..b76d0609d1b7 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -609,7 +609,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kmalloc_obj(struct memcard);
+	card = kzalloc_obj(struct memcard);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -627,13 +627,13 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kmalloc_objs(struct vmupart, card->partitions);
+	card->parts = kzalloc_objs(struct vmupart, card->partitions);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kmalloc_objs(struct mtd_info, card->partitions);
+	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;
-- 
2.43.0

