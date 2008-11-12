From: yoshii.takashi@gmail.com
Date: Wed, 12 Nov 2008 04:33:13 +0000
Subject: Re: Qemu SH4 status #2
Message-Id: <20081112133313.967c82e2.yoshii.takashi@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Wed__12_Nov_2008_13_33_13_+0900_AeiKc6/L_WJyuI0p"
List-Id: <linux-sh.vger.kernel.org>
References: <20081110233926.3d8c7fd1.kristoffer.ericson@gmail.com>
	<20081111141335.3c869c26.yoshii.takashi@gmail.com>
	<20081111122700.79906a33.kristoffer.ericson@gmail.com>
In-Reply-To: <20081111122700.79906a33.kristoffer.ericson@gmail.com>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: qemu-devel@nongnu.org, takasi-y@ops.dti.ne.jp, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

This is a multi-part message in MIME format.

--Multipart=_Wed__12_Nov_2008_13_33_13_+0900_AeiKc6/L_WJyuI0p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> I'm still getting segmentation fault at exact same
> location. Have you made additional patches?
Please find attached file "qemu081111.diff".
Basically, this is an aggregate of patches found on qemu-devel ML,
 with some conflicts against current svn source being resolved,
 and some small fix are added, which are scheduled to be posted after
 I finished with my pending patches.

I post this to share information between qemu and linux/sh people,
 and hopefully accelerate debugging with linux people's help.

Another file "linuxconfig_r2d_qemu.diff" is diff for linux kernel
 configuretion. It changes following parameters from r2d+'s defconfig.
