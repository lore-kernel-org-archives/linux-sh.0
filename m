Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B53C83F20
	for <linux-sh@archiver.kernel.org>; Thu, 31 Aug 2023 01:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344987AbjHaBMQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Aug 2023 21:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbjHaBMO (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Aug 2023 21:12:14 -0400
Received: from hsmtpd-def.xspmail.jp (hsmtpd-def.xspmail.jp [202.238.198.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59EDCD6
        for <linux-sh@vger.kernel.org>; Wed, 30 Aug 2023 18:12:07 -0700 (PDT)
X-Country-Code: JP
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by hsmtpd-out-0.asahinet.cluster.xspmail.jp (Halon) with ESMTPA
        id 8543706c-970b-469d-9f7f-589f48082d40;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
Received: from SIOS1075.flets-east.jp (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
        by sakura.ysato.name (Postfix) with ESMTPSA id 0C1921C05D4;
        Thu, 31 Aug 2023 10:12:06 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        glaubitz@physik.fu-berlin.de
Subject: [RESEND RFC PATCH 06/12] drivers/pci: Add SH7751 PCI Host bridge driver.
Date:   Thu, 31 Aug 2023 10:11:53 +0900
Message-Id: <0b72656a4f7154d4d95f7672eb1f2b038751f59a.1693444193.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693444193.git.ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Use Common framework host bridge driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/controller/Kconfig      |   9 +
 drivers/pci/controller/Makefile     |   1 +
 drivers/pci/controller/pci-sh7751.c | 382 ++++++++++++++++++++++++++++
 drivers/pci/controller/pci-sh7751.h | 267 +++++++++++++++++++
 4 files changed, 659 insertions(+)
 create mode 100644 drivers/pci/controller/pci-sh7751.c
 create mode 100644 drivers/pci/controller/pci-sh7751.h

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 8d49bad7f847..2aac15bec897 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -343,6 +343,15 @@ config PCIE_XILINX_CPM
 	  Say 'Y' here if you want kernel support for the
 	  Xilinx Versal CPM host bridge.
 
+config PCI_SH7751
+	bool "Renesas SH7751 PCI controller"
+	depends on OF
+	depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
+	  Host Bridge driver.
+
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 37c8663de7fe..ce96cfe9f1f2 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
 obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
 obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
+obj-$(CONFIG_PCI_SH7751) += pci-sh7751.o
 
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
diff --git a/drivers/pci/controller/pci-sh7751.c b/drivers/pci/controller/pci-sh7751.c
new file mode 100644
index 000000000000..b81f489b4f05
--- /dev/null
+++ b/drivers/pci/controller/pci-sh7751.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas SH7751 PCI Host bridge driver
+ * Copyright (C) 2023 Yoshinori Sato
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/pci-ecam.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <asm-generic/pci.h>
+#include "pci-sh7751.h"
+
+#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
+#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))
+
+DEFINE_RAW_SPINLOCK(pci_config_lock);
+
+/*
+ * PCIC fixups
+ */
+
+#define PCIMCR_MRSET 0x40000000
+#define PCIMCR_RFSH  0x00000004
+
+static void __init julian_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = __raw_readl(bcr + SH7751_BCR1);
+	bcr1 |= 0x00080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	mcr = __raw_readl(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, SH7751_PCICONF5);
+	pcic_writel(0xd0000000, SH7751_PCICONF6);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+static void __init r2dplus_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = ioread32(bcr + SH7751_BCR1);
+	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pcic_writel(bcr1, SH4_PCIBCR1);
+
+	/* Enable all interrupts, so we known what to fix */
+	pcic_writel(0x0000c3ff, SH4_PCIINTM);
+	pcic_writel(0x0000380f, SH4_PCIAINTM);
+
+	pcic_writel(0xfb900047, SH7751_PCICONF1);
+	pcic_writel(0xab000001, SH7751_PCICONF4);
+
+	mcr = ioread32(bcr + SH7751_MCR);
+	mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
+	pcic_writel(mcr, SH4_PCIMCR);
+
+	pcic_writel(0x0c000000, SH7751_PCICONF5);
+	pcic_writel(0xd0000000, SH7751_PCICONF6);
+	pcic_writel(0x0c000000, SH4_PCILAR0);
+	pcic_writel(0x00000000, SH4_PCILAR1);
+}
+
+static const __initconst struct fixups {
+	char *compatible;
+	void (*fixup)(void __iomem *pcic_base, void __iomem *bcr);
+} fixup_list[] = {
+	{
+		.compatible = "iodata,julian",
+		.fixup = julian_fixup,
+	},
+	{
+		.compatible = "renesas,rts7751r2dplus",
+		.fixup = r2dplus_fixup,
+	},
+};
+
+static __init void pcic_fixups(struct device_node *np,
+		       void __iomem *pcic, void __iomem *bcr)
+{
+	int i;
+	const struct fixups *f = fixup_list;
+
+	for (i = 0; i < ARRAY_SIZE(fixup_list); i++) {
+		if (of_device_is_compatible(np, f->compatible)) {
+			f->fixup(pcic, bcr);
+			break;
+		}
+	}
+}
+
+/*
+ * Direct access to PCI hardware...
+ */
+#define CONFIG_CMD(bus, devfn, where) \
+	(0x80000000 | (bus->number << 16) | (devfn << 8) | (where & ~3))
+
+/*
+ * Functions for accessing PCI configuration space with type 1 accesses
+ */
+static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
+			   int where, int size, u32 *val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+	unsigned long flags;
+	u32 data;
+
+	/*
+	 * PCIPDR may only be accessed as 32 bit words,
+	 * so we must do byte alignment by hand
+	 */
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pcic_readl(SH4_PCIPDR);
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	switch (size) {
+	case 1:
+		*val = (data >> ((where & 3) << 3)) & 0xff;
+		break;
+	case 2:
+		*val = (data >> ((where & 2) << 3)) & 0xffff;
+		break;
+	case 4:
+		*val = data;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ * Since SH4 only does 32bit access we'll have to do a read,
+ * mask,write operation.
+ * We'll allow an odd byte offset, though it should be illegal.
+ */
+static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
+			 int where, int size, u32 val)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+	unsigned long flags;
+	int shift;
+	u32 data;
+
+	raw_spin_lock_irqsave(&pci_config_lock, flags);
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pcic_readl(SH4_PCIPDR);
+	raw_spin_unlock_irqrestore(&pci_config_lock, flags);
+
+	switch (size) {
+	case 1:
+		shift = (where & 3) << 3;
+		data &= ~(0xff << shift);
+		data |= ((val & 0xff) << shift);
+		break;
+	case 2:
+		shift = (where & 2) << 3;
+		data &= ~(0xffff << shift);
+		data |= ((val & 0xffff) << shift);
+		break;
+	case 4:
+		data = val;
+		break;
+	default:
+		return PCIBIOS_FUNC_NOT_SUPPORTED;
+	}
+
+	pcic_writel(data, SH4_PCIPDR);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+/*
+ *  Called after each bus is probed, but before its children
+ *  are examined.
+ */
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+}
+
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+					      resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	return start;
+}
+
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	/*
+	 * I/O space can be accessed via normal processor loads and stores on
+	 * this platform but for now we elect not to do this and portable
+	 * drivers should not do this anyway.
+	 */
+	if (mmap_state == pci_mmap_io)
+		return -EINVAL;
+
+	/*
+	 * Ignore write-combine; for now only return uncached mappings.
+	 */
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot);
+}
+
+static int __init area_sdram_check(void __iomem *pci_reg_base,
+				   void __iomem *bcr,
+				   unsigned int area)
+{
+	unsigned long word;
+
+	word = __raw_readl(bcr + SH7751_BCR1);
+	/* check BCR for SDRAM in area */
+	if (((word >> area) & 1) == 0) {
+		pr_info("PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",
+		       area, word);
+		return 0;
+	}
+	pcic_writel(word, SH4_PCIBCR1);
+
+	word = __raw_readw(bcr + SH7751_BCR2);
+	/* check BCR2 for 32bit SDRAM interface*/
+	if (((word >> (area << 1)) & 0x3) != 0x3) {
+		pr_info("PCI: Area %d is not 32 bit SDRAM. BCR2=0x%lx\n",
+		       area, word);
+		return 0;
+	}
+	pcic_writel(word, SH4_PCIBCR2);
+
+	return 1;
+}
+
+static __init int sh7751_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res, *wres;
+	u32 id;
+	u32 reg, word;
+	void __iomem *pci_reg_base;
+	void __iomem *bcr;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pci_reg_base = (void __iomem *)res->start;
+	if (IS_ERR(pci_reg_base))
+		return PTR_ERR(pci_reg_base);
+
+	wres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(wres))
+		return PTR_ERR(wres);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	bcr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pci_reg_base))
+		return PTR_ERR(bcr);
+
+	/* check for SH7751/SH7751R hardware */
+	id = pcic_readl(SH7751_PCICONF0);
+	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
+	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
+		pr_warn("PCI: This is not an SH7751(R)\n");
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "PCI core found at %p\n",
+		pci_reg_base);
+
+	/* Set the BCR's to enable PCI access */
+	reg = __raw_readl(bcr);
+	reg |= 0x80000;
+	__raw_writel(reg, bcr);
+
+	/* Turn the clocks back on (not done in reset)*/
+	pcic_writel(0, SH4_PCICLKR);
+	/* Clear Powerdown IRQ's (not done in reset) */
+	word = SH4_PCIPINT_D3 | SH4_PCIPINT_D0;
+	pcic_writel(word, SH4_PCIPINT);
+
+	/* set the command/status bits to:
+	 * Wait Cycle Control + Parity Enable + Bus Master +
+	 * Mem space enable
+	 */
+	word = SH7751_PCICONF1_WCC | SH7751_PCICONF1_PER |
+	       SH7751_PCICONF1_BUM | SH7751_PCICONF1_MES;
+	pcic_writel(word, SH7751_PCICONF1);
+
+	/* define this host as the host bridge */
+	word = PCI_BASE_CLASS_BRIDGE << 24;
+	pcic_writel(word, SH7751_PCICONF2);
+
+	/* Set IO and Mem windows to local address
+	 * Make PCI and local address the same for easy 1 to 1 mapping
+	 */
+	word = wres->end - wres->start - 1;
+	pcic_writel(word, SH4_PCILSR0);
+	/* Set the values on window 0 PCI config registers */
+	word = P2SEGADDR(wres->start);
+	pcic_writel(word, SH4_PCILAR0);
+	pcic_writel(word, SH7751_PCICONF5);
+
+	/* check BCR for SDRAM in specified area */
+	area_sdram_check(pci_reg_base, bcr, (wres->start >> 27) & 0x07);
+
+	/* configure the wait control registers */
+	word = __raw_readl(bcr + SH7751_WCR1);
+	pcic_writel(word, SH4_PCIWCR1);
+	word = __raw_readl(bcr + SH7751_WCR2);
+	pcic_writel(word, SH4_PCIWCR2);
+	word = __raw_readl(bcr + SH7751_WCR3);
+	pcic_writel(word, SH4_PCIWCR3);
+	word = __raw_readl(bcr + SH7751_MCR);
+	pcic_writel(word, SH4_PCIMCR);
+
+	pcic_fixups(pdev->dev.of_node, pci_reg_base, bcr);
+
+	/* SH7751 init done, set central function init complete */
+	/* use round robin mode to stop a device starving/overruning */
+	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
+	pcic_writel(word, SH4_PCICR);
+
+	return pci_host_common_probe(pdev);
+}
+
+static void __iomem *sh4_pci_map_bus(struct pci_bus *bus,
+				     unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pci_reg_base = (void __iomem *)cfg->res.start;
+
+	pcic_writel(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	return pci_reg_base + SH4_PCIPDR;
+}
+
+static const struct pci_ecam_ops pci_sh7751_bus_ops = {
+	.pci_ops	= {
+		.map_bus	= sh4_pci_map_bus,
+		.read		= sh4_pci_read,
+		.write		= sh4_pci_write,
+	}
+};
+
+static const struct of_device_id sh7751_pci_of_match[] = {
+	{ .compatible = "renesas,sh7751-pci",
+	  .data = &pci_sh7751_bus_ops },
+
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sh7751_pci_of_match);
+
+static struct platform_driver sh7751_pci_driver = {
+	.driver = {
+		.name = "sh7751-pci",
+		.of_match_table = sh7751_pci_of_match,
+	},
+	.probe = sh7751_pci_probe,
+};
+module_platform_driver(sh7751_pci_driver);
+
+MODULE_DESCRIPTION("SH7751 PCI Host brige driver");
+MODULE_AUTHOR("Yoshinori Sato");
+
diff --git a/drivers/pci/controller/pci-sh7751.h b/drivers/pci/controller/pci-sh7751.h
new file mode 100644
index 000000000000..b2d74d57addb
--- /dev/null
+++ b/drivers/pci/controller/pci-sh7751.h
@@ -0,0 +1,267 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *	Low-Level PCI Support for SH7751 targets
+ *
+ *  Dustin McIntire (dustin@sensoria.com) (c) 2001
+ *  Paul Mundt (lethal@linux-sh.org) (c) 2003
+ *
+ */
+
+#ifndef _PCI_SH7751_H_
+#define _PCI_SH7751_H_
+
+#define SH4_PCICR		0x100		/* PCI Control Register */
+  #define SH4_PCICR_PREFIX	  0xA5000000	/* CR prefix for write */
+  #define SH4_PCICR_FTO		  0x00000400	/* TRDY/IRDY Enable */
+  #define SH4_PCICR_TRSB	  0x00000200	/* Target Read Single */
+  #define SH4_PCICR_BSWP	  0x00000100	/* Target Byte Swap */
+  #define SH4_PCICR_PLUP	  0x00000080	/* Enable PCI Pullup */
+  #define SH4_PCICR_ARBM	  0x00000040	/* PCI Arbitration Mode */
+  #define SH4_PCICR_MD		  0x00000030	/* MD9 and MD10 status */
+  #define SH4_PCICR_SERR	  0x00000008	/* SERR output assert */
+  #define SH4_PCICR_INTA	  0x00000004	/* INTA output assert */
+  #define SH4_PCICR_PRST	  0x00000002	/* PCI Reset Assert */
+  #define SH4_PCICR_CFIN	  0x00000001	/* Central Fun. Init Done */
+#define SH4_PCILSR0		0x104		/* PCI Local Space Register0 */
+#define SH4_PCILSR1		0x108		/* PCI Local Space Register1 */
+#define SH4_PCILAR0		0x10C		/* PCI Local Addr Register1 */
+#define SH4_PCILAR1		0x110		/* PCI Local Addr Register1 */
+#define SH4_PCIINT		0x114		/* PCI Interrupt Register */
+  #define SH4_PCIINT_MLCK	  0x00008000	/* Master Lock Error */
+  #define SH4_PCIINT_TABT	  0x00004000	/* Target Abort Error */
+  #define SH4_PCIINT_TRET	  0x00000200	/* Target Retry Error */
+  #define SH4_PCIINT_MFDE	  0x00000100	/* Master Func. Disable Error */
+  #define SH4_PCIINT_PRTY	  0x00000080	/* Address Parity Error */
+  #define SH4_PCIINT_SERR	  0x00000040	/* SERR Detection Error */
+  #define SH4_PCIINT_TWDP	  0x00000020	/* Tgt. Write Parity Error */
+  #define SH4_PCIINT_TRDP	  0x00000010	/* Tgt. Read Parity Err Det. */
+  #define SH4_PCIINT_MTABT	  0x00000008	/* Master-Tgt. Abort Error */
+  #define SH4_PCIINT_MMABT	  0x00000004	/* Master-Master Abort Error */
+  #define SH4_PCIINT_MWPD	  0x00000002	/* Master Write PERR Detect */
+  #define SH4_PCIINT_MRPD	  0x00000001	/* Master Read PERR Detect */
+#define SH4_PCIINTM		0x118		/* PCI Interrupt Mask */
+  #define SH4_PCIINTM_TTADIM	  BIT(14)	/* Target-target abort interrupt */
+  #define SH4_PCIINTM_TMTOIM	  BIT(9)	/* Target retry timeout */
+  #define SH4_PCIINTM_MDEIM	  BIT(8)	/* Master function disable error */
+  #define SH4_PCIINTM_APEDIM	  BIT(7)	/* Address parity error detection */
+  #define SH4_PCIINTM_SDIM	  BIT(6)	/* SERR detection */
+  #define SH4_PCIINTM_DPEITWM	  BIT(5)	/* Data parity error for target write */
+  #define SH4_PCIINTM_PEDITRM	  BIT(4)	/* PERR detection for target read */
+  #define SH4_PCIINTM_TADIMM	  BIT(3)	/* Target abort for master */
+  #define SH4_PCIINTM_MADIMM	  BIT(2)	/* Master abort for master */
+  #define SH4_PCIINTM_MWPDIM	  BIT(1)	/* Master write data parity error */
+  #define SH4_PCIINTM_MRDPEIM	  BIT(0)	/* Master read data parity error */
+#define SH4_PCIALR		0x11C		/* Error Address Register */
+#define SH4_PCICLR		0x120		/* Error Command/Data */
+  #define SH4_PCICLR_MPIO	  0x80000000
+  #define SH4_PCICLR_MDMA0	  0x40000000	/* DMA0 Transfer Error */
+  #define SH4_PCICLR_MDMA1	  0x20000000	/* DMA1 Transfer Error */
+  #define SH4_PCICLR_MDMA2	  0x10000000	/* DMA2 Transfer Error */
+  #define SH4_PCICLR_MDMA3	  0x08000000	/* DMA3 Transfer Error */
+  #define SH4_PCICLR_TGT	  0x04000000	/* Target Transfer Error */
+  #define SH4_PCICLR_CMDL	  0x0000000F	/* PCI Command at Error */
+#define SH4_PCIAINT		0x130		/* Arbiter Interrupt Register */
+  #define SH4_PCIAINT_MBKN	  0x00002000	/* Master Broken Interrupt */
+  #define SH4_PCIAINT_TBTO	  0x00001000	/* Target Bus Time Out */
+  #define SH4_PCIAINT_MBTO	  0x00000800	/* Master Bus Time Out */
+  #define SH4_PCIAINT_TABT	  0x00000008	/* Target Abort */
+  #define SH4_PCIAINT_MABT	  0x00000004	/* Master Abort */
+  #define SH4_PCIAINT_RDPE	  0x00000002	/* Read Data Parity Error */
+  #define SH4_PCIAINT_WDPE	  0x00000001	/* Write Data Parity Error */
+#define SH4_PCIAINTM            0x134		/* Arbiter Int. Mask Register */
+#define SH4_PCIBMLR		0x138		/* Error Bus Master Register */
+  #define SH4_PCIBMLR_REQ4	  0x00000010	/* REQ4 bus master at error */
+  #define SH4_PCIBMLR_REQ3	  0x00000008	/* REQ3 bus master at error */
+  #define SH4_PCIBMLR_REQ2	  0x00000004	/* REQ2 bus master at error */
+  #define SH4_PCIBMLR_REQ1	  0x00000002	/* REQ1 bus master at error */
+  #define SH4_PCIBMLR_REQ0	  0x00000001	/* REQ0 bus master at error */
+#define SH4_PCIDMABT		0x140		/* DMA Transfer Arb. Register */
+  #define SH4_PCIDMABT_RRBN	  0x00000001	/* DMA Arbitor Round-Robin */
+#define SH4_PCIDPA0		0x180		/* DMA0 Transfer Addr. */
+#define SH4_PCIDLA0		0x184		/* DMA0 Local Addr. */
+#define SH4_PCIDTC0		0x188		/* DMA0 Transfer Cnt. */
+#define SH4_PCIDCR0		0x18C		/* DMA0 Control Register */
+  #define SH4_PCIDCR_ALGN	  0x00000600	/* DMA Alignment Mode */
+  #define SH4_PCIDCR_MAST	  0x00000100	/* DMA Termination Type */
+  #define SH4_PCIDCR_INTM	  0x00000080	/* DMA Interrupt Done Mask*/
+  #define SH4_PCIDCR_INTS	  0x00000040	/* DMA Interrupt Done Status */
+  #define SH4_PCIDCR_LHLD	  0x00000020	/* Local Address Control */
+  #define SH4_PCIDCR_PHLD	  0x00000010	/* PCI Address Control*/
+  #define SH4_PCIDCR_IOSEL	  0x00000008	/* PCI Address Space Type */
+  #define SH4_PCIDCR_DIR	  0x00000004	/* DMA Transfer Direction */
+  #define SH4_PCIDCR_STOP	  0x00000002	/* Force DMA Stop */
+  #define SH4_PCIDCR_STRT	  0x00000001	/* DMA Start */
+#define SH4_PCIDPA1		0x190		/* DMA1 Transfer Addr. */
+#define SH4_PCIDLA1		0x194		/* DMA1 Local Addr. */
+#define SH4_PCIDTC1		0x198		/* DMA1 Transfer Cnt. */
+#define SH4_PCIDCR1		0x19C		/* DMA1 Control Register */
+#define SH4_PCIDPA2		0x1A0		/* DMA2 Transfer Addr. */
+#define SH4_PCIDLA2		0x1A4		/* DMA2 Local Addr. */
+#define SH4_PCIDTC2		0x1A8		/* DMA2 Transfer Cnt. */
+#define SH4_PCIDCR2		0x1AC		/* DMA2 Control Register */
+#define SH4_PCIDPA3		0x1B0		/* DMA3 Transfer Addr. */
+#define SH4_PCIDLA3		0x1B4		/* DMA3 Local Addr. */
+#define SH4_PCIDTC3		0x1B8		/* DMA3 Transfer Cnt. */
+#define SH4_PCIDCR3		0x1BC		/* DMA3 Control Register */
+#define SH4_PCIPAR		0x1C0		/* PIO Address Register */
+  #define SH4_PCIPAR_CFGEN	  0x80000000	/* Configuration Enable */
+  #define SH4_PCIPAR_BUSNO	  0x00FF0000	/* Config. Bus Number */
+  #define SH4_PCIPAR_DEVNO	  0x0000FF00	/* Config. Device Number */
+  #define SH4_PCIPAR_REGAD	  0x000000FC	/* Register Address Number */
+#define SH4_PCIMBR		0x1C4		/* Memory Base Address */
+  #define SH4_PCIMBR_MASK	  0xFF000000	/* Memory Space Mask */
+  #define SH4_PCIMBR_LOCK	  0x00000001	/* Lock Memory Space */
+#define SH4_PCIIOBR		0x1C8		/* I/O Base Address Register */
+  #define SH4_PCIIOBR_MASK	  0xFFFC0000	/* IO Space Mask */
+  #define SH4_PCIIOBR_LOCK	  0x00000001	/* Lock IO Space */
+#define SH4_PCIPINT		0x1CC		/* Power Mgmnt Int. Register */
+  #define SH4_PCIPINT_D3	  0x00000002	/* D3 Pwr Mgmt. Interrupt */
+  #define SH4_PCIPINT_D0	  0x00000001	/* D0 Pwr Mgmt. Interrupt */
+#define SH4_PCIPINTM		0x1D0		/* Power Mgmnt Mask Register */
+#define SH4_PCICLKR		0x1D4		/* Clock Ctrl. Register */
+  #define SH4_PCICLKR_PCSTP	  0x00000002	/* PCI Clock Stop */
+  #define SH4_PCICLKR_BCSTP	  0x00000001	/* BCLK Clock Stop */
+/* For definitions of BCR, MCR see ... */
+#define SH4_PCIBCR1		0x1E0		/* Memory BCR1 Register */
+  #define SH4_PCIMBR0		SH4_PCIBCR1
+#define SH4_PCIBCR2		0x1E4		/* Memory BCR2 Register */
+  #define SH4_PCIMBMR0		SH4_PCIBCR2
+#define SH4_PCIWCR1		0x1E8		/* Wait Control 1 Register */
+#define SH4_PCIWCR2		0x1EC		/* Wait Control 2 Register */
+#define SH4_PCIWCR3		0x1F0		/* Wait Control 3 Register */
+  #define SH4_PCIMBR2		SH4_PCIWCR3
+#define SH4_PCIMCR		0x1F4		/* Memory Control Register */
+#define SH4_PCIBCR3		0x1f8		/* Memory BCR3 Register */
+#define SH4_PCIPCTR             0x200		/* Port Control Register */
+  #define SH4_PCIPCTR_P2EN	  0x000400000	/* Port 2 Enable */
+  #define SH4_PCIPCTR_P1EN	  0x000200000	/* Port 1 Enable */
+  #define SH4_PCIPCTR_P0EN	  0x000100000	/* Port 0 Enable */
+  #define SH4_PCIPCTR_P2UP	  0x000000020	/* Port2 Pull Up Enable */
+  #define SH4_PCIPCTR_P2IO	  0x000000010	/* Port2 Output Enable */
+  #define SH4_PCIPCTR_P1UP	  0x000000008	/* Port1 Pull Up Enable */
+  #define SH4_PCIPCTR_P1IO	  0x000000004	/* Port1 Output Enable */
+  #define SH4_PCIPCTR_P0UP	  0x000000002	/* Port0 Pull Up Enable */
+  #define SH4_PCIPCTR_P0IO	  0x000000001	/* Port0 Output Enable */
+#define SH4_PCIPDTR		0x204		/* Port Data Register */
+  #define SH4_PCIPDTR_PB5	  0x000000020	/* Port 5 Enable */
+  #define SH4_PCIPDTR_PB4	  0x000000010	/* Port 4 Enable */
+  #define SH4_PCIPDTR_PB3	  0x000000008	/* Port 3 Enable */
+  #define SH4_PCIPDTR_PB2	  0x000000004	/* Port 2 Enable */
+  #define SH4_PCIPDTR_PB1	  0x000000002	/* Port 1 Enable */
+  #define SH4_PCIPDTR_PB0	  0x000000001	/* Port 0 Enable */
+#define SH4_PCIPDR		0x220		/* Port IO Data Register */
+
+/* Platform Specific Values */
+#define SH7751_VENDOR_ID             0x1054
+#define SH7751_DEVICE_ID             0x3505
+#define SH7751R_DEVICE_ID            0x350e
+
+/* SH7751 Specific Values */
+#define SH7751_PCI_CONFIG_BASE	     0xFD000000  /* Config space base addr */
+#define SH7751_PCI_CONFIG_SIZE       0x1000000   /* Config space size */
+#define SH7751_PCI_MEMORY_BASE	     0xFD000000  /* Memory space base addr */
+#define SH7751_PCI_MEM_SIZE          0x01000000  /* Size of Memory window */
+#define SH7751_PCI_IO_BASE           0xFE240000  /* IO space base address */
+#define SH7751_PCI_IO_SIZE           0x40000     /* Size of IO window */
+
+#define SH7751_PCIREG_BASE           0xFE200000  /* PCI regs base address */
+
+#define SH7751_PCICONF0            0x0           /* PCI Config Reg 0 */
+  #define SH7751_PCICONF0_DEVID      0xFFFF0000  /* Device ID */
+  #define SH7751_PCICONF0_VNDID      0x0000FFFF  /* Vendor ID */
+#define SH7751_PCICONF1            0x4           /* PCI Config Reg 1 */
+  #define SH7751_PCICONF1_DPE        0x80000000  /* Data Parity Error */
+  #define SH7751_PCICONF1_SSE        0x40000000  /* System Error Status */
+  #define SH7751_PCICONF1_RMA        0x20000000  /* Master Abort */
+  #define SH7751_PCICONF1_RTA        0x10000000  /* Target Abort Rx Status */
+  #define SH7751_PCICONF1_STA        0x08000000  /* Target Abort Exec Status */
+  #define SH7751_PCICONF1_DEV        0x06000000  /* Timing Status */
+  #define SH7751_PCICONF1_DPD        0x01000000  /* Data Parity Status */
+  #define SH7751_PCICONF1_FBBC       0x00800000  /* Back 2 Back Status */
+  #define SH7751_PCICONF1_UDF        0x00400000  /* User Defined Status */
+  #define SH7751_PCICONF1_66M        0x00200000  /* 66Mhz Operation Status */
+  #define SH7751_PCICONF1_PM         0x00100000  /* Power Management Status */
+  #define SH7751_PCICONF1_PBBE       0x00000200  /* Back 2 Back Control */
+  #define SH7751_PCICONF1_SER        0x00000100  /* SERR Output Control */
+  #define SH7751_PCICONF1_WCC        0x00000080  /* Wait Cycle Control */
+  #define SH7751_PCICONF1_PER        0x00000040  /* Parity Error Response */
+  #define SH7751_PCICONF1_VPS        0x00000020  /* VGA Pallet Snoop */
+  #define SH7751_PCICONF1_MWIE       0x00000010  /* Memory Write+Invalidate */
+  #define SH7751_PCICONF1_SPC        0x00000008  /* Special Cycle Control */
+  #define SH7751_PCICONF1_BUM        0x00000004  /* Bus Master Control */
+  #define SH7751_PCICONF1_MES        0x00000002  /* Memory Space Control */
+  #define SH7751_PCICONF1_IOS        0x00000001  /* I/O Space Control */
+#define SH7751_PCICONF2            0x8           /* PCI Config Reg 2 */
+  #define SH7751_PCICONF2_BCC        0xFF000000  /* Base Class Code */
+  #define SH7751_PCICONF2_SCC        0x00FF0000  /* Sub-Class Code */
+  #define SH7751_PCICONF2_RLPI       0x0000FF00  /* Programming Interface */
+  #define SH7751_PCICONF2_REV        0x000000FF  /* Revision ID */
+#define SH7751_PCICONF3            0xC           /* PCI Config Reg 3 */
+  #define SH7751_PCICONF3_BIST7      0x80000000  /* Bist Supported */
+  #define SH7751_PCICONF3_BIST6      0x40000000  /* Bist Executing */
+  #define SH7751_PCICONF3_BIST3_0    0x0F000000  /* Bist Passed */
+  #define SH7751_PCICONF3_HD7        0x00800000  /* Single Function device */
+  #define SH7751_PCICONF3_HD6_0      0x007F0000  /* Configuration Layout */
+  #define SH7751_PCICONF3_LAT        0x0000FF00  /* Latency Timer */
+  #define SH7751_PCICONF3_CLS        0x000000FF  /* Cache Line Size */
+#define SH7751_PCICONF4            0x10          /* PCI Config Reg 4 */
+  #define SH7751_PCICONF4_BASE       0xFFFFFFFC  /* I/O Space Base Addr */
+  #define SH7751_PCICONF4_ASI        0x00000001  /* Address Space Type */
+#define SH7751_PCICONF5            0x14          /* PCI Config Reg 5 */
+  #define SH7751_PCICONF5_BASE       0xFFFFFFF0  /* Mem Space Base Addr */
+  #define SH7751_PCICONF5_LAP        0x00000008  /* Prefetch Enabled */
+  #define SH7751_PCICONF5_LAT        0x00000006  /* Local Memory type */
+  #define SH7751_PCICONF5_ASI        0x00000001  /* Address Space Type */
+#define SH7751_PCICONF6            0x18          /* PCI Config Reg 6 */
+  #define SH7751_PCICONF6_BASE       0xFFFFFFF0  /* Mem Space Base Addr */
+  #define SH7751_PCICONF6_LAP        0x00000008  /* Prefetch Enabled */
+  #define SH7751_PCICONF6_LAT        0x00000006  /* Local Memory type */
+  #define SH7751_PCICONF6_ASI        0x00000001  /* Address Space Type */
+/* PCICONF7 - PCICONF10 are undefined */
+#define SH7751_PCICONF11           0x2C          /* PCI Config Reg 11 */
+  #define SH7751_PCICONF11_SSID      0xFFFF0000  /* Subsystem ID */
+  #define SH7751_PCICONF11_SVID      0x0000FFFF  /* Subsystem Vendor ID */
+/* PCICONF12 is undefined */
+#define SH7751_PCICONF13           0x34          /* PCI Config Reg 13 */
+  #define SH7751_PCICONF13_CPTR      0x000000FF  /* PM function pointer */
+/* PCICONF14 is undefined */
+#define SH7751_PCICONF15           0x3C          /* PCI Config Reg 15 */
+  #define SH7751_PCICONF15_IPIN      0x000000FF  /* Interrupt Pin */
+#define SH7751_PCICONF16           0x40          /* PCI Config Reg 16 */
+  #define SH7751_PCICONF16_PMES      0xF8000000  /* PME Support */
+  #define SH7751_PCICONF16_D2S       0x04000000  /* D2 Support */
+  #define SH7751_PCICONF16_D1S       0x02000000  /* D1 Support */
+  #define SH7751_PCICONF16_DSI       0x00200000  /* Bit Device Init. */
+  #define SH7751_PCICONF16_PMCK      0x00080000  /* Clock for PME req. */
+  #define SH7751_PCICONF16_VER       0x00070000  /* PM Version */
+  #define SH7751_PCICONF16_NIP       0x0000FF00  /* Next Item Pointer */
+  #define SH7751_PCICONF16_CID       0x000000FF  /* Capability Identifier */
+#define SH7751_PCICONF17           0x44          /* PCI Config Reg 17 */
+  #define SH7751_PCICONF17_DATA      0xFF000000  /* Data field for PM */
+  #define SH7751_PCICONF17_PMES      0x00800000  /* PME Status */
+  #define SH7751_PCICONF17_DSCL      0x00600000  /* Data Scaling Value */
+  #define SH7751_PCICONF17_DSEL      0x001E0000  /* Data Select */
+  #define SH7751_PCICONF17_PMEN      0x00010000  /* PME Enable */
+  #define SH7751_PCICONF17_PWST      0x00000003  /* Power State */
+/* SH7751 Internal PCI Registers */
+
+/* Memory Control Registers */
+#define SH7751_BCR1                0x0000    /* Memory BCR1 Register */
+#define SH7751_BCR2                0x0004    /* Memory BCR2 Register */
+#define SH7751_BCR3                0x0050    /* Memory BCR3 Register */
+#define SH7751_WCR1                0x0008    /* Wait Control 1 Register */
+#define SH7751_WCR2                0x000C    /* Wait Control 2 Register */
+#define SH7751_WCR3                0x0010    /* Wait Control 3 Register */
+#define SH7751_MCR                 0x0014    /* Memory Control Register */
+
+/* General Memory Config Addresses */
+#define SH7751_CS0_BASE_ADDR       0x0
+#define SH7751_MEM_REGION_SIZE     0x04000000
+#define SH7751_CS1_BASE_ADDR       (SH7751_CS0_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS2_BASE_ADDR       (SH7751_CS1_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS3_BASE_ADDR       (SH7751_CS2_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS4_BASE_ADDR       (SH7751_CS3_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS5_BASE_ADDR       (SH7751_CS4_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+#define SH7751_CS6_BASE_ADDR       (SH7751_CS5_BASE_ADDR + SH7751_MEM_REGION_SIZE)
+
+#endif /* _PCI_SH7751_H_ */
-- 
2.39.2

