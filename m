From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 01 Aug 2013 01:01:34 +0000
Subject: [PATCH v2] sh: include: asm: include "linux/sched.h" instead of "asm/ptrace.h" in "kgdb.h"
Message-Id: <51F9B36E.6090609@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Before really use "asm/ptrace.h", need include "linux/sched.h" firstly,
and also "linux/sched.h" has already included "asm/ptrace.h".

So in "kgdb.h", need include "linux/sched.h" instead of "asm/ptrace.h",
or 'allmodconfig' can not pass compiling.

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
 arch/sh/include/asm/kgdb.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/kgdb.h b/arch/sh/include/asm/kgdb.h
index 9e7d2d1..fef7091 100644
--- a/arch/sh/include/asm/kgdb.h
+++ b/arch/sh/include/asm/kgdb.h
@@ -2,7 +2,7 @@
 #define __ASM_SH_KGDB_H
 
 #include <asm/cacheflush.h>
-#include <asm/ptrace.h>
+#include <linux/sched.h>
 
 enum regnames {
 	GDB_R0, GDB_R1, GDB_R2, GDB_R3, GDB_R4, GDB_R5, GDB_R6, GDB_R7,
-- 
1.7.7.6
