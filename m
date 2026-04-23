Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDC336885
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975664; cv=none; b=XVTe5JiTPDAK05JhckQ8yZONlc/dRmQNLnjVwr7pVem7UracuLYkQFKOpgvPPJlTv95pRO0DybAEf/701O9KB4YgZ2tn+NTzbUgIlu04YprzVERMulfS+4zjHT9O3t5r/SHMo49amOt1gBmK+D42t7qjQHIKzFzvUnQ0KbZkeWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975664; c=relaxed/simple;
	bh=clRQBLZLyMkNToXv7TBsJc8dayp8m4uA7BFHlQ2ixJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjaQ52Bgg+SWJKsPp/gs4RNTV4FeV4VHEVbaYuPK4fX+vLVE3qasrUu9TIL1n8t1ay1zak6nq2kCqKCHWKxH/DgUjnY1hYU0Qh/v4n6wLKJLNEjidpn2KSeBu7iCsIKgvoPhHFpFDYiCLXjsQYGwhAKAdPHcfuUzgVWgkUPqtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/3/lFXC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/3/lFXC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso97405165e9.3
        for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776975662; x=1777580462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhO7XdLlo3g+fXfBF98bZHpoFBDk4f+SfNDZuUrfUlU=;
        b=G/3/lFXCR4JwEc/wvlZT2m9waU/OfRWVfUzz9jKKC5Gs6IcgR83TvYR9HVfj4jBxsy
         C/G+I/kAIKu92ViVeFhJcV28e8R+RYuCD7mXC/EOM8gW6kL0A6sb4xUmq+4e5o63onBy
         kBqheUrTltFzMHdIO0zXlJKSC+z+sYjQLjYnwZxW07uVj5uC4Z5N61cH98llZb2t6Ld4
         4KoIkQybgEeG1kxAi6MiSaIa1GTnlxUyNHy0OnOhRfonS2Wh/riWNEB3aq3CsPQyiQrd
         hS8aMR2j0cgo+40h9SVN4sCzWHejhF1ct+MgMkJErEyg4mK1/vyL82pX9htRWZlaf+2k
         iQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975662; x=1777580462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FhO7XdLlo3g+fXfBF98bZHpoFBDk4f+SfNDZuUrfUlU=;
        b=SbgK8zRzsjX02EBDSlht2BXBrRwy8sNRRjo26Jhb9uxnSJ+vIn0CbepBOVkjGtr1+b
         i31rafgkQlMQ0h3MFRGsmBXpNxhG4KVeB2uritzfVZPiQpMvsJii7oHyVpLKLZbGplum
         xFHgbyL9DHfbDXDNFRzQX48MXit5e8XpQrVlux31Gv4mzRY9mNtrZ04Aj3vwdkbnJP6U
         4oE1ZgMseXcXmNdzhT5dKAILv0nM8e67h0aM8ftzFrtyaVmH2BgyTrLkFLIaKCcWEzH1
         jyK/98j/TDEwslM05Ou9piwhuSUCM31wTx3M8NS/cFt59cuPEOAb6y7e9asJCGJ8kbt2
         rHAw==
X-Gm-Message-State: AOJu0YyqvG6SNMzwLl3twntqFKbj8T5UvDa4qvIKj0UNGwEmilr4Tv7G
	VBXtC6Tv5psYyUC3GbhQoqeWq30h882Oqg/GSSWy2gki94+vVU1Xh7vi0+DQOr0=
X-Gm-Gg: AeBDiesQfPFez2kkcJGBvoDENFycmAY3PhhBblbiA5nb7tt6C0zmvXtv9kYFAGGHf3+
	1/Fe85HOtW+nj7kz+QLwPT8PfkexZDgxrHLCg0HFvFM7f93RjbVirolTxkQJ0llTdbxNwx1RUYg
	nZ2LJ3WIN0qYnBdq2BamYMN/DtNSb5y3raiM0c2xpIrqgVer/jbyTNche/LVQMEmup+5hWsP4yh
	lK1FsQ+0CYk9dR2PgXtcAF0MmnJbxID+APWdBBlKOSnVYugKvhUF7uvdwx8ndP3nXmuvYi3KT71
	2UAsNU6fvn7VhrYn+//93WbqyBatfGZ8TCIMwPSkdHUw/5nZC8wUEXMQVf90dTJy3coSxVscabJ
	VpY/B0vFY5kb/nmabdCVnSCIyjmGfmvg5u9F14dARvHlbwTAs7QECy3upkcTLYSnOzxax9sDO/+
	jfo68Pk0G8nzCmodOue53rVuCOHouRpghBJLIxTkVzNO50yAuVFdE/mhQjFrBcaVT1QnoYqwLNJ
	40kjMQiswmQoPSI
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id 5b1f17b1804b1-4891d23468bmr266800665e9.5.1776975661257;
        Thu, 23 Apr 2026 13:21:01 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb97:cfb5:53a1:28])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4891bb3d121sm529336555e9.14.2026.04.23.13.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 13:21:00 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v3 2/3] cdrom: gdrom: update gendisk capacity on open
Date: Thu, 23 Apr 2026 21:41:31 +0200
Message-ID: <20260423194132.693271-3-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423194132.693271-1-fuchsfl@gmail.com>
References: <20260423194132.693271-1-fuchsfl@gmail.com>
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
v2->v3: Also add quirk to handle proprietary GDROMs, using the same
        mechanic like in gdrom_get_last_session() try session 1 first
	for GDROM, then session 0 for CDROMs. Dropped Acked-By due to
	code change.
v1->v2: no change for gdrom_update_capacity(), but for
        gdrom_bdops_open(): handle the failure case when
        gdrom_update_capacity() fails but previous cdrom_open() succeeded,
        to cleanup the successful cdrom_open() with cdrom_release()

v2: https://lore.kernel.org/linux-sh/20260419162823.2829286-3-fuchsfl@gmail.com/
v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-3-fuchsfl@gmail.com/

 drivers/cdrom/gdrom.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 094d55b2d004..1e73617b39ac 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -474,6 +474,27 @@ static const struct cdrom_device_ops gdrom_ops = {
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
+	ret = gdrom_readtoc_cmd(gd.toc, 1);
+	if (ret)
+		ret = gdrom_readtoc_cmd(gd.toc, 0);
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
@@ -482,6 +503,12 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 
 	mutex_lock(&gdrom_mutex);
 	ret = cdrom_open(gd.cd_info, mode);
+	if (ret)
+		goto out;
+	ret = gdrom_update_capacity();
+	if (ret)
+		cdrom_release(gd.cd_info);
+out:
 	mutex_unlock(&gdrom_mutex);
 	return ret;
 }
-- 
2.43.0

