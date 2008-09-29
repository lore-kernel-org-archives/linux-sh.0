From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Mon, 29 Sep 2008 09:26:45 +0000
Subject: [RFC][PATCH] sh: override DMA interrupt handler to dma-sh driver
Message-Id: <48E09F55.4030406@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dma-sh has fixed interrupt handler and cannot register
an interrupt for exclusive use of the device with dma.

I added a handler to sh_dmac_request_dma and reviced it
to be able to appoint a handler.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@nigauri.org>
---
 arch/sh/drivers/dma/Kconfig       |    2 +-
 arch/sh/drivers/dma/dma-api.c     |   63 +++++++++++++++++++++++++-----------
 arch/sh/drivers/dma/dma-pvr2.c    |    2 +-
 arch/sh/drivers/dma/dma-sh.c      |   38 ++++++++++++----------
 arch/sh/drivers/dma/dma-sh.h      |   46 +++++++++++++++++++--------
 arch/sh/drivers/dma/dmabrg.c      |    2 +-
 arch/sh/include/asm/dma.h         |   36 +++++++++++++++++---
 arch/sh/include/cpu-sh4/cpu/dma.h |    9 +++++-
 8 files changed, 137 insertions(+), 61 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index 0193636..0c4ee21 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -12,7 +12,7 @@ config SH_DMA
 config NR_ONCHIP_DMA_CHANNELS
 	int
 	depends on SH_DMA
-	default "6" if CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721
+	default "6" if CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721 || CPU_SUBTYPE_SH7763
 	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R
 	default "12" if CPU_SUBTYPE_SH7780
 	default "4"
diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 727126e..27831a1 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -126,7 +126,8 @@ static int search_cap(const char **haystack, const char *needle)
  * case they can never be allocated using this API, and so
  * request_dma() must be used specifying the channel number.
  */
-int request_dma_bycap(const char **dmac, const char **caps, const char *dev_id)
+int request_dma_bycap(const char **dmac, const char **caps,
+	const char *dev_id, irq_handler_t handler, void *data)
 {
 	unsigned int found = 0;
 	struct dma_info *info;
@@ -135,6 +136,9 @@ int request_dma_bycap(const char **dmac, const char **caps, const char *dev_id)

 	BUG_ON(!dmac || !caps);

+	if(!handler||!data)
+		return -EINVAL;
+
 	list_for_each_entry(info, &registered_dmac_list, list)
 		if (strcmp(*dmac, info->name) = 0) {
 			found = 1;
@@ -149,20 +153,19 @@ int request_dma_bycap(const char **dmac, const char **caps, const char *dev_id)

 		if (unlikely(!channel->caps))
 			continue;
-
 		for (p = caps; *p; p++) {
 			if (!search_cap(channel->caps, *p))
 				break;
-			if (request_dma(channel->chan, dev_id) = 0)
+
+			if (request_dma(channel->chan, dev_id, handler, data) = 0)
 				return channel->chan;
 		}
 	}
-
 	return -EINVAL;
 }
 EXPORT_SYMBOL(request_dma_bycap);

-int dmac_search_free_channel(const char *dev_id)
+int dmac_search_free_channel(void)
 {
 	struct dma_channel *channel = { 0 };
 	struct dma_info *info = get_dma_info(0);
@@ -177,32 +180,26 @@ int dmac_search_free_channel(const char *dev_id)
 			break;
 	}

-	if (info->ops->request) {
-		int result = info->ops->request(channel);
-		if (result)
-			return result;
-
-		atomic_set(&channel->busy, 1);
-		return channel->chan;
-	}
-
-	return -ENOSYS;
+	return channel->chan;
 }
+EXPORT_SYMBOL(dmac_search_free_channel);

-int request_dma(unsigned int chan, const char *dev_id)
+int request_dma(unsigned int chan, const char *dev_id,
+	irq_handler_t handler, void *data)
 {
 	struct dma_channel *channel = { 0 };
 	struct dma_info *info = get_dma_info(chan);
 	int result;

 	channel = get_dma_channel(chan);
+
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;

 	strlcpy(channel->dev_id, dev_id, sizeof(channel->dev_id));

 	if (info->ops->request) {
-		result = info->ops->request(channel);
+		result = info->ops->request(channel, handler, data);
 		if (result)
 			atomic_set(&channel->busy, 0);

@@ -213,13 +210,13 @@ int request_dma(unsigned int chan, const char *dev_id)
 }
 EXPORT_SYMBOL(request_dma);

-void free_dma(unsigned int chan)
+void free_dma(unsigned int chan, void *data)
 {
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);

 	if (info->ops->free)
-		info->ops->free(channel);
+		info->ops->free(channel, data);

 	atomic_set(&channel->busy, 0);
 }
