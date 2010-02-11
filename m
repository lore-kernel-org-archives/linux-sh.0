From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Feb 2010 16:50:14 +0000
Subject: [PATCH 3/5 v2] sh: separate DMA headers, used by the legacy and the
Message-Id: <Pine.LNX.4.64.1002111726340.4484@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Separate SH DMA headers into ones, commonly used by both drivers, and ones,
specific to each of them. This will make the future development of the
dmaengine driver easier.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Needs ack(s) from ASoC maintainers - (trivially) touches sound/soc

v1 -> v2:

1. renamed arch/sh/include/asm/dma-common.h to 
   arch/sh/include/asm/dma-register.h
2. proc/cpu-regoster.h are now only used in platform code and in legacy 
   driver - not in shdma.c.
3. shdma.c now uses platform data instead of macros for register layout 
   variants
4. renamed arch/sh/include/asm/sh-dmaengine.h to 
   arch/sh/include/asm/dmaengine.h
5. removed not directly related sound/soc/sh/Kconfig hunk - will be a 
   separate patch

 arch/sh/include/asm/dma-register.h         |   51 ++++++++++++
 arch/sh/include/asm/dma-sh.h               |   95 +----------------------
 arch/sh/include/asm/dmaengine.h            |   73 +++++++++++++++++
 arch/sh/include/asm/siu.h                  |    2 +-
 arch/sh/include/cpu-sh3/cpu/dma-register.h |   41 ++++++++++
 arch/sh/include/cpu-sh3/cpu/dma.h          |   27 -------
 arch/sh/include/cpu-sh4/cpu/dma-register.h |  116 ++++++++++++++++++++++++++++
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h     |   62 ---------------
 arch/sh/include/cpu-sh4/cpu/dma.h          |   36 +--------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c     |   20 ++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c     |   21 +++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c     |   21 +++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c     |   21 +++++-
 drivers/dma/shdma.c                        |   81 ++++++++++++--------
 drivers/dma/shdma.h                        |    4 +-
 sound/soc/sh/siu.h                         |    2 +-
 sound/soc/sh/siu_pcm.c                     |    2 +-
 17 files changed, 416 insertions(+), 259 deletions(-)
 create mode 100644 arch/sh/include/asm/dma-register.h
 create mode 100644 arch/sh/include/asm/dmaengine.h
 create mode 100644 arch/sh/include/cpu-sh3/cpu/dma-register.h
 create mode 100644 arch/sh/include/cpu-sh4/cpu/dma-register.h

diff --git a/arch/sh/include/asm/dma-register.h b/arch/sh/include/asm/dma-register.h
new file mode 100644
index 0000000..51cd78f
--- /dev/null
+++ b/arch/sh/include/asm/dma-register.h
@@ -0,0 +1,51 @@
+/*
+ * Common header for the legacy SH DMA driver and the new dmaengine driver
+ *
+ * extracted from arch/sh/include/asm/dma-sh.h:
+ *
+ * Copyright (C) 2000  Takashi YOSHII
+ * Copyright (C) 2003  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef DMA_REGISTER_H
+#define DMA_REGISTER_H
+
+/* DMA register */
+#define SAR	0x00
+#define DAR	0x04
+#define TCR	0x08
+#define CHCR	0x0C
+#define DMAOR	0x40
+
+/* DMAOR definitions */
+#define DMAOR_AE	0x00000004
+#define DMAOR_NMIF	0x00000002
+#define DMAOR_DME	0x00000001
+
+/* Definitions for the SuperH DMAC */
+#define REQ_L	0x00000000
+#define REQ_E	0x00080000
+#define RACK_H	0x00000000
+#define RACK_L	0x00040000
+#define ACK_R	0x00000000
+#define ACK_W	0x00020000
+#define ACK_H	0x00000000
+#define ACK_L	0x00010000
+#define DM_INC	0x00004000
+#define DM_DEC	0x00008000
+#define DM_FIX	0x0000c000
+#define SM_INC	0x00001000
+#define SM_DEC	0x00002000
+#define SM_FIX	0x00003000
+#define RS_IN	0x00000200
+#define RS_OUT	0x00000300
+#define TS_BLK	0x00000040
+#define TM_BUR	0x00000020
+#define CHCR_DE	0x00000001
+#define CHCR_TE	0x00000002
+#define CHCR_IE	0x00000004
+
+#endif
diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index 2e3631d..f3acb8e 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -11,7 +11,8 @@
 #ifndef __DMA_SH_H
 #define __DMA_SH_H
 
