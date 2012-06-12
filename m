From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:33:53 +0000
Subject: [PATCH 04/27 v2] ARM: shmobile: shareing DMAEngine definitions
Message-Id: <871ulkyiv6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current shmobile have DMAEngine specific settings on each CPU code,
but SH-ARM DMAC use same value.
This patch will share DMAEngine definitions and reduce a waste of code
on SH-ARM architecture.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
v1 -> v2

 - TS_SHIFT -> static dma_ts_shift

 arch/arm/mach-shmobile/include/mach/dma-register.h |   45 +++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c              |   80 +++++++-------------
 arch/arm/mach-shmobile/setup-sh73a0.c              |   33 +-------
 3 files changed, 75 insertions(+), 83 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/dma-register.h

diff --git a/arch/arm/mach-shmobile/include/mach/dma-register.h b/arch/arm/mach-shmobile/include/mach/dma-register.h
new file mode 100644
index 0000000..0ed1e90
--- /dev/null
+++ b/arch/arm/mach-shmobile/include/mach/dma-register.h
@@ -0,0 +1,45 @@
+/*
+ * SH-ARM CPU-specific DMA definitions, used by both DMA drivers
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp
+ *
+ * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * Based on arch/sh/include/cpu-sh4/cpu/dma-register.h
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef DMA_REGISTER_H
+#define DMA_REGISTER_H
+
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_512BIT		= 5,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+static const unsigned int dma_ts_shift[] = {
+	[XMIT_SZ_8BIT]		= 0,
+	[XMIT_SZ_16BIT]		= 1,
+	[XMIT_SZ_32BIT]		= 2,
+	[XMIT_SZ_64BIT]		= 3,
+	[XMIT_SZ_128BIT]	= 4,
+	[XMIT_SZ_256BIT]	= 5,
+	[XMIT_SZ_512BIT]	= 6,
+};
+
+#define TS_INDEX2VAL(i) ((((i) & 0x3) << 3) | (((i) & 0xc) << (20 - 2)))
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+
+#endif /* DMA_REGISTER_H */
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index fafce9c..a0e3113 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -33,6 +33,7 @@
 #include <linux/sh_timer.h>
 #include <linux/pm_domain.h>
 #include <linux/dma-mapping.h>
+#include <mach/dma-register.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
@@ -335,151 +336,126 @@ static struct platform_device iic1_device = {
 };
 
 /* DMA */
-/* Transmit sizes and respective CHCR register values */
-enum {
-	XMIT_SZ_8BIT		= 0,
-	XMIT_SZ_16BIT		= 1,
-	XMIT_SZ_32BIT		= 2,
-	XMIT_SZ_64BIT		= 7,
-	XMIT_SZ_128BIT		= 3,
-	XMIT_SZ_256BIT		= 4,
-	XMIT_SZ_512BIT		= 5,
-};
-
-/* log2(size / 8) - used to calculate number of transfers */
-#define TS_SHIFT {			\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_64BIT]		= 3,	\
-	[XMIT_SZ_128BIT]	= 4,	\
-	[XMIT_SZ_256BIT]	= 5,	\
-	[XMIT_SZ_512BIT]	= 6,	\
-}
-
-#define TS_INDEX2VAL(i) ((((i) & 3) << 3) | \
-			 (((i) & 0xc) << (20 - 2)))
-
 static const struct sh_dmae_slave_config sh7372_dmae_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
 		.addr		= 0xe6c40020,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x21,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF0_RX,
 		.addr		= 0xe6c40024,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x22,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF1_TX,
 		.addr		= 0xe6c50020,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x25,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF1_RX,
 		.addr		= 0xe6c50024,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x26,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
 		.addr		= 0xe6c60020,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x29,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
 		.addr		= 0xe6c60024,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x2a,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF3_TX,
 		.addr		= 0xe6c70020,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x2d,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
 		.addr		= 0xe6c70024,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x2e,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF4_TX,
 		.addr		= 0xe6c80020,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x39,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
 		.addr		= 0xe6c80024,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x3a,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF5_TX,
 		.addr		= 0xe6cb0020,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x35,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF5_RX,
 		.addr		= 0xe6cb0024,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x36,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF6_TX,
 		.addr		= 0xe6c30040,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x3d,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SCIF6_RX,
 		.addr		= 0xe6c30060,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
 		.mid_rid	= 0x3e,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
 		.addr		= 0xe6850030,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
 		.mid_rid	= 0xc1,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
 		.addr		= 0xe6850030,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
 		.mid_rid	= 0xc2,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI1_TX,
 		.addr		= 0xe6860030,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
 		.mid_rid	= 0xc9,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI1_RX,
 		.addr		= 0xe6860030,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
 		.mid_rid	= 0xca,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI2_TX,
 		.addr		= 0xe6870030,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
 		.mid_rid	= 0xcd,
 	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI2_RX,
 		.addr		= 0xe6870030,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
 		.mid_rid	= 0xce,
 	}, {
 		.slave_id	= SHDMA_SLAVE_FSIA_TX,
 		.addr		= 0xfe1f0024,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xb1,
 	}, {
 		.slave_id	= SHDMA_SLAVE_FSIA_RX,
 		.addr		= 0xfe1f0020,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xb2,
 	}, {
 		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
 		.addr		= 0xe6bd0034,
-		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xd1,
 	}, {
 		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
 		.addr		= 0xe6bd0034,
-		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
 		.mid_rid	= 0xd2,
 	},
 };
