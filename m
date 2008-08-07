From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 07 Aug 2008 04:54:59 +0000
Subject: [PATCH] sh: fix sh2a cache entry_mask
Message-Id: <489A8023.6020505@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

fix sh2a cache entry_mask in __flush_{purge,invalidate}_region.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/mm/cache-sh2a.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/cache-sh2a.c b/arch/sh/mm/cache-sh2a.c
index 62c0c5f..24d86a7 100644
--- a/arch/sh/mm/cache-sh2a.c
+++ b/arch/sh/mm/cache-sh2a.c
@@ -59,7 +59,7 @@ void __flush_purge_region(void *start, int size)

 	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
 		ctrl_outl((v & CACHE_PHYSADDR_MASK),
-			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
 	}
 	back_to_cached();
 	local_irq_restore(flags);
@@ -82,14 +82,14 @@ void __flush_invalidate_region(void *start, int size)
 	/* I-cache invalidate */
 	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
 		ctrl_outl((v & CACHE_PHYSADDR_MASK),
-			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
 	}
 #else
 	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
 		ctrl_outl((v & CACHE_PHYSADDR_MASK),
-			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
 		ctrl_outl((v & CACHE_PHYSADDR_MASK),
-			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0) | 0x00000008);
 	}
 #endif
 	back_to_cached();
-- 
1.5.5

