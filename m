Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1C320A0B;
	Mon, 13 Apr 2026 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077242; cv=none; b=MsWvq+Pb7cay/L7+aPzv7Q8Bk0vlePeQnq0Pgc+0/aV0XCHpvCvFfga0O0L8i8QlWnVI5ch1gmeOVdXMIrJZSsityovYKwOUnEltlg1iYgIfki/iQXOKZk68vYKmkfvsxQqT3WflqSsnX7c0BYHwvN10jSqEkJrReMTb47cM2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077242; c=relaxed/simple;
	bh=lvY8/CoxdcUj05A6GOXsGloszNtYBaitN2QjjVRBlcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL9XQgHxyyNOyMvfY4xc+2c9I474se/kFNRAFai3fl8Jt1CMcPMW2Y404/7XyAgQJjQNYFZ+KNLIrMkxqApRpzCmZSDCG2eMRCZH1LeiM7qIxH8nL5hW12aW663Wacu/fLd1H4MA/Eq7A5PyNOfMwRKCze3NTqEVvSvW7g6Z68Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTILtthu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTILtthu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2E0C116C6;
	Mon, 13 Apr 2026 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776077242;
	bh=lvY8/CoxdcUj05A6GOXsGloszNtYBaitN2QjjVRBlcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iTILtthupm/4gmTKWZXhsMVLE/4dux9MQkCta1L3VKbjBGwi5rfxjzuidNR8jJmbS
	 t+eNE63HRvaO1KaZtgDsAuZncVcKioArKuGmD8/p75TUb2W2DOlMfUYfYG4VUOc+3d
	 eYIKCKIP+7kBFqIT8JkKHCWVea+/dR+zvY7IhCq/XZxMqHUh+VaMo6hX7rxQdPE/B2
	 1z3CrDCo9skf16ez+6F3y4a1gJasZAEsk13quWWOr+wytIygw/Nu+JqOHtL2+vJ2Xx
	 4GKDwPWZq7expq914q/QrGEqxeCIgkfP8TkE2zjaAKZ8PwZLVX4Y549b09ginUYcSa
	 926oMD0kxLmNw==
From: Mike Rapoport <rppt@kernel.org>
To: linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@kernel.org>,
	Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/10] sh: drop include/asm/sparsemem.h
Date: Mon, 13 Apr 2026 13:46:48 +0300
Message-ID: <20260413104649.852228-11-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104649.852228-1-rppt@kernel.org>
References: <20260413104649.852228-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Move MAX_PHYSMEM_BITS declaration to include/asm/mmu.h and drop now
unneeded include/asm/sparsemem.h

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/include/asm/mmu.h       |  2 ++
 arch/sh/include/asm/sparsemem.h | 12 ------------
 arch/sh/kernel/setup.c          |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)
 delete mode 100644 arch/sh/include/asm/sparsemem.h

diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index b9c9f91e6616..def7c1edd605 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -2,6 +2,8 @@
 #ifndef __MMU_H
 #define __MMU_H
 
+#define MAX_PHYSMEM_BITS	32
+
 /*
  * Privileged Space Mapping Buffer (PMB) definitions
  */
diff --git a/arch/sh/include/asm/sparsemem.h b/arch/sh/include/asm/sparsemem.h
deleted file mode 100644
index 4703cbe23844..000000000000
--- a/arch/sh/include/asm/sparsemem.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_SPARSEMEM_H
-#define __ASM_SH_SPARSEMEM_H
-
-/*
- * SECTION_SIZE_BITS		2^N: how big each section will be
- * MAX_PHYSMEM_BITS		2^N: how much physical address space we have
- */
-#define SECTION_SIZE_BITS	26
-#define MAX_PHYSMEM_BITS	32
-
-#endif /* __ASM_SH_SPARSEMEM_H */
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 43d0f7b62b03..99f52d888aa3 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -41,7 +41,6 @@
 #include <asm/smp.h>
 #include <asm/mmu_context.h>
 #include <asm/processor.h>
-#include <asm/sparsemem.h>
 #include <asm/platform_early.h>
 
 /*
-- 
2.53.0

