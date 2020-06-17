From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:35 +0000
Subject: [PATCH v2 5/9] sh: dump_stack: Fix broken lines and ptrval in calltrace dumps
Message-Id: <20200617143639.18315-6-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Rejoin the broken lines by dropping the log level parameters and using
pr_cont().
Use "%px" to print sensible addresses in call traces.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
v2:
  - Add Tested-by,
  - Rebase on top of "[PATCHv3 00/50] Add log level to show_stack()":
      - Drop conversion of remaining printk() calls to pr_*(), as they
	have all received a loglvl parameter,
      - Remove loglvl parameters from continuations.

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
 arch/sh/kernel/dumpstack.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index cc8063a01284bf64..0a69588e343f7b98 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -16,8 +16,8 @@
 #include <asm/unwinder.h>
 #include <asm/stacktrace.h>
 
-void dump_mem(const char *str, const char *loglvl,
-	      unsigned long bottom, unsigned long top)
+void dump_mem(const char *str, const char *loglvl, unsigned long bottom,
+	      unsigned long top)
 {
 	unsigned long p;
 	int i;
@@ -31,23 +31,23 @@ void dump_mem(const char *str, const char *loglvl,
 			unsigned int val;
 
 			if (p < bottom || p >= top)
-				printk("%s         ", loglvl);
+				pr_cont("         ");
 			else {
 				if (__get_user(val, (unsigned int __user *)p)) {
-					printk("%s\n", loglvl);
+					pr_cont("\n");
 					return;
 				}
-				printk("%s%08x ", loglvl, val);
+				pr_cont("%08x ", val);
 			}
 		}
-		printk("%s\n", loglvl);
+		pr_cont("\n");
 	}
 }
 
 void printk_address(unsigned long address, int reliable)
 {
-	printk(" [<%p>] %s%pS\n", (void *) address,
-			reliable ? "" : "? ", (void *) address);
+	pr_cont(" [<%px>] %s%pS\n", (void *) address,
+		reliable ? "" : "? ", (void *) address);
 }
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
@@ -137,7 +137,7 @@ void show_trace(struct task_struct *tsk, unsigned long *sp,
 
 	unwind_stack(tsk, regs, sp, &print_trace_ops, (void *)loglvl);
 
-	printk("%s\n", loglvl);
+	pr_cont("\n");
 
 	if (!tsk)
 		tsk = current;
-- 
2.17.1