-#include <asm/dma.h>
+#include <asm/dma-register.h>
+#include <cpu/dma-register.h>
 #include <cpu/dma.h>
 
 /* DMAOR contorl: The DMAOR access size is different by CPU.*/
@@ -53,34 +54,6 @@ static int dmte_irq_map[] __maybe_unused = {
 #endif
 };
 
-/* Definitions for the SuperH DMAC */
-#define REQ_L	0x00000000
-#define REQ_E	0x00080000
-#define RACK_H	0x00000000
-#define RACK_L	0x00040000
-#define ACK_R	0x00000000
-#define ACK_W	0x00020000
-#define ACK_H	0x00000000
-#define ACK_L	0x00010000
-#define DM_INC	0x00004000
-#define DM_DEC	0x00008000
-#define DM_FIX	0x0000c000
-#define SM_INC	0x00001000
-#define SM_DEC	0x00002000
-#define SM_FIX	0x00003000
-#define RS_IN	0x00000200
-#define RS_OUT	0x00000300
-#define TS_BLK	0x00000040
-#define TM_BUR	0x00000020
-#define CHCR_DE 0x00000001
-#define CHCR_TE 0x00000002
-#define CHCR_IE 0x00000004
-
-/* DMAOR definitions */
-#define DMAOR_AE	0x00000004
-#define DMAOR_NMIF	0x00000002
-#define DMAOR_DME	0x00000001
-
 /*
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
@@ -111,68 +84,4 @@ static u32 dma_base_addr[] __maybe_unused = {
 #endif
 };
 
-/* DMA register */
-#define SAR     0x00
-#define DAR     0x04
-#define TCR     0x08
-#define CHCR    0x0C
-#define DMAOR	0x40
-
-/*
- * for dma engine
- *
- * SuperH DMA mode
- */
-#define SHDMA_MIX_IRQ	(1 << 1)
-#define SHDMA_DMAOR1	(1 << 2)
-#define SHDMA_DMAE1	(1 << 3)
-
-enum sh_dmae_slave_chan_id {
-	SHDMA_SLAVE_SCIF0_TX,
-	SHDMA_SLAVE_SCIF0_RX,
-	SHDMA_SLAVE_SCIF1_TX,
-	SHDMA_SLAVE_SCIF1_RX,
-	SHDMA_SLAVE_SCIF2_TX,
-	SHDMA_SLAVE_SCIF2_RX,
-	SHDMA_SLAVE_SCIF3_TX,
-	SHDMA_SLAVE_SCIF3_RX,
-	SHDMA_SLAVE_SCIF4_TX,
-	SHDMA_SLAVE_SCIF4_RX,
-	SHDMA_SLAVE_SCIF5_TX,
-	SHDMA_SLAVE_SCIF5_RX,
-	SHDMA_SLAVE_SIUA_TX,
-	SHDMA_SLAVE_SIUA_RX,
-	SHDMA_SLAVE_SIUB_TX,
-	SHDMA_SLAVE_SIUB_RX,
-	SHDMA_SLAVE_NUMBER,	/* Must stay last */
-};
-
-struct sh_dmae_slave_config {
-	enum sh_dmae_slave_chan_id	slave_id;
-	dma_addr_t			addr;
-	u32				chcr;
-	char				mid_rid;
-};
-
-struct sh_dmae_channel {
-	unsigned int	offset;
-	unsigned int	dmars;
-	unsigned int	dmars_bit;
-};
-
-struct sh_dmae_pdata {
-	struct sh_dmae_slave_config *slave;
-	int slave_num;
-	struct sh_dmae_channel *channel;
-	int channel_num;
-};
-
-struct device;
-
-struct sh_dmae_slave {
-	enum sh_dmae_slave_chan_id	slave_id; /* Set by the platform */
-	struct device			*dma_dev; /* Set by the platform */
-	struct sh_dmae_slave_config	*config;  /* Set by the driver */
-};
-
 #endif /* __DMA_SH_H */
