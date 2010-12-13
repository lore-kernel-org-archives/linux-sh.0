From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Mon, 13 Dec 2010 10:20:26 +0000
Subject: [PATCH (sh-2.6)] sh: wire up accept4 syscall (non-multiplexed path)
Message-Id: <1292235626-23589-1-git-send-email-carmelo.amoroso@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/include/asm/unistd_32.h |    3 ++-
 arch/sh/kernel/syscalls_32.S    |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
index 903cd61..d6741fc 100644
--- a/arch/sh/include/asm/unistd_32.h
+++ b/arch/sh/include/asm/unistd_32.h
@@ -368,8 +368,9 @@
 #define __NR_sendmsg		355
 #define __NR_recvmsg		356
 #define __NR_recvmmsg		357
+#define __NR_accept4		358
 
-#define NR_syscalls 358
+#define NR_syscalls 359
 
 #ifdef __KERNEL__
 
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index e872e81..6fc347e 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -375,3 +375,4 @@ ENTRY(sys_call_table)
 	.long sys_sendmsg		/* 355 */
 	.long sys_recvmsg
 	.long sys_recvmmsg
+	.long sys_accept4
-- 
1.5.5.6
