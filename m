From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:34:37 +0000
Subject: [PATCH 02/09] sh: add init member to pci_channel data
Message-Id: <20080219123437.4266.62836.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds an init callback to struct pci_channel and makes sure
it is initialized properly. Code is added to call this init function
from pcibios_init(). Return values are adjusted and a warning is is
printed if init fails.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/dreamcast/setup.c     |    6 ------
 arch/sh/drivers/pci/ops-cayman.c     |    2 +-
 arch/sh/drivers/pci/ops-dreamcast.c  |   17 ++++++++---------
 arch/sh/drivers/pci/ops-landisk.c    |    2 +-
 arch/sh/drivers/pci/ops-lboxre2.c    |    2 +-
 arch/sh/drivers/pci/ops-r7780rp.c    |    2 +-
 arch/sh/drivers/pci/ops-rts7751r2d.c |    2 +-
 arch/sh/drivers/pci/ops-sdk7780.c    |    2 +-
 arch/sh/drivers/pci/ops-se7780.c     |    2 +-
 arch/sh/drivers/pci/ops-sh03.c       |    2 +-
 arch/sh/drivers/pci/ops-snapgear.c   |    2 +-
 arch/sh/drivers/pci/ops-titan.c      |    2 +-
 arch/sh/drivers/pci/pci-sh5.c        |    6 ++++++
 arch/sh/drivers/pci/pci-sh5.h        |    1 +
 arch/sh/drivers/pci/pci-sh7751.c     |   11 +++++------
 arch/sh/drivers/pci/pci-sh7751.h     |    1 +
 arch/sh/drivers/pci/pci-sh7780.c     |    9 ++++-----
 arch/sh/drivers/pci/pci-sh7780.h     |    1 +
 arch/sh/drivers/pci/pci.c            |   23 ++++++++++++++++++-----
 include/asm-sh/pci.h                 |    2 ++
 20 files changed, 56 insertions(+), 41 deletions(-)

--- 0003/arch/sh/boards/dreamcast/setup.c
+++ work/arch/sh/boards/dreamcast/setup.c	2008-02-19 15:15:08.000000000 +0900
@@ -30,7 +30,6 @@
 
 extern struct hw_interrupt_type systemasic_int;
 extern void aica_time_init(void);
-extern int gapspci_init(void);
 extern int systemasic_irq_demux(int);
 
 static void __init dreamcast_setup(char **cmdline_p)
@@ -48,11 +47,6 @@ static void __init dreamcast_setup(char 
 		irq_desc[i].chip = &systemasic_int;
 
 	board_time_init = aica_time_init;
-
-#ifdef CONFIG_PCI
-	if (gapspci_init() < 0)
-		printk(KERN_WARNING "GAPSPCI was not detected.\n");
-#endif
 }
 
 static struct sh_machine_vector mv_dreamcast __initmv = {
--- 0001/arch/sh/drivers/pci/ops-cayman.c
+++ work/arch/sh/drivers/pci/ops-cayman.c	2008-02-19 15:27:21.000000000 +0900
@@ -82,7 +82,7 @@ int __init pcibios_map_platform_irq(stru
 }
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh5_pci_ops, NULL, NULL, 0, 0xff },
+	{ sh5_pci_init, &sh5_pci_ops, NULL, NULL, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 EXPORT_SYMBOL(board_pci_channels);
--- 0001/arch/sh/drivers/pci/ops-dreamcast.c
+++ work/arch/sh/drivers/pci/ops-dreamcast.c	2008-02-19 15:15:08.000000000 +0900
@@ -41,14 +41,6 @@ static struct resource gapspci_mem_resou
 	.flags	= IORESOURCE_MEM,
 };
 
-static struct pci_ops gapspci_pci_ops;
-
-struct pci_channel board_pci_channels[] = {
-	{ &gapspci_pci_ops, &gapspci_io_resource,
-	  &gapspci_mem_resource, 0, 1 },
-	{ 0, }
-};
-
 /*
  * The !gapspci_config_access case really shouldn't happen, ever, unless
  * someone implicitly messes around with the last devfn value.. otherwise we
@@ -114,7 +106,7 @@ static struct pci_ops gapspci_pci_ops = 
  * gapspci init
  */
 