- Cache -> off (qemu has no cache)
- commandline change (for debugging)
- 8139too -> 8139cp (qemu's default is c+, still thinking how to switch)
- SH SPI -> off (sci emulation is not mature enough to handle it)

Build procedure is as follows,
Configure kernel:
 make ARCH=sh rts7751r2dplus_defconfig
 patch .config < linuxconfig_r2d_qemu.diff
 (and build)

Configure Qemu:
 ./configure --disable-system --target-list=sh4-softmmu \
  --disable-linux-user --disable-kqemu

Execute:
 sh4-softmmu/qemu-system-sh4 -M r2d --serial vc --serial /dev/tty \
  --kernel zImage --append "console=tty0 root=/dev/sda" \
  -usb --usbdevice keyboard --usbdevice mouse disk.img

I've tested it on qemu svn head this morning.
You will see penguin logo, and fbcon input/output working.
For debugging purpose, console=ttySC0,115200 might help.
/yoshii

--Multipart=_Wed__12_Nov_2008_13_33_13_+0900_AeiKc6/L_WJyuI0p
Content-Type: text/x-patch;
 name="qemu081111.diff"
Content-Disposition: attachment;
 filename="qemu081111.diff"
Content-Transfer-Encoding: 7bit

--- svn/target-sh4/helper.c	(revision 5703)
+++ svn/target-sh4/helper.c	(working copy)
@@ -359,14 +359,12 @@
 			   int *prot, target_ulong address,
 			   int rw, int access_type)
 {
-    int use_asid, is_code, n;
+    int use_asid, n;
     tlb_t *matching = NULL;
 
-    use_asid = (env->mmucr & MMUCR_SV) == 0 || (env->sr & SR_MD) == 0;
-    is_code = env->pc == address;	/* Hack */
+    use_asid = (env->mmucr & MMUCR_SV) == 0 || (env->sr & SR_MD) == 0;    
 
-    /* Use a hack to find if this is an instruction or data access */
-    if (env->pc == address && !(rw & PAGE_WRITE)) {
+    if (rw == 2) {
 	n = find_itlb_entry(env, address, use_asid, 1);
 	if (n >= 0) {
 	    matching = &env->itlb[n];
@@ -382,13 +380,13 @@
 	    switch ((matching->pr << 1) | ((env->sr & SR_MD) ? 1 : 0)) {
 	    case 0:		/* 000 */
 	    case 2:		/* 010 */
-		n = (rw & PAGE_WRITE) ? MMU_DTLB_VIOLATION_WRITE :
+	      n = (rw == 1) ? MMU_DTLB_VIOLATION_WRITE :
 		    MMU_DTLB_VIOLATION_READ;
 		break;
 	    case 1:		/* 001 */
 	    case 4:		/* 100 */
 	    case 5:		/* 101 */
-		if (rw & PAGE_WRITE)
+		if (rw == 1)
 		    n = MMU_DTLB_VIOLATION_WRITE;
 		else
 		    *prot = PAGE_READ;
@@ -396,11 +394,11 @@
 	    case 3:		/* 011 */
 	    case 6:		/* 110 */
 	    case 7:		/* 111 */
-		*prot = rw & (PAGE_READ | PAGE_WRITE);
+	        *prot = (rw == 1)? PAGE_WRITE : PAGE_READ;
 		break;
 	    }
 	} else if (n == MMU_DTLB_MISS) {
-	    n = (rw & PAGE_WRITE) ? MMU_DTLB_MISS_WRITE :
+	    n = (rw == 1) ? MMU_DTLB_MISS_WRITE :
 		MMU_DTLB_MISS_READ;
 	}
     }
@@ -426,12 +424,19 @@
 	    && (address < 0xe0000000 || address > 0xe4000000)) {
 	    /* Unauthorized access in user mode (only store queues are available) */
 	    fprintf(stderr, "Unauthorized access\n");
-	    return (rw & PAGE_WRITE) ? MMU_DTLB_MISS_WRITE :
-		MMU_DTLB_MISS_READ;
+	    if (rw == 0)
+	        return MMU_DTLB_MISS_READ;
+	    else if (rw == 1)
+	        return MMU_DTLB_MISS_WRITE;
+	    else
+	        return MMU_ITLB_MISS;
 	}
 	if (address >= 0x80000000 && address < 0xc0000000) {
 	    /* Mask upper 3 bits for P1 and P2 areas */
 	    *physical = address & 0x1fffffff;
+	} else if (address >= 0xfd000000 && address < 0xfe000000) {
+	    /* PCI memory space */
+	    *physical = address;
 	} else if (address >= 0xfc000000) {
 	    /*
 	     * Mask upper 3 bits for control registers in P4 area,
@@ -465,27 +470,6 @@
     target_ulong physical, page_offset, page_size;
     int prot, ret, access_type;
 
-    switch (rw) {
-    case 0:
-        rw = PAGE_READ;
-        break;
-    case 1:
-        rw = PAGE_WRITE;
-        break;
-    case 2: /* READ_ACCESS_TYPE == 2 defined in softmmu_template.h */
-        rw = PAGE_READ;
-        break;
-    default:
-        /* fatal error */
-        assert(0);
-    }
-
-    /* XXXXX */
-#if 0
-    fprintf(stderr, "%s pc %08x ad %08x rw %d mmu_idx %d smmu %d\n",
-	    __func__, env->pc, address, rw, mmu_idx, is_softmmu);
-#endif
-
     access_type = ACCESS_INT;
     ret =
 	get_physical_address(env, &physical, &prot, address, rw,
@@ -537,7 +521,7 @@
     target_ulong physical;
     int prot;
 
-    get_physical_address(env, &physical, &prot, addr, PAGE_READ, 0);
+    get_physical_address(env, &physical, &prot, addr, 0, 0);
     return physical;
 }
 
--- svn/Makefile.target	(revision 5703)
+++ svn/Makefile.target	(working copy)
@@ -736,7 +736,8 @@
 endif
 ifeq ($(TARGET_BASE_ARCH), sh4)
 OBJS+= shix.o r2d.o sh7750.o sh7750_regnames.o tc58128.o
-OBJS+= sh_timer.o ptimer.o sh_serial.o sh_intc.o sm501.o serial.o
+OBJS+= sh_timer.o ptimer.o sh_serial.o sh_intc.o sh_pci.o sm501.o serial.o
+OBJS+= ide.o
 endif
 ifeq ($(TARGET_BASE_ARCH), m68k)
 OBJS+= an5206.o mcf5206.o ptimer.o mcf_uart.o mcf_intc.o mcf5208.o mcf_fec.o
--- svn/hw/r2d.c	(revision 5703)
+++ svn/hw/r2d.c	(working copy)
@@ -28,12 +28,16 @@
 #include "devices.h"
 #include "sysemu.h"
 #include "boards.h"
+#include "pci.h"
+#include "net.h"
+#include "sh7750_regs.h"
 
 #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
 #define SDRAM_SIZE 0x04000000
 
 #define SM501_VRAM_SIZE 0x800000
 
+#define PA_IRLMSK	0x00
 #define PA_POWOFF	0x30
 #define PA_VERREG	0x32
 #define PA_OUTPORT	0x36
@@ -41,6 +45,8 @@
 typedef struct {
     target_phys_addr_t base;
 
+/* register */
+    uint16_t irlmsk;
     uint16_t bcr;
     uint16_t irlmon;
     uint16_t cfctl;
@@ -62,8 +68,53 @@
     uint16_t inport;
     uint16_t outport;
     uint16_t bverreg;
+
+/* output pin */
+    qemu_irq irl;
 } r2d_fpga_t;
 
+enum r2d_fpga_irq {
+    PCI_INTD, CF_IDE, CF_CD, PCI_INTC, SM501, KEY, RTC_A, RTC_T,
+    SDCARD, PCI_INTA, PCI_INTB, EXT, TP,
+    NR_IRQS
+};
+
+static const struct { short irl; uint16_t msk; } irqtab[NR_IRQS] = {
+    [CF_IDE]	= {  1, 1<<9 },
+    [CF_CD]	= {  2, 1<<8 },
+    [PCI_INTA]	= {  9, 1<<14 },
+    [PCI_INTB]	= { 10, 1<<13 },
+    [PCI_INTC]	= {  3, 1<<12 },
+    [PCI_INTD]	= {  0, 1<<11 },
+    [SM501]	= {  4, 1<<10 },
+    [KEY]	= {  5, 1<<6 },
+    [RTC_A]	= {  6, 1<<5 },
+    [RTC_T]	= {  7, 1<<4 },
+    [SDCARD]	= {  8, 1<<7 },
+    [EXT]	= { 11, 1<<0 },
+    [TP]	= { 12, 1<<15 },
+};
+
+static void update_irl(r2d_fpga_t *fpga)
+{
+    int i, irl = 15;
+    for (i = 0; i < NR_IRQS; i++)
+        if (fpga->irlmon & fpga->irlmsk & irqtab[i].msk)
+            if (irqtab[i].irl < irl)
+                irl = irqtab[i].irl;
+    qemu_set_irq(fpga->irl, irl ^ 15);
+}
+
+static void r2d_fpga_irq_set(void *opaque, int n, int level)
+{
+    r2d_fpga_t *fpga = opaque;
+    if (level)
+        fpga->irlmon |= irqtab[n].msk;
+    else
+        fpga->irlmon &= ~irqtab[n].msk;
+    update_irl(fpga);
+}
+
 static uint32_t r2d_fpga_read(void *opaque, target_phys_addr_t addr)
 {
     r2d_fpga_t *s = opaque;
@@ -71,6 +122,8 @@
     addr -= s->base;
 
     switch (addr) {
+    case PA_IRLMSK:
+        return s->irlmsk;
     case PA_OUTPORT:
 	return s->outport;
     case PA_POWOFF:
@@ -90,6 +143,10 @@
     addr -= s->base;
 
     switch (addr) {
+    case PA_IRLMSK:
+        s->irlmsk = value;
+        update_irl(s);
+	break;
     case PA_OUTPORT:
 	s->outport = value;
 	break;
@@ -114,21 +171,35 @@
     NULL,
 };
 
-static void r2d_fpga_init(target_phys_addr_t base)
+static qemu_irq *r2d_fpga_init(target_phys_addr_t base, qemu_irq irl)
 {
     int iomemtype;
     r2d_fpga_t *s;
 
     s = qemu_mallocz(sizeof(r2d_fpga_t));
     if (!s)
-	return;
+	return NULL;
 
+    s->irl = irl;
+
     s->base = base;
     iomemtype = cpu_register_io_memory(0, r2d_fpga_readfn,
 				       r2d_fpga_writefn, s);
     cpu_register_physical_memory(base, 0x40, iomemtype);
+    return qemu_allocate_irqs(r2d_fpga_irq_set, s, NR_IRQS);
 }
 
+static void r2d_pci_set_irq(qemu_irq *p, int n, int l)
+{
+    qemu_set_irq(p[n], l);
+}
+
+static int r2d_pci_map_irq(PCIDevice *d, int irq_num)
+{
+    const int intx[] = { PCI_INTA, PCI_INTB, PCI_INTC, PCI_INTD };
+    return intx[d->devfn>>3];
+}
+
 static void r2d_init(ram_addr_t ram_size, int vga_ram_size,
               const char *boot_device, DisplayState * ds,
 	      const char *kernel_filename, const char *kernel_cmdline,
@@ -137,6 +208,9 @@
     CPUState *env;
     struct SH7750State *s;
     ram_addr_t sdram_addr, sm501_vga_ram_addr;
+    qemu_irq *irq;
+    PCIBus *pci;
+    int i;
 
     if (!cpu_model)
         cpu_model = "SH7751R";
@@ -151,23 +225,50 @@
     sdram_addr = qemu_ram_alloc(SDRAM_SIZE);
     cpu_register_physical_memory(SDRAM_BASE, SDRAM_SIZE, sdram_addr);
     /* Register peripherals */
-    r2d_fpga_init(0x04000000);
     s = sh7750_init(env);
+    irq = r2d_fpga_init(0x04000000, sh7750_irl(s));
+
     sm501_vga_ram_addr = qemu_ram_alloc(SM501_VRAM_SIZE);
     sm501_init(ds, 0x10000000, sm501_vga_ram_addr, SM501_VRAM_SIZE,
 	       serial_hds[2]);
+
+    /* onboard CF (True IDE mode, Master only). */
+    if ((i = drive_get_index(IF_IDE, 0, 0)) != -1)
+        mmio_ide_init(0x14001000, 0x1400080c, irq[CF_IDE], 1,
+                      drives_table[i].bdrv, NULL);
+
+    /* PCI host and peripherals */
+    pci = sh_pci_register_bus(r2d_pci_set_irq, r2d_pci_map_irq, irq, 0, 4);
+
+    /* NIC: rtl8139 on-board, and 2 slots. */
+    if (nb_nics)
+        pci_rtl8139_init(pci, &nd_table[0], 2<<3);
+    for (i = 1; i < nb_nics; i++)
+        pci_nic_init(pci, &nd_table[i], -1);
+    /* USB OHCI for keyboard & mouse */
+    if (usb_enabled)
+        usb_ohci_init_pci(pci, 4, -1);
     /* Todo: register on board registers */
-    {
+    if (kernel_filename) {
       int kernel_size;
+      /* initialization which should be done by firmware */
+      uint32_t bcr1 = 1<<3; // cs3 SDRAM
+      uint16_t bcr2 = 3<<(3*2); // cs3 32bit
+      cpu_physical_memory_write(SH7750_BCR1_A7,&bcr1,4);
+      cpu_physical_memory_write(SH7750_BCR2_A7,&bcr2,2);
 
-      kernel_size = load_image(kernel_filename, phys_ram_base);
-
+      if (kernel_cmdline) {
+          kernel_size = load_image(kernel_filename, phys_ram_base + 0x80000);
+          env->pc = (SDRAM_BASE + 0x80000) | 0xa0000000;
+          pstrcpy(phys_ram_base + 0x10100, 256, kernel_cmdline);
+      } else {
+          kernel_size = load_image(kernel_filename, phys_ram_base);
+          env->pc = SDRAM_BASE | 0xa0000000; /* Start from P2 area */
+      }
       if (kernel_size < 0) {
         fprintf(stderr, "qemu: could not load kernel '%s'\n", kernel_filename);
         exit(1);
       }
-
-      env->pc = SDRAM_BASE | 0xa0000000; /* Start from P2 area */
     }
 }
 
--- svn/hw/sh_pci.c	(revision 0)
+++ svn/hw/sh_pci.c	(revision 0)
@@ -0,0 +1,207 @@
+/*
+ * SuperH on-chip PCIC emulation.	
+ *
+ * Copyright (c) 2008 Takashi YOSHII
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+#include "hw.h"
+#include "sh.h"
+#include "pci.h"
+#include "bswap.h"
+
+typedef struct {
+    PCIBus *bus;
+    PCIDevice *dev;
+    uint32_t regbase;
+    uint32_t iopbase;
+    uint32_t membase;
+    uint32_t par;
+    uint32_t mbr;
+    uint32_t iobr;
+} SHPCIC;
+
+static void sh_pci_reg_write (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    SHPCIC *pcic = p;
+    addr -= pcic->regbase;
+    switch(addr) {
+      case 0 ... 0xfc:
+        cpu_to_le32w((uint32_t*)(pcic->dev->config + addr), val);
+        break;
+      case 0x1c0:
+        pcic->par = val;
+        break;
+      case 0x1c4:
+        pcic->mbr = val;
+        break;
+      case 0x1c8:
+        pcic->iobr = val;
+        break;
+      case 0x220:
+        pci_data_write(pcic->bus, pcic->par, val, 4);
+        break;
+    }
+}
+
+static uint32_t sh_pci_reg_read (void *p, target_phys_addr_t addr)
+{
+    SHPCIC *pcic = p;
+    addr -= pcic->regbase;
+    switch(addr) {
+      case 0 ... 0xfc:
+        return le32_to_cpup((uint32_t*)(pcic->dev->config + addr));
+      case 0x1c0:
+        return pcic->par;
+      case 0x220:
+        return pci_data_read(pcic->bus, pcic->par, 4);
+    }
+    return 0;
+}
+
+static void sh_pci_data_write (SHPCIC *pcic, target_phys_addr_t addr,
+                               uint32_t val, int size)
+{
+    pci_data_write(pcic->bus, addr - pcic->membase + pcic->mbr, val, size);
+}
+
+static uint32_t sh_pci_mem_read (SHPCIC *pcic, target_phys_addr_t addr,
+                                 int size)
+{
+    return pci_data_read(pcic->bus, addr - pcic->membase + pcic->mbr, size);
+}
+
+static void sh_pci_writeb (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    sh_pci_data_write(p, addr, val, 1);
+}
+
+static void sh_pci_writew (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    sh_pci_data_write(p, addr, val, 2);
+}
+
+static void sh_pci_writel (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    sh_pci_data_write(p, addr, val, 4);
+}
+
+static uint32_t sh_pci_readb (void *p, target_phys_addr_t addr)
+{
+    return sh_pci_mem_read(p, addr, 1);
+}
+
+static uint32_t sh_pci_readw (void *p, target_phys_addr_t addr)
+{
+    return sh_pci_mem_read(p, addr, 2);
+}
+
+static uint32_t sh_pci_readl (void *p, target_phys_addr_t addr)
+{
+    return sh_pci_mem_read(p, addr, 4);
+}
+
+static int sh_pci_addr2port(SHPCIC *pcic, target_phys_addr_t addr)
+{
+    return addr - pcic->iopbase + pcic->iobr;
+}
+
+static void sh_pci_outb (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    cpu_outb(NULL, sh_pci_addr2port(p, addr), val);
+}
+
+static void sh_pci_outw (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    cpu_outw(NULL, sh_pci_addr2port(p, addr), val);
+}
+
+static void sh_pci_outl (void *p, target_phys_addr_t addr, uint32_t val)
+{
+    cpu_outl(NULL, sh_pci_addr2port(p, addr), val);
+}
+
+static uint32_t sh_pci_inb (void *p, target_phys_addr_t addr)
+{
+    return cpu_inb(NULL, sh_pci_addr2port(p, addr));
+}
+
+static uint32_t sh_pci_inw (void *p, target_phys_addr_t addr)
+{
+    return cpu_inw(NULL, sh_pci_addr2port(p, addr));
+}
+
+static uint32_t sh_pci_inl (void *p, target_phys_addr_t addr)
+{
+    return cpu_inl(NULL, sh_pci_addr2port(p, addr));
+}
+
+typedef struct {
+    CPUReadMemoryFunc *r[3];
+    CPUWriteMemoryFunc *w[3];
+} MemOp;
+
+static MemOp sh_pci_reg = {
+    { NULL, NULL, sh_pci_reg_read },
+    { NULL, NULL, sh_pci_reg_write },
+};
+
+static MemOp sh_pci_mem = {
+    { sh_pci_readb, sh_pci_readw, sh_pci_readl },
+    { sh_pci_writeb, sh_pci_writew, sh_pci_writel },
+};
+
+static MemOp sh_pci_iop = {
+    { sh_pci_inb, sh_pci_inw, sh_pci_inl },
+    { sh_pci_outb, sh_pci_outw, sh_pci_outl },
+};
+
+PCIBus *sh_pci_register_bus(pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
+                            qemu_irq *pic, int devfn_min, int nirq)
+{
+    SHPCIC *p;
+    int mem, reg, iop;
+
+    p = qemu_mallocz(sizeof(SHPCIC));
+    p->bus = pci_register_bus(set_irq, map_irq, pic, devfn_min, nirq);
+
+    p->dev = pci_register_device(p->bus, "SH PCIC", sizeof(PCIDevice),
+                                 -1, NULL, NULL);
+    p->regbase = 0x1e200000;
+    p->iopbase = 0x1e240000;
+    p->membase = 0xfd000000;
+    reg = cpu_register_io_memory(0, sh_pci_reg.r, sh_pci_reg.w, p);
+    mem = cpu_register_io_memory(0, sh_pci_mem.r, sh_pci_mem.w, p);
+    iop = cpu_register_io_memory(0, sh_pci_iop.r, sh_pci_iop.w, p);
+    cpu_register_physical_memory(p->regbase, 0x224, reg);
+    cpu_register_physical_memory(p->iopbase, 0x40000, iop);
+    cpu_register_physical_memory(p->membase, 0x1000000, mem);
+
+    p->dev->config[0x00] = 0x54; // HITACHI
+    p->dev->config[0x01] = 0x10; //
+    p->dev->config[0x02] = 0x0e; // SH7751R
+    p->dev->config[0x03] = 0x35; //
+    p->dev->config[0x04] = 0x80;
+    p->dev->config[0x05] = 0x00;
+    p->dev->config[0x06] = 0x90;
+    p->dev->config[0x07] = 0x02;
+
+    return p->bus;
+}
+
--- svn/hw/sh.h	(revision 5703)
+++ svn/hw/sh.h	(working copy)
@@ -42,7 +42,14 @@
 		     struct intc_source *tei_source,
 		     struct intc_source *bri_source);
 
+/* sh7750.c */
+qemu_irq sh7750_irl(struct SH7750State *s);
+
 /* tc58128.c */
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zone2);
 
+/* ide.c */
+void mmio_ide_init(target_phys_addr_t membase, target_phys_addr_t membase2,
+                   qemu_irq irq, int shift,
+                   BlockDriverState *hd0, BlockDriverState *hd1);
 #endif
--- svn/hw/sh7750.c	(revision 5703)
+++ svn/hw/sh7750.c	(working copy)
@@ -41,6 +41,8 @@
     /* Peripheral frequency in Hz */
     uint32_t periph_freq;
     /* SDRAM controller */
+    uint32_t bcr1;
+    uint32_t bcr2;
     uint16_t rfcr;
     /* IO ports */
     uint16_t gpioic;
@@ -208,6 +210,8 @@
     SH7750State *s = opaque;
 
     switch (addr) {
+    case SH7750_BCR2_A7:
+	return s->bcr2;
     case SH7750_FRQCR_A7:
 	return 0;
     case SH7750_RFCR_A7:
@@ -231,6 +235,15 @@
     SH7750State *s = opaque;
 
     switch (addr) {
+    case SH7750_BCR1_A7:
+	return s->bcr1;
+    case SH7750_BCR4_A7:
+    case SH7750_WCR1_A7:
+    case SH7750_WCR2_A7:
+    case SH7750_WCR3_A7:
+    case SH7750_MCR_A7:
+	ignore_access("long read", addr);
+	return 0;
     case SH7750_MMUCR_A7:
 	return s->cpu->mmucr;
     case SH7750_PTEH_A7:
@@ -285,6 +298,8 @@
     switch (addr) {
 	/* SDRAM controller */
     case SH7750_BCR2_A7:
+	s->bcr2 = mem_value;
+	return;
     case SH7750_BCR3_A7:
     case SH7750_RTCOR_A7:
     case SH7750_RTCNT_A7:
@@ -331,6 +346,8 @@
     switch (addr) {
 	/* SDRAM controller */
     case SH7750_BCR1_A7:
+	s->bcr1 = mem_value;
+        return;
     case SH7750_BCR4_A7:
     case SH7750_WCR1_A7:
     case SH7750_WCR2_A7:
@@ -412,7 +429,9 @@
 	UNUSED = 0,
 
 	/* interrupt sources */
-	IRL0, IRL1, IRL2, IRL3, /* only IRLM mode supported */
+	IRL_0, IRL_1, IRL_2, IRL_3, IRL_4, IRL_5, IRL_6, IRL_7,
+	IRL_8, IRL_9, IRL_A, IRL_B, IRL_C, IRL_D, IRL_E,
+	IRL0, IRL1, IRL2, IRL3,
 	HUDI, GPIOI,
 	DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2, DMAC_DMTE3,
 	DMAC_DMTE4, DMAC_DMTE5, DMAC_DMTE6, DMAC_DMTE7,
@@ -428,6 +447,8 @@
 
 	/* interrupt groups */
 	DMAC, PCIC1, TMU2, RTC, SCI1, SCIF, REF,
+	/* irl bundle */
+	IRL,
 
 	NR_SOURCES,
 };
@@ -529,6 +550,29 @@
 		   PCIC1_PCIDMA0, PCIC1_PCIDMA1, PCIC1_PCIDMA2, PCIC1_PCIDMA3),
 };
 
+static struct intc_vect vectors_irl[] = {
+	INTC_VECT(IRL_0, 0x200),
+	INTC_VECT(IRL_1, 0x220),
+	INTC_VECT(IRL_2, 0x240),
+	INTC_VECT(IRL_3, 0x260),
+	INTC_VECT(IRL_4, 0x280),
+	INTC_VECT(IRL_5, 0x2a0),
+	INTC_VECT(IRL_6, 0x2c0),
+	INTC_VECT(IRL_7, 0x2e0),
+	INTC_VECT(IRL_8, 0x300),
+	INTC_VECT(IRL_9, 0x320),
+	INTC_VECT(IRL_A, 0x340),
+	INTC_VECT(IRL_B, 0x360),
+	INTC_VECT(IRL_C, 0x380),
+	INTC_VECT(IRL_D, 0x3a0),
+	INTC_VECT(IRL_E, 0x3c0),
+};
+
+static struct intc_group groups_irl[] = {
+	INTC_GROUP(IRL, IRL_0, IRL_1, IRL_2, IRL_3, IRL_4, IRL_5, IRL_6,
+		IRL_7, IRL_8, IRL_9, IRL_A, IRL_B, IRL_C, IRL_D, IRL_E),
+};
+
 /**********************************************************************
  Memory mapped cache and TLB
 **********************************************************************/
@@ -717,5 +761,16 @@
 				 NULL, 0);
     }
 
+    sh_intc_register_sources(&s->intc,
+				_INTC_ARRAY(vectors_irl),
+				_INTC_ARRAY(groups_irl));
     return s;
 }
+
+qemu_irq sh7750_irl(SH7750State *s)
+{
+    sh_intc_toggle_source(sh_intc_source(&s->intc, IRL), 1, 0); /* enable */
+    return qemu_allocate_irqs(sh_intc_set_irl, sh_intc_source(&s->intc, IRL),
+                               1)[0];
+}
+
--- svn/hw/ide.c	(revision 5703)
+++ svn/hw/ide.c	(working copy)
@@ -3512,6 +3512,98 @@
 }
 
 /***********************************************************/
