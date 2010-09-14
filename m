From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 14 Sep 2010 19:35:00 +0000
Subject: [PATCH 09/18] sh: kill big kernel lock
Message-Id: <1284492909-7147-10-git-send-email-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The only BKL user in arch/sh protects a single bit,
so we can trivially replace it with test_and_set_bit.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/ptrace_64.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 5fd644d..178b6b0 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -20,7 +20,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
+#include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
@@ -395,10 +395,9 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 asmlinkage int sh64_ptrace(long request, long pid, long addr, long data)
 {
 #define WPC_DBRMODE 0x0d104008
-	static int first_call = 1;
+	static unsigned long first_call;
 
-	lock_kernel();
-	if (first_call) {
+	if (!test_and_set_bit(0, &first_call)) {
 		/* Set WPC.DBRMODE to 0.  This makes all debug events get
 		 * delivered through RESVEC, i.e. into the handlers in entry.S.
 		 * (If the kernel was downloaded using a remote gdb, WPC.DBRMODE
@@ -408,9 +407,7 @@ asmlinkage int sh64_ptrace(long request, long pid, long addr, long data)
 		 * the remote gdb.) */
 		printk("DBRMODE set to 0 to permit native debugging\n");
 		poke_real_address_q(WPC_DBRMODE, 0);
-		first_call = 0;
 	}
-	unlock_kernel();
 
 	return sys_ptrace(request, pid, addr, data);
 }
-- 
1.7.1

