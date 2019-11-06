From: Dmitry Safonov <dima@arista.com>
Date: Wed, 06 Nov 2019 03:05:24 +0000
Subject: [PATCH 33/50] sh: Add show_stack_loglvl()
Message-Id: <20191106030542.868541-34-dima@arista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191106030542.868541-1-dima@arista.com>
In-Reply-To: <20191106030542.868541-1-dima@arista.com>
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

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index d488a47a1f0f..cc51e9d74667 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -144,7 +144,8 @@ void show_trace(struct task_struct *tsk, unsigned long *sp,
 	debug_show_held_locks(tsk);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long stack;
 
@@ -156,7 +157,12 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 		sp = (unsigned long *)tsk->thread.sp;
 
 	stack = (unsigned long)sp;
-	dump_mem("Stack: ", KERN_DEFAULT, stack, THREAD_SIZE +
+	dump_mem("Stack: ", loglvl, stack, THREAD_SIZE +
 		 (unsigned long)task_stack_page(tsk));
-	show_trace(tsk, sp, NULL, KERN_DEFAULT);
+	show_trace(tsk, sp, NULL, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
-- 
2.23.0