-int __init gapspci_init(void)
+static int __init gapspci_init(struct pci_channel *chan)
 {
 	char idbuf[16];
 	int i;
@@ -166,3 +158,10 @@ char * __devinit pcibios_setup(char *str
 {
 	return str;
 }
+
+struct pci_channel board_pci_channels[] = {
+	{ gapspci_init, &gapspci_pci_ops, &gapspci_io_resource,
+	  &gapspci_mem_resource, 0, 1 },
+	{ 0, }
+};
+
--- 0004/arch/sh/drivers/pci/ops-landisk.c
+++ work/arch/sh/drivers/pci/ops-landisk.c	2008-02-19 15:06:22.000000000 +0900
@@ -30,7 +30,7 @@ static struct resource sh7751_mem_resour
 };
 
 struct pci_channel board_pci_channels[] = {
-	{&sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0x3ff},
+	{ sh7751_pci_init, &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0x3ff},
 	{NULL, NULL, NULL, 0, 0},
 };
 
--- 0004/arch/sh/drivers/pci/ops-lboxre2.c
+++ work/arch/sh/drivers/pci/ops-lboxre2.c	2008-02-19 15:06:22.000000000 +0900
@@ -39,7 +39,7 @@ static struct resource sh7751_mem_resour
 extern struct pci_ops sh7751_pci_ops;
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
+	{ sh7751_pci_init, &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 
--- 0004/arch/sh/drivers/pci/ops-r7780rp.c
+++ work/arch/sh/drivers/pci/ops-r7780rp.c	2008-02-19 15:06:22.000000000 +0900
@@ -43,7 +43,7 @@ static struct resource sh7780_mem_resour
 extern struct pci_ops sh7780_pci_ops;
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sh7780_io_resource, &sh7780_mem_resource, 0, 0xff },
+	{ sh7780_pci_init, &sh4_pci_ops, &sh7780_io_resource, &sh7780_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 EXPORT_SYMBOL(board_pci_channels);
--- 0004/arch/sh/drivers/pci/ops-rts7751r2d.c
+++ work/arch/sh/drivers/pci/ops-rts7751r2d.c	2008-02-19 15:06:22.000000000 +0900
@@ -47,7 +47,7 @@ static struct resource sh7751_mem_resour
 extern struct pci_ops sh7751_pci_ops;
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
+	{ sh7751_pci_init, &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 EXPORT_SYMBOL(board_pci_channels);
--- 0004/arch/sh/drivers/pci/ops-sdk7780.c
+++ work/arch/sh/drivers/pci/ops-sdk7780.c	2008-02-19 15:06:22.000000000 +0900
@@ -49,7 +49,7 @@ static struct resource sdk7780_mem_resou
 };
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sdk7780_io_resource, &sdk7780_mem_resource, 0, 0xff },
+	{ sh7780_pci_init, &sh4_pci_ops, &sdk7780_io_resource, &sdk7780_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 EXPORT_SYMBOL(board_pci_channels);
--- 0004/arch/sh/drivers/pci/ops-se7780.c
+++ work/arch/sh/drivers/pci/ops-se7780.c	2008-02-19 15:06:22.000000000 +0900
@@ -58,7 +58,7 @@ static struct resource se7780_mem_resour
 extern struct pci_ops se7780_pci_ops;
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &se7780_io_resource, &se7780_mem_resource, 0, 0xff },
+	{ sh7780_pci_init, &sh4_pci_ops, &se7780_io_resource, &se7780_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 EXPORT_SYMBOL(board_pci_channels);
--- 0001/arch/sh/drivers/pci/ops-sh03.c
+++ work/arch/sh/drivers/pci/ops-sh03.c	2008-02-19 15:06:22.000000000 +0900
@@ -38,7 +38,7 @@ static struct resource sh7751_mem_resour
 extern struct pci_ops sh4_pci_ops;
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
+	{ sh7751_pci_init, &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 
--- 0004/arch/sh/drivers/pci/ops-snapgear.c
+++ work/arch/sh/drivers/pci/ops-snapgear.c	2008-02-19 15:06:22.000000000 +0900
@@ -40,7 +40,7 @@ static struct resource sh7751_mem_resour
 };
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
+	{ sh7751_pci_init, &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
 	{ 0, }
 };
 
--- 0004/arch/sh/drivers/pci/ops-titan.c
+++ work/arch/sh/drivers/pci/ops-titan.c	2008-02-19 15:06:22.000000000 +0900
@@ -52,7 +52,7 @@ static struct resource sh7751_mem_resour
 };
 
 struct pci_channel board_pci_channels[] = {
-	{ &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
+	{ sh7751_pci_init, &sh4_pci_ops, &sh7751_io_resource, &sh7751_mem_resource, 0, 0xff },
 	{ NULL, NULL, NULL, 0, 0 },
 };
 EXPORT_SYMBOL(board_pci_channels);
--- 0001/arch/sh/drivers/pci/pci-sh5.c
+++ work/arch/sh/drivers/pci/pci-sh5.c	2008-02-19 15:27:21.000000000 +0900
@@ -27,6 +27,12 @@
 unsigned long pcicr_virt;
 unsigned long PCI_IO_AREA;
 
+int __init sh5_pci_init(struct pci_channel *chan)
+{
+	pr_debug("PCI: Starting intialization.\n");
+	return pcibios_init_platform();
+}
+
 /* Rounds a number UP to the nearest power of two. Used for
  * sizing the PCI window.
  */
--- 0001/arch/sh/drivers/pci/pci-sh5.h
+++ work/arch/sh/drivers/pci/pci-sh5.h	2008-02-19 15:27:21.000000000 +0900
@@ -108,6 +108,7 @@ extern unsigned long pcicr_virt;
 extern struct pci_ops sh5_pci_ops;
 
 /* arch/sh/drivers/pci/pci-sh5.c */
+int sh5_pci_init(struct pci_channel *chan);
 int sh5pci_init(unsigned long memStart, unsigned long memSize);
 
 #endif /* __PCI_SH5_H */
--- 0004/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2008-02-19 15:06:22.000000000 +0900
@@ -32,7 +32,7 @@
  * space mapping) will be called via the platform defined function
  * pcibios_init_platform().
  */
-static int __init sh7751_pci_init(void)
+int __init sh7751_pci_init(struct pci_channel *chan)
 {
 	unsigned int id;
 	int ret;
@@ -40,19 +40,18 @@ static int __init sh7751_pci_init(void)
 	pr_debug("PCI: Starting intialization.\n");
 
 	/* check for SH7751/SH7751R hardware */
-	id = pci_read_reg(NULL, SH7751_PCICONF0);
+	id = pci_read_reg(chan, SH7751_PCICONF0);
 	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
 	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
 		pr_debug("PCI: This is not an SH7751(R) (%x)\n", id);
 		return -ENODEV;
 	}
 
-	if ((ret = sh4_pci_check_direct(NULL)) != 0)
+	if ((ret = sh4_pci_check_direct(chan)) != 0)
 		return ret;
 
 	return pcibios_init_platform();
 }
