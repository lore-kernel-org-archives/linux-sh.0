From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 21 May 2016 12:09:22 +0000
Subject: [PATCH 0252/1529] Fix typo
Message-Id: <20160521120922.13205-1-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sh/kernel/dwarf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 9d209a0..ebaaa62 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -639,7 +639,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 		 * This is our normal exit path. There are two reasons
 		 * why we might exit here,
 		 *
-		 *	a) pc has no asscociated DWARF frame info and so
+		 *	a) pc has no associated DWARF frame info and so
 		 *	we don't know how to unwind this frame. This is
 		 *	usually the case when we're trying to unwind a
 		 *	frame that was called from some assembly code
-- 
2.8.2.534.g1f66975

