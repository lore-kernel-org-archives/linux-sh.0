From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Feb 2008 08:26:54 +0000
Subject: [PATCH] sh: fix ptrace copy_from/to_user() compilation error
Message-Id: <20080208082654.32594.98688.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch makes the 32-bit ptrace code compile again.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/ptrace_32.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/ptrace_32.c
+++ work/arch/sh/kernel/ptrace_32.c	2008-02-08 14:57:44.000000000 +0900
@@ -220,7 +220,7 @@ long arch_ptrace(struct task_struct *chi
 		dp = ((unsigned long) child) + THREAD_SIZE -
 			 sizeof(struct pt_dspregs);
 		if (*((int *) (dp - 4)) = SR_FD) {
-			copy_to_user(addr, (void *) dp,
+			copy_to_user((void *)addr, (void *) dp,
 				sizeof(struct pt_dspregs));
 			ret = 0;
 		}
@@ -234,7 +234,7 @@ long arch_ptrace(struct task_struct *chi
 		dp = ((unsigned long) child) + THREAD_SIZE -
 			 sizeof(struct pt_dspregs);
 		if (*((int *) (dp - 4)) = SR_FD) {
-			copy_from_user((void *) dp, addr,
+			copy_from_user((void *) dp, (void *)addr,
 				sizeof(struct pt_dspregs));
 			ret = 0;
 		}
