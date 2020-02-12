From: afzal mohammed <afzal.mohd.ma@gmail.com>
Date: Wed, 12 Feb 2020 08:16:48 +0000
Subject: [PATCH 12/18] sh: replace setup_irq() by request_irq()
Message-Id: <557ac61def897b99d1c21164ad422a67a68003aa.1581478324.git.afzal.mohd.ma@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
In-Reply-To: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>

request_irq() is preferred over setup_irq(). Existing callers of
setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
memory allocators are ready by 'mm_init()'.

Per tglx[1], setup_irq() existed in olden days when allocators were not
ready by the time early interrupts were initialized.

Hence replace setup_irq() by request_irq().

Seldom remove_irq() usage has been observed coupled with setup_irq(),
wherever that has been found, it too has been replaced by free_irq().

[1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos

Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
---

Since cc'ing cover letter to all maintainers/reviewers would be too
many, refer for cover letter,
 https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com

 arch/sh/boards/mach-cayman/irq.c | 18 ++++++------------
 arch/sh/drivers/dma/dma-pvr2.c   |  9 +++------
 2 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/irq.c
index 3b6ea2d99013..de65b15206a2 100644
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
+		pr_err("request_irq() on %s failed\n", "Cayman SMSC Mux");
+	if (request_irq(PCI2_IRQ, cayman_interrupt_pci2, 0, "Cayman PCI2 Mux",
+			NULL))
+		pr_err("request_irq() on %s failed\n", "Cayman PCI2 Mux");
 }
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.c
index b5dbd1f75768..171348016995 100644
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
+		pr_err("request_irq() on %s failed\n", "pvr2 DMA handler");
 	request_dma(PVR2_CASCADE_CHAN, "pvr2 cascade");
 
 	return register_dmac(&pvr2_dma_info);
-- 
2.24.1
