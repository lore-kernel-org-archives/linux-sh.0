From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Dec 2009 12:20:41 +0000
Subject: [PATCH] sh: fix build with FPU disabled
Message-Id: <20091203122041.9836.36225.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch makes sure platforms lacking FPU build
Without this sh7722 fails to build.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/process_32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/process_32.c
+++ work/arch/sh/kernel/process_32.c	2009-12-03 15:03:27.000000000 +0900
@@ -290,9 +290,9 @@ static void ubc_set_tracing(int asid, un
 __notrace_funcgraph struct task_struct *
 __switch_to(struct task_struct *prev, struct task_struct *next)
 {
+#if defined(CONFIG_SH_FPU)
 	struct thread_struct *next_t = &next->thread;
 
-#if defined(CONFIG_SH_FPU)
 	unlazy_fpu(prev, task_pt_regs(prev));
 
 	/* we're going to use this soon, after a few expensive things */