-subsys_initcall(sh7751_pci_init);
 
 static int __init __area_sdram_check(struct pci_channel *chan,
 				     unsigned int area)
@@ -178,7 +177,7 @@ int __init sh7751_pcic_init(struct pci_c
 	}
 
 	if (!word)
-		return 0;
+		return -1;
 
 	/* configure the wait control registers */
 	word = ctrl_inl(SH7751_WCR1);
@@ -202,5 +201,5 @@ int __init sh7751_pcic_init(struct pci_c
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
 	pci_write_reg(chan, word, SH4_PCICR);
 
-	return 1;
+	return 0;
 }
--- 0004/arch/sh/drivers/pci/pci-sh7751.h
+++ work/arch/sh/drivers/pci/pci-sh7751.h	2008-02-19 15:06:22.000000000 +0900
@@ -130,6 +130,7 @@
 struct sh4_pci_address_map;
 
 /* arch/sh/drivers/pci/pci-sh7751.c */
+int sh7751_pci_init(struct pci_channel *chan);
 int sh7751_pcic_init(struct pci_channel *chan,
 		     struct sh4_pci_address_map *map);
 
--- 0004/arch/sh/drivers/pci/pci-sh7780.c
+++ work/arch/sh/drivers/pci/pci-sh7780.c	2008-02-19 15:06:22.000000000 +0900
@@ -45,7 +45,7 @@
  * space mapping) will be called via the platform defined function
  * pcibios_init_platform().
  */