@@ -295,6 +292,34 @@ int dma_xfer(unsigned int chan, unsigned long from,
 }
 EXPORT_SYMBOL(dma_xfer);

+int dma_start(unsigned int chan)
+{
+	struct dma_info *info = get_dma_info(chan);
+	struct dma_channel *channel = get_dma_channel(chan);
+	
+	if( info->ops->start ) {
+		info->ops->start(channel);
+		return 0;
+	}
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(dma_start);
+
+int dma_stop(unsigned int chan)
+{
+	struct dma_info *info = get_dma_info(chan);
+	struct dma_channel *channel = get_dma_channel(chan);
+
+	if( info->ops->stop ){
+		info->ops->stop(channel);
+		return 0;
+	}
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL(dma_stop);
+
 int dma_extend(unsigned int chan, unsigned long op, void *param)
 {
 	struct dma_info *info = get_dma_info(chan);
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index 391cbe1..2016e88 100644
--- a/arch/sh/drivers/dma/dma-pvr2.c
+++ b/arch/sh/drivers/dma/dma-pvr2.c
@@ -89,7 +89,7 @@ static struct dma_info pvr2_dma_info = {
 static int __init pvr2_dma_init(void)
 {
 	setup_irq(HW_EVENT_PVR2_DMA, &pvr2_dma_irq);
-	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade");
+	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade",NULL, NULL);

 	return register_dmac(&pvr2_dma_info);
 }
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index b2ffe64..69cb807 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -28,6 +28,7 @@ static int dmte_irq_map[] = {
     defined(CONFIG_CPU_SUBTYPE_SH7721)  ||	\
     defined(CONFIG_CPU_SUBTYPE_SH7751R) ||	\
     defined(CONFIG_CPU_SUBTYPE_SH7760)  ||	\
+    defined(CONFIG_CPU_SUBTYPE_SH7763)  ||	\
     defined(CONFIG_CPU_SUBTYPE_SH7709)  ||	\
     defined(CONFIG_CPU_SUBTYPE_SH7780)
 	DMTE4_IRQ,
@@ -88,18 +89,25 @@ static irqreturn_t dma_tei(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }

-static int sh_dmac_request_dma(struct dma_channel *chan)
+static int sh_dmac_request_dma(struct dma_channel *chan, irq_handler_t handler, void *data)
 {
 	if (unlikely(!(chan->flags & DMA_TEI_CAPABLE)))
 		return 0;

+	if (handler)
+		return request_irq(get_dmte_irq(chan->chan), handler,
+			IRQF_DISABLED, chan->dev_id, data);
+
 	return request_irq(get_dmte_irq(chan->chan), dma_tei,
-			   IRQF_DISABLED, chan->dev_id, chan);
+			IRQF_DISABLED, chan->dev_id, chan);
 }

-static void sh_dmac_free_dma(struct dma_channel *chan)
+static void sh_dmac_free_dma(struct dma_channel *chan, void *data)
 {
-	free_irq(get_dmte_irq(chan->chan), chan);
+	if (data)
+		free_irq(get_dmte_irq(chan->chan), data);
+	else
+		free_irq(get_dmte_irq(chan->chan), chan);
 }

 static int
@@ -116,17 +124,14 @@ sh_dmac_configure_channel(struct dma_channel *chan, unsigned long chcr)
 	}

 	ctrl_outl(chcr, CHCR[chan->chan]);
-
 	chan->flags |= DMA_CONFIGURED;
 	return 0;
 }

 static void sh_dmac_enable_dma(struct dma_channel *chan)
 {
-	int irq;
-	u32 chcr;
+	u32 chcr= ctrl_inl(CHCR[chan->chan]);

-	chcr = ctrl_inl(CHCR[chan->chan]);
 	chcr |= CHCR_DE;

 	if (chan->flags & DMA_TEI_CAPABLE)
@@ -134,21 +139,15 @@ static void sh_dmac_enable_dma(struct dma_channel *chan)

 	ctrl_outl(chcr, CHCR[chan->chan]);

-	if (chan->flags & DMA_TEI_CAPABLE) {
-		irq = get_dmte_irq(chan->chan);
-		enable_irq(irq);
-	}
+	if (chan->flags & DMA_TEI_CAPABLE)
+		enable_irq(get_dmte_irq(chan->chan));
 }

 static void sh_dmac_disable_dma(struct dma_channel *chan)
 {
-	int irq;
 	u32 chcr;
-
-	if (chan->flags & DMA_TEI_CAPABLE) {
-		irq = get_dmte_irq(chan->chan);
-		disable_irq(irq);
-	}
+	if (chan->flags & DMA_TEI_CAPABLE)
+		disable_irq(get_dmte_irq(chan->chan));

 	chcr = ctrl_inl(CHCR[chan->chan]);
 	chcr &= ~(CHCR_DE | CHCR_TE | CHCR_IE);
@@ -205,6 +204,7 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)

 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7763) || \
     defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define dmaor_read_reg()	ctrl_inw(DMAOR)
 #define dmaor_write_reg(data)	ctrl_outw(data, DMAOR)
@@ -249,6 +249,8 @@ static struct dma_ops sh_dmac_ops = {
 	.get_residue	= sh_dmac_get_dma_residue,
 	.xfer		= sh_dmac_xfer_dma,
 	.configure	= sh_dmac_configure_channel,
+	.start = sh_dmac_enable_dma,
+	.stop = sh_dmac_disable_dma,
 };

 static struct dma_info sh_dmac_info = {
diff --git a/arch/sh/drivers/dma/dma-sh.h b/arch/sh/drivers/dma/dma-sh.h
index b05af34..6cb8269 100644
--- a/arch/sh/drivers/dma/dma-sh.h
+++ b/arch/sh/drivers/dma/dma-sh.h
@@ -28,10 +28,21 @@
 #define SM_DEC	0x00002000
 #define RS_IN	0x00000200
 #define RS_OUT	0x00000300
+#define RS_EXT	0x00000000
+#define RS_AUTO 0x00000400
+#define RS_MOD	0x00000800
 #define TS_BLK	0x00000040
+#define TB_E	0x00000020
 #define CHCR_DE 0x00000001
 #define CHCR_TE 0x00000002
 #define CHCR_IE 0x00000004
+/* Reload / Repert Mode */
+#define RPT_ALL	0x01000000
+#define RPT_DAR	0x02000000
+#define RPT_SAR	0x03000000
+#define RLD_ALL	0x05000000
+#define RLD_DAR	0x06000000
+#define RLD_SAR	0x07000000

 /* DMAOR definitions */
 #define DMAOR_AE	0x00000004
@@ -42,7 +53,7 @@
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
  */
-#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_32)
+#define RS_DUAL	(DM_INC | SM_INC | RS_AUTO | TS_32)

 #define MAX_DMAC_CHANNELS	(CONFIG_NR_ONCHIP_DMA_CHANNELS)

@@ -55,20 +66,27 @@
  * basic calculation, unfortunately on other subtypes these are more
  * scattered, so we just leave it unrolled for simplicity.
  */
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
+#define SAR ((unsigned long[]){SH_DMAC_BASE + 0x00, SH_DMAC_BASE + 0x10, \
+					SH_DMAC_BASE + 0x20, SH_DMAC_BASE + 0x30, \
+					SH_DMAC_BASE + 0x50, SH_DMAC_BASE + 0x60})

