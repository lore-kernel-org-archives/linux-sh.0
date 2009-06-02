From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 02 Jun 2009 02:49:20 +0000
Subject: [PATCH 2/4] sh: add l2_cache_init function on cache_init
Message-Id: <ubpp7e4en.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/init.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index d29e69c..ad85421 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -62,6 +62,11 @@ static void __init speculative_execution_init(void)
 #define speculative_execution_init()	do { } while (0)
 #endif
 
+/* 2nd-level cache init */
+void __uses_jump_to_uncached __attribute__ ((weak)) l2_cache_init(void)
+{
+}
+
 /*
  * Generic first-level cache init
  */
@@ -146,6 +151,8 @@ static void __uses_jump_to_uncached cache_init(void)
 	flags &= ~CCR_CACHE_ENABLE;
 #endif
 
+	l2_cache_init();
+
 	ctrl_outl(flags, CCR);
 	back_to_cached();
 }
-- 
1.6.0.4

