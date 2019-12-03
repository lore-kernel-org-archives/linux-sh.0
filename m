From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 03 Dec 2019 16:26:43 +0000
Subject: [PATCH 5/7] sh: pci: Modernize printing of kernel messages
Message-Id: <20191203162645.19950-6-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20191203162645.19950-1-geert+renesas@glider.be>
In-Reply-To: <20191203162645.19950-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

  - Convert from printk() to pr_*(),
  - Add missing continuations,
  - Join broken messages.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.
---
 arch/sh/drivers/pci/common.c     |  6 +++---
 arch/sh/drivers/pci/pci-sh7780.c | 23 +++++++++++------------
 arch/sh/drivers/pci/pci.c        | 11 +++++------
 3 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
index fe163ecd07197073..2fd2b77e12cec1f2 100644
--- a/arch/sh/drivers/pci/common.c
+++ b/arch/sh/drivers/pci/common.c
@@ -54,7 +54,7 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
 	int cap66 = -1;
 	u16 stat;
 
-	printk(KERN_INFO "PCI: Checking 66MHz capabilities...\n");
+	pr_info("PCI: Checking 66MHz capabilities...\n");
 
 	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
 		if (PCI_FUNC(pci_devfn))
@@ -134,7 +134,7 @@ unsigned int pcibios_handle_status_errors(unsigned long addr,
 		pcibios_report_status(PCI_STATUS_REC_TARGET_ABORT |
 				      PCI_STATUS_SIG_TARGET_ABORT |
 				      PCI_STATUS_REC_MASTER_ABORT, 1);
-		printk("\n");
+		pr_cont("\n");
 
 		cmd |= PCI_STATUS_REC_TARGET_ABORT;
 	}
@@ -143,7 +143,7 @@ unsigned int pcibios_handle_status_errors(unsigned long addr,
 		printk(KERN_DEBUG "PCI: parity error detected: ");
 		pcibios_report_status(PCI_STATUS_PARITY |
 				      PCI_STATUS_DETECTED_PARITY, 1);
-		printk("\n");
+		pr_cont("\n");
 
 		cmd |= PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
 
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 287b3a68570cf0ff..9a624a6ee3547924 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -148,7 +148,7 @@ static irqreturn_t sh7780_pci_serr_irq(int irq, void *dev_id)
 
 	printk(KERN_DEBUG "PCI: system error received: ");
 	pcibios_report_status(PCI_STATUS_SIG_SYSTEM_ERROR, 1);
-	printk("\n");
+	pr_cont("\n");
 
 	/* Deassert SERR */
 	__raw_writel(SH4_PCIINTM_SDIM, hose->reg_base + SH4_PCIINTM);
@@ -179,7 +179,7 @@ static int __init sh7780_pci_setup_irqs(struct pci_channel *hose)
 	ret = request_irq(hose->serr_irq, sh7780_pci_serr_irq, 0,
 			  "PCI SERR interrupt", hose);
 	if (unlikely(ret)) {
-		printk(KERN_ERR "PCI: Failed hooking SERR IRQ\n");
+		pr_err("PCI: Failed hooking SERR IRQ\n");
 		return ret;
 	}
 
@@ -250,7 +250,7 @@ static int __init sh7780_pci_init(void)
 	const char *type;
 	int ret, i;
 
-	printk(KERN_NOTICE "PCI: Starting initialization.\n");
+	pr_notice("PCI: Starting initialization.\n");
 
 	chan->reg_base = 0xfe040000;
 
@@ -270,7 +270,7 @@ static int __init sh7780_pci_init(void)
 
 	id = __raw_readw(chan->reg_base + PCI_VENDOR_ID);
 	if (id != PCI_VENDOR_ID_RENESAS) {
-		printk(KERN_ERR "PCI: Unknown vendor ID 0x%04x.\n", id);
+		pr_err("PCI: Unknown vendor ID 0x%04x.\n", id);
 		return -ENODEV;
 	}
 
@@ -281,14 +281,13 @@ static int __init sh7780_pci_init(void)
 	       (id = PCI_DEVICE_ID_RENESAS_SH7785) ? "SH7785" :
 					  NULL;
 	if (unlikely(!type)) {
-		printk(KERN_ERR "PCI: Found an unsupported Renesas host "
-		       "controller, device id 0x%04x.\n", id);
+		pr_err("PCI: Found an unsupported Renesas host controller, device id 0x%04x.\n",
+		       id);
 		return -EINVAL;
 	}
 
-	printk(KERN_NOTICE "PCI: Found a Renesas %s host "
-	       "controller, revision %d.\n", type,
-	       __raw_readb(chan->reg_base + PCI_REVISION_ID));
+	pr_notice("PCI: Found a Renesas %s host controller, revision %d.\n",
+		  type, __raw_readb(chan->reg_base + PCI_REVISION_ID));
 
 	/*
 	 * Now throw it in to register initialization mode and
@@ -395,9 +394,9 @@ static int __init sh7780_pci_init(void)
 
 	sh7780_pci66_init(chan);
 
-	printk(KERN_NOTICE "PCI: Running at %dMHz.\n",
-	       (__raw_readw(chan->reg_base + PCI_STATUS) & PCI_STATUS_66MHZ) ?
-	       66 : 33);
+	pr_notice("PCI: Running at %dMHz.\n",
+		  (__raw_readw(chan->reg_base + PCI_STATUS) & PCI_STATUS_66MHZ)
+		  ? 66 : 33);
 
 	return 0;
 
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index c7784e1569644d76..6ab0b7377f6634fc 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -120,8 +120,7 @@ int register_pci_controller(struct pci_channel *hose)
 	 * Do not panic here but later - this might happen before console init.
 	 */
 	if (!hose->io_map_base) {
-		printk(KERN_WARNING
-		       "registering PCI controller with io_map_base unset\n");
+		pr_warn("registering PCI controller with io_map_base unset\n");
 	}
 
 	/*
@@ -145,7 +144,7 @@ int register_pci_controller(struct pci_channel *hose)
 	for (--i; i >= 0; i--)
 		release_resource(&hose->resources[i]);
 
-	printk(KERN_WARNING "Skipping PCI bus scan due to resource conflict\n");
+	pr_warn("Skipping PCI bus scan due to resource conflict\n");
 	return -1;
 }
 
@@ -213,8 +212,8 @@ pcibios_bus_report_status_early(struct pci_channel *hose,
 					pci_devfn, PCI_STATUS,
 					status & status_mask);
 		if (warn)
-			printk("(%02x:%02x: %04X) ", current_bus,
-			       pci_devfn, status);
+			pr_cont("(%02x:%02x: %04X) ", current_bus, pci_devfn,
+				status);
 	}
 }
 
@@ -249,7 +248,7 @@ pcibios_bus_report_status(struct pci_bus *bus, unsigned int status_mask,
 		pci_write_config_word(dev, PCI_STATUS, status & status_mask);
 
 		if (warn)
-			printk("(%s: %04X) ", pci_name(dev), status);
+			pr_cont("(%s: %04X) ", pci_name(dev), status);
 	}
 
 	list_for_each_entry(dev, &bus->devices, bus_list)
-- 
2.17.1
