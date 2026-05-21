Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168B3BBA01
	for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366733; cv=none; b=t+4yMpbemPQRvducRkQi+nc1J+XR7/eeqUAba6syJabKcxcNLL8tVBJ4HvQy0vFAOp8/0m0pIeP9cJ2Y9tQiy9UVc/wNYXkr3NklHKsmvbx3j7r+dikvlA9Ij8mtmdy8DEdLNdmelFuXAz6x6eGOTQtMXzuBgJMIpA2WQHIJF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366733; c=relaxed/simple;
	bh=jQnNgu0j4tUSjBrg581qH4wjHjeo2hEWtOuwpKYpmJc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WiP8/E+hPppfe4QqlnD6MK/Ziqn5oy953IUzI6HOH7BVFZWE4idbZ6QiL+u0ZpyGpU0nAK7c8Us36x2WjjWhbS3fzNENwaCGhBc+S5xwfMoGKE7ArdMtoXS3pQ5P3bSOVVzBwxNCxYuKc+YiOCbbJsxCFAToVLVtnW16QDJJGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk7b/WH+; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk7b/WH+"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so4948209f8f.2
        for <linux-sh@vger.kernel.org>; Thu, 21 May 2026 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779366730; x=1779971530; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o9Wpk0SWOqreAi0uU9R/bjkVXMMr/Jb9mNXoYTqNDRk=;
        b=Fk7b/WH+5G271T4kqifXk6JdHXqWMc+WLpObJnKNeeaH+ealzYK/8g0fZ0uLUU6SXI
         BukxXPseK28k5CjE2YnE25ZZZ7YsPprU/HE8G+QDKiYqCbHvU5tHdU5fENMVW6tdjTer
         YGVH/q6XNX9zYDriKpuoFPuALf3Y9mFKp6NT+EYqNKf1AuQ7pBcLHrRON4MndZi74U36
         UU6xBnPJYqJizVj4e234XafLPeII5AS/KhWIOKUsroi/kg4BJt7pnCuXJ+ux582URBo4
         +Ux052unD/6mHf2e/grJHcTEXU2UH1L91wXTpV2xw4R4+qsCjwLsgmnVIlke81+Pp4uR
         NaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366730; x=1779971530;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9Wpk0SWOqreAi0uU9R/bjkVXMMr/Jb9mNXoYTqNDRk=;
        b=p5lQsUAx1fRhRPHUlS62GyFXteW1tWU6QGyLD7DIAemOYzhgy9e6UT+H/kEZSS8PbD
         Lx6kZaoQk2xftmxg3fGPwru8iitegFfjqYe6Q8Lw+AumfQLYbTrkADLjqW/RIpn+jwSx
         YeAG4FJUpao+qVbjUt31isiDf5VvBRORrTE+gblVtxLeAGrYmewv0KrBX6UjjgE9pg9B
         XuFSC4pEde1TJJtyAs7gi9z/SXqNL+FE2+scmqP0uenHlErxuCkVREPzO+pruiMx2Hyn
         q89MGezQJkOqI3Rd/uMN34SVd5fQuZb/zpBbe2P1/dLqvikMv/41nduTJl4m5WgkQjzS
         b9AA==
X-Forwarded-Encrypted: i=1; AFNElJ/3C5o62ksHEtAbWUfZJpzjqj3WrSkrwRse6YS+3FA65TnXxlUcU5SwAqOCRmBQn6pyQCRXvg2UAA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qr63JJqqW1PnUqUZyxN2iqqkvKNerlCmOFpwzFrvL4ira8NG
	suPgVgU4dk7ri5fd5KoirfOzYV3wZiwOyfSt9b5eGuWWtj3LyZ49B0hh+2hPyLyXHmGHzqDOLSr
	Pfg==
X-Received: from wmqo22.prod.google.com ([2002:a05:600c:4fd6:b0:48a:6051:b5af])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:a04:b0:48a:97b6:7420
 with SMTP id 5b1f17b1804b1-490360e46d3mr36961525e9.24.1779366729894; Thu, 21
 May 2026 05:32:09 -0700 (PDT)
Date: Thu, 21 May 2026 14:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521123205.146268-1-elver@google.com>
Subject: [PATCH] sh: Implement _THIS_IP_ using inline asm
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Both GCC [1] and Clang [2] consider the generic version of _THIS_IP_ to
be broken:

        #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })

In particular, the address of a label is only expected to be used with a
computed goto.

While the generic version more or less works today, it is known to be
brittle and may break with current and future optimizations. For
example, Clang -O2 always returns 1 when this function is inlined:

        static inline unsigned long get_ip(void)
        { return ({ __label__ __here; __here: (unsigned long)&&__here; }); }

Fix it by overriding _THIS_IP_ in <asm/linkage.h> (which is included by
<linux/instruction_pointer.h>) using an architecture-specific inline asm
version. Additionally, avoiding taking the address of a label prevents
compilers from emitting spurious indirect branch targets (e.g. ENDBR or
BTI) under control-flow integrity schemes.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=120071 [1]
Link: https://github.com/llvm/llvm-project/issues/138272 [2]
Signed-off-by: Marco Elver <elver@google.com>
---
 arch/sh/include/asm/linkage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/linkage.h b/arch/sh/include/asm/linkage.h
index 7c2fa27a43f8..af56b38b6001 100644
--- a/arch/sh/include/asm/linkage.h
+++ b/arch/sh/include/asm/linkage.h
@@ -5,4 +5,6 @@
 #define __ALIGN .balign 4
 #define __ALIGN_STR ".balign 4"
 
+#define _THIS_IP_ ({ unsigned long __ip; asm volatile("mova 1f, %0\n1:" : "=z" (__ip)); __ip; })
+
 #endif
-- 
2.54.0.746.g67dd491aae-goog

