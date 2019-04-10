From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 10 Apr 2019 10:27:58 +0000
Subject: [RFC patch 04/41] sh/stacktrace: Remove the pointless ULONG_MAX marker
Message-Id: <20190410103643.932464393@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Terminating the last trace entry with ULONG_MAX is a completely pointless
exercise and none of the consumers can rely on it because it's
inconsistently implemented across architectures. In fact quite some of the
callers remove the entry and adjust stack_trace.nr_entries afterwards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org
Cc: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/stacktrace.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -49,8 +49,6 @@ void save_stack_trace(struct stack_trace
 	unsigned long *sp = (unsigned long *)current_stack_pointer;
 
 	unwind_stack(current, NULL, sp,  &save_stack_ops, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
@@ -84,7 +82,5 @@ void save_stack_trace_tsk(struct task_st
 	unsigned long *sp = (unsigned long *)tsk->thread.sp;
 
 	unwind_stack(current, NULL, sp,  &save_stack_ops_nosched, trace);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
