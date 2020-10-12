From: Jinyang He <hejinyang@loongson.cn>
Date: Mon, 12 Oct 2020 03:50:24 +0000
Subject: [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro
Message-Id: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Christian Brauner <christian.brauner@ubuntu.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes: 	e1cc9d8d596e ("sh: switch to copy_thread_tls()")
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/sh/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d209271..165f291 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -30,7 +30,6 @@ config SUPERH
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_COPY_THREAD_TLS
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
-- 
2.1.0
