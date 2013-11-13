From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Date: Wed, 13 Nov 2013 14:38:24 +0000
Subject: [PATCH] sh: fix kernel build error
Message-Id: <1384353504-21886-1-git-send-email-gaowanlong@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org, fengguang.wu@intel.com, kbuild-all@01.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>

   arch/sh/kernel/kgdb.c: In function 'sleeping_thread_to_gdb_regs':
>> arch/sh/kernel/kgdb.c:225:32: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
>> arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type
>> arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type
   arch/sh/kernel/kgdb.c: In function 'singlestep_trap_handler':
>> arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function)
   arch/sh/kernel/kgdb.c:310:27: note: each undeclared identifier is reported only once for each function it appears in
   cc1: all warnings being treated as errors

This is introduced by commit 16559ae.

CC: kbuild-all@01.org
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 arch/sh/kernel/kgdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 38b3139..adad46e 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -13,6 +13,7 @@
 #include <linux/kdebug.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
 
-- 
1.8.5.rc1.17.g0ecd94d

