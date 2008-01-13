From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 13 Jan 2008 13:38:14 +0000
Subject: [PATCH] sh: remove voyagergx
Message-Id: <20080113133814.28951.81886.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: remove voyagergx

This patch removes redundant irq handling code together with unused
consistent alloc code. R2D uart setup code is changed to use sm501-regs.h
and unused header files are removed.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Makefile                          |    1 
 arch/sh/boards/renesas/rts7751r2d/irq.c   |    4 
 arch/sh/boards/renesas/rts7751r2d/setup.c |   73 +++---
 arch/sh/cchips/voyagergx/Makefile         |    9 
 arch/sh/cchips/voyagergx/consistent.c     |  121 ----------
 arch/sh/cchips/voyagergx/irq.c            |  101 --------
 include/asm-sh/voyagergx.h                |  341 -----------------------------
 7 files changed, 39 insertions(+), 611 deletions(-)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2008-01-13 21:55:52.000000000 +0900
@@ -138,7 +138,6 @@ endif
 
 # Companion chips
 core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
-core-$(CONFIG_MFD_SM501)	+= arch/sh/cchips/voyagergx/
 
 cpuincdir-$(CONFIG_CPU_SH2)	:= cpu-sh2
 cpuincdir-$(CONFIG_CPU_SH2A)	:= cpu-sh2a
--- 0001/arch/sh/boards/renesas/rts7751r2d/irq.c
+++ work/arch/sh/boards/renesas/rts7751r2d/irq.c	2008-01-13 21:55:52.000000000 +0900
@@ -13,7 +13,6 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <asm/voyagergx.h>
 #include <asm/rts7751r2d.h>
 
 #define R2D_NR_IRL 13
@@ -153,7 +152,4 @@ void __init init_rts7751r2d_IRQ(void)
 	}
 
 	register_intc_controller(d);
-#ifdef CONFIG_MFD_SM501
-	setup_voyagergx_irq();
-#endif
 }
--- 0002/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-01-13 21:56:48.000000000 +0900
@@ -13,36 +13,13 @@
 #include <linux/pata_platform.h>
 #include <linux/serial_8250.h>
 #include <linux/sm501.h>
+#include <linux/sm501-regs.h>
 #include <linux/pm.h>
 #include <linux/fb.h>
 #include <asm/machvec.h>
 #include <asm/rts7751r2d.h>
-#include <asm/voyagergx.h>
 #include <asm/io.h>
 