diff --git a/arch/sh/include/asm/dmaengine.h b/arch/sh/include/asm/dmaengine.h
new file mode 100644
index 0000000..9586e4a
--- /dev/null
+++ b/arch/sh/include/asm/dmaengine.h
@@ -0,0 +1,73 @@
+/*
+ * Header for the new SH dmaengine driver
+ *
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASM_DMAENGINE_H
+#define ASM_DMAENGINE_H
+
+#include <asm/dma-register.h>
+
+#define SH_DMAC_MAX_CHANNELS	6
+
+enum sh_dmae_slave_chan_id {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SIUA_TX,
+	SHDMA_SLAVE_SIUA_RX,
+	SHDMA_SLAVE_SIUB_TX,
+	SHDMA_SLAVE_SIUB_RX,
+	SHDMA_SLAVE_NUMBER,	/* Must stay last */
+};
+
+struct sh_dmae_slave_config {
+	enum sh_dmae_slave_chan_id	slave_id;
+	dma_addr_t			addr;
+	u32				chcr;
+	char				mid_rid;
+};
+
+struct sh_dmae_channel {
+	unsigned int	offset;
+	unsigned int	dmars;
+	unsigned int	dmars_bit;
+};
+
+struct sh_dmae_pdata {
+	struct sh_dmae_slave_config *slave;
+	int slave_num;
+	struct sh_dmae_channel *channel;
+	int channel_num;
+	unsigned int ts_low_shift;
+	unsigned int ts_low_mask;
+	unsigned int ts_high_shift;
+	unsigned int ts_high_mask;
+	unsigned int *ts_shift;
+	int ts_shift_num;
+	u16 dmaor_init;
+};
+
+struct device;
+
+/* Used by slave DMA clients to request DMA to/from a specific peripheral */
+struct sh_dmae_slave {
+	enum sh_dmae_slave_chan_id	slave_id; /* Set by the platform */
+	struct device			*dma_dev; /* Set by the platform */
+	struct sh_dmae_slave_config	*config;  /* Set by the driver */
+};
+
+#endif
diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index 57565a3..f1b1e69 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -11,7 +11,7 @@
 #ifndef ASM_SIU_H
 #define ASM_SIU_H
 
-#include <asm/dma-sh.h>
+#include <asm/dmaengine.h>
 
 struct device;
 
diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
new file mode 100644
index 0000000..2349e48
--- /dev/null
+++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
@@ -0,0 +1,41 @@
+/*
+ * SH3 CPU-specific DMA definitions, used by both DMA drivers
+ *
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef CPU_DMA_REGISTER_H
+#define CPU_DMA_REGISTER_H
+
+#define CHCR_TS_LOW_MASK	0x18
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+
+#define DMAOR_INIT	DMAOR_DME
+
+/*
+ * The SuperH DMAC supports a number of transmit sizes, we list them here,
+ * with their respective values as they appear in the CHCR registers.
+ */
+enum {
+	XMIT_SZ_8BIT,
+	XMIT_SZ_16BIT,
+	XMIT_SZ_32BIT,
+	XMIT_SZ_128BIT,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+}
+
+#define TS_INDEX2VAL(i)	(((i) & 3) << CHCR_TS_LOW_SHIFT)
+
+#endif
diff --git a/arch/sh/include/cpu-sh3/cpu/dma.h b/arch/sh/include/cpu-sh3/cpu/dma.h
index 207811a..24e28b9 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma.h
@@ -20,31 +20,4 @@
 #define TS_32		0x00000010
 #define TS_128		0x00000018
 
