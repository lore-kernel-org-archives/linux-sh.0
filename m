From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 11 Jul 2009 00:29:02 +0000
Subject: [PATCH 1/3] sh: Provide diagnostic kernel stack checks
Message-Id: <194c0b5363680cc9a1ff59bf2784e09574fbaa99.1247272091.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable kernel stack checking code in both the dynamic ftrace and mcount
code paths. Check the stack to see if it's overflowing and make sure
that the stack pointer contains an address that's either in init_stack
or after the bss.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/Kconfig.debug |   11 ++++++
 arch/sh/lib/mcount.S  |   85 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 39224b5..52a132c 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -123,4 +123,15 @@ config SH64_SR_WATCH
 	bool "Debug: set SR.WATCH to enable hardware watchpoints and trace"
 	depends on SUPERH64
 
+config STACK_DEBUG
+	bool "Enable diagnostic checks of the kernel stack"
+	depends on FUNCTION_TRACER
+	select DEBUG_STACKOVERFLOW
+	default n
+	help
+	  This option allows checks to be performed on the kernel stack
+	  at runtime. Saying Y here will add overhead to every function
+	  call and will therefore incur a major performance hit. Most
+	  users should say N.
+
 endmenu
diff --git a/arch/sh/lib/mcount.S b/arch/sh/lib/mcount.S
index 71e87f9..282a38d 100644
--- a/arch/sh/lib/mcount.S
+++ b/arch/sh/lib/mcount.S
@@ -9,6 +9,7 @@
  * for more details.
  */
 #include <asm/ftrace.h>
+#include <asm/thread_info.h>
 
 #define MCOUNT_ENTER()		\
 	mov.l	r4, @-r15;	\
@@ -28,6 +29,56 @@
 	rts;			\
 	 mov.l	@r15+, r4
 
+#ifdef CONFIG_STACK_DEBUG
+/*
+ * Perform diagnostic checks on the state of the kernel stack,
+ *
+ * Check for stack overflow. If there is less than 1KB free
+ * then it has overflowed.
+ *
+ * Make sure the stack pointer contains a valid address. Valid
+ * addresses for kernel stacks are anywhere after the bss
+ * (after _ebss) and anywhere in init_thread_union (init_stack).
+ */
+#define STACK_CHECK()					\
+	mov	#(THREAD_SIZE >> 10), r0;		\
+	shll8	r0;					\
+	shll2	r0;					\
+							\
+	/* r1 = sp & (THREAD_SIZE - 1) */		\
+	mov	#-1, r1;				\
+	add	r0, r1;					\
+	and	r15, r1;				\
+							\
+	/* sizeof(struct thread_info) */		\
+	mov	#60, r3;				\
+	mov	#(STACK_WARN >> 8), r2;			\
+	shll8	r2;					\
+	add	r3, r2;					\
+							\
+	/* Is the stack overflowing? */			\
+	cmp/hi	r2, r1;					\
+	bf	stack_panic;				\
+							\
+	/* If sp > _ebss then we're OK. */		\
+	mov.l	.L_ebss, r1;				\
+	cmp/hi	r1, r15;				\
+	bt	1f;					\
+							\
+	/* If sp < init_stack, we're not OK. */		\
+	mov.l	.L_init_thread_union, r1;		\
+	cmp/hs	r1, r15;				\
+	bf	stack_panic;				\
+							\
+	/* If sp > init_stack && sp < _ebss, not OK. */	\
+	add	r0, r1;					\
+	cmp/hs	r1, r15;				\
+	bt	stack_panic;				\
+1:
+#else
+#define STACK_CHECK()
+#endif /* CONFIG_STACK_DEBUG */
+
 	.align 2
 	.globl	_mcount
 	.type	_mcount,@function
@@ -41,6 +92,8 @@ mcount:
 	tst	r0, r0
 	bf	ftrace_stub
 #endif
+	STACK_CHECK()
+
 	MCOUNT_ENTER()
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -73,6 +126,8 @@ ftrace_caller:
 	tst	r0, r0
 	bf	ftrace_stub
 
+	STACK_CHECK()
+
 	MCOUNT_ENTER()
 
 	.globl ftrace_call
@@ -100,6 +155,36 @@ ftrace_stub:
 	rts
 	 nop
 
+#ifdef CONFIG_STACK_DEBUG
+	.globl	stack_panic
+stack_panic:
+	mov.l	.Ldump_stack, r0
+	jsr	@r0
+	 nop
+
+	mov.l	.Lpanic, r0
+	jsr	@r0
+	 mov.l	.Lpanic_s, r4
+
+	rts
+	 nop
+
 	.align 2
 .Lfunction_trace_stop:
 	.long	function_trace_stop
+.L_ebss:
+	.long	_ebss
+.L_init_thread_union:
+	.long	init_thread_union
+.Lpanic:
+	.long	panic
+.Lpanic_s:
+	.long	.Lpanic_str
+.Ldump_stack:
+	.long	dump_stack
+
+	.section	.rodata
+	.align 2
+.Lpanic_str:
+	.string "Stack error"
+#endif /* CONFIG_STACK_DEBUG */
-- 
1.6.3.2.316.gda4e

