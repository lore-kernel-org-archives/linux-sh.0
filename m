Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A071C34C808
	for <linux-sh@vger.kernel.org>; Wed, 12 Nov 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974554; cv=none; b=G0l0/vob77cf5nvkjSwqqP13/WfEFHXyH71JEg85n7X4A50S/3NezMUOQ7X40CGXxOAxu3eLbeX7NKUP2B6xO0tBafLHa152Kz8znlmoK8FTmp0iKKCJsl/Jht2TnVqabomW4Ay0SSPO0j/qizhkpXG/bmL/10nBvFXb0OZEdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974554; c=relaxed/simple;
	bh=vCZSV1WWxWmjtBXURpOwW4cZm8n5J6wXTTO5rnBlH+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ayiuLSz+ECXm+phnY6k427ED9omJfJh9nZQlRNZYRgzYGJTpzUMjL8Tfn6WTNfdVzGf+o8i7Rx1v1GANaKy8y/4NmyNSVfl2uJvLXKFSR6wIzBO9N+63qCE62GvDtKlU98W8hNN3Mmaohm4pPJM/PA0YPvOZfe0UwUAsJ6oUy/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a59aUyku; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a59aUyku"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b403bb7843eso27980866b.3
        for <linux-sh@vger.kernel.org>; Wed, 12 Nov 2025 11:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762974551; x=1763579351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4HxarC/0cHfwsXI7e4vj+A1IpTTWGHNmxw+3uenBi0=;
        b=a59aUykuNRw4+z3fOG8ikc96jaHow3Q0L4qu/mex+YNiU8CneTyklFguK6oco36jOD
         c3Iegn8U4IlzPlqkVp0htrKXaUx0HifdOur9VKnTXTiOl+N7U4NCtS06bwKZKYYzyEj2
         h8jD0faL2eGyjnY/xwb7OO736aT5zxLBgluctFZbU/2jcVFTPaVn0rM36cjsqL1Zhhni
         ZtYgHL6ODzjmifxrd9Eyi9t417FjvxIGQa1X7qDkLyEvq2lA/UH2UnMTS2MUb14BwVOo
         yP2u23I1J0h4JCgjFnch6NNmAwAdGmPx1yQfxOtEGUfa3gFCsy1zHvVA+5wUSreDUP20
         0ArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762974551; x=1763579351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4HxarC/0cHfwsXI7e4vj+A1IpTTWGHNmxw+3uenBi0=;
        b=VByKNch3OKjCagZA2r39SAwN8yqgS6T/q50x/edQKV+6UDzraU8SH1e/tUSSDUZ32K
         dhFBf+Z6VTzvOmIFIyllQa6Sgqzz2RQWPuANe/b4pjE5akFgMq1CPIbK/KdKEBQBGAyB
         0a2iiBFKRNa9cicT+V500bWu/pcWVRSVK24VbnNg5HsynZ7Gq9vJzq1Cwg0QMWCqjhz0
         2yHt4eDdEpjlEhzCg3znnCTfyzjpitWnLTT3Of22r8c/lXiENgeQYrIwgi8pG4Jv9hHM
         aV3popc7WBDXxMAMOwhgFOQO+tDEKjCCMbF/dMjCXH23/K4H05ooOwM/oivw0nlreom+
         ayfg==
X-Forwarded-Encrypted: i=1; AJvYcCUkhH01fZH5nrbte6GZ9LFdvAgxoWnth1euv8/f88leWjL80YnZUBUNEMt1QkRt8hZZPaIIZ+jbKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7POCHRc9m6TnuOfYPL3qLxExjPUTkLNsAQbA/poOY4nmNv4Rw
	KyS4cFj51b5S7hdd+42bBc5wTF0x000IyE6yl/NKnnk0DIpNv0Iwu0eAcWLioH4=
