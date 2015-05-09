From: Chen Gang <xili_gchen_5257@hotmail.com>
Date: Sat, 09 May 2015 21:02:55 +0000
Subject: [PATCH] sh: Wire up missing syscalls
Message-Id: <BLU436-SMTP93208A4E06C8B5CC68CA1CB9DD0@phx.gbl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

The related warnings:

    CALL    scripts/checksyscalls.sh
  <stdin>:1229:2: warning: #warning syscall sched_setattr not implemented [-Wcpp]
  <stdin>:1232:2: warning: #warning syscall sched_getattr not implemented [-Wcpp]
  <stdin>:1235:2: warning: #warning syscall renameat2 not implemented [-Wcpp]
  <stdin>:1238:2: warning: #warning syscall seccomp not implemented [-Wcpp]
  <stdin>:1241:2: warning: #warning syscall getrandom not implemented [-Wcpp]
  <stdin>:1244:2: warning: #warning syscall memfd_create not implemented [-Wcpp]
  <stdin>:1247:2: warning: #warning syscall bpf not implemented [-Wcpp]
  <stdin>:1250:2: warning: #warning syscall execveat not implemented [-Wcpp]

Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 arch/sh/include/uapi/asm/unistd_32.h | 10 +++++++++-
 arch/sh/include/uapi/asm/unistd_64.h | 10 +++++++++-
 arch/sh/kernel/syscalls_32.S         |  8 ++++++++
 arch/sh/kernel/syscalls_64.S         |  8 ++++++++
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
index d13a1d6..be5052e 100644
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ b/arch/sh/include/uapi/asm/unistd_32.h
@@ -380,7 +380,15 @@
 #define __NR_process_vm_writev	366
 #define __NR_kcmp		367
 #define __NR_finit_module	368
+#define __NR_sched_setattr	369
+#define __NR_sched_getattr	370
+#define __NR_renameat2		371
+#define __NR_seccomp		372
+#define __NR_getrandom		373
+#define __NR_memfd_create	374
+#define __NR_bpf		375
+#define __NR_execveat		376
 
-#define NR_syscalls 369
+#define NR_syscalls 377
 
 #endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index e6820c8..decc1b8 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -400,7 +400,15 @@
 #define __NR_process_vm_writev	377
 #define __NR_kcmp		378
 #define __NR_finit_module	379
+#define __NR_sched_setattr	380
+#define __NR_sched_getattr	381
+#define __NR_renameat2		382
+#define __NR_seccomp		383
+#define __NR_getrandom		384
+#define __NR_memfd_create	385
+#define __NR_bpf		386
+#define __NR_execveat		387
 
-#define NR_syscalls 380
+#define NR_syscalls 388
 
 #endif /* __ASM_SH_UNISTD_64_H */
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index 734234b..39ddd5c 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -386,3 +386,11 @@ ENTRY(sys_call_table)
 	.long sys_process_vm_writev
 	.long sys_kcmp
 	.long sys_finit_module
+	.long sys_sched_setattr
+	.long sys_sched_getattr		/* 370 */
+	.long sys_renameat2
+	.long sys_seccomp
+	.long sys_getrandom
+	.long sys_memfd_create
+	.long sys_bpf			/* 375 */
+	.long sys_execveat
diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
index 579fcb9..793d140 100644
--- a/arch/sh/kernel/syscalls_64.S
+++ b/arch/sh/kernel/syscalls_64.S
@@ -406,3 +406,11 @@ sys_call_table:
 	.long sys_process_vm_writev
 	.long sys_kcmp
 	.long sys_finit_module
+	.long sys_sched_setattr		/* 380 */
+	.long sys_sched_getattr
+	.long sys_renameat2
+	.long sys_seccomp
+	.long sys_getrandom
+	.long sys_memfd_create		/* 385 */
+	.long sys_bpf
+	.long sys_execveat
-- 
1.9.3
