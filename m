From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:34:56 +0000
Subject: [PATCH 06/27 v2] ARM: shmobile: shareing DMAEngine USBTS_HI/LOW value
Message-Id: <87y5nsx48z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In SH-ARM CPU (= sh7372/sh73a0/r8a7740),
USB DMA :: CHCR :: TS (= DMA Transfer Size Specify) bit is mapped as
TS[1:0] = CHCR[7:6]

SH-ARM USB DMAEngine uses shdma.
Then, it is easy to understand if sh_dmae_pdata / sh_dmae_slave_config
settings are used defined value instead of direct value.
This patch modify these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
v1 -> v2

 - USBTS_SHIFT -> static dma_usbts_shift

 arch/arm/mach-shmobile/include/mach/dma-register.h |   30 ++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c              |   43 +++++++------------
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/dma-register.h b/arch/arm/mach-shmobile/include/mach/dma-register.h
index 21b3dff..97c40bd 100644
--- a/arch/arm/mach-shmobile/include/mach/dma-register.h
+++ b/arch/arm/mach-shmobile/include/mach/dma-register.h
@@ -16,6 +16,10 @@
 #ifndef DMA_REGISTER_H
 #define DMA_REGISTER_H
 
+/*
+ *		Direct Memory Access Controller
+ */
+
 /* Transmit sizes and respective CHCR register values */
 enum {
 	XMIT_SZ_8BIT		= 0,
@@ -51,4 +55,30 @@ static const unsigned int dma_ts_shift[] = {
 #define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
 #define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
 
+
+/*
+ *		USB High-Speed DMAC
+ */
+/* Transmit sizes and respective CHCR register values */
+enum {
+	USBTS_XMIT_SZ_8BYTE		= 0,
+	USBTS_XMIT_SZ_16BYTE		= 1,
+	USBTS_XMIT_SZ_32BYTE		= 2,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+static const unsigned int dma_usbts_shift[] = {
+	[USBTS_XMIT_SZ_8BYTE]	= 3,
+	[USBTS_XMIT_SZ_16BYTE]	= 4,
+	[USBTS_XMIT_SZ_32BYTE]	= 5,
+};
+
+#define USBTS_LOW_BIT	0x3 /* --xx */
+#define USBTS_HI_BIT	0x0 /* ---- */
+
+#define USBTS_LOW_SHIFT	6
+#define USBTS_HI_SHIFT	0
+
+#define USBTS_INDEX2VAL(i) (((i) & 3) << 6)
+
 #endif /* DMA_REGISTER_H */
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index aa5c2ba..7873159 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -628,17 +628,6 @@ static struct platform_device dma2_device = {
 /*
  * USB-DMAC
  */
-
-unsigned int usbts_shift[] = {3, 4, 5};
-
-enum {
-	XMIT_SZ_8BYTE		= 0,
-	XMIT_SZ_16BYTE		= 1,
-	XMIT_SZ_32BYTE		= 2,
-};
-
-#define USBTS_INDEX2VAL(i) (((i) & 3) << 6)
-
 static const struct sh_dmae_channel sh7372_usb_dmae_channels[] = {
 	{
 		.offset = 0,
@@ -651,10 +640,10 @@ static const struct sh_dmae_channel sh7372_usb_dmae_channels[] = {
 static const struct sh_dmae_slave_config sh7372_usb_dmae0_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_USB0_TX,
-		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
+		.chcr		= USBTS_INDEX2VAL(USBTS_XMIT_SZ_8BYTE),
 	}, {
 		.slave_id	= SHDMA_SLAVE_USB0_RX,
-		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
+		.chcr		= USBTS_INDEX2VAL(USBTS_XMIT_SZ_8BYTE),
 	},
 };
 
@@ -663,12 +652,12 @@ static struct sh_dmae_pdata usb_dma0_platform_data = {
 	.slave_num	= ARRAY_SIZE(sh7372_usb_dmae0_slaves),
 	.channel	= sh7372_usb_dmae_channels,
 	.channel_num	= ARRAY_SIZE(sh7372_usb_dmae_channels),
-	.ts_low_shift	= 6,
-	.ts_low_mask	= 0xc0,
-	.ts_high_shift	= 0,
-	.ts_high_mask	= 0,
-	.ts_shift	= usbts_shift,
-	.ts_shift_num	= ARRAY_SIZE(usbts_shift),
+	.ts_low_shift	= USBTS_LOW_SHIFT,
+	.ts_low_mask	= USBTS_LOW_BIT << USBTS_LOW_SHIFT,
+	.ts_high_shift	= USBTS_HI_SHIFT,
+	.ts_high_mask	= USBTS_HI_BIT << USBTS_HI_SHIFT,
+	.ts_shift	= dma_usbts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_usbts_shift),
 	.dmaor_init	= DMAOR_DME,
 	.chcr_offset	= 0x14,
 	.chcr_ie_bit	= 1 << 5,
@@ -713,10 +702,10 @@ static struct platform_device usb_dma0_device = {
 static const struct sh_dmae_slave_config sh7372_usb_dmae1_slaves[] = {
 	{
 		.slave_id	= SHDMA_SLAVE_USB1_TX,
-		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
+		.chcr		= USBTS_INDEX2VAL(USBTS_XMIT_SZ_8BYTE),
 	}, {
 		.slave_id	= SHDMA_SLAVE_USB1_RX,
-		.chcr		= USBTS_INDEX2VAL(XMIT_SZ_8BYTE),
+		.chcr		= USBTS_INDEX2VAL(USBTS_XMIT_SZ_8BYTE),
 	},
 };
 
@@ -725,12 +714,12 @@ static struct sh_dmae_pdata usb_dma1_platform_data = {
 	.slave_num	= ARRAY_SIZE(sh7372_usb_dmae1_slaves),
 	.channel	= sh7372_usb_dmae_channels,
 	.channel_num	= ARRAY_SIZE(sh7372_usb_dmae_channels),
-	.ts_low_shift	= 6,
-	.ts_low_mask	= 0xc0,
-	.ts_high_shift	= 0,
-	.ts_high_mask	= 0,
-	.ts_shift	= usbts_shift,
-	.ts_shift_num	= ARRAY_SIZE(usbts_shift),
+	.ts_low_shift	= USBTS_LOW_SHIFT,
+	.ts_low_mask	= USBTS_LOW_BIT << USBTS_LOW_SHIFT,
+	.ts_high_shift	= USBTS_HI_SHIFT,
+	.ts_high_mask	= USBTS_HI_BIT << USBTS_HI_SHIFT,
+	.ts_shift	= dma_usbts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_usbts_shift),
 	.dmaor_init	= DMAOR_DME,
 	.chcr_offset	= 0x14,
 	.chcr_ie_bit	= 1 << 5,
-- 
1.7.5.4

