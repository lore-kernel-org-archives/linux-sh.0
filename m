Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADC430C174
	for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 19:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874739; cv=none; b=Tkv3okkn7JHSYbRESOPTnqCHpvUQIANVaXXn5P0cp+JocIpbpiRSfoiRdWOylH45limhjiV1Jpc5XnjR+EMJogX/bCRYrPxYbTGId8T8x8914PpHPQ8pxpSi73G3dk/IzcKqQbPQeFQYxKrq7CKd/6wJMO3TXxms8xqWsT6zeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874739; c=relaxed/simple;
	bh=xCVWl4uwmNXrwVsWzgyfOd7sqqVawCo0Cx+xJ/XQPvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPM+fdBPStWN1SpXQfe/AAT7+JabOUiVBI4mRGTxW60BEKtLTpojKDZLYjl16qHpWJmGwe/B7wBAM6oLzZwzbmq4i40BLk5P5OAavNGFA2jnb6XKXI7bYGoyH3ZmPJe2MY0CU29CvACsGJZjl0wwA6acM1I7czv/QZnXnJc+ZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsaLMlD0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsaLMlD0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ad135063so1518765e9.0
        for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 12:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874737; x=1779479537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJLq1riXpJimDOMmlqmNgk87J2NmQiv1+kjxBSblf3k=;
        b=bsaLMlD00/1vbEGMMn2r6WNae57WkBN2CmwzpAZiEw3TVOx3iZB0GjpLhh/IxN4Wkt
         OMOP4dAPRruUgkmIh3RNhE38UsS/4JIUr39CAiDpdk4B4b00ZGTREOrL8OX5yKALJWT9
         TaL7KCg3v5d2kWN4t9QlagO02lR38fvhXU9HYVGWMbPPwVuNwNlAyqjaSj6aoRkMkY/B
         zjHS+bvoTWVCnGVdiD2gyE4TqoeGpZARKBy8Y6+dngSY3IY3pynUizFYs5m5cdCnCFIA
         y1y38ey0WmsEYSKMiCQdVGh3CsAw+3scFI7qCS2vpNUK5rh7RUngMnr3m9AWdZfGE/b7
         iZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874737; x=1779479537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MJLq1riXpJimDOMmlqmNgk87J2NmQiv1+kjxBSblf3k=;
        b=PGwLn+rNfwKzwHbgd/fAXhGayQ4pZCYfoN/ghaUN4PfjOimEuJm7m2Nhf5b3WJg+jD
         jDt+1grtPNxvpXDKfNpkESCz81pa39rynIHA+iRsnIBDVTXQydYZKaqwcZ/es5T6jxVI
         fAGnGSaCJOKy+fQ6ypUyRJu8KwDobYguFpp6iQ3mFG1NEDYvpoo7nzcg75TxVYrJfDB+
         leg8jtici2D6YU7H4bSifDBinZ0GCR8mfsUdWBClMSLq19Q7mm+1ch1kQamEfr3oF9A0
         lYjZXEuvincQ+bmDieEcieMw14NY1hJeZ1wrv+w6UsplK7RvEvmWEJI/EdfdtPD5DrTX
         Afyw==
X-Gm-Message-State: AOJu0Yw2Srct3AeX6eLlAuydoMCSuW00Uf5jKUKUdW5GyYZCfx+8LStg
	TYmh5PZ3DIBLhhpVCd2qb9j/+pgukFq945H5B/9PTPGwwplarP0spjROcrYijro=
X-Gm-Gg: Acq92OGwm0LySimzvqbER6SCFHHHn6yxCGQoA/g3+OyNs7sEFg0U7/25Q0p0cQOyXsh
	wcI41nZ6ESu+L5eRmXlbc2eDp17NMoi2MpiXiz3LdY8efii5KeTKDblfnBL/XnuTywWPvZtfZYM
	GCZfz9s8r6DMBtWm4jAsb/t2hhYWs/Q6EZY/yl4CLB4xRODp+zq8ig0JUmfGSpwI9Hm56YN8+yC
	RPrZLSnzhlup1dlq5BKS7TLJVJUDNnJzCXCYsgoGgbbiyud0tgtUE3LopgS7/dTa8syJcfzVifV
	wACos/Q0cvWHI8rWhpHSrwHzwq6U6uYnRFTynlrtNb+fYyjktOBXvU7LQHH6cNYK/g17oRTBFer
	zb8l8PR8RoJjmbJ8I93QyHA8g803Y5CPD02G+HMtTTJg+r4CTtXBSpiX+3bhDxD1EDRSK/8IKH0
	6xfrHa+xjOINnOlXS5SU7HHQiHOjclDwwwzzR5gUAqorvqHFu1x7S/m6935+1ZHvdZ+d6JjqbNA
	pqc/4A=
X-Received: by 2002:a05:600c:1389:b0:48f:de4e:882b with SMTP id 5b1f17b1804b1-48fe60e524dmr74554545e9.6.1778874736500;
        Fri, 15 May 2026 12:52:16 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb24:41ce:1d7:fad9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48febf81970sm29065065e9.8.2026.05.15.12.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 12:52:16 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH v4 2/3] cdrom: gdrom: update gendisk capacity on open
Date: Fri, 15 May 2026 21:51:10 +0200
Message-ID: <20260515195111.3295031-3-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515195111.3295031-1-fuchsfl@gmail.com>
References: <20260515195111.3295031-1-fuchsfl@gmail.com>
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

Acked-by: Artur Rojek <contact@artur-rojek.eu>
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
v3->v4: Simplify condition in gdrom_update_capacity() according to
	review feedback
v2->v3: Also add quirk to handle proprietary GDROMs, using the same
        mechanic like in gdrom_get_last_session() try session 1 first
        for GDROM, then session 0 for CDROMs. Dropped Acked-By due to
        code change.
v1->v2: no change for gdrom_update_capacity(), but for
        gdrom_bdops_open(): handle the failure case when
        gdrom_update_capacity() fails but previous cdrom_open() succeeded,
        to cleanup the successful cdrom_open() with cdrom_release()

v3: https://lore.kernel.org/linux-sh/20260423194132.693271-3-fuchsfl@gmail.com/
v2: https://lore.kernel.org/linux-sh/20260419162823.2829286-3-fuchsfl@gmail.com/
v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-3-fuchsfl@gmail.com/

 drivers/cdrom/gdrom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 094d55b2d004..603429756a34 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -474,6 +474,23 @@ static const struct cdrom_device_ops gdrom_ops = {
 				  CDC_RESET | CDC_DRIVE_STATUS | CDC_CD_R,
 };
 
+static int gdrom_update_capacity(void)
+{
+	sector_t cap;
+
+	if (gdrom_drivestatus(gd.cd_info, CDSL_CURRENT) != CDS_DISC_OK) {
+		set_capacity(gd.disk, 0);
+		return -ENOMEDIUM;
+	}
+	if (gdrom_readtoc_cmd(gd.toc, 1) && gdrom_readtoc_cmd(gd.toc, 0)) {
+		set_capacity(gd.disk, 0);
+		return -EINVAL;
+	}
+	cap = (sector_t)get_entry_lba(gd.toc->leadout) * GD_TO_BLK;
+	set_capacity(gd.disk, cap);
+	return 0;
+}
+
 static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 {
 	int ret;
@@ -482,6 +499,12 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 
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

