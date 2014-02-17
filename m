From: Bobby Bingham <koorogi@koorogi.info>
Date: Mon, 17 Feb 2014 02:50:19 +0000
Subject: [PATCH 2/3] sh: remove unused do_fpu_error
Message-Id: <2ab03b9be8ee59f72cd89f44b2379967e346cf85.1392600646.git.koorogi@koorogi.info>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This does not appear to have been used since commit
74d99a5e262229ee865f6f68528d10b82471ead6 in 2007.

Signed-off-by: Bobby Bingham <koorogi@koorogi.info>
---
 arch/sh/math-emu/math.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/sh/math-emu/math.c b/arch/sh/math-emu/math.c
index b876780..04aa55f 100644
--- a/arch/sh/math-emu/math.c
+++ b/arch/sh/math-emu/math.c
@@ -574,24 +574,6 @@ static int ieee_fpe_handler(struct pt_regs *regs)
 	return 0;
 }
 
-asmlinkage void do_fpu_error(unsigned long r4, unsigned long r5,
-			     unsigned long r6, unsigned long r7,
-			     struct pt_regs regs)
-{
-	struct task_struct *tsk = current;
-	siginfo_t info;
-
-	if (ieee_fpe_handler (&regs))
-		return;
-
-	regs.pc += 2;
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_code = FPE_FLTINV;
-	info.si_addr = (void __user *)regs.pc;
-	force_sig_info(SIGFPE, &info, tsk);
-}
-
 /**
  * fpu_init - Initialize FPU registers
  * @fpu: Pointer to software emulated FPU registers.
-- 
1.8.5.4

