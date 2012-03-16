From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 16 Mar 2012 02:31:26 +0000
Subject: [PATCH 2/2] sh: dma: Collect up CHCR of SH7763, SH7764, SH7780 and SH7785
Message-Id: <1331865086-20880-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CHCR of SH7763, SH7764, SH7780 and SH7785 is constitution same as SH7757.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/dma-register.h |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 1af4a95..02788b6 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -30,27 +30,15 @@
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0x00300000
 #define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
-#elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7764)
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
-#elif defined(CONFIG_CPU_SUBTYPE_SH7757)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7757) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7763) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7764) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7780) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7785)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0x00100000
 #define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
-#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
-#else /* SH7785 */
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #endif
 
 /* Transmit sizes and respective CHCR register values */
-- 
1.7.9.1

