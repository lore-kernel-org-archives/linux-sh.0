From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 11 Jul 2009 00:29:04 +0000
Subject: [PATCH 3/3] sh: Mark __switch_to() as __notrace_funcgraph
Message-Id: <ec2374930859b12e4d2953b22f8e4b8321bdc4eb.1247272091.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Annotate __switch_to() so that the function graph tracer does not try to
trace it. Use __notrace_funcgraph, as opposed to notrace, so that other
tracers can continue to trace __switch_to().

The reason that we don't want to trace __switch_to() with the function
graph tracer is because of how the return address stack in task_struct
is implemented. When we enter __switch_to we store the real return
address on prev's ret_stack. When we return from __switch_to() we've
patched the return address on the kernel stack to be
return_to_handler. Calling return_to_handler we do,

       -> ftrace_return_to_handler()
       	  -> ftrace_pop_return_ftrace()

Which tries to pop the real return address from current->ret_stack. The
problem being that we stored the return address on prev->ret_stack, but
current now points to next, and next->ret_stack doesn't contain the
correct return address (and is possibly even empty).

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/kernel/process_32.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 92d7740..9fee977 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -23,6 +23,7 @@
 #include <linux/tick.h>
 #include <linux/reboot.h>
 #include <linux/fs.h>
+#include <linux/ftrace.h>
 #include <linux/preempt.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -264,8 +265,8 @@ static void ubc_set_tracing(int asid, unsigned long pc)
  *	switch_to(x,y) should switch tasks from x to y.
  *
  */
-struct task_struct *__switch_to(struct task_struct *prev,
-				struct task_struct *next)
+__notrace_funcgraph struct task_struct *
+__switch_to(struct task_struct *prev, struct task_struct *next)
 {
 #if defined(CONFIG_SH_FPU)
 	unlazy_fpu(prev, task_pt_regs(prev));
-- 
1.6.3.2.316.gda4e

