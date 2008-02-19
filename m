From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:34:55 +0000
Subject: [PATCH 04/09] sh: hook in struct pci_channel in sysdata
Message-Id: <20080219123455.4266.10541.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Store a struct pci_channel pointer in bus->sysdata. This makes whatever
struct pci_channel assigned to a bus available for sh4_pci_read() and
sh4_pci_write(). We also modify PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM to
use bus->sysdata - this to gives us support for multiple pci channels.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/ops-sh4.c  |   12 +++++++-----
 arch/sh/drivers/pci/pci-auto.c |    1 +
 include/asm-sh/pci.h           |    6 ++++--
 3 files changed, 12 insertions(+), 7 deletions(-)

--- 0004/arch/sh/drivers/pci/ops-sh4.c
+++ work/arch/sh/drivers/pci/ops-sh4.c	2008-02-19 17:45:46.000000000 +0900
@@ -26,6 +26,7 @@ static DEFINE_SPINLOCK(sh4_pci_lock);
 static int sh4_pci_read(struct pci_bus *bus, unsigned int devfn,
 			   int where, int size, u32 *val)
 {
+	struct pci_channel *chan = bus->sysdata;
 	unsigned long flags;
 	u32 data;
 
@@ -34,8 +35,8 @@ static int sh4_pci_read(struct pci_bus *
 	 * so we must do byte alignment by hand
 	 */
 	spin_lock_irqsave(&sh4_pci_lock, flags);
-	pci_write_reg(NULL, CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
-	data = pci_read_reg(NULL, SH4_PCIPDR);
+	pci_write_reg(chan, CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pci_read_reg(chan, SH4_PCIPDR);
 	spin_unlock_irqrestore(&sh4_pci_lock, flags);
 
 	switch (size) {
@@ -63,13 +64,14 @@ static int sh4_pci_read(struct pci_bus *
 static int sh4_pci_write(struct pci_bus *bus, unsigned int devfn,
 			 int where, int size, u32 val)
 {
+	struct pci_channel *chan = bus->sysdata;
 	unsigned long flags;
 	int shift;
 	u32 data;
 
 	spin_lock_irqsave(&sh4_pci_lock, flags);
-	pci_write_reg(NULL, CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
-	data = pci_read_reg(NULL, SH4_PCIPDR);
+	pci_write_reg(chan, CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pci_read_reg(chan, SH4_PCIPDR);
 	spin_unlock_irqrestore(&sh4_pci_lock, flags);
 
 	switch (size) {
@@ -90,7 +92,7 @@ static int sh4_pci_write(struct pci_bus 
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	pci_write_reg(NULL, data, SH4_PCIPDR);
+	pci_write_reg(chan, data, SH4_PCIPDR);
 
 	return PCIBIOS_SUCCESSFUL;
 }
--- 0001/arch/sh/drivers/pci/pci-auto.c
+++ work/arch/sh/drivers/pci/pci-auto.c	2008-02-19 17:45:46.000000000 +0900
@@ -67,6 +67,7 @@ static struct pci_dev *fake_pci_dev(stru
 	dev.devfn = devfn;
 	bus.number = busnr;
 	bus.ops = hose->pci_ops;
+	bus.sysdata = hose;
 
 	if(busnr != top_bus)
 		/* Fake a parent bus structure. */
--- 0005/include/asm-sh/pci.h
+++ work/include/asm-sh/pci.h	2008-02-19 20:28:02.000000000 +0900
@@ -31,8 +31,10 @@ struct pci_channel {
  */
 extern struct pci_channel board_pci_channels[];
 
-#define PCIBIOS_MIN_IO		board_pci_channels->io_resource->start
-#define PCIBIOS_MIN_MEM		board_pci_channels->mem_resource->start
+/* ugly as hell, but makes drivers/pci/setup-res.c compile and work */
+#define __PCI_CHAN(bus)		((struct pci_channel *)bus->sysdata)
+#define PCIBIOS_MIN_IO		__PCI_CHAN(bus)->io_resource->start
+#define PCIBIOS_MIN_MEM		__PCI_CHAN(bus)->mem_resource->start
 
 /*
  * I/O routine helpers
