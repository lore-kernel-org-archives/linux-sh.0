From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Thu, 20 Nov 2008 11:50:32 +0000
Subject: [RFC PATCH 1/1] Support for sh4a fastpath mutex implementation
Message-Id: <20081120115032.GA26685@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Support for sh4a fastpath mutex implementation

Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>

---
 arch/sh/include/asm/mutex.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/mutex.h b/arch/sh/include/asm/mutex.h
index 458c1f7..24b7a98 100644
--- a/arch/sh/include/asm/mutex.h
+++ b/arch/sh/include/asm/mutex.h
@@ -5,5 +5,8 @@
  * implementation in place, or pick the atomic_xchg() based generic
  * implementation. (see asm-generic/mutex-xchg.h for details)
  */
-
+#if defined(CONFIG_CPU_SH4A)
+#include <asm/mutex_sh.h>
+#else
 #include <asm-generic/mutex-dec.h>
+#endif
-- 
1.5.6.5

