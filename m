From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 15:03:50 +0000
Subject: [PATCH 2/4] sh: separate DMA headers, used by the legacy and the
Message-Id: <Pine.LNX.4.64.1002031559050.6324@axis700.grange>
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
 arch/sh/include/asm/dma-common.h           |   53 +++++++++++++
 arch/sh/include/asm/dma-sh.h               |   97 +-----------------------
 arch/sh/include/asm/sh-dmaengine.h         |   71 +++++++++++++++++
 arch/sh/include/asm/siu.h                  |    2 +-
 arch/sh/include/cpu-sh3/cpu/dma-register.h |   40 ++++++++++
 arch/sh/include/cpu-sh3/cpu/dma.h          |   27 -------
 arch/sh/include/cpu-sh4/cpu/dma-register.h |  116 ++++++++++++++++++++++++++++
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h     |   62 ---------------
 arch/sh/include/cpu-sh4/cpu/dma.h          |   36 +--------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c     |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c     |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c     |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c     |    2 +-
 drivers/dma/shdma.c                        |    5 +-
 drivers/dma/shdma.h                        |    4 +-
 sound/soc/sh/Kconfig                       |    4 +
 sound/soc/sh/siu.h                         |    2 +-
 sound/soc/sh/siu_pcm.c                     |    2 +-
 18 files changed, 298 insertions(+), 231 deletions(-)
 create mode 100644 arch/sh/include/asm/dma-common.h
 create mode 100644 arch/sh/include/asm/sh-dmaengine.h
 create mode 100644 arch/sh/include/cpu-sh3/cpu/dma-register.h
 create mode 100644 arch/sh/include/cpu-sh4/cpu/dma-register.h

diff --git a/arch/sh/include/asm/dma-common.h b/arch/sh/include/asm/dma-common.h
new file mode 100644
index 0000000..a3456f4
--- /dev/null
+++ b/arch/sh/include/asm/dma-common.h
@@ -0,0 +1,53 @@
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
+#ifndef __DMA_COMMON_H
+#define __DMA_COMMON_H
+
+/* DMA register */
+#define SAR     0x00
+#define DAR     0x04
+#define TCR     0x08
+#define CHCR    0x0C
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
+#define CHCR_DE 0x00000001
+#define CHCR_TE 0x00000002
+#define CHCR_IE 0x00000004
+
+#include <cpu/dma-register.h>
+
+#endif
diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index 238df83..675a9d5 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -11,7 +11,7 @@
 #ifndef __DMA_SH_H
 #define __DMA_SH_H
 
-#include <asm/dma.h>
+#include <asm/dma-common.h>
 #include <cpu/dma.h>
 
 /* DMAOR contorl: The DMAOR access size is different by CPU.*/
