From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:34:22 +0000
Subject: [PATCH 05/27 v2] ARM: shmobile: shareing DMAEngine TS_HI/LOW value
Message-Id: <87zk88x49x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In SH-ARM CPU (= sh7372/sh73a0/r8a7740),
DMAC :: CHCR :: TS (= DMA Transfer Size Specify) bit is mapped as
TS[3:2] = CHCR[21:20]
TS[1:0] = CHCR[4:3]

Because of these mapping, shdma needs
special settings on sh_dmae_pdata / sh_dmae_slave_config.

But it is easy to understand if these settings use sharing value
instead of using direct value.
This patch modify these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
v1 -> v2

 - no change

 arch/arm/mach-shmobile/include/mach/dma-register.h |   11 ++++++++++-
 arch/arm/mach-shmobile/setup-sh7372.c              |    8 ++++----
 arch/arm/mach-shmobile/setup-sh73a0.c              |    8 ++++----
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/dma-register.h b/arch/arm/mach-shmobile/include/mach/dma-register.h
index 0ed1e90..21b3dff 100644
--- a/arch/arm/mach-shmobile/include/mach/dma-register.h
+++ b/arch/arm/mach-shmobile/include/mach/dma-register.h
@@ -38,7 +38,16 @@ static const unsigned int dma_ts_shift[] = {
 	[XMIT_SZ_512BIT]	= 6,
 };
 
-#define TS_INDEX2VAL(i) ((((i) & 0x3) << 3) | (((i) & 0xc) << (20 - 2)))
+#define TS_LOW_BIT	0x3 /* --xx */
+#define TS_HI_BIT	0xc /* xx-- */
+
+#define TS_LOW_SHIFT	(3)
+#define TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+
+#define TS_INDEX2VAL(i) \
+	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
+	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
+
 #define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
 #define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
 
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index a0e3113..aa5c2ba 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -501,10 +501,10 @@ static struct sh_dmae_pdata dma_platform_data = {
 	.slave_num	= ARRAY_SIZE(sh7372_dmae_slaves),
 	.channel	= sh7372_dmae_channels,
 	.channel_num	= ARRAY_SIZE(sh7372_dmae_channels),
-	.ts_low_shift	= 3,
-	.ts_low_mask	= 0x18,
-	.ts_high_shift	= (20 - 2),	/* 2 bits for shifted low TS */
-	.ts_high_mask	= 0x00300000,
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
 	.ts_shift	= dma_ts_shift,
 	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
 	.dmaor_init	= DMAOR_DME,
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 69d6393..3617bc5 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -584,10 +584,10 @@ static struct sh_dmae_pdata sh73a0_dmae_platform_data = {
 	.slave_num      = ARRAY_SIZE(sh73a0_dmae_slaves),
 	.channel        = sh73a0_dmae_channels,
 	.channel_num    = ARRAY_SIZE(sh73a0_dmae_channels),
-	.ts_low_shift   = 3,
-	.ts_low_mask    = 0x18,
-	.ts_high_shift  = (20 - 2),     /* 2 bits for shifted low TS */
-	.ts_high_mask   = 0x00300000,
+	.ts_low_shift   = TS_LOW_SHIFT,
+	.ts_low_mask    = TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift  = TS_HI_SHIFT,
+	.ts_high_mask   = TS_HI_BIT << TS_HI_SHIFT,
 	.ts_shift       = dma_ts_shift,
 	.ts_shift_num   = ARRAY_SIZE(dma_ts_shift),
 	.dmaor_init     = DMAOR_DME,
-- 
1.7.5.4

