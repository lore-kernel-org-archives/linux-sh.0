From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 11 Jul 2009 00:29:03 +0000
Subject: [PATCH 2/3] sh: Function graph tracer support
Message-Id: <b3aec4e1eb69eea102622f1bb30bd45608c4e787.1247272091.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add both dynamic and static function graph tracer support for sh.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/Kconfig                 |    1 +
 arch/sh/include/asm/ftrace.h    |    3 +
 arch/sh/kernel/Makefile_32      |    1 +
 arch/sh/kernel/ftrace.c         |  124 +++++++++++++++++++++++++++++++++++++++
 arch/sh/lib/Makefile            |    1 +
 arch/sh/lib/mcount.S            |  117 ++++++++++++++++++++++++++++++++++++-
 6 files changed, 246 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/kernel/vmlinux_64.lds.S

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 29e41ec..6d110a4 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -33,6 +33,7 @@ config SUPERH32
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_FTRACE_SYSCALLS
+	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_ARCH_KGDB
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 
diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index b09311a..7e0bcc4 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -13,8 +13,11 @@ extern void mcount(void);
 #ifdef CONFIG_DYNAMIC_FTRACE
 #define CALL_ADDR		((long)(ftrace_call))
 #define STUB_ADDR		((long)(ftrace_stub))
+#define GRAPH_ADDR		((long)(ftrace_graph_call))
+#define CALLER_ADDR		((long)(ftrace_caller))
 
 #define MCOUNT_INSN_OFFSET	((STUB_ADDR - CALL_ADDR) - 4)
+#define GRAPH_INSN_OFFSET	((CALLER_ADDR - GRAPH_ADDR) - 4)
 
 struct dyn_arch_ftrace {
 	/* No extra data needed on sh */
diff --git a/arch/sh/kernel/Makefile_32 b/arch/sh/kernel/Makefile_32
index fee924a..94ed99b 100644
--- a/arch/sh/kernel/Makefile_32
+++ b/arch/sh/kernel/Makefile_32
@@ -30,6 +30,7 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_GENERIC_GPIO)	+= gpio.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 obj-$(CONFIG_DUMP_CODE)		+= disassemble.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o
 
diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
index 4f62ece..503c506 100644
--- a/arch/sh/kernel/ftrace.c
+++ b/arch/sh/kernel/ftrace.c
@@ -16,11 +16,15 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <asm/ftrace.h>
 #include <asm/cacheflush.h>
 #include <asm/unistd.h>
 #include <trace/syscall.h>
 
+#include <trace/syscall.h>
+
+#ifdef CONFIG_DYNAMIC_FTRACE
 static unsigned char ftrace_replaced_code[MCOUNT_INSN_SIZE];
 
 static unsigned char ftrace_nop[4];
