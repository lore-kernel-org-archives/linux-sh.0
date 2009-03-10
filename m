From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 10 Mar 2009 08:17:33 +0000
Subject: [PATCH v3] sh: Update dma-sh api
Message-Id: <49B6221D.1020301@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA support of new SH CPU and the change of definition.
And add Multi IRQ support for SH7763/64/80/85.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---

 V3: revert CONFIG_NR_ONCHIP_DMA_CHANNELS defconfig

 arch/sh/drivers/dma/Kconfig              |    8 +-
 arch/sh/drivers/dma/dma-sh.c             |  172 ++++++++++++++++++++----------
 arch/sh/drivers/dma/dma-sh.h             |   75 -------------
 arch/sh/include/asm/dma-sh.h             |  117 ++++++++++++++++++++
 arch/sh/include/asm/dma.h                |    4 +-
 arch/sh/include/cpu-sh3/cpu/dma.h        |   17 +--
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h   |   94 ++++++++++++++++
 arch/sh/include/cpu-sh4/cpu/dma-sh7780.h |   39 -------
 arch/sh/include/cpu-sh4/cpu/dma.h        |   30 +++---
 9 files changed, 352 insertions(+), 204 deletions(-)
 delete mode 100644 arch/sh/drivers/dma/dma-sh.h
 create mode 100644 arch/sh/include/asm/dma-sh.h
 create mode 100644 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
 delete mode 100644 arch/sh/include/cpu-sh4/cpu/dma-sh7780.h

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index 0193636..57d95fc 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -12,10 +12,10 @@ config SH_DMA
 config NR_ONCHIP_DMA_CHANNELS
 	int
 	depends on SH_DMA
-	default "6" if CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721
-	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R
-	default "12" if CPU_SUBTYPE_SH7780
-	default "4"
+	default "4" if CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7750S
+	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || CPU_SUBTYPE_SH7760
+	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
+	default "6"
 	help
 	  This allows you to specify the number of channels that the on-chip
 	  DMAC supports. This will be 4 for SH7750/SH7751 and 8 for the
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 50887a5..ab7b18d 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -17,28 +17,23 @@
 #include <mach-dreamcast/mach/dma.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include "dma-sh.h"
-
-static int dmte_irq_map[] = {
-	DMTE0_IRQ,
-	DMTE1_IRQ,
-	DMTE2_IRQ,
-	DMTE3_IRQ,
-#if defined(CONFIG_CPU_SUBTYPE_SH7720)  ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7721)  ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7751R) ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7760)  ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7709)  ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7780)
-	DMTE4_IRQ,
-	DMTE5_IRQ,
+#include <asm/dma-sh.h>
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7763)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7764)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7780)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7785)
+#define DMAC_IRQ_MULTI	1
 #endif
-#if defined(CONFIG_CPU_SUBTYPE_SH7751R) ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7760)  ||	\
-    defined(CONFIG_CPU_SUBTYPE_SH7780)
-	DMTE6_IRQ,
-	DMTE7_IRQ,
+
+#if defined(DMAE1_IRQ)
+#define NR_DMAE		2
+#else
+#define NR_DMAE		1
 #endif
+
+static const char *dmae_name[] = {
+	"DMAC Address Error0", "DMAC Address Error1"
 };

 static inline unsigned int get_dmte_irq(unsigned int chan)
@@ -46,7 +41,14 @@ static inline unsigned int get_dmte_irq(unsigned int chan)
 	unsigned int irq = 0;
 	if (chan < ARRAY_SIZE(dmte_irq_map))
 		irq = dmte_irq_map[chan];
+
+#if defined(DMAC_IRQ_MULTI)
+	if (irq > DMTE6_IRQ)
+		return DMTE6_IRQ;
+	return DMTE0_IRQ;
+#else
 	return irq;
+#endif
 }

 /*
@@ -59,7 +61,7 @@ static inline unsigned int get_dmte_irq(unsigned int chan)
  */
 static inline unsigned int calc_xmit_shift(struct dma_channel *chan)
 {
-	u32 chcr = ctrl_inl(CHCR[chan->chan]);
+	u32 chcr = ctrl_inl(dma_base_addr[chan->chan] + CHCR);

 	return ts_shift[(chcr & CHCR_TS_MASK)>>CHCR_TS_SHIFT];
 }
