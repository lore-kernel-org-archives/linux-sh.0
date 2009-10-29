From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 29 Oct 2009 21:53:30 +0000
Subject: [PATCH] sh: Do not apply virt_to_phys() to a physical address
Message-Id: <1256853210-2517-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The variable 'phys' already contains the physical address to flush. It
is not a virtual address and should not be passed to virt_to_phys().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/cache-sh4.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 4a2fbf2..b5abe94 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -95,8 +95,7 @@ static inline void flush_cache_one(unsigned long start, unsigned long phys)
 		exec_offset = cached_to_uncached;
 
 	local_irq_save(flags);
-	__flush_cache_one(start | SH_CACHE_ASSOC,
-			  virt_to_phys(phys), exec_offset);
+	__flush_cache_one(start | SH_CACHE_ASSOC, phys, exec_offset);
 	local_irq_restore(flags);
 }
 
-- 
1.6.2.5

