From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 09 Nov 2020 14:14:00 +0000
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
Message-Id: <f6914e11-5d7c-576f-4797-83f7294722aa@kernel.dk>
List-Id: <linux-sh.vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
In-Reply-To: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/9/20 1:15 AM, Rob Landley wrote:
> On 11/5/20 11:15 AM, Jens Axboe wrote:
>> On 11/5/20 9:20 AM, John Paul Adrian Glaubitz wrote:
>>> Hi Jens!
>>>
>>> On 11/5/20 5:17 PM, Jens Axboe wrote:
>>>> Gentle nudge on this one.
>>>
>>> I can build- and boot-test on SH and IA64.
>>
>> That'd be great, thanks!
>>
>>> I assume Rich will be fine with the SH changes, not sure about the IA64 and Tony.
>>
>> Let's add Tony - maybe he'll have a chance to take a look at the ia64 change.
> 
> It breaks my ARCH=sh j2_defconfig build:
> 
> arch/sh/kernel/signal_32.c: In function 'do_signal':
> arch/sh/kernel/signal_32.c:469:6: error: 'ti_work' undeclared (first use in this
> function)
> 
> Admittedly I'm testing a stack of 6 other patches at the same time:
> 
> [PATCH -next v2] sh: intc: Convert to DEFINE_SHOW_ATTRIBUTE.eml
> [PATCH] sh: dma: fix kconfig dependency for G2_DMA.eml
> [PATCH] sh: remove CONFIG_IDE from most defconfig.eml
> [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro.eml
> [PATCH v1] sh: Drop ARCH_NR_GPIOS definition.eml
> [PATCH v2 RESEND +TRIVIAL] arch_sh: hyphenate Non-Uniform in Kconfig prompt.eml
> 
> But this is the one I need to revert to get 5.10-rc3 to build, the rest compile.

Yeah that's my fault, this one should be a lot better...


commit de2791b15d47a56854054da71064b9634896728b
Author: Jens Axboe <axboe@kernel.dk>
Date:   Fri Oct 9 15:36:35 2020 -0600

    sh: add support for TIF_NOTIFY_SIGNAL
    
    Wire up TIF_NOTIFY_SIGNAL handling for sh.
    
    Cc: linux-sh@vger.kernel.org
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

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
index 1add47fd31f6..e78d3e10a203 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -453,7 +453,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs, unsigned int save_r0)
  * the kernel can handle, and then we build all the user-level signal handling
  * stack-frames in one go after that.
  */
-static void do_signal(struct pt_regs *regs, unsigned int save_r0)
+static void do_signal(struct pt_regs *regs, unsigned int save_r0,
+		      unsigned long ti_work)
 {
 	struct ksignal ksig;
 
@@ -466,7 +467,10 @@ static void do_signal(struct pt_regs *regs, unsigned int save_r0)
 	if (!user_mode(regs))
 		return;
 
-	if (get_signal(&ksig)) {
+	if (ti_work & _TIF_NOTIFY_SIGNAL)
+		tracehook_notify_signal();
+
+	if ((ti_work & _TIF_SIGPENDING) && get_signal(&ksig)) {
 		handle_syscall_restart(save_r0, regs, &ksig.ka.sa);
 
 		/* Whee!  Actually deliver the signal.  */
@@ -499,8 +503,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned int save_r0,
 				 unsigned long thread_info_flags)
 {
 	/* deal with pending signal delivery */
-	if (thread_info_flags & _TIF_SIGPENDING)
-		do_signal(regs, save_r0);
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+		do_signal(regs, save_r0, thread_info_flags);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
 		tracehook_notify_resume(regs);

-- 
Jens Axboe