@@ -75,13 +77,13 @@ static irqreturn_t dma_tei(int irq, void *dev_id)
 	struct dma_channel *chan = dev_id;
 	u32 chcr;

-	chcr = ctrl_inl(CHCR[chan->chan]);
+	chcr = ctrl_inl(dma_base_addr[chan->chan] + CHCR);

 	if (!(chcr & CHCR_TE))
 		return IRQ_NONE;

 	chcr &= ~(CHCR_IE | CHCR_DE);
-	ctrl_outl(chcr, CHCR[chan->chan]);
+	ctrl_outl(chcr, (dma_base_addr[chan->chan] + CHCR));

 	wake_up(&chan->wait_queue);

@@ -94,7 +96,12 @@ static int sh_dmac_request_dma(struct dma_channel *chan)
 		return 0;

 	return request_irq(get_dmte_irq(chan->chan), dma_tei,
-			   IRQF_DISABLED, chan->dev_id, chan);
+#if defined(DMAC_IRQ_MULTI)
+				IRQF_SHARED,
+#else
+				IRQF_DISABLED,
+#endif
+				chan->dev_id, chan);
 }

 static void sh_dmac_free_dma(struct dma_channel *chan)
@@ -115,7 +122,7 @@ sh_dmac_configure_channel(struct dma_channel *chan, unsigned long chcr)
 		chan->flags &= ~DMA_TEI_CAPABLE;
 	}

-	ctrl_outl(chcr, CHCR[chan->chan]);
+	ctrl_outl(chcr, (dma_base_addr[chan->chan] + CHCR));

 	chan->flags |= DMA_CONFIGURED;
 	return 0;
@@ -126,13 +133,13 @@ static void sh_dmac_enable_dma(struct dma_channel *chan)
 	int irq;
 	u32 chcr;

-	chcr = ctrl_inl(CHCR[chan->chan]);
+	chcr = ctrl_inl(dma_base_addr[chan->chan] + CHCR);
 	chcr |= CHCR_DE;

 	if (chan->flags & DMA_TEI_CAPABLE)
 		chcr |= CHCR_IE;

-	ctrl_outl(chcr, CHCR[chan->chan]);
+	ctrl_outl(chcr, (dma_base_addr[chan->chan] + CHCR));

 	if (chan->flags & DMA_TEI_CAPABLE) {
 		irq = get_dmte_irq(chan->chan);
@@ -150,9 +157,9 @@ static void sh_dmac_disable_dma(struct dma_channel *chan)
 		disable_irq(irq);
 	}

-	chcr = ctrl_inl(CHCR[chan->chan]);
+	chcr = ctrl_inl(dma_base_addr[chan->chan] + CHCR);
 	chcr &= ~(CHCR_DE | CHCR_TE | CHCR_IE);
-	ctrl_outl(chcr, CHCR[chan->chan]);
+	ctrl_outl(chcr, (dma_base_addr[chan->chan] + CHCR));
 }

 static int sh_dmac_xfer_dma(struct dma_channel *chan)
@@ -183,12 +190,13 @@ static int sh_dmac_xfer_dma(struct dma_channel *chan)
 	 */
 	if (chan->sar || (mach_is_dreamcast() &&
 			  chan->chan = PVR2_CASCADE_CHAN))
-		ctrl_outl(chan->sar, SAR[chan->chan]);
+		ctrl_outl(chan->sar, (dma_base_addr[chan->chan]+SAR));
 	if (chan->dar || (mach_is_dreamcast() &&
 			  chan->chan = PVR2_CASCADE_CHAN))
-		ctrl_outl(chan->dar, DAR[chan->chan]);
+		ctrl_outl(chan->dar, (dma_base_addr[chan->chan] + DAR));

-	ctrl_outl(chan->count >> calc_xmit_shift(chan), DMATCR[chan->chan]);
+	ctrl_outl(chan->count >> calc_xmit_shift(chan),
+		(dma_base_addr[chan->chan] + TCR));

 	sh_dmac_enable_dma(chan);