-#define CHCR_TS_LOW_MASK	0x18
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
-
-#define DMAOR_INIT	DMAOR_DME
-
-/*
- * The SuperH DMAC supports a number of transmit sizes, we list them here,
- * with their respective values as they appear in the CHCR registers.
- */
-enum {
-	XMIT_SZ_8BIT,
-	XMIT_SZ_16BIT,
-	XMIT_SZ_32BIT,
-	XMIT_SZ_128BIT,
-};
-
-#define TS_SHIFT {			\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_128BIT]	= 4,	\
-}
-
-#define TS_INDEX2VAL(i)	(((i) & 3) << CHCR_TS_LOW_SHIFT)
-
 #endif /* __ASM_CPU_SH3_DMA_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
new file mode 100644
index 0000000..008e7fc
--- /dev/null
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -0,0 +1,116 @@
+/*
+ * SH4 CPU-specific DMA definitions, used by both DMA drivers
+ *
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef CPU_DMA_REGISTER_H
+#define CPU_DMA_REGISTER_H
+
+/* SH7751/7760/7780 DMA IRQ sources */
+
+#ifdef CONFIG_CPU_SH4A
+
+#define DMAOR_INIT	DMAOR_DME
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7343) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7730)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7722)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0x00300000
+#define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7764)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0x00600000
+#define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#else /* SH7785 */
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#endif
+
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_128BIT_BLK	= 0xb,
+	XMIT_SZ_256BIT_BLK	= 0xc,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+	[XMIT_SZ_128BIT_BLK]	= 4,	\
+	[XMIT_SZ_256BIT_BLK]	= 5,	\
+}
+
+#define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
+			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
+
+#else /* CONFIG_CPU_SH4A */
+
+#define DMAOR_INIT	(0x8000 | DMAOR_DME)
+
+#define CHCR_TS_LOW_MASK	0x70
+#define CHCR_TS_LOW_SHIFT	4
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT	= 1,
+	XMIT_SZ_16BIT	= 2,
+	XMIT_SZ_32BIT	= 3,
+	XMIT_SZ_64BIT	= 0,
+	XMIT_SZ_256BIT	= 4,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+}
+
+#define TS_INDEX2VAL(i)	(((i) & 7) << CHCR_TS_LOW_SHIFT)
+
+#endif /* CONFIG_CPU_SH4A */
+
+#endif
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
index e734ea4..9647e68 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -8,20 +8,12 @@
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMARS_BASE0	0xFE009000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7722)
 #define DMTE0_IRQ	48
 #define DMTE4_IRQ	76
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMARS_BASE0	0xFE009000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0x00300000
-#define CHCR_TS_HIGH_SHIFT	20
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7764)
 #define DMTE0_IRQ	34
@@ -29,10 +21,6 @@
 #define DMAE0_IRQ	38
 #define SH_DMAC_BASE0	0xFF608020
 #define SH_DMARS_BASE0	0xFF609000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723)
 #define DMTE0_IRQ	48	/* DMAC0A*/
 #define DMTE4_IRQ	76	/* DMAC0B */
@@ -46,10 +34,6 @@
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMAC_BASE1	0xFDC08020
 #define SH_DMARS_BASE0	0xFDC09000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #elif defined(CONFIG_CPU_SUBTYPE_SH7724)
 #define DMTE0_IRQ	48	/* DMAC0A*/
 #define DMTE4_IRQ	76	/* DMAC0B */
@@ -64,10 +48,6 @@
 #define SH_DMAC_BASE1	0xFDC08020
 #define SH_DMARS_BASE0	0xFE009000
 #define SH_DMARS_BASE1	0xFDC09000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0x00600000
-#define CHCR_TS_HIGH_SHIFT	21
 #elif defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define DMTE0_IRQ	34
 #define DMTE4_IRQ	44
