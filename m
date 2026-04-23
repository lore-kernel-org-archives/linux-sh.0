Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F013E314A83
	for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776975662; cv=none; b=jxYRPPyQBKkMA+n/sin3nsQ/dYmrJGjbWzoD95KJgPM/fPMd+l5BssS/2vCKp31/IJmFd2D9HCpNUw4CA/HWqzkDGJVLM0INcMjA4EtOV27ecSHo26W1pcEgzOjUIGuCFb4WvhqHqlMozVFQWJ3oFONIZu2h4jvdrp8BdRcgysU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776975662; c=relaxed/simple;
	bh=T/czwC0J26l2TyVqQ6wc+YrBgBSivvrCySEq1+B0MTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zk0k4UAOQVWq7UxQtPThx+ZpqUYHT5/QaE1erO2/GEYw4ML7aVOoARXDKxqmmwB6+ApjFcLsGXZoCBjsQtUF19Er7bx4DZnn4BpkxMMcZLQdWRTWcW6Ien1rn1/eSdnF8ThpGSgcPOF9Gyyss2kEB8k11deUSwDOWPWl2d8bhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVO5qIVw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVO5qIVw"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fe62837baso4313395f8f.3
        for <linux-sh@vger.kernel.org>; Thu, 23 Apr 2026 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776975659; x=1777580459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc0syp3ZtsazMj/JLPGELtRdP32axpA3bIZR9qnEYeE=;
        b=KVO5qIVwQRFK+OZ0Z3SqDOQ461OgfI44g1k+uSoUQv4YK1bGTdkdkzM9XZ4PMaStsZ
         vhM6l+intwSurS3K/uYQ7llNeCLDuFMqKIwuxoXg5jOE/clo4rf43fAbzfAz1pp/q0dn
         +XfkW/mrxIh+hNDp4eVCJx3ZCop5rzwX02Gkkw7PvXZBWRaDKZxztR4GB/45JQh6OlOi
         vRgWg7TpnwyEdfnE1T4Lrjp8aWC4bwKwubtrNggeUG320zw8xskqUC52ZvtP3nhEDhZU
         rCOf1wIk2Rd4LVZhQbkOfMxyaGyYWGcJVbAkyXMgcKlrTnMwmGAR1v9pe8jFdWufPM4j
         mT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776975659; x=1777580459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc0syp3ZtsazMj/JLPGELtRdP32axpA3bIZR9qnEYeE=;
        b=jJaPD/Y615cDSlCKHHDr7B/1IyUk1Snpy1wXAhWcg3OQFvOidqped2LqpTgJUKv4qL
         MOWgqrp4PBpv3WDooGsushlTFXlM5eCXaPeQzryUTAk0esYbXuXZczfhJb9dxqGLmpav
         48+VZa++7J88w8Jh37ZfCLGzC6zYGxbtqichWFBrcKbHpJrp3+fBeUdmQfNbHhp8ibv5
         8EWbsqG1bf3iOqewVfLV1RSa7dr2vwsGZPzgm3IBk88H3kuPV0TXtf8UtciJGJSCQlmc
         Kfry22YlzM/GAO7whmITT9w20+DHKldewQEE2wwD6lysEeSwMBAJZc6KlFKCWXCAiSeo
         fSdA==
X-Gm-Message-State: AOJu0YyQK1iCBF42oJfl6Z5Ie9pTMb7vucjVkXQzn6VVUh/MTJiNcwAq
	2PPsXeVmlAMvc/RnaZQoMqwSsWrwduBRgv6Mo0rCL54kRNHMGcm8BaYk9/3x6i8=
X-Gm-Gg: AeBDieuNROV8AiFT67J5mGjN1YUFx9XNOYK/6nWddHHxiMwzBp1v/yXCXibfOBlke3X
	o2p7wwuI1ebqc6prUylESVwh7tVPnaaT+0i8z/u0Bhl8+49Mk5jeGIpmuJd8p+Pw9oQffjA5ARu
	irPFTzCME7leOlf/ZgtB2jBofkRhGkZtY/HLqPrA9GxSK1cvBPAyuzdXA93HoCoDDTgjxS3JiZX
	bP6OFzEz9fJNucY3BqnToml5j25NqQNmthjR2fxhzHDUigNLJN2v55UbUN15iBs1oqzEfj5RkPO
	p+vjF34FEOR79RX4WU2KaA5gVnTKgIdYaOZxmDVO5Jf9ljt/sbQnrxAXrU365sN7UAj90u/okyW
	zTlG/cDcgWxpw6SK4gefYekUfv3CvKArfVhdKs2ZeZFdXOHNmzBVc4AY9SoVKJVz5HGEtju/8Po
	GPWgBhWx97db+JGfu17pScMp0Z7u3OvZWvSeGf9dXrqwo7GRS7Mao0BqZ13aHuWjSR4czPGK6U4
	OSdMYpbhpnnkPLu
X-Received: by 2002:a05:6000:4287:b0:43f:e7c9:2402 with SMTP id ffacd0b85a97d-43fe7c9254bmr45447117f8f.3.1776975658988;
        Thu, 23 Apr 2026 13:20:58 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb97:cfb5:53a1:28])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e4eec9sm52314911f8f.34.2026.04.23.13.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 13:20:58 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v3 0/3] cdrom: gdrom: fix block I/O and capacity setting
Date: Thu, 23 Apr 2026 21:41:29 +0200
Message-ID: <20260423194132.693271-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series fixes a gdrom driver Oops due to bad MMIO register access and
fixes the missing updates of the block layer gendisk capacity that
prevented ISO9660 mounts from working. It fixes also the case of disc
swapping by sending the Test Unit command prior to cdrom_open().

The change was tested on real Sega Dreamcast devices (PAL-E, NTSC-J,
NTSC-U) with physical CD-R discs and with GDEMU emulated discs. Before:
Oops on mount and an unusable drive. After: Successfully able to mount
and use the inserted medium.

Thanks,
Florian
---
v2->v3: Added patch "cdrom: gdrom: verify device access after disc swap"
        from Artur Rojek to also handle the disc swap case reliably. And
        added Acked-by, Reviewed-by from v2 to the respective patches.
        Also handle the GDROM case in gdrom_update_capacity().
v1->v2: for "cdrom: gdrom: replace port I/O with MMIO accessors": Don't
        use helper functions with io.*_rep(), but writesw() and readsw()
        local in the respective functions. Improved failure case of
        gdrom_update_capacity() in gdrom_bdops_open().

v2: https://lore.kernel.org/linux-sh/20260419162823.2829286-1-fuchsfl@gmail.com/
v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-1-fuchsfl@gmail.com/

Artur Rojek (1):
  cdrom: gdrom: verify device access after disc swap

Florian Fuchs (2):
  cdrom: gdrom: replace port I/O with MMIO accessors
  cdrom: gdrom: update gendisk capacity on open

 drivers/cdrom/gdrom.c | 65 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0

