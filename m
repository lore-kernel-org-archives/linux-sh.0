From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Wed, 01 Sep 2010 01:54:15 +0000
Subject: [PATCH] sh: Remove unused __IGNORE_recvmmsg macro.
Message-Id: <1283306055-761-1-git-send-email-carmelo.amoroso@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 arch/sh/include/asm/unistd_32.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/unistd_32.h b/arch/sh/include/asm/unistd_32.h
index a683d2f..4769278 100644
--- a/arch/sh/include/asm/unistd_32.h
+++ b/arch/sh/include/asm/unistd_32.h
@@ -372,8 +372,6 @@
 
 #ifdef __KERNEL__
 
-#define __IGNORE_recvmmsg
-
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
-- 
1.5.5.6

