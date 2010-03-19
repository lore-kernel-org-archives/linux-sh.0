From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:47:10 +0000
Subject: [PATCH 04/05] dmaengine: shdma: Introduce include/linux/sh_dma.h
Message-Id: <20100319044710.17051.98259.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Create a common platform data header file for the
shdma dmaengine driver. This is done by moving
common structures from sh asm/dmaengine.h to
linux/sh_dma.h. DMA registers are also copied from
sh asm/dma-register.h to make the code architecture
independent.

The sh header file asm/dmaengine.h is still kept
with the slave id enum. This allows us to keep the
old processor specific code as is and slowly move
over to slave id enums in per-processor headers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/dmaengine.h |   60 -----------------------
 drivers/dma/shdma.c             |    3 -
 drivers/dma/shdma.h             |    3 -
 include/linux/sh_dma.h          |  101 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+), 63 deletions(-)

--- 0004/arch/sh/include/asm/dmaengine.h
+++ work/arch/sh/include/asm/dmaengine.h	2010-03-18 23:25:04.000000000 +0900
@@ -10,12 +10,7 @@
 #ifndef ASM_DMAENGINE_H
 #define ASM_DMAENGINE_H
 
-#include <linux/dmaengine.h>
-#include <linux/list.h>
-
-#include <asm/dma-register.h>
-
-#define SH_DMAC_MAX_CHANNELS	6
+#include <linux/sh_dma.h>
 
 enum {
 	SHDMA_SLAVE_SCIF0_TX,
@@ -36,57 +31,4 @@ enum {
 	SHDMA_SLAVE_SIUB_RX,
 };
 
-struct sh_dmae_slave_config {
-	unsigned int			slave_id;
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
-	unsigned int ts_low_shift;
-	unsigned int ts_low_mask;
-	unsigned int ts_high_shift;
-	unsigned int ts_high_mask;
-	unsigned int *ts_shift;
-	int ts_shift_num;
-	u16 dmaor_init;
-};
-
-struct device;
-
-/* Used by slave DMA clients to request DMA to/from a specific peripheral */
-struct sh_dmae_slave {
-	unsigned int			slave_id; /* Set by the platform */
-	struct device			*dma_dev; /* Set by the platform */
-	struct sh_dmae_slave_config	*config;  /* Set by the driver */
-};
-
-struct sh_dmae_regs {
-	u32 sar; /* SAR / source address */
-	u32 dar; /* DAR / destination address */
-	u32 tcr; /* TCR / transfer count */
-};
-
-struct sh_desc {
-	struct sh_dmae_regs hw;
-	struct list_head node;
-	struct dma_async_tx_descriptor async_tx;
-	enum dma_data_direction direction;
-	dma_cookie_t cookie;
-	size_t partial;
-	int chunks;
-	int mark;
-};
-
 #endif
--- 0004/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2010-03-18 23:25:04.000000000 +0900
@@ -25,8 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-
-#include <asm/dmaengine.h>
+#include <linux/sh_dma.h>
 
 #include "shdma.h"
 
--- 0004/drivers/dma/shdma.h
+++ work/drivers/dma/shdma.h	2010-03-18 23:25:04.000000000 +0900
@@ -17,8 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/list.h>
 
-#include <asm/dmaengine.h>
-
+#define SH_DMAC_MAX_CHANNELS 6
 #define SH_DMA_SLAVE_NUMBER 256
 #define SH_DMA_TCR_MAX 0x00FFFFFF	/* 16MB */
 
--- /dev/null
+++ work/include/linux/sh_dma.h	2010-03-18 23:25:32.000000000 +0900
@@ -0,0 +1,101 @@
+/*
+ * Header for the new SH dmaengine driver
+ *
+ * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef SH_DMA_H
+#define SH_DMA_H
+
+#include <linux/list.h>
+#include <linux/dmaengine.h>
+
+/* Used by slave DMA clients to request DMA to/from a specific peripheral */
+struct sh_dmae_slave {
+	unsigned int			slave_id; /* Set by the platform */
+	struct device			*dma_dev; /* Set by the platform */
+	struct sh_dmae_slave_config	*config;  /* Set by the driver */
+};
+
+struct sh_dmae_regs {
+	u32 sar; /* SAR / source address */
+	u32 dar; /* DAR / destination address */
+	u32 tcr; /* TCR / transfer count */
+};
+
+struct sh_desc {
+	struct sh_dmae_regs hw;
+	struct list_head node;
+	struct dma_async_tx_descriptor async_tx;
+	enum dma_data_direction direction;
+	dma_cookie_t cookie;
+	size_t partial;
+	int chunks;
+	int mark;
+};
+struct sh_dmae_slave_config {
+	unsigned int			slave_id;
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
