Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823A9488DAE
	for <linux-sh@vger.kernel.org>; Thu,  1 Oct 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837874; cv=none; b=L5pKhYB8WTcZEdaxxLg7xtV54SZ9o51JnhMmBornP5sS/3i2fLmpJvqathjwwjXuCXyheWn174cnvZN/3WVZ1K3mAqIrdN9kjuwtXxYOi54LXASjw7uMwa06130Sd5QQiuLoys7nab1m4VrsGsChl7too4VIBR+3KGNKdkFnCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837874; c=relaxed/simple;
	bh=oyGxfknbD70hR315BZAc8UNTJemd7B5UNz5z1PytFcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoRYNnVcuhb6TVegi+rh/zHbSr0i3UJns246MOfw99UK0JS6scKbdCVCmweHg7pbAElwO4gRb6rDPNKKPpV8jRtw7aS9qmlRCxGi39p01mi5VGWrCUm4fwd3Auasa/oRei4b4F4nVAygBwL1wFolh6e257YzDkBH0Cd9TBLInZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJTibrmi; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJTibrmi"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so3461220a91.2
        for <linux-sh@vger.kernel.org>; Wed, 30 Sep 2026 23:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790837873; x=1791442673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbv3x0usvUQFlT6gSLII0S/r79J2R+NYTfNWLq1Zy6k=;
        b=SJTibrmiCoS3k9t8Dy1JPkRuCAQLq2L7rXf3FTzQQv1Wro7Vdc+bm2D8c6s/c64fGF
         Z4kiNTwS5ag64vIqXolEil7NAVpbniZRrnDMyzNcnC73wmHziiphKtuy3AJu53cwMUFz
         m6WQqZ1OWJPFtVtijBODow1avTk9OYBjpsptJpX5gxXJmhIMNSQW5C06eADlLzPXXQk6
         sD71ENbWAAZuQtSJZM/CLP6pc3Ky1RrqQKdCembB+QfitGIscmgXw9ljQzcwkTFRecT7
         uDkVuDFIR9uQOlDPXdr2awRFeWmOGVWpz/DyIk4WosO6g5aHOhk4/O/JKQG3cnAPg+tG
         P1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790837873; x=1791442673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cbv3x0usvUQFlT6gSLII0S/r79J2R+NYTfNWLq1Zy6k=;
        b=unpP0F1QjqUmqhimw2i2tbyvkyCEC9+w6r/PDICffpw7vDN5HBSMLGpEfANWLSjMmN
         yrISyN9gC31hhRTNzGMvEhgvruPx4q+RB20Tdm9uwtHvVQcScXlcWhySWM46vzdbmhkH
         5mB3WkbGmDCd6VSsX/tcy6e+X4Owhs9CQ5t+dFNpKewFps/bS9DkNpiDgIGJrCUaTPeK
         8GL5IL2fBeYoJIrpBHH+ChVJYU/Qsfjahj0XM3qOLA051eoSIhgQMFpYSe2DKtHTXDws
         nBQqVEvYIgC9zQJJ6FZewGVXgk3Mf9TnDunXRSdJs8oJH7WEUcMIMnEk1S255qfqCDz0
         dX3A==
X-Gm-Message-State: AFq9FYK+xeQHfWNzb9Qo8noOs5IYj7/FpUXjCxujTNFo/LYceYEb+8Q/
	oTuOMkMQJSvwcZdMpXHFXJWFeGtwye/IFbtnmQa8R7Ovpf6qyLVm7qZnF2qKY08W
X-Gm-Gg: AYBFou12CRCXpmz6QjuRy1GegdrsDwQJ2mnGKGqUwt/09WUkVcAKWe2g55Swz3dn3ZG
	aUAhK3e5yvaasBmisVvKiHsUrsen0zUDnAOqdPKCZ6bsy7SNLUu2Ld8qc/3BzPhltlBzXThbHv2
	9ed37Iztzxd/xvouDaAtvUpYmb7bX/aeyYwLu3tbwUOUX5+I2s4xuTTmNjLpkPZ5B8MfmmdIQ8v
	y2bKeP5P7lmnpEgAcOxvniZd7C7ASqGCSbGXnIQV0UuPoCKvoaEX0NG2dPA7trqUeZ0p4XqjhD1
	UA8yyHpSqH1By4j0u6NqHcmEiULBPH97RWWiXLEgWceYiR0NJ7ZqsJd5xyBn38OdiyF6ea0YMiO
	nyL8qdnD+iAqZvb+ETAcujLjd3Obx7VDIvYRqwb2z1H0JHSrHH4Xz+uxTIsWlHHzkr13sVTvKTR
	VB7EWESvJmVOl+YzPIst30BGCvW5630a4b2jNFJwj1NTjsd5iwrNLI8K7idqZX+UB3jY+zyRl0B
	JnrXcc4CrR/oaM64IfdS5I5r9Xu8+1VEhHi1y1AeyzzGtwU
X-Received: by 2002:a17:90b:3b52:b0:3a4:e31b:9312 with SMTP id 98e67ed59e1d1-3a4fe5a7b0dmr908773a91.25.1790837872858;
        Wed, 30 Sep 2026 23:57:52 -0700 (PDT)
Received: from localhost.localdomain (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44d0a30sm2873138a91.16.2026.09.30.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 23:57:52 -0700 (PDT)
From: cacioandpepe <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cacioandpepe <artem122novak@gmail.com>
Subject: [PATCH 1/2] sh: guard SH4 no-FPU compiler fallback
Date: Thu,  1 Oct 2026 00:57:35 -0600
Message-ID: <20261001065736.753215-2-artem122novak@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001065736.753215-1-artem122novak@gmail.com>
References: <20261001065736.753215-1-artem122novak@gmail.com>
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

Signed-off-by: cacioandpepe <artem122novak@gmail.com>
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

