From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Mon, 22 Jun 2020 23:43:23 +0000
Subject: [PATCH 14/17] sh: switch to copy_thread_tls()
Message-Id: <20200622234326.906346-15-christian.brauner@ubuntu.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200622234326.906346-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <christian.brauner@ubuntu.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org

Use the copy_thread_tls() calling convention which passes tls through a
register. This is required so we can remove the copy_thread{_tls}() split
and remove the HAVE_COPY_THREAD_TLS macro.

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/sh/Kconfig             | 1 +
 arch/sh/kernel/process_32.c | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 9fc2b010e938..e10118d61ce7 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -70,6 +70,7 @@ config SUPERH
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 	select SPARSE_IRQ
 	select HAVE_STACKPROTECTOR
+	select HAVE_COPY_THREAD_TLS
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 456cc8d171f7..537a82d80616 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -115,8 +115,8 @@ EXPORT_SYMBOL(dump_fpu);
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);
 
-int copy_thread(unsigned long clone_flags, unsigned long usp,
-		unsigned long arg, struct task_struct *p)
+int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+		    unsigned long arg, struct task_struct *p, unsigned long tls)
 {
 	struct thread_info *ti = task_thread_info(p);
 	struct pt_regs *childregs;
@@ -158,7 +158,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	ti->addr_limit = USER_DS;
 
 	if (clone_flags & CLONE_SETTLS)
-		childregs->gbr = childregs->regs[0];
+		childregs->gbr = tls;
 
 	childregs->regs[0] = 0; /* Set return value for child */
 	p->thread.pc = (unsigned long) ret_from_fork;
-- 
2.27.0
