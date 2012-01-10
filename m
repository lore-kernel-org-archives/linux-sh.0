From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 05:20:16 +0000
Subject: [PATCH v2 1/3] dmaengine: shdma: modify the DMAC Address Error
Message-Id: <4F0BCA90.3050508@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The USB-DMAC/SUDMAC don't have the interrupt of DMAC Address Error.
So, only when the resource has a name and it is "error_irq", the driver
calls request_irq() for DMAC Address Error.

This patch is also useful for the generic DMAC which doesn't have
DMAC Address Error. So, we can get rid of the "CPU_SH4 || ARCH_SHMOBILE"
ifdefs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - use a resource name for the registration.
  - rid of the "CPU_SH4 || ARCH_SHMOBILE" ifdefs.

 drivers/dma/shdma.c |   74 ++++++++++++++++++++++++++------------------------
 1 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 81809c2..4fff02b 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1151,10 +1151,10 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 	unsigned long irqflags = IRQF_DISABLED,
 		chan_flag[SH_DMAC_MAX_CHANNELS] = {};
-	int errirq, chan_irq[SH_DMAC_MAX_CHANNELS];
+	int errirq = 0, chan_irq[SH_DMAC_MAX_CHANNELS];
 	int err, i, irq_cnt = 0, irqres = 0, irq_cap = 0;
 	struct sh_dmae_device *shdev;
-	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
+	struct resource *chan, *dmars, *errirq_res, *irq_res, *chanirq_res;

 	/* get platform data */
 	if (!pdata || !pdata->channel_num)
@@ -1179,8 +1179,8 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	 *    specify IORESOURCE_IRQ_SHAREABLE in their resources, they will be
 	 *    requested with the IRQF_SHARED flag
 	 */
-	errirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!chan || !errirq_res)
+	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!chan || !irq_res)
 		return -ENODEV;

 	if (!request_mem_region(chan->start, resource_size(chan), pdev->name)) {
@@ -1258,33 +1258,35 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
 	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;

-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
-
-	if (!chanirq_res)
-		chanirq_res = errirq_res;
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
+	errirq_res = platform_get_resource_byname(pdev, IORESOURCE_IRQ,
+						  "error_irq");
+	if (errirq_res) {
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
+	} else {
+		chanirq_res = irq_res;
 	}

-#else
-	chanirq_res = errirq_res;
-#endif /* CONFIG_CPU_SH4 || CONFIG_ARCH_SHMOBILE */
-
 	if (chanirq_res->start = chanirq_res->end &&
 	    !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
 		/* Special case - all multiplexed */
@@ -1305,7 +1307,7 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 					break;
 				}

-				if ((errirq_res->flags & IORESOURCE_BITS) =
+				if ((irq_res->flags & IORESOURCE_BITS) =
 				    IORESOURCE_IRQ_SHAREABLE)
 					chan_flag[irq_cnt] = IRQF_SHARED;
 				else
@@ -1345,10 +1347,9 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 chan_probe_err:
 	sh_dmae_chan_remove(shdev);

-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
-	free_irq(errirq, shdev);
+	if (errirq_res)
+		free_irq(errirq, shdev);
 eirq_err:
-#endif
 rst_err:
 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
@@ -1379,12 +1380,13 @@ static int __exit sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct resource *res;
-	int errirq = platform_get_irq(pdev, 0);
+	struct resource *errirq_res = platform_get_resource_byname(pdev,
+						IORESOURCE_IRQ, "error_irq");

 	dma_async_device_unregister(&shdev->common);

-	if (errirq > 0)
-		free_irq(errirq, shdev);
+	if (errirq_res)
+		free_irq(errirq_res->start, shdev);

 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
-- 
1.7.1
