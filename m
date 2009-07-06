From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 06 Jul 2009 10:32:43 +0000
Subject: [PATCH 3/3] sh: Add ftrace syscall tracing support
Message-Id: <dbb88ecd5d63d4a1dea184b1e2dcfd9cfb914d9d.1246875978.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that I've added TIF_SYSCALL_FTRACE the bits in
current_thread_info->flags do not fit into a byte. I've split
_TIF_WORK_SYSCALL_MASK and _TIF_ALLWORK_MASK into high and low parts.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/Kconfig                   |    1 +
 arch/sh/include/asm/ftrace.h      |    4 ++
 arch/sh/include/asm/syscall_32.h  |    1 +
 arch/sh/include/asm/thread_info.h |   21 ++++++++---
 arch/sh/kernel/Makefile_32        |    1 +
 arch/sh/kernel/entry-common.S     |   14 ++++++--
 arch/sh/kernel/ftrace.c           |   66 +++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/ptrace_32.c        |    8 ++++
 8 files changed, 107 insertions(+), 9 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 235c388..174c348 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -29,6 +29,7 @@ config SUPERH32
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
+	select HAVE_FTRACE_SYSCALLS
 	select HAVE_ARCH_KGDB
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 
diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index b09311a..1f09aa6 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -31,4 +31,8 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 
+#ifdef CONFIG_FTRACE_SYSCALLS
+#define FTRACE_SYSCALL_MAX	334
+#endif
+
 #endif /* __ASM_SH_FTRACE_H */
diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 5bc3468..4be2b00 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -64,6 +64,7 @@ static inline void syscall_get_arguments(struct task_struct *task,
 	case 3: args[2] = regs->regs[6];
 	case 2: args[1] = regs->regs[5];
 	case 1:	args[0] = regs->regs[4];
+	case 0:
 		break;
 	default:
 		BUG();
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index f09ac48..1e5785f 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -116,6 +116,7 @@ extern void free_thread_info(struct thread_info *ti);
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
 #define TIF_SECCOMP		6	/* secure computing */
 #define TIF_NOTIFY_RESUME	7	/* callback before returning to user */
+#define TIF_SYSCALL_FTRACE	8	/* for ftrace syscall instrumentation */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18
@@ -129,28 +130,36 @@ extern void free_thread_info(struct thread_info *ti);
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_SYSCALL_FTRACE	(1 << TIF_SYSCALL_FTRACE)
 #define _TIF_USEDFPU		(1 << TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_FREEZE		(1 << TIF_FREEZE)
 
 /*
- * _TIF_ALLWORK_MASK and _TIF_WORK_MASK need to fit within a byte, or we
- * blow the tst immediate size constraints and need to fix up
+ * _TIF_ALLWORK_MASK_LO/_TIF_ALLWORK_MASK_HI needs to fit within two
+ * bytes and _TIF_WORK_MASK needs to fit within one byte, or we blow the
+ * tst immediate size constraints and need to fix up
  * arch/sh/kernel/entry-common.S.
  */
 
 /* work to do in syscall trace */
-#define _TIF_WORK_SYSCALL_MASK	(_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | \
-				 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)
+#define _TIF_WORK_SYSCALL_MASK_LO	(_TIF_SYSCALL_TRACE |		\
+					 _TIF_SINGLESTEP |		\
+					 _TIF_SYSCALL_AUDIT | _TIF_SECCOMP)
+
+#define _TIF_WORK_SYSCALL_MASK_HI	(_TIF_SYSCALL_FTRACE)
 
 /* work to do on any return to u-space */
-#define _TIF_ALLWORK_MASK	(_TIF_SYSCALL_TRACE | _TIF_SIGPENDING      | \
+#define _TIF_ALLWORK_MASK_LO	(_TIF_SYSCALL_TRACE | _TIF_SIGPENDING      | \
 				 _TIF_NEED_RESCHED  | _TIF_SYSCALL_AUDIT   | \
 				 _TIF_SINGLESTEP    | _TIF_RESTORE_SIGMASK | \
 				 _TIF_NOTIFY_RESUME)
 
+#define _TIF_ALLWORK_MASK_HI	(_TIF_SYSCALL_FTRACE)
+
 /* work to do on interrupt/exception return */
-#define _TIF_WORK_MASK		(_TIF_ALLWORK_MASK & ~(_TIF_SYSCALL_TRACE | \
+#define _TIF_WORK_MASK		(_TIF_ALLWORK_MASK_LO &			\
+				 ~(_TIF_SYSCALL_TRACE |	  		\
 				 _TIF_SYSCALL_AUDIT | _TIF_SINGLESTEP))
 
 #endif /* __KERNEL__ */
diff --git a/arch/sh/kernel/Makefile_32 b/arch/sh/kernel/Makefile_32
index 82a3a15..550c04e 100644
--- a/arch/sh/kernel/Makefile_32
+++ b/arch/sh/kernel/Makefile_32
@@ -29,6 +29,7 @@ obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
+obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
 obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d62359c..e63c775 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -181,7 +181,7 @@ work_resched:
 syscall_exit_work:
 	! r0: current_thread_info->flags
 	! r8: current_thread_info
