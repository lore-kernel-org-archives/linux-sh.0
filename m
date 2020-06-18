From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 18 Jun 2020 07:59:37 +0000
Subject: [PATCH] sh: stacktrace: Remove stacktrace_ops.stack()
Message-Id: <20200618075937.16391-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The SH implementation never called stacktrace_ops.stack().
Presumably this was copied from the x86 implementation.

Hence remove the method, and all implementations (most of them are
dummies).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/sh/include/asm/stacktrace.h | 2 --
 arch/sh/kernel/dumpstack.c       | 7 -------
 arch/sh/kernel/perf_callchain.c  | 6 ------
 arch/sh/kernel/stacktrace.c      | 7 -------
 arch/sh/oprofile/backtrace.c     | 7 -------
 5 files changed, 29 deletions(-)

diff --git a/arch/sh/include/asm/stacktrace.h b/arch/sh/include/asm/stacktrace.h
index 50c173c0b9f56f69..4f98cdc64ec59b1c 100644
--- a/arch/sh/include/asm/stacktrace.h
+++ b/arch/sh/include/asm/stacktrace.h
@@ -12,8 +12,6 @@
 
 struct stacktrace_ops {
 	void (*address)(void *data, unsigned long address, int reliable);
-	/* On negative return stop dumping */
-	int (*stack)(void *data, char *name);
 };
 
 void dump_trace(struct task_struct *tsk, struct pt_regs *regs,
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 0a69588e343f7b98..758a6c89e911bc15 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -107,12 +107,6 @@ stack_reader_dump(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-static int print_trace_stack(void *data, char *name)
-{
-	printk("%s <%s> ", (char *)data, name);
-	return 0;
-}
-
 /*
  * Print one address/symbol entries per line.
  */
@@ -123,7 +117,6 @@ static void print_trace_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops print_trace_ops = {
-	.stack = print_trace_stack,
 	.address = print_trace_address,
 };
 
diff --git a/arch/sh/kernel/perf_callchain.c b/arch/sh/kernel/perf_callchain.c
index 6281f2fdf9cac906..c9d3aa18732d1d49 100644
--- a/arch/sh/kernel/perf_callchain.c
+++ b/arch/sh/kernel/perf_callchain.c
@@ -11,11 +11,6 @@
 #include <asm/unwinder.h>
 #include <asm/ptrace.h>
 
-static int callchain_stack(void *data, char *name)
-{
-	return 0;
-}
-
 static void callchain_address(void *data, unsigned long addr, int reliable)
 {
 	struct perf_callchain_entry_ctx *entry = data;
@@ -25,7 +20,6 @@ static void callchain_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops callchain_ops = {
-	.stack		= callchain_stack,
 	.address	= callchain_address,
 };
 
diff --git a/arch/sh/kernel/stacktrace.c b/arch/sh/kernel/stacktrace.c
index 2950b19ad0772081..daf0b53ee066fa6d 100644
--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -15,11 +15,6 @@
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
-static int save_stack_stack(void *data, char *name)
-{
-	return 0;
-}
-
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
@@ -40,7 +35,6 @@ static void save_stack_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops save_stack_ops = {
-	.stack = save_stack_stack,
 	.address = save_stack_address,
 };
 
@@ -73,7 +67,6 @@ save_stack_address_nosched(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops save_stack_ops_nosched = {
-	.stack = save_stack_stack,
 	.address = save_stack_address_nosched,
 };
 
diff --git a/arch/sh/oprofile/backtrace.c b/arch/sh/oprofile/backtrace.c
index f1205f92631df3b9..cc16cf86cd92fabe 100644
--- a/arch/sh/oprofile/backtrace.c
+++ b/arch/sh/oprofile/backtrace.c
@@ -19,12 +19,6 @@
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 
-static int backtrace_stack(void *data, char *name)
-{
-	/* Yes, we want all stacks */
-	return 0;
-}
-
 static void backtrace_address(void *data, unsigned long addr, int reliable)
 {
 	unsigned int *depth = data;
@@ -34,7 +28,6 @@ static void backtrace_address(void *data, unsigned long addr, int reliable)
 }
 
 static struct stacktrace_ops backtrace_ops = {
-	.stack = backtrace_stack,
 	.address = backtrace_address,
 };
 
-- 
2.17.1
