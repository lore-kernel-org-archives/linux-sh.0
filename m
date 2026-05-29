Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6373F9A1A
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066955; cv=none; b=C0S2yM7rzclv/Y9AVancBefSaNozxnfuw7arTzw3XNIrD1uz7vk18LSktKJnFERup9BJfqN6Ki/DuiL84dIj+i9QCKvDFYDP5T0VdeVXfCS/yzVtpCxLaOk84itdODTsQ9LSlZnqorpSewSKlJnDqLjXXIL8Dpl8vJBKMaKtgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066955; c=relaxed/simple;
	bh=rxjhw6NCkFydv9twVpR1AtWCBWmKfNC1CK4SdAjRO3M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kR0zXx1EW6ksvSztH/HJbJHDnA1Kl0qyZ+hg1uINFACAhPA6PkzBNldb1frhCHevQAJavwi7YX82eN6W91JNRxOBsOlZKPGDrSkn06DHQe+uNGW/yZAQjZhq9jJrQjqP0Tedx1PLFkjjPvBJc2Yw/YU5dpwws4aCbrN2I1YLNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fm5KpZ5V; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fm5KpZ5V"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-68b6f4f3c06so1652968a12.0
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066953; x=1780671753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EyPAfNS2y6WG0YPoe21sR6PBixrZIgpxdj99NPdSN8=;
        b=fm5KpZ5VFx0WhY9lKuc6Q9RtRY5g62KFHm1cEaitsrlLrktZT7GyocYML20WldmM9u
         IDLu9LQ+FQGMsoZz+B60VSsacRBJoF8LX9M2IRujRt/zgSSNd3vPbesBWL6vyYgt6xQz
         +1NUYXHJsddmroMV7zEpi3yaPqKHLIljp/hptOmqUn5et7UBhXv3Gp3JMDoXlBYobJvS
         pdMnNwCWObB9BTgWi6q/HQxPpdVwg+WH+v/FNZpmyRabnEDXRi2AoEJcDA74KcZZ9pyf
         8DE9WRb/3U9/Jg8IWLg7o6DANMrI5c/3f2sjg53Zyfzto1g9icmdswkkXkhw+KaSk+Ub
         ZFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066953; x=1780671753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EyPAfNS2y6WG0YPoe21sR6PBixrZIgpxdj99NPdSN8=;
        b=PVDLhNzXwcFNfs7jWyjZgqLZMi/zbEoYLjTTF5d/DEEtvIJ++IUG0mNjXofG/AggYc
         rJxxK4Ib2dbXASJkj5co2BWGoQZv9rQieko9Tv9KJmhTtJaiQncsibfUnYJVZVfNiSED
         qzVEwEw16Dap2kK2ShRwcOT1P6S7E+yNZLDNi418YCUNl4qzR1CZHAJGbRUWSVfgqlhQ
         4+415qI0JuYOMsR5tg7pUGbrB9K2JYruJ7fWePaFQvPFiQI4SRV/XAmfvpYas1gYLVlD
         Qdj/04z0JU7xZaxBzxOGhitkDVO3Ff4Iwo8salkFnrUItx4QmxSh8zut5VFHM9Nju5KK
         1y6w==
X-Forwarded-Encrypted: i=1; AFNElJ8vuMV75qXbCbGspKS/FjVWSUDGOXT8b63zZiX+vq9Lhg2OEeY9Uxcih703CshJvDpr7uOAeBndqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCNSo+HNfprEoU8Bp0AVWzzjCafYausCdsfA+XzvhZUQNJduV8
	TvjPCBHbAMapsp+S5sTkazxfloT3um3QC8KrwkL3Y0YbAmLLtlpUGSIO+7oq124YeOcLkSlKQQ=
	=
X-Received: from edpg3.prod.google.com ([2002:aa7:d1c3:0:b0:68b:f715:5345])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:a29b:10b0:683:be46:c20c
 with SMTP id 4fb4d7f45d1cf-68c8a65763dmr15813a12.16.1780066952419; Fri, 29
 May 2026 08:02:32 -0700 (PDT)
Date: Fri, 29 May 2026 17:02:03 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=ardb@kernel.org;
 h=from:subject; bh=4saoJOhT3cEc7dpWXJZksxFCf7gWJDz5CDZcsy0RHE0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVe4Vpn2a3EuL7z5c9yPshq/FTf8NSmKzXz68s33ZB
 ld1mYh7HaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAibDIM/2u5Yv7kFfP5v2Ww
 OfqOx3NBpOKey7t5vhR6LI5Y9SY78z3D/5SO1Jh354yPPvIQfsjEWFAfIL3vxawn2VI8ya8XJ21 dxwwA
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-29-ardb+git@google.com>
Subject: [PATCH v7 12/15] sh: Drop cache flush of the zero page at boot
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

SuperH performs cache maintenance on the zero page during boot,
presumably because before commit

  6215d9f4470f ("arch, mm: consolidate empty_zero_page")

the zero page did double duty as a boot params region, and was cleared
separately, as it was not part of BSS. The memset() in question was
dropped by that commit, but the __flush_wback_region() call remained.

As empty_zero_page[] has been moved to BSS, it can be treated as any
other BSS memory, and so the cache flush can be dropped.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/sh/mm/init.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4e40d5e96be9..110308bdef01 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -331,9 +331,6 @@ void __init mem_init(void)
 	/* Set this up early, so we can take care of the zero page */
 	cpu_cache_init();
 
-	/* clear the zero-page */
-	__flush_wback_region(empty_zero_page, PAGE_SIZE);
-
 	vsyscall_init();
 
 	pr_info("virtual kernel memory layout:\n"
-- 
2.54.0.823.g6e5bcc1fc9-goog