@@ -133,6 +137,126 @@ int __init ftrace_dyn_arch_init(void *data)
 
 	return 0;
 }
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifdef CONFIG_DYNAMIC_FTRACE
+extern void ftrace_graph_call(void);
+
+static int ftrace_mod(unsigned long ip, unsigned long old_addr,
+		      unsigned long new_addr)
+{
+	unsigned char code[MCOUNT_INSN_SIZE];
+
+	if (probe_kernel_read(code, (void *)ip, MCOUNT_INSN_SIZE))
+		return -EFAULT;
+
+	if (old_addr != __raw_readl((unsigned long *)code))
+		return -EINVAL;
+
+	__raw_writel(new_addr, ip);
+	return 0;
+}
+
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned long ip, old_addr, new_addr;
+
+	ip = (unsigned long)(&ftrace_graph_call) + GRAPH_INSN_OFFSET;
+	old_addr = (unsigned long)(&skip_trace);
+	new_addr = (unsigned long)(&ftrace_graph_caller);
+
+	return ftrace_mod(ip, old_addr, new_addr);
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned long ip, old_addr, new_addr;
+
+	ip = (unsigned long)(&ftrace_graph_call) + GRAPH_INSN_OFFSET;
+	old_addr = (unsigned long)(&ftrace_graph_caller);
+	new_addr = (unsigned long)(&skip_trace);
+
+	return ftrace_mod(ip, old_addr, new_addr);
+}
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+/*
+ * Hook the return address and push it in the stack of return addrs
+ * in the current thread info.
+ *
+ * This is the main routine for the function graph tracer. The function
+ * graph tracer essentially works like this:
+ *
+ * parent is the stack address containing self_addr's return address.
+ * We pull the real return address out of parent and store it in
+ * current's ret_stack. Then, we replace the return address on the stack
+ * with the address of return_to_handler. self_addr is the function that
+ * called mcount.
+ *
+ * When self_addr returns, it will jump to return_to_handler which calls
+ * ftrace_return_to_handler. ftrace_return_to_handler will pull the real
+ * return address off of current's ret_stack and jump to it.
+ */
+void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
+{
+	unsigned long old;
+	int faulted, err;
+	struct ftrace_graph_ent trace;
+	unsigned long return_hooker = (unsigned long)&return_to_handler;
+
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		return;
+
+	/*
+	 * Protect against fault, even if it shouldn't
+	 * happen. This tool is too much intrusive to
+	 * ignore such a protection.
+	 */
+	__asm__ __volatile__(
+		"1:						\n\t"
+		"mov.l		@%2, %0				\n\t"
+		"2:						\n\t"
+		"mov.l		%3, @%2				\n\t"
+		"mov		#0, %1				\n\t"
+		"3:						\n\t"
+		".section .fixup, \"ax\"			\n\t"
+		"4:						\n\t"
+		"mov.l		5f, %0				\n\t"
+		"jmp		@%0				\n\t"
+		" mov		#1, %1				\n\t"
+		".balign 4					\n\t"
+		"5:	.long 3b				\n\t"
+		".previous					\n\t"
+		".section __ex_table,\"a\"			\n\t"
+		".long 1b, 4b					\n\t"
+		".long 2b, 4b					\n\t"
+		".previous					\n\t"
+		: "=&r" (old), "=r" (faulted)
+		: "r" (parent), "r" (return_hooker)
+	);
+
+	if (unlikely(faulted)) {
+		ftrace_graph_stop();
+		WARN_ON(1);
+		return;
+	}
+
+	err = ftrace_push_return_trace(old, self_addr, &trace.depth, 0);
+	if (err = -EBUSY) {
+		__raw_writel(old, parent);
+		return;
+	}
+
+	trace.func = self_addr;
+
+	/* Only trace if the calling function expects to */
+	if (!ftrace_graph_entry(&trace)) {
+		current->curr_ret_stack--;
+		__raw_writel(old, parent);
+	}
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 
diff --git a/arch/sh/kernel/vmlinux_64.lds.S b/arch/sh/kernel/vmlinux_64.lds.S
new file mode 100644
index 0000000..e69de29
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index aaea580..19328d9 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -25,6 +25,7 @@ memcpy-$(CONFIG_CPU_SH4)	:= memcpy-sh4.o
 
 lib-$(CONFIG_MMU)		+= copy_page.o clear_page.o
 lib-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
+lib-$(CONFIG_FUNCTION_GRAPH_TRACER) += mcount.o
 lib-y				+= $(memcpy-y) $(udivsi3-y)
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/sh/lib/mcount.S b/arch/sh/lib/mcount.S
index 282a38d..c649a89 100644
--- a/arch/sh/lib/mcount.S
+++ b/arch/sh/lib/mcount.S
@@ -111,14 +111,62 @@ mcount_call:
 	jsr	@r6
 	 nop
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	mov.l   .Lftrace_graph_return, r6
+	mov.l   .Lftrace_stub, r7
+	cmp/eq  r6, r7
+	bt      1f
+
+	mov.l   .Lftrace_graph_caller, r0
+	jmp     @r0
+	 nop
+
+1:
+	mov.l	.Lftrace_graph_entry, r6
+	mov.l	.Lftrace_graph_entry_stub, r7
+	cmp/eq	r6, r7
+	bt	skip_trace
+
+	mov.l   .Lftrace_graph_caller, r0
+	jmp	@r0
+	 nop
+
+	.align 2
+.Lftrace_graph_return:
+	.long   ftrace_graph_return
+.Lftrace_graph_entry:
+	.long   ftrace_graph_entry
+.Lftrace_graph_entry_stub:
+	.long   ftrace_graph_entry_stub
+.Lftrace_graph_caller:
+	.long   ftrace_graph_caller
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+	.globl skip_trace
 skip_trace:
 	MCOUNT_LEAVE()
 
 	.align 2
 .Lftrace_trace_function:
-	.long	ftrace_trace_function
+	.long   ftrace_trace_function
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+/*
+ * NOTE: Do not move either ftrace_graph_call or ftrace_caller
+ * as this will affect the calculation of GRAPH_INSN_OFFSET.
+ */
+	.globl ftrace_graph_call
+ftrace_graph_call:
+	mov.l	.Lskip_trace, r0
+	jmp	@r0
+	 nop
+
+	.align 2
+.Lskip_trace:
+	.long	skip_trace
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 	.globl ftrace_caller
 ftrace_caller:
 	mov.l	.Lfunction_trace_stop, r0
@@ -136,7 +184,12 @@ ftrace_call:
 	jsr	@r6
 	 nop
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	bra	ftrace_graph_call
+	 nop
+#else
 	MCOUNT_LEAVE()
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 /*
@@ -188,3 +241,65 @@ stack_panic:
 .Lpanic_str:
 	.string "Stack error"
 #endif /* CONFIG_STACK_DEBUG */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl	ftrace_graph_caller
+ftrace_graph_caller:
+	mov.l	2f, r0
+	mov.l	@r0, r0
+	tst	r0, r0
+	bt	1f
+
+	mov.l	3f, r1
+	jmp	@r1
+	 nop
+1:
+	/*
+	 * MCOUNT_ENTER() pushed 5 registers onto the stack, so
+	 * the stack address containing our return address is
+	 * r15 + 20.
+	 */
+	mov	#20, r0
+	add	r15, r0
+	mov	r0, r4
+
+	mov.l	.Lprepare_ftrace_return, r0
+	jsr	@r0
+	 nop
+
+	MCOUNT_LEAVE()
+
+	.align 2
+2:	.long	function_trace_stop
+3:	.long	skip_trace
+.Lprepare_ftrace_return:
+	.long	prepare_ftrace_return
+
+	.globl	return_to_handler
+return_to_handler:
+	/*
+	 * Save the return values.
+	 */
+	mov.l	r0, @-r15
+	mov.l	r1, @-r15
+
+	mov	#0, r4
+
+	mov.l	.Lftrace_return_to_handler, r0
+	jsr	@r0
+	 nop
+
+	/*
+	 * The return value from ftrace_return_handler has the real
+	 * address that we should return to.
+	 */
+	lds	r0, pr
+	mov.l	@r15+, r1
+	rts
+	 mov.l	@r15+, r0
+
+
+	.align 2
+.Lftrace_return_to_handler:
+	.long	ftrace_return_to_handler
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-- 
1.6.3.2.316.gda4e

