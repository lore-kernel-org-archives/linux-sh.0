Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035CB344044
	for <linux-sh@vger.kernel.org>; Tue, 16 Jun 2026 18:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634627; cv=none; b=hAVtyhsSJjWk9JpNnhDKA58bZUkB2mW2jvJbWEYmThdlTHLk0LsaYH3iF2F4T6S4sitp0avQg5Cs2BUMR9Rd+7SlOS+CB6XHEehew/rx2se9yg9LzFcT5UNi17Q07q9Ci42bjgzt2QKDnke2Johq7lFnpu8mE89pxvMA4cagrC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634627; c=relaxed/simple;
	bh=dybo8/HrHeGrJGasUpHRaqT8xbB02VCrzfApuMlEzCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPZQObsRdhPkb5GStCJ8egzSYKu7KiPTRwAMnblI5EbFXToeuQgw/0R7RPOHBACB/LUG1WhCfpEgPScnPyjocpeHdIYI/i5cuGGxnL6VGyopGxa8xae0NEpZWVH79jSv+BohR/ydAFG5suCZSrLfWbotNVNdT3R2VPkUJji9FLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO9AK9QN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO9AK9QN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c1e0b0faso31092685ad.0
        for <linux-sh@vger.kernel.org>; Tue, 16 Jun 2026 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781634625; x=1782239425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtnXNaxn+fspW0Xw1nKXB6TGSGdVBv01OAGdj8wNpN0=;
        b=iO9AK9QNKZ1IT2DAT8O1Mcvvx2XZ5Yr327SVGETMj6+5xFRx7/Bx90Jqvjt7WViJhI
         qbFJC3Dun40Yj4SaS7b6t7RGzznpcJhMIU/ZURvOyM+HXqZJk7w9Guspb67dFvapISMO
         NYq0dGS8YsC3K/Dj1mEi3Idgn9mFImY3YV2sVEOA9CJxY931JmCiK2tkZnvydgwe9lwq
         WfxlPBanBfAdjoZZb7erSgSIhsVJ2Nlnqkd7cMRe79dusfxADMV60DX00cKcRXHuvUEA
         koKOvdQ0B9iJjS8mAPWYy3G1SUnQTh3Jv6WohZ7ayK99HxEpNqSCjjrpxWcTe3JNXUsx
         9sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781634625; x=1782239425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtnXNaxn+fspW0Xw1nKXB6TGSGdVBv01OAGdj8wNpN0=;
        b=bKvfzGrUQCLY4AsvseK9c+Mbm0ZFakY6fpnYU0+iFSPFMWf/EPDbH0CM/q4jG4l8hr
         s2MN4M9fO0lN53SnCWBblu0scfCK+QVQGs/yOm3Jfr4rPFBaaimo6zM6MlwsELUoc8kk
         rgKFfjIDAwb8wYe1yn/rRg85lFUq3BoHuMTR1gEaxh2+2I4qXoBagIpJhdrjTFjZ8owB
         LuxH9T3HLY22fkhCvT4TUH/XEnKjmpQMJo+Eu+T9J/pXS2YSgoABHXL1OdJRAqKHS+yk
         FUI0sK1GTJvAVwNFj1bjJEAZGdv0d40xdG2S7XLMPsfn0KN/bFTh/ZU8NP20uM14i0IL
         7cZA==
X-Forwarded-Encrypted: i=1; AFNElJ+yZz0Sge9pv01Fl0Ud5JU715YvNx38jWjOYUNTcz8xsIvlvRFAuUV1JR31ij6HpHPLGAKh8eY1Hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDM4/vlcQbLH33NqFconhZGh6KMFI1/XyqPGF908QQOoWHq/A4
	vX2KoUIXl0wEdmCj+q5932EpO4jmj+ReB7ZWply2+RCFyopPDgkB01WPwk5oDmcP
X-Gm-Gg: AfdE7clZk0CusRCuh3dL4JCOSdIBweilXZYBJPDLqkzY3VtJGNXBdi8ME9ZTbjWNFkv
	VOytDtkyeDwyOJpSM45z8AU3XH/WoiF0v32K0vVQkRKplYlqlH9zg4+VqoE1Qb7qAPJnuxoBrpF
	oEFnWj5FyIB7WTjKDud2JEmKOHwRmACnce3M3cfhG4Jn0+70BEFFAVBtZH+sdog+0JbSFcqJfOI
	7gAJfRy6WR5FjgxUIhr/+2+wU0ntd/6RK2Muj9g1vdmav9IpCgf+8atHZS0zU7P8zzFpXcXaViv
	4tcEkr7y7Ujvv+p2YlhstwvqkfBvXNyJF/d+Q1IQh1Uy8Y+w97fYqA2j1AVmU+DuF5WL20K+NDo
	3dtd05Spzkf1i3Ljz4gM8B4m5QIpfSuCFt/mEGUeU0Wve38siCJ/p02VDtJVg+Ta9MXxPIcILg5
	nnV4OLiSsyO4q4TME6WA==
X-Received: by 2002:a17:903:32d1:b0:2bc:f1ef:2e64 with SMTP id d9443c01a7336-2c6bc0c8905mr2089075ad.12.1781634625343;
        Tue, 16 Jun 2026 11:30:25 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e3ffsm141092685ad.71.2026.06.16.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 11:30:24 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Sang-Heon Jeon <ekffu200098@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 2/5] sh: remove unreachable memblock_reserve() return value check
Date: Wed, 17 Jun 2026 03:29:53 +0900
Message-ID: <20260616182959.2429774-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616182959.2429774-1-ekffu200098@gmail.com>
References: <20260616182959.2429774-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reserve_crashkernel() runs from early_reserve_mem() in paging_init(),
before the same function calls memblock_allow_resize(). At that point
memblock_reserve() either succeeds or panics, never returning an error.

Therefore the return value check is unreachable, so remove it and the
related logic.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/sh/kernel/machine_kexec.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 37073ca1e0ad..ba9c412f14d9 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -165,12 +165,7 @@ void __init reserve_crashkernel(void)
 			goto disable;
 		}
 	} else {
-		ret = memblock_reserve(crashk_res.start, crash_size);
-		if (unlikely(ret < 0)) {
-			pr_err("crashkernel reservation failed - "
-			       "memory is in use\n");
-			goto disable;
-		}
+		memblock_reserve(crashk_res.start, crash_size);
 	}
 
 	crashk_res.end = crashk_res.start + crash_size - 1;
-- 
2.43.0

