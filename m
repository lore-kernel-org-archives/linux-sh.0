From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 01 Sep 2010 01:49:29 +0000
Subject: [PATCH] sh: Add syscall entries for non multiplexed socket calls
Message-Id: <1283305771-31182-1-git-send-email-carmelo.amoroso@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Linux kernel already has socket syscalls that can be invoked
without the multiplexing sys_socketcall wrapper.
C library wrappers are ready to use them directly. It needs just
to define the missing syscall numbers and provide the related entries
into the syscalls table, like sh64 aleady does.

Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/include/asm/unistd_32.h |   21 ++++++++++++++++++++-
 arch/sh/kernel/syscalls_32.S    |   18 ++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
index 01183ad..2000709 100644
--- a/arch/sh/include/asm/unistd_32.h
+++ b/arch/sh/include/asm/unistd_32.h
@@ -349,7 +349,26 @@
 #define __NR_fanotify_mark	338
 #define __NR_prlimit64		339
 
-#define NR_syscalls 340
+/* Non-multiplexed socket family */
+#define __NR_socket        340
+#define __NR_bind          341
+#define __NR_connect       342
+#define __NR_listen        343
+#define __NR_accept        344
+#define __NR_getsockname   345
+#define __NR_getpeername   346
+#define __NR_socketpair    347
+#define __NR_send          348
+#define __NR_sendto        349
+#define __NR_recv          350
+#define __NR_recvfrom      351
+#define __NR_shutdown      352
+#define __NR_setsockopt    353
+#define __NR_getsockopt    354
+#define __NR_sendmsg       355
+#define __NR_recvmsg       356
+
+#define NR_syscalls 357
 
 #ifdef __KERNEL__
 
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index 3c6d669..0847433 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -356,3 +356,21 @@ ENTRY(sys_call_table)
 	.long sys_fanotify_init
 	.long sys_fanotify_mark
 	.long sys_prlimit64
+	/* Broken-out socket family */
+	.long sys_socket		/* 340 */
+	.long sys_bind
+	.long sys_connect
+	.long sys_listen
+	.long sys_accept
+	.long sys_getsockname	/* 345 */
+	.long sys_getpeername
+	.long sys_socketpair
+	.long sys_send
+	.long sys_sendto
+	.long sys_recv			/* 350 */
+	.long sys_recvfrom
+	.long sys_shutdown
+	.long sys_setsockopt
+	.long sys_getsockopt
+	.long sys_sendmsg		/* 355 */
+	.long sys_recvmsg
-- 
1.5.5.6

