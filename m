Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F612D1F40
	for <linux-sh@vger.kernel.org>; Sun, 19 Apr 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616155; cv=none; b=g1YEJO3dTc13nfqkpotGD5dlZHE+nHbZBGmm+zhTMH2N4PEQsPLvmXmkXCvyPNsyLXdAP4pKqBvdvzgTZS84TwU+WZHXRUWKW8zZVuY+SNB5+b/sM9RxSjiM6vATlk66obgfPjrsXI5MXos302GEkUzwfd8V85H7To/fIKxo18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616155; c=relaxed/simple;
	bh=/0TEkY+sxpaC0GlCPNbeaHDoXij7IeFeKG2B7njq+AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWyMot0jKpJyt3Z4tG2hy7joXey8HQOCRDUYtpZUt4soNscidQVEQTMwRYN+HRktpa+zU0MKyi5FWyVGN144buP6WFb3hBgcSO6EJw15F4qYLV9bTjrhcK7o4EQcW7rxFsbvoUvmrnEpuBPvFkgojYp+0hn3vT4VDuh6/9nSYqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nh1UoKJ/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nh1UoKJ/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so1836147f8f.1
        for <linux-sh@vger.kernel.org>; Sun, 19 Apr 2026 09:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616153; x=1777220953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CG0WEefAtVYQQDx1GALJY/zb5ptlk38Q48NQwoW8PzY=;
        b=nh1UoKJ/VOa8G1i/gyBJpRmUqnOuMx2alI5jWvWvyY6lO14gWWaVcfgd0xdvDLx3f6
         4c+I4E12dv4SOOk3aawG3NkJElWRs34cxuC0V2uOIGcrcypawfF+h+Qv8/H682YvKq60
         8g9htjIxPTZmkU7aaIGobvzOl4pKndHtoK1hVxnotZSfSp3V/Hsd0gIDvy2DuYeEHVyq
         wWJEJEdENgELpK+FbVTfqWlCD0q6DN6TxzNRXgHPsiMY/Uizth/nv4ObE+vDSbxVZ/e6
         wfmjc2i0V80Hm6Voc3HC7mug2i39JrI/LuZNVS8QQFStd2Xvv43xZELVsMGmW545T09m
         HQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616153; x=1777220953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CG0WEefAtVYQQDx1GALJY/zb5ptlk38Q48NQwoW8PzY=;
        b=nQwB6luyXH66YBgxj6BA/uje2xK+4m1XCSmT2Hcyu1HO9TMKliOo6MKBOSbgPgldxa
         kA+wcpeBstZlZAzMJcKWPJC09sRAF3lFLnBHc57mZeRcgNbeDgmAnuctFgSjsAN7KpMi
         GFGdgePb7KPuSmPmpvX47ojaAnOhESccWKuBOp/ZURvv2nPjrv+wf4CIsTX2XAVrvfRM
         B6VDn9hdlClRiMHCWpP32BsTI6E1PNGsyRenDiYGGZRsRr8uz1bL/EEy+MjvU6WMoZDq
         rv2QS9lGftS7ZIE2+B/vMlWp9l4C1eCtC9HSPJKMXTim7cM6FCzMVMRz6dYL4y87Cp1Q
         Q6Sw==
X-Gm-Message-State: AOJu0YzXb+IO/Imy+uHSUFtl0AxtyeX56cXnrW4oeouVFHweVNscdLbT
	EkP8CBImSdGM5H2Hk9GQaYKOXq9h9gihzgn0TfHJJh6KRCFiXkseenpy18XyqYc=
X-Gm-Gg: AeBDievmqVpnV4q7dom7z2izy7UuLc8UBqWw55AF4i5AqQBGysTwwccMe/K4b3wKuOh
	E83IxVRgLzmRoY5iAVYZKSWIhoNy0BhxvAwknHrSn25DMdvS8zNZQvfihaf1FhQyOur3l28zpWV
	OzK1aYJ5jWB2CT9duphUD/zUiW1LGfWuLHgVrbzc6d9GRXDHC8dXm18qwlaGTN2rEa0KuvbwkvP
	0tFb36KQ7rJfJ7dZBEOKeCMyv/DeM5yEv+7oJZ8FenRX7Urpnnq0jOaVIsbBNpVoAYpMIk8ORCt
	WatEN21byOvhjMFZxLMUpJ+FTCQL5yYGcm2Dp/R0/1ebDDJmiG/oXLece2mHxJptyMTJAWR6rm7
	6JRFFWy1h5PBLMkIowBFqjM1VHcsIiU7/ao5YC3GnsavefZ1sUT6lh/3DfXHpTbfetogDYQBIbL
	f8DGdGXcj6AvDNWjeiY6Mwbd/FKBqdaGpEQ1ATaaaNM9m4YzFdpeKZByl9DMML8leKMpFA9XCli
	7G41cjg7zVd3vVb2LI=
X-Received: by 2002:a05:6000:2dc3:b0:439:b1c3:84c8 with SMTP id ffacd0b85a97d-43fe3de2bf5mr15121663f8f.21.1776616152477;
        Sun, 19 Apr 2026 09:29:12 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:e7d2:9a54:d18c:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e591cesm29467804f8f.36.2026.04.19.09.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 09:29:11 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v2 2/2] cdrom: gdrom: update gendisk capacity on open
Date: Sun, 19 Apr 2026 18:28:23 +0200
Message-ID: <20260419162823.2829286-3-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419162823.2829286-1-fuchsfl@gmail.com>
References: <20260419162823.2829286-1-fuchsfl@gmail.com>
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
v1->v2: no change for gdrom_update_capacity(), but for
        gdrom_bdops_open(): handle the failure case when
        gdrom_update_capacity() fails but previous cdrom_open() succeeded,
        to cleanup the successful cdrom_open() with cdrom_release()

v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-3-fuchsfl@gmail.com/
---
 drivers/cdrom/gdrom.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 89938d9b2825..fb95288fad72 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -474,6 +474,25 @@ static const struct cdrom_device_ops gdrom_ops = {
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
@@ -482,6 +501,12 @@ static int gdrom_bdops_open(struct gendisk *disk, blk_mode_t mode)
 
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