-static void __init voyagergx_serial_init(void)
-{
-	unsigned long val;
-
-	/*
-	 * GPIO Control
-	 */
-	val = readl((void __iomem *)GPIO_MUX_HIGH);
-	val |= 0x00001fe0;
-	writel(val, (void __iomem *)GPIO_MUX_HIGH);
-
-	/*
-	 * Power Mode Gate
-	 */
-	val = readl((void __iomem *)POWER_MODE0_GATE);
-	val |= (POWER_MODE0_GATE_U0 | POWER_MODE0_GATE_U1);
-	writel(val, (void __iomem *)POWER_MODE0_GATE);
-
-	val = readl((void __iomem *)POWER_MODE1_GATE);
-	val |= (POWER_MODE1_GATE_U0 | POWER_MODE1_GATE_U1);
-	writel(val, (void __iomem *)POWER_MODE1_GATE);
-}
-
 static struct resource cf_ide_resources[] = {
 	[0] = {
 		.start	= PA_AREA5_IO + 0x1000,
@@ -94,11 +71,11 @@ static struct platform_device heartbeat_
 #ifdef CONFIG_MFD_SM501
 static struct plat_serial8250_port uart_platform_data[] = {
 	{
-		.membase	= (void __iomem *)VOYAGER_UART_BASE,
-		.mapbase	= VOYAGER_UART_BASE,
+		.membase	= (void __iomem *)0xb3e30000,
+		.mapbase	= 0xb3e30000,
 		.iotype		= UPIO_MEM,
-		.irq		= IRQ_SM501_U0,
-		.flags		= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
+		.irq		= IRQ_VOYAGER,
+		.flags		= UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ,
 		.regshift	= 2,
 		.uartclk	= (9600 * 16),
 	},
@@ -125,7 +102,7 @@ static struct resource sm501_resources[]
 		.flags	= IORESOURCE_MEM,
 	},
 	[2]	= {
-		.start	= IRQ_SM501_CV,
+		.start	= IRQ_VOYAGER,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -167,7 +144,15 @@ static struct sm501_platdata_fb sm501_fb
 	.flags		= SM501_FBPD_SWAP_FB_ENDIAN,
 };
 
+static struct sm501_initdata sm501_initdata = {
+	.gpio_high	= {
+		.set	= 0x00001fe0,
+		.mask	= 0x0,
+	},
+};
+
 static struct sm501_platdata sm501_platform_data = {
+	.init		= &sm501_initdata,
 	.fb		= &sm501_fb_pdata,
 };
 
@@ -237,6 +222,7 @@ u8 rts7751r2d_readb(void __iomem *addr)
  */
 static void __init rts7751r2d_setup(char **cmdline_p)
 {
+	void __iomem *sm501_reg;
 	u16 ver = ctrl_inw(PA_VERREG);
 
 	printk(KERN_INFO "Renesas Technology Sales RTS7751R2D support.\n");
@@ -247,7 +233,30 @@ static void __init rts7751r2d_setup(char
 	ctrl_outw(0x0000, PA_OUTPORT);
 	pm_power_off = rts7751r2d_power_off;
 
-	voyagergx_serial_init();
+	/* sm501 dram configuration:
+	 * ColSizeX = 11 - External Memory Column Size: 256 words.
+	 * APX = 1 - External Memory Active to Pre-Charge Delay: 7 clocks.
+	 * RstX = 1 - External Memory Reset: Normal.
+	 * Rfsh = 1 - Local Memory Refresh to Command Delay: 12 clocks.
+	 * BwC =  1 - Local Memory Block Write Cycle Time: 2 clocks.
+	 * BwP =  1 - Local Memory Block Write to Pre-Charge Delay: 1 clock.
+	 * AP = 1 - Internal Memory Active to Pre-Charge Delay: 7 clocks.
+	 * Rst = 1 - Internal Memory Reset: Normal.
+	 * RA = 1 - Internal Memory Remain in Active State: Do not remain.
+	 */
+
+	sm501_reg = (void __iomem *)0xb3e00000 + SM501_DRAM_CONTROL;
+	writel(readl(sm501_reg) | 0x00f107c0, sm501_reg);
+
+	/*
+	 * Power Mode Gate - Enable UART0
+	 */
+
+	sm501_reg = (void __iomem *)0xb3e00000 + SM501_POWER_MODE_0_GATE;
+	writel(readl(sm501_reg) | (1 << SM501_GATE_UART0), sm501_reg);
+
+	sm501_reg = (void __iomem *)0xb3e00000 + SM501_POWER_MODE_1_GATE;
+	writel(readl(sm501_reg) | (1 << SM501_GATE_UART0), sm501_reg);
 }
 
 /*
@@ -260,8 +269,4 @@ static struct sh_machine_vector mv_rts77
 	.mv_irq_demux		= rts7751r2d_irq_demux,
 	.mv_writeb		= rts7751r2d_writeb,
 	.mv_readb		= rts7751r2d_readb,
-#if defined(CONFIG_MFD_SM501) && defined(CONFIG_USB_OHCI_HCD)
-	.mv_consistent_alloc	= voyagergx_consistent_alloc,
-	.mv_consistent_free	= voyagergx_consistent_free,
-#endif
 };
--- 0001/arch/sh/cchips/voyagergx/Makefile
+++ /dev/null	2007-12-24 23:06:17.939005730 +0900
@@ -1,9 +0,0 @@
-#
-# Makefile for VoyagerGX
-#
-
-obj-y	:= irq.o setup.o
-
-obj-$(CONFIG_USB_OHCI_HCD)	+= consistent.o
-
-EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/cchips/voyagergx/consistent.c
+++ /dev/null	2007-12-24 23:06:17.939005730 +0900
@@ -1,121 +0,0 @@
-/*
- * arch/sh/cchips/voyagergx/consistent.c
- *
- * Copyright (C) 2004  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/mm.h>
-#include <linux/dma-mapping.h>
-#include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <asm/io.h>
-
-
-struct voya_alloc_entry {
-	struct list_head list;
-	unsigned long ofs;
-	unsigned long len;
-};
-
-static DEFINE_SPINLOCK(voya_list_lock);
-static LIST_HEAD(voya_alloc_list);
-
-#define OHCI_SRAM_START	0xb0000000
-#define OHCI_HCCA_SIZE	0x100
-#define OHCI_SRAM_SIZE	0x10000
-
-#define VOYAGER_OHCI_NAME	"voyager-ohci"
-
-void *voyagergx_consistent_alloc(struct device *dev, size_t size,
-				 dma_addr_t *handle, gfp_t flag)
-{
-	struct list_head *list = &voya_alloc_list;
-	struct voya_alloc_entry *entry;
-	unsigned long start, end;
-	unsigned long flags;
-
-	/*
-	 * The SM501 contains an integrated 8051 with its own SRAM.
-	 * Devices within the cchip can all hook into the 8051 SRAM.
-	 * We presently use this for the OHCI.
-	 *
-	 * Everything else goes through consistent_alloc().
-	 */
-	if (!dev || strcmp(dev->driver->name, VOYAGER_OHCI_NAME))
-		return NULL;
-
-	start = OHCI_SRAM_START + OHCI_HCCA_SIZE;
-
-	entry = kmalloc(sizeof(struct voya_alloc_entry), GFP_ATOMIC);
-	if (!entry)
-		return ERR_PTR(-ENOMEM);
-
-	entry->len = (size + 15) & ~15;
-
-	/*
-	 * The basis for this allocator is dwmw2's malloc.. the
-	 * Matrox allocator :-)
-	 */
-	spin_lock_irqsave(&voya_list_lock, flags);
-	list_for_each(list, &voya_alloc_list) {
-		struct voya_alloc_entry *p;
-
-		p = list_entry(list, struct voya_alloc_entry, list);
-
-		if (p->ofs - start >= size)
-			goto out;
-
-		start = p->ofs + p->len;
-	}
-
-	end  = start + (OHCI_SRAM_SIZE  - OHCI_HCCA_SIZE);
-	list = &voya_alloc_list;
-
-	if (end - start >= size) {
-out:
-		entry->ofs = start;
-		list_add_tail(&entry->list, list);
-		spin_unlock_irqrestore(&voya_list_lock, flags);
-
-		*handle = start;
-		return (void *)start;
-	}
-
-	kfree(entry);
-	spin_unlock_irqrestore(&voya_list_lock, flags);
-
-	return ERR_PTR(-EINVAL);
-}
-
-int voyagergx_consistent_free(struct device *dev, size_t size,
-			      void *vaddr, dma_addr_t handle)
-{
-	struct voya_alloc_entry *entry;
-	unsigned long flags;
-
-	if (!dev || strcmp(dev->driver->name, VOYAGER_OHCI_NAME))
-		return -EINVAL;
-
-	spin_lock_irqsave(&voya_list_lock, flags);
-	list_for_each_entry(entry, &voya_alloc_list, list) {
-		if (entry->ofs != handle)
-			continue;
-
-		list_del(&entry->list);
-		kfree(entry);
-
-		break;
-	}
-	spin_unlock_irqrestore(&voya_list_lock, flags);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(voyagergx_consistent_alloc);
-EXPORT_SYMBOL(voyagergx_consistent_free);
--- 0001/arch/sh/cchips/voyagergx/irq.c
+++ /dev/null	2007-12-24 23:06:17.939005730 +0900
@@ -1,101 +0,0 @@
-/* -------------------------------------------------------------------- */
-/* setup_voyagergx.c:                                                     */
-/* -------------------------------------------------------------------- */
-/*  This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Copyright 2003 (c) Lineo uSolutions,Inc.
-*/
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <asm/voyagergx.h>
-#include <asm/rts7751r2d.h>
-
-enum {
-	UNUSED = 0,
-
-	/* voyager specific interrupt sources */
-	UP, G54, G53, G52, G51, G50, G49, G48,
-	I2C, PW, DMA, PCI, I2S, AC, US,
-	U1, U0, CV, MC, S1, S0,
-	UH, TWOD, ZD, PV, CI,
-};
-
-static struct intc_vect vectors[] __initdata = {
-	INTC_IRQ(UP, IRQ_SM501_UP), INTC_IRQ(G54, IRQ_SM501_G54),
-	INTC_IRQ(G53, IRQ_SM501_G53), INTC_IRQ(G52, IRQ_SM501_G52),
-	INTC_IRQ(G51, IRQ_SM501_G51), INTC_IRQ(G50, IRQ_SM501_G50),
-	INTC_IRQ(G49, IRQ_SM501_G49), INTC_IRQ(G48, IRQ_SM501_G48),
-	INTC_IRQ(I2C, IRQ_SM501_I2C), INTC_IRQ(PW, IRQ_SM501_PW),
-	INTC_IRQ(DMA, IRQ_SM501_DMA), INTC_IRQ(PCI, IRQ_SM501_PCI),
-	INTC_IRQ(I2S, IRQ_SM501_I2S), INTC_IRQ(AC, IRQ_SM501_AC),
-	INTC_IRQ(US, IRQ_SM501_US), INTC_IRQ(U1, IRQ_SM501_U1),
-	INTC_IRQ(U0, IRQ_SM501_U0), INTC_IRQ(CV, IRQ_SM501_CV),
-	INTC_IRQ(MC, IRQ_SM501_MC), INTC_IRQ(S1, IRQ_SM501_S1),
-	INTC_IRQ(S0, IRQ_SM501_S0), INTC_IRQ(UH, IRQ_SM501_UH),
-	INTC_IRQ(TWOD, IRQ_SM501_2D), INTC_IRQ(ZD, IRQ_SM501_ZD),
-	INTC_IRQ(PV, IRQ_SM501_PV), INTC_IRQ(CI, IRQ_SM501_CI),
-};
-
-static struct intc_mask_reg mask_registers[] __initdata = {
-	{ VOYAGER_INT_MASK, 0, 32, /* "Interrupt Mask", MMIO_base + 0x30 */
-	  { UP, G54, G53, G52, G51, G50, G49, G48,
-	    I2C, PW, 0, DMA, PCI, I2S, AC, US,
-	    0, 0, U1, U0, CV, MC, S1, S0,
-	    0, UH, 0, 0, TWOD, ZD, PV, CI } },
-};
-
-static DECLARE_INTC_DESC(intc_desc, "voyagergx", vectors,
-			 NULL, mask_registers, NULL, NULL);
-
-static unsigned int voyagergx_stat2irq[32] = {
-	IRQ_SM501_CI, IRQ_SM501_PV, IRQ_SM501_ZD, IRQ_SM501_2D,
-	0, 0, IRQ_SM501_UH, 0,
-	IRQ_SM501_S0, IRQ_SM501_S1, IRQ_SM501_MC, IRQ_SM501_CV,
-	IRQ_SM501_U0, IRQ_SM501_U1, 0, 0,
-	IRQ_SM501_US, IRQ_SM501_AC, IRQ_SM501_I2S, IRQ_SM501_PCI,
-	IRQ_SM501_DMA, 0, IRQ_SM501_PW, IRQ_SM501_I2C,
-	IRQ_SM501_G48, IRQ_SM501_G49, IRQ_SM501_G50, IRQ_SM501_G51,
-	IRQ_SM501_G52, IRQ_SM501_G53, IRQ_SM501_G54, IRQ_SM501_UP
-};
-
-static void voyagergx_irq_demux(unsigned int irq, struct irq_desc *desc)
-{
-	unsigned long intv = ctrl_inl(INT_STATUS);
-	struct irq_desc *ext_desc;
-	unsigned int ext_irq;
-	unsigned int k = 0;
-
-	while (intv) {
-		ext_irq = voyagergx_stat2irq[k];
-		if (ext_irq && (intv & 1)) {
-			ext_desc = irq_desc + ext_irq;
-			handle_level_irq(ext_irq, ext_desc);
-		}
-		intv >>= 1;
-		k++;
-	}
-}
-
-void __init setup_voyagergx_irq(void)
-{
-	printk(KERN_INFO "VoyagerGX on irq %d (mapped into %d to %d)\n",
-	       IRQ_VOYAGER,
-	       VOYAGER_IRQ_BASE,
-	       VOYAGER_IRQ_BASE + VOYAGER_IRQ_NUM - 1);
-
-	register_intc_controller(&intc_desc);
-	set_irq_chained_handler(IRQ_VOYAGER, voyagergx_irq_demux);
-}
--- 0001/include/asm-sh/voyagergx.h
+++ /dev/null	2007-12-24 23:06:17.939005730 +0900
@@ -1,341 +0,0 @@
-/* -------------------------------------------------------------------- */
-/* voyagergx.h	                                                      */
-/* -------------------------------------------------------------------- */
-/*  This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-    Copyright 2003 (c) Lineo uSolutions,Inc.
-*/
-/* -------------------------------------------------------------------- */
-
-#ifndef _VOYAGER_GX_REG_H
-#define _VOYAGER_GX_REG_H
-
-#define VOYAGER_BASE			0xb3e00000
-#define VOYAGER_USBH_BASE		(0x40000 + VOYAGER_BASE)
-#define VOYAGER_UART_BASE		(0x30000 + VOYAGER_BASE)
-#define	VOYAGER_AC97_BASE		(0xa0000 + VOYAGER_BASE)
-
-#define VOYAGER_IRQ_NUM			26
-#define VOYAGER_IRQ_BASE		200
-
-#define IRQ_SM501_UP			(VOYAGER_IRQ_BASE + 0)
-#define IRQ_SM501_G54			(VOYAGER_IRQ_BASE + 1)
-#define IRQ_SM501_G53			(VOYAGER_IRQ_BASE + 2)
-#define IRQ_SM501_G52			(VOYAGER_IRQ_BASE + 3)
-#define IRQ_SM501_G51			(VOYAGER_IRQ_BASE + 4)
-#define IRQ_SM501_G50			(VOYAGER_IRQ_BASE + 5)
-#define IRQ_SM501_G49			(VOYAGER_IRQ_BASE + 6)
-#define IRQ_SM501_G48			(VOYAGER_IRQ_BASE + 7)
-#define IRQ_SM501_I2C			(VOYAGER_IRQ_BASE + 8)
-#define IRQ_SM501_PW			(VOYAGER_IRQ_BASE + 9)
-#define IRQ_SM501_DMA			(VOYAGER_IRQ_BASE + 10)
-#define IRQ_SM501_PCI			(VOYAGER_IRQ_BASE + 11)
-#define IRQ_SM501_I2S			(VOYAGER_IRQ_BASE + 12)
-#define IRQ_SM501_AC			(VOYAGER_IRQ_BASE + 13)
-#define IRQ_SM501_US			(VOYAGER_IRQ_BASE + 14)
-#define IRQ_SM501_U1			(VOYAGER_IRQ_BASE + 15)
-#define IRQ_SM501_U0			(VOYAGER_IRQ_BASE + 16)
-#define IRQ_SM501_CV			(VOYAGER_IRQ_BASE + 17)
-#define IRQ_SM501_MC			(VOYAGER_IRQ_BASE + 18)
-#define IRQ_SM501_S1			(VOYAGER_IRQ_BASE + 19)
-#define IRQ_SM501_S0			(VOYAGER_IRQ_BASE + 20)
-#define IRQ_SM501_UH			(VOYAGER_IRQ_BASE + 21)
-#define IRQ_SM501_2D			(VOYAGER_IRQ_BASE + 22)
-#define IRQ_SM501_ZD			(VOYAGER_IRQ_BASE + 23)
-#define IRQ_SM501_PV			(VOYAGER_IRQ_BASE + 24)
-#define IRQ_SM501_CI			(VOYAGER_IRQ_BASE + 25)
-
-/* ----- MISC controle  register ------------------------------ */
-#define MISC_CTRL			(0x000004 + VOYAGER_BASE)
-#define MISC_CTRL_USBCLK_48		(3 << 28)
-#define MISC_CTRL_USBCLK_96		(2 << 28)
-#define MISC_CTRL_USBCLK_CRYSTAL	(1 << 28)
-
-/* ----- GPIO[31:0] register --------------------------------- */
-#define GPIO_MUX_LOW			(0x000008 + VOYAGER_BASE)
-#define GPIO_MUX_LOW_AC97		0x1F000000
-#define GPIO_MUX_LOW_8051		0x0000ffff
-#define GPIO_MUX_LOW_PWM		(1 << 29)
-
-/* ----- GPIO[63:32] register --------------------------------- */
-#define GPIO_MUX_HIGH			(0x00000C + VOYAGER_BASE)
-
-/* ----- DRAM controle  register ------------------------------- */
-#define DRAM_CTRL			(0x000010 + VOYAGER_BASE)
-#define DRAM_CTRL_EMBEDDED		(1 << 31)
-#define DRAM_CTRL_CPU_BURST_1		(0 << 28)
-#define DRAM_CTRL_CPU_BURST_2		(1 << 28)
-#define DRAM_CTRL_CPU_BURST_4		(2 << 28)
-#define DRAM_CTRL_CPU_BURST_8		(3 << 28)
-#define DRAM_CTRL_CPU_CAS_LATENCY	(1 << 27)
-#define DRAM_CTRL_CPU_SIZE_2		(0 << 24)
-#define DRAM_CTRL_CPU_SIZE_4		(1 << 24)
-#define DRAM_CTRL_CPU_SIZE_64		(4 << 24)
-#define DRAM_CTRL_CPU_SIZE_32		(5 << 24)
-#define DRAM_CTRL_CPU_SIZE_16		(6 << 24)
-#define DRAM_CTRL_CPU_SIZE_8		(7 << 24)
-#define DRAM_CTRL_CPU_COLUMN_SIZE_1024	(0 << 22)
-#define DRAM_CTRL_CPU_COLUMN_SIZE_512	(2 << 22)
-#define DRAM_CTRL_CPU_COLUMN_SIZE_256	(3 << 22)
-#define DRAM_CTRL_CPU_ACTIVE_PRECHARGE	(1 << 21)
-#define DRAM_CTRL_CPU_RESET		(1 << 20)
-#define DRAM_CTRL_CPU_BANKS		(1 << 19)
-#define DRAM_CTRL_CPU_WRITE_PRECHARGE	(1 << 18)
-#define DRAM_CTRL_BLOCK_WRITE		(1 << 17)
-#define DRAM_CTRL_REFRESH_COMMAND	(1 << 16)
-#define DRAM_CTRL_SIZE_4		(0 << 13)
-#define DRAM_CTRL_SIZE_8		(1 << 13)
-#define DRAM_CTRL_SIZE_16		(2 << 13)
-#define DRAM_CTRL_SIZE_32		(3 << 13)
-#define DRAM_CTRL_SIZE_64		(4 << 13)
-#define DRAM_CTRL_SIZE_2		(5 << 13)
-#define DRAM_CTRL_COLUMN_SIZE_256	(0 << 11)
-#define DRAM_CTRL_COLUMN_SIZE_512	(2 << 11)
-#define DRAM_CTRL_COLUMN_SIZE_1024	(3 << 11)
-#define DRAM_CTRL_BLOCK_WRITE_TIME	(1 << 10)
-#define DRAM_CTRL_BLOCK_WRITE_PRECHARGE	(1 << 9)
-#define DRAM_CTRL_ACTIVE_PRECHARGE	(1 << 8)
-#define DRAM_CTRL_RESET			(1 << 7)
-#define DRAM_CTRL_REMAIN_ACTIVE		(1 << 6)
-#define DRAM_CTRL_BANKS			(1 << 1)
-#define DRAM_CTRL_WRITE_PRECHARGE	(1 << 0)
-
-/* ----- Arvitration control register -------------------------- */
-#define ARBITRATION_CTRL		(0x000014 + VOYAGER_BASE)
-#define ARBITRATION_CTRL_CPUMEM		(1 << 29)
-#define ARBITRATION_CTRL_INTMEM		(1 << 28)
-#define ARBITRATION_CTRL_USB_OFF	(0 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_1	(1 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_2	(2 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_3	(3 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_4	(4 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_5	(5 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_6	(6 << 24)
-#define ARBITRATION_CTRL_USB_PRIORITY_7	(7 << 24)
-#define ARBITRATION_CTRL_PANEL_OFF	(0 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_1	(1 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_2	(2 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_3	(3 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_4	(4 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_5	(5 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_6	(6 << 20)
-#define ARBITRATION_CTRL_PANEL_PRIORITY_7	(7 << 20)
-#define ARBITRATION_CTRL_ZVPORT_OFF	(0 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_1	(1 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_2	(2 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_3	(3 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_4	(4 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_5	(5 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_6	(6 << 16)
-#define ARBITRATION_CTRL_ZVPORTL_PRIORITY_7	(7 << 16)
-#define ARBITRATION_CTRL_CMD_INTPR_OFF	(0 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_1	(1 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_2	(2 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_3	(3 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_4	(4 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_5	(5 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_6	(6 << 12)
-#define ARBITRATION_CTRL_CMD_INTPR_PRIORITY_7	(7 << 12)
-#define ARBITRATION_CTRL_DMA_OFF	(0 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_1	(1 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_2	(2 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_3	(3 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_4	(4 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_5	(5 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_6	(6 << 8)
-#define ARBITRATION_CTRL_DMA_PRIORITY_7	(7 << 8)
-#define ARBITRATION_CTRL_VIDEO_OFF	(0 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_1	(1 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_2	(2 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_3	(3 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_4	(4 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_5	(5 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_6	(6 << 4)
-#define ARBITRATION_CTRL_VIDEO_PRIORITY_7	(7 << 4)
-#define ARBITRATION_CTRL_CRT_OFF	(0 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_1	(1 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_2	(2 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_3	(3 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_4	(4 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_5	(5 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_6	(6 << 0)
-#define ARBITRATION_CTRL_CRT_PRIORITY_7	(7 << 0)
-
-/* ----- Command list status register -------------------------- */
-#define CMD_INTPR_STATUS		(0x000024 + VOYAGER_BASE)
-
-/* ----- Interrupt status register ----------------------------- */
-#define INT_STATUS			(0x00002c + VOYAGER_BASE)
-#define INT_STATUS_UH			(1 << 6)
-#define INT_STATUS_MC			(1 << 10)
-#define INT_STATUS_U0			(1 << 12)
-#define INT_STATUS_U1			(1 << 13)
-#define	INT_STATUS_AC			(1 << 17)
-
-/* ----- Interrupt mask register ------------------------------ */
-#define VOYAGER_INT_MASK		(0x000030 + VOYAGER_BASE)
-#define VOYAGER_INT_MASK_AC		(1 << 17)
-
-/* ----- Current Gate register ---------------------------------*/
-#define CURRENT_GATE			(0x000038 + VOYAGER_BASE)
-
-/* ----- Power mode 0 gate register --------------------------- */
-#define POWER_MODE0_GATE		(0x000040 + VOYAGER_BASE)
-#define POWER_MODE0_GATE_G		(1 << 6)
-#define POWER_MODE0_GATE_U0		(1 << 7)
-#define POWER_MODE0_GATE_U1		(1 << 8)
-#define POWER_MODE0_GATE_UH		(1 << 11)
-#define	POWER_MODE0_GATE_AC		(1 << 18)
-
-/* ----- Power mode 1 gate register --------------------------- */
-#define POWER_MODE1_GATE		(0x000048 + VOYAGER_BASE)
-#define POWER_MODE1_GATE_G		(1 << 6)
-#define POWER_MODE1_GATE_U0		(1 << 7)
-#define POWER_MODE1_GATE_U1		(1 << 8)
-#define POWER_MODE1_GATE_UH		(1 << 11)
-#define	POWER_MODE1_GATE_AC		(1 << 18)
-
-/* ----- Power mode 0 clock register -------------------------- */
-#define POWER_MODE0_CLOCK		(0x000044 + VOYAGER_BASE)
-
-/* ----- Power mode 1 clock register -------------------------- */
-#define POWER_MODE1_CLOCK		(0x00004C + VOYAGER_BASE)
-
-/* ----- Power mode control register ------------------------- */
-#define POWER_MODE_CTRL			(0x000054 + VOYAGER_BASE)
-
-/* ----- Miscellaneous Timing register ------------------------ */
-#define SYSTEM_DRAM_CTRL		(0x000068 + VOYAGER_BASE)
-
-/* ----- PWM register ------------------------------------------*/
-#define PWM_0				(0x010020 + VOYAGER_BASE)
-#define PWM_0_HC(x)			(((x)&0x0fff)<<20)
-#define PWM_0_LC(x)			(((x)&0x0fff)<<8 )
-#define PWM_0_CLK_DEV(x)		(((x)&0x000f)<<4 )
-#define PWM_0_EN			(1<<0)
-
-/* ----- I2C register ----------------------------------------- */
-#define I2C_BYTECOUNT			(0x010040 + VOYAGER_BASE)
-#define I2C_CONTROL			(0x010041 + VOYAGER_BASE)
-#define I2C_STATUS			(0x010042 + VOYAGER_BASE)
-#define I2C_RESET			(0x010042 + VOYAGER_BASE)
-#define I2C_SADDRESS			(0x010043 + VOYAGER_BASE)
-#define I2C_DATA			(0x010044 + VOYAGER_BASE)
-
-/* ----- Controle register bits ----------------------------------------- */
-#define I2C_CONTROL_E			(1 << 0)
-#define I2C_CONTROL_MODE		(1 << 1)
-#define I2C_CONTROL_STATUS		(1 << 2)
-#define I2C_CONTROL_INT			(1 << 4)
-#define I2C_CONTROL_INTACK		(1 << 5)
-#define I2C_CONTROL_REPEAT		(1 << 6)
-
-/* ----- Status register bits ----------------------------------------- */
-#define I2C_STATUS_BUSY			(1 << 0)
-#define I2C_STATUS_ACK			(1 << 1)
-#define I2C_STATUS_ERROR		(1 << 2)
-#define I2C_STATUS_COMPLETE		(1 << 3)
-
-/* ----- Reset register  ---------------------------------------------- */
-#define I2C_RESET_ERROR			(1 << 2)
-
-/* ----- transmission frequencies ------------------------------------- */
-#define I2C_SADDRESS_SELECT		(1 << 0)
-
-/* ----- Display Controll register ----------------------------------------- */
-#define PANEL_DISPLAY_CTRL		(0x080000 + VOYAGER_BASE)
-#define PANEL_DISPLAY_CTRL_BIAS         (1<<26)
-#define PANEL_PAN_CTRL			(0x080004 + VOYAGER_BASE)
-#define PANEL_COLOR_KEY			(0x080008 + VOYAGER_BASE)
-#define PANEL_FB_ADDRESS		(0x08000C + VOYAGER_BASE)
-#define PANEL_FB_WIDTH			(0x080010 + VOYAGER_BASE)
-#define PANEL_WINDOW_WIDTH		(0x080014 + VOYAGER_BASE)
-#define PANEL_WINDOW_HEIGHT		(0x080018 + VOYAGER_BASE)
-#define PANEL_PLANE_TL			(0x08001C + VOYAGER_BASE)
-#define PANEL_PLANE_BR			(0x080020 + VOYAGER_BASE)
-#define PANEL_HORIZONTAL_TOTAL		(0x080024 + VOYAGER_BASE)
-#define PANEL_HORIZONTAL_SYNC		(0x080028 + VOYAGER_BASE)
-#define PANEL_VERTICAL_TOTAL		(0x08002C + VOYAGER_BASE)
-#define PANEL_VERTICAL_SYNC		(0x080030 + VOYAGER_BASE)
-#define PANEL_CURRENT_LINE		(0x080034 + VOYAGER_BASE)
-#define VIDEO_DISPLAY_CTRL		(0x080040 + VOYAGER_BASE)
-#define VIDEO_FB_0_ADDRESS		(0x080044 + VOYAGER_BASE)
-#define VIDEO_FB_WIDTH			(0x080048 + VOYAGER_BASE)
-#define VIDEO_FB_0_LAST_ADDRESS		(0x08004C + VOYAGER_BASE)
-#define VIDEO_PLANE_TL			(0x080050 + VOYAGER_BASE)
-#define VIDEO_PLANE_BR			(0x080054 + VOYAGER_BASE)
-#define VIDEO_SCALE			(0x080058 + VOYAGER_BASE)
-#define VIDEO_INITIAL_SCALE		(0x08005C + VOYAGER_BASE)
-#define VIDEO_YUV_CONSTANTS		(0x080060 + VOYAGER_BASE)
-#define VIDEO_FB_1_ADDRESS		(0x080064 + VOYAGER_BASE)
-#define VIDEO_FB_1_LAST_ADDRESS		(0x080068 + VOYAGER_BASE)
-#define VIDEO_ALPHA_DISPLAY_CTRL	(0x080080 + VOYAGER_BASE)
-#define VIDEO_ALPHA_FB_ADDRESS		(0x080084 + VOYAGER_BASE)
-#define VIDEO_ALPHA_FB_WIDTH		(0x080088 + VOYAGER_BASE)
-#define VIDEO_ALPHA_FB_LAST_ADDRESS	(0x08008C + VOYAGER_BASE)
-#define VIDEO_ALPHA_PLANE_TL		(0x080090 + VOYAGER_BASE)
-#define VIDEO_ALPHA_PLANE_BR		(0x080094 + VOYAGER_BASE)
-#define VIDEO_ALPHA_SCALE		(0x080098 + VOYAGER_BASE)
-#define VIDEO_ALPHA_INITIAL_SCALE	(0x08009C + VOYAGER_BASE)
-#define VIDEO_ALPHA_CHROMA_KEY		(0x0800A0 + VOYAGER_BASE)
-#define PANEL_HWC_ADDRESS		(0x0800F0 + VOYAGER_BASE)
-#define PANEL_HWC_LOCATION		(0x0800F4 + VOYAGER_BASE)
-#define PANEL_HWC_COLOR_12		(0x0800F8 + VOYAGER_BASE)
-#define PANEL_HWC_COLOR_3		(0x0800FC + VOYAGER_BASE)
-#define ALPHA_DISPLAY_CTRL		(0x080100 + VOYAGER_BASE)
-#define ALPHA_FB_ADDRESS		(0x080104 + VOYAGER_BASE)
-#define ALPHA_FB_WIDTH			(0x080108 + VOYAGER_BASE)
-#define ALPHA_PLANE_TL			(0x08010C + VOYAGER_BASE)
-#define ALPHA_PLANE_BR			(0x080110 + VOYAGER_BASE)
-#define ALPHA_CHROMA_KEY		(0x080114 + VOYAGER_BASE)
-#define CRT_DISPLAY_CTRL		(0x080200 + VOYAGER_BASE)
-#define CRT_FB_ADDRESS			(0x080204 + VOYAGER_BASE)
-#define CRT_FB_WIDTH			(0x080208 + VOYAGER_BASE)
-#define CRT_HORIZONTAL_TOTAL		(0x08020C + VOYAGER_BASE)
-#define CRT_HORIZONTAL_SYNC		(0x080210 + VOYAGER_BASE)
-#define CRT_VERTICAL_TOTAL		(0x080214 + VOYAGER_BASE)
-#define CRT_VERTICAL_SYNC		(0x080218 + VOYAGER_BASE)
-#define CRT_SIGNATURE_ANALYZER		(0x08021C + VOYAGER_BASE)
-#define CRT_CURRENT_LINE		(0x080220 + VOYAGER_BASE)
-#define CRT_MONITOR_DETECT		(0x080224 + VOYAGER_BASE)
-#define CRT_HWC_ADDRESS			(0x080230 + VOYAGER_BASE)
-#define CRT_HWC_LOCATION		(0x080234 + VOYAGER_BASE)
-#define CRT_HWC_COLOR_12		(0x080238 + VOYAGER_BASE)
-#define CRT_HWC_COLOR_3			(0x08023C + VOYAGER_BASE)
-#define CRT_PALETTE_RAM			(0x080400 + VOYAGER_BASE)
-#define PANEL_PALETTE_RAM		(0x080800 + VOYAGER_BASE)
-#define VIDEO_PALETTE_RAM		(0x080C00 + VOYAGER_BASE)
-
-/* ----- 8051 Controle register ----------------------------------------- */
-#define VOYAGER_8051_BASE		(0x000c0000 + VOYAGER_BASE)
-#define VOYAGER_8051_RESET		(0x000b0000 + VOYAGER_BASE)
-#define VOYAGER_8051_SELECT		(0x000b0004 + VOYAGER_BASE)
-#define VOYAGER_8051_CPU_INT		(0x000b000c + VOYAGER_BASE)
-
-/* ----- AC97 Controle register ----------------------------------------- */
-#define AC97_TX_SLOT0			(0x00000000 + VOYAGER_AC97_BASE)
-#define AC97_CONTROL_STATUS		(0x00000080 + VOYAGER_AC97_BASE)
-#define AC97C_READ			(1 << 19)
-#define AC97C_WD_BIT			(1 << 2)
-#define AC97C_INDEX_MASK		0x7f
-
-/* arch/sh/cchips/voyagergx/consistent.c */
-void *voyagergx_consistent_alloc(struct device *, size_t, dma_addr_t *, gfp_t);
-int voyagergx_consistent_free(struct device *, size_t, void *, dma_addr_t);
-
-/* arch/sh/cchips/voyagergx/irq.c */
-void setup_voyagergx_irq(void);
-
-#endif /* _VOYAGER_GX_REG_H */
