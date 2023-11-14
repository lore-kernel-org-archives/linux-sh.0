Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAE6C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjKNIA7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjKNIA6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:00:58 -0500
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD1F7195
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:00:54 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
        by sakura.ysato.name (Postfix) with ESMTPSA id B554C1C04D0;
        Tue, 14 Nov 2023 17:00:53 +0900 (JST)
From:   Yoshinori Sato <ysato@users.sourceforge.jp>
To:     linux-sh@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 12/37] pci: pci-sh7751: Add SH7751 PCI driver
Date:   Tue, 14 Nov 2023 17:00:03 +0900
Message-Id: <90c0f0810c778e4f515bb9d8582b501d77e2bf1a.1699856600.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Renesas SH7751 CPU Internal PCI Controller driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/pci/controller/Kconfig      |   9 +
 drivers/pci/controller/Makefile     |   1 +
 drivers/pci/controller/pci-sh7751.c | 293 ++++++++++++++++++++++++++++
 3 files changed, 303 insertions(+)
 create mode 100644 drivers/pci/controller/pci-sh7751.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e534c02ee34f..a2fd917a2e03 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -353,6 +353,15 @@ config PCIE_XILINX_CPM
 	  Say 'Y' here if you want kernel support for the
 	  Xilinx Versal CPM host bridge.
 
+config PCI_SH7751
+	bool "Renesas SH7751 PCI controller"
+	depends on OF
+	depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R || COMPILE_TEST
+	select PCI_HOST_COMMON
+	help
+	  Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
+	  Host Bridge driver.
+
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index f2b19e6174af..aa97e5d74e58 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
 obj-$(CONFIG_PCIE_HISI_ERR) += pcie-hisi-error.o
 obj-$(CONFIG_PCIE_APPLE) += pcie-apple.o
 obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