-#define DMAOR	(SH_DMAC_BASE + 0x40)
+#define DAR ((unsigned long[]){SH_DMAC_BASE + 0x04, SH_DMAC_BASE + 0x14, \
+					SH_DMAC_BASE + 0x24, SH_DMAC_BASE + 0x34, \
+					SH_DMAC_BASE + 0x54, SH_DMAC_BASE + 0x64})
+
+#define DMATCR ((unsigned long[]){SH_DMAC_BASE + 0x08, SH_DMAC_BASE + 0x18, \
+					SH_DMAC_BASE + 0x28, SH_DMAC_BASE + 0x38, \
+					SH_DMAC_BASE + 0x58, SH_DMAC_BASE + 0x68})
+
+#define CHCR ((unsigned long[]){SH_DMAC_BASE + 0x0c, SH_DMAC_BASE + 0x1c, \
+					SH_DMAC_BASE + 0x2c, SH_DMAC_BASE + 0x3c, \
+					SH_DMAC_BASE + 0x5c, SH_DMAC_BASE + 0x6c})
+
+#define DMAOR (SH_DMAC_BASE + 0x40)
+
+#define DMASR ((unsigned long[]){SH_DMAC_BASE + 0xFE0, SH_DMAC_BASE + 0xFE0, \
+					SH_DMAC_BASE + 0xFE4, SH_DMAC_BASE + 0xFE4, \
+					SH_DMAC_BASE + 0xFE8, SH_DMAC_BASE + 0xFE8})

 #endif /* __DMA_SH_H */

diff --git a/arch/sh/drivers/dma/dmabrg.c b/arch/sh/drivers/dma/dmabrg.c
index 5e22689..38c3edc 100644
--- a/arch/sh/drivers/dma/dmabrg.c
+++ b/arch/sh/drivers/dma/dmabrg.c
@@ -160,7 +160,7 @@ static int __init dmabrg_init(void)

 #ifdef CONFIG_SH_DMA
 	/* request DMAC channel 0 before anyone else can get it */
