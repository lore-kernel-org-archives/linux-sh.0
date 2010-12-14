From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 06:57:10 +0000
Subject: Re: sh: sh7723/7724 nmi: nmi stops DMA transfers
Message-Id: <20101214065710.GA6694@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 13, 2010 at 07:28:41PM +0900, Paul Mundt wrote:
> On Mon, Dec 13, 2010 at 10:19:54AM +0100, Szafranek, Michael wrote:
> > I've got a patch that fixes a problem when a NMI occurs which stops DMA
> > transfers. The code in the patch resumes the DMA transfers. But it does
> > not look like the proper place to solve this problem. If you could give
> > me a hint were to move the code.
...

> Simply register a die notifier in the DMA driver and take care of this
> there.

Ok, so it turned out to be a bit more work than I expected, but here's a
trivial proof of concept that ought to work for both SH and ARM:

---

 drivers/dma/shdma.c |  129 ++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/dma/shdma.h |    1 
 2 files changed, 112 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 85ffd5e..89cce17 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -27,7 +27,10 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
-
+#include <linux/notifier.h>
+#include <linux/kdebug.h>
+#include <linux/spinlock.h>
+#include <linux/rculist.h>
 #include "shdma.h"
 
 /* DMA descriptor control */
@@ -43,6 +46,13 @@ enum sh_dmae_desc_status {
 /* Default MEMCPY transfer size = 2^2 = 4 bytes */
 #define LOG2_DEFAULT_XFER_SIZE	2
 
+/*
+ * Used for write-side mutual exclusion for the global device list,
+ * read-side synchronization by way of RCU.
+ */
+static DEFINE_SPINLOCK(sh_dmae_lock);
+static LIST_HEAD(sh_dmae_devices);
+
 /* A bitmask with bits enough for enum sh_dmae_slave_chan_id */
 static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SH_DMA_SLAVE_NUMBER)];
 
