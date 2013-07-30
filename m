From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 30 Jul 2013 02:08:54 +0000
Subject: [PATCH 1/2] sh64: kernel: use 'usp' instead of 'fn'
Message-Id: <51F72036.9030304@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

'fn' is not defined, according to the implementation copy_thread() in
'sh32', need use 'usp' instead of.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sh/kernel/process_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index 174d124..eac5947 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -393,7 +393,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->regs[2] = (unsigned long)arg;
-		childregs->regs[3] = (unsigned long)fn;
+		childregs->regs[3] = (unsigned long)usp;
 		childregs->sr = (1 << 30); /* not user_mode */
 		childregs->sr |= SR_FD; /* Invalidate FPU flag */
 		p->thread.pc = (unsigned long) ret_from_kernel_thread;
-- 
1.7.7.6
