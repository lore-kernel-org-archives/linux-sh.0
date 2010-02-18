From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Feb 2010 15:24:17 +0000
Subject: [PATCH] sh: merge sh7722 and sh7724 DMA register definitions
Message-Id: <Pine.LNX.4.64.1002181620550.4373@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

DMA CHCR register layout is equal on sh7722 and sh7724, reuse definitions.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 008e7fc..55f9fec 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -22,7 +22,8 @@
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
 #define CHCR_TS_HIGH_SHIFT	0
-#elif defined(CONFIG_CPU_SUBTYPE_SH7722)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7722) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7724)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0x00300000
@@ -38,11 +39,6 @@
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
 #define CHCR_TS_HIGH_SHIFT	0
-#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0x00600000
-#define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
