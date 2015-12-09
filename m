From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Wed, 09 Dec 2015 03:16:55 +0000
Subject: [PATCH] sh64: fix __NR_fgetxattr
Message-Id: <20151209031655.GA22704@altlinux.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

According to arch/sh/kernel/syscalls_64.S and common sense,
__NR_fgetxattr has to be defined to 259, but it doesn't.
Instead, it's defined to 269, which is of course used
by another syscall, __NR_sched_setaffinity in this case.

This bug was found by strace test suite.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Cc: stable@vger.kernel.org
---
 arch/sh/include/uapi/asm/unistd_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index e6820c8..47ebd5b 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -278,7 +278,7 @@
 #define __NR_fsetxattr		256
 #define __NR_getxattr		257
 #define __NR_lgetxattr		258
-#define __NR_fgetxattr		269
+#define __NR_fgetxattr		259
 #define __NR_listxattr		260
 #define __NR_llistxattr		261
 #define __NR_flistxattr		262
-- 
ldv
