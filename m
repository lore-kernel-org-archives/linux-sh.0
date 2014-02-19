From: Bobby Bingham <koorogi@koorogi.info>
Date: Wed, 19 Feb 2014 06:03:15 +0000
Subject: [PATCH v2 2/3] sh: remove unused do_fpu_error
Message-Id: <0645431563b3c6782171218dc5b65461c8bd7dcd.1392789383.git.koorogi@koorogi.info>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1392789383.git.koorogi@koorogi.info>
In-Reply-To: <cover.1392789383.git.koorogi@koorogi.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, linux-sh@vger.kernel.org
Cc: Bobby Bingham <koorogi@koorogi.info>, linux-kernel@vger.kernel.org

This does not appear to have been used since commit
74d99a5e262229ee865f6f68528d10b82471ead6 (sh: SH-2A FPU support) in
2007.

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
1.8.5.5

