From: Richard Weinberger <richard@nod.at>
Date: Thu, 12 May 2011 13:11:11 +0000
Subject: [PATCH 1/2] sh: remove warning and warning_symbol from struct stacktrace_ops
Message-Id: <1305205872-10321-1-git-send-email-richard@nod.at>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, ying.huang@intel.com, ssp@redhat.com, namhyung@gmail.com, fweisbec@gmail.com, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, robert.richter@amd.com, lethal@linux-sh.org, Richard Weinberger <richard@nod.at>

Both warning and warning_symbol are nowhere used.
Let's get rid of them.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/sh/include/asm/stacktrace.h |    3 ---
 arch/sh/kernel/dumpstack.c       |   15 ---------------
 arch/sh/kernel/perf_callchain.c  |   12 ------------
 arch/sh/kernel/stacktrace.c      |   13 -------------
 arch/sh/oprofile/backtrace.c     |   13 -------------
 5 files changed, 0 insertions(+), 56 deletions(-)

diff --git a/arch/sh/include/asm/stacktrace.h b/arch/sh/include/asm/stacktrace.h
index 7970182..a7e2d4d 100644
--- a/arch/sh/include/asm/stacktrace.h
+++ b/arch/sh/include/asm/stacktrace.h
@@ -10,9 +10,6 @@
 /* Generic stack tracer with callbacks */
 
 struct stacktrace_ops {
-	void (*warning)(void *data, char *msg);
-	/* msg must contain %s for the symbol */
-	void (*warning_symbol)(void *data, char *msg, unsigned long symbol);
 	void (*address)(void *data, unsigned long address, int reliable);
 	/* On negative return stop dumping */
 	int (*stack)(void *data, char *name);
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 6f5ad15..694158b 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -69,19 +69,6 @@ stack_reader_dump(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-static void
-print_trace_warning_symbol(void *data, char *msg, unsigned long symbol)
-{
-	printk(data);
-	print_symbol(msg, symbol);
-	printk("\n");
-}
-
-static void print_trace_warning(void *data, char *msg)
-{
-	printk("%s%s\n", (char *)data, msg);
-}
-
 static int print_trace_stack(void *data, char *name)
 {
 	printk("%s <%s> ", (char *)data, name);
@@ -98,8 +85,6 @@ static void print_trace_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops print_trace_ops = {
-	.warning = print_trace_warning,
-	.warning_symbol = print_trace_warning_symbol,
 	.stack = print_trace_stack,
 	.address = print_trace_address,
 };
diff --git a/arch/sh/kernel/perf_callchain.c b/arch/sh/kernel/perf_callchain.c
index d5ca1ef..cc80b61 100644
--- a/arch/sh/kernel/perf_callchain.c
+++ b/arch/sh/kernel/perf_callchain.c
@@ -14,16 +14,6 @@
 #include <asm/unwinder.h>
 #include <asm/ptrace.h>
 
-
-static void callchain_warning(void *data, char *msg)
-{
-}
-
-static void
-callchain_warning_symbol(void *data, char *msg, unsigned long symbol)
-{
-}
-
 static int callchain_stack(void *data, char *name)
 {
 	return 0;
@@ -38,8 +28,6 @@ static void callchain_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops callchain_ops = {
-	.warning	= callchain_warning,
-	.warning_symbol	= callchain_warning_symbol,
 	.stack		= callchain_stack,
 	.address	= callchain_address,
 };
diff --git a/arch/sh/kernel/stacktrace.c b/arch/sh/kernel/stacktrace.c
index c2e45c4..bf989e0 100644
--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -17,15 +17,6 @@
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
-static void save_stack_warning(void *data, char *msg)
-{
-}
-
-static void
-save_stack_warning_symbol(void *data, char *msg, unsigned long symbol)
-{
-}
-
 static int save_stack_stack(void *data, char *name)
 {
 	return 0;
@@ -51,8 +42,6 @@ static void save_stack_address(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops save_stack_ops = {
-	.warning = save_stack_warning,
-	.warning_symbol = save_stack_warning_symbol,
 	.stack = save_stack_stack,
 	.address = save_stack_address,
 };
@@ -88,8 +77,6 @@ save_stack_address_nosched(void *data, unsigned long addr, int reliable)
 }
 
 static const struct stacktrace_ops save_stack_ops_nosched = {
-	.warning = save_stack_warning,
-	.warning_symbol = save_stack_warning_symbol,
 	.stack = save_stack_stack,
 	.address = save_stack_address_nosched,
 };
diff --git a/arch/sh/oprofile/backtrace.c b/arch/sh/oprofile/backtrace.c
index 37f3a75..9c88dcd 100644
--- a/arch/sh/oprofile/backtrace.c
+++ b/arch/sh/oprofile/backtrace.c
@@ -23,17 +23,6 @@
 #include <asm/sections.h>
 #include <asm/stacktrace.h>
 
-static void backtrace_warning_symbol(void *data, char *msg,
-				     unsigned long symbol)
-{
-	/* Ignore warnings */
-}
-
-static void backtrace_warning(void *data, char *msg)
-{
-	/* Ignore warnings */
-}
-
 static int backtrace_stack(void *data, char *name)
 {
 	/* Yes, we want all stacks */
@@ -49,8 +38,6 @@ static void backtrace_address(void *data, unsigned long addr, int reliable)
 }
 
 static struct stacktrace_ops backtrace_ops = {
-	.warning = backtrace_warning,
-	.warning_symbol = backtrace_warning_symbol,
 	.stack = backtrace_stack,
 	.address = backtrace_address,
 };
-- 
1.7.4.2