@@ -197,36 +205,26 @@ static int sh_dmac_xfer_dma(struct dma_channel *chan)

 static int sh_dmac_get_dma_residue(struct dma_channel *chan)
 {
-	if (!(ctrl_inl(CHCR[chan->chan]) & CHCR_DE))
+	if (!(ctrl_inl(dma_base_addr[chan->chan] + CHCR) & CHCR_DE))
 		return 0;

-	return ctrl_inl(DMATCR[chan->chan]) << calc_xmit_shift(chan);
+	return ctrl_inl(dma_base_addr[chan->chan] + TCR)
+		 << calc_xmit_shift(chan);
 }

-#if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7780) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7709)
-#define dmaor_read_reg()	ctrl_inw(DMAOR)
-#define dmaor_write_reg(data)	ctrl_outw(data, DMAOR)
-#else
-#define dmaor_read_reg()	ctrl_inl(DMAOR)
-#define dmaor_write_reg(data)	ctrl_outl(data, DMAOR)
-#endif
-
-static inline int dmaor_reset(void)
+static inline int dmaor_reset(int no)
 {
-	unsigned long dmaor = dmaor_read_reg();
+	unsigned long dmaor = dmaor_read_reg(no);

 	/* Try to clear the error flags first, incase they are set */
 	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
-	dmaor_write_reg(dmaor);
+	dmaor_write_reg(no, dmaor);

 	dmaor |= DMAOR_INIT;
-	dmaor_write_reg(dmaor);
+	dmaor_write_reg(no, dmaor);

 	/* See if we got an error again */
-	if ((dmaor_read_reg() & (DMAOR_AE | DMAOR_NMIF))) {
+	if ((dmaor_read_reg(no) & (DMAOR_AE | DMAOR_NMIF))) {
 		printk(KERN_ERR "dma-sh: Can't initialize DMAOR.\n");
 		return -EINVAL;
 	}
@@ -237,10 +235,33 @@ static inline int dmaor_reset(void)
 #if defined(CONFIG_CPU_SH4)
 static irqreturn_t dma_err(int irq, void *dummy)
 {
-	dmaor_reset();
+#if defined(DMAC_IRQ_MULTI)
+	int cnt = 0;
+	switch (irq) {
+#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
+	case DMTE6_IRQ:
+		cnt++;
+#endif
+	case DMTE0_IRQ:
+		if (dmaor_read_reg(cnt) & (DMAOR_NMIF | DMAOR_AE)) {
+			disable_irq(irq);
+			/* DMA multi and error IRQ */
+			return IRQ_HANDLED;
+		}
+	default:
+		return IRQ_NONE;
+	}
+#else
+	dmaor_reset(0);
+#if defined(CONFIG_CPU_SUBTYPE_SH7723)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7780)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7785)
+	dmaor_reset(1);
+#endif
 	disable_irq(irq);

 	return IRQ_HANDLED;
+#endif
 }
 #endif

@@ -259,24 +280,57 @@ static struct dma_info sh_dmac_info = {
 	.flags		= DMAC_CHANNELS_TEI_CAPABLE,
 };

+static unsigned int get_dma_error_irq(int n)
+{
+#if defined(DMAC_IRQ_MULTI)
+	return (n = 0) ? get_dmte_irq(0) : get_dmte_irq(6);
+#else
+	return (n = 0) ? DMAE0_IRQ :
+#if defined(DMAE1_IRQ)
+				DMAE1_IRQ;
+#else
+				-1;
+#endif
+#endif
+}
+
 static int __init sh_dmac_init(void)
 {
 	struct dma_info *info = &sh_dmac_info;
 	int i;

 #ifdef CONFIG_CPU_SH4
-	i = request_irq(DMAE_IRQ, dma_err, IRQF_DISABLED, "DMAC Address Error", 0);
-	if (unlikely(i < 0))
-		return i;
+	int n;
+
+	for (n = 0; n < NR_DMAE; n++) {
+		i = request_irq(get_dma_error_irq(n), dma_err,
+#if defined(DMAC_IRQ_MULTI)
+				IRQF_SHARED,
+#else
+				IRQF_DISABLED,
 #endif
+				dmae_name[n], (void *)dmae_name[n]);
+		if (unlikely(i < 0)) {
+			printk(KERN_ERR "%s request_irq fail\n", dmae_name[n]);
+			return i;
+		}
+	}
+#endif /* CONFIG_CPU_SH4 */

 	/*
 	 * Initialize DMAOR, and clean up any error flags that may have
 	 * been set.
 	 */
-	i = dmaor_reset();
+	i = dmaor_reset(0);
+	if (unlikely(i != 0))
+		return i;
+#if defined(CONFIG_CPU_SUBTYPE_SH7723)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7780)	|| \
+		defined(CONFIG_CPU_SUBTYPE_SH7785)
+	i = dmaor_reset(1);
 	if (unlikely(i != 0))
 		return i;
+#endif

 	return register_dmac(info);
 }
@@ -284,8 +338,12 @@ static int __init sh_dmac_init(void)
 static void __exit sh_dmac_exit(void)
 {
 #ifdef CONFIG_CPU_SH4
-	free_irq(DMAE_IRQ, 0);
-#endif
+	int n;
+
+	for (n = 0; n < NR_DMAE; n++) {
+		free_irq(get_dma_error_irq(n), (void *)dmae_name[n]);
+	}
+#endif /* CONFIG_CPU_SH4 */
 	unregister_dmac(&sh_dmac_info);
 }

diff --git a/arch/sh/drivers/dma/dma-sh.h b/arch/sh/drivers/dma/dma-sh.h
deleted file mode 100644
index 05fecd5..0000000
--- a/arch/sh/drivers/dma/dma-sh.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * arch/sh/drivers/dma/dma-sh.h
- *
- * Copyright (C) 2000  Takashi YOSHII
- * Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#ifndef __DMA_SH_H
-#define __DMA_SH_H
-
-#include <cpu/dma.h>
-
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
-#define SM_INC	0x00001000
-#define SM_DEC	0x00002000
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
-/*
- * Define the default configuration for dual address memory-memory transfer.
- * The 0x400 value represents auto-request, external->external.
- */
-#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_32)
-
-#define MAX_DMAC_CHANNELS	(CONFIG_NR_ONCHIP_DMA_CHANNELS)
-
-/*
- * Subtypes that have fewer channels than this simply need to change
- * CONFIG_NR_ONCHIP_DMA_CHANNELS. Likewise, subtypes with a larger number
- * of channels should expand on this.
- *
- * For most subtypes we can easily figure these values out with some
- * basic calculation, unfortunately on other subtypes these are more
- * scattered, so we just leave it unrolled for simplicity.
- */
-#define SAR	((unsigned long[]){SH_DMAC_BASE + 0x00, SH_DMAC_BASE + 0x10, \
-				   SH_DMAC_BASE + 0x20, SH_DMAC_BASE + 0x30, \
-				   SH_DMAC_BASE + 0x50, SH_DMAC_BASE + 0x60})
-#define DAR	((unsigned long[]){SH_DMAC_BASE + 0x04, SH_DMAC_BASE + 0x14, \
-				   SH_DMAC_BASE + 0x24, SH_DMAC_BASE + 0x34, \
-				   SH_DMAC_BASE + 0x54, SH_DMAC_BASE + 0x64})
-#define DMATCR	((unsigned long[]){SH_DMAC_BASE + 0x08, SH_DMAC_BASE + 0x18, \
-				   SH_DMAC_BASE + 0x28, SH_DMAC_BASE + 0x38, \
-				   SH_DMAC_BASE + 0x58, SH_DMAC_BASE + 0x68})
-#define CHCR	((unsigned long[]){SH_DMAC_BASE + 0x0c, SH_DMAC_BASE + 0x1c, \
-				   SH_DMAC_BASE + 0x2c, SH_DMAC_BASE + 0x3c, \
-				   SH_DMAC_BASE + 0x5c, SH_DMAC_BASE + 0x6c})
-
-#define DMAOR	(SH_DMAC_BASE + 0x40)
-
-#endif /* __DMA_SH_H */
-
diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
new file mode 100644
index 0000000..e873eca
--- /dev/null
+++ b/arch/sh/include/asm/dma-sh.h
@@ -0,0 +1,117 @@
+/*
+ * arch/sh/include/asm/dma-sh.h
+ *
+ * Copyright (C) 2000  Takashi YOSHII
+ * Copyright (C) 2003  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __DMA_SH_H
+#define __DMA_SH_H
+
+#include <cpu/dma.h>
+
+/* DMAOR contorl: The DMAOR access size is different by CPU.*/
+#if defined(CONFIG_CPU_SUBTYPE_SH7723)	|| \
+    defined(CONFIG_CPU_SUBTYPE_SH7780)	|| \
+    defined(CONFIG_CPU_SUBTYPE_SH7785)
+#define dmaor_read_reg(n) \
+    (n ? ctrl_inw(SH_DMAC_BASE1 + DMAOR) \
+	: ctrl_inw(SH_DMAC_BASE0 + DMAOR))
+#define dmaor_write_reg(n, data) \
+    (n ? ctrl_outw(data, SH_DMAC_BASE1 + DMAOR) \
+    : ctrl_outw(data, SH_DMAC_BASE0 + DMAOR))
+#else /* Other CPU */
+#define dmaor_read_reg(n) ctrl_inw(SH_DMAC_BASE0 + DMAOR)
+#define dmaor_write_reg(n, data) ctrl_outw(data, SH_DMAC_BASE0 + DMAOR)
+#endif
+
+static int dmte_irq_map[] __maybe_unused = {
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 4)
+    DMTE0_IRQ,
+    DMTE0_IRQ + 1,
+    DMTE0_IRQ + 2,
+    DMTE0_IRQ + 3,
+#endif
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 6)
+    DMTE4_IRQ,
+    DMTE4_IRQ + 1,
+#endif
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 8)
+    DMTE6_IRQ,
+    DMTE6_IRQ + 1,
+#endif
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 12)
+    DMTE8_IRQ,
+    DMTE9_IRQ,
+    DMTE10_IRQ,
+    DMTE11_IRQ,
+#endif
+};
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
+#define SM_INC	0x00001000
+#define SM_DEC	0x00002000
+#define RS_IN	0x00000200
+#define RS_OUT	0x00000300
+#define TS_BLK	0x00000040
+#define TM_BUR	0x00000020
+#define CHCR_DE 0x00000001
+#define CHCR_TE 0x00000002
+#define CHCR_IE 0x00000004
+
+/* DMAOR definitions */
+#define DMAOR_AE	0x00000004
+#define DMAOR_NMIF	0x00000002
+#define DMAOR_DME	0x00000001
+
+/*
+ * Define the default configuration for dual address memory-memory transfer.
+ * The 0x400 value represents auto-request, external->external.
+ */
+#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_32)
+
+/* DMA base address */
+static u32 dma_base_addr[] __maybe_unused = {
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 4)
+	SH_DMAC_BASE0 + 0x00,	/* channel 0 */
+	SH_DMAC_BASE0 + 0x10,
+	SH_DMAC_BASE0 + 0x20,
+	SH_DMAC_BASE0 + 0x30,
+#endif
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 6)
+	SH_DMAC_BASE0 + 0x50,
+	SH_DMAC_BASE0 + 0x60,
+#endif
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 8)
+	SH_DMAC_BASE1 + 0x00,
+	SH_DMAC_BASE1 + 0x10,
+#endif
+#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 12)
+	SH_DMAC_BASE1 + 0x20,
+	SH_DMAC_BASE1 + 0x30,
+	SH_DMAC_BASE1 + 0x50,
+	SH_DMAC_BASE1 + 0x60, /* channel 11 */
+#endif
+};
+
+/* DMA register */
+#define SAR     0x00
+#define DAR     0x04
+#define TCR     0x08
+#define CHCR    0x0C
+#define DMAOR	0x40
+
+#endif /* __DMA_SH_H */
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index beca712..6bd1784 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -25,9 +25,9 @@
 #define MAX_DMA_ADDRESS		(PAGE_OFFSET+0x10000000)

 #ifdef CONFIG_NR_DMA_CHANNELS
