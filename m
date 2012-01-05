From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Jan 2012 05:41:06 +0000
Subject: [RFC][PATCH 1/3] dmaengine: shdma: add .no_error_irq flag
Message-Id: <4F0537F2.4080306@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
So, this patch adds the .no_error_irq flag.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/dma/shdma.c    |   50 ++++++++++++++++++++++++++---------------------
 include/linux/sh_dma.h |    1 +
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 81809c2..97f7d24 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1151,7 +1151,7 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
-	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
+	int errirq = 0, chan_irq[SH_DMAC_MAX_CHANNELS];
 	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
 	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
@@ -1259,26 +1259,31 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;

 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-
-	if (!chanirq_res)
+	if (pdata->no_error_irq) {
 		chanirq_res = errirq_res;
-	else
-		irqres++;
-
-	if (chanirq_res = errirq_res ||
-	    (errirq_res->flags & IORESOURCE_BITS) = IORESOURCE_IRQ_SHAREABLE)
-		irqflags = IRQF_SHARED;
-
-	errirq = errirq_res->start;
-
-	err = request_irq(errirq, sh_dmae_err, irqflags,
-			  "DMAC Address Error", shdev);
-	if (err) {
-		dev_err(&pdev->dev,
-			"DMA failed requesting irq #%d, error %d\n",
-			errirq, err);
-		goto eirq_err;
+	} else {
+		chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+
+		if (!chanirq_res)
+			chanirq_res = errirq_res;
+		else
+			irqres++;
+
+		if (chanirq_res = errirq_res ||
+		    (errirq_res->flags & IORESOURCE_BITS) =
+		    IORESOURCE_IRQ_SHAREABLE)
+			irqflags = IRQF_SHARED;
+
+		errirq = errirq_res->start;
+
+		err = request_irq(errirq, sh_dmae_err, irqflags,
+				  "DMAC Address Error", shdev);
+		if (err) {
+			dev_err(&pdev->dev,
+				"DMA failed requesting irq #%d, error %d\n",
+				errirq, err);
+			goto eirq_err;
+		}
 	}

 #else
@@ -1346,7 +1351,8 @@ chan_probe_err:
 	sh_dmae_chan_remove(shdev);

 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	free_irq(errirq, shdev);
+	if (!pdata->no_error_irq)
+		free_irq(errirq, shdev);
 eirq_err:
 #endif
 rst_err:
@@ -1383,7 +1389,7 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)

 	dma_async_device_unregister(&shdev->common);

-	if (errirq > 0)
+	if (!shdev->pdata->no_error_irq && errirq > 0)
 		free_irq(errirq, shdev);

 	spin_lock_irq(&sh_dmae_lock);
diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
index cb2dd11..b638f42 100644
--- a/include/linux/sh_dma.h
+++ b/include/linux/sh_dma.h
@@ -68,6 +68,7 @@ struct sh_dmae_pdata {
 	unsigned int dmaor_is_32bit:1;
 	unsigned int needs_tend_set:1;
 	unsigned int no_dmars:1;
+	unsigned int no_error_irq:1;
 };

 /* DMA register */
-- 
1.7.1