-	tst	#_TIF_WORK_SYSCALL_MASK, r0
+	tst	#_TIF_WORK_SYSCALL_MASK_LO, r0
 	bt/s	work_pending
 	 tst	#_TIF_NEED_RESCHED, r0
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -331,8 +331,12 @@ ENTRY(system_call)
 	!
 	get_current_thread_info r8, r10
 	mov.l	@(TI_FLAGS,r8), r8
-	mov	#_TIF_WORK_SYSCALL_MASK, r10
+	mov	#_TIF_WORK_SYSCALL_MASK_LO, r10
+	mov	#(_TIF_WORK_SYSCALL_MASK_HI >> 8), r9
 	tst	r10, r8
+	shll8	r9
+	bf	syscall_trace_entry
+	tst	r9, r8
 	bf	syscall_trace_entry
 	!
 	mov.l	2f, r8			! Number of syscalls
@@ -359,7 +363,11 @@ syscall_exit:
 	!
 	get_current_thread_info r8, r0
 	mov.l	@(TI_FLAGS,r8), r0		! current_thread_info->flags
-	tst	#_TIF_ALLWORK_MASK, r0
+	tst	#_TIF_ALLWORK_MASK_LO, r0
+	mov	#(_TIF_ALLWORK_MASK_HI >> 8), r1
+	bf	syscall_exit_work
+	shlr8	r0
+	tst	r0, r1
 	bf	syscall_exit_work
 	bra	__restore_all
 	 nop
diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 066f37d..0543ab2 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -19,6 +19,8 @@
 #include <asm/ftrace.h>
 #include <asm/cacheflush.h>
 
+#include <trace/syscall.h>
+
 static unsigned char ftrace_replaced_code[MCOUNT_INSN_SIZE];
 
 static unsigned char ftrace_nop[4];
@@ -131,3 +133,67 @@ int __init ftrace_dyn_arch_init(void *data)
 
 	return 0;
 }
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+
+extern unsigned long __start_syscalls_metadata[];
+extern unsigned long __stop_syscalls_metadata[];
+extern unsigned long *sys_call_table;
+
+static struct syscall_metadata **syscalls_metadata;
+
+static struct syscall_metadata *find_syscall_meta(unsigned long *syscall)
+{
+	struct syscall_metadata *start;
+	struct syscall_metadata *stop;
+	char str[KSYM_SYMBOL_LEN];
+
+
+	start = (struct syscall_metadata *)__start_syscalls_metadata;
+	stop = (struct syscall_metadata *)__stop_syscalls_metadata;
+	kallsyms_lookup((unsigned long) syscall, NULL, NULL, NULL, str);
+
+	for ( ; start < stop; start++) {
+		if (start->name && !strcmp(start->name, str))
+			return start;
+	}
+
+	return NULL;
+}
+
+struct syscall_metadata *syscall_nr_to_meta(int nr)
+{
+	if (!syscalls_metadata || nr >= FTRACE_SYSCALL_MAX || nr < 0)
+		return NULL;
+
+	return syscalls_metadata[nr];
+}
+
+void arch_init_ftrace_syscalls(void)
+{
+	int i;
+	struct syscall_metadata *meta;
+	unsigned long **psys_syscall_table = &sys_call_table;
+	static atomic_t refs;
+
+	if (atomic_inc_return(&refs) != 1)
+		goto end;
+
+	syscalls_metadata = kzalloc(sizeof(*syscalls_metadata) *
+					FTRACE_SYSCALL_MAX, GFP_KERNEL);
+	if (!syscalls_metadata) {
+		WARN_ON(1);
+		return;
+	}
+
+	for (i = 0; i < FTRACE_SYSCALL_MAX; i++) {
+		meta = find_syscall_meta(psys_syscall_table[i]);
+		syscalls_metadata[i] = meta;
+	}
+	return;
+
+	/* Paranoid: avoid overflow */
+end:
+	atomic_dec(&refs);
+}
+#endif /* CONFIG_FTRACE_SYSCALLS */
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index f7b22dd..fefb883 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -34,6 +34,8 @@
 #include <asm/syscalls.h>
 #include <asm/fpu.h>
 
+#include <trace/syscall.h>
+
 /*
  * This routine will get a word off of the process kernel stack.
  */
@@ -451,6 +453,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		 */
 		ret = -1L;
 
+	if (unlikely(test_thread_flag(TIF_SYSCALL_FTRACE)))
+		ftrace_syscall_enter(regs);
+
 	if (unlikely(current->audit_context))
 		audit_syscall_entry(audit_arch(), regs->regs[3],
 				    regs->regs[4], regs->regs[5],
@@ -467,6 +472,9 @@ asmlinkage void do_syscall_trace_leave(struct pt_regs *regs)
 		audit_syscall_exit(AUDITSC_RESULT(regs->regs[0]),
 				   regs->regs[0]);
 
+	if (unlikely(test_thread_flag(TIF_SYSCALL_FTRACE)))
+		ftrace_syscall_exit(regs);
+
 	step = test_thread_flag(TIF_SINGLESTEP);
 	if (step || test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall_exit(regs, step);
-- 
1.6.3.2.316.gda4e

