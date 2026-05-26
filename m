Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785AA429831
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818381; cv=none; b=dbqwFgjI+D24F+nccv7IttlXu6fgz2Th92RS1fQBy9xnXICVKBMVdSdv1gSGKoVcPmQnKbVPGegegyC3Pfv8ZbyRgPCUfHqNdglxbzhKkx/RrWv8j6Jh4rtPf3gvVHHA7xFTiTr7XW6e7vix5rygY+BNRTi9BqhFrYwOvaL6BOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818381; c=relaxed/simple;
	bh=Dv+z+rs70M0xjYisYL9XokmSShn9jQLiJBvjCaKzxRg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UuvJWc3xyo0TInpJ392Px1TWdKZbMnWjE6V6L5B2eQqtFtRGVavg0vxQrKxONBrP7CflizxBFMqUyuobQ/5KUsJZ67Qst9qx1bK6nKWghmUDjboCe8RamN4Wp7ggjB+1IhnlXgesmynqtPvdH2sLDCK2Dbpjc/ywmre5jyjHiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8q4TckL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8q4TckL"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45e55c44ac1so8609628f8f.0
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818378; x=1780423178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjw03D6SHFyZLBNhPne++YEq9ou7VA2sQlGz9HbrowM=;
        b=O8q4TckLnxHv7C5X/pJXidT5rlBtOqeBDdjao1Seu1Z0eFPL9doj6XQG1JE1MJI+Uw
         f0gWZYb22xKhGlmEB5U49acPfnAODCZ4tNdsYbotSpxkO7CysJrHp1Bti3OF2DMCZuYR
         lKNDbtiTdyhWgI57+Kkyux9FAquHl5C5Dtkd1zpqxu/MoX8bmw5nqLznLDmJ6HcyFyO4
         UEY8iDK9QH6K+K2f7gpy2uLqBt0ds+Mix9N+lbC79U+9BoSDeNZx9MyjSoYQe2zWD+KE
         QkQGys4i7yvTGPVGhVXlVQBG5EWf4Twofv8omymt5vZd5DWA28WuNMOjfTt634hedt/l
         a0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818378; x=1780423178;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjw03D6SHFyZLBNhPne++YEq9ou7VA2sQlGz9HbrowM=;
        b=ML4teTAR7kSFKGM4y6/+1Pl+iEZ/14yq+YMY8tHI09xyX5F5f1S1OHpj0fHUhslY2U
         uFTP7Xwot10Olf6ghjc9axzT+bi0XMMXdvQk628sUYtJrjVKCQcS6smBCc+A1UF++wvz
         TIdxSdQbyPIcmcIMRlhpms7kxqP2yS7RsP9OOsAxI8ma2uoaUI1xHoT0jGgOt03JKG+N
         NPNP/Zy/rHchg3zytZTVj06ghUWyjn9w/BtIEDZjnRk0U7reEgqfK+2F3/0un0/cnvSF
         1yRdHjmotyrJ/F5/qINO2Ibtpc1rsAkP7Vl+i2geigKdqqWYPLVGdG7BsRxfMD06jcF+
         K4Rg==
X-Forwarded-Encrypted: i=1; AFNElJ9sFiLiifPZIkHYa2ISfD6VycMq9eUhZ+4EqHZxi2MecyHoMVC4LuD77DxGvucfg88KBZL5M2TJrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylyZ/VZybaNAQPZ2bBuYwP9DmICcCG0QYfOkRGll9S+Ho4bEvc
	7X3RzBpqZK3GO/ql7Uz4JvBJOvbZVLrslbEdMq1AjHdr8xH590DxIPSf5gHA9zCqh3wNgtHrZg=
	=
X-Received: from wmog11.prod.google.com ([2002:a05:600c:310b:b0:488:7f73:f59f])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f88:b0:490:50eb:b777
 with SMTP id 5b1f17b1804b1-49050ebb9e0mr289239055e9.5.1779818377750; Tue, 26
 May 2026 10:59:37 -0700 (PDT)
Date: Tue, 26 May 2026 19:59:00 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1330; i=ardb@kernel.org;
 h=from:subject; bh=P6+9rEICJJwtkUC1X6hejRp2Q1Pr3xumYehGC6YytMU=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fobew29CRUaVxU/ZtLw+1lwTWmzi/Jj1qSv70V6Hy
 z8YV03qKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNpOcfI8HBnlRjjxeVTqlfn
 ZXLs3ZJ7bJOj+aZIhVt/dgfO0n5tlsrwz8LsvO1Fp6MbfH7/PnJz9VaPp6kP950W7qm/NTevLfh YHjcA
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-30-ardb+git@google.com>
Subject: [PATCH v6 13/15] sh: cast away constness from the zero page when
 flushing it from the cache
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

SH performs cache maintenance on the zero page during boot, presumably
to ensure that any clearing of BSS that has occurred at startup is
visible to other CPUs and DMA devices.

The __flush_wback_region() function takes a void* argument, which is
conceptually sound, but given that empty_zero_page[] must never be
modified, it is being repainted as const, making it incompatible with a
void* formal parameter.

Given the above, and the fact that __flush_wback_region() is in fact a
function pointer variable with multiple implementations, take the easy
way out, and cast away the constness in this particular invocation.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/sh/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 4e40d5e96be9..acbb481cdbfe 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -332,7 +332,7 @@ void __init mem_init(void)
 	cpu_cache_init();
 
 	/* clear the zero-page */
-	__flush_wback_region(empty_zero_page, PAGE_SIZE);
+	__flush_wback_region((void *)empty_zero_page, PAGE_SIZE);
 
 	vsyscall_init();
 
-- 
2.54.0.794.g4f17f83d09-goog

