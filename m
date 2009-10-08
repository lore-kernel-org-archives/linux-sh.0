From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Thu, 08 Oct 2009 09:54:00 +0000
Subject: [PATCH] sh: sh7785lcr: add possibility of using 128MB pci window
Message-Id: <4ACDB6B8.9090808@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Only pci may start now from 0xC0000000-phys:0xb8000000-virtual.
All other mapping is the same as without using PMB. 	

Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
---
 arch/sh/boot/Makefile                |    4 ++++
 arch/sh/drivers/pci/fixups-r7780rp.c |    5 +++++
 arch/sh/drivers/pci/pci-sh7780.c     |   15 +++++++++++++--
 arch/sh/drivers/pci/pci-sh7780.h     |    9 ++++++++-
 arch/sh/include/asm/addrspace.h      |    2 +-
 arch/sh/include/asm/io.h             |    6 ++++++
 arch/sh/include/asm/page.h           |    3 +++
 arch/sh/kernel/vmlinux.lds.S         |    2 ++
 arch/sh/mm/Kconfig                   |   10 ++++++++++
 arch/sh/mm/Makefile                  |    1 +
 arch/sh/mm/pmb.c                     |   22 ++++++++++++++++++++++
 11 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index a131687..08b6353 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -51,6 +51,10 @@ ifeq ($(CONFIG_29BIT),y)
 KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_MEMORY_START)]')
 endif
+ifeq ($(CONFIG_PMB_PCI128),y)
+KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
+		     $$[$(CONFIG_MEMORY_START) & 0x1fffffff]')
+endif
 
 KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_PAGE_OFFSET)  + \
diff --git a/arch/sh/drivers/pci/fixups-r7780rp.c b/arch/sh/drivers/pci/fixups-r7780rp.c
index 15ca65c..647d47e 100644
--- a/arch/sh/drivers/pci/fixups-r7780rp.c
+++ b/arch/sh/drivers/pci/fixups-r7780rp.c
@@ -29,8 +29,13 @@ int pci_fixup_pcic(struct pci_channel *chan)
 	pci_write_reg(chan, 0x00000000, SH7780_PCIIBAR);
 	pci_write_reg(chan, 0x08000000, SH7780_PCICSCR0);
 	pci_write_reg(chan, 0x0000001b, SH7780_PCICSAR0);
+#ifdef CONFIG_PMB_PCI128
+	pci_write_reg(chan, 0xc0000000, SH7780_PCICSCR1);
+	pci_write_reg(chan, 0x0000001b, SH7780_PCICSAR1);
+#else
 	pci_write_reg(chan, 0xfd000000, SH7780_PCICSCR1);
 	pci_write_reg(chan, 0x0000000f, SH7780_PCICSAR1);
+#endif
 
 	return 0;
 }
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 323b92d..d2f9b6e 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -22,12 +22,21 @@ static struct resource sh7785_io_resource = {
 	.flags	= IORESOURCE_IO
 };
 
+#ifdef CONFIG_PMB_PCI128
+static struct resource sh7785_mem_resource = {
+	.name	= "SH7785_mem",
+	.start	= SH7780_PCI128_MEMORY_BASE,
+	.end	= SH7780_PCI128_MEMORY_BASE + SH7780_PCI128_MEM_SIZE - 1,
+	.flags	= IORESOURCE_MEM
+};
+#else
 static struct resource sh7785_mem_resource = {
 	.name	= "SH7785_mem",
 	.start	= SH7780_PCI_MEMORY_BASE,
 	.end	= SH7780_PCI_MEMORY_BASE + SH7780_PCI_MEM_SIZE - 1,
 	.flags	= IORESOURCE_MEM
 };
