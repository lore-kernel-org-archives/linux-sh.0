From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 07 Jan 2011 02:58:16 +0000
Subject: [PATCH 4/5] sh: intc - convert board specific landisk code
Message-Id: <1294369335-4064-4-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Nobuhiro Iwamatsu <iwamatsu@nigarui.org>

This converts the board specific interrupt code for landisk to make
use of intc (use register_intc_controller).

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigarui.org>
---
 arch/sh/boards/mach-landisk/irq.c |   59 ++++++++++++++++++++++---------------
 1 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/sh/boards/mach-landisk/irq.c b/arch/sh/boards/mach-landisk/irq.c
index e79412a..c00ace3 100644
--- a/arch/sh/boards/mach-landisk/irq.c
+++ b/arch/sh/boards/mach-landisk/irq.c
@@ -1,9 +1,10 @@
 /*
- * arch/sh/boards/landisk/irq.c
+ * arch/sh/boards/mach-landisk/irq.c
  *
  * I-O DATA Device, Inc. LANDISK Support
  *
  * Copyright (C) 2005-2007 kogiidena
+ * Copyright (C) 2011 Nobuhiro Iwamatsu
  *
  * Copyright (C) 2001  Ian da Silva, Jeremy Siegel
  * Based largely on io_se.c.
@@ -12,44 +13,54 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <mach-landisk/mach/iodata_landisk.h>
 
-static void disable_landisk_irq(struct irq_data *data)
-{
-	unsigned char mask = 0xff ^ (0x01 << (data->irq - 5));
+enum {
+	UNUSED = 0,
 
-	__raw_writeb(__raw_readb(PA_IMASK) & mask, PA_IMASK);
-}
-
-static void enable_landisk_irq(struct irq_data *data)
-{
-	unsigned char value = (0x01 << (data->irq - 5));
+	PCI_INTA, /* PCI int A */
+	PCI_INTB, /* PCI int B */
+	PCI_INTC, /* PCI int C */
+	PCI_INTD, /* PCI int D */
+	ATA,	  /* ATA */
+	FATA,	  /* CF */
+	POWER,	  /* Power swtich */
+	BUTTON,	  /* Button swtich */
+};
 
-	__raw_writeb(__raw_readb(PA_IMASK) | value, PA_IMASK);
-}
+/* Vectors for LANDISK */
+static struct intc_vect vectors_landisk[] __initdata = {
+	INTC_IRQ(PCI_INTA, IRQ_PCIINTA),
+	INTC_IRQ(PCI_INTB, IRQ_PCIINTB),
+	INTC_IRQ(PCI_INTC, IRQ_PCIINTC),
+	INTC_IRQ(PCI_INTD, IRQ_PCIINTD),
+	INTC_IRQ(ATA, IRQ_ATA),
+	INTC_IRQ(FATA, IRQ_FATA),
+	INTC_IRQ(POWER, IRQ_POWER),
+	INTC_IRQ(BUTTON, IRQ_BUTTON),
+};
 
-static struct irq_chip landisk_irq_chip __read_mostly = {
-	.name		= "LANDISK",
-	.irq_mask	= disable_landisk_irq,
-	.irq_unmask	= enable_landisk_irq,
+/* IRLMSK mask register layout for LANDISK */
+static struct intc_mask_reg mask_registers_landisk[] __initdata = {
+	{ PA_IMASK, 0, 8, /* IRLMSK */
+	  {  BUTTON, POWER, FATA, ATA,
+	     PCI_INTD, PCI_INTC, PCI_INTB, PCI_INTA,
+	  }
+	},
 };
 
+static DECLARE_INTC_DESC(intc_desc_landisk, "landisk", vectors_landisk, NULL,
+			mask_registers_landisk, NULL, NULL);
 /*
  * Initialize IRQ setting
  */
 void __init init_landisk_IRQ(void)
 {
-	int i;
-
-	for (i = 5; i < 14; i++) {
-		disable_irq_nosync(i);
-		set_irq_chip_and_handler_name(i, &landisk_irq_chip,
-					      handle_level_irq, "level");
-		enable_landisk_irq(irq_get_irq_data(i));
-	}
+	register_intc_controller(&intc_desc_landisk);
 	__raw_writeb(0x00, PA_PWRINT_CLR);
 }
-- 
1.7.2.3

