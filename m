From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 24 Oct 2009 18:56:57 +0000
Subject: [PATCH] sh: Check for return_to_handler when unwinding the stack
Message-Id: <1256410617-16860-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When CONFIG_FUNCTION_GRAPH_TRACER is enabled the function graph tracer
may patch return addresses on the stack with the address of
return_to_handler(). This really confuses the DWARF unwinder because it
will try find the caller of return_to_handler(), not the caller of the
real return address.

So teach the DWARF unwinder how to find the real return address whenever
it encounters return_to_handler().

This patch does not cope very well when multiple return addresses on the
stack have been patched. To make it work properly it would require state
to track how many return_to_handler()'s have been seen so that we'd know
where to look in current->curr_ret_stack[]. So for now, instead of
trying to handle this, just moan if more than one return address on the
stack has been patched.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/dwarf.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 4d8c7bd..6c9d0c1 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -21,6 +21,7 @@
 #include <linux/mempool.h>
 #include <linux/mm.h>
 #include <linux/elf.h>
+#include <linux/ftrace.h>
 #include <asm/dwarf.h>
 #include <asm/unwinder.h>
 #include <asm/sections.h>
@@ -569,6 +570,27 @@ struct dwarf_frame * dwarf_unwind_stack(unsigned long pc,
 	if (!pc && !prev)
 		pc = (unsigned long)current_text_addr();
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	/*
+	 * If our stack has been patched by the function graph tracer
+	 * then we might see the address of return_to_handler() where we
+	 * expected to find the real return address.
+	 */
+	if (pc = (unsigned long)&return_to_handler) {
+		int index = current->curr_ret_stack;
+
+		/*
+		 * We currently have no way of tracking how many
+		 * return_to_handler()'s we've seen. If there is more
+		 * than one patched return address on our stack,
+		 * complain loudly.
+		 */
+		WARN_ON(index > 0);
+
+		pc = current->ret_stack[index].ret;
+	}
+#endif
+
 	frame = mempool_alloc(dwarf_frame_pool, GFP_ATOMIC);
 	if (!frame) {
 		printk(KERN_ERR "Unable to allocate a dwarf frame\n");
-- 
1.6.4.rc0

