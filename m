From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:09:44 +0000
Subject: [PATCH 0254/1529] Fix typo
Message-Id: <20160521120944.13307-1-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sh/lib64/copy_user_memcpy.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/lib64/copy_user_memcpy.S b/arch/sh/lib64/copy_user_memcpy.S
index 49aeabe..f964aa3 100644
--- a/arch/sh/lib64/copy_user_memcpy.S
+++ b/arch/sh/lib64/copy_user_memcpy.S
@@ -46,7 +46,7 @@
 
 */
 
-/* NOTE : Prefetches removed and allocos guarded by synco to avoid TAKum03020
+/* NOTE : Prefetches removed and allocs guarded by synco to avoid TAKum03020
  * erratum.  The first two prefetches are nop-ed out to avoid upsetting the
  * instruction counts used in the jump address calculation.
  * */
-- 
2.8.2.534.g1f66975