@@ -80,10 +60,6 @@
 #define SH_DMAC_BASE0	0xFC808020
 #define SH_DMAC_BASE1	0xFC818020
 #define SH_DMARS_BASE0	0xFC809000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #else /* SH7785 */
 #define DMTE0_IRQ	33
 #define DMTE4_IRQ	37
@@ -97,10 +73,6 @@
 #define SH_DMAC_BASE0	0xFC808020
 #define SH_DMAC_BASE1	0xFCC08020
 #define SH_DMARS_BASE0	0xFC809000
-#define CHCR_TS_LOW_MASK	0x00000018
-#define CHCR_TS_LOW_SHIFT	3
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
 #endif
 
 #define REQ_HE		0x000000C0
@@ -108,38 +80,4 @@
 #define REQ_LE		0x00000040
 #define TM_BURST	0x00000020
 
-/*
- * The SuperH DMAC supports a number of transmit sizes, we list them here,
- * with their respective values as they appear in the CHCR registers.
- *
- * Defaults to a 64-bit transfer size.
- */
-enum {
-	XMIT_SZ_8BIT		= 0,
-	XMIT_SZ_16BIT		= 1,
-	XMIT_SZ_32BIT		= 2,
-	XMIT_SZ_64BIT		= 7,
-	XMIT_SZ_128BIT		= 3,
-	XMIT_SZ_256BIT		= 4,
-	XMIT_SZ_128BIT_BLK	= 0xb,
-	XMIT_SZ_256BIT_BLK	= 0xc,
-};
-
-/*
- * The DMA count is defined as the number of bytes to transfer.
- */
-#define TS_SHIFT {			\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_64BIT]		= 3,	\
-	[XMIT_SZ_128BIT]	= 4,	\
-	[XMIT_SZ_256BIT]	= 5,	\
-	[XMIT_SZ_128BIT_BLK]	= 4,	\
-	[XMIT_SZ_256BIT_BLK]	= 5,	\
-}
-
-#define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
-			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
-
 #endif /* __ASM_SH_CPU_SH4_DMA_SH7780_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma.h b/arch/sh/include/cpu-sh4/cpu/dma.h
index 114a369..ca747e9 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma.h
@@ -5,9 +5,8 @@
 
 #ifdef CONFIG_CPU_SH4A
 
-#define DMAOR_INIT	(DMAOR_DME)
-
 #include <cpu/dma-sh4a.h>
+
 #else /* CONFIG_CPU_SH4A */
 /*
  * SH7750/SH7751/SH7760
@@ -17,7 +16,6 @@
 #define DMTE6_IRQ	46
 #define DMAE0_IRQ	38
 
-#define DMAOR_INIT	(0x8000|DMAOR_DME)
 #define SH_DMAC_BASE0	0xffa00000
 #define SH_DMAC_BASE1	0xffa00070
 /* Definitions for the SuperH DMAC */
@@ -27,40 +25,8 @@
 #define TS_32		0x00000030
 #define TS_64		0x00000000
 
-#define CHCR_TS_LOW_MASK	0x70
-#define CHCR_TS_LOW_SHIFT	4
-#define CHCR_TS_HIGH_MASK	0
-#define CHCR_TS_HIGH_SHIFT	0
-
 #define DMAOR_COD	0x00000008
 
-/*
- * The SuperH DMAC supports a number of transmit sizes, we list them here,
- * with their respective values as they appear in the CHCR registers.
- *
- * Defaults to a 64-bit transfer size.
- */
-enum {
-	XMIT_SZ_8BIT	= 1,
-	XMIT_SZ_16BIT	= 2,
-	XMIT_SZ_32BIT	= 3,
-	XMIT_SZ_64BIT	= 0,
-	XMIT_SZ_256BIT	= 4,
-};
-
-/*
- * The DMA count is defined as the number of bytes to transfer.
- */
-#define TS_SHIFT {			\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_64BIT]		= 3,	\
-	[XMIT_SZ_256BIT]	= 5,	\
-}
-
-#define TS_INDEX2VAL(i)	(((i) & 7) << CHCR_TS_LOW_SHIFT)
-
 #endif
 
 #endif /* __ASM_CPU_SH4_DMA_H */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 5dcd0de..3ce06c3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -7,18 +7,21 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-#include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
