From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 31 Jul 2018 10:36:09 +0000
Subject: [PATCH] sh: systemcall wireup
Message-Id: <20180731103609.127718-1-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/uapi/asm/unistd_32.h | 8 ++++++--
 arch/sh/kernel/syscalls_32.S         | 5 +++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
index 58f04cf3d1d9..4f0fa3ab99f8 100644
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ b/arch/sh/include/uapi/asm/unistd_32.h
@@ -395,7 +395,11 @@
 #define __NR_copy_file_range	380
 #define __NR_preadv2		381
 #define __NR_pwritev2		382
-
-#define NR_syscalls 383
+#define __NR_pkey_mprotect	383
+#define __NR_pkey_alloc		384
+#define __NR_pkey_free		385
+#define __NR_statx		386
+#define __NR_io_pgetevents	387
+#define NR_syscalls 388
 
 #endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index 254bc22ee57d..dd2aa16327af 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -400,3 +400,8 @@ ENTRY(sys_call_table)
 	.long sys_copy_file_range	/* 380 */
 	.long sys_preadv2
 	.long sys_pwritev2
+	.long sys_pkey_mprotect
+	.long sys_pkey_alloc
+	.long sys_pkey_free		/* 385 */
+	.long sys_statx
+	.long sys_io_pgetevents
-- 
2.11.0

