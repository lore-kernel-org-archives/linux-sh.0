From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:31 +0000
Subject: [PATCH 11/14] sh: Use page_to_phys() to get the physical address of a page
Message-Id: <d620fb66e676d5aefe201035330d3e974e5d8bc7.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Instead of abusing __pa() and page_address() to get the physical address
of page, use page_to_phys(), which was invented for this purpose.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/cache-sh4.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 5b73b37..0bad81c 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -123,7 +123,7 @@ static void sh4_flush_dcache_page(void *arg)
 	else
 #endif
 	{
-		unsigned long phys = __pa(page_address(page));
+		unsigned long phys = page_to_phys(page);
 		unsigned long addr = CACHE_OC_ADDRESS_ARRAY;
 		int i, n;
 
-- 
1.6.3.3