+#endif
 
 static struct pci_channel sh7780_pci_controller = {
 	.pci_ops	= &sh4_pci_ops,
@@ -40,7 +49,7 @@ static struct pci_channel sh7780_pci_controller = {
 
 static struct sh4_pci_address_map sh7780_pci_map = {
 	.window0	= {
-#if defined(CONFIG_32BIT)
+#if defined(CONFIG_32BIT) && !defined(CONFIG_PMB_PCI128)
 		.base	= SH7780_32BIT_DDR_BASE_ADDR,
 		.size	= 0x40000000,
 #else
@@ -123,9 +132,11 @@ static int __init sh7780_pci_init(void)
 	pci_write_reg(chan, 0xfd000000, SH7780_PCIMBR0);
 	pci_write_reg(chan, 0x00fc0000, SH7780_PCIMBMR0);
 
+	pci_write_reg(chan, 0x10000000, SH7780_PCIMBR2);
+	pci_write_reg(chan, 0x03fc0000, SH7780_PCIMBMR2); /* ???64 MB */
 #ifdef CONFIG_32BIT
 	pci_write_reg(chan, 0xc0000000, SH7780_PCIMBR2);
-	pci_write_reg(chan, 0x20000000 - SH7780_PCI_IO_SIZE, SH7780_PCIMBMR2);
+	pci_write_reg(chan, 0x07fc0000, SH7780_PCIMBMR2); /* 128 MB */
 #endif
 
 	/* Set IOBR for windows containing area specified in pci.h */
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7780.h
index 4a52478..9c1a906 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -27,9 +27,14 @@
 #define SH7780_PCI_CONFIG_BASE	0xFD000000	/* Config space base addr */
 #define SH7780_PCI_CONFIG_SIZE	0x01000000	/* Config space size */
 
-#define SH7780_PCI_MEMORY_BASE	0xFD000000	/* Memory space base addr */
+#define SH7780_PCI_MEMORY_BASE	0xfd000000	/* Memory space base addr */
 #define SH7780_PCI_MEM_SIZE	0x01000000	/* Size of Memory window */
 
+#ifdef CONFIG_PMB_PCI128
+#define SH7780_PCI128_MEMORY_BASE 0xC0000000	/* 128MB Memory space base addr */
+#define SH7780_PCI128_MEM_SIZE	  0x08000000    /* 128MB Size of Memory window */
+#endif
+
 #define SH7780_PCI_IO_BASE	0xFE200000	/* IO space base address */
 #define SH7780_PCI_IO_SIZE	0x00400000	/* Size of IO window */
 
@@ -78,6 +83,8 @@
 
 #define SH7780_PCIMBR0		0x1E0
 #define SH7780_PCIMBMR0		0x1E4
+#define SH7780_PCIMBR1		0x1E8
+#define SH7780_PCIMBMR1		0x1EC
 #define SH7780_PCIMBR2		0x1F0
 #define SH7780_PCIMBMR2		0x1F4
 #define SH7780_PCIIOBR		0x1F8
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 80d4081..062f98d 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -31,7 +31,7 @@
 /* Returns the physical address of a PnSEG (n=1,2) address   */
 #define PHYSADDR(a)	(((unsigned long)(a)) & 0x1fffffff)
 
-#if defined(CONFIG_29BIT) || defined(CONFIG_PMB_FIXED)
+#if defined(CONFIG_29BIT) || defined(CONFIG_PMB_FIXED) || defined(CONFIG_PMB_PCI128)
 /*
  * Map an address to a certain privileged segment
  */
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 5be45ea..e97bd5e 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -251,6 +251,12 @@ __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 #endif
 	void __iomem *ret;
 
+#if defined(CONFIG_PMB_PCI128)
+	if (likely(offset >= P3SEG) && likely(offset < P3_ADDR_MAX)) {
+		printk("%s: offset = %lx -> addr = %lx \n", __FUNCTION__, offset, (PA_AREA6_IO + (0x07ffffff & offset)));
+		return (void __iomem *)(PA_AREA6_IO + (0x07ffffff & offset));
+	}
+#endif
 	ret = __ioremap_trapped(offset, size);
 	if (ret)
 		return ret;
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 81bffc0..9e71022 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -132,6 +132,9 @@ typedef struct page *pgtable_t;
 #define PMB_OFFSET	(PAGE_OFFSET - PXSEG(__MEMORY_START))
 #define __pa(x)	((unsigned long)(x) - PMB_OFFSET)
 #define __va(x)	((void *)((unsigned long)(x) + PMB_OFFSET))
+#elif defined(CONFIG_PMB_PCI128)
+#define __pa(x)	((unsigned long)(x)-PAGE_OFFSET)
+#define __va(x)	((void *)((unsigned long)(x)+PAGE_OFFSET))
 #elif defined(CONFIG_32BIT)
 #define __pa(x)	((unsigned long)(x)-PAGE_OFFSET+__MEMORY_START)
 #define __va(x)	((void *)((unsigned long)(x)+PAGE_OFFSET-__MEMORY_START))
diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index a1e4ec2..b2172b7 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -20,6 +20,8 @@ SECTIONS
 #ifdef CONFIG_PMB_FIXED
 	. = CONFIG_PAGE_OFFSET + (CONFIG_MEMORY_START & 0x1fffffff) +
 	    CONFIG_ZERO_PAGE_OFFSET;
+#elif defined(CONFIG_PMB_PCI128)
+	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
 #elif defined(CONFIG_32BIT)
 	. = CONFIG_PAGE_OFFSET + CONFIG_ZERO_PAGE_OFFSET;
 #else
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 64dc1ad..d7e691b 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -116,6 +116,16 @@ config PMB_FIXED
 	  management. This is the closest to legacy 29-bit physical mode,
 	  and allows systems to support up to 512MiB of system memory.
 
+config PMB_PCI128
+	bool "pci 128MB PMB"
+	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7780 || \
+					   CPU_SUBTYPE_SH7785)
+	select 32BIT
+	help
+	  If this option is enabled, PMB mappings are appeared
+	  This is the closest to legacy 29-bit physical mode,
+	  and allows systems to support up to 128MiB of pci memory.
+
 endchoice
 
 config X2TLB
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 3759bf8..81faaf8 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -34,6 +34,7 @@ endif
 
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PMB)		+= pmb.o
+obj-$(CONFIG_PMB_PCI128)	+= pmb.o
 obj-$(CONFIG_PMB_FIXED)		+= pmb-fixed.o
 obj-$(CONFIG_NUMA)		+= numa.o
 
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index b1a714a..ab6b28a 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -36,6 +36,27 @@
 static struct kmem_cache *pmb_cache;
 static unsigned long pmb_map;
 
+#ifdef CONFIG_PMB_PCI128
+static struct pmb_entry pmb_init_map[] = {
+	/* vpn         ppn         flags (ub/sz/c/wt) */
+
+	/* P1 Section Mappings */
+	{ 0x80000000, 0x00000000, PMB_SZ_64M  | PMB_C, },
+	{ 0x84000000, 0x04000000, PMB_SZ_64M  | PMB_C, },
+	{ 0x88000000, 0x08000000, PMB_SZ_128M | PMB_C, },
+	{ 0x90000000, 0x10000000, PMB_SZ_64M  | PMB_C, },
+	{ 0x94000000, 0x14000000, PMB_SZ_64M  | PMB_C, },
+	{ 0x98000000, 0x18000000, PMB_SZ_64M  | PMB_C, },
+
+	/* P2 Section Mappings */
+	{ 0xa0000000, 0x00000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
+	{ 0xa4000000, 0x04000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
+	{ 0xa8000000, 0x08000000, PMB_UB | PMB_SZ_128M | PMB_WT, },
+	{ 0xb0000000, 0x10000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
+	{ 0xb4000000, 0x14000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
+	{ 0xb8000000, 0xc0000000, PMB_UB | PMB_SZ_128M , },
+};
+#else
 static struct pmb_entry pmb_init_map[] = {
 	/* vpn         ppn         flags (ub/sz/c/wt) */
 
@@ -55,6 +76,7 @@ static struct pmb_entry pmb_init_map[] = {
 	{ 0xb4000000, 0x14000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
 	{ 0xb8000000, 0x18000000, PMB_UB | PMB_SZ_64M  | PMB_WT, },
 };
+#endif
 
 static inline unsigned long mk_pmb_entry(unsigned int entry)
 {
-- 1.6.3.3

