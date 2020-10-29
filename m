From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 29 Oct 2020 16:21:41 +0000
Subject: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
Message-Id: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for sh.

Cc: linux-sh@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/sh/include/asm/thread_info.h | 4 +++-
 arch/sh/kernel/signal_32.c        | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 243ea5150aa0..598d0184ffea 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -105,6 +105,7 @@ extern void init_thread_xstate(void);
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
+#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
 #define TIF_SINGLESTEP		4	/* singlestepping active */
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
 #define TIF_SECCOMP		6	/* secure computing */
@@ -116,6 +117,7 @@ extern void init_thread_xstate(void);
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
@@ -132,7 +134,7 @@ extern void init_thread_xstate(void);
 #define _TIF_ALLWORK_MASK	(_TIF_SYSCALL_TRACE | _TIF_SIGPENDING      | \
 				 _TIF_NEED_RESCHED  | _TIF_SYSCALL_AUDIT   | \
 				 _TIF_SINGLESTEP    | _TIF_NOTIFY_RESUME   | \
-				 _TIF_SYSCALL_TRACEPOINT)
+				 _TIF_SYSCALL_TRACEPOINT | _TIF_NOTIFY_SIGNAL)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK		(_TIF_ALLWORK_MASK & ~(_TIF_SYSCALL_TRACE | \
diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index 1add47fd31f6..8cfae5a75edb 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -466,7 +466,10 @@ static void do_signal(struct pt_regs *regs, unsigned int save_r0)
 	if (!user_mode(regs))
 		return;
 
-	if (get_signal(&ksig)) {
+	if (ti_work & _TIF_NOTIFY_SIGNAL)
+		tracehook_notify_signal();
+
+	if ((ti_work & _TIF_SIGPENDING) && get_signal(&ksig)) {
 		handle_syscall_restart(save_r0, regs, &ksig.ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
@@ -499,7 +502,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned int save_r0,
 				 unsigned long thread_info_flags)
 {
 	/* deal with pending signal delivery */
-	if (thread_info_flags & _TIF_SIGPENDING)
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs, save_r0);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
-- 
2.29.0

-- 
Jens Axboe