@@ -520,8 +496,6 @@ static const struct sh_dmae_channel sh7372_dmae_channels[] = {
 	}
 };
 
-static const unsigned int ts_shift[] = TS_SHIFT;
-
 static struct sh_dmae_pdata dma_platform_data = {
 	.slave		= sh7372_dmae_slaves,
 	.slave_num	= ARRAY_SIZE(sh7372_dmae_slaves),
@@ -531,8 +505,8 @@ static struct sh_dmae_pdata dma_platform_data = {
 	.ts_low_mask	= 0x18,
 	.ts_high_shift	= (20 - 2),	/* 2 bits for shifted low TS */
 	.ts_high_mask	= 0x00300000,
-	.ts_shift	= ts_shift,
-	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
 	.dmaor_init	= DMAOR_DME,
 	.chclr_present	= 1,
 };
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 04a0dfe..69d6393 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -30,6 +30,7 @@
 #include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
+#include <mach/dma-register.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
@@ -415,32 +416,6 @@ static struct platform_device i2c4_device = {
 	.num_resources	= ARRAY_SIZE(i2c4_resources),
 };
 
-/* Transmit sizes and respective CHCR register values */
-enum {
-	XMIT_SZ_8BIT		= 0,
-	XMIT_SZ_16BIT		= 1,
-	XMIT_SZ_32BIT		= 2,
-	XMIT_SZ_64BIT		= 7,
-	XMIT_SZ_128BIT		= 3,
-	XMIT_SZ_256BIT		= 4,
-	XMIT_SZ_512BIT		= 5,
-};
-
-/* log2(size / 8) - used to calculate number of transfers */
-#define TS_SHIFT {			\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_64BIT]		= 3,	\
-	[XMIT_SZ_128BIT]	= 4,	\
-	[XMIT_SZ_256BIT]	= 5,	\
-	[XMIT_SZ_512BIT]	= 6,	\
-}
-
-#define TS_INDEX2VAL(i) ((((i) & 3) << 3) | (((i) & 0xc) << (20 - 2)))
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
-
 static const struct sh_dmae_slave_config sh73a0_dmae_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
@@ -604,8 +579,6 @@ static const struct sh_dmae_channel sh73a0_dmae_channels[] = {
 	DMAE_CHANNEL(0x8980),
 };
 
-static const unsigned int ts_shift[] = TS_SHIFT;
-
 static struct sh_dmae_pdata sh73a0_dmae_platform_data = {
 	.slave          = sh73a0_dmae_slaves,
 	.slave_num      = ARRAY_SIZE(sh73a0_dmae_slaves),
@@ -615,8 +588,8 @@ static struct sh_dmae_pdata sh73a0_dmae_platform_data = {
 	.ts_low_mask    = 0x18,
 	.ts_high_shift  = (20 - 2),     /* 2 bits for shifted low TS */
 	.ts_high_mask   = 0x00300000,
-	.ts_shift       = ts_shift,
-	.ts_shift_num   = ARRAY_SIZE(ts_shift),
+	.ts_shift       = dma_ts_shift,
+	.ts_shift_num   = ARRAY_SIZE(dma_ts_shift),
 	.dmaor_init     = DMAOR_DME,
 };
 
-- 
1.7.5.4

