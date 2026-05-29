Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF79E3F44E2
	for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066945; cv=none; b=MeyZM63UvH4U4VHcp1K0wE8pXdQMprYG3LT11A+rbNW7gdJ37s1dYqu0Qx2wCgwGZY8mBvj/1sTMinIX1b4d73w4ZfP2PK45kLjfQSREt/6N6juGGL0sKX6xvbN98JIVBvrJDCSRGIU6sDlDecA9uzM3FAUTCT3cE7sI8WgJtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066945; c=relaxed/simple;
	bh=MK4il/RyXbeZqS4oUFS19K5ZKkdBSMDJph3YVgjuPuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DZlWeYPaotwySY7g8g5S4uUQx/RNgCxpVPAUtPq4xE7qSP9V5rtHCHdVCQDTMbzQvg2WSn6wk4+bSdQlXTbDpebIw9uyBJ4hT0EEkyAnYTUGl2AaON92/5CFIQNcCu2qCaAu4HBptc6p2mbipw5Np0o3UTMk5k6hBGQ6EmTye0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCcGjhYR; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCcGjhYR"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-45ef66cc579so84074f8f.3
        for <linux-sh@vger.kernel.org>; Fri, 29 May 2026 08:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066942; x=1780671742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9SMbp+4SpJBPuSW3tE55txpooI4fjODhC3THY1otv5g=;
        b=tCcGjhYRpAgjs9ZQlg5nTj4fwuIXRojXh2ckb8TsgT25viMsROlKb2ET0dIeogpNHy
         0Ed5eSypvv8tNy/NzP8eZJMUZ/tOEpkb02mQ6lKKC3VWEKMwGbkeN2Qy+ffJiKwpn9i6
         e8BgJKUhJ/YPmn7X2t0EKM3SBRUodNbVo6Me+A/1BuGCudiIJFcxdol4JhAyoS8EsABp
         9zCX1PywkLAhGtHTXVAjUdAypNSeXM5PbDyZishE+kUW0mFfzDuPm/ZZMbi9Cw9RBaV7
         RSizPmAv6XaGhiPxXJAs1E1a/mHSkUOJZ2g83YopW3mEeDCPjAugnK3r5fbgr3BvSpTr
         75KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066942; x=1780671742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9SMbp+4SpJBPuSW3tE55txpooI4fjODhC3THY1otv5g=;
        b=RWaI3VmyE0nsGsJ8QiwhhNRpxqk5AhjbTuS8Sn51d3WxhH6bWkor6htZlxX36JYMzb
         AR8J6KI+PTvij/rdTv5EOKVhtr2JO1ZS8vy16tOLsrsbL9mcvWlL7l8RhdjAzEOnXUHX
         StkRoGwgEuCIMa9I6uPVkAb9KnFqhPldjufcMH5nn8G/ok3vp0002Uv8PSlGc6ahJpHb
         d15++kzT7v6XZR7HIYAwCO4P27fbDTHvrCpgG2jmnyR8KM847Uc+pSDgw/FnWBlPgdOs
         X+iXLEl4/mkLLYliuNhdt9G9rZbumk+EpO248v7maPOXO/nfR7OZtsVGW44FmbG2ZjQR
         3hzA==
X-Forwarded-Encrypted: i=1; AFNElJ/pt5CtYQNI/wPZRxwsv8qMIEpL2o17BesZhWgfFNaNu2mJceK7N4n89ls9dNHJ7yudualcKl52Vw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyheVHBcAEcUnEyr8LHVd0D+rFrIRGMqdZwIdmkfikLBGCO3jvb
	gSy2duB8b6knDKrLNmEoLihdKHa5453uwWr61vuRR3ArvpPx2luw5q47bdNj/4os0k3ZK5MTEQ=
	=
X-Received: from wrna16.prod.google.com ([2002:adf:e5d0:0:b0:43f:df99:cb43])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:b05:b0:45e:e3ea:1101
 with SMTP id ffacd0b85a97d-45ef6b3a9d3mr250438f8f.17.1780066942102; Fri, 29
 May 2026 08:02:22 -0700 (PDT)
Date: Fri, 29 May 2026 17:01:55 +0200
In-Reply-To: <20260529150150.1670604-17-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529150150.1670604-17-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1360; i=ardb@kernel.org;
 h=from:subject; bh=zgVblspip5ZINNAWS3J63kCjniwJXU0OYP5r0DXGxEI=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIUtyVfJJkczPYfGm/hd8+FL02y7q1vnc3l5lLz2B/bWeR
 ZyU8q+OUhYGMS4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJGrFxn+e55rMk6KmS+o8qjx
 TFPydss+tp/hHKtbs3vkHc/PO8RoyvA/WrE+UfB50QXpS/Hr3nSqW/oxK2XsCGS8dSmZxXNHTQs /AA==
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150150.1670604-21-ardb+git@google.com>
Subject: [PATCH v7 04/15] arm64: mm: Preserve existing table mappings when
 mapping DRAM
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Instead of blindly overwriting an existing table entry when mapping DRAM
regions, take care not to replace a pre-existing table entry with a
block entry. This permits the logic of mapping the kernel's linear alias
to be simplified in a subsequent patch.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/mm/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b2ba5b35c35f..5c827fa3cd38 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -256,7 +256,8 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 
 		/* try section mapping first */
 		if (((addr | next | phys) & ~PMD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pmd_table(old_pmd)) {
 			WARN_ON(!pmd_set_huge(pmdp, phys, prot));
 
 			/*
@@ -379,7 +380,8 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 		 */
 		if (pud_sect_supported() &&
 		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
-		    (flags & NO_BLOCK_MAPPINGS) == 0) {
+		    (flags & NO_BLOCK_MAPPINGS) == 0 &&
+		    !pud_table(old_pud)) {
 			WARN_ON(!pud_set_huge(pudp, phys, prot));
 
 			/*
-- 
2.54.0.823.g6e5bcc1fc9-goog

