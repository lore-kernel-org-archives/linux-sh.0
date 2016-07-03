From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:35 +0000
Subject: [PATCH v5 15/22] sh: Move common PCI stuff to arch/sh/kernel
Message-Id: <1467564402-2649-16-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/drivers/pci/Makefile |   2 -
 arch/sh/drivers/pci/common.c | 162 --------------------
 arch/sh/drivers/pci/pci.c    | 320 ----------------------------------------
 arch/sh/kernel/Makefile      |   2 +
 arch/sh/kernel/pci-common.c  | 162 ++++++++++++++++++++
 arch/sh/kernel/pci.c         | 342 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 506 insertions(+), 484 deletions(-)
 delete mode 100644 arch/sh/drivers/pci/common.c
 delete mode 100644 arch/sh/drivers/pci/pci.c
 create mode 100644 arch/sh/kernel/pci-common.c
 create mode 100644 arch/sh/kernel/pci.c

diff --git a/arch/sh/drivers/pci/Makefile b/arch/sh/drivers/pci/Makefile
index 82f0a33..fffbede 100644
--- a/arch/sh/drivers/pci/Makefile
+++ b/arch/sh/drivers/pci/Makefile
@@ -1,8 +1,6 @@
 #
 # Makefile for the PCI specific kernel interface routines under Linux.
 #
-obj-y					+= common.o pci.o
-
 obj-$(CONFIG_CPU_SUBTYPE_SH7751)	+= pci-sh7751.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7751R)	+= pci-sh7751.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7763)	+= pci-sh7780.o ops-sh4.o
diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
deleted file mode 100644
index dbf1381..0000000
--- a/arch/sh/drivers/pci/common.c
+++ /dev/null
@@ -1,162 +0,0 @@
-#include <linux/pci.h>
-#include <linux/interrupt.h>
-#include <linux/timer.h>
-#include <linux/kernel.h>
-
-/*
- * These functions are used early on before PCI scanning is done
- * and all of the pci_dev and pci_bus structures have been created.
- */
-static struct pci_dev *fake_pci_dev(struct pci_channel *hose,
-	int top_bus, int busnr, int devfn)
-{
-	static struct pci_dev dev;
-	static struct pci_bus bus;
-
-	dev.bus = &bus;
-	dev.sysdata = hose;
-	dev.devfn = devfn;
-	bus.number = busnr;
-	bus.sysdata = hose;
-	bus.ops = hose->pci_ops;
-
-	if(busnr != top_bus)
-		/* Fake a parent bus structure. */
-		bus.parent = &bus;
-	else
-		bus.parent = NULL;
-
-	return &dev;
-}
-
-#define EARLY_PCI_OP(rw, size, type)					\
-int __init early_##rw##_config_##size(struct pci_channel *hose,		\
-	int top_bus, int bus, int devfn, int offset, type value)	\
-{									\
-	return pci_##rw##_config_##size(				\
-		fake_pci_dev(hose, top_bus, bus, devfn),		\
-		offset, value);						\
-}
-
-EARLY_PCI_OP(read, byte, u8 *)
-EARLY_PCI_OP(read, word, u16 *)
-EARLY_PCI_OP(read, dword, u32 *)
-EARLY_PCI_OP(write, byte, u8)
-EARLY_PCI_OP(write, word, u16)
-EARLY_PCI_OP(write, dword, u32)
-
-int __init pci_is_66mhz_capable(struct pci_channel *hose,
-				int top_bus, int current_bus)
-{
-	u32 pci_devfn;
-	unsigned short vid;
-	int cap66 = -1;
-	u16 stat;
-
-	printk(KERN_INFO "PCI: Checking 66MHz capabilities...\n");
-
-	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
-		if (PCI_FUNC(pci_devfn))
-			continue;
-		if (early_read_config_word(hose, top_bus, current_bus,
-					   pci_devfn, PCI_VENDOR_ID, &vid) !-		    PCIBIOS_SUCCESSFUL)
-			continue;
-		if (vid = 0xffff)
-			continue;
-
-		/* check 66MHz capability */
-		if (cap66 < 0)
-			cap66 = 1;
-		if (cap66) {
-			early_read_config_word(hose, top_bus, current_bus,
-					       pci_devfn, PCI_STATUS, &stat);
-			if (!(stat & PCI_STATUS_66MHZ)) {
-				printk(KERN_DEBUG
-				       "PCI: %02x:%02x not 66MHz capable.\n",
-				       current_bus, pci_devfn);
-				cap66 = 0;
-				break;
-			}
-		}
-	}
-
-	return cap66 > 0;
-}
-
-static void pcibios_enable_err(unsigned long __data)
-{
-	struct pci_channel *hose = (struct pci_channel *)__data;
-
-	del_timer(&hose->err_timer);
-	printk(KERN_DEBUG "PCI: re-enabling error IRQ.\n");
-	enable_irq(hose->err_irq);
-}
-
-static void pcibios_enable_serr(unsigned long __data)
-{
-	struct pci_channel *hose = (struct pci_channel *)__data;
-
-	del_timer(&hose->serr_timer);
-	printk(KERN_DEBUG "PCI: re-enabling system error IRQ.\n");
-	enable_irq(hose->serr_irq);
-}
-
-void pcibios_enable_timers(struct pci_channel *hose)
-{
-	if (hose->err_irq) {
-		init_timer(&hose->err_timer);
-		hose->err_timer.data = (unsigned long)hose;
-		hose->err_timer.function = pcibios_enable_err;
-	}
-
-	if (hose->serr_irq) {
-		init_timer(&hose->serr_timer);
-		hose->serr_timer.data = (unsigned long)hose;
-		hose->serr_timer.function = pcibios_enable_serr;
-	}
-}
-
-/*
- * A simple handler for the regular PCI status errors, called from IRQ
- * context.
- */
-unsigned int pcibios_handle_status_errors(unsigned long addr,
-					  unsigned int status,
-					  struct pci_channel *hose)
-{
-	unsigned int cmd = 0;
-
-	if (status & PCI_STATUS_REC_MASTER_ABORT) {
-		printk(KERN_DEBUG "PCI: master abort, pc=0x%08lx\n", addr);
-		cmd |= PCI_STATUS_REC_MASTER_ABORT;
-	}
-
-	if (status & PCI_STATUS_REC_TARGET_ABORT) {
-		printk(KERN_DEBUG "PCI: target abort: ");
-		pcibios_report_status(PCI_STATUS_REC_TARGET_ABORT |
-				      PCI_STATUS_SIG_TARGET_ABORT |
-				      PCI_STATUS_REC_MASTER_ABORT, 1);
-		printk("\n");
-
-		cmd |= PCI_STATUS_REC_TARGET_ABORT;
-	}
-
-	if (status & (PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY)) {
-		printk(KERN_DEBUG "PCI: parity error detected: ");
-		pcibios_report_status(PCI_STATUS_PARITY |
-				      PCI_STATUS_DETECTED_PARITY, 1);
-		printk("\n");
-
-		cmd |= PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
-
-		/* Now back off of the IRQ for awhile */
-		if (hose->err_irq) {
-			disable_irq_nosync(hose->err_irq);
-			hose->err_timer.expires = jiffies + HZ;
-			add_timer(&hose->err_timer);
-		}
-	}
-
-	return cmd;
-}
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
deleted file mode 100644
index d5462b7..0000000
--- a/arch/sh/drivers/pci/pci.c
+++ /dev/null
@@ -1,320 +0,0 @@
-/*
- * New-style PCI core.
- *
- * Copyright (c) 2004 - 2009  Paul Mundt
- * Copyright (c) 2002  M. R. Brown
- *
- * Modelled after arch/mips/pci/pci.c:
- *  Copyright (C) 2003, 04 Ralf Baechle (ralf@linux-mips.org)
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/dma-debug.h>
-#include <linux/io.h>
-#include <linux/mutex.h>
-#include <linux/spinlock.h>
-#include <linux/export.h>
-
-unsigned long PCIBIOS_MIN_IO = 0x0000;
-unsigned long PCIBIOS_MIN_MEM = 0;
-
-/*
- * The PCI controller list.
- */
-static struct pci_channel *hose_head, **hose_tail = &hose_head;
-
-static int pci_initialized;
-
-static void pcibios_scanbus(struct pci_channel *hose)
-{
-	static int next_busno;
-	static int need_domain_info;
-	LIST_HEAD(resources);
-	struct resource *res;
-	resource_size_t offset;
-	int i;
-	struct pci_bus *bus;
-
-	for (i = 0; i < hose->nr_resources; i++) {
-		res = hose->resources + i;
-		offset = 0;
-		if (res->flags & IORESOURCE_IO)
-			offset = hose->io_offset;
-		else if (res->flags & IORESOURCE_MEM)
-			offset = hose->mem_offset;
-		pci_add_resource_offset(&resources, res, offset);
-	}
-
-	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
-				&resources);
-	hose->bus = bus;
-
-	need_domain_info = need_domain_info || hose->index;
-	hose->need_domain_info = need_domain_info;
-
-	if (!bus) {
-		pci_free_resource_list(&resources);
-		return;
-	}
-
-	next_busno = bus->busn_res.end + 1;
-	/* Don't allow 8-bit bus number overflow inside the hose -
-	   reserve some space for bridges. */
-	if (next_busno > 224) {
-		next_busno = 0;
-		need_domain_info = 1;
-	}
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-	pci_bus_add_devices(bus);
-}
-
-/*
- * This interrupt-safe spinlock protects all accesses to PCI
- * configuration space.
- */
-DEFINE_RAW_SPINLOCK(pci_config_lock);
-static DEFINE_MUTEX(pci_scan_mutex);
-
-int register_pci_controller(struct pci_channel *hose)
-{
-	int i;
-
-	for (i = 0; i < hose->nr_resources; i++) {
-		struct resource *res = hose->resources + i;
-
-		if (res->flags & IORESOURCE_IO) {
-			if (request_resource(&ioport_resource, res) < 0)
-				goto out;
-		} else {
-			if (request_resource(&iomem_resource, res) < 0)
-				goto out;
-		}
-	}
-
-	*hose_tail = hose;
-	hose_tail = &hose->next;
-
-	/*
-	 * Do not panic here but later - this might happen before console init.
-	 */
-	if (!hose->io_map_base) {
-		printk(KERN_WARNING
-		       "registering PCI controller with io_map_base unset\n");
-	}
-
-	/*
-	 * Setup the ERR/PERR and SERR timers, if available.
-	 */
-	pcibios_enable_timers(hose);
-
-	/*
-	 * Scan the bus if it is register after the PCI subsystem
-	 * initialization.
-	 */
-	if (pci_initialized) {
-		mutex_lock(&pci_scan_mutex);
-		pcibios_scanbus(hose);
-		mutex_unlock(&pci_scan_mutex);
-	}
-
-	return 0;
-
-out:
-	for (--i; i >= 0; i--)
-		release_resource(&hose->resources[i]);
-
-	printk(KERN_WARNING "Skipping PCI bus scan due to resource conflict\n");
-	return -1;
-}
-
-static int __init pcibios_init(void)
-{
-	struct pci_channel *hose;
-
-	/* Scan all of the recorded PCI controllers.  */
-	for (hose = hose_head; hose; hose = hose->next)
-		pcibios_scanbus(hose);
-
-	pci_fixup_irqs(pci_common_swizzle, pcibios_map_platform_irq);
-
-	dma_debug_add_bus(&pci_bus_type);
-
-	pci_initialized = 1;
-
-	return 0;
-}
-subsys_initcall(pcibios_init);
-
-/*
- *  Called after each bus is probed, but before its children
- *  are examined.
- */
-void pcibios_fixup_bus(struct pci_bus *bus)
-{
-}
-
-/*
- * We need to avoid collisions with `mirrored' VGA ports
- * and other strange ISA hardware, so we always want the
- * addresses to be allocated in the 0x000-0x0ff region
- * modulo 0x400.
- */
-resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-				resource_size_t size, resource_size_t align)
-{
-	struct pci_dev *dev = data;
-	struct pci_channel *hose = dev->sysdata;
-	resource_size_t start = res->start;
-
-	if (res->flags & IORESOURCE_IO) {
-		if (start < PCIBIOS_MIN_IO + hose->resources[0].start)
-			start = PCIBIOS_MIN_IO + hose->resources[0].start;
-
-		/*
-                 * Put everything into 0x00-0xff region modulo 0x400.
-		 */
-		if (start & 0x300)
-			start = (start + 0x3ff) & ~0x3ff;
-	}
-
-	return start;
-}
-
-static void __init
-pcibios_bus_report_status_early(struct pci_channel *hose,
-				int top_bus, int current_bus,
-				unsigned int status_mask, int warn)
-{
-	unsigned int pci_devfn;
-	u16 status;
-	int ret;
-
-	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
-		if (PCI_FUNC(pci_devfn))
-			continue;
-		ret = early_read_config_word(hose, top_bus, current_bus,
-					     pci_devfn, PCI_STATUS, &status);
-		if (ret != PCIBIOS_SUCCESSFUL)
-			continue;
-		if (status = 0xffff)
-			continue;
-
-		early_write_config_word(hose, top_bus, current_bus,
-					pci_devfn, PCI_STATUS,
-					status & status_mask);
-		if (warn)
-			printk("(%02x:%02x: %04X) ", current_bus,
-			       pci_devfn, status);
-	}
-}
-
-/*
- * We can't use pci_find_device() here since we are
- * called from interrupt context.
- */
-static void __init_refok
-pcibios_bus_report_status(struct pci_bus *bus, unsigned int status_mask,
-			  int warn)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		u16 status;
-
-		/*
-		 * ignore host bridge - we handle
-		 * that separately
-		 */
-		if (dev->bus->number = 0 && dev->devfn = 0)
-			continue;
-
-		pci_read_config_word(dev, PCI_STATUS, &status);
-		if (status = 0xffff)
-			continue;
-
-		if ((status & status_mask) = 0)
-			continue;
-
-		/* clear the status errors */
-		pci_write_config_word(dev, PCI_STATUS, status & status_mask);
-
-		if (warn)
-			printk("(%s: %04X) ", pci_name(dev), status);
-	}
-
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		if (dev->subordinate)
-			pcibios_bus_report_status(dev->subordinate, status_mask, warn);
-}
-
-void __init_refok pcibios_report_status(unsigned int status_mask, int warn)
-{
-	struct pci_channel *hose;
-
-	for (hose = hose_head; hose; hose = hose->next) {
-		if (unlikely(!hose->bus))
-			pcibios_bus_report_status_early(hose, hose_head->index,
-					hose->index, status_mask, warn);
-		else
-			pcibios_bus_report_status(hose->bus, status_mask, warn);
-	}
-}
-
-int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	/*
-	 * I/O space can be accessed via normal processor loads and stores on
-	 * this platform but for now we elect not to do this and portable
-	 * drivers should not do this anyway.
-	 */
-	if (mmap_state = pci_mmap_io)
-		return -EINVAL;
-
-	/*
-	 * Ignore write-combine; for now only return uncached mappings.
-	 */
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
-#ifndef CONFIG_GENERIC_IOMAP
-
-void __iomem *__pci_ioport_map(struct pci_dev *dev,
-			       unsigned long port, unsigned int nr)
-{
-	struct pci_channel *chan = dev->sysdata;
-
-	if (unlikely(!chan->io_map_base)) {
-		chan->io_map_base = sh_io_port_base;
-
-		if (pci_domains_supported)
-			panic("To avoid data corruption io_map_base MUST be "
-			      "set with multiple PCI domains.");
-	}
-
-	return (void __iomem *)(chan->io_map_base + port);
-}
-
-void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
-{
-	iounmap(addr);
-}
-EXPORT_SYMBOL(pci_iounmap);
-
-#endif /* CONFIG_GENERIC_IOMAP */
-
-EXPORT_SYMBOL(PCIBIOS_MIN_IO);
-EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index 09040fd..a9a54c2 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -46,5 +46,7 @@ obj-$(CONFIG_DWARF_UNWINDER)	+= dwarf.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_callchain.o
 
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
+obj-$(CONFIG_PCI)		+= pci.o pci-common.o
 
 ccflags-y := -Werror