+/* MMIO based ide port
+ * This emulates IDE device connected directly to the CPU bus without
+ * dedicated ide controller, which is often seen on embedded boards.
+ */
+
+typedef struct {
+    void *dev;
+    int shift;
+} MMIOState;
+
+static uint32_t mmio_ide_read (void *opaque, target_phys_addr_t addr)
+{
+    MMIOState *s = (MMIOState*)opaque;
+    IDEState *ide = (IDEState*)s->dev;
+    addr >>= s->shift;
+    if (addr & 7)
+        return ide_ioport_read(ide, addr);
+    else
+        return ide_data_readw(ide, 0);
+}
+
+static void mmio_ide_write (void *opaque, target_phys_addr_t addr,
+	uint32_t val)
+{
+    MMIOState *s = (MMIOState*)opaque;
+    IDEState *ide = (IDEState*)s->dev;
+    addr >>= s->shift;
+    if (addr & 7)
+        ide_ioport_write(ide, addr, val);
+    else
+        ide_data_writew(ide, 0, val);
+}
+
+static CPUReadMemoryFunc *mmio_ide_reads[] = {
+    mmio_ide_read,
+    mmio_ide_read,
+    mmio_ide_read,
+};
+
+static CPUWriteMemoryFunc *mmio_ide_writes[] = {
+    mmio_ide_write,
+    mmio_ide_write,
+    mmio_ide_write,
+};
+
+static uint32_t mmio_ide_status_read (void *opaque, target_phys_addr_t addr)
+{
+    MMIOState *s= (MMIOState*)opaque;
+    IDEState *ide = (IDEState*)s->dev;
+    return ide_status_read(ide, 0);
+}
+
+static void mmio_ide_cmd_write (void *opaque, target_phys_addr_t addr,
+	uint32_t val)
+{
+    MMIOState *s = (MMIOState*)opaque;
+    IDEState *ide = (IDEState*)s->dev;
+    ide_cmd_write(ide, 0, val);
+}
+
+static CPUReadMemoryFunc *mmio_ide_status[] = {
+    mmio_ide_status_read,
+    mmio_ide_status_read,
+    mmio_ide_status_read,
+};
+
+static CPUWriteMemoryFunc *mmio_ide_cmd[] = {
+    mmio_ide_cmd_write,
+    mmio_ide_cmd_write,
+    mmio_ide_cmd_write,
+};
+
+void mmio_ide_init (target_phys_addr_t membase, target_phys_addr_t membase2, 
+	            qemu_irq irq, int shift,
+                    BlockDriverState *hd0, BlockDriverState *hd1)
+{
+    MMIOState *s = qemu_mallocz(sizeof(MMIOState));
+    IDEState *ide = qemu_mallocz(sizeof(IDEState) * 2);
+    int mem1, mem2;
+
+    ide_init2(ide, hd0, hd1, irq);
+
+    s->dev = ide;
+    s->shift = shift;
+
+    mem1 = cpu_register_io_memory(0, mmio_ide_reads, mmio_ide_writes, s);
+    mem2 = cpu_register_io_memory(0, mmio_ide_status, mmio_ide_cmd, s);
+    cpu_register_physical_memory(membase, 16<<shift, mem1);
+    cpu_register_physical_memory(membase2, 2<<shift, mem2);
+}
+
+/***********************************************************/
 /* CF-ATA Microdrive */
 
 #define METADATA_SIZE	0x20
