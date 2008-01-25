From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 25 Jan 2008 07:04:29 +0000
Subject: [PATCH] sh: update r7780rp interrupt code
Message-Id: <20080125070429.23372.77848.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch updates the board specific irq code for r7780rp. The new code is
very similar to the other highlander implementations, with the exception that
the r7780rp handles pci interrupts using IRL. To simplify the pci code and
use the same interrupt numbers as r7780mp and r7785rp we hook in to the
cpu specific pci vectors.

The pci interrupts and the push switch all work well with and without this
patch. CF and AX88796 are not ok though and the source of the problem is
unknown at this point. The AX88796 does for not detect it's proper mac
address (IPL gets it right) and the kernel hangs on CF access. As a workaround
this patch removes the CF and the AX88796 from the platform datain case of
r7780rp.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/r7780rp/Makefile      |    2 -
 arch/sh/boards/renesas/r7780rp/irq-r7780rp.c |   52 ++++++++++++++++++++++++--
 arch/sh/boards/renesas/r7780rp/irq.c         |   51 -------------------------
 arch/sh/boards/renesas/r7780rp/setup.c       |   10 +++--
 arch/sh/drivers/pci/ops-r7780rp.c            |   16 +-------
 include/asm-sh/r7780rp.h                     |   19 ---------
 6 files changed, 57 insertions(+), 93 deletions(-)

--- 0001/arch/sh/boards/renesas/r7780rp/Makefile
+++ work/arch/sh/boards/renesas/r7780rp/Makefile	2008-01-25 15:29:56.000000000 +0900
@@ -3,7 +3,7 @@
 #
 irqinit-$(CONFIG_SH_R7780MP)	:= irq-r7780mp.o
 irqinit-$(CONFIG_SH_R7785RP)	:= irq-r7785rp.o
-irqinit-$(CONFIG_SH_R7780RP)	:= irq-r7780rp.o irq.o
+irqinit-$(CONFIG_SH_R7780RP)	:= irq-r7780rp.o
 obj-y				:= setup.o $(irqinit-y)
 
 ifneq ($(CONFIG_SH_R7785RP),y)
--- 0001/arch/sh/boards/renesas/r7780rp/irq-r7780rp.c
+++ work/arch/sh/boards/renesas/r7780rp/irq-r7780rp.c	2008-01-25 15:41:52.000000000 +0900
@@ -3,21 +3,65 @@
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006  Paul Mundt
+ * Copyright (C) 2008  Magnus Damm
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/io.h>
 #include <asm/r7780rp.h>
 
+enum {
+	UNUSED = 0,
+
+	/* board specific interrupt sources */
+
+	AX88796,          /* Ethernet controller */
+	PSW,              /* Push Switch */
+	CF,               /* Compact Flash */
+
+	PCI_A,
+	PCI_B,
+	PCI_C,
+	PCI_D,
+};
+
+static struct intc_vect vectors[] __initdata = {
+	INTC_IRQ(PCI_A, 65), /* dirty: overwrite cpu vectors for pci */
+	INTC_IRQ(PCI_B, 66),
+	INTC_IRQ(PCI_C, 67),
+	INTC_IRQ(PCI_D, 68),
+	INTC_IRQ(CF, IRQ_CF),
+	INTC_IRQ(PSW, IRQ_PSW),
+	INTC_IRQ(AX88796, IRQ_AX88796),
+};
+
+static struct intc_mask_reg mask_registers[] __initdata = {
+	{ 0xa5000000, 0, 16, /* IRLMSK */
+	  { PCI_A, PCI_B, PCI_C, PCI_D, CF, 0, 0, 0,
+	    0, 0, 0, 0, 0, 0, PSW, AX88796 } },
+};
+
+static unsigned char irl2irq[HL_NR_IRL] __initdata = {
+	65, 66, 67, 68,
+	IRQ_CF, 0, 0, 0,
+	0, 0, 0, 0,
+	IRQ_AX88796, IRQ_PSW
+};
+
+static DECLARE_INTC_DESC(intc_desc, "r7780rp", vectors,
+			 NULL, mask_registers, NULL, NULL);
+
 unsigned char * __init highlander_init_irq_r7780rp(void)
 {
-	int i;
-
-	for (i = 0; i < 15; i++)
-		make_r7780rp_irq(i);
+	if (ctrl_inw(0xa5000600)) {
+		printk(KERN_INFO "Using r7780rp interrupt controller.\n");
+		register_intc_controller(&intc_desc);
+		return irl2irq;
+	}
 
 	return NULL;
 }
