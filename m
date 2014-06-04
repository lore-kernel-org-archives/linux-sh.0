From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 16:14:10 +0000
Subject: [PATCH 3/8] shdma: fdt: update r8a73a4 code for re-use in shdma-of code
Message-Id: <1401898455-31064-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The shdma-r8a73a4 code contains useful constants in the shdam-arm.h
file that could be re-used by shdma-of code for the generic arm template
structure.

Change the names to be specific to ARM to ensure the code can be included
in shdma-of whilst avoiding the possibility it will clash with any other
defines.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/dma/sh/shdma-arm.h     | 48 +++++++++++++++++++++---------------------
 drivers/dma/sh/shdma-r8a73a4.c | 18 ++++++++--------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/dma/sh/shdma-arm.h b/drivers/dma/sh/shdma-arm.h
index a2b8258..987ca21 100644
--- a/drivers/dma/sh/shdma-arm.h
+++ b/drivers/dma/sh/shdma-arm.h
@@ -15,37 +15,37 @@
 
 /* Transmit sizes and respective CHCR register values */
 enum {
-	XMIT_SZ_8BIT		= 0,
-	XMIT_SZ_16BIT		= 1,
-	XMIT_SZ_32BIT		= 2,
-	XMIT_SZ_64BIT		= 7,
-	XMIT_SZ_128BIT		= 3,
-	XMIT_SZ_256BIT		= 4,
-	XMIT_SZ_512BIT		= 5,
+	SHDMA_ARM_SZ_8BIT		= 0,
+	SHDMA_ARM_SZ_16BIT		= 1,
+	SHDMA_ARM_SZ_32BIT		= 2,
+	SHDMA_ARM_SZ_64BIT		= 7,
+	SHDMA_ARM_SZ_128BIT		= 3,
+	SHDMA_ARM_SZ_256BIT		= 4,
+	SHDMA_ARM_SZ_512BIT		= 5,
 };
 
 /* log2(size / 8) - used to calculate number of transfers */
-#define SH_DMAE_TS_SHIFT {		\
-	[XMIT_SZ_8BIT]		= 0,	\
-	[XMIT_SZ_16BIT]		= 1,	\
-	[XMIT_SZ_32BIT]		= 2,	\
-	[XMIT_SZ_64BIT]		= 3,	\
-	[XMIT_SZ_128BIT]	= 4,	\
-	[XMIT_SZ_256BIT]	= 5,	\
-	[XMIT_SZ_512BIT]	= 6,	\
+#define SH_DMAE_ARM_TS_SHIFT {		\
+	[SHDMA_ARM_SZ_8BIT]		= 0,	\
+	[SHDMA_ARM_SZ_16BIT]		= 1,	\
+	[SHDMA_ARM_SZ_32BIT]		= 2,	\
+	[SHDMA_ARM_SZ_64BIT]		= 3,	\
+	[SHDMA_ARM_SZ_128BIT]	= 4,	\
+	[SHDMA_ARM_SZ_256BIT]	= 5,	\
+	[SHDMA_ARM_SZ_512BIT]	= 6,	\
 }
 
-#define TS_LOW_BIT	0x3 /* --xx */
-#define TS_HI_BIT	0xc /* xx-- */
+#define SHDMA_ARM_TS_LOW_BIT	0x3 /* --xx */
+#define SHDMA_ARM_TS_HI_BIT	0xc /* xx-- */
 
-#define TS_LOW_SHIFT	(3)
-#define TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+#define SHDMA_ARM_TS_LOW_SHIFT	(3)
+#define SHDMA_ARM_TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
 
-#define TS_INDEX2VAL(i) \
-	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
-	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
+#define SHDMA_ARM_TS_INDEX2VAL(i) \
+	((((i) & SHDMA_ARM_TS_LOW_BIT) << SHDMA_ARM_TS_LOW_SHIFT) |\
+	 (((i) & SHDMA_ARM_TS_HI_BIT)  << SHDMA_ARM_TS_HI_SHIFT))
 
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | SHDMA_ARM_TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | SHDMA_ARM_TS_INDEX2VAL((xmit_sz)))
 
 #endif
diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
index 4fb9997..c7fd2b2 100644
--- a/drivers/dma/sh/shdma-r8a73a4.c
+++ b/drivers/dma/sh/shdma-r8a73a4.c
@@ -11,20 +11,20 @@
 
 #include "shdma-arm.h"
 
-const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
+const unsigned int dma_ts_shift[] = SH_DMAE_ARM_TS_SHIFT;
 
 static const struct sh_dmae_slave_config dma_slaves[] = {
 	{
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.chcr		= CHCR_TX(SHDMA_ARM_SZ_32BIT),
 		.mid_rid	= 0xd1,		/* MMC0 Tx */
 	}, {
-		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.chcr		= CHCR_RX(SHDMA_ARM_SZ_32BIT),
 		.mid_rid	= 0xd2,		/* MMC0 Rx */
 	}, {
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.chcr		= CHCR_TX(SHDMA_ARM_SZ_32BIT),
 		.mid_rid	= 0xe1,		/* MMC1 Tx */
 	}, {
-		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.chcr		= CHCR_RX(SHDMA_ARM_SZ_32BIT),
 		.mid_rid	= 0xe2,		/* MMC1 Rx */
 	},
 };
@@ -65,10 +65,10 @@ const struct sh_dmae_pdata r8a73a4_dma_pdata = {
 	.slave_num	= ARRAY_SIZE(dma_slaves),
 	.channel	= dma_channels,
 	.channel_num	= ARRAY_SIZE(dma_channels),
-	.ts_low_shift	= TS_LOW_SHIFT,
-	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
-	.ts_high_shift	= TS_HI_SHIFT,
-	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_low_shift	= SHDMA_ARM_TS_LOW_SHIFT,
+	.ts_low_mask	= SHDMA_ARM_TS_LOW_BIT << SHDMA_ARM_TS_LOW_SHIFT,
+	.ts_high_shift	= SHDMA_ARM_TS_HI_SHIFT,
+	.ts_high_mask	= SHDMA_ARM_TS_HI_BIT << SHDMA_ARM_TS_HI_SHIFT,
 	.ts_shift	= dma_ts_shift,
 	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
 	.dmaor_init     = DMAOR_DME,
-- 
2.0.0.rc2

