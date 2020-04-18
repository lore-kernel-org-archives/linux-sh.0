From: Dmitry Safonov <dima@arista.com>
Date: Sat, 18 Apr 2020 20:19:23 +0000
Subject: [PATCHv3 29/50] sh: Add loglvl to dump_mem()
Message-Id: <20200418201944.482088-30-dima@arista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level argument to dump_mem() as a preparation to introduce
show_stack_loglvl().

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/include/asm/kdebug.h |  3 ++-
 arch/sh/kernel/dumpstack.c   | 17 +++++++++--------
 arch/sh/kernel/traps.c       |  4 ++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/sh/include/asm/kdebug.h b/arch/sh/include/asm/kdebug.h
index 5212f5fcd752..de8693fabb1d 100644
--- a/arch/sh/include/asm/kdebug.h
+++ b/arch/sh/include/asm/kdebug.h
@@ -13,6 +13,7 @@ enum die_val {
 
 /* arch/sh/kernel/dumpstack.c */
 extern void printk_address(unsigned long address, int reliable);
-extern void dump_mem(const char *str, unsigned long bottom, unsigned long top);
+extern void dump_mem(const char *str, const char *loglvl,
+		     unsigned long bottom, unsigned long top);
 
 #endif /* __ASM_SH_KDEBUG_H */
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index 9f1c9c11d62d..6784b914fba0 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -16,30 +16,31 @@
 #include <asm/unwinder.h>
 #include <asm/stacktrace.h>
 
-void dump_mem(const char *str, unsigned long bottom, unsigned long top)
+void dump_mem(const char *str, const char *loglvl,
+	      unsigned long bottom, unsigned long top)
 {
 	unsigned long p;
 	int i;
 
-	printk("%s(0x%08lx to 0x%08lx)\n", str, bottom, top);
+	printk("%s%s(0x%08lx to 0x%08lx)\n", loglvl, str, bottom, top);
 
 	for (p = bottom & ~31; p < top; ) {
-		printk("%04lx: ", p & 0xffff);
+		printk("%s%04lx: ", loglvl,  p & 0xffff);
 
 		for (i = 0; i < 8; i++, p += 4) {
 			unsigned int val;
 
 			if (p < bottom || p >= top)
-				printk("         ");
+				printk("%s         ", loglvl);
 			else {
 				if (__get_user(val, (unsigned int __user *)p)) {
-					printk("\n");
+					printk("%s\n", loglvl);
 					return;
 				}
-				printk("%08x ", val);
+				printk("%s%08x ", loglvl, val);
 			}
 		}
-		printk("\n");
+		printk("%s\n", loglvl);
 	}
 }
 
@@ -156,7 +157,7 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 		sp = (unsigned long *)tsk->thread.sp;
 
 	stack = (unsigned long)sp;
-	dump_mem("Stack: ", stack, THREAD_SIZE +
+	dump_mem("Stack: ", KERN_DEFAULT, stack, THREAD_SIZE +
 		 (unsigned long)task_stack_page(tsk));
 	show_trace(tsk, sp, NULL);
 }
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index 63cf17bc760d..faad65409075 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -38,8 +38,8 @@ void die(const char *str, struct pt_regs *regs, long err)
 			task_pid_nr(current), task_stack_page(current) + 1);
 
 	if (!user_mode(regs) || in_interrupt())
-		dump_mem("Stack: ", regs->regs[15], THREAD_SIZE +
-			 (unsigned long)task_stack_page(current));
+		dump_mem("Stack: ", KERN_DEFAULT, regs->regs[15],
+			THREAD_SIZE + (unsigned long)task_stack_page(current));
 
 	notify_die(DIE_OOPS, str, regs, err, 255, SIGSEGV);
 
-- 
2.26.0
