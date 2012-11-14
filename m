From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 14 Nov 2012 06:26:37 +0000
Subject: [PATCH v2] sh: Wire up finit_module syscall
Message-Id: <1352874397-6772-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 v2: Fix syncall id in unistd_64.h

 arch/sh/include/uapi/asm/unistd_32.h |    3 ++-
 arch/sh/include/uapi/asm/unistd_64.h |    3 ++-
 arch/sh/kernel/syscalls_32.S         |    1 +
 arch/sh/kernel/syscalls_64.S         |    1 +
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
index 9e465f2..d13a1d6 100644
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ b/arch/sh/include/uapi/asm/unistd_32.h
@@ -379,7 +379,8 @@
 #define __NR_process_vm_readv	365
 #define __NR_process_vm_writev	366
 #define __NR_kcmp		367
+#define __NR_finit_module	368
 
-#define NR_syscalls 368
+#define NR_syscalls 369
 
 #endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index 8e3a2ed..e6820c8 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -399,7 +399,8 @@
 #define __NR_process_vm_readv	376
 #define __NR_process_vm_writev	377
 #define __NR_kcmp		378
+#define __NR_finit_module	379
 
-#define NR_syscalls 379
+#define NR_syscalls 380
 
 #endif /* __ASM_SH_UNISTD_64_H */
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index fe97ae5..734234b 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -385,3 +385,4 @@ ENTRY(sys_call_table)
 	.long sys_process_vm_readv	/* 365 */
 	.long sys_process_vm_writev
 	.long sys_kcmp
+	.long sys_finit_module
diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
index 5c7b1c6..579fcb9 100644
--- a/arch/sh/kernel/syscalls_64.S
+++ b/arch/sh/kernel/syscalls_64.S
@@ -405,3 +405,4 @@ sys_call_table:
 	.long sys_process_vm_readv
 	.long sys_process_vm_writev
 	.long sys_kcmp
+	.long sys_finit_module
-- 
1.7.10.4