--- 0001/arch/sh/boards/renesas/r7780rp/irq.c
+++ /dev/null	2007-12-24 23:06:17.939005730 +0900
@@ -1,51 +0,0 @@
-/*
- * Renesas Solutions Highlander R7780RP-1 Support.
- *
- * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
- * Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <asm/r7780rp.h>
-
-#ifdef CONFIG_SH_R7780RP
-static int mask_pos[] = {15, 14, 13, 12, 11, 10, 9, 8, 7, 5, 6, 4, 0, 1, 2, 0};
-#elif defined(CONFIG_SH_R7780MP)
-static int mask_pos[] = {12, 11, 9, 14, 15, 8, 13, 6, 5, 4, 3, 2, 0, 0, 1, 0};
-#elif defined(CONFIG_SH_R7785RP)
-static int mask_pos[] = {2, 11, 2, 2, 2, 2, 9, 8, 7, 5, 10, 2, 2, 2, 2, 2};
-#endif
-
-static void enable_r7780rp_irq(unsigned int irq)
-{
-	/* Set priority in IPR back to original value */
-	ctrl_outw(ctrl_inw(IRLCNTR1) | (1 << mask_pos[irq]), IRLCNTR1);
-}
-
-static void disable_r7780rp_irq(unsigned int irq)
-{
-	/* Set the priority in IPR to 0 */
-	ctrl_outw(ctrl_inw(IRLCNTR1) & (0xffff ^ (1 << mask_pos[irq])),
-		  IRLCNTR1);
-}
-
-static struct irq_chip r7780rp_irq_chip __read_mostly = {
-	.name		= "R7780RP",
-	.mask		= disable_r7780rp_irq,
-	.unmask		= enable_r7780rp_irq,
-	.mask_ack	= disable_r7780rp_irq,
-};
-
-void make_r7780rp_irq(unsigned int irq)
-{
-	disable_irq_nosync(irq);
-	set_irq_chip_and_handler_name(irq, &r7780rp_irq_chip,
-				      handle_level_irq, "level");
-	enable_r7780rp_irq(irq);
-}
--- 0001/arch/sh/boards/renesas/r7780rp/setup.c
+++ work/arch/sh/boards/renesas/r7780rp/setup.c	2008-01-25 15:33:32.000000000 +0900
@@ -179,9 +179,11 @@ static struct platform_device ax88796_de
 static struct platform_device *r7780rp_devices[] __initdata = {
 	&r8a66597_usb_host_device,
 	&m66592_usb_peripheral_device,
-	&cf_ide_device,
 	&heartbeat_device,
+#ifndef CONFIG_SH_R7780RP
+	&cf_ide_device,
 	&ax88796_device,
+#endif
 };
 
 static int __init r7780rp_devices_setup(void)
@@ -316,9 +318,9 @@ void __init highlander_init_irq(void)
 			break;
 #endif
 #ifdef CONFIG_SH_R7780RP
-		highlander_init_irq_r7780rp();
-		ucp = irl2irq;
-		break;
+		ucp = highlander_init_irq_r7780rp();
+		if (ucp)
+			break;
 #endif
 	} while (0);
 
--- 0001/arch/sh/drivers/pci/ops-r7780rp.c
+++ work/arch/sh/drivers/pci/ops-r7780rp.c	2008-01-25 15:19:40.000000000 +0900
@@ -17,25 +17,13 @@
 #include <asm/io.h>
 #include "pci-sh4.h"
 
-static char r7780rp_irq_tab[] __initdata = {
-	0, 1, 2, 3,
-};
-
-static char r7780mp_irq_tab[] __initdata = {
+static char irq_tab[] __initdata = {
 	65, 66, 67, 68,
 };
 
 int __init pcibios_map_platform_irq(struct pci_dev *pdev, u8 slot, u8 pin)
 {
-	if (mach_is_r7780rp())
-		return r7780rp_irq_tab[slot];
-	if (mach_is_r7780mp() || mach_is_r7785rp())
-		return r7780mp_irq_tab[slot];
-
-	printk(KERN_ERR "PCI: Bad IRQ mapping "
-	       "request for slot %d, func %d\n", slot, pin-1);
-
-	return -1;
+	return irq_tab[slot];
 }
 
 static struct resource sh7780_io_resource = {
--- 0001/include/asm-sh/r7780rp.h
+++ work/include/asm-sh/r7780rp.h	2008-01-25 15:29:31.000000000 +0900
@@ -121,21 +121,6 @@
 
 #define IRLCNTR1	(PA_BCR + 0)	/* Interrupt Control Register1 */
 
-#define IRQ_PCISLOT1	0		/* PCI Slot #1 IRQ */
-#define IRQ_PCISLOT2	1		/* PCI Slot #2 IRQ */
-#define IRQ_PCISLOT3	2		/* PCI Slot #3 IRQ */
-#define IRQ_PCISLOT4	3		/* PCI Slot #4 IRQ */
-#define IRQ_CFINST	5		/* CF Card Insert IRQ */
-#define IRQ_M66596	6		/* M66596 IRQ */
-#define IRQ_SDCARD	7		/* SD Card IRQ */
-#define IRQ_TUCHPANEL	8		/* Touch Panel IRQ */
-#define IRQ_SCI		9		/* SCI IRQ */
-#define IRQ_2SERIAL	10		/* Serial IRQ */
-#define	IRQ_EXTENTION	11		/* EXTn IRQ */
-#define IRQ_ONETH	12		/* On board Ethernet IRQ */
-#define IRQ_PSW		13		/* Push Switch IRQ */
-#define IRQ_ZIGBEE	14		/* Ziggbee IO IRQ */
-
 #define IVDR_CK_ON	8		/* iVDR Clock ON */
 
 #elif defined(CONFIG_SH_R7785RP)
@@ -192,9 +177,7 @@
 
 #define IRQ_AX88796		(HL_FPGA_IRQ_BASE + 0)
 #define IRQ_CF			(HL_FPGA_IRQ_BASE + 1)
-#ifndef IRQ_PSW
 #define IRQ_PSW			(HL_FPGA_IRQ_BASE + 2)
-#endif
 #define IRQ_EXT0		(HL_FPGA_IRQ_BASE + 3)
 #define IRQ_EXT1		(HL_FPGA_IRQ_BASE + 4)
 #define IRQ_EXT2		(HL_FPGA_IRQ_BASE + 5)
@@ -208,8 +191,6 @@
 #define IRQ_RTC			(HL_FPGA_IRQ_BASE + 13)
 #define IRQ_TH_ALERT		(HL_FPGA_IRQ_BASE + 14)
 
-void make_r7780rp_irq(unsigned int irq);
-
 unsigned char *highlander_init_irq_r7780mp(void);
 unsigned char *highlander_init_irq_r7780rp(void);
 unsigned char *highlander_init_irq_r7785rp(void);
