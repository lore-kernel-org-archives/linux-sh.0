From: Richard Weinberger <richard@nod.at>
Date: Fri, 25 May 2012 22:04:26 +0000
Subject: [PATCH 10/20] sh: Do not call do_signal() with irqs disabled
Message-Id: <1337983476-22081-10-git-send-email-richard@nod.at>
List-Id: <linux-sh.vger.kernel.org>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

get_signal_to_deliver() calls try_to_freeze() which might sleep.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/sh/kernel/signal_32.c |    3 +++
 arch/sh/kernel/signal_64.c |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/signal_32.c b/arch/sh/kernel/signal_32.c
index cb4172c..4f1db5e 100644
--- a/arch/sh/kernel/signal_32.c
+++ b/arch/sh/kernel/signal_32.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/io.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -619,6 +620,8 @@ static void do_signal(struct pt_regs *regs, unsigned int save_r0)
 asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned int save_r0,
 				 unsigned long thread_info_flags)
 {
+	local_irq_enable();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs, save_r0);
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index b589a35..f92fdb7 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -23,6 +23,7 @@
 #include <linux/unistd.h>
 #include <linux/stddef.h>
 #include <linux/tracehook.h>
+#include <linux/irqflags.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -679,6 +680,8 @@ handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
 
 asmlinkage void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
 {
+	local_irq_enable();
+
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
 
-- 
1.7.7.3