-static int __init sh7780_pci_init(void)
+int __init sh7780_pci_init(struct pci_channel *chan)
 {
 	unsigned int id;
 	int ret, match = 0;
@@ -55,7 +55,7 @@ static int __init sh7780_pci_init(void)
 	ctrl_outl(0x00000001, SH7780_PCI_VCR2); /* Enable PCIC */
 
 	/* check for SH7780/SH7780R hardware */
-	id = pci_read_reg(NULL, SH7780_PCIVID);
+	id = pci_read_reg(chan, SH7780_PCIVID);
 	if ((id & 0xffff) = SH7780_VENDOR_ID) {
 		switch ((id >> 16) & 0xffff) {
 		case SH7763_DEVICE_ID:
@@ -82,12 +82,11 @@ static int __init sh7780_pci_init(void)
 		ctrl_outl(0x33333333, INTC_INTPRI);
 	}
 
-	if ((ret = sh4_pci_check_direct(NULL)) != 0)
+	if ((ret = sh4_pci_check_direct(chan)) != 0)
 		return ret;
 
 	return pcibios_init_platform();
 }
-core_initcall(sh7780_pci_init);
 
 int __init sh7780_pcic_init(struct pci_channel *chan,
 			    struct sh4_pci_address_map *map)
@@ -159,5 +158,5 @@ int __init sh7780_pcic_init(struct pci_c
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_FTO;
 	pci_write_reg(chan, word, SH4_PCICR);
 
-	return 1;
+	return 0;
 }
--- 0004/arch/sh/drivers/pci/pci-sh7780.h
+++ work/arch/sh/drivers/pci/pci-sh7780.h	2008-02-19 15:06:22.000000000 +0900
@@ -107,6 +107,7 @@
 struct sh4_pci_address_map;
 
 /* arch/sh/drivers/pci/pci-sh7780.c */
+int sh7780_pci_init(struct pci_channel *chan);
 int sh7780_pcic_init(struct pci_channel *chan,
 		     struct sh4_pci_address_map *map);
 
--- 0001/arch/sh/drivers/pci/pci.c
+++ work/arch/sh/drivers/pci/pci.c	2008-02-19 15:06:22.000000000 +0900
@@ -47,18 +47,31 @@ static int __init pcibios_init(void)
 	struct pci_bus *bus;
 	int busno;
 
+	/* init channels */
+	busno = 0;
+	for (p = board_pci_channels; p->init; p++) {
+		if (p->init(p) = 0)
+			p->enabled = 1;
+		else
+			pr_err("Unable to init pci channel %d\n", busno);
+		busno++;
+	}
+
 #ifdef CONFIG_PCI_AUTO
 	/* assign resources */
 	busno = 0;
-	for (p = board_pci_channels; p->pci_ops != NULL; p++)
-		busno = pciauto_assign_resources(busno, p) + 1;
+	for (p = board_pci_channels; p->init; p++)
+		if (p->enabled)
+			busno = pciauto_assign_resources(busno, p) + 1;
 #endif
 
 	/* scan the buses */
 	busno = 0;
-	for (p = board_pci_channels; p->pci_ops != NULL; p++) {
-		bus = pci_scan_bus(busno, p->pci_ops, p);
-		busno = bus->subordinate + 1;
+	for (p = board_pci_channels; p->init; p++) {
+		if (p->enabled) {
+			bus = pci_scan_bus(busno, p->pci_ops, p);
+			busno = bus->subordinate + 1;
+		}
 	}
 
 	pci_fixup_irqs(simple_swizzle, pcibios_map_platform_irq);
--- 0001/include/asm-sh/pci.h
+++ work/include/asm-sh/pci.h	2008-02-19 15:06:22.000000000 +0900
@@ -17,11 +17,13 @@
  * external) PCI controllers.
  */
 struct pci_channel {
+	int (*init)(struct pci_channel *chan);
 	struct pci_ops *pci_ops;
 	struct resource *io_resource;
 	struct resource *mem_resource;
 	int first_devfn;
 	int last_devfn;
+	int enabled;
 };
 
 /*
