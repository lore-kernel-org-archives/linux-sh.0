Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF00F5FDCC
	for <linux-sh@vger.kernel.org>; Tue, 23 Jan 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970168; cv=none; b=KddFKdycp1fKwbm5OIaHIE9V9vGH45Bm6VTzks3rsRInvwdBllZvE+9tkKVAv3n7NWFLH2Rt20EdeHWBZtGdNtOrGIW51KKO6XBbCeddTh+96rqE/kqE7xb/FQzZvmE+LuoBB5VIqrEjEtjp+kASi1KJ1hpSdr+K0k3b4rj49bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970168; c=relaxed/simple;
	bh=ZK9PQLCXLKqeI6EmNJVF0wuj6cnB4GzhbTbrgojBZ9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+ZaFjb+n+o0T34M3YLrMGDR4meINTljSnVd9Pd8A39rxyk6KPkTQcQlAktMqMFHT8Bueh8zgNYe5BymU53QAORG4wKgSHf4/65r5NBuBpHQG6Qxr93yQeysoqvC3KSW2Q7w1k4L7Cd97nzhEb/eGZtfsDHt18r1YmINqLEPKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kfSIlFZA; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kfSIlFZA"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-598699c0f1eso2026825eaf.2
        for <linux-sh@vger.kernel.org>; Mon, 22 Jan 2024 16:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970165; x=1706574965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6q/05jnWeDl9wgQC0c2qm9hOe5mPaDwj5Q60EimLqQ=;
        b=kfSIlFZA6fnZU+ngo0vOwEzFDExHHTpN9Sow18ZXhBmwklUjezd2BJwZiMKy0piJTl
         4S/GC0HoUkS+YyL+Os4PbRA3MBBX89iR5oWnbdTnM7yJzHxrTZIRFmOU53gEIPpylooi
         prjdon2a1bSZf5Zp3sMoN16NHSNlQWhdqYDCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970165; x=1706574965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6q/05jnWeDl9wgQC0c2qm9hOe5mPaDwj5Q60EimLqQ=;
        b=TC1cjERAcr5WuM7tnkADacMfcBsGKRhwh7TcDd4QC/lsxiKST8e3OWCz1i42QlFbLV
         Nf+oXJrlmxAX4Vmdj68K5+M0sBqrhH86NpYlMhKHMRhvM5thjjhW+bEi8qG53gCp9+VQ
         rLThxYzcwWrAWyZ+AUHDjQ6VUx2yH+jiZz554ooSzvgKPs3OKTSVhTSULLWmvht1Erxe
         UiSiVVzxWzK8pwmPSVZaOAIfqs/+R/bwMytiEowRlsMj3ky4eVwZmfWj28M7Pd0Fo3jR
         0/hMSTcI3jW6vdntMEzOVPGC8VzzSVoSVpBYjBLIbXG+kJoY8jHdfQiwxLFoicsIVBcR
         K5yA==
X-Gm-Message-State: AOJu0YxLveFYt0ZYV9Arc02Oa4PiNRdzlV3leeijjo6J2ifgtYGlISc0
	w7KFeh5TVPtNBZd8deSO3TrEQ8D78PtoWJhz5B0bcdhduO8e3C551dmQBJBMvQ==
X-Google-Smtp-Source: AGHT+IFKzSLUEO//rfGN7z0yklmQ5nmdIr50yIhfprlff4HJFkLJGsjAr2HPDwPu40EicdjBjXXTcQ==
X-Received: by 2002:a05:6358:6f89:b0:170:c91a:b466 with SMTP id s9-20020a0563586f8900b00170c91ab466mr3835144rwn.23.1705970164998;
        Mon, 22 Jan 2024 16:36:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 8-20020a631648000000b005ccf10e73b8sm8711311pgw.91.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 73/82] sh: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:48 -0800
Message-Id: <20240123002814.1396804-73-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1873; i=keescook@chromium.org;
 h=from:subject; bh=ZK9PQLCXLKqeI6EmNJVF0wuj6cnB4GzhbTbrgojBZ9E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLPxEAqie9ltCp6SXpHxJz4a8frf9JpRCdW
 Ks3k+P95JSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JvckEACcdyYY2SIWpI3UA8mAOkYcOxPIionsaXUa6hl6QfIhatPHcfLoS0jDS13mORx6DesE8QR
 cEMphGUFZaW309UODp7aj2yCE0TFoSPXkaVTK17BfmoRQIwhtk0f8XfbAE5ingmsTuXMtAnJOsC
 TuJCmFXEgdPGKvUH3Xb36aFDcfbo+XCAUnEJNX2SZCgGukPkeLLLbjS8PvuLCJtMMEnECnnR1B1
 G/OOQHRWemIAHGZHOxhqiqTULKLtQDEb9ah+eWfzVXVhPlSrg2dTXOvPz6UzqYDBuoGKwF5BOIt
 eXzxRTA/iyaVaOWQawo8BpS7RbJQO6ZgXrwtWcTjjEheh7JWOgHGzCIKRfW2kG45QTP3evtFpIA
 kOvZdB51R6QuF6t47RBV550QbgsF80t2UmsPYjsToEE0nPBdZ26Iq3l2lQxqDG1fxHv71r2LzjW
 DH+rai0uNuRUpzJ7IMpon9RPoW2yuFaProOmaiX21mVY9baklpdewo53p9mh/6iRCJ/vuUq/xSi
 kmUDoE7kbNyXIda7pkfffdCgpbBKQDzjA8F8iTmT9Zrw/O0z3Om2bC/qlgXNnZQLwenVATU5Qrj
 1otM6joYjNE87mYWGpZ614abu55pynw/87WeqCPNKZuArSS6+IqDTjPVGcwDtTjK4KqNff/y6iO TlhNUzg3ntPt4Qw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sh/kernel/sys_sh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index a5a7b33ed81a..e390caeb8c00 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -66,7 +66,7 @@ asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
 	 * Verify that the specified address region actually belongs
 	 * to this process.
 	 */
-	if (addr + len < addr)
+	if (add_would_overflow(addr, len))
 		return -EFAULT;
 
 	mmap_read_lock(current->mm);
-- 
2.34.1

