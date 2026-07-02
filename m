Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47224949E2;
	Thu,  2 Jul 2026 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985104; cv=none; b=khim3FOjZgqwtzx0R8gE45ifBkXtDLzETuxJA7xocWmMmJPIFbdE7XJptlchspRv7RO3cOdMFObLlNXj+gBLbxs0LzxVm30xwxMNPRRHlh1NS8VO4bFsAjLbUZgCbfTi6FBuF5NQnIwDxiAjZyAL5LqvE4EG2I9BA3fzzzLDM18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985104; c=relaxed/simple;
	bh=djA4HLBivg/uZiON7kZbD4QRlo7qTxMQGq/j5dlYSRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfG0JZ6+uRdFz1YYblWO4Jmh4NTdMagsRP4d/03iG/h1J9hJ10LJPD69AnJ8juWVlQPOjcW6Y5O3gpciPz9BfDOaGxqi8FGM+O3H3G2AYxtbgwQUQEgoafMCj8crLzMdRahV5t8Qw8S+Y5is87Py8E9ripXGntv6o0Hp+Lmdrqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRxdOcBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRxdOcBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18EB1F000E9;
	Thu,  2 Jul 2026 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985103;
	bh=eeu2gm08p0qWJNkiRBrM4tyOIbqoW+rKQy1HSk8NO8I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MRxdOcBxOgBazORyA9tjwC6LuYhDZBMSMrw2DlWnGqOOrCz2g5Yk4+prj5wtRLt6q
	 Yzhp9GDy7fcIrUFDhOcdORz089HctP3ldm+yI/0JH7fyIpt3TNVMIHyAxqQIikwl/p
	 UdHk37FUVwYzhWmcrrWBLm6YBOe744a+qL3MUbPBsshIjkTduAGaM8AupVRDTK7Ox4
	 DWLmgZu/Xac5vbNaTGvFx6u2kxO5nVQuJmDkphEvoIfiIjtOfrCvIYexsq2Mx/Ik94
	 wZAxScnNi+YvCh5CJmUY74BkDO+snCRZJOH2ek0h7vPIH56iUhqZNLN9sopX23kG52
	 ijhUtLuqL2k1g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 02 Jul 2026 12:37:59 +0300
Subject: [PATCH v3 10/10] sh: drop include/asm/sparsemem.h
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-sh-numa-v2-v3-10-57e2435603de@kernel.org>
References: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
In-Reply-To: <20260702-sh-numa-v2-v3-0-57e2435603de@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.16-dev

Move MAX_PHYSMEM_BITS declaration to include/asm/mmu.h and drop now
unneeded include/asm/sparsemem.h

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/sh/include/asm/mmu.h       |  2 ++
 arch/sh/include/asm/sparsemem.h | 12 ------------
 arch/sh/kernel/setup.c          |  1 -
 3 files changed, 2 insertions(+), 13 deletions(-)

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

