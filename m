Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7547ECE9
	for <linux-sh@vger.kernel.org>; Thu,  4 Jun 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579210; cv=none; b=f1NfEQ9E+4AHSeuWA3YUfgO1uTSxT9BOgJojclcuaJbyR1NgQS8xufpnck2tlQKzbFMhiPVbYcx//JToTSp9YyJwFipB5Wyn/rjHUVhgBmGOvVkYjLd332ebgypMRFi52pMXU/sBZC0C4RQFLkcUh3Ba6ZzN5f/RCq1l2nTphJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579210; c=relaxed/simple;
	bh=T2wQkK65vboZ4IeGnr4NbeD+9D8laMYxlcwY9lW95Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAoECGXnqxQJiV8TyuoZX3tJoZPGDDsLRQ/yU4HmlL1K6gRgdj7JG/RGmnWcMmw+T2m85x9itWiqh4hrwbJCJBmAjCzcf6AJVw2N1a/stkOkbUhpbklPiLpfwCmWXzIDWC0U2CuP5LCOTtSuFFhmrCD2tf/t6w20KtGyQUhaQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/MSGcKj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/MSGcKj"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef372c58aso431497f8f.0
        for <linux-sh@vger.kernel.org>; Thu, 04 Jun 2026 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579204; x=1781184004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=U/MSGcKjCOLpKGiwmb+hS6FzWFLCtJ6wvdYdnHQmDaSBnqFmO05w0ioUV+SrGfOxfF
         XiRqqhlPMZ1EcHJ4AVLYrCWuZ19nM5c9AcKiolBT6t5zfbp3Ka13PBs7LwN+/DLBzrIH
         9YU1JoXrNLqvIMsTiGYf5aaXp9bRVN4b8CClSaEeU3PdL3JnzaAGZy2Sb4kipcA26Pnc
         i0Vli4Vi2svsdclzVrs04iNFpA9+tNH4DTezcyVnlM80DLdidU50PMXNojOfg7OyVIAm
         ZELBI6wVqLhYrQiWM6Ie3WKfuyuUzZaM/DOzmhmzhP6/A+U8vOFeQE4RDz8LuYFmvrcT
         nPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579204; x=1781184004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nCy5icZAFPKbCxn3K3WrZKHkVhOrNfCywaz2Tw/0Yng=;
        b=J+ifIOr3Ql6ttCtdm5p1bpsugK0T67HKUxWgsGjNeewe12qiyYV4UzZmMD38aMJjua
         nxdztVuU30AuI/cTmWODnqNC6ovjBzQXWXwcU6C0muTJ4bEvxZDhChuZh1OyzIvZn6Lc
         Gh4Ljmkdbs/bQwK1HJeGQ9fWxLiJQCAZPLsdgcw10sDKKfbOW257Y90SUOG2UKA6I28t
         vN4TjFlpXLbs1XxSazsFvNXcctHD3QB9oaH7cB38uJCvFI5nRh18TwV48P8UfeuMjD13
         3KXo7Vi9LUGobar69taWDPEcY8RMeHuF9l+oMT/kWECoH8mXQMd2nSOQulpwMFcPHsVU
         zmpw==
X-Forwarded-Encrypted: i=1; AFNElJ/Gv0Ili1QmT/mRcB4hIOQp4D20gImWRHi3gpzNMeh3IbHE+7L5pt9pFwzfsofp39hVi1GYMV135w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzaMYLaUrUY69gZmo14JGMToMjFFbafsOUeOvlqKuJKiusCOMD
	Jj/jtKqcf2knZhRbXtpuzOCJO4Rs2C6m0GgjkAFkVHDouZMJorTQhBKX
X-Gm-Gg: Acq92OF8mRSsMirsmkuMy9X96if0NV9rh5LzFFRKMSx8oI8WRnnXHjI7iYGfpm9f/VI
	C7klD9SPURff8k4+F25nmDV9bUQ2NvbDP0o0VY8W7KPN8HV5ed4/VyWqHfQeJcii5FvpK80qiap
	i2d5GPfoLBVipBQd02JhpbwxJS5WnbeDY3XTX2l3FLYz/KszmtqPOREL1aBtMPaqXfhWVlAKcB/
	ZHQLHaxv8onkZm1Ua04iT9k2JYrI+KZ2TKUGHg1/vOhUqyXYikLmBcvyZtP6u1h+kwfEc7ghoDW
	2KN2ju0SYs+YAWPGMQTUmbttZUCtea/lZGI68u71sbKgT2as+zxWCuSmUOSYj04Rbl/34Nps6LR
	eknBb648JPGx301PQ27XnYZlIIuP3UJj8oNTgafrOhD0OXzbYVaBHsiAoNSbwpOahJT7ZQqs9uO
	i7ps99zEjQ/C97DI3uaezRbgQXL41tZOVE
X-Received: by 2002:a05:6000:299c:20b0:45e:7418:a3f2 with SMTP id ffacd0b85a97d-46021846dc0mr9148505f8f.26.1780579204445;
        Thu, 04 Jun 2026 06:20:04 -0700 (PDT)
Received: from localhost ([94.53.77.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm3398435f8f.32.2026.06.04.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:20:04 -0700 (PDT)
From: Catalin Iacob <iacobcatalin@gmail.com>
Date: Thu, 04 Jun 2026 16:20:29 +0300
Subject: [PATCH v3 6/6] sparc: Remove remaining defconfig references to the
 pktcdvd driver
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-remove-pktcdvd-references-v3-6-e2f06fb4eef4@gmail.com>
References: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
In-Reply-To: <20260604-remove-pktcdvd-references-v3-0-e2f06fb4eef4@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jens Axboe <axboe@kernel.dk>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-scsi@vger.kernel.org, 
 Catalin Iacob <iacobcatalin@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=746; i=iacobcatalin@gmail.com;
 h=from:subject:message-id; bh=T2wQkK65vboZ4IeGnr4NbeD+9D8laMYxlcwY9lW95Qo=;
 b=owGbwMvMwCX261qtXAKXKjvjabUkhizF6vUry7hfsO25sPz06cyFgXWfhXOy1B3f+N6v/xxft
 T7rWuWjjlIWBjEuBlkxRZYX5663bdhzJuBekl0LzBxWJpAhDFycAjCRvxkM/8PWMczLnZQ1MVVk
 61zh9Gc8zi+v3191c++BLfadB9vXLZzB8M+6u/j1BddEqaaNtVEqK99Nb7E/mlw1+8ssJ3HGyv3
 3njIAAA==
X-Developer-Key: i=iacobcatalin@gmail.com; a=openpgp;
 fpr=F609BFABD84EB5C9DDDC37EDE89C6A3571CD0E33

Commit 1cea5180f2f8 ("block: remove pktcdvd driver") left behind some
CONFIG_CONFIG_CDROM_PKTCDVD* references in defconfigs. Remove them.

Signed-off-by: Catalin Iacob <iacobcatalin@gmail.com>
---
 arch/sparc/configs/sparc64_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 632081a262ba..4abea39281cd 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -60,8 +60,6 @@ CONFIG_CONNECTOR=m
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_CDROM_PKTCDVD=m
-CONFIG_CDROM_PKTCDVD_WCACHE=y
 CONFIG_ATA_OVER_ETH=m
 CONFIG_SUNVDC=m
 CONFIG_ATA=y

-- 
2.54.0

