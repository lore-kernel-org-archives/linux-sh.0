From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Jun 2013 06:59:51 +0000
Subject: [PATCH 13/15] ARM: shmobile: Remove mach/memory.h
Message-Id: <1371106793-25071-14-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove mach-shmobile memory.h since it is no longer needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/memory.h | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/memory.h

diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/mach-shmobile/include/mach/memory.h
deleted file mode 100644
index 0ffbe81..0000000
--- a/arch/arm/mach-shmobile/include/mach/memory.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef __ASM_MACH_MEMORY_H
-#define __ASM_MACH_MEMORY_H
-
-#define PLAT_PHYS_OFFSET	UL(CONFIG_MEMORY_START)
-#define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
-
-#endif /* __ASM_MACH_MEMORY_H */
-- 
1.8.2.1

