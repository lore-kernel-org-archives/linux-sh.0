From: Phil Edworthy <PHIL.EDWORTHY@renesas.com>
Date: Thu, 14 Apr 2011 15:11:35 +0000
Subject: [PATCH] 2.6.35.y: Revert
Message-Id: <1302793895-725-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This reverts commit 1219932ca26da2026e598590a3b7a2f36b3c3621
(commit d8b5fc01683c66060edc202d6bb5635365822181 upstream).

The reverted commit depends on an upstream commit that has not
been applied to 2.6.35.y (d7627467b7a8dd6944885290a03a07ceb28c10eb).

This fixes a build failure on all SH devices:

/arch/sh/kernel/process_32.c:299: error: conflicting types for 'sys_execve'
/arch/sh/include/asm/syscalls_32.h:22: note: previous declaration of 'sys_execve' was here

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/include/asm/syscalls_32.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/syscalls_32.h b/arch/sh/include/asm/syscalls_32.h
index 611e92d..8b30200 100644
--- a/arch/sh/include/asm/syscalls_32.h
+++ b/arch/sh/include/asm/syscalls_32.h
@@ -19,8 +19,8 @@ asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp,
 asmlinkage int sys_vfork(unsigned long r4, unsigned long r5,
 			 unsigned long r6, unsigned long r7,
 			 struct pt_regs __regs);
-asmlinkage int sys_execve(char __user *ufilename, const char __user * __user *uargv,
-			  const char __user * __user *uenvp, unsigned long r7,
+asmlinkage int sys_execve(char __user *ufilename, char __user * __user *uargv,
+			  char __user * __user *uenvp, unsigned long r7,
 			  struct pt_regs __regs);
 asmlinkage int sys_sigsuspend(old_sigset_t mask, unsigned long r5,
 			      unsigned long r6, unsigned long r7,
-- 
1.7.1

