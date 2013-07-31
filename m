From: Chen Gang <gang.chen@asianux.com>
Date: Wed, 31 Jul 2013 08:53:30 +0000
Subject: [PATCH] sh: include: asm: include "linux/sched.h" in "ptrace.h"
Message-Id: <51F8D08A.8000502@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Need include "linux/sched.h" in "ptrace.h", or 'allmodconfig' can not

pass compiling.

The relate error:

    CC      arch/sh/kernel/kgdb.o
  In file included from /root/linux-next/arch/sh/include/asm/kgdb.h:5:0,
                   from include/linux/kgdb.h:20,
                   from arch/sh/kernel/kgdb.c:12:
  arch/sh/kernel/kgdb.c: In function 'sleeping_thread_to_gdb_regs':
  arch/sh/include/asm/ptrace.h:103:11: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
    ((struct pt_regs *) (task_stack_page(task) + THREAD_SIZE) - 1)
             ^
  arch/sh/kernel/kgdb.c:225:32: note: in expansion of macro 'task_pt_regs'
    struct pt_regs *thread_regs = task_pt_regs(p);
                                  ^
  arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type
    gdb_regs[GDB_R15] = p->thread.sp;
                         ^
  arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type
    gdb_regs[GDB_PC] = p->thread.pc;
                        ^
  arch/sh/kernel/kgdb.c: In function 'singlestep_trap_handler':
  arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function)
    kgdb_handle_exception(0, SIGTRAP, 0, regs);
                             ^
  arch/sh/kernel/kgdb.c:310:27: note: each undeclared identifier is reported only once for each function it appears in


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sh/include/asm/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 2506c7d..b5784f9 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -11,6 +11,7 @@
 #include <asm/addrspace.h>
 #include <asm/page.h>
 #include <uapi/asm/ptrace.h>
+#include <linux/sched.h>
 
 #define user_mode(regs)			(((regs)->sr & 0x40000000)=0)
 #define kernel_stack_pointer(_regs)	((unsigned long)(_regs)->regs[15])
-- 
1.7.7.6