+obj-$(CONFIG_PCI_SH7751) += pci-sh7751.o
 
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
diff --git a/drivers/pci/controller/pci-sh7751.c b/drivers/pci/controller/pci-sh7751.c
new file mode 100644
index 000000000000..36b4f5e9c4a9
--- /dev/null
+++ b/drivers/pci/controller/pci-sh7751.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SH7751 PCI driver
+ * Copyright (C) 2023 Yoshinori Sato
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
+#include <asm/pci.h>
+#include <asm/addrspace.h>
+#include <asm/pci-sh4.h>
+
+#define pcic_writel(val, base, reg) __raw_writel(val, base + (reg))
+#define pcic_readl(base, reg) __raw_readl(base + (reg))
+
+/* BSC registers offset */
+#define BSC_BCR1	0x00000000
+#define BSC_BCR2	0x00000004
+#define BSC_WCR1	0x00000008
+#define BSC_WCR2	0x0000000c
+#define BSC_WCR3	0x00000010
+#define BSC_MCR		0x00000014
+
+/*
+ * PCIC fixups
+ */
+
+static inline void pci_fixup_write_regs(struct device_node *np,
+					const char *prop,
+					void __iomem *pcic, int reg,
+					int nr_regs)
+{
+	int i;
+	u32 val;
+
+	for (i = 0; i < nr_regs; i++) {
+		if (of_property_read_u32_index(np, prop, i, &val))
+			pcic_writel(val, pcic, reg + i * 4);
+	}
+}
+
+#define SH7751_NUM_CONFIG 18
+static void pcic_fixups(struct device_node *np,
+		       void __iomem *pcic, void __iomem *bsc)
+{
+	unsigned long bcr1, mcr;
+	u32 val;
+	int i, r;
+	u32 pci_config[SH7751_NUM_CONFIG * 2];
+
+	const struct {
+		const char *name;
+		int reg;
+		int nr;
+	} reg_prop[] = {
+		/*
+		 *  The bus timing uses the bootloader settings,
+		 *  so do not change them here.
+		 */
+		{ "renesas,intm",  SH4_PCIINTM,  1, },
+		{ "renesas,aintm", SH4_PCIAINTM, 1, },
+		{ "renesas,lsr",   SH4_PCILSR0,  2, },
+		{ "renesas,lar",   SH4_PCILAR0,  2, },
+		{ "renesas,dmabt", SH4_PCIDMABT, 1, },
+		{ "renesas,pintm", SH4_PCIPINTM, 1, },
+	};
+
+	if (of_property_read_u32(np, "sh7751-pci,bcr1", &val)) {
+		bcr1 = ioread32(bsc + BSC_BCR1);
+		bcr1 |= val;
+		pcic_writel(bcr1, pcic, SH4_PCIBCR1);
+	}
+	if (of_property_read_u32(np, "renesas,clkr", &val)) {
+		val = (0xa5 << 24) | (val & 0xffffff);
+		pcic_writel(val, pcic, SH4_PCICLKR);
+	}
+	for (i = 0; i < ARRAY_SIZE(reg_prop); i++)
+		pci_fixup_write_regs(np, reg_prop[i].name, pcic,
+				     reg_prop[i].reg, reg_prop[i].nr);
+
+	memset(pci_config, 0, sizeof(pci_config));
+	if (of_property_read_u32_array(np, "renesas,config",
+				       pci_config, SH7751_NUM_CONFIG) == 0) {
+		for (i = 0; i < SH7751_NUM_CONFIG; i++) {
+			r = pci_config[i * 2];
+			/* CONFIG0 is read-only, so make it a sentinel. */
+			if (r == 0)
+				break;
+			pcic_writel(pci_config[i * 2 + 1], pcic,
+				    SH7751_PCICONF0 + r * 4);
+		}
+	}
+
+	if (of_property_read_u32(np, "sh7751-pci,mcrmask", &val)) {
+		mcr = ioread32(bsc + BSC_MCR);
+		mcr &= ~val;
+		pcic_writel(mcr, pcic, SH4_PCIMCR);
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
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ */
+#define IO_REGION_BASE 0x1000
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+
+	if (res->flags & IORESOURCE_IO) {
+		if (start < PCIBIOS_MIN_IO + IO_REGION_BASE)
+			start = PCIBIOS_MIN_IO + IO_REGION_BASE;
+
+		/*
+		 * Put everything into 0x00-0xff region modulo 0x400.
+		 */
+		if (start & 0x300)
+			start = (start + 0x3ff) & ~0x3ff;
+	}
+
+	return start;
+}
+
+static int area_sdram_check(struct device *dev, void __iomem *pcic,
+			    void __iomem *bsc, unsigned int area)
+{
+	unsigned long word;
+
+	word = __raw_readl(bsc + BSC_BCR1);
+	/* check BCR for SDRAM in area */
+	if (((word >> area) & 1) == 0) {
+		dev_info(dev, "PCI: Area %d is not configured for SDRAM. BCR1=0x%lx\n",
+		       area, word);
+		return 0;
+	}
+	pcic_writel(word, pcic, SH4_PCIBCR1);
+
+	word = __raw_readw(bsc + BSC_BCR2);
+	/* check BCR2 for 32bit SDRAM interface*/
+	if (((word >> (area << 1)) & 0x3) != 0x3) {
+		dev_info(dev, "PCI: Area %d is not 32 bit SDRAM. BCR2=0x%lx\n",
+			area, word);
+		return 0;
+	}
+	pcic_writel(word, pcic, SH4_PCIBCR2);
+
+	return 1;
+}
+
+static void set_pci_window(void __iomem *pcic, int no, struct resource *res)
+{
+	u32 word;
+
+	word = res->end - res->start - 1;
+	pcic_writel(word, pcic, SH4_PCILSR0 + no * 4);
+	word = P2SEGADDR(res->start);
+	pcic_writel(word, pcic, SH4_PCILAR0 + no * 4);
+	pcic_writel(word, pcic, SH7751_PCICONF5 + no * 4);
+}
+
+static int sh7751_pci_probe(struct platform_device *pdev)
+{
+	struct resource *res, *w0res;
+	u32 id;
+	u32 reg, word;
+	void __iomem *pcic;
+	void __iomem *bsc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pcic = (void __iomem *)res->start;
+	if (IS_ERR(pcic))
+		return PTR_ERR(pcic);
+
+	w0res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(w0res))
+		return PTR_ERR(w0res);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	bsc = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(bsc))
+		return PTR_ERR(bsc);
+
+	/* check for SH7751/SH7751R hardware */
+	id = pcic_readl(pcic, SH7751_PCICONF0);
+	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
+	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
+		dev_warn(&pdev->dev, "PCI: This is not an SH7751(R)\n");
+		return -ENODEV;
+	}
+	dev_info(&pdev->dev, "PCI core found at %pR\n", pcic);
+
+	/* Set the BCR's to enable PCI access */
+	reg = __raw_readl(bsc);
+	reg |= 0x80000;
+	__raw_writel(reg, bsc);
+
+	/* Turn the clocks back on (not done in reset)*/
+	pcic_writel(0, pcic, SH4_PCICLKR);
+	/* Clear Powerdown IRQ's (not done in reset) */
+	word = SH4_PCIPINT_D3 | SH4_PCIPINT_D0;
+	pcic_writel(word, pcic, SH4_PCIPINT);
+
+	/* set the command/status bits to:
+	 * Wait Cycle Control + Parity Enable + Bus Master +
+	 * Mem space enable
+	 */
+	word = SH7751_PCICONF1_WCC | SH7751_PCICONF1_PER |
+	       SH7751_PCICONF1_BUM | SH7751_PCICONF1_MES;
+	pcic_writel(word, pcic, SH7751_PCICONF1);
+
+	/* define this host as the host bridge */
+	word = PCI_BASE_CLASS_BRIDGE << 24;
+	pcic_writel(word, pcic, SH7751_PCICONF2);
+
+	/* Set IO and Mem windows to local address
+	 * Make PCI and local address the same for easy 1 to 1 mapping
+	 */
+	set_pci_window(pcic, 0, w0res);	/* memory */
+
+	/* check BCR for SDRAM in specified area */
+	area_sdram_check(&pdev->dev, pcic, bsc, (w0res->start >> 27) & 0x07);
+
+	/* configure the wait control registers */
+	word = __raw_readl(bsc + BSC_WCR1);
+	pcic_writel(word, pcic, SH4_PCIWCR1);
+	word = __raw_readl(bsc + BSC_WCR2);
+	pcic_writel(word, pcic, SH4_PCIWCR2);
+	word = __raw_readl(bsc + BSC_WCR3);
+	pcic_writel(word, pcic, SH4_PCIWCR3);
+	word = __raw_readl(bsc + BSC_MCR);
+	pcic_writel(word, pcic, SH4_PCIMCR);
+
+	/* Override register setting */
+	pcic_fixups(pdev->dev.of_node, pcic, bsc);
+
+	/* SH7751 init done, set central function init complete */
+	/* use round robin mode to stop a device starving/overrunning */
+	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
+	pcic_writel(word, pcic, SH4_PCICR);
+
+	return pci_host_common_probe(pdev);
+}
+
+static void __iomem *sh4_pci_map_bus(struct pci_bus *bus,
+				     unsigned int devfn, int where)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	void __iomem *pcic = (void __iomem *)cfg->res.start;
+
+	pcic_writel(CONFIG_CMD(bus, devfn, where), pcic, SH4_PCIPAR);
+	return pcic + SH4_PCIPDR;
+}
+
+static const struct pci_ecam_ops pci_sh7751_bus_ops = {
+	.pci_ops	= {
+		.map_bus = sh4_pci_map_bus,
+		.read    = pci_generic_config_read32,
+		.write   = pci_generic_config_write32,
+	}
+};
+
+static const struct of_device_id sh7751_pci_of_match[] = {
+	{ .compatible = "renesas,sh7751-pci",
+	  .data = &pci_sh7751_bus_ops },
+	{ }
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
+MODULE_DESCRIPTION("SH7751 PCI driver");
-- 
2.39.2