-#  define MAX_DMA_CHANNELS	(CONFIG_NR_DMA_CHANNELS)
+#  define MAX_DMA_CHANNELS   (CONFIG_NR_DMA_CHANNELS)
 #else
-#  define MAX_DMA_CHANNELS	(CONFIG_NR_ONCHIP_DMA_CHANNELS)
+#  define MAX_DMA_CHANNELS   (CONFIG_NR_ONCHIP_DMA_CHANNELS)
 #endif

 /*
diff --git a/arch/sh/include/cpu-sh3/cpu/dma.h b/arch/sh/include/cpu-sh3/cpu/dma.h
index 6813c32..0ea15f3 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma.h
@@ -1,22 +1,17 @@
 #ifndef __ASM_CPU_SH3_DMA_H
 #define __ASM_CPU_SH3_DMA_H

-
 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7721)
-#define SH_DMAC_BASE	0xa4010020
-#else
-#define SH_DMAC_BASE	0xa4000020
+    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7710) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7712)
+#define SH_DMAC_BASE0	0xa4010020
+#else /* SH7705/06/07/09 */
+#define SH_DMAC_BASE0	0xa4000020
 #endif

-#if defined(CONFIG_CPU_SUBTYPE_SH7720) || defined(CONFIG_CPU_SUBTYPE_SH7709)
 #define DMTE0_IRQ	48
