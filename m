From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 21 Feb 2012 08:29:57 +0000
Subject: [PATCH] sh: Fix sh2a build error for CONFIG_CACHE_WRITETHROUGH
Message-Id: <1329812997-9774-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/mm/cache-sh2a.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/cache-sh2a.c b/arch/sh/mm/cache-sh2a.c
index ae08cbb..949e2d3 100644
--- a/arch/sh/mm/cache-sh2a.c
+++ b/arch/sh/mm/cache-sh2a.c
@@ -23,6 +23,7 @@
 #define MAX_OCACHE_PAGES	32
 #define MAX_ICACHE_PAGES	32
 
+#ifdef CONFIG_CACHE_WRITEBACK
 static void sh2a_flush_oc_line(unsigned long v, int way)
 {
 	unsigned long addr = (v & 0x000007f0) | (way << 11);
@@ -34,6 +35,7 @@ static void sh2a_flush_oc_line(unsigned long v, int way)
 		__raw_writel(data, CACHE_OC_ADDRESS_ARRAY | addr);
 	}
 }
+#endif
 
 static void sh2a_invalidate_line(unsigned long cache_addr, unsigned long v)
 {
-- 
1.7.0.4