-	ret = request_dma(0, "DMAC 0 (DMABRG)");
+	ret = request_dma(0, "DMAC 0 (DMABRG)", NULL, NULL);
 	if (ret < 0)
 		printk(KERN_INFO "DMABRG: DMAC ch0 not reserved!\n");
 #endif
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index beca712..e29fbd2 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -1,5 +1,5 @@
 /*
- * include/asm-sh/dma.h
+ * arch/sh/include/asm/dma.h
  *
  * Copyright (C) 2003, 2004  Paul Mundt
  *
@@ -13,6 +13,7 @@

 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/sysdev.h>
 #include <cpu/dma.h>
@@ -67,13 +68,16 @@ extern spinlock_t dma_spin_lock;
 struct dma_channel;

 struct dma_ops {
-	int (*request)(struct dma_channel *chan);
-	void (*free)(struct dma_channel *chan);
+	int (*request)(struct dma_channel *chan, irq_handler_t handler,
+						void *data);
+	void (*free)(struct dma_channel *chan, void *data);

 	int (*get_residue)(struct dma_channel *chan);
 	int (*xfer)(struct dma_channel *chan);
 	int (*configure)(struct dma_channel *chan, unsigned long flags);
 	int (*extend)(struct dma_channel *chan, unsigned long op, void *param);
+	void (*start)(struct dma_channel *chan);
+	void (*stop)(struct dma_channel *chan);
 };

 struct dma_channel {
@@ -124,6 +128,21 @@ struct dma_chan_caps {
 /* arch/sh/drivers/dma/dma-api.c */
 extern int dma_xfer(unsigned int chan, unsigned long from,
 		    unsigned long to, size_t size, unsigned int mode);
+/* SAR */
+#define dma_set_sar(val, chan)	ctrl_outl(val, SAR[chan])
+#define dma_get_sar(chan)		ctrl_inl(SAR[chan])
+/* DAR */
+#define dma_set_dar(val, chan)	ctrl_outl(val, DAR[chan])
+#define dma_get_dar(chan)		ctrl_inl(DAR[chan])
+/* DMATCR */
+#define dma_set_dmatcr(val, chan) ctrl_outl(val, DMATCR[chan])
+#define dma_get_dmatcr(chan) ctrl_inl(DMATCR[chan])
+/* CHCR */
+#define dma_set_chcr(val, chan)	ctrl_outl(val, CHCR[chan])
+#define dma_get_chcr(chan)		ctrl_inl(CHCR[chan])
+/* DMASR */
+#define dma_set_dmasr(val, chan)	ctrl_outw(val, DMASR[chan])
+#define dma_get_dmasr(chan)			ctrl_inw(DMASR[chan])

 #define dma_write(chan, from, to, size)	\
 	dma_xfer(chan, from, to, size, DMA_MODE_WRITE)
@@ -135,10 +154,15 @@ extern int dma_xfer(unsigned int chan, unsigned long from,
 #define dma_read_page(chan, from, to)	\
 	dma_read(chan, from, to, PAGE_SIZE)

+extern int dma_start(unsigned int chan);
+extern int dma_stop(unsigned int chan);
+
 extern int request_dma_bycap(const char **dmac, const char **caps,
-			     const char *dev_id);
-extern int request_dma(unsigned int chan, const char *dev_id);
-extern void free_dma(unsigned int chan);
+			const char *dev_id, irq_handler_t handler, void *data);
+extern int dmac_search_free_channel(void);
+extern int request_dma(unsigned int chan, const char *dev_id,
+			irq_handler_t handler, void *data);
+extern void free_dma(unsigned int chan, void *data);
 extern int get_dma_residue(unsigned int chan);
 extern struct dma_info *get_dma_info(unsigned int chan);
 extern struct dma_channel *get_dma_channel(unsigned int chan);
diff --git a/arch/sh/include/cpu-sh4/cpu/dma.h b/arch/sh/include/cpu-sh4/cpu/dma.h
index 235b7cd..1d2bd3b 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma.h
@@ -15,7 +15,14 @@
 #define DMAE_IRQ	38

 #ifdef CONFIG_CPU_SH4A
-#define SH_DMAC_BASE	0xfc808020
+
+#if defined(CONFIG_CPU_SUBTYPE_SH7763) ||\
+	defined(CONFIG_CPU_SUBTYPE_SH7764)
+# define SH_DMAC_BASE  0xff608020
+#else
+/* SH7780/SH7785 */
+# define SH_DMAC_BASE  0xfc808020
+#endif

 #define CHCR_TS_MASK	0x18
 #define CHCR_TS_SHIFT	3
-- 
1.5.6.3