-#define DMTE1_IRQ	49
-#define DMTE2_IRQ	50
-#define DMTE3_IRQ	51
 #define DMTE4_IRQ	76
-#define DMTE5_IRQ	77
-#endif

 /* Definitions for the SuperH DMAC */
 #define TM_BURST	0x00000020
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
new file mode 100644
index 0000000..0ed5178
--- /dev/null
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -0,0 +1,94 @@
+#ifndef __ASM_SH_CPU_SH4_DMA_SH7780_H
+#define __ASM_SH_CPU_SH4_DMA_SH7780_H
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7343) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7722) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7730)
+#define DMTE0_IRQ	48
+#define DMTE4_IRQ	76
+#define DMAE0_IRQ	78	/* DMA Error IRQ*/
+#define SH_DMAC_BASE0	0xFE008020
+#define SH_DMARS_BASE	0xFE009000
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7764)
+#define DMTE0_IRQ	34
+#define DMTE4_IRQ	44
+#define DMAE0_IRQ	38
+#define SH_DMAC_BASE0	0xFF608020
+#define SH_DMARS_BASE	0xFF609000
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
+#define DMTE0_IRQ	48	/* DMAC0A*/
+#define DMTE4_IRQ	40	/* DMAC0B */
+#define DMTE6_IRQ	42
+#define DMTE8_IRQ	76	/* DMAC1A */
+#define DMTE9_IRQ	77
+#define DMTE10_IRQ	72	/* DMAC1B */
+#define DMTE11_IRQ	73
+#define DMAE0_IRQ	78	/* DMA Error IRQ*/
+#define DMAE1_IRQ	74	/* DMA Error IRQ*/
+#define SH_DMAC_BASE0	0xFE008020
+#define SH_DMAC_BASE1	0xFDC08020
+#define SH_DMARS_BASE	0xFDC09000
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+#define DMTE0_IRQ	34
+#define DMTE4_IRQ	44
+#define DMTE6_IRQ	46
+#define DMTE8_IRQ	92
+#define DMTE9_IRQ	93
+#define DMTE10_IRQ	94
+#define DMTE11_IRQ	95
+#define DMAE0_IRQ	38	/* DMA Error IRQ */
+#define SH_DMAC_BASE0	0xFC808020
+#define SH_DMAC_BASE1	0xFC818020
+#define SH_DMARS_BASE	0xFC809000
+#else /* SH7785 */
+#define DMTE0_IRQ	33
+#define DMTE4_IRQ	37
+#define DMTE6_IRQ	52
+#define DMTE8_IRQ	54
+#define DMTE9_IRQ	55
+#define DMTE10_IRQ	56
+#define DMTE11_IRQ	57
+#define DMAE0_IRQ	39	/* DMA Error IRQ0 */
+#define DMAE1_IRQ	58	/* DMA Error IRQ1 */
+#define SH_DMAC_BASE0	0xFC808020
+#define SH_DMAC_BASE1	0xFCC08020
+#define SH_DMARS_BASE	0xFC809000
+#endif
+
+#define REQ_HE	0x000000C0
+#define REQ_H	0x00000080
+#define REQ_LE	0x00000040
+#define TM_BURST 0x0000020
+#define TS_8	0x00000000
+#define TS_16	0x00000008
+#define TS_32	0x00000010
+#define TS_16BLK	0x00000018
+#define TS_32BLK	0x00100000
+
+/*
+ * The SuperH DMAC supports a number of transmit sizes, we list them here,
+ * with their respective values as they appear in the CHCR registers.
+ *
+ * Defaults to a 64-bit transfer size.
+ */
+enum {
+	XMIT_SZ_8BIT,
+	XMIT_SZ_16BIT,
+	XMIT_SZ_32BIT,
+	XMIT_SZ_128BIT,
+	XMIT_SZ_256BIT,
+};
+
+/*
+ * The DMA count is defined as the number of bytes to transfer.
+ */
+static unsigned int ts_shift[] __maybe_unused = {
+	[XMIT_SZ_8BIT]		= 0,
+	[XMIT_SZ_16BIT]		= 1,
+	[XMIT_SZ_32BIT]		= 2,
+	[XMIT_SZ_128BIT]	= 4,
+	[XMIT_SZ_256BIT]	= 5,
+};
+
+#endif /* __ASM_SH_CPU_SH4_DMA_SH7780_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh7780.h b/arch/sh/include/cpu-sh4/cpu/dma-sh7780.h
deleted file mode 100644
index 71b426a..0000000
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh7780.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#ifndef __ASM_SH_CPU_SH4_DMA_SH7780_H
-#define __ASM_SH_CPU_SH4_DMA_SH7780_H
-
-#define REQ_HE	0x000000C0
-#define REQ_H	0x00000080
-#define REQ_LE	0x00000040
-#define TM_BURST 0x0000020
-#define TS_8	0x00000000
-#define TS_16	0x00000008
-#define TS_32	0x00000010
-#define TS_16BLK	0x00000018
-#define TS_32BLK	0x00100000
-
-/*
- * The SuperH DMAC supports a number of transmit sizes, we list them here,
- * with their respective values as they appear in the CHCR registers.
- *
- * Defaults to a 64-bit transfer size.
- */
-enum {
-	XMIT_SZ_8BIT,
-	XMIT_SZ_16BIT,
-	XMIT_SZ_32BIT,
-	XMIT_SZ_128BIT,
-	XMIT_SZ_256BIT,
-};
-
-/*
- * The DMA count is defined as the number of bytes to transfer.
- */
-static unsigned int ts_shift[] __maybe_unused = {
-	[XMIT_SZ_8BIT]		= 0,
-	[XMIT_SZ_16BIT]		= 1,
-	[XMIT_SZ_32BIT]		= 2,
-	[XMIT_SZ_128BIT]	= 4,
-	[XMIT_SZ_256BIT]	= 5,
-};
-
-#endif /* __ASM_SH_CPU_SH4_DMA_SH7780_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma.h b/arch/sh/include/cpu-sh4/cpu/dma.h
index 235b7cd..bcb3024 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma.h
@@ -1,31 +1,29 @@
 #ifndef __ASM_CPU_SH4_DMA_H
 #define __ASM_CPU_SH4_DMA_H

