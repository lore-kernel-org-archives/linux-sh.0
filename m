From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 02 Jun 2009 02:49:13 +0000
Subject: [PATCH 1/4] cache.h: add RAMCR definition for sh4
Message-Id: <ud49ne4eu.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/cache.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 1c61ebf..7bfb9e8 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -38,5 +38,7 @@
 #define CACHE_IC_ADDRESS_ARRAY	0xf0000000
 #define CACHE_OC_ADDRESS_ARRAY	0xf4000000
 
+#define RAMCR			0xFF000074
+
 #endif /* __ASM_CPU_SH4_CACHE_H */
 
-- 
1.6.0.4

