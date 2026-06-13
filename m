Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562F946A
	for <linux-sh@vger.kernel.org>; Sat, 13 Jun 2026 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384714; cv=none; b=D+mvkvj1+98cm0fmDCTLbz+IfEhYqiYIOsgggdil7F2TxMmqTbfHbanqdY8UR8CmGDVKpaP9gftIXoYO9fiHd44cVyorr312unGqKvloxcgv/XYyTotb4eFQZDh6Y1wm5bv3tUrBsKXEx+xBHDOzmK67ItYQFrdzV+XAmlq8PDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384714; c=relaxed/simple;
	bh=sQ1bHeXlmv2zvCrmFzv0dQ6WZkwe7KorVnbWqi6TovE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fBmCPpRqg4uckOt6baSN5qHcvDZ8L0IlgL4xniNw1v5EiubgLY/zqMNIOYUIoJlrlKGiKiPfqPTfK4Zf/lCkywO9X29APbvbra8weXG69/ay+mfeSj8j9K2JM67CLKpVBISV0+A2lQ+GRIOeprLc4QmM+P5SftNvRnp+OMUy7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3tKKIuA; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3tKKIuA"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-13817614cd3so4455434c88.0
        for <linux-sh@vger.kernel.org>; Sat, 13 Jun 2026 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781384712; x=1781989512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mTL4bCKNzFCC7f7clVeIyBIMDmq1NZNC6ZSIw8RM0DQ=;
        b=i3tKKIuAc97rHGIeeBpLWne1Gn4glANygwxd4H1oOBkC8JY5XycOXn8d1fn3inhiZL
         4lgAlufS3VlUuDzHc+qOOOfXKU0SP4c5zK9EpHtw0XznGkERs9z+LI0ewV+kmqd8zT1Y
         q5jbGfLPalSteCadIVNgijIjvYHpLxry9vqYWsjbBx9yhpMmkYoHxUs2mreHZ67ulwJN
         fYddF0qVgSc/we0/gxcoz2h04Z7lFRH8FlpLLkNzyzVL8KyyYLxp3bbwbr0cVfCBess4
         otMGqbz9hiJo6YarlgrKnpbZnJnRednHPqq+2UTHzZd0Y+S+hci8eHO9tJvccGURM/tG
         uZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781384712; x=1781989512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTL4bCKNzFCC7f7clVeIyBIMDmq1NZNC6ZSIw8RM0DQ=;
        b=nPem2n9ezC5grcfXXyMvgULrf4EiePyPlBhWBkvqs3o9QmSJmy884PPGb53hN0yf8B
         l/EiY+V8dQ050cZY11piVAriKQuDgxKa+hoEdNsSOPFBtOQjUlqhe0yCbSXL8dkYG4pz
         UoYLOeP6LzjV5f8dTtxV/FtghOqdZCrMy9iFDeY9BjxJdgXUCrbExMvp7kDcLvEULIfX
         YEeveaONDrp/3gZZR/9kXtgMAh1AuIhX9fJJ9I6IhO3upppkbcdA9Uazys963gRZWjoc
         CrYAmvklq3xM9V+wzJSyyBciEoAMigHvcFm8V+AacJls7W9MBxYvk9vOQPm0Ba7XnGNO
         mi6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9KhhfDHqyzKujH1Z4u1giANxUgVY0LrKBNWwp89wMy7uginzOxSm0Yj0aTmqlx/rzOx6nW6L9EYA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5dz/fg0miaYLMNvIZuUAKL6Cw6IvKWIXGuOhEpF1UkV7P/7TS
	sV7oxhP+zr6hTIz/N03wcfva1oTmTv23ei0jAqDgfVQmOU5OwEWmCKpJ
X-Gm-Gg: Acq92OGF/eJiNnP0phx6GZv5sa5Uef3YcHdQQPnskX7xMEc3DIdUPwkgzY5u7W7zOgL
	BTPpnu6Arq8cbGJbdXfxcZjj3CVSoy5x0Not6aL0lX7Qlpk1db5rIPdS9eMSPlcGh9UsAAt0Gvy
	LSegRYN5S1RLoHgXiY/7ULMgbJifZ2HTu6nzkpTAz/tL0ZCGkF5BCUeVVfaIOgCTyOWhiFfdueU
	SX1MrdbyTy5/a4G1YA/otqEBeLDvQp9bixYheKtBK/eLwY1NddRGQwfKy4+vxHzkYZrn6TIfxNw
	cLWhm6XBmmP6N7kgUxEt4OsKrOfHaXFvEdIonaoSN8/WfHrWIeVeB5JBem0U/QwZTNivmfr0vCy
	BFca7ZCyXByTlJ2V5DBpo4/TzwqLSHGdKfpf6vyizv13uttvMVHsEYGc7fJlmwGeqzryud9nf+G
	sOWgfKuZCjOQV5bSgKnaKCUO8VDsWUFhtfZ4i1eUf1ZZIhMiBnFr0EkknfcTEEpgAvtqJlSAdnk
	cX3eCGP+He/u903PTLMSzasJiZnyWm8Rv2PUMKk1U2u6UdfAFSLYrqX0kR6pDQKCVtDkCMNoi8Z
	635BSAncwNeushAPPg==
X-Received: by 2002:a05:7022:61a3:b0:12d:de3e:cbfe with SMTP id a92af1059eb24-1386f3a0e82mr2304469c88.37.1781384712221;
        Sat, 13 Jun 2026 14:05:12 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97bf09sm6174994c88.14.2026.06.13.14.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 14:05:11 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: "GitAuthor: Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
	linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] sh: mm: Remove checks for nonexistent CONFIG_CPU_SUBTYPE_ST40
Date: Sat, 13 Jun 2026 14:05:04 -0700
Message-ID: <20260613210507.83434-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CONFIG_CPU_SUBTYPE_ST40 option was removed in commit f96691872439
("sh: Kill off the remaining ST40 cruft."), but a check for it remained
in arch/sh/include/cpu-sh4/cpu/mmu_context.h. Remove this dead code.
Also remove the definition of and references to the MMUCR_SE bit mask,
because it is defined as zero on all CPUs other than ST40.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/sh/include/cpu-sh4/cpu/mmu_context.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 421b56d5c595..4a6148e1ea84 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -43,12 +43,6 @@
 #define MMUCR_URC		0x0000FC00
 #define MMUCR_URC_SHIFT		10
 
-#if defined(CONFIG_32BIT) && defined(CONFIG_CPU_SUBTYPE_ST40)
-#define MMUCR_SE		(1 << 4)
-#else
-#define MMUCR_SE		(0)
-#endif
-
 #ifdef CONFIG_CPU_HAS_PTEAEX
 #define MMUCR_AEX		(1 << 6)
 #else
@@ -69,7 +63,7 @@
 
 #define MMU_NTLB_ENTRIES	64
 #define MMU_CONTROL_INIT	(MMUCR_AT | MMUCR_TI | MMUCR_SQMD | \
-				 MMUCR_ME | MMUCR_SE | MMUCR_AEX)
+				 MMUCR_ME | MMUCR_AEX)
 
 #define TRA	0xff000020
 #define EXPEVT	0xff000024
-- 
2.43.0

