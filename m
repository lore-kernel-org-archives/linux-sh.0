Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCC3B52E4
	for <linux-sh@vger.kernel.org>; Thu, 16 Jul 2026 16:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784220816; cv=none; b=fGBEpfnL6g9MgfhL365LyOecebA0zX+kmHGXC+N2EQjTDZ2OXlphPv86KQY/ygPQHGQ5qD/5elAN1etac/GpKacuMOHOHVvFQoUWSxpY9RUUsdb7cFNHjwKEUUtqm5JLZC4GhkJ2NM8jMGb4X1PXijL9OjyOBP/No7H92V3iGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784220816; c=relaxed/simple;
	bh=yVWxVr5wCqho7aaBxohfMNyIFAx0zoDuyCrt4dd+8E8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJzgXYZ/eGZ98n+a3aULY/ulmisivUXfbNLsyfdS00HuoEOKutWZBamHSoPakJCOtBvsFq6KcBH9/MPv9lXpCA96qjYwAG0eSOuqm68prnai0Vhjdb3zZi7yh/mACMH7EhyKqcRoq+3zmxrXBbs5tYBT+JR8qfDczBJeUG7qsaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxZZnljx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxZZnljx"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so55864815e9.0
        for <linux-sh@vger.kernel.org>; Thu, 16 Jul 2026 09:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784220812; x=1784825612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qsv/ssphIw4w3J4xbQsRhu6PDnBdNECQZb2Ca+aq2GU=;
        b=dxZZnljx1OW8qCGMCT8jwmPZsYDZJ0NlZpm8UcyR8iWkWvyVS2c9nV5Px3/7rx4p0R
         7l7lyn0hVPfqPAt7OzC1dOUQWmf33uTm4hV5xw1lnNMxZ90bOXFbqCQxINNuL6UFYvLc
         7SSNgWbN750Bw8JabDvFFWSXL4emVy7KEsD4/KHXcUeiW+WLxv3L+vyra+jufdndKgdF
         cJQINitNhY+Tzpi1VVeKrOeG3ypjrziGuef4o7Pu87oXptzbLs60kOyYlRkDrX+3sZgI
         frTM353wDO21haQimfX9I84N+rz6p32vumaoU9Vq04JNI/iql71K16BNGElJeqXNzTan
         AVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784220812; x=1784825612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsv/ssphIw4w3J4xbQsRhu6PDnBdNECQZb2Ca+aq2GU=;
        b=E9Edilh/W66TYFrl9aAGNxjKF/3r33dklOLcfqFS9CIHfOmXE6gadgKP9SktHcaFRL
         7toyo/P3gYuDrHu66zr821/PEERpK7o1IDxt4jGFwuG2bpemR40Z9YJH/WX5SkHCHFGW
         JTAEsLrolMkPf5gWY4lPS1A6PPcIaol3BaZJDJ+jnhMO9fMt55QfCMMrlwkSJLx92dwH
         Z9+aIWtyJ22CFIdJuJJehNrSBOBu3n28etwcvM22SOBME5J7xvmgUaoB/RjHynS54+js
         lp3BiYlBcpACpDB3Vl9sL/b944mZuMBNEVMdeklkF/r3GXZxjvebynWum1RJpymX82Vo
         1i9A==
X-Forwarded-Encrypted: i=1; AHgh+RoP1fad5a8SC8IBnv3ZYuCHwc+8ErGQackIL97zWclo5zf6c7apCAINsaWs/QtBDFSR9hLrchRCrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/XCKUnzmHzi38+jBkCRYXBva12NrGP6WKB3geRBnmdBylg+Z
	kw/TY9z6SES8eg6DBeuN+QHLJkKBbYXoza9o/cFyYBdCzSeCe9lynn4=
X-Gm-Gg: AfdE7clQXQputqzd+1+l5a3RLJDvjqbcIqWlZ9H+WEy4jgUGOlGehHCVmZdyMHD6edu
	A9pW6wnMlLevkY38zFwl7tm8zqa88c8FpfZQuahGE6JBtX8Zb7nBsHtzhYZn3nK2GJIjIidezjw
	eFlOnok1GVZUGgYNvZr6XdP8G5HhI0i9finFc/NChON+yZrF2OKFMG5yBh5soKOgfy689YvvEc+
	yV4ZD6Y+lMPS+Q2jYhIeb2crJ+UBXwa++rSs4htRcCT/se8/qOVNY0xLu8qjWLZe7NOos+yumgq
	EM2VCSA66BXF7lla4B1GNTUkEBzzvjqG7wGtjL9ub+fdtq8+C8dF16zD7h12QVhYJEPegQxjMAh
	KiZrtu8l05G0g0PIaggQPrUnCXLgCOwPms/KnEthqIRTjjbrC6qjGoPeXOH0Wk8pg5PWjy6oFgC
	m7PGOpo6TV8I/O4fCiurrNgJzQMPpfAOFJEZ1FFw5EaBZKkXJHHlWOU6QU4pM=
X-Received: by 2002:a05:600c:4fcc:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-49547523de0mr12594045e9.20.1784220811600;
        Thu, 16 Jul 2026 09:53:31 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:257e:feb0:16dc:a8e5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49541eb7372sm96044945e9.13.2026.07.16.09.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 09:53:31 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sh: uaccess: Require offsettable operands for 64-bit user access
Date: Thu, 16 Jul 2026 18:53:29 +0200
Message-ID: <20260716165329.3418962-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 64-bit __get_user_u64()/__put_user_u64() paths address the memory
operand as %T2 (base+4). This base+4 requires an offsettable address,
but "m" also allows the indexed mode @(R0,Rn) (e.g. for a variable-
indexed array element), which has no displacement field for the +4.
Depending on optimization this build fails with "invalid 'asm'" or an
ICE in GCC's change_address_1.

Require an offsettable memory operand, allowing GCC to reload an
unsuitable indexed address into an appropriate form.

Fixes: 2d2b308a8b7d ("sh: Implement __get_user_u64() required for 64-bit get_user()")
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
---
The patch was verified on the J2 core on the Mimas v2 board. And booted
on the Dreamcast SH4. checkpatch doesn't like the missing whitespaces
around : I preferred not to touch the other unrelated lines, so I kept
the local style.

The original GCC ICE, without this patch can be seen here:
https://lore.kernel.org/linux-sh/ef22a5de-d945-4080-9f4a-f5a1ab9de1dc@landley.net/

 arch/sh/include/asm/uaccess_32.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd..cef40414bfb1 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -92,7 +92,7 @@ __asm__ __volatile__( \
 	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
-	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
 #else
 #define __get_user_u64(x, addr, err) \
 ({ \
@@ -116,7 +116,7 @@ __asm__ __volatile__( \
 	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	:"=&r" (err), "=&r" (x) \
-	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
+	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
 #endif
 
 #define __put_user_size(x,ptr,size,retval)		\
@@ -196,7 +196,7 @@ __asm__ __volatile__( \
 	".long	1b, 3b\n\t" \
 	".previous" \
 	: "=r" (retval) \
-	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
+	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
         : "memory"); })
 #else
 #define __put_user_u64(val,addr,retval) \
@@ -218,7 +218,7 @@ __asm__ __volatile__( \
 	".long	1b, 3b\n\t" \
 	".previous" \
 	: "=r" (retval) \
-	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
+	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
         : "memory"); })
 #endif
 
-- 
2.43.0