--- svn/hw/sh_intc.c	(revision 5703)
+++ svn/hw/sh_intc.c	(working copy)
@@ -451,3 +451,18 @@
 
     return 0;
 }
+
+/* Assert level <n> IRL interrupt. 
+   0:deassert. 1:lowest priority,... 15:highest priority. */
+void sh_intc_set_irl(void *opaque, int n, int level)
+{
+    struct intc_source *s = opaque;
+    int i, irl = level ^ 15;
+    for (i = 0; (s = sh_intc_source(s->parent, s->next_enum_id)); i++) {
+	if (i == irl)
+	    sh_intc_toggle_source(s, s->enable_count?0:1, s->asserted?0:1);
+	else
+	    if (s->asserted)
+	        sh_intc_toggle_source(s, 0, -1);
+    }
+}
--- svn/hw/sh_intc.h	(revision 5703)
+++ svn/hw/sh_intc.h	(working copy)
@@ -72,4 +72,6 @@
 		 struct intc_prio_reg *prio_regs,
 		 int nr_prio_regs);
 
+void sh_intc_set_irl(void *opaque, int n, int level);
+
 #endif /* __SH_INTC_H__ */

--Multipart=_Wed__12_Nov_2008_13_33_13_+0900_AeiKc6/L_WJyuI0p
Content-Type: text/x-patch;
 name="linuxconfig_r2d_qemu.diff"
