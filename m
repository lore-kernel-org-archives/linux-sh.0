From: afzal mohammed <afzal.mohd.ma@gmail.com>
Date: Fri, 27 Mar 2020 16:22:24 +0000
Subject: [PATCH v5 4/6] sh: replace setup_irq() by request_irq()
Message-Id: <b060312689820559121ee0a6456bbc1202fb7ee5.1585320721.git.afzal.mohd.ma@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200321174303.GA7930@afzalpc>
 <cover.1585320721.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <cover.1585320721.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

request_irq() is preferred over setup_irq(). Invocations of setup_irq()
occur after memory allocators are ready.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Link to v3, v2 & v1,
[v3] https://lkml.kernel.org/r/20200304005120.5403-1-afzal.mohd.ma@gmail.com
[v2] https://lkml.kernel.org/r/cover.1582471508.git.afzal.mohd.ma@gmail.com
[v1] https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

v5:
 * No change
v4:
 * Non-existent
v3:
 * Split out from tree wide series, as Thomas suggested to get it thr'
	respective maintainers
 * Modify pr_err displayed in case of error
 * Re-arrange code & choose pr_err args as required to improve readability
 * Remove irrelevant parts from commit message & improve
 
v2:
 * Replace pr_err("request_irq() on %s failed" by
           pr_err("%s: request_irq() failed"
 * Commit message massage

 arch/sh/boards/mach-cayman/irq.c | 18 ++++++------------
 arch/sh/drivers/dma/dma-pvr2.c   |  9 +++------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index 3b6ea2d99013..0305d0b51730 100644
--- a/arch/sh/boards/mach-cayman/irq.c
+++ b/arch/sh/boards/mach-cayman/irq.c
@@ -40,16 +40,6 @@ static irqreturn_t cayman_interrupt_pci2(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static struct irqaction cayman_action_smsc = {
-	.name		= "Cayman SMSC Mux",
-	.handler	= cayman_interrupt_smsc,
-};
-
-static struct irqaction cayman_action_pci2 = {
-	.name		= "Cayman PCI2 Mux",
-	.handler	= cayman_interrupt_pci2,
-};
-
 static void enable_cayman_irq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
@@ -149,6 +139,10 @@ void init_cayman_irq(void)
 	}
 
 	/* Setup the SMSC interrupt */
-	setup_irq(SMSC_IRQ, &cayman_action_smsc);
-	setup_irq(PCI2_IRQ, &cayman_action_pci2);
+	if (request_irq(SMSC_IRQ, cayman_interrupt_smsc, 0, "Cayman SMSC Mux",
+			NULL))
+		pr_err("Failed to register Cayman SMSC Mux interrupt\n");
+	if (request_irq(PCI2_IRQ, cayman_interrupt_pci2, 0, "Cayman PCI2 Mux",
+			NULL))
+		pr_err("Failed to register Cayman PCI2 Mux interrupt\n");
 }
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index b5dbd1f75768..21c347543e19 100644
--- a/arch/sh/drivers/dma/dma-pvr2.c
+++ b/arch/sh/drivers/dma/dma-pvr2.c
@@ -64,11 +64,6 @@ static int pvr2_xfer_dma(struct dma_channel *chan)
 	return 0;
 }
 
-static struct irqaction pvr2_dma_irq = {
-	.name		= "pvr2 DMA handler",
-	.handler	= pvr2_dma_interrupt,
-};
-
 static struct dma_ops pvr2_dma_ops = {
 	.request	= pvr2_request_dma,
 	.get_residue	= pvr2_get_dma_residue,
@@ -84,7 +79,9 @@ static struct dma_info pvr2_dma_info = {
 
 static int __init pvr2_dma_init(void)
 {
-	setup_irq(HW_EVENT_PVR2_DMA, &pvr2_dma_irq);
+	if (request_irq(HW_EVENT_PVR2_DMA, pvr2_dma_interrupt, 0,
+			"pvr2 DMA handler", NULL))
+		pr_err("Failed to register pvr2 DMA handler interrupt\n");
 	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade");
 
 	return register_dmac(&pvr2_dma_info);
-- 
2.25.1
