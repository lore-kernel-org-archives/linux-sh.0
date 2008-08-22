From: Adrian Bunk <bunk@kernel.org>
Date: Fri, 22 Aug 2008 15:20:36 +0000
Subject: [2.6 patch] sh: fix ptrace_64.c:user_disable_single_step()
Message-Id: <20080822152036.GB26762@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following compile error caused by
commit c459dbf294b4a3d70490a468a7ca3907fb2c2f57
(sh: ptrace single stepping cleanups.):

<--  snip  -->

...
  CC      arch/sh/kernel/ptrace_64.o
arch/sh/kernel/ptrace_64.c: In function 'user_disable_single_step':
arch/sh/kernel/ptrace_64.c:134: error: 'regs' undeclared (first use in this function)
arch/sh/kernel/ptrace_64.c:134: error: (Each undeclared identifier is reported only once
arch/sh/kernel/ptrace_64.c:134: error: for each function it appears in.)
...
make[2]: *** [arch/sh/kernel/ptrace_64.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
956a62dc8d102633bdeb955f639d179b066703a5 
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 5922edd..9c64248 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -131,6 +131,8 @@ void user_enable_single_step(struct task_struct *child)
 
 void user_disable_single_step(struct task_struct *child)
 {
+	struct pt_regs *regs = child->thread.uregs;
+
 	regs->sr &= ~SR_SSTEP;
 }
 

