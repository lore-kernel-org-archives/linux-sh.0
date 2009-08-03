From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 03 Aug 2009 04:52:24 +0000
Subject: [PATCH] Add SH7724 support to DMAC
Message-Id: <u7hxlts6v.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/include/asm/dma-sh.h           |    1 +
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index 0c8f8e1..68a5f4c 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -16,6 +16,7 @@
 
 /* DMAOR contorl: The DMAOR access size is different by CPU.*/
 #if defined(CONFIG_CPU_SUBTYPE_SH7723)	|| \
+    defined(CONFIG_CPU_SUBTYPE_SH7724)	|| \
     defined(CONFIG_CPU_SUBTYPE_SH7780)	|| \
     defined(CONFIG_CPU_SUBTYPE_SH7785)
 #define dmaor_read_reg(n) \
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
index 0ed5178..f0886bc 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -16,7 +16,8 @@
 #define DMAE0_IRQ	38
 #define SH_DMAC_BASE0	0xFF608020
 #define SH_DMARS_BASE	0xFF609000
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723) || \
+      defined(CONFIG_CPU_SUBTYPE_SH7724)
 #define DMTE0_IRQ	48	/* DMAC0A*/
 #define DMTE4_IRQ	40	/* DMAC0B */
 #define DMTE6_IRQ	42
-- 
1.6.0.4