X-Gm-Gg: ASbGnct3BHOwPuU0SoJkiTwI1X/I5Y2R+rgFSVN+Vx4BuwqI2j8VPaU7zBWRyqFwWDW
	N/v3qcHm01AIuiOIVA9D9TaHbGLQ53fE/Rebsl8bM7lqfzzaiiCiL5I4HaBvJ6mAZrBu4Iyfscw
	10Of+IhIeHYu7vx8CYZ6/wQ14ykc9XBNPWr+0/lxdIHB1uEn1KkX788s6+zRaWwMC7vQwN866eH
	HKyv0FzFCiCQWkQ8RMAV0UZvtETvjrOspdtRq4bu1qTuxv57Xpy/S0MFO5ucSH0FHTxRj+EpLVe
	jaMAqrCctuoPrkAyZWwNVaUzv8kanKYzXfKDAEoN9Y8htyHU1RjFe+6q/NIealafDifAaQjegej
	hOiUAqVmM/hbQRnJuxZooocoMLIa1PUtSDTZxUwi0MXucLIrF1gD1neAlj3stD0Y7+4ZKeTtcNQ
	Bmtg3rgd4m+XwI7ufDMc5PIjJ8vbCJk2Au6HpseJUcLBaJ+rz8WTLdures5xcgJN0v73g=
X-Google-Smtp-Source: AGHT+IHxy8pjSz5ZXQAhsov6reJ0AmK0QM7dpISGdovz9adYZVIS0mObDjcrOiPl+EMnu74xwF1Gww==
X-Received: by 2002:a17:907:e895:b0:b5f:c2f6:a172 with SMTP id a640c23a62f3a-b7331a70378mr423238766b.30.1762974550736;
        Wed, 12 Nov 2025 11:09:10 -0800 (PST)
Received: from localhost ([2a02:810d:4a94:b300:ec52:7cf5:e31:cdb7])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b72bfa24d14sm1659239866b.74.2025.11.12.11.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 11:09:10 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH] sh: maple: fix empty port handling
Date: Wed, 12 Nov 2025 20:04:44 +0100
Message-ID: <20251112190444.3631533-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle timeout response from empty ports of the maple bus to prevent a
stuck maple_sentq and a blocked maple bus.

When only some ports are used, e.g. if only keyboard is connected and the
other ports are empty, the device tends to timeout and return 0xff for
the empty port. This needs to be handled, just like the
MAPLE_RESPONSE_NONE response, to detect empty ports and to have usable
peripherals, if not all of the ports are utilized. Previously, an empty
port resulted in a never cleared maple_sentq which totally blocked the
maple bus to be used.

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
Note: This patch was tested on real Sega Dreamcast hardware and resulted
in a usable keyboard, even when only 1 or 2 ports where populated. The
hot-plugging of the keyboard does also work fine.

The description of the timeout response can be obtained on the bottom of
of the page: https://mc.pp.se/dc/maplebus.html: "If no response is
received before the timeout, a word with all bits set (FFFFFFFF) is
written at the Result address."

 drivers/sh/maple/maple.c | 1 +
 include/linux/maple.h    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 6dc0549f7900..3d6c716cfc98 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -649,6 +649,7 @@ static void maple_dma_handler(struct work_struct *work)
 			list_del_init(&mq->list);
 			switch (code) {
 			case MAPLE_RESPONSE_NONE:
+			case MAPLE_RESPONSE_TIMEOUT:
 				maple_response_none(mdev);
 				break;
 
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 3be4e567473c..4ae3cc6678a8 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -27,7 +27,8 @@ enum maple_code {
 	MAPLE_COMMAND_BWRITE,
 	MAPLE_COMMAND_BSYNC,
 	MAPLE_COMMAND_SETCOND,
-	MAPLE_COMMAND_MICCONTROL
+	MAPLE_COMMAND_MICCONTROL,
+	MAPLE_RESPONSE_TIMEOUT = 255
 };
 
 enum maple_file_errors {

base-commit: 24172e0d79900908cf5ebf366600616d29c9b417
-- 
2.43.0

