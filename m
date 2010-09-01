From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 01 Sep 2010 01:49:30 +0000
Subject: [PATCH] sh_net: Do not implement socketcall, use specific syscalls.
Message-Id: <1283305771-31182-2-git-send-email-carmelo.amoroso@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Socket syscalls entries are now available in the syscall table,
so it does not need to implement the multipler syscall.
It is mapped into the sys_ni_syscall.

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/include/asm/unistd_32.h |    1 -
 arch/sh/include/asm/unistd_64.h |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
index 2000709..a683d2f 100644
--- a/arch/sh/include/asm/unistd_32.h
+++ b/arch/sh/include/asm/unistd_32.h
@@ -387,7 +387,6 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
-#define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_LLSEEK
diff --git a/arch/sh/include/asm/unistd_64.h b/arch/sh/include/asm/unistd_64.h
index 09aa93f..2a91bb2 100644
--- a/arch/sh/include/asm/unistd_64.h
+++ b/arch/sh/include/asm/unistd_64.h
@@ -408,7 +408,6 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_WAITPID
-#define __ARCH_WANT_SYS_SOCKETCALL
 #define __ARCH_WANT_SYS_FADVISE64
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_LLSEEK
-- 
1.5.5.6

