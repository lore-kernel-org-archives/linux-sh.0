From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 29 May 2009 07:41:18 +0000
Subject: [PATCH] sh4a: add L2 cache support
Message-Id: <uprdswe3l.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/cache.h |    5 +++++
 arch/sh/kernel/cpu/init.c           |    8 ++++++++
 arch/sh/mm/Kconfig                  |    5 +++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 1c61ebf..0a438f5 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -31,6 +31,11 @@
 #define CCR_CACHE_EMODE	0x80000000	/* EMODE Enable */
 #endif
 
+#define RAMCR			0xFF000074
+#define RAMCR_CACHE_L2FC	0x0002
+#define RAMCR_CACHE_L2E		0x0001
+#define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
+
 /* Default CCR setup: 8k+16k-byte cache,P1-wb,enable */
 #define CCR_CACHE_ENABLE	(CCR_CACHE_OCE|CCR_CACHE_ICE)
 #define CCR_CACHE_INVALIDATE	(CCR_CACHE_OCI|CCR_CACHE_ICI)
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index d29e69c..79646e8 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -146,6 +146,14 @@ static void __uses_jump_to_uncached cache_init(void)
 	flags &= ~CCR_CACHE_ENABLE;
 #endif
 
+#ifdef CONFIG_L2_CACHE_ENABLE
+	/* Enabel L2 cache */
+	if (current_cpu_data.flags & CPU_HAS_L2_CACHE) {
+		ctrl_outl(flags & ~CCR_CACHE_ENABLE, CCR);
+		ctrl_outl(L2_CACHE_ENABLE, RAMCR);
+	}
+#endif
+
 	ctrl_outl(flags, CCR);
 	back_to_cached();
 }
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 2795618..8be9d95 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -291,4 +291,9 @@ config CACHE_OFF
 
 endchoice
 
+config L2_CACHE_ENABLE
+	bool "L2 Cache Enable"
+	depends on CACHE_WRITEBACK || CACHE_WRITETHROUGH
+	depends on CPU_SH4
+
 endmenu
-- 
1.6.0.4

