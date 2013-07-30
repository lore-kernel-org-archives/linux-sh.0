From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 30 Jul 2013 02:09:42 +0000
Subject: [PATCH 2/2] sh64: kernel: remove useless variable 'regs'
Message-Id: <51F72066.9080407@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

remvoe useless variable 'regs' to avoid the related warnings (warning
is treated as error).

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sh/kernel/process_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index eac5947..e2062e6 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -374,7 +374,7 @@ asmlinkage void ret_from_kernel_thread(void);
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long arg, struct task_struct *p)
 {
-	struct pt_regs *childregs, *regs = current_pt_regs();
+	struct pt_regs *childregs;
 
 #ifdef CONFIG_SH_FPU
 	/* can't happen for a kernel thread */
-- 
1.7.7.6