-#include <linux/mm.h>
+#include <linux/sh_timer.h>
 #include <linux/uio_driver.h>
 #include <linux/usb/m66592.h>
-#include <linux/sh_timer.h>
+
 #include <asm/clock.h>
+#include <asm/dmaengine.h>
 #include <asm/mmzone.h>
-#include <asm/dma-sh.h>
 #include <asm/siu.h>
+
+#include <cpu/dma-register.h>
 #include <cpu/sh7722.h>
 
 static struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
@@ -103,11 +106,20 @@ static struct sh_dmae_channel sh7722_dmae_channels[] = {
 	}
 };
 
+static unsigned int ts_shift[] = TS_SHIFT;
+
 static struct sh_dmae_pdata dma_platform_data = {
 	.slave		= sh7722_dmae_slaves,
 	.slave_num	= ARRAY_SIZE(sh7722_dmae_slaves),
 	.channel	= sh7722_dmae_channels,
 	.channel_num	= ARRAY_SIZE(sh7722_dmae_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 static struct resource sh7722_dmae_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index f001fc4..cf829bf 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -21,10 +21,13 @@
 #include <linux/sh_timer.h>
 #include <linux/io.h>
 #include <linux/notifier.h>
+
 #include <asm/suspend.h>
 #include <asm/clock.h>
-#include <asm/dma-sh.h>
+#include <asm/dmaengine.h>
 #include <asm/mmzone.h>
+
+#include <cpu/dma-register.h>
 #include <cpu/sh7724.h>
 
 /* DMA */
@@ -84,14 +87,30 @@ static struct sh_dmae_channel sh7724_dmae1_channels[] = {
 	}
 };
 
+static unsigned int ts_shift[] = TS_SHIFT;
+
 static struct sh_dmae_pdata dma0_platform_data = {
 	.channel	= sh7724_dmae0_channels,
 	.channel_num	= ARRAY_SIZE(sh7724_dmae0_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 static struct sh_dmae_pdata dma1_platform_data = {
 	.channel	= sh7724_dmae1_channels,
 	.channel_num	= ARRAY_SIZE(sh7724_dmae1_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 /* Resource order important! */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 338dfc2..02e792c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -13,7 +13,10 @@
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
-#include <asm/dma-sh.h>
+
+#include <asm/dmaengine.h>
+
+#include <cpu/dma-register.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
@@ -292,14 +295,30 @@ static struct sh_dmae_channel sh7780_dmae1_channels[] = {
 	}
 };
 
+static unsigned int ts_shift[] = TS_SHIFT;
+
 static struct sh_dmae_pdata dma0_platform_data = {
 	.channel	= sh7780_dmae0_channels,
 	.channel_num	= ARRAY_SIZE(sh7780_dmae0_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 static struct sh_dmae_pdata dma1_platform_data = {
 	.channel	= sh7780_dmae1_channels,
 	.channel_num	= ARRAY_SIZE(sh7780_dmae1_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 static struct resource sh7780_dmae0_resources[] = {
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index fbb5d1f..1fcd88b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -14,9 +14,12 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
-#include <asm/dma-sh.h>
+
+#include <asm/dmaengine.h>
 #include <asm/mmzone.h>
 
+#include <cpu/dma-register.h>
+
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffea0000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -340,14 +343,30 @@ static struct sh_dmae_channel sh7785_dmae1_channels[] = {
 	}
 };
 
+static unsigned int ts_shift[] = TS_SHIFT;
+
 static struct sh_dmae_pdata dma0_platform_data = {
 	.channel	= sh7785_dmae0_channels,
 	.channel_num	= ARRAY_SIZE(sh7785_dmae0_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 static struct sh_dmae_pdata dma1_platform_data = {
 	.channel	= sh7785_dmae1_channels,
 	.channel_num	= ARRAY_SIZE(sh7785_dmae1_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
 };
 
 static struct resource sh7785_dmae0_resources[] = {
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index bf70132..b419afa 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -24,8 +24,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <cpu/dma.h>
-#include <asm/dma-sh.h>
+#include <asm/dmaengine.h>
 #include "shdma.h"
 
 /* DMA descriptor control */
@@ -38,15 +37,8 @@ enum sh_dmae_desc_status {
 };
 
 #define NR_DESCS_PER_CHANNEL 32
-/*
- * Define the default configuration for dual address memory-memory transfer.
- * The 0x400 value represents auto-request, external->external.
- *
- * And this driver set 4byte burst mode.
- * If you want to change mode, you need to change RS_DEFAULT of value.
- * (ex 1byte burst mode -> (RS_DUAL & ~TS_32)
- */
-#define RS_DEFAULT  (RS_DUAL)
+/* Default MEMCPY transfer size = 2^2 = 4 bytes */
+#define LOG2_DEFAULT_XFER_SIZE	2
 
 /* A bitmask with bits enough for enum sh_dmae_slave_chan_id */
 static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SHDMA_SLAVE_NUMBER)];
@@ -90,7 +82,7 @@ static int sh_dmae_rst(struct sh_dmae_device *shdev)
 	unsigned short dmaor;
 
 	sh_dmae_ctl_stop(shdev);
-	dmaor = dmaor_read(shdev) | DMAOR_INIT;
+	dmaor = dmaor_read(shdev) | shdev->pdata->dmaor_init;
 
 	dmaor_write(shdev, dmaor);
 	if (dmaor_read(shdev) & (DMAOR_AE | DMAOR_NMIF)) {
@@ -110,13 +102,36 @@ static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 	return false; /* waiting */
 }
 
-static unsigned int ts_shift[] = TS_SHIFT;
-static inline unsigned int calc_xmit_shift(u32 chcr)
+static unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan, u32 chcr)
 {
-	int cnt = ((chcr & CHCR_TS_LOW_MASK) >> CHCR_TS_LOW_SHIFT) |
-		((chcr & CHCR_TS_HIGH_MASK) >> CHCR_TS_HIGH_SHIFT);
+	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
+						struct sh_dmae_device, common);
+	struct sh_dmae_pdata *pdata = shdev->pdata;
+	int cnt = ((chcr & pdata->ts_low_mask) >> pdata->ts_low_shift) |
+		((chcr & pdata->ts_high_mask) >> pdata->ts_high_shift);
+
+	if (cnt >= pdata->ts_shift_num)
+		cnt = 0;
 
-	return ts_shift[cnt];
+	return pdata->ts_shift[cnt];
+}
+
+static u32 log2size_to_chcr(struct sh_dmae_chan *sh_chan, int l2size)
+{
+	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
+						struct sh_dmae_device, common);
+	struct sh_dmae_pdata *pdata = shdev->pdata;
+	int i;
+
+	for (i = 0; i < pdata->ts_shift_num; i++)
+		if (pdata->ts_shift[i] = l2size)
+			break;
+
+	if (i = pdata->ts_shift_num)
+		i = 0;
+
+	return ((i << pdata->ts_low_shift) & pdata->ts_low_mask) |
+		((i << pdata->ts_high_shift) & pdata->ts_high_mask);
 }
 
 static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
@@ -144,8 +159,13 @@ static void dmae_halt(struct sh_dmae_chan *sh_chan)
 
 static void dmae_init(struct sh_dmae_chan *sh_chan)
 {
-	u32 chcr = RS_DEFAULT; /* default is DUAL mode */
-	sh_chan->xmit_shift = calc_xmit_shift(chcr);
+	/*
+	 * Default configuration for dual address memory-memory transfer.
+	 * 0x400 represents auto-request.
+	 */
+	u32 chcr = DM_INC | SM_INC | 0x400 | log2size_to_chcr(sh_chan,
+						   LOG2_DEFAULT_XFER_SIZE);
+	sh_chan->xmit_shift = calc_xmit_shift(sh_chan, chcr);
 	sh_dmae_writel(sh_chan, chcr, CHCR);
 }
 
@@ -155,7 +175,7 @@ static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
-	sh_chan->xmit_shift = calc_xmit_shift(val);
+	sh_chan->xmit_shift = calc_xmit_shift(sh_chan, val);
 	sh_dmae_writel(sh_chan, val, CHCR);
 
 	return 0;
@@ -285,9 +305,8 @@ static int sh_dmae_alloc_chan_resources(struct dma_chan *chan)
 
 		dmae_set_dmars(sh_chan, cfg->mid_rid);
 		dmae_set_chcr(sh_chan, cfg->chcr);
-	} else {
-		if ((sh_dmae_readl(sh_chan, CHCR) & 0x700) != 0x400)
-			dmae_set_chcr(sh_chan, RS_DEFAULT);
+	} else if ((sh_dmae_readl(sh_chan, CHCR) & 0xf00) != 0x400) {
+		dmae_init(sh_chan);
 	}
 
 	spin_lock_bh(&sh_chan->desc_lock);
@@ -757,7 +776,7 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 	sh_dmae_ctl_stop(shdev);
 
 	/* We cannot detect, which channel caused the error, have to reset all */
-	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
+	for (i = 0; i < SH_DMAC_MAX_CHANNELS; i++) {
 		struct sh_dmae_chan *sh_chan = shdev->chan[i];
 		if (sh_chan) {
 			struct sh_desc *desc;
@@ -822,6 +841,9 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 		return -ENOMEM;
 	}
 
+	/* copy struct dma_device */
+	new_sh_chan->common.device = &shdev->common;
+
 	new_sh_chan->dev = shdev->common.dev;
 	new_sh_chan->id = id;
 	new_sh_chan->irq = irq;
@@ -840,9 +862,6 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 	INIT_LIST_HEAD(&new_sh_chan->ld_queue);
 	INIT_LIST_HEAD(&new_sh_chan->ld_free);
 
-	/* copy struct dma_device */
-	new_sh_chan->common.device = &shdev->common;
-
 	/* Add the channel to DMA device channel list */
 	list_add_tail(&new_sh_chan->common.device_node,
 			&shdev->common.channels);
@@ -896,8 +915,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 {
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
-		chan_flag[MAX_DMA_CHANNELS] = {};
-	int errirq, chan_irq[MAX_DMA_CHANNELS];
+		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
+	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
 	int err, i, irq_cnt = 0, irqres = 0;
 	struct sh_dmae_device *shdev;
 	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
@@ -983,7 +1002,7 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 
 	shdev->common.dev = &pdev->dev;
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
-	shdev->common.copy_align = 5;
+	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;
 
 #if defined(CONFIG_CPU_SH4)
 	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 800fd88..9f0897f 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 
+#include <asm/dmaengine.h>
+
 #define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
 
 struct sh_dmae_regs {
@@ -55,7 +57,7 @@ struct sh_dmae_chan {
 
 struct sh_dmae_device {
 	struct dma_device common;
-	struct sh_dmae_chan *chan[MAX_DMA_CHANNELS];
+	struct sh_dmae_chan *chan[SH_DMAC_MAX_CHANNELS];
 	struct sh_dmae_pdata *pdata;
 	u32 __iomem *chan_reg;
 	u16 __iomem *dmars;
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 9cc04ab..c0bfab8 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -72,7 +72,7 @@ struct siu_firmware {
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
-#include <asm/dma-sh.h>
+#include <asm/dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index c5efc30..ba7f8d0 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -32,7 +32,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-dai.h>
 
-#include <asm/dma-sh.h>
+#include <asm/dmaengine.h>
 #include <asm/siu.h>
 
 #include "siu.h"
-- 
1.6.2.4

