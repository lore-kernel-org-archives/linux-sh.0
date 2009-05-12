From: Stuart MENEFY <stuart.menefy@st.com>
Date: Tue, 12 May 2009 12:15:22 +0000
Subject: Re: [BUG] Error in copy_process, when enable CONFIG_PROVE_LOCKING.
Message-Id: <4A09685A.2070105@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
In-Reply-To: <29ab51dc0905112140v3187b462qcc8a9e5385de8ef6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Nobuhiro Iwamatsu wrote:
> Error in copy_process, when enable CONFIG_PROVE_LOCKING.
> This error has p->hardirqs_enabled in kernel.fork.c
> 
>  987 #ifdef CONFIG_PROVE_LOCKING
>  988     DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
>  989     DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
>  990 #endif
>  991     retval = -EAGAIN;
> 
> The error message is as follows.
> I am debuging this. Please teach if you know the revision method of
> this problem.

As it happens I was looking at this recently. I think there are some
missing calls to trace_hardirqs_on/off in the assembly
code. Unfortunately my kernel is quite different from the mainline in
this area, but you could try this patch which is an *untested* forward
port of the code I'm currently running successfully.

--

A couple of fixes are required for the IRQ tracing. Also switch to using
a macro which removes quite a few #ifdefs.

Signed-off-by: Stuart Menefy <stuart.menefy@st.com>
Index: x/arch/sh/kernel/cpu/sh3/entry.S
=================================--- x.orig/arch/sh/kernel/cpu/sh3/entry.S
+++ x/arch/sh/kernel/cpu/sh3/entry.S
@@ -217,6 +217,16 @@ ENTRY(sh_bios_handler)
 ! BL=0 on entry, on exit BL=1 (depending on r8).

 ENTRY(restore_regs)
+#ifdef CONFIG_TRACE_IRQFLAGS
+	mov	#OFF_SR, r0
+	mov.l	@(r0,r15), r0		! get status register
+	shlr2	r0
+	and	#0x3c, r0
+	cmp/eq	#0x3c, r0
+	bt	6f
+	TRACE_IRQS_ON
+6:
+#endif
 	mov.l	@r15+, r0
 	mov.l	@r15+, r1
 	mov.l	@r15+, r2
Index: x/arch/sh/kernel/entry-common.S
=================================--- x.orig/arch/sh/kernel/entry-common.S
+++ x/arch/sh/kernel/entry-common.S
@@ -45,7 +45,7 @@
  */

 #if defined(CONFIG_PREEMPT)
-#  define preempt_stop()	cli
+#  define preempt_stop()	cli; TRACE_IRQS_OFF
 #else
 #  define preempt_stop()
 #  define resume_kernel		__restore_all
@@ -55,11 +55,7 @@
 	.align	2
 ENTRY(exception_error)
 	!
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	2f, r0
-	jsr	@r0
-	 nop
-#endif
+	TRACE_IRQS_ON
 	sti
 	mov.l	1f, r0
 	jmp	@r0
@@ -67,18 +63,10 @@ ENTRY(exception_error)

 	.align	2
 1:	.long	do_exception_error
-#ifdef CONFIG_TRACE_IRQFLAGS
-2:	.long	trace_hardirqs_on
-#endif

 	.align	2
 ret_from_exception:
 	preempt_stop()
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	4f, r0
-	jsr	@r0
-	 nop
-#endif
 ENTRY(ret_from_irq)
 	!
 	mov	#OFF_SR, r0
@@ -125,11 +113,7 @@ noresched:
 ENTRY(resume_userspace)
 	! r8: current_thread_info
 	cli
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	5f, r0
-	jsr	@r0
-	 nop
-#endif
+	TRACE_IRQS_OFF
 	mov.l	@(TI_FLAGS,r8), r0		! current_thread_info->flags
 	tst	#_TIF_WORK_MASK, r0
 	bt/s	__restore_all
@@ -156,11 +140,7 @@ work_resched:
 	jsr	@r1				! schedule
 	 nop
 	cli
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	5f, r0
-	jsr	@r0
-	 nop
-#endif
+	TRACE_IRQS_OFF
 	!
 	mov.l	@(TI_FLAGS,r8), r0		! current_thread_info->flags
 	tst	#_TIF_WORK_MASK, r0
@@ -172,10 +152,6 @@ work_resched:
 1:	.long	schedule
 2:	.long	do_notify_resume
 3:	.long	resume_userspace
-#ifdef CONFIG_TRACE_IRQFLAGS
-4:	.long	trace_hardirqs_on
-5:	.long	trace_hardirqs_off
-#endif

 	.align	2
 syscall_exit_work:
@@ -184,11 +160,7 @@ syscall_exit_work:
 	tst	#_TIF_WORK_SYSCALL_MASK, r0
 	bt/s	work_pending
 	 tst	#_TIF_NEED_RESCHED, r0
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	5f, r0
-	jsr	@r0
-	 nop
-#endif
+	TRACE_IRQS_ON
 	sti
 	mov	r15, r4
 	mov.l	8f, r0			! do_syscall_trace_leave
@@ -322,9 +294,10 @@ ENTRY(system_call)
 	 nop

 #ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	5f, r10
-	jsr	@r10
-	 nop
+	/* Need to preserve r3 */
+	mov	r3, r8
+	TRACE_IRQS_ON
+	mov	r8, r3
 #endif
 	sti

@@ -351,11 +324,7 @@ syscall_call:
 	!
 syscall_exit:
 	cli
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	6f, r0
-	jsr	@r0
-	 nop
-#endif
+	TRACE_IRQS_OFF
 	!
 	get_current_thread_info r8, r0
 	mov.l	@(TI_FLAGS,r8), r0		! current_thread_info->flags
@@ -369,9 +338,5 @@ syscall_exit:
 #endif
 2:	.long	NR_syscalls
 3:	.long	sys_call_table
-#ifdef CONFIG_TRACE_IRQFLAGS
-5:	.long	trace_hardirqs_on
-6:	.long	trace_hardirqs_off
-#endif
 7:	.long	do_syscall_trace_enter
 8:	.long	do_syscall_trace_leave
Index: x/arch/sh/include/asm/entry-macros.S
=================================--- x.orig/arch/sh/include/asm/entry-macros.S
+++ x/arch/sh/include/asm/entry-macros.S
@@ -31,6 +31,37 @@
 #endif	
 	.endm

+#ifdef CONFIG_TRACE_IRQFLAGS
+
+	.macro	TRACE_IRQS_ON
+	mov.l	7834f, r0
+	jsr	@r0
+	 nop
+	bra	7835f
+	 nop
+	.balign	4
+7834:	.long	trace_hardirqs_on
+7835:
+	.endm
+	.macro	TRACE_IRQS_OFF
+	mov.l	7834f, r0
+	jsr	@r0
+	 nop
+	bra	7835f
+	 nop
+	.balign	4
+7834:	.long	trace_hardirqs_off
+7835:
+	.endm
+
+#else
+	.macro	TRACE_IRQS_ON
+	.endm
+
+	.macro	TRACE_IRQS_OFF
+	.endm
+#endif
+
 #if defined(CONFIG_CPU_SH2A) || defined(CONFIG_CPU_SH4)
 # define PREF(x)	pref	@x
 #else