-#define DMAOR_INIT	( 0x8000 | DMAOR_DME )
-
 /* SH7751/7760/7780 DMA IRQ sources */
-#define DMTE0_IRQ	34
-#define DMTE1_IRQ	35
-#define DMTE2_IRQ	36
-#define DMTE3_IRQ	37
-#define DMTE4_IRQ	44
-#define DMTE5_IRQ	45
-#define DMTE6_IRQ	46
-#define DMTE7_IRQ	47
-#define DMAE_IRQ	38

 #ifdef CONFIG_CPU_SH4A
-#define SH_DMAC_BASE	0xfc808020

+#define DMAOR_INIT	(DMAOR_DME)
 #define CHCR_TS_MASK	0x18
 #define CHCR_TS_SHIFT	3

-#include <cpu/dma-sh7780.h>
-#else
-#define SH_DMAC_BASE	0xffa00000
+#include <cpu/dma-sh4a.h>
+#else /* CONFIG_CPU_SH4A */
+/*
+ * SH7750/SH7751/SH7760
+ */
+#define DMTE0_IRQ	34
+#define DMTE4_IRQ	44
+#define DMTE6_IRQ	46
+#define DMAE0_IRQ	38

+#define DMAOR_INIT	(0x8000|DMAOR_DME)
+#define SH_DMAC_BASE0	0xffa00000
+#define SH_DMAC_BASE1	0xffa00070
 /* Definitions for the SuperH DMAC */
-#define TM_BURST	0x0000080
+#define TM_BURST	0x00000080
 #define TS_8		0x00000010
 #define TS_16		0x00000020
 #define TS_32		0x00000030
-- 
1.6.1.3

