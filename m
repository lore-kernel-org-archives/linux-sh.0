Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FBE396B68;
	Sun, 10 May 2026 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421381; cv=none; b=puBWysRDNcki3rwtljG6QrsM8aj5Dq0EBKoXrh8CKNZZ3mazVB03JuXH/auCTiP6ae1EFmFJ1loJWyjyIjfJAGIG1t1dTUAcWlEg6WI9Y2pRnGgs9i0NkBNZsEAD5K2km2yJLiBU9jktlpVYVj+1Vpbe42KhWLpH5tDvLcbnNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421381; c=relaxed/simple;
	bh=FmPjppYqmtQ/uCHJ2PqO1Z7RqOhpoVQASPz+LWTt2U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEKPANrDKIfQJtgsIuucuyJGQbp7mKQETotam6CxQIv1e8O+cFYPlfiM0hrkRUtxTrbKw3/3NrZkoGP925dGGzJPnWfNw7GPoceTsaKxK4j81oZ1gpjOpu/lptym5KI5pQmpdnJCZQh24c4JDBOdwYecxv+kqyIlO5BMjl5LfVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9CIBPRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9CIBPRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC5EC2BCB8;
	Sun, 10 May 2026 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421381;
	bh=FmPjppYqmtQ/uCHJ2PqO1Z7RqOhpoVQASPz+LWTt2U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9CIBPRsZwQvXiffEJfhuKEtVBvOPUiu+xxmZSpQoK2RCxhlOdidlPjYaH2ztd7u5
	 KyX78ObrKB+rGxIqadOoTOVCkVEN/1PmRcQ4vWb8SHzANQKzON+YmsBOZQIpGVbMDt
	 w79lF9elbmc2lpNeM9axwfznH2tej84bXIflsCl46luttE5qr4Ul22mGHi8miKHIV2
	 eoluVt5KARwhPmLaJaAXB6tnQbWswiOkJNYLte4V5mBwd4+dAw7Ekd0uwip5XSj0bN
	 NcBxOb1iKa2n8j0f+FYBkaH+UpYBoNUPp1NrJC1Z4UdY8GhWCN3paZ5B8dA1icDTTc
	 seOWZKHxZa7dQ==
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
Subject: [PATCH v2 10/10] sh: drop include/asm/sparsemem.h
Date: Sun, 10 May 2026 16:55:46 +0300
Message-ID: <20260510135546.13554-11-rppt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260510135546.13554-1-rppt@kernel.org>
References: <20260510135546.13554-1-rppt@kernel.org>
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

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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

