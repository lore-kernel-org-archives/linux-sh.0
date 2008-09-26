From: "Roni Feldman" <ronifeldman@gmail.com>
Date: Fri, 26 Sep 2008 11:50:10 +0000
Subject: [RFC] sh7751(r): Adding support for PCI-DMA
Message-Id: <7b5883fc0809260450w642dde94k1c25166d8305f007@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello everyone,

I've added very basic PCI-DMA support for the sh7751's. I'll be happy
to see if this works on
different machines since it has been tested only on one platform.
Also, it would be interesting
to know if there are other SH-4(A) devices that support this.

Best regards,
Roni

---
From: Roni Feldman <roni.feldman@gmail.com>

Adding support for pci-to-memory and memory-to-pci DMA
transfers via the PCIC.

Signed-off-by: Roni Feldman <roni.feldman@gmail.com>
---
arch/sh/drivers/pci/Kconfig                  |    7 +
arch/sh/drivers/pci/Makefile                 |    1 +
arch/sh/drivers/pci/pci-dma-sh7751.c         |  228 ++++++++++++++++++++++++++
arch/sh/include/cpu-sh4/cpu/pci-dma-sh7751.h |   25 +++
4 files changed, 261 insertions(+), 0 deletions(-)

diff --git a/arch/sh/drivers/pci/Kconfig b/arch/sh/drivers/pci/Kconfig
index 7e816ed..05691a5 100644
--- a/arch/sh/drivers/pci/Kconfig
+++ b/arch/sh/drivers/pci/Kconfig
@@ -35,3 +35,10 @@ config PCI_AUTO_UPDATE_RESOURCES
 	  with its resources updated beyond what they are when the device
 	  is powered up, set this to N. Everyone else will want this as Y.

+config SH7751_PCI_DMA
+	bool "PCI DMA support for SH7751(R)"
+	depends on (PCI && (CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R))
+	default n
+	help
+	  PCI-DMA support for fast PCI-to-memory or memory-to-PCI transfers.
+
diff --git a/arch/sh/drivers/pci/Makefile b/arch/sh/drivers/pci/Makefile
index 847e908..c7726a6 100644
--- a/arch/sh/drivers/pci/Makefile
+++ b/arch/sh/drivers/pci/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PCI_AUTO)			+= pci-auto.o

 obj-$(CONFIG_CPU_SUBTYPE_SH7751)	+= pci-sh7751.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7751R)	+= pci-sh7751.o ops-sh4.o
+obj-$(CONFIG_SH7751_PCI_DMA)		+= pci-dma-sh7751.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7763)	+= pci-sh7780.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7780)	+= pci-sh7780.o ops-sh4.o
 obj-$(CONFIG_CPU_SUBTYPE_SH7785)	+= pci-sh7780.o ops-sh4.o
