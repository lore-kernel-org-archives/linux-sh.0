From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:35:22 +0000
Subject: [PATCH 07/09] sh: pci memory range checking code
Message-Id: <20080219123522.4266.23318.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch changes the code to use __is_pci_memory() instead of
is_pci_memaddr(). __is_pci_memory() loops through all the pci
channels on the system to match memory windows.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/titan/io.c |    2 +-
 arch/sh/drivers/pci/pci.c |    5 ++---
 arch/sh/mm/ioremap_32.c   |    4 ++--
 include/asm-sh/pci.h      |   23 +++++++++++++++++++----
 4 files changed, 24 insertions(+), 10 deletions(-)

--- 0001/arch/sh/boards/titan/io.c
+++ work/arch/sh/boards/titan/io.c	2008-02-19 16:46:40.000000000 +0900
@@ -117,7 +117,7 @@ void titan_outsl(unsigned long port, con
 
 void __iomem *titan_ioport_map(unsigned long port, unsigned int size)
 {
-	if (PXSEG(port) || is_pci_memaddr(port))
+	if (PXSEG(port))
 		return (void __iomem *)port;
 	else if (is_pci_ioaddr(port))
 		return (void __iomem *)pci_ioaddr(port);
--- 0005/arch/sh/drivers/pci/pci.c
+++ work/arch/sh/drivers/pci/pci.c	2008-02-19 16:46:40.000000000 +0900
@@ -216,9 +216,8 @@ void __iomem *pci_iomap(struct pci_dev *
 	/*
 	 * Presently the IORESOURCE_MEM case is a bit special, most
 	 * SH7751 style PCI controllers have PCI memory at a fixed
-	 * location in the address space where no remapping is desired
-	 * (typically at 0xfd000000, but is_pci_memaddr() will know
-	 * best). With the IORESOURCE_MEM case more care has to be taken
+	 * location in the address space where no remapping is desired.
+	 * With the IORESOURCE_MEM case more care has to be taken
 	 * to inhibit page table mapping for legacy cores, but this is
 	 * punted off to __ioremap().
 	 *					-- PFM.
--- 0001/arch/sh/mm/ioremap_32.c
+++ work/arch/sh/mm/ioremap_32.c	2008-02-19 16:46:40.000000000 +0900
@@ -56,7 +56,7 @@ void __iomem *__ioremap(unsigned long ph
 	 * P1/P2 space, ioremap() will already do the right thing,
 	 * and we'll never get this far.
 	 */
-	if (is_pci_memaddr(phys_addr) && is_pci_memaddr(last_addr))
+	if (__is_pci_memory(phys_addr, size))
 		return (void __iomem *)phys_addr;
 
 	/*
@@ -118,7 +118,7 @@ void __iounmap(void __iomem *addr)
 	unsigned long vaddr = (unsigned long __force)addr;
 	struct vm_struct *p;
 
-	if (PXSEG(vaddr) < P3SEG || is_pci_memaddr(vaddr))
+	if (PXSEG(vaddr) < P3SEG || __is_pci_memory(vaddr, 0))
 		return;
 
 #ifdef CONFIG_32BIT
--- 0008/include/asm-sh/pci.h
+++ work/include/asm-sh/pci.h	2008-02-19 16:48:13.000000000 +0900
@@ -59,12 +59,8 @@ extern unsigned long PCI_IO_AREA;
 #define is_pci_ioaddr(port)		\
 	(((port) >= PCIBIOS_MIN_IO) &&	\
 	 ((port) < (PCIBIOS_MIN_IO + PCI_IO_SIZE)))
-#define is_pci_memaddr(port)		\
-	(((port) >= PCIBIOS_MIN_MEM) &&	\
-	 ((port) < (PCIBIOS_MIN_MEM + PCI_MEM_SIZE)))
 #else
 #define is_pci_ioaddr(port)	(0)
-#define is_pci_memaddr(port)	(0)
 #endif
 
 struct pci_dev;
@@ -125,6 +121,25 @@ static inline void pci_dma_burst_advice(
 	*strat = PCI_DMA_BURST_INFINITY;
 	*strategy_parameter = ~0UL;
 }
+
+static inline int __is_pci_memory(unsigned long phys_addr, unsigned long size)
+{
+	struct pci_channel *p;
+	struct resource *res;
+
+	for (p = board_pci_channels; p->init; p++) {
+		res = p->mem_resource;
+		if (p->enabled && (phys_addr >= res->start) &&
+		    (phys_addr + size) <= (res->end + 1))
+			return 1;
+	}
+	return 0;
+}
+#else
+static inline int __is_pci_memory(unsigned long phys_addr, unsigned long size)
+{
+	return 0;
+}
 #endif
 
 /* Board-specific fixup routines. */