@@ -817,10 +827,9 @@ static irqreturn_t sh_dmae_interrupt(int irq, void *data)
 	return ret;
 }
 
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-static irqreturn_t sh_dmae_err(int irq, void *data)
+static unsigned int sh_dmae_reset(struct sh_dmae_device *shdev)
 {
-	struct sh_dmae_device *shdev = (struct sh_dmae_device *)data;
+	unsigned int handled = 0;
 	int i;
 
 	/* halt the dma controller */
@@ -829,25 +838,35 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 	/* We cannot detect, which channel caused the error, have to reset all */
 	for (i = 0; i < SH_DMAC_MAX_CHANNELS; i++) {
 		struct sh_dmae_chan *sh_chan = shdev->chan[i];
-		if (sh_chan) {
-			struct sh_desc *desc;
-			/* Stop the channel */
-			dmae_halt(sh_chan);
-			/* Complete all  */
-			list_for_each_entry(desc, &sh_chan->ld_queue, node) {
-				struct dma_async_tx_descriptor *tx = &desc->async_tx;
-				desc->mark = DESC_IDLE;
-				if (tx->callback)
-					tx->callback(tx->callback_param);
-			}
-			list_splice_init(&sh_chan->ld_queue, &sh_chan->ld_free);
+		struct sh_desc *desc;
+
+		if (!sh_chan)
+			continue;
+
+		/* Stop the channel */
+		dmae_halt(sh_chan);
+
+		/* Complete all  */
+		list_for_each_entry(desc, &sh_chan->ld_queue, node) {
+			struct dma_async_tx_descriptor *tx = &desc->async_tx;
+			desc->mark = DESC_IDLE;
+			if (tx->callback)
+				tx->callback(tx->callback_param);
 		}
+
+		list_splice_init(&sh_chan->ld_queue, &sh_chan->ld_free);
+		handled++;
 	}
+
 	sh_dmae_rst(shdev);
 
-	return IRQ_HANDLED;
+	return !!handled;
+}
+
+static irqreturn_t sh_dmae_err(int irq, void *data)
+{
+	return IRQ_RETVAL(sh_dmae_reset(data));
 }
-#endif
 
 static void dmae_do_tasklet(unsigned long data)
 {
@@ -876,6 +895,57 @@ static void dmae_do_tasklet(unsigned long data)
 	sh_dmae_chan_ld_cleanup(sh_chan, false);
 }
 
+static bool sh_dmae_nmi_notify(struct sh_dmae_device *shdev)
+{
+	unsigned int handled;
+
+	/* Fast path out if NMIF is not asserted for this controller */
+	if ((dmaor_read(shdev) & DMAOR_NMIF) = 0)
+		return false;
+
+	handled = sh_dmae_reset(shdev);
+	if (handled)
+		return true;
+
+	return false;
+}
+
+static int sh_dmae_nmi_handler(struct notifier_block *self,
+			       unsigned long cmd, void *data)
+{
+	struct sh_dmae_device *shdev;
+	int ret = NOTIFY_DONE;
+	bool triggered;
+
+	/*
+	 * Only concern ourselves with NMI events.
+	 *
+	 * Normally we would check the die chain value, but as this needs
+	 * to be architecture independent, check for NMI context instead.
+	 */
+	if (!in_nmi())
+		return NOTIFY_DONE;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(shdev, &sh_dmae_devices, node) {
+		/*
+		 * Only stop if one of the controllers has NMIF asserted,
+		 * we do not want to interfere with regular address error
+		 * handling or NMI events that don't concern the DMACs.
+		 */
+		triggered = sh_dmae_nmi_notify(shdev);
+		if (triggered = true)
+			ret = NOTIFY_STOP;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static struct notifier_block sh_dmae_nmi_notifier __read_mostly = {
+	.notifier_call		= sh_dmae_nmi_handler,
+};
+
 static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 					int irq, unsigned long flags)
 {
@@ -967,6 +1037,7 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
+	unsigned long flags;
 	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
 	int err, i, irq_cnt = 0, irqres = 0;
 	struct sh_dmae_device *shdev;
@@ -1032,6 +1103,15 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
+	spin_lock_irqsave(&sh_dmae_lock, flags);
+	list_add_tail_rcu(&shdev->node, &sh_dmae_devices);
+	spin_unlock_irqrestore(&sh_dmae_lock, flags);
+
+	/* Wire up NMI handling before bringing the controller online */
+	err = register_die_notifier(&sh_dmae_nmi_notifier);
+	if (err)
+		goto notifier_err;
+
 	/* reset dma controller */
 	err = sh_dmae_rst(shdev);
 	if (err)
@@ -1135,6 +1215,12 @@ eirqres:
 eirq_err:
 #endif
 rst_err:
+	unregister_die_notifier(&sh_dmae_nmi_notifier);
+notifier_err:
+	spin_lock_irqsave(&sh_dmae_lock, flags);
+	list_del_rcu(&shdev->node);
+	spin_unlock_irqrestore(&sh_dmae_lock, flags);
+
 	pm_runtime_put(&pdev->dev);
 	if (dmars)
 		iounmap(shdev->dmars);
@@ -1155,6 +1241,7 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct resource *res;
+	unsigned long flags;
 	int errirq = platform_get_irq(pdev, 0);
 
 	dma_async_device_unregister(&shdev->common);
@@ -1162,6 +1249,12 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 	if (errirq > 0)
 		free_irq(errirq, shdev);
 
+	unregister_die_notifier(&sh_dmae_nmi_notifier);
+
+	spin_lock_irqsave(&sh_dmae_lock, flags);
+	list_del_rcu(&shdev->node);
+	spin_unlock_irqrestore(&sh_dmae_lock, flags);
+
 	/* channel data remove */
 	sh_dmae_chan_remove(shdev);
 
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 4021275..52e4fb1 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -43,6 +43,7 @@ struct sh_dmae_device {
 	struct dma_device common;
 	struct sh_dmae_chan *chan[SH_DMAC_MAX_CHANNELS];
 	struct sh_dmae_pdata *pdata;
+	struct list_head node;
 	u32 __iomem *chan_reg;
 	u16 __iomem *dmars;
 };
