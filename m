From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:09:52 +0000
Subject: [PATCH 0255/1529] Fix typo
Message-Id: <20160521120952.13362-1-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sh/mm/cache-sh5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/cache-sh5.c b/arch/sh/mm/cache-sh5.c
index d1bffbc..5380089 100644
--- a/arch/sh/mm/cache-sh5.c
+++ b/arch/sh/mm/cache-sh5.c
@@ -259,7 +259,7 @@ static void inline sh64_dcache_purge_sets(int sets_to_purge_base, int n_sets)
 		 * Do one alloco which hits the required set per cache
 		 * way.  For write-back mode, this will purge the #ways
 		 * resident lines.  There's little point unrolling this
-		 * loop because the allocos stall more if they're too
+		 * loop because the allocs stall more if they're too
 		 * close together.
 		 */
 		eaddr1 = eaddr0 + cpu_data->dcache.way_size *
-- 
2.8.2.534.g1f66975

