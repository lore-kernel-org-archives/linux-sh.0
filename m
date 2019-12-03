From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 03 Dec 2019 16:26:40 +0000
Subject: [PATCH 2/7] sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
Message-Id: <20191203162645.19950-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203162645.19950-1-geert+renesas@glider.be>
In-Reply-To: <20191203162645.19950-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Rejoin the broken lines by using pr_cont(), and use "%px" to print
sensible addresses.
Convert the remaining printk() calls to pr_*() while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Sample impact:

-Stack: (0x8e8b1d58 to 0x8e8b2000)
-1d40:
-
-
-
-
-
-
-8c09a2b4
-8fb51b40
-
-1d60:
-8fbf400c
-00000000
-8c09a7da
-00000122
-8fbf4010
-00000001
-00000002
-8fbf4000
-
-1d80:
-00000002
-8fbf400c
-0030f231
-00000100
-8e8b1db0
-00000000
-8e8b1dac
-8c2b64b4
+Stack: (0x8eeabc80 to 0x8eeac000)
+bc80: 8c09a2a8 8fb5cce0 8fbf400c 00000000 8c09a7ce 00000122 8fbf4010 00000002
+bca0: 00000001 8fbf4000 00000001 8fbf400c 0030f231 00000100 8eeabcd8 00000000
+bcc0: 00001000 8c2b64b4 00460000 00000004 232d0f3f 8c21b788 8fb075a4 8fb50e44

 [...]

 Call trace:
- [<(ptrval)>] free_pcppages_bulk+0x106/0x348
- [<(ptrval)>] __get_free_pages+0xe/0x54
- [<(ptrval)>] free_unref_page_list+0xca/0x12c
- [<(ptrval)>] arch_local_irq_restore+0x0/0x24
- [<(ptrval)>] free_unref_page_commit.isra.141+0x0/0x74
+ [<8c09a7ce>] free_pcppages_bulk+0x106/0x348
+ [<8c21b788>] _cond_resched+0x38/0x54
+ [<8c09bb5a>] free_unref_page_list+0xca/0x12c
+ [<8c002808>] arch_local_irq_restore+0x0/0x24
+ [<8c09aaf8>] free_unref_page_commit.isra.141+0x0/0x74
---
 arch/sh/kernel/dumpstack.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 9f1c9c11d62df46a..6009281f83442ae3 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -21,32 +21,32 @@ void dump_mem(const char *str, unsigned long bottom, unsigned long top)
 	unsigned long p;
 	int i;
 
-	printk("%s(0x%08lx to 0x%08lx)\n", str, bottom, top);
+	pr_info("%s(0x%08lx to 0x%08lx)\n", str, bottom, top);
 
 	for (p = bottom & ~31; p < top; ) {
-		printk("%04lx: ", p & 0xffff);
+		pr_info("%04lx: ", p & 0xffff);
 
 		for (i = 0; i < 8; i++, p += 4) {
 			unsigned int val;
 
 			if (p < bottom || p >= top)
-				printk("         ");
+				pr_cont("         ");
 			else {
 				if (__get_user(val, (unsigned int __user *)p)) {
-					printk("\n");
+					pr_cont("\n");
 					return;
 				}
-				printk("%08x ", val);
+				pr_cont("%08x ", val);
 			}
 		}
-		printk("\n");
+		pr_cont("\n");
 	}
 }
 
 void printk_address(unsigned long address, int reliable)
 {
-	printk(" [<%p>] %s%pS\n", (void *) address,
-			reliable ? "" : "? ", (void *) address);
+	pr_cont(" [<%px>] %s%pS\n", (void *)address, reliable ? "" : "? ",
+		(void *)address);
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -108,7 +108,7 @@ stack_reader_dump(struct task_struct *task, struct pt_regs *regs,
 
 static int print_trace_stack(void *data, char *name)
 {
-	printk("%s <%s> ", (char *)data, name);
+	pr_info("%s <%s> ", (char *)data, name);
 	return 0;
 }
 
@@ -117,7 +117,7 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk("%s", (char *)data);
+	pr_info("%s", (char *)data);
 	printk_address(addr, reliable);
 }
 
@@ -132,11 +132,11 @@ void show_trace(struct task_struct *tsk, unsigned long *sp,
 	if (regs && user_mode(regs))
 		return;
 
-	printk("\nCall trace:\n");
+	pr_info("\nCall trace:\n");
 
 	unwind_stack(tsk, regs, sp, &print_trace_ops, "");
 
-	printk("\n");
+	pr_cont("\n");
 
 	if (!tsk)
 		tsk = current;
-- 
2.17.1
