From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:09:32 +0000
Subject: [PATCH 0253/1529] Fix typo
Message-Id: <20160521120932.13257-1-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sh/lib64/copy_page.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/lib64/copy_page.S b/arch/sh/lib64/copy_page.S
index 0ec6fca..84ada2d 100644
--- a/arch/sh/lib64/copy_page.S
+++ b/arch/sh/lib64/copy_page.S
@@ -16,9 +16,9 @@
    Always copies 4096 bytes.
 
    Points to review.
-   * Currently the prefetch is 4 lines ahead and the alloco is 2 lines ahead.
+   * Currently the prefetch is 4 lines ahead and the alloc is 2 lines ahead.
      It seems like the prefetch needs to be at at least 4 lines ahead to get
-     the data into the cache in time, and the allocos contend with outstanding
+     the data into the cache in time, and the allocs contend with outstanding
      prefetches for the same cache set, so it's better to have the numbers
      different.
    */
-- 
2.8.2.534.g1f66975

