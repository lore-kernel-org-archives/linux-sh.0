Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB55175A98
	for <linux-sh@vger.kernel.org>; Sat, 13 Jun 2026 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384224; cv=none; b=cCIBGHtO9bjJBKf8AK5lHlbsvBLWxZpVolQ/zL0t+KwHRVrbfdDuYD6eDhF4mQMxlCjfMzVIDwXKEps+rA9M2kDpqOGxXfpfu9+OX4sid5++t6IQBB5WybpjIvzdQzHmv3v3Ds6FSG8dDRlUuC5hm2+lZGPjHvY2iuBCoZMpJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384224; c=relaxed/simple;
	bh=/qDCWylRg6QwnSERshK1R9EDzpJDD5fI0Jflr855Sbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W65D99vLRr8eR77MmmuvSwyflEUYLYRQMkqU5SzgCh/aRNOiLndDIwUZnWJHcWyhZFfpDUBikIJWWs1RqTikHo8eiUJ/1Yxu7XmLi2MDVIWV3CDzeno38HAJYhZ6nsuioFVxNjj8lsqraGNEprXu7l8xWxr91mqAYzKXs0M3CP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvTQe/Vk; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvTQe/Vk"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-3074adb8fcaso1933229eec.0
        for <linux-sh@vger.kernel.org>; Sat, 13 Jun 2026 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781384223; x=1781989023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx95+XEnolNVV9PcPo1ScatzdmZ/oswLsa8ILrgnsdc=;
        b=IvTQe/Vk94/hy/A6UvA0fV8bR/VSHfD4CqBshdwyiACyPGBWe4oyokRsBjSVZEPmEx
         Z+hZ5DbFkTD/WjSfodlOa5GHqYJmsVhYBoR5NrUifEmzqHqi3OTCNXrpdSobEJHeqnAv
         9eXYTTk64RlZewwnQPLkQPuc0sg/EDq6UwiGEh8CeSzg7ei7ZG+NLcbhJ5f53DaLwiZP
         DVKSbuiGwLri//6mL/y6rCgm7zHQnMq3lz+DVgrgiZRmksHoh/+ZpWmFriooIRNpg+PT
         JFS4LiGVBeYIJ4M2mu/+4ciMzupm30iuHqN9Y2j91dKODnFYxbrVZUF8z1vqlC+X5Vtt
         7cOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781384223; x=1781989023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx95+XEnolNVV9PcPo1ScatzdmZ/oswLsa8ILrgnsdc=;
        b=bRL210OMbIeRAsSpv25Z6dQtVjJWndU0icT6HMjsD087TRiucqyaX7hHsFXw3j06Uv
         A7IpEUbl2W0jDfL8UzLaa0Mb95v7JtF9yN9mUrWA8hTL3i6XSpGdT64JluDcRujF4yeo
         JT2UtEojuwxAMxOzCYCxqA1nzsbqBGn2TQFUEyIfJ6Y1sVj6I1GhC+gUyvJV0EVIMIEn
         QahaFSVUlWAVzmLtHZGeJIrSuXUN61uQqd2pDiUozDEiOMM6dKPItNIQCq4yiWgBm5b2
         h18ztyd3jF8f1lKFR5aS5hdEWI+rBbPR0V4ToeoHkxKvQYG1y/uy7IEthWV/xuLkancb
         CN1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/9P5OT5xZfm5/7F/lXwQbTC7QNFTm8/xRd7lP9IKfudhD4YuY0tGkbP5IguuwKrqmVTE0HzaFBfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhclWc3/g6C5F1VRTUN5D72l7BaAfMXCYO8hZo/fP2ssg2/9Yf
	aHwgXHRciVMeclYDzWFAdmj+tGiDOH7PbhsGJSE4icFlYu45xaDj6XhaVW/mnG2I
X-Gm-Gg: Acq92OHdJYhPpoz9JTBwBhE6Mzpzw+/z9f7kCrxl6vWeUfesnva7FuNb5Bu4cT1IhjD
	PEJWfnYF93zDQxCnx2Lz6Vsueq+MzFKF3dew/ln2Aj6SRhszHUSyP/YdgBiqNdXyRxyA/cdU1Qc
	wbycjZtol21XUpPrg3f7JXRaxwwxronoiMTuUQMD+cs6NLzrO58oJPMlkrcfy8IHnHbQ3ufOVPz
	/X/02cfZNrDYD3cwEGXFzNOFuiYa4tvG18UGYY6cSEBQBqQzFTV4hAnjrM2ddXfqJiLDMEUbpSz
	UrMyjOSCfGX4Dz2vdeUjHr+mN+DZMhPzjG/R2s8eut6V2jkNWLa2l//Y1A3kBOcB9ySzSsHDHOl
	y3pGEiGYsVPDDxQPn35LcuMV2Z1GkSiAgxtqAtZ7v6wrJJeamSirtUhhT0NTY+0UZBWJ3S0eVt1
	1NiX0KBaoX8zOwszzl8A+uW7j9dRlk7PW48kcPLnkJDxULINZyfH2l8QMR+cvxana/wN0cwu76c
	fz3ZRnMqnS7yUw3J1KMOwki8xteWX3sJSGW90WLd6E4i/YOZD4lERG3OoA9f5qyPWbGLVA1mCHE
	6N/8JzViB3lRV8XRKw==
X-Received: by 2002:a05:7300:5341:b0:2fc:9ae6:e5a8 with SMTP id 5a478bee46e88-3082009c394mr5366231eec.20.1781384222583;
        Sat, 13 Jun 2026 13:57:02 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48c3dcsm9184480eec.1.2026.06.13.13.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 13:57:02 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: "GitAuthor: Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
	linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH] sh: dma: Remove checks for nonexistent CONFIG_CPU_SUBTYPE_SH7730
Date: Sat, 13 Jun 2026 13:56:52 -0700
Message-ID: <20260613205657.82194-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two headers in arch/sh/include contain references to
CONFIG_CPU_SUBTYPE_SH7730, which has never existed in the kernel.
Remove these references.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 arch/sh/include/cpu-sh4/cpu/dma-register.h | 1 -
 arch/sh/include/cpu-sh4a/cpu/dma.h         | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 53f7ab990d88..af973c0f4f9d 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -21,7 +21,6 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7722) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7723) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7724) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7730) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7786)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
diff --git a/arch/sh/include/cpu-sh4a/cpu/dma.h b/arch/sh/include/cpu-sh4a/cpu/dma.h
index bdbbba8a784a..04992db01280 100644
--- a/arch/sh/include/cpu-sh4a/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4a/cpu/dma.h
@@ -4,8 +4,7 @@
 
 #include <linux/sh_intc.h>
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7343) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7730)
+#ifdef CONFIG_CPU_SUBTYPE_SH7343
 #define DMTE0_IRQ	evt2irq(0x800)
 #define DMTE4_IRQ	evt2irq(0xb80)
 #define DMAE0_IRQ	evt2irq(0xbc0)	/* DMA Error IRQ*/
-- 
2.43.0

