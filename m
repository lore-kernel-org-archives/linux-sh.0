From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 30 Nov 2011 07:21:53 +0000
Subject: [PATCH] sh: sh2a: Optimise cache flush for writethrough mode.
Message-Id: <1322637713-15227-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When the operand cache is set to writethough mode, there is no
need to flush data.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/mm/cache-sh2a.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/cache-sh2a.c b/arch/sh/mm/cache-sh2a.c
index 1f51225..56bb5f2 100644
--- a/arch/sh/mm/cache-sh2a.c
+++ b/arch/sh/mm/cache-sh2a.c
@@ -112,6 +112,7 @@ static void sh2a_flush_icache_range(void *args)
 
 	for (v = start; v < end; v+=L1_CACHE_BYTES) {
 		unsigned long addr = (v & 0x000007f0);
+#ifdef CONFIG_CACHE_WRITEBACK
 		int way;
 		/* O-Cache writeback */
 		for (way = 0; way < 4; way++) {
@@ -121,6 +122,7 @@ static void sh2a_flush_icache_range(void *args)
 				__raw_writel(data, CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
 			}
 		}
+#endif
 		/* I-Cache invalidate */
 		__raw_writel(addr,
 			  CACHE_IC_ADDRESS_ARRAY | addr | 0x00000008);
-- 
1.7.0.4