+CFLAGS_pci.o := -O0
diff --git a/arch/sh/kernel/pci-common.c b/arch/sh/kernel/pci-common.c
new file mode 100644
index 0000000..dbf1381
--- /dev/null
+++ b/arch/sh/kernel/pci-common.c
@@ -0,0 +1,162 @@
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/timer.h>
+#include <linux/kernel.h>
+
+/*
+ * These functions are used early on before PCI scanning is done
+ * and all of the pci_dev and pci_bus structures have been created.
+ */
+static struct pci_dev *fake_pci_dev(struct pci_channel *hose,
+	int top_bus, int busnr, int devfn)
+{
+	static struct pci_dev dev;
+	static struct pci_bus bus;
+
+	dev.bus = &bus;
+	dev.sysdata = hose;
+	dev.devfn = devfn;
+	bus.number = busnr;
+	bus.sysdata = hose;
+	bus.ops = hose->pci_ops;
+
+	if(busnr != top_bus)
+		/* Fake a parent bus structure. */
+		bus.parent = &bus;
+	else
+		bus.parent = NULL;
+
+	return &dev;
+}
+
+#define EARLY_PCI_OP(rw, size, type)					\
+int __init early_##rw##_config_##size(struct pci_channel *hose,		\
+	int top_bus, int bus, int devfn, int offset, type value)	\
+{									\
+	return pci_##rw##_config_##size(				\
+		fake_pci_dev(hose, top_bus, bus, devfn),		\
+		offset, value);						\
+}
+
+EARLY_PCI_OP(read, byte, u8 *)
+EARLY_PCI_OP(read, word, u16 *)
+EARLY_PCI_OP(read, dword, u32 *)
+EARLY_PCI_OP(write, byte, u8)
+EARLY_PCI_OP(write, word, u16)
+EARLY_PCI_OP(write, dword, u32)
+
+int __init pci_is_66mhz_capable(struct pci_channel *hose,
+				int top_bus, int current_bus)
+{
+	u32 pci_devfn;
+	unsigned short vid;
+	int cap66 = -1;
+	u16 stat;
+
+	printk(KERN_INFO "PCI: Checking 66MHz capabilities...\n");
+
+	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
+		if (PCI_FUNC(pci_devfn))
+			continue;
+		if (early_read_config_word(hose, top_bus, current_bus,
+					   pci_devfn, PCI_VENDOR_ID, &vid) !+		    PCIBIOS_SUCCESSFUL)
+			continue;
+		if (vid = 0xffff)
+			continue;
+
+		/* check 66MHz capability */
+		if (cap66 < 0)
+			cap66 = 1;
+		if (cap66) {
+			early_read_config_word(hose, top_bus, current_bus,
+					       pci_devfn, PCI_STATUS, &stat);
+			if (!(stat & PCI_STATUS_66MHZ)) {
+				printk(KERN_DEBUG
+				       "PCI: %02x:%02x not 66MHz capable.\n",
+				       current_bus, pci_devfn);
+				cap66 = 0;
+				break;
+			}
+		}
+	}
+
+	return cap66 > 0;
+}
+
+static void pcibios_enable_err(unsigned long __data)
+{
+	struct pci_channel *hose = (struct pci_channel *)__data;
+
+	del_timer(&hose->err_timer);
+	printk(KERN_DEBUG "PCI: re-enabling error IRQ.\n");
+	enable_irq(hose->err_irq);
+}
+
+static void pcibios_enable_serr(unsigned long __data)
+{
+	struct pci_channel *hose = (struct pci_channel *)__data;
+
+	del_timer(&hose->serr_timer);
+	printk(KERN_DEBUG "PCI: re-enabling system error IRQ.\n");
+	enable_irq(hose->serr_irq);
+}
+
+void pcibios_enable_timers(struct pci_channel *hose)
+{
+	if (hose->err_irq) {
+		init_timer(&hose->err_timer);
+		hose->err_timer.data = (unsigned long)hose;
+		hose->err_timer.function = pcibios_enable_err;
+	}
+
+	if (hose->serr_irq) {
+		init_timer(&hose->serr_timer);
+		hose->serr_timer.data = (unsigned long)hose;
+		hose->serr_timer.function = pcibios_enable_serr;
+	}
+}
+
+/*
+ * A simple handler for the regular PCI status errors, called from IRQ
+ * context.
+ */
+unsigned int pcibios_handle_status_errors(unsigned long addr,
+					  unsigned int status,
+					  struct pci_channel *hose)
+{
+	unsigned int cmd = 0;
+
+	if (status & PCI_STATUS_REC_MASTER_ABORT) {
+		printk(KERN_DEBUG "PCI: master abort, pc=0x%08lx\n", addr);
+		cmd |= PCI_STATUS_REC_MASTER_ABORT;
+	}
+
+	if (status & PCI_STATUS_REC_TARGET_ABORT) {
+		printk(KERN_DEBUG "PCI: target abort: ");
+		pcibios_report_status(PCI_STATUS_REC_TARGET_ABORT |
+				      PCI_STATUS_SIG_TARGET_ABORT |
+				      PCI_STATUS_REC_MASTER_ABORT, 1);
+		printk("\n");
+
+		cmd |= PCI_STATUS_REC_TARGET_ABORT;
+	}
+
+	if (status & (PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY)) {
+		printk(KERN_DEBUG "PCI: parity error detected: ");
+		pcibios_report_status(PCI_STATUS_PARITY |
+				      PCI_STATUS_DETECTED_PARITY, 1);
+		printk("\n");
+
+		cmd |= PCI_STATUS_PARITY | PCI_STATUS_DETECTED_PARITY;
+
+		/* Now back off of the IRQ for awhile */
+		if (hose->err_irq) {
+			disable_irq_nosync(hose->err_irq);
+			hose->err_timer.expires = jiffies + HZ;
+			add_timer(&hose->err_timer);
+		}
+	}
+
+	return cmd;
+}
diff --git a/arch/sh/kernel/pci.c b/arch/sh/kernel/pci.c
new file mode 100644
index 0000000..9cf0ba4
--- /dev/null
+++ b/arch/sh/kernel/pci.c
@@ -0,0 +1,342 @@
+/*
+ * New-style PCI core.
+ *
+ * Copyright (c) 2004 - 2009  Paul Mundt
+ * Copyright (c) 2002  M. R. Brown
+ *
+ * Modelled after arch/mips/pci/pci.c:
+ *  Copyright (C) 2003, 04 Ralf Baechle (ralf@linux-mips.org)
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/dma-debug.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+unsigned long PCIBIOS_MIN_IO = 0x0000;
+unsigned long PCIBIOS_MIN_MEM = 0;
+
+/*
+ * The PCI controller list.
+ */
+static struct pci_channel *hose_head, **hose_tail = &hose_head;
+
+static int pci_initialized;
+
+static void pcibios_scanbus(struct pci_channel *hose)
+{
+	static int next_busno;
+	static int need_domain_info;
+	LIST_HEAD(resources);
+	struct resource *res;
+	resource_size_t offset;
+	int i;
+	struct pci_bus *bus;
+
+	for (i = 0; i < hose->nr_resources; i++) {
+		res = hose->resources + i;
+		offset = 0;
+		if (res->flags & IORESOURCE_IO)
+			offset = hose->io_offset;
+		else if (res->flags & IORESOURCE_MEM)
+			offset = hose->mem_offset;
+		pci_add_resource_offset(&resources, res, offset);
+	}
+
+	bus = pci_scan_root_bus(NULL, next_busno, hose->pci_ops, hose,
+				&resources);
+	hose->bus = bus;
+
+	need_domain_info = need_domain_info || hose->index;
+	hose->need_domain_info = need_domain_info;
+
+	if (!bus) {
+		pci_free_resource_list(&resources);
+		return;
+	}
+
+	next_busno = bus->busn_res.end + 1;
+	/* Don't allow 8-bit bus number overflow inside the hose -
+	   reserve some space for bridges. */
+	if (next_busno > 224) {
+		next_busno = 0;
+		need_domain_info = 1;
+	}
+
+	pci_bus_size_bridges(bus);
+	pci_bus_assign_resources(bus);
+	pci_bus_add_devices(bus);
+}
+
+/*
+ * This interrupt-safe spinlock protects all accesses to PCI
+ * configuration space.
+ */
+DEFINE_RAW_SPINLOCK(pci_config_lock);
+static DEFINE_MUTEX(pci_scan_mutex);
+
+int register_pci_controller(struct pci_channel *hose)
+{
+	int i;
+
+	for (i = 0; i < hose->nr_resources; i++) {
+		struct resource *res = hose->resources + i;
+
+		if (res->flags & IORESOURCE_IO) {
+			if (request_resource(&ioport_resource, res) < 0)
+				goto out;
+		} else {
+			if (request_resource(&iomem_resource, res) < 0)
+				goto out;
+		}
+	}
+
+	*hose_tail = hose;
+	hose_tail = &hose->next;
+
+	/*
+	 * Do not panic here but later - this might happen before console init.
+	 */
+	if (!hose->io_map_base) {
+		printk(KERN_WARNING
+		       "registering PCI controller with io_map_base unset\n");
+	}
+
+	/*
+	 * Setup the ERR/PERR and SERR timers, if available.
+	 */
+	pcibios_enable_timers(hose);
+
+	/*
+	 * Scan the bus if it is register after the PCI subsystem
+	 * initialization.
+	 */
+	if (pci_initialized) {
+		mutex_lock(&pci_scan_mutex);
+		pcibios_scanbus(hose);
+		mutex_unlock(&pci_scan_mutex);
+	}
+
+	return 0;
+
+out:
+	for (--i; i >= 0; i--)
+		release_resource(&hose->resources[i]);
+
+	printk(KERN_WARNING "Skipping PCI bus scan due to resource conflict\n");
+	return -1;
+}
+
+#ifndef CONFIG_SH_DEVICE_TREE
+static int __init pcibios_init(void)
+{
+	struct pci_channel *hose;
+
+	/* Scan all of the recorded PCI controllers.  */
+	for (hose = hose_head; hose; hose = hose->next)
+		pcibios_scanbus(hose);
+
+	pci_fixup_irqs(pci_common_swizzle, pcibios_map_platform_irq);
+
+	dma_debug_add_bus(&pci_bus_type);
+
+	pci_initialized = 1;
+
+	return 0;
+}
+subsys_initcall(pcibios_init);
+#endif
+
+/*
+ *  Called after each bus is probed, but before its children
+ *  are examined.
+ */
+void pcibios_fixup_bus(struct pci_bus *bus)
+{
+}
+
+#ifndef CONFIG_SH_DEVICE_TREE
+/*
+ * We need to avoid collisions with `mirrored' VGA ports
+ * and other strange ISA hardware, so we always want the
+ * addresses to be allocated in the 0x000-0x0ff region
+ * modulo 0x400.
+ */
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	struct pci_dev *dev = data;
+	struct pci_channel *hose = dev->sysdata;
+	resource_size_t start = res->start;
+
+	if (res->flags & IORESOURCE_IO) {
+		if (start < PCIBIOS_MIN_IO + hose->resources[0].start)
+			start = PCIBIOS_MIN_IO + hose->resources[0].start;
+
+		/*
+                 * Put everything into 0x00-0xff region modulo 0x400.
+		 */
+		if (start & 0x300)
+			start = (start + 0x3ff) & ~0x3ff;
+	}
+
+	return start;
+}
+#else
+typedef resource_size_t (*align_resource_fn)(struct pci_dev *dev,
+					     const struct resource *res,
+					     resource_size_t start,
+					     resource_size_t size,
+					     resource_size_t align);
+
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				resource_size_t size, resource_size_t align)
+{
+	resource_size_t start = res->start;
+	struct pci_dev *dev = data;
+	struct pci_config_window *cfg = dev->sysdata;
+	align_resource_fn fn;
+
+	fn = (align_resource_fn)(cfg->priv);
+	return fn(dev, res, start, size, align);
+}
+#endif
+
+static void __init
+pcibios_bus_report_status_early(struct pci_channel *hose,
+				int top_bus, int current_bus,
+				unsigned int status_mask, int warn)
+{
+	unsigned int pci_devfn;
+	u16 status;
+	int ret;
+
+	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
+		if (PCI_FUNC(pci_devfn))
+			continue;
+		ret = early_read_config_word(hose, top_bus, current_bus,
+					     pci_devfn, PCI_STATUS, &status);
+		if (ret != PCIBIOS_SUCCESSFUL)
+			continue;
+		if (status = 0xffff)
+			continue;
+
+		early_write_config_word(hose, top_bus, current_bus,
+					pci_devfn, PCI_STATUS,
+					status & status_mask);
+		if (warn)
+			printk("(%02x:%02x: %04X) ", current_bus,
+			       pci_devfn, status);
+	}
+}
+
+/*
+ * We can't use pci_find_device() here since we are
+ * called from interrupt context.
+ */
+static void __init_refok
+pcibios_bus_report_status(struct pci_bus *bus, unsigned int status_mask,
+			  int warn)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		u16 status;
+
+		/*
+		 * ignore host bridge - we handle
+		 * that separately
+		 */
+		if (dev->bus->number = 0 && dev->devfn = 0)
+			continue;
+
+		pci_read_config_word(dev, PCI_STATUS, &status);
+		if (status = 0xffff)
+			continue;
+
+		if ((status & status_mask) = 0)
+			continue;
+
+		/* clear the status errors */
+		pci_write_config_word(dev, PCI_STATUS, status & status_mask);
+
+		if (warn)
+			printk("(%s: %04X) ", pci_name(dev), status);
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (dev->subordinate)
+			pcibios_bus_report_status(dev->subordinate, status_mask, warn);
+}
+
+void __init_refok pcibios_report_status(unsigned int status_mask, int warn)
+{
+	struct pci_channel *hose;
+
+	for (hose = hose_head; hose; hose = hose->next) {
+		if (unlikely(!hose->bus))
+			pcibios_bus_report_status_early(hose, hose_head->index,
+					hose->index, status_mask, warn);
+		else
+			pcibios_bus_report_status(hose->bus, status_mask, warn);
+	}
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
+	if (mmap_state = pci_mmap_io)
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
+#ifndef CONFIG_GENERIC_IOMAP
+
+void __iomem *__pci_ioport_map(struct pci_dev *dev,
+			       unsigned long port, unsigned int nr)
+{
+	struct pci_channel *chan = dev->sysdata;
+
+	if (unlikely(!chan->io_map_base)) {
+		chan->io_map_base = sh_io_port_base;
+
+		if (pci_domains_supported)
+			panic("To avoid data corruption io_map_base MUST be "
+			      "set with multiple PCI domains.");
+	}
+
+	return (void __iomem *)(chan->io_map_base + port);
+}
+
+void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
+{
+	iounmap(addr);
+}
+EXPORT_SYMBOL(pci_iounmap);
+
+#endif /* CONFIG_GENERIC_IOMAP */
+
+EXPORT_SYMBOL(PCIBIOS_MIN_IO);
+EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-- 
2.7.0