diff --git a/arch/sh/drivers/pci/pci-dma-sh7751.c
b/arch/sh/drivers/pci/pci-dma-sh7751.c
new file mode 100755
index 0000000..7b86cf7
--- /dev/null
+++ b/arch/sh/drivers/pci/pci-dma-sh7751.c
@@ -0,0 +1,228 @@
+/*
+ * PCI DMA operaions for SH7751, SH7751R.
+ *
+ * 2008 Roni Feldman
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License v2. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/semaphore.h>
+
+#include "pci-sh4.h"
+
+#define IRQ_PCI_SYSERROR     64
+#define IRQ_PCI_ERROR        71
+#define PCI_DMA_HIGHEST_IRQ  68
+#define MAX_PCI_DMA_CHANNELS 4
+
+static struct semaphore pci_dma_sem;
+
+struct pci_dma_registers {
+	unsigned long local_addr;
+	unsigned long remote_addr;
+	unsigned long count;
+	unsigned long control;
+};
+
+struct pci_dma_channel {
+	atomic_t busy;
+	int chan;
+	const char * name;
+	struct semaphore transfer_complete;
+	struct pci_dma_registers regs;
+};
+
+static struct pci_dma_channel pci_dma_channels[MAX_PCI_DMA_CHANNELS] = {
+	[0 ... MAX_PCI_DMA_CHANNELS-1] = {
+		.busy = ATOMIC_INIT(0),
+	},
+	[0] = { .name = "PCI-DMA 0", .chan = 0, .regs = {
+							.local_addr  = SH4_PCIDLA0,
+							.remote_addr = SH4_PCIDPA0,
+							.count       = SH4_PCIDTC0,
+							.control    = SH4_PCIDCR0,
+						}
+	},
+	[1] = { .name = "PCI-DMA 1", .chan = 1, .regs = {
+							.local_addr  = SH4_PCIDLA1,
+							.remote_addr = SH4_PCIDPA1,
+							.count       = SH4_PCIDTC1,
+							.control    = SH4_PCIDCR1,
+						}
+	},
+	[2] = { .name = "PCI-DMA 2", .chan = 2, .regs = {
+							.local_addr  = SH4_PCIDLA2,
+							.remote_addr = SH4_PCIDPA2,
+							.count       = SH4_PCIDTC2,
+							.control    = SH4_PCIDCR2,
+						}
+	},
+	[3] = { .name = "PCI-DMA 3", .chan = 3, .regs = {
+							.local_addr  = SH4_PCIDLA3,
+							.remote_addr = SH4_PCIDPA3,
+							.count       = SH4_PCIDTC3,
+							.control    = SH4_PCIDCR3,
+						},
+	}
+};
+
+static inline int get_pci_dmte_irq(int channel)
+{
+	if (channel < 0 || channel >= MAX_PCI_DMA_CHANNELS) {
+		return -EINVAL;
+	}
+	return (PCI_DMA_HIGHEST_IRQ - channel);
+}
+
+int request_pci_dma(void)
+{
+	int chan;
+	down(&pci_dma_sem);
+	for (chan = 0; chan < MAX_PCI_DMA_CHANNELS; chan++) {
+		if (!atomic_xchg(&pci_dma_channels[chan].busy, 1)) {
+			return chan;
+		}
+	}
+	return -EINVAL; // never reached
+}
+EXPORT_SYMBOL(request_pci_dma);
+
+int request_pci_dma_noblock(void)
+{
+	int chan;
+	if (!down_trylock(&pci_dma_sem)) {
+		return -EBUSY;
+	}
+	for (chan = 0; chan < MAX_PCI_DMA_CHANNELS; chan++) {
+		if (!atomic_xchg(&pci_dma_channels[chan].busy, 1)) {
+			return chan;
+		}
+	}
+	return -EINVAL; // never reached
+}
+EXPORT_SYMBOL(request_pci_dma_noblock);
+
+void free_pci_dma(int channel)
+{
+	atomic_set(&pci_dma_channels[channel].busy, 0);
+	up(&pci_dma_sem);
+}
+EXPORT_SYMBOL(free_pci_dma);
+
+void pci_dma_start_transfer(int channel, unsigned long local_address,
+			    unsigned long remote_address, unsigned long count,
+			    int mode)
+{
+	unsigned long control;
+	struct pci_dma_channel * chan = &pci_dma_channels[channel];
+
+	control = (SH4_PCIDCR_ALGN | SH4_PCIDCR_INTM | SH4_PCIDCR_STRT);
+	if (PCI_DMA_TODEVICE = mode) {
+		control |= SH4_PCIDCR_DIR;
+	}
+
+	pci_write_reg(local_address, chan->regs.local_addr);
+	pci_write_reg(remote_address, chan->regs.remote_addr);
+	pci_write_reg(count, chan->regs.count);
+
+	pci_write_reg(control, chan->regs.control);
+}
+EXPORT_SYMBOL(pci_dma_start_transfer);
+
+int pci_dma_wait_for_completion(int channel)
+{
+	int val;
+	down(&pci_dma_channels[channel].transfer_complete);
+	val = pci_read_reg(pci_dma_channels[channel].regs.control) & SH4_PCIDCR_MAST;
+	if (val) {
+		return -EREMOTEIO;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(pci_dma_wait_for_completion);
+
+static irqreturn_t pci_dma_tei_handler(int irq, void * dev_id)
+{
+	int chan = (int)dev_id;
+	// clear the interrupt
+	pci_write_reg(SH4_PCIDCR_INTS, pci_dma_channels[chan].regs.control);
+	if (pci_read_reg(SH4_PCIDCR_INTS) & SH4_PCIDCR_INTS) {
+		printk(KERN_CRIT "PCI: dma error: transfer status incorrect\n");
+	}
+	up(&pci_dma_channels[chan].transfer_complete);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pci_error_handler(int irq, void * dev_id)
+{
+	unsigned long pciint, pciaint;
+	pciint = pci_read_reg(SH4_PCIINT);
+	pciaint = pci_read_reg(SH4_PCIAINT);
+	printk(KERN_CRIT "PCI: transfer error: PCIINT 0x%08lx, PCIAINT 0x%08lx\n",
+	       pciint, pciaint);
+	pci_write_reg(pciint, SH4_PCIINT);
+	pci_write_reg(pciaint, SH4_PCIAINT);
+	return IRQ_HANDLED;
+}
+
+static int __init pci_dma_init(void)
+{
+	int chan;
+
+	sema_init(&pci_dma_sem, MAX_PCI_DMA_CHANNELS);
+
+	/* set pci-dma arbitration mode to round robin */
+	pci_write_reg(SH4_PCIDMABT_RRBN, SH4_PCIDMABT);
+
+	/* setup irq for transfer end */
+	for (chan = 0; chan < MAX_PCI_DMA_CHANNELS; chan++) {
+		sema_init(&pci_dma_channels[chan].transfer_complete, 0);
+		if (request_irq(get_pci_dmte_irq(chan), pci_dma_tei_handler,
+				IRQF_DISABLED, pci_dma_channels[chan].name, (void *)chan)) {
+			printk(KERN_CRIT "PCI: error registering TEI handler\n");
+			return -EINVAL;
+		}
+	}
+
+	if (request_irq(IRQ_PCI_ERROR, pci_error_handler,
+			IRQF_DISABLED, "PCI error", NULL)) {
+		printk(KERN_CRIT "PCI: error registering IRQ_PCI_ERROR\n");
+		goto err_free_irqs;
+	}
+
+	if (request_irq(IRQ_PCI_SYSERROR, pci_error_handler,
+			IRQF_DISABLED, "PCI system error", NULL)) {
+		printk(KERN_CRIT "PCI: error registering IRQ_PCI_SYSERROR\n");
+		goto err_free_irqs_pcierror;
+	}
+
+	return 0;
+
+err_free_irqs_pcierror:
+	free_irq(IRQ_PCI_ERROR, NULL);
+err_free_irqs:
+	for (chan = 0; chan < MAX_PCI_DMA_CHANNELS; chan++) {
+		free_irq(get_pci_dmte_irq(chan), (void *)chan);
+	}
+	return -EINVAL;
+}
+
+static void __exit pci_dma_exit(void)
+{
+	int chan;
+	for (chan = 0; chan < MAX_PCI_DMA_CHANNELS; chan++) {
+		free_irq(get_pci_dmte_irq(chan), (void *)chan);
+	}
+
+	free_irq(IRQ_PCI_ERROR, NULL);
+	free_irq(IRQ_PCI_SYSERROR, NULL);
+
+}
+
+subsys_initcall(pci_dma_init);
+module_exit(pci_dma_exit);
diff --git a/arch/sh/include/cpu-sh4/cpu/pci-dma-sh7751.h
b/arch/sh/include/cpu-sh4/cpu/pci-dma-sh7751.h
new file mode 100755
index 0000000..57f8c47
--- /dev/null
+++ b/arch/sh/include/cpu-sh4/cpu/pci-dma-sh7751.h
@@ -0,0 +1,25 @@
+/*
+ * PCI DMA operaions for SH7751, SH7751R.
+ *
+ * 2008 Roni Feldman
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License v2. See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+/* Requests a PCI-DMA channel. Can block. */
+int request_pci_dma(void);
+
+/* Requests a PCI-DMA channel. Returns if there are non free. */
+int request_pci_dma_noblock(void);
+
+void free_pci_dma(int channel);
+
+/* Activates the DMA transfer. Does not block. */
+void pci_dma_start_transfer(int channel, unsigned long local_address,
+			    unsigned long remote_address, unsigned long count,
+			    int mode);
+
+/* Blocks until the transfer is done. */
+int pci_dma_wait_for_completion(int channel);