Content-Disposition: attachment;
 filename="linuxconfig_r2d_qemu.diff"
Content-Transfer-Encoding: 7bit

--- arch/sh/configs/rts7751r2dplus_defconfig	2008-11-11 16:18:39.000000000 +0900
+++ .config	2008-11-12 13:09:59.000000000 +0900
@@ -197,9 +197,9 @@
 # Cache configuration
 #
 # CONFIG_SH_DIRECT_MAPPED is not set
-CONFIG_CACHE_WRITEBACK=y
+# CONFIG_CACHE_WRITEBACK is not set
 # CONFIG_CACHE_WRITETHROUGH is not set
-# CONFIG_CACHE_OFF is not set
+CONFIG_CACHE_OFF=y
 
 #
 # Processor features
@@ -283,8 +283,7 @@
 CONFIG_ZERO_PAGE_OFFSET=0x00010000
 CONFIG_BOOT_LINK_OFFSET=0x00800000
 # CONFIG_UBC_WAKEUP is not set
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=tty0 console=ttySC0,115200 root=/dev/sda1 earlyprintk=serial"
+# CONFIG_CMDLINE_BOOL is not set
 
 #
 # Bus options
@@ -613,8 +612,8 @@
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
-# CONFIG_8139CP is not set
-CONFIG_8139TOO=y
+CONFIG_8139CP=y
+# CONFIG_8139TOO is not set
 # CONFIG_8139TOO_PIO is not set
 # CONFIG_8139TOO_TUNE_TWISTER is not set
 # CONFIG_8139TOO_8129 is not set
@@ -772,7 +772,7 @@
 # SPI Master Controller Drivers
 #
 CONFIG_SPI_BITBANG=y
-CONFIG_SPI_SH_SCI=y
+# CONFIG_SPI_SH_SCI is not set
 
 #
 # SPI Protocol Masters

--Multipart=_Wed__12_Nov_2008_13_33_13_+0900_AeiKc6/L_WJyuI0p--
