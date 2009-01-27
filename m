From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 27 Jan 2009 07:27:18 +0000
Subject: Re: ERESTART* seen by userland
Message-Id: <20090127072718.GA6806@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
In-Reply-To: <20090117.084015.142054869.kkojima@rr.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 20, 2009 at 01:43:50PM +0900, Kaz Kojima wrote:
> Paul Mundt <lethal@linux-sh.org> wrote:
> >> It seems that some syscalls return with ERESTART* errno when
> >> they should return EINTR in the recent SH kernels.
> >> Has anybody experienced this?
> >> 
> > I haven't hit this personally, but the only logical explanation I can
> > think of for this is the T-bit setting in the syscall restart code. I
> > suppose I will have to find another bit to use. Can you confirm if
> > getting rid of regs->sr T-bit manipulation makes this go away?
> 
> I've confirmed that my testcases are fixed with removing the if line
> just before handle_syscall_restart call in do_signal:
> 
> --- GIT/linux-2.6/arch/sh/kernel/signal_32.c	2008-12-30 09:31:12.000000000 +0900
> +++ linux-2.6.29-rc1/arch/sh/kernel/signal_32.c	2009-01-20 12:48:40.000000000 +0900
> @@ -589,8 +589,7 @@ static void do_signal(struct pt_regs *re
>  
>  	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
>  	if (signr > 0) {
> -		if (regs->sr & 1)
> -			handle_syscall_restart(save_r0, regs, &ka.sa);
> +		handle_syscall_restart(save_r0, regs, &ka.sa);
>  
>  		/* Whee!  Actually deliver the signal.  */
>  		if (handle_signal(signr, &ka, &info, oldset,
> 
This should fix it up:

---

 arch/sh/include/asm/syscall_32.h |   22 +++-------------------
 arch/sh/include/asm/syscall_64.h |   22 +++-------------------
 arch/sh/kernel/signal_32.c       |    4 +---
 arch/sh/kernel/signal_64.c       |    4 +---
 4 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 05a868a..5bc3468 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -21,23 +21,10 @@ static inline void syscall_rollback(struct task_struct *task,
 	 */
 }
 
-static inline bool syscall_has_error(struct pt_regs *regs)
-{
-	return (regs->sr & 0x1) ? true : false;
-}
-static inline void syscall_set_error(struct pt_regs *regs)
-{
-	regs->sr |= 0x1;
-}
-static inline void syscall_clear_error(struct pt_regs *regs)
-{
-	regs->sr &= ~0x1;
-}
-
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	return syscall_has_error(regs) ? regs->regs[0] : 0;
+	return IS_ERR_VALUE(regs->regs[0]) ? regs->regs[0] : 0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
@@ -50,13 +37,10 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error) {
-		syscall_set_error(regs);
+	if (error)
 		regs->regs[0] = -error;
-	} else {
-		syscall_clear_error(regs);
+	else
 		regs->regs[0] = val;
-	}
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index e1143b9..c3561ca 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -21,23 +21,10 @@ static inline void syscall_rollback(struct task_struct *task,
 	 */
 }
 
-static inline bool syscall_has_error(struct pt_regs *regs)
-{
-	return (regs->sr & 0x1) ? true : false;
-}
-static inline void syscall_set_error(struct pt_regs *regs)
-{
-	regs->sr |= 0x1;
-}
-static inline void syscall_clear_error(struct pt_regs *regs)
-{
-	regs->sr &= ~0x1;
-}
-
 static inline long syscall_get_error(struct task_struct *task,
 				     struct pt_regs *regs)
 {
-	return syscall_has_error(regs) ? regs->regs[9] : 0;
+	return IS_ERR_VALUE(regs->regs[9]) ? regs->regs[9] : 0;
 }
 
 static inline long syscall_get_return_value(struct task_struct *task,
@@ -50,13 +37,10 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error) {
-		syscall_set_error(regs);
+	if (error)
 		regs->regs[9] = -error;
-	} else {
-		syscall_clear_error(regs);
+	else
 		regs->regs[9] = val;
-	}
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index 77c21bd..17784e1 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -510,7 +510,6 @@ handle_syscall_restart(unsigned long save_r0, struct pt_regs *regs,
 		case -ERESTARTNOHAND:
 		no_system_call_restart:
 			regs->regs[0] = -EINTR;
-			regs->sr |= 1;
 			break;
 
 		case -ERESTARTSYS:
@@ -589,8 +588,7 @@ static void do_signal(struct pt_regs *regs, unsigned int save_r0)
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
-		if (regs->sr & 1)
-			handle_syscall_restart(save_r0, regs, &ka.sa);
+		handle_syscall_restart(save_r0, regs, &ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
 		if (handle_signal(signr, &ka, &info, oldset,
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index b22fdfa..0663a0e 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -60,7 +60,6 @@ handle_syscall_restart(struct pt_regs *regs, struct sigaction *sa)
 		case -ERESTARTNOHAND:
 		no_system_call_restart:
 			regs->regs[REG_RET] = -EINTR;
-			regs->sr |= 1;
 			break;
 
 		case -ERESTARTSYS:
@@ -109,8 +108,7 @@ static int do_signal(struct pt_regs *regs, sigset_t *oldset)
 
 	signr = get_signal_to_deliver(&info, &ka, regs, 0);
 	if (signr > 0) {
-		if (regs->sr & 1)
-			handle_syscall_restart(regs, &ka.sa);
+		handle_syscall_restart(regs, &ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
 		if (handle_signal(signr, &info, &ka, oldset, regs) = 0) {
