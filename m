Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB1324716
	for <linux-sh@vger.kernel.org>; Fri,  2 Oct 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914355; cv=none; b=GdL9ljEd9R+T3Lo5N+mXOYTKvAYY+zGLTJ1RJcOyl1vaAKbJsmMgfNKtQT1noO/RFRGaemGHiTuxDlqM1D8GED2F0UubfZSAKaSphEmz7q8i8ywPsXkw0upiuzIeHB0Gzm0K1kLB3qT8WcnvMlBTtfMH9IITESophBkMHo/Gp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914355; c=relaxed/simple;
	bh=GSbYMRDHgekDn0QpUlut1siCyoLbFNqcoDlzOLwJF08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFmr9vHszaghzz9H9Ji0fHt913PAlIPMhzP47nMPEqfgM0ZKxK90pXJQvypjKLKZAp3McL8K2iPslq2OKAe5KiOM23NdS0kDkZ2slj1TUx3dKKehxrCwr3YJAnFdLa/qOj9Nj7f0yGkWWJVu3oQAKdkjwq/4YusoVufaagVObvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdxGdwcM; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdxGdwcM"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso2884271a91.2
        for <linux-sh@vger.kernel.org>; Thu, 01 Oct 2026 21:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790914353; x=1791519153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=id8Fgrp+2+bOjEjJtP5z9Vlf/9k7Y4aJNtzy7hfSJk0=;
        b=FdxGdwcMaeUZ3x0MbP5xw/D0wGgTYy6ubIid9gEqiLlX1QEI0FHJgkL6J2E/ZpXtBo
         kLeNTmHb85XYYQmvj1E5AL8FlR0YtyBFrAGMZ0PmzdxIYdVVvXYRTdL2dz2DJrynbrOH
         PTRGLjvf1DNlL8mXgTliO2FEcjCH994Z84Px95cRfeq6Vq7jXG6wJ/E/3mzjt7iKRCpn
         N7hZs2rzIyG1ILkyzR7VDotjXUFnzQWbuxh7jVuzDHRtfKZ7IdYt8EIeub0N1G8bZ472
         DEFCSZ9gw40F9fIFpV95yuIgBvSVGQiR940JE1n3Y/eOSlqhiXzr5wnNFXIacsKDO8q6
         Hleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790914353; x=1791519153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=id8Fgrp+2+bOjEjJtP5z9Vlf/9k7Y4aJNtzy7hfSJk0=;
        b=ZLlgUh1F6TD+TvL3O/PPlNtBn/ScgnOkK5MIVSRwzvjWXH7f7MPUVBNZqj2B+QhPuQ
         4TgNvuDqi7P70dpGiJ0177Ua4pQTcgiYdTY6DZEepG1ni3IIHL3Z5nsnYzDnfynMK47W
         j6NZNXcY1osf1qZCvYZg/mrTh5mfz6fEKanfYgNcb6g5GpjvEYQdHpopLMUu/v+uyNvd
         fFcWTQjOURX3HblYPP70wY+fFt8JfvnsjrqrOS+x4TGgVQh+eNsc6bKo/fmtiBKiJBe9
         5TdOSRLZ59eFCR2amPvYMpt8veLKYVqny/oQK43reCUsExe5Dz0eKAlZE4GUD0RlLAME
         DEbg==
X-Gm-Message-State: AFq9FYIK/+Sdg9zKwPdjo13RvRtGn02F0VEcrIRNVTkfMAXh2lUmzcL+
	lynCrxFVeifeBSr3DxxPFMaZ+kjNVjo9UYQKc3z+oacgyIdhnhwm4kjB
X-Gm-Gg: AYBFou2ZTgXLWjSuEgDEh2xUb4XCHlXobHgw8Q6oWUXS90UcsHhQ9TNIABavszt7e0C
	4ar8FuKe1v2wW2vTC2AmQ8zXXrz71t7EGH1UZB1LihsyOM5MJ/PEcaBF/7rwFfDB7DxjX/aQzsk
	49sQxqnVGLkKUNxqyIbOBtisp6mdZETOMKptOfUxoFLoNk+4YCBtKgf+soJENDQCEH7WZI5IWjI
	65BnWIxHAdqkMCIbeu43LF5zP4T8VEIT/VsXbGljyAAuikGKA+9CQo2RcqK9YDzJA0Hj3oa1WGQ
	T/GhZOXgjjF1xVGRUFHVMS5BPTNk96Hdt2n0i5YKL5AKa7skF+yRQKOwS7IEFeAvK7DcXmCo2NH
	w6Jmqog2VgSxvV2hGEu4pVCwT+fv39aaJ/0EZwssF57aYUa+GFlipD5J055fgToWj2r6t/Iqhzf
	nv6wdee8jEzeALRe4t1KAF7dgo8j8RGxzSum7G0WWH7Gi/6i6XeiMnj44PFULDsuRWtqfQy6V+d
	m+UAzZGmAzoEBk+S9og3ZlJKsHzYqkg2nMAVUYZil208U2x
X-Received: by 2002:a17:90b:2e8e:b0:3a0:9ed5:5420 with SMTP id 98e67ed59e1d1-3a6cecdb276mr1377044a91.44.1790914353166;
        Thu, 01 Oct 2026 21:12:33 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f680403sm3484055ad.25.2026.10.01.21.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:12:32 -0700 (PDT)
From: Artem Novak <artem122novak@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v2 1/2] sh: guard SH4 no-FPU compiler fallback
Date: Thu,  1 Oct 2026 22:12:19 -0600
Message-ID: <20261002041220.133911-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002041220.133911-1-artem122novak@gmail.com>
References: <20261002041220.133911-1-artem122novak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SH4 compiler flag selection falls back to -m4-nofpu when
-mno-implicit-fp is unavailable without checking whether the compiler
supports -m4-nofpu itself.

This breaks SH4A-only toolchains which support -m4a and -m4a-nofpu
but do not provide the plain SH4 -m4-nofpu option.

Use a nested cc-option so the fallback is emitted only when supported.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 7b420424b6d7..238c701ab14b 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -36,7 +36,7 @@ cflags-$(CONFIG_CPU_SH2A)		+= $(call cc-option,-m2a,) \
 					   $(call cc-option,-m4-nofpu,)
 cflags-$(CONFIG_CPU_SH3)		:= $(call cc-option,-m3,)
 cflags-$(CONFIG_CPU_SH4)		:= $(call cc-option,-m4,) \
-	$(call cc-option,-mno-implicit-fp,-m4-nofpu)
+	$(call cc-option,-mno-implicit-fp,$(call cc-option,-m4-nofpu,))
 cflags-$(CONFIG_CPU_SH4A)		+= $(call cc-option,-m4a,) \
 					   $(call cc-option,-m4a-nofpu,)
 cflags-$(CONFIG_CPU_SH4AL_DSP)		+= $(call cc-option,-m4al,)
-- 
2.55.0

