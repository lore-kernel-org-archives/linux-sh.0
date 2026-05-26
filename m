Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72681427A14
	for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779818377; cv=none; b=ZBa3UBpUv5GpGMaSSnZUFVIqgukNswdBDgdyfogiC8MNQ1ZOdxc4SWSdigysJWIiv9/+c/4ugk1aWjzOuvQQqYFmWkUxMWdox+K3XPvuoUgpCXmR5HyOXuDOISujRPaHOxoptbU5C7MBfu7AjKn24r5G6xN6aNRY7aKx2TZjnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779818377; c=relaxed/simple;
	bh=ev685/CJw382iK9z08ELcRr7fLfPN9V7kdOx6hU1hW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PLBhyx3rTTlh0xgZoOtiuKvM7qkrqi3UT1ZX3Y1699xuV3CwAfStZosJ7nusH+Y/E6ZkP0VqkddRA/NQh/GRD7lEbwbeLG8qU2+2ZAPmgUtI9NZmfuEBbsmDksP/NYNfmEn7XDl+G7tV2y5rTEyvrKdr5e+yN2TFtkLhzUG6eRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bxzhk6iW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bxzhk6iW"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49058e91639so23202225e9.3
        for <linux-sh@vger.kernel.org>; Tue, 26 May 2026 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779818374; x=1780423174; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YEs+3ha0YZ0GL65qiPfv2bavm0rO2bwvFUt4jkd+Vg=;
        b=Bxzhk6iWBaI6lCd87AuEqX+Pj9CMyxoolSzXMXMKq+qvnAklYTn8fTIpOZw23co12c
         qzqBZF8RjWrRE0hfoYFyto+1my244bRfdSQIB1w/iB+e0QWEtDw0oCsELa3AmcGyx+VT
         U9jpxwWqcRf9XGewjUyo9CLE3zigv56SMkQrIUVPWYSwhaLVSRFAF6rMfQmVkJJ/rbG7
         DuMGC/Pql9w9NQnEzcnu2r/nDJUxaiLdoA7Kb2rg9Hr0NK+pvpArX7YywUZKnqqgDFbq
         7PYCaatch8nKWSJm71uJAt0AOCWPXUiSi3dNiTPektdADBQeyNuonvN0K57g3HXkEcc+
         SHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779818374; x=1780423174;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YEs+3ha0YZ0GL65qiPfv2bavm0rO2bwvFUt4jkd+Vg=;
        b=IriZllG46z488WZoviqCjoSjaGYiiGnhwiid9zwFX+9Wj9lHHcw00QfyIAFfbN96ZC
         1m7zq4qr9YZ/TkYmOaQQbxWbzofwPYxZBe6NILRRe90AQZGU49pm0/cAm3045y4PRdjE
         PxKAHWVZO+BRrmSfwBgC5rMzpVW70NeHmnzPNVx5epQgI6BoWhDJamR8nwuhQx/mW5kt
         qd93+bh7kIhDjQa9WbiyWxMQ9GVX8KnlB9mKuL8NjKiKC2tGoCq3ZRTrx4GO6IuEte/8
         J9dI4252EU1ZCkI3k0ctc4qBXS8aP0pFUGc3AgA+irCXL28veJ63GIdZTRlbSqEOgAGy
         Lddg==
X-Forwarded-Encrypted: i=1; AFNElJ8rWdBAmGjCVgAocuNLIGA8dzo1tJXhY0KZpzwMRn+8eQBqxzSmEgCtNL+GGTCIguXfPAMTeJQq3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Iht2Pac0qfXe9fai6owu4XhkbGIVTXqnPa2dJZ4FDSZ8JiXr
	i+EPMqLHojRgErW7QIBazt2lMhh4dsdpzUrSh8UW/vJkFhZXm0IIEGD6f7ghuSgeEsAohI4zWg=
	=
X-Received: from wmri26-n1.prod.google.com ([2002:a05:600c:8a1a:10b0:490:49db:2263])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5298:b0:48f:e230:1d12
 with SMTP id 5b1f17b1804b1-490428dd63emr346556585e9.31.1779818373602; Tue, 26
 May 2026 10:59:33 -0700 (PDT)
Date: Tue, 26 May 2026 19:58:57 +0200
In-Reply-To: <20260526175846.2694125-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526175846.2694125-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2521; i=ardb@kernel.org;
 h=from:subject; bh=IVFHANRX1Y5B7sO2czLQgDyXUEkQiTSy8G1FQDCgg/E=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUv0fsoLbrWLu7gSw7a4He9yccnfFaz2Zfnzl9euX9kmw
 5F4//u9jlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCR2HhGhum3KqfUzpnosfjs
 O4PZz65tu/Cten/afJ4dmhfPiNRN+BDP8D8myOOB5p+Lm9QF963bJLbl3IvwqSc/fj98Oa1ZZH3 U5m2sAA==
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260526175846.2694125-27-ardb+git@google.com>
Subject: [PATCH v6 10/15] arm64: mm: Don't abuse memblock NOMAP to check for overlaps
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Now that the linear region mapping routines respect existing table
mappings and contiguous block and page mappings, it is no longer needed
to fiddle with the memblock tables to set and clear the NOMAP attribute
in order to omit text and rodata when creating the linear map.

Instead, map the kernel text and rodata alias first with the desired
initial attributes and granularity, so that the loop iterating over the
memblocks will not remap it in a manner that prevents it from being
remapped with updated attributes later.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 23 ++++++--------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 04cc579c7a15..b20c76b8381d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1164,12 +1164,14 @@ static void __init map_mem(void)
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
 	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 * So temporarily mark them as NOMAP to skip mappings in
-	 * the following for-loop
+	 * Map the linear alias of the [_text, __init_begin) interval
+	 * as non-executable now, and remove the write permission in
+	 * mark_linear_text_alias_ro() above (which will be called after
+	 * alternative patching has completed). This makes the contents
+	 * of the region accessible to subsystems such as hibernate,
+	 * but protects it from inadvertent modification or execution.
 	 */
-	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);
 
 	/* map all the memory banks */
 	for_each_mem_range(i, &start, &end) {
@@ -1181,17 +1183,6 @@ static void __init map_mem(void)
 		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
 			       flags);
 	}
-
-	/*
-	 * Map the linear alias of the [_text, __init_begin) interval
-	 * as non-executable now, and remove the write permission in
-	 * mark_linear_text_alias_ro() below (which will be called after
-	 * alternative patching has completed). This makes the contents
-	 * of the region accessible to subsystems such as hibernate,
-	 * but protects it from inadvertent modification or execution.
-	 */
-	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
-	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 }
 
 void mark_rodata_ro(void)
-- 
2.54.0.794.g4f17f83d09-goog

