From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 16 Mar 2012 02:31:25 +0000
Subject: [PATCH 1/2] sh: dma: Collect up CHCR of SH7723 and SH7730
Message-Id: <1331865086-20880-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CHCR of SH7723 and SH7730 is constitution same as SH7724.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/dma-register.h |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 18fa80a..1af4a95 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -16,14 +16,15 @@
 
 #define DMAOR_INIT	DMAOR_DME
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7343) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7730)
+#if defined(CONFIG_CPU_SUBTYPE_SH7343)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
 #define CHCR_TS_HIGH_SHIFT	0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7722) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7723) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7724) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7730) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7786)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
@@ -35,11 +36,6 @@
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
 #define CHCR_TS_HIGH_SHIFT	0
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7757)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
-- 
1.7.9.1

