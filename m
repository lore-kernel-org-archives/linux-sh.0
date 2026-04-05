Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026A40DFAD
	for <linux-sh@vger.kernel.org>; Sun,  5 Apr 2026 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775377423; cv=none; b=jxrOH2ziwbs0rA7Llixi0TxCLwiLt7qoM4UalQEV0H5et8UddB/f1t/tz6E/v1qOC/9U9/iGoQ6Nf9y8x1FZS6QUXCzVldevrUzAORH2aKSX/bmvHcZfohgEiZiFdnpxPIFFmoS/HD17tSLJhx33+0uIrEnRr+DUft0pdTjLZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775377423; c=relaxed/simple;
	bh=CndNBHs65/Oko/6eA4m0yCdiX9aMzha3rwQSngz79G0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X3Gdpnu9guIRITL04/ytQ6vmnj3BNSS73HKp23DHfhWsUgGb5IMaRO/b/f5ZGDxZVzLIIB3sk/RXGMY/b4/w+c40VZaww27w+vP5dfRGKvROEdqAMqAKesceP8hWSkbnU15F2FZijuC/T++JrUzXCP2Hss0kRGPobhz76xxGr+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDEhRGsU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDEhRGsU"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso1940200f8f.1
        for <linux-sh@vger.kernel.org>; Sun, 05 Apr 2026 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775377420; x=1775982220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ivdw88sKwAITBaCSqptSbAgLAv66q7tzyfMWmFGYTXA=;
        b=MDEhRGsUs9Mph6z7/XaZONQkeD/FGY+9TRyIIbgvgrr5b8YQ4V7ql0RfHifk9Re28s
         KJT9xThFjQ/naMSix1QzZFRN7qbN1GsYgBhV913XJMmiDmiwhpl06qRubE2WdGJ5O233
         Dy/F7Rr6cw5fQ0Mz5R/6XeCX1U+RsIoYjO8dBy9jhabM69C/wAtPeg/Cwkvzl6KTLdZz
         ajx2NTIjJVB+9Z9iugKwXCLxrY7/YicOSHQ6BuWvozqkWYaREbcjUyXjTdDEzeVGVV01
         57UzNU2zAQldMelPOYAJiuTZOXuAZp3KDoirDQzl9JSdkBenRf87XXkbYPXDoiLIq6Yt
         nPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775377420; x=1775982220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ivdw88sKwAITBaCSqptSbAgLAv66q7tzyfMWmFGYTXA=;
        b=Hm2MBHm+bYMd9xj72JVEYtB7esw2qu6zZ1N0H6TnZgZSqN8bJ2GrHSkugSmf9Q5OY6
         9Bku4Gj6ORwTb3LQVftD/BIe3U5wC/CIbZX7Z6quHxXJFAjRXSEamK62hXdXPv3OPKSK
         tcZqTHowZYIH1dk1NfsT/SyniHvgNLqkWRGkkjfOdj00nVFDy3DByqHT02KZF/P1LxXk
         nAXcd8g8G072MhseJbOH//ua4A13iw8EEVs/y3zboOhaRh/qoWPcHtpP4aipacu5QTf1
         AgRF0S5eS+PFFCGNTwfuR2tqOD7AN6EJD123MI6I4o0jU6hvesxY33UJMHiu5+GcgmUI
         JgeQ==
X-Gm-Message-State: AOJu0YypGerztUlMsIylf98mC9KFEonpTYEcHybi4jMfwv19fjkAzoln
	nTwj4X7lFSZl7o7HVfU2nVqZb6/9lmOqUFuQdnN/OE3Ox1I7FkvpPQEsfMHpIIY=
X-Gm-Gg: AeBDieuKiBfa43oMx4ibxavgRm2La7A/pENSbWFlGJjud+kqADi/RmiV2qw8BYlKmDk
	+RS2SjO5PTuvZMnJ9xMv2YzafChd2XeMqIgKdIerhEv85c2Y9v3LwEMYgzpUbw6MoaWQ17FlKKO
	MibYrIteIjdwCObmDo8aklqI+8W/DPoKMkicFc7DF6tIMpEsbL3YSRBCLZfkT+3gh9NXdtE32am
	ZTITI7KokxwAvazeDKAE+DiahJgp3ZzsxlRwqxTVVkJgkYllRidpAWvrRv1auDxSGcG6IMCIruS
	ZZYos2/LNxyVdAUzMoyjeqjJcm78IfOFrwCHUn9Pq00+tQB+bgMT1Z4p6K7BKaQ9TRlsM9fiPQl
	KQG5EbrZJWXLmBH22USq1mwQGRJ7CQmAujYApZFChM121zLvnSrq2LXR4tE89zamlY4q8/z38T/
	fR2QuXAwgnPqrMVQIlYwJGkVEFmoNeOrxXPJ1PIxN5NQnnpE/5+T809UdydfDQu1lYOz+qsiB/k
	AbcXtQy
X-Received: by 2002:a05:6000:208a:b0:43b:492c:8345 with SMTP id ffacd0b85a97d-43d2927f4bfmr11419777f8f.10.1775377420033;
        Sun, 05 Apr 2026 01:23:40 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:4382:4d9a:caac:a8d9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43d1e2a7223sm27615483f8f.5.2026.04.05.01.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 01:23:39 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH 2/2] cdrom: gdrom: update gendisk capacity on open
Date: Sun,  5 Apr 2026 10:23:30 +0200
Message-ID: <20260405082330.4104672-3-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405082330.4104672-1-fuchsfl@gmail.com>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the gendisk capacity of the media. Without the capacity, the block
reads fail before reaching the request queue, which prevented ISO9660
mounts. Refresh the capacity from the TOC leadout in gdrom_bdops_open()
so it checks the inserted media.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
 drivers/cdrom/gdrom.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index dccf41fa5d0a..854a511e3466 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -484,6 +484,25 @@ static const struct cdrom_device_ops gdrom_ops = {
 				  CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R,
 };
 
+static int gdrom_update_capacity(void)
+{
+	sector_t cap;
+	int ret;
+
+	if (gdrom_drivestatus(gd.cd_info, CDSL_CURRENT) != CDS_DISC_OK) {
+		set_capacity(gd.disk, 0);
+		return -ENOMEDIUM;
+	}
+	ret = gdrom_readtoc_cmd(gd.toc, 0);
+	if (ret) {
+		set_capacity(gd.disk, 0);
+		return ret;
+	}
+	cap = (sector_t)get_entry_lba(gd.toc->leadout) * GD_TO_BLK;
+	set_capacity(gd.disk, cap);
+	return 0;
+}
+
 static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int ret;
@@ -492,6 +511,8 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 
 	mutex_lock(&gdrom_mutex);
 	ret = cdrom_open(gd.cd_info, mode);
+	if (!ret)
+		ret = gdrom_update_capacity();
 	mutex_unlock(&gdrom_mutex);
 	return ret;
 }
-- 
2.43.0