@@ -53,34 +53,6 @@ static int dmte_irq_map[] __maybe_unused = {
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
@@ -111,71 +83,4 @@ static u32 dma_base_addr[] __maybe_unused = {
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
-	int		irq;
-	unsigned int	dmars;
-	unsigned int	dmars_bit;
-};
-
-struct sh_dmae_pdata {
-	unsigned int mode;
-	struct sh_dmae_slave_config *slave;
-	int slave_num;
-	struct sh_dmae_channel *channel;
-	int channel_num;
-	unsigned int dmaor_offset;
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
diff --git a/arch/sh/include/asm/sh-dmaengine.h b/arch/sh/include/asm/sh-dmaengine.h
new file mode 100644
index 0000000..e127ce5
--- /dev/null
+++ b/arch/sh/include/asm/sh-dmaengine.h
@@ -0,0 +1,71 @@
+/*
+ * Header for the new SH dmaengine driver
+ *
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef SH_DMAENGINE_H
+#define SH_DMAENGINE_H
+
+#include <asm/dma-common.h>
+
+#define SH_DMAC_MAX_CHANNELS	6
+
+/* SuperH DMA mode */
+#define SHDMA_MIX_IRQ	(1 << 0)
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
+	int		irq;
+	unsigned int	dmars;
+	unsigned int	dmars_bit;
+};
+
+struct sh_dmae_pdata {
+	unsigned int mode;
+	struct sh_dmae_slave_config *slave;
+	int slave_num;
+	struct sh_dmae_channel *channel;
+	int channel_num;
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
index 57565a3..1a384aa 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -11,7 +11,7 @@
 #ifndef ASM_SIU_H
 #define ASM_SIU_H
 
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 
 struct device;
 
diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
new file mode 100644
index 0000000..ed9c469
--- /dev/null
+++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
@@ -0,0 +1,40 @@
+/*
+ * SH3 CPU-specific DMA definitions, used by both DMA drivers
+ *
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef DMA_REGISTER_H
+#define DMA_REGISTER_H
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
index 0000000..a065a2d
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
+#ifndef DMA_REGISTER_H
+#define DMA_REGISTER_H
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
+#define CHCR_TS_HIGH_SHIFT	20
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
+#define CHCR_TS_HIGH_SHIFT	21
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
index c1335e5..5d7dc19 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -17,7 +17,7 @@
 #include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 #include <asm/siu.h>
 #include <cpu/sh7722.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 460d147..b692e61 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -23,7 +23,7 @@
 #include <linux/notifier.h>
 #include <asm/suspend.h>
 #include <asm/clock.h>
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 #include <asm/mmzone.h>
 #include <cpu/sh7724.h>
 
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 851de27..99c6b77 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index e3abc2d..ad55a6c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -14,7 +14,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 #include <asm/mmzone.h>
 
 static struct plat_sci_port scif0_platform_data = {
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 7242776..3498cab 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -24,8 +24,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
-#include <cpu/dma.h>
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 #include "shdma.h"
 
 /* DMA descriptor control */
@@ -46,7 +45,7 @@ enum sh_dmae_desc_status {
  * If you want to change mode, you need to change RS_DEFAULT of value.
  * (ex 1byte burst mode -> (RS_DUAL & ~TS_32)
  */
-#define RS_DEFAULT  (RS_DUAL)
+#define RS_DEFAULT  (DM_INC | SM_INC | 0x400 | TS_INDEX2VAL(XMIT_SZ_32BIT))
 
 /* A bitmask with bits enough for enum sh_dmae_slave_chan_id */
 static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SHDMA_SLAVE_NUMBER)];
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index a99c385..d910398 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -17,6 +17,8 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 
+#include <asm/sh-dmaengine.h>
+
 #define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
 
 struct sh_dmae_regs {
@@ -54,7 +56,7 @@ struct sh_dmae_chan {
 
 struct sh_dmae_device {
 	struct dma_device common;
-	struct sh_dmae_chan *chan[MAX_DMA_CHANNELS];
+	struct sh_dmae_chan *chan[SH_DMAC_MAX_CHANNELS];
 	struct sh_dmae_pdata *pdata;
 	u32 __iomem *chan_reg;
 	u16 __iomem *dmars;
diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index a86696b..73aba28 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -26,9 +26,13 @@ config SND_SOC_SH4_FSI
 	help
 	  This option enables FSI sound support
 
+# for some reason "depends on !SH_DMA_API" doesn't work. So, have to
+# "select DMA_ENGINE", then drivers can also be built with SH_DMA_API enabled,
+# but, certainly, cannot be used.
 config SND_SOC_SH4_SIU
 	tristate
 	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	select DMA_ENGINE
 	select DMADEVICES
 	select SH_DMAE
 
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 9cc04ab..fc9a03f 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -72,7 +72,7 @@ struct siu_firmware {
 #include <linux/interrupt.h>
 #include <linux/io.h>
 
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index c5efc30..c307bb9 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -32,7 +32,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc-dai.h>
 
-#include <asm/dma-sh.h>
+#include <asm/sh-dmaengine.h>
 #include <asm/siu.h>
 
 #include "siu.h"
-- 
1.6.2.4

