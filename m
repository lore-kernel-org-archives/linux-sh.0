From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:43:19 +0000
Subject: [PATCH 3/4] ARM: shmobile: use common DMAEngine definitions on sh7372
Message-Id: <87a9zrk6yk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch switch over to use common DMAEngine definitions,
and reduced a waste of code.

It is easy to understand if sh_dmae_pdata / sh_dmae_slave_config
settings are used defined value instead of direct value.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-sh7372.c |  131 ++++++++++++---------------------
 1 files changed, 47 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index fafce9c..7873159 100644
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
@@ -520,19 +496,17 @@ static const struct sh_dmae_channel sh7372_dmae_channels[] = {
 	}
 };
 
-static const unsigned int ts_shift[] = TS_SHIFT;
-
 static struct sh_dmae_pdata dma_platform_data = {
 	.slave		= sh7372_dmae_slaves,
 	.slave_num	= ARRAY_SIZE(sh7372_dmae_slaves),
 	.channel	= sh7372_dmae_channels,
 	.channel_num	= ARRAY_SIZE(sh7372_dmae_channels),
-	.ts_low_shift	= 3,
-	.ts_low_mask	= 0x18,
-	.ts_high_shift	= (20 - 2),	/* 2 bits for shifted low TS */
-	.ts_high_mask	= 0x00300000,
-	.ts_shift	= ts_shift,
-	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
 	.dmaor_init	= DMAOR_DME,
 	.chclr_present	= 1,
 };
@@ -654,17 +628,6 @@ static struct platform_device dma2_device = {
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
@@ -677,10 +640,10 @@ static const struct sh_dmae_channel sh7372_usb_dmae_channels[] = {
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
 
@@ -689,12 +652,12 @@ static struct sh_dmae_pdata usb_dma0_platform_data = {
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
@@ -739,10 +702,10 @@ static struct platform_device usb_dma0_device = {
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
 
@@ -751,12 +714,12 @@ static struct sh_dmae_pdata usb_dma1_platform_data = {
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

