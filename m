From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:35:31 +0000
Subject: [PATCH 08/09] sh: pci io port base address code
Message-Id: <20080219123531.4266.135.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds a __get_pci_io_base() function which is used to match a port range
against struct pci_channel. This allows us to detect if a port range is
assigned to pci or happens to be legacy port io. While at it, remove unused
cpu-specific cruft.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/ops-rts7751r2d.c |    1 
 arch/sh/kernel/io.c                  |    5 +++
 include/asm-sh/pci.h                 |   47 ++++++++++++++--------------------
 3 files changed, 25 insertions(+), 28 deletions(-)

--- 0005/arch/sh/drivers/pci/ops-rts7751r2d.c
+++ work/arch/sh/drivers/pci/ops-rts7751r2d.c	2008-02-19 18:01:56.000000000 +0900
@@ -68,7 +68,6 @@ static struct sh4_pci_address_map sh7751
 
 int __init pcibios_init_platform(void)
 {
-	__set_io_port_base(SH7751_PCI_IO_BASE);
 	return sh7751_pcic_init(&board_pci_channels[0], &sh7751_pci_map);
 }
 
--- 0001/arch/sh/kernel/io.c
+++ work/arch/sh/kernel/io.c	2008-02-19 18:01:56.000000000 +0900
@@ -12,6 +12,7 @@
  * for more details.
  */
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 
@@ -69,6 +70,10 @@ void __iomem *ioport_map(unsigned long p
 	if (ret)
 		return ret;
 
+	ret = __get_pci_io_base(port, nr);
+	if (ret)
+		return ret;
+
 	return __ioport_map(port, nr);
 }
 EXPORT_SYMBOL(ioport_map);
--- 0010/include/asm-sh/pci.h
+++ work/include/asm-sh/pci.h	2008-02-19 20:24:06.000000000 +0900
@@ -37,33 +37,6 @@ extern struct pci_channel board_pci_chan
 #define PCIBIOS_MIN_IO		((struct pci_channel *)bus->sysdata)->io_resource->start
 #define PCIBIOS_MIN_MEM		((struct pci_channel *)bus->sysdata)->mem_resource->start
 
-/*
- * I/O routine helpers
- */
-#if defined(CONFIG_CPU_SUBTYPE_SH7780) || defined(CONFIG_CPU_SUBTYPE_SH7785)
-#define PCI_IO_AREA		0xFE400000
-#define PCI_IO_SIZE		0x00400000
-#elif defined(CONFIG_CPU_SH5)
-extern unsigned long PCI_IO_AREA;
-#define PCI_IO_SIZE		0x00010000
-#else
-#define PCI_IO_AREA		0xFE240000
-#define PCI_IO_SIZE		0x00040000
-#endif
-
-#define PCI_MEM_SIZE		0x01000000
-
-#define SH4_PCIIOBR_MASK	0xFFFC0000
-#define pci_ioaddr(addr)	(PCI_IO_AREA + (addr & ~SH4_PCIIOBR_MASK))
-
-#if defined(CONFIG_PCI)
-#define is_pci_ioaddr(port)		\
-	(((port) >= PCIBIOS_MIN_IO) &&	\
-	 ((port) < (PCIBIOS_MIN_IO + PCI_IO_SIZE)))
-#else
-#define is_pci_ioaddr(port)	(0)
-#endif
-
 struct pci_dev;
 
 extern void pcibios_set_master(struct pci_dev *dev);
@@ -136,11 +109,31 @@ static inline int __is_pci_memory(unsign
 	}
 	return 0;
 }
+
+static inline void __iomem *__get_pci_io_base(unsigned long port,
+					      unsigned long size)
+{
+	struct pci_channel *p;
+	struct resource *res;
+
+	for (p = board_pci_channels; p->init; p++) {
+		res = p->io_resource;
+		if (p->enabled && (port >= res->start) &&
+		    (port + size) <= (res->end + 1))
+			return (void __iomem *)(p->io_base + port);
+	}
+	return NULL;
+}
 #else
 static inline int __is_pci_memory(unsigned long phys_addr, unsigned long size)
 {
 	return 0;
 }
+static inline void __iomem *__get_pci_io_base(unsigned long port,
+					      unsigned long size)
+{
+	return NULL;
+}
 #endif
 
 /* Board-specific fixup routines. */
