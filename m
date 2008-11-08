From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Sat, 08 Nov 2008 19:37:14 +0000
Subject: Re: Concerning Qemu SH4
Message-Id: <20081108213718.8d2f41c4.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Sat__8_Nov_2008_21_37_19_+0100_vxIf_tZRczq2wD.4"
List-Id: <linux-sh.vger.kernel.org>
References: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
In-Reply-To: <20081108020202.0c9a4b59.kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

--Signature=_Sat__8_Nov_2008_21_37_19_+0100_vxIf_tZRczq2wD.4
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__8_Nov_2008_21_37_18_+0100_TqQ=v3jE+6h3AM=D"


--Multipart=_Sat__8_Nov_2008_21_37_18_+0100_TqQ=v3jE+6h3AM=D
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 9 Nov 2008 00:28:35 +0900 (JST)
takasi-y@ops.dti.ne.jp wrote:

> Hi,
>=20
> > Oki, gotten it to work now. Whats left is putting some sort=20
> > of harddrive file there. I've created an loop file but
> > can't seem to get it going.
> Have you applied all patches on ML?
> Otherwise it doesn't support hard disk.
> QEMU repository is being maintained very slowly.
> There always many patches left on ML waiting for being merged.
>=20
> Now, following patches are pending.
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg00970.html
>  This must be applied. Otherwise it will be crashed frequently.
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01246.html
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01247.html
> http://lists.gnu.org/archive/html/qemu-devel/2008-10/msg01248.html
>  These three are needed use to use HDD.
> http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg00118.html
> http://lists.gnu.org/archive/html/qemu-devel/2008-11/msg00119.html
>  These two are needed to use network.

Great!

>=20
> Some of them can't be applied cleanly, because other patch has been
>  applied after I posted them. Please edit them manually.
>=20

I've edited them and finally gotten everything to compile (without errors/w=
arnings).
BUT I get segmentation fault at startup, I'm thinking it could be related
to me compiling with 4.1.x, so I'm going to give it a try with 3.4.x.

I've attached the up-to-date diff (and also below for everyone else).
Note that the sh_pci.c is just a regular file so it's not an patch.

> > I'm also missing something with the initrd as it
> > constantly claims that the initrd expands beyond
> > the memory boundry.
> Current code doesn't support --initrd nor --append.
> Only --kernel works. Use initramfs and initial command line.
>=20
> /yoshii

/*
 * SuperH on-chip PCIC emulation.     =20
 *
 * Copyright (c) 2008 Takashi YOSHII
 *
 * Permission is hereby granted, free of charge, to any person obtaining a =
copy
 * of this software and associated documentation files (the "Software"), to=
=20
eal
 * in the Software without restriction, including without limitation the ri=
ghts
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included =
in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTH=
ER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
=20
FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
#include "hw.h"
#include "sh.h"
#include "pci.h"

typedef struct {
    PCIBus *bus;
    PCIDevice *dev;
    uint32_t regbase;
    uint32_t iopbase;
    uint32_t membase;
    uint32_t par;
    uint32_t mbr;
    uint32_t iobr;
} SHPCIC;

static void sh_pci_reg_write (void *p, target_phys_addr_t addr, uint32_t va=
l)
{
    SHPCIC *pcic =3D p;
    addr -=3D pcic->regbase;
    switch(addr) {
      case 0 ... 0xff: *(uint32_t*)(pcic->dev->config + addr) =3D val;
      case 0x1c0: pcic->par =3D val; break;
      case 0x1c4: pcic->mbr =3D val; break;
      case 0x1c8: pcic->iobr =3D val; break;
      case 0x220: pci_data_write(pcic->bus, pcic->par, val, 4);
    }
}

static uint32_t sh_pci_reg_read (void *p, target_phys_addr_t addr)
{
    SHPCIC *pcic =3D p;
    addr -=3D pcic->regbase;
    switch(addr) {
      case 0 ... 0xff: return *(uint32_t*)(pcic->dev->config + addr);
      case 0x1c0: return pcic->par;
      case 0x220: return pci_data_read(pcic->bus, pcic->par, 4);
    }
    return 0;
}

static void sh_pci_data_write (SHPCIC *pcic, target_phys_addr_t addr,
                               uint32_t val, int size)
{
    pci_data_write(pcic->bus, addr - pcic->membase + pcic->mbr, val, size);
}

static uint32_t sh_pci_mem_read (SHPCIC *pcic, target_phys_addr_t addr,
                                 int size)
{
    return pci_data_read(pcic->bus, addr - pcic->membase + pcic->mbr, size);
}

static void sh_pci_writeb (void *p, target_phys_addr_t addr, uint32_t val)
{
    sh_pci_data_write(p, addr, val, 1);
}

static void sh_pci_writew (void *p, target_phys_addr_t addr, uint32_t val)
{
    sh_pci_data_write(p, addr, val, 2);
}

static void sh_pci_writel (void *p, target_phys_addr_t addr, uint32_t val)
{
    sh_pci_data_write(p, addr, val, 4);
}

static uint32_t sh_pci_readb (void *p, target_phys_addr_t addr)
{
    return sh_pci_mem_read(p, addr, 1);
}

static uint32_t sh_pci_readw (void *p, target_phys_addr_t addr)
{
    return sh_pci_mem_read(p, addr, 2);
}

static uint32_t sh_pci_readl (void *p, target_phys_addr_t addr)
{
    return sh_pci_mem_read(p, addr, 4);
}

static int sh_pci_addr2port(SHPCIC *pcic, target_phys_addr_t addr)
{
    return addr - pcic->iopbase + pcic->iobr;
}

static void sh_pci_outb (void *p, target_phys_addr_t addr, uint32_t val)
{
    cpu_outb(NULL, sh_pci_addr2port(p, addr), val);
}

static void sh_pci_outw (void *p, target_phys_addr_t addr, uint32_t val)
{
    cpu_outw(NULL, sh_pci_addr2port(p, addr), val);
}

static void sh_pci_outl (void *p, target_phys_addr_t addr, uint32_t val)
{
    cpu_outl(NULL, sh_pci_addr2port(p, addr), val);
}

static uint32_t sh_pci_inb (void *p, target_phys_addr_t addr)
{
    return cpu_inb(NULL, sh_pci_addr2port(p, addr));
}

static uint32_t sh_pci_inw (void *p, target_phys_addr_t addr)
{
    return cpu_inw(NULL, sh_pci_addr2port(p, addr));
}

static uint32_t sh_pci_inl (void *p, target_phys_addr_t addr)
{
    return cpu_inl(NULL, sh_pci_addr2port(p, addr));
}

typedef struct {
    CPUReadMemoryFunc *r[3];
    CPUWriteMemoryFunc *w[3];
} MemOp;

static MemOp sh_pci_reg =3D {
    { NULL, NULL, sh_pci_reg_read },
    { NULL, NULL, sh_pci_reg_write },
};

static MemOp sh_pci_mem =3D {
    { sh_pci_readb, sh_pci_readw, sh_pci_readl },
    { sh_pci_writeb, sh_pci_writew, sh_pci_writel },
};

static MemOp sh_pci_iop =3D {
    { sh_pci_inb, sh_pci_inw, sh_pci_inl },
    { sh_pci_outb, sh_pci_outw, sh_pci_outl },
};

PCIBus *sh_pci_register_bus(pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                            qemu_irq *pic, int devfn_min, int nirq)
{
    SHPCIC *p;
    int mem, reg, iop;

    p =3D qemu_mallocz(sizeof(SHPCIC));
    p->bus =3D pci_register_bus(set_irq, map_irq, pic, devfn_min, nirq);

    p->dev =3D pci_register_device(p->bus, "SH PCIC", sizeof(PCIDevice),
                                 -1, NULL, NULL);
    p->regbase =3D 0x1e200000;
    p->iopbase =3D 0x1e240000;
    p->membase =3D 0xfd000000;
    reg =3D cpu_register_io_memory(0, sh_pci_reg.r, sh_pci_reg.w, p);
    mem =3D cpu_register_io_memory(0, sh_pci_mem.r, sh_pci_mem.w, p);
    iop =3D cpu_register_io_memory(0, sh_pci_iop.r, sh_pci_iop.w, p);
    cpu_register_physical_memory(p->regbase, 0x224, reg);
    cpu_register_physical_memory(p->iopbase, 0x40000, iop);
    cpu_register_physical_memory(p->membase, 0x1000000, mem);

    p->dev->config[0x00] =3D 0x54; // HITACHI
    p->dev->config[0x01] =3D 0x10; //
    p->dev->config[0x02] =3D 0x0e; // SH7751R
    p->dev->config[0x03] =3D 0x35; //
    p->dev->config[0x04] =3D 0x80;
    p->dev->config[0x05] =3D 0x00;
    p->dev->config[0x06] =3D 0x90;
    p->dev->config[0x07] =3D 0x02;

    return p->bus;
}



Index: target-sh4/helper.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- target-sh4/helper.c	(revision 5646)
+++ target-sh4/helper.c	(working copy)
@@ -359,14 +359,13 @@
 			   int *prot, target_ulong address,
 			   int rw, int access_type)
 {
-    int use_asid, is_code, n;
+    int use_asid, n;
     tlb_t *matching =3D NULL;
=20
     use_asid =3D (env->mmucr & MMUCR_SV) =3D=3D 0 || (env->sr & SR_MD) =3D=
=3D 0;
-    is_code =3D env->pc =3D=3D address;	/* Hack */
=20
     /* Use a hack to find if this is an instruction or data access */
-    if (env->pc =3D=3D address && !(rw & PAGE_WRITE)) {
+    if (rw =3D=3D 2) {
 	n =3D find_itlb_entry(env, address, use_asid, 1);
 	if (n >=3D 0) {
 	    matching =3D &env->itlb[n];
@@ -382,13 +381,13 @@
 	    switch ((matching->pr << 1) | ((env->sr & SR_MD) ? 1 : 0)) {
 	    case 0:		/* 000 */
 	    case 2:		/* 010 */
-		n =3D (rw & PAGE_WRITE) ? MMU_DTLB_VIOLATION_WRITE :
+		n =3D (rw =3D=3D 1) ? MMU_DTLB_VIOLATION_WRITE :
 		    MMU_DTLB_VIOLATION_READ;
 		break;
 	    case 1:		/* 001 */
 	    case 4:		/* 100 */
 	    case 5:		/* 101 */
-		if (rw & PAGE_WRITE)
+		if (rw =3D=3D 1)
 		    n =3D MMU_DTLB_VIOLATION_WRITE;
 		else
 		    *prot =3D PAGE_READ;
@@ -396,11 +395,11 @@
 	    case 3:		/* 011 */
 	    case 6:		/* 110 */
 	    case 7:		/* 111 */
-		*prot =3D rw & (PAGE_READ | PAGE_WRITE);
+		*prot =3D (rw =3D=3D 1) ? PAGE_WRITE : PAGE_READ;
 		break;
 	    }
 	} else if (n =3D=3D MMU_DTLB_MISS) {
-	    n =3D (rw & PAGE_WRITE) ? MMU_DTLB_MISS_WRITE :
+	    n =3D (rw =3D=3D 1) ? MMU_DTLB_MISS_WRITE :
 		MMU_DTLB_MISS_READ;
 	}
     }
@@ -426,8 +425,12 @@
 	    && (address < 0xe0000000 || address > 0xe4000000)) {
 	    /* Unauthorized access in user mode (only store queues are available)=
 */
 	    fprintf(stderr, "Unauthorized access\n");
-	    return (rw & PAGE_WRITE) ? MMU_DTLB_MISS_WRITE :
-		MMU_DTLB_MISS_READ;
+	    if (rw =3D=3D 0)
+		return MMU_DTLB_MISS_READ;
+	    else if (rw =3D=3D 1)
+		return MMU_DTLB_MISS_WRITE;
+	    else
+		return MMU_ITLB_MISS;
 	}
 	if (address >=3D 0x80000000 && address < 0xc0000000) {
 	    /* Mask upper 3 bits for P1 and P2 areas */
@@ -465,27 +468,6 @@
     target_ulong physical, page_offset, page_size;
     int prot, ret, access_type;
=20
-    switch (rw) {
-    case 0:
-        rw =3D PAGE_READ;
-        break;
-    case 1:
-        rw =3D PAGE_WRITE;
-        break;
-    case 2: /* READ_ACCESS_TYPE =3D=3D 2 defined in softmmu_template.h */
-        rw =3D PAGE_READ;
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
     access_type =3D ACCESS_INT;
     ret =3D
 	get_physical_address(env, &physical, &prot, address, rw,
@@ -537,7 +519,7 @@
     target_ulong physical;
     int prot;
=20
-    get_physical_address(env, &physical, &prot, addr, PAGE_READ, 0);
+    get_physical_address(env, &physical, &prot, addr, 0, 0);
     return physical;
 }
=20
Index: Makefile.target
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- Makefile.target	(revision 5646)
+++ Makefile.target	(working copy)
@@ -738,6 +738,7 @@
 ifeq ($(TARGET_BASE_ARCH), sh4)
 OBJS+=3D shix.o r2d.o sh7750.o sh7750_regnames.o tc58128.o
 OBJS+=3D sh_timer.o ptimer.o sh_serial.o sh_intc.o sm501.o serial.o
+OBJS+=3D ide.o sh_pci.o
 endif
 ifeq ($(TARGET_BASE_ARCH), m68k)
 OBJS+=3D an5206.o mcf5206.o ptimer.o mcf_uart.o mcf_intc.o mcf5208.o mcf_f=
ec.o
Index: hw/r2d.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hw/r2d.c	(revision 5646)
+++ hw/r2d.c	(working copy)
@@ -28,19 +28,24 @@
 #include "devices.h"
 #include "sysemu.h"
 #include "boards.h"
+#include "pci.h"
+#include "net.h"
+#include "sh7750_regs.h"
=20
 #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
 #define SDRAM_SIZE 0x04000000
=20
 #define SM501_VRAM_SIZE 0x800000
=20
+#define PA_IRLMSK	0x00
 #define PA_POWOFF	0x30
 #define PA_VERREG	0x32
 #define PA_OUTPORT	0x36
=20
 typedef struct {
     target_phys_addr_t base;
-
+    /*register */
+    uint16_t irlmsk;
     uint16_t bcr;
     uint16_t irlmon;
     uint16_t cfctl;
@@ -62,8 +67,54 @@
     uint16_t inport;
     uint16_t outport;
     uint16_t bverreg;
+
+    /* output_pin */
+    qemu_irq irl;
+
 } r2d_fpga_t;
=20
+enum r2d_fgpa_irq {
+    PCI_INTD, CF_IDE, CF_CD, PCI_INTC, SM501, KEY, RTC_A, RTC_T,
+    SDCARD, PCI_INTA, PCI_INTB, EXT, TP,
+    NR_IRQS
+};
+
+static const struct { short irl; uint16_t msk; } irqtab[NR_IRQS] =3D {
+    [CF_IDE]	=3D	{ 1, 1<<9  },
+    [CF_CD]	=3D	{ 2, 1<<8  },
+    [PCI_INTA]	=3D	{ 9, 1<<14 },
+    [PCI_INTB]	=3D	{10, 1<<13 },
+    [PCI_INTC]	=3D	{ 3, 1<<12 },
+    [PCI_INTD]	=3D	{ 0, 1<<11 },
+    [SM501]	=3D	{ 4, 1<<10 },
+    [KEY]	=3D	{ 5, 1<<6  },
+    [RTC_A]	=3D	{ 6, 1<<5  },
+    [RTC_T]	=3D	{ 7, 1<<4  },
+    [SDCARD]	=3D	{ 8, 1<<7  },
+    [EXT]	=3D	{11, 1<<0  },
+    [TP]	=3D	{12, 1<<15 },
+};
+
+static void update_irl(r2d_fpga_t *fpga)
+{
+    int i, irl =3D 15;
+    for (i =3D 0; i < NR_IRQS; i++)
+	if (fpga->irlmon & fpga->irlmsk & irqtab[i].msk)
+	    if (irqtab[i].irl < irl)
+		irl =3D irqtab[i].irl;
+    qemu_set_irq(fpga->irl, irl ^ 15);
+}
+
+static void r2d_fpga_irq_set(void *opaque, int n, int level)
+{
+    r2d_fpga_t	*fpga =3D opaque;
+    if (level)
+	fpga->irlmon |=3D irqtab[n].msk;
+    else
+	fpga->irlmon &=3D ~irqtab[n].msk;
+    update_irl(fpga);
+}
+
 static uint32_t r2d_fpga_read(void *opaque, target_phys_addr_t addr)
 {
     r2d_fpga_t *s =3D opaque;
@@ -71,6 +122,8 @@
     addr -=3D s->base;
=20
     switch (addr) {
+    case PA_IRLMSK:
+	return s->irlmsk;
     case PA_OUTPORT:
 	return s->outport;
     case PA_POWOFF:
@@ -90,6 +143,10 @@
     addr -=3D s->base;
=20
     switch (addr) {
+    case PA_IRLMSK:
+	s->irlmsk =3D value;
+	update_irl(s);
+	break;
     case PA_OUTPORT:
 	s->outport =3D value;
 	break;
@@ -114,21 +171,35 @@
     NULL,
 };
=20
-static void r2d_fpga_init(target_phys_addr_t base)
+static qemu_irq *r2d_fpga_init(target_phys_addr_t base, qemu_irq irl)
 {
     int iomemtype;
     r2d_fpga_t *s;
=20
     s =3D qemu_mallocz(sizeof(r2d_fpga_t));
     if (!s)
-	return;
+	return NULL;
=20
+    s->irl =3D irl;
+
     s->base =3D base;
     iomemtype =3D cpu_register_io_memory(0, r2d_fpga_readfn,
 				       r2d_fpga_writefn, s);
     cpu_register_physical_memory(base, 0x40, iomemtype);
+    return qemu_allocate_irqs(r2d_fpga_irq_set, s, NR_IRQS);
 }
=20
+static void r2d_pci_set_irq(qemu_irq *p, int n, int l)
+{
+    qemu_set_irq(p[n], l);
+}
+
+static int r2d_pci_map_irq(PCIDevice *d, int irq_num)
+{
+    const int intx[] =3D { PCI_INTA, PCI_INTB, PCI_INTC, PCI_INTD };
+    return intx[d->devfn>>3];
+}
+
 static void r2d_init(ram_addr_t ram_size, int vga_ram_size,
               const char *boot_device, DisplayState * ds,
 	      const char *kernel_filename, const char *kernel_cmdline,
@@ -136,6 +207,10 @@
 {
     CPUState *env;
     struct SH7750State *s;
+    qemu_irq *irq;
+    PCIBus *pci;
+    int i;
+
     ram_addr_t sdram_addr, sm501_vga_ram_addr;
=20
     if (!cpu_model)
@@ -151,14 +226,24 @@
     sdram_addr =3D qemu_ram_alloc(SDRAM_SIZE);
     cpu_register_physical_memory(SDRAM_BASE, SDRAM_SIZE, sdram_addr);
     /* Register peripherals */
-    r2d_fpga_init(0x04000000);
+    irq =3D r2d_fpga_init(0x04000000, sh7750_irl(s));
+    pci =3D sh_pci_register_bus(r2d_pci_set_irq, r2d_pci_map_irq, irq, 0, =
4);
     s =3D sh7750_init(env);
     sm501_vga_ram_addr =3D qemu_ram_alloc(SM501_VRAM_SIZE);
     sm501_init(ds, 0x10000000, sm501_vga_ram_addr, SM501_VRAM_SIZE,
 	       serial_hds[2]);
+
+    mmio_ide_init(0x14001000, 0x1400080c, irq[CF_IDE], 1,
+	    drives_table[drive_get_index(IF_IDE, 0, 0)].bdrv, NULL);
+
     /* Todo: register on board registers */
     {
       int kernel_size;
+      /* initialization which should be done by firmware */
+      uint32_t bcr1 =3D 1<<3; // cs3 SDRAM
+      uint16_t bcr2 =3D 3<<(3*2); // cs3 32bit
+      cpu_physical_memory_write(SH7750_BCR1_A7, &bcr1, 4);
+      cpu_physical_memory_write(SH7750_BCR2_A7, &bcr2, 2);
=20
       kernel_size =3D load_image(kernel_filename, phys_ram_base);
=20
Index: hw/sh.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hw/sh.h	(revision 5646)
+++ hw/sh.h	(working copy)
@@ -42,7 +42,14 @@
 		     struct intc_source *tei_source,
 		     struct intc_source *bri_source);
=20
+/* sh7750.c */
+qemu_irq sh7750_irl(struct SH7750State *s);
+
 /* tc58128.c */
 int tc58128_init(struct SH7750State *s, const char *zone1, const char *zon=
e2);
=20
+/* ide.c */
+void mmio_ide_init(target_phys_addr_t membase, target_phys_addr_t membase2,
+		    qemu_irq irq, int shift,
+		    BlockDriverState *hd0, BlockDriverState *hd1);
 #endif
Index: hw/sh7750.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hw/sh7750.c	(revision 5646)
+++ hw/sh7750.c	(working copy)
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
     SH7750State *s =3D opaque;
=20
     switch (addr) {
+    case SH7750_BCR2_A7:
+	return s->bcr2;
     case SH7750_FRQCR_A7:
 	return 0;
     case SH7750_RFCR_A7:
@@ -231,6 +235,15 @@
     SH7750State *s =3D opaque;
=20
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
+	s->bcr2 =3D mem_value;
+	return;
     case SH7750_BCR3_A7:
     case SH7750_RTCOR_A7:
     case SH7750_RTCNT_A7:
@@ -331,6 +346,8 @@
     switch (addr) {
 	/* SDRAM controller */
     case SH7750_BCR1_A7:
+	s->bcr1 =3D mem_value;
+	return;
     case SH7750_BCR4_A7:
     case SH7750_WCR1_A7:
     case SH7750_WCR2_A7:
@@ -412,6 +429,8 @@
 	UNUSED =3D 0,
=20
 	/* interrupt sources */
+	IRL_0, IRL_1, IRL_2, IRL_3, IRL_4, IRL_5, IRL_6, IRL_7,
+	IRL_8, IRL_9, IRL_A, IRL_B, IRL_C, IRL_D, IRL_E,
 	IRL0, IRL1, IRL2, IRL3, /* only IRLM mode supported */
 	HUDI, GPIOI,
 	DMAC_DMTE0, DMAC_DMTE1, DMAC_DMTE2, DMAC_DMTE3,
@@ -428,10 +447,34 @@
=20
 	/* interrupt groups */
 	DMAC, PCIC1, TMU2, RTC, SCI1, SCIF, REF,
-
+	IRL,
 	NR_SOURCES,
 };
=20
+static struct intc_vect vectors_irl[] =3D {
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
+static struct intc_group groups_irl[] =3D {
+    INTC_GROUP(IRL, IRL_0, IRL_1, IRL_2, IRL_3, IRL_4, IRL_5, IRL_6,
+    IRL_7, IRL_8, IRL_9, IRL_A, IRL_B, IRL_C, IRL_D, IRL_E)
+};
+
+
 static struct intc_vect vectors[] =3D {
 	INTC_VECT(HUDI, 0x600), INTC_VECT(GPIOI, 0x620),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
@@ -717,5 +760,15 @@
 				 NULL, 0);
     }
=20
+    sh_intc_register_sources(&s->intc,
+				_INTC_ARRAY(vectors_irl),
+				_INTC_ARRAY(groups_irl));
     return s;
 }
+
+qemu_irq sh7750_irl(SH7750State *s)
+{
+    sh_intc_toggle_source(sh_intc_source(&s->intc, IRL), 1, 0); /* enable =
*/
+    return qemu_allocate_irqs(sh_intc_set_irl, sh_intc_source(&s->intc, IR=
L),
+				1)[0];
+}
Index: hw/ide.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hw/ide.c	(revision 5646)
+++ hw/ide.c	(working copy)
@@ -3486,6 +3486,104 @@
 }
=20
 /***********************************************************/
+/* MMIO based ide port
+ * This emulates IDE device connected directly to the CPU bus
+ * without dedicated ide controller, which is often seen on
+ * embedded boards.
+ */
+
+typedef struct {
+    void *dev;
+    int shift;
+} MMIOState;
+
+static uint32_t mmio_ide_read (void *opaque, target_phys_addr_t addr)
+{
+    MMIOState *s =3D (MMIOState*)opaque;
+    IDEState *ide =3D (IDEState*)s->dev;
+    addr >>=3D s->shift;
+    if (addr & 7)
+	return ide_ioport_read(ide, addr);
+    else
+	return ide_data_readw(ide, 0);
+}
+
+static void mmio_ide_write (void *opaque, target_phys_addr_t addr,
+		uint32_t val)
+{
+    MMIOState *s =3D (MMIOState*) opaque;
+    IDEState *ide =3D (IDEState*)s->dev;
+    addr >>=3D s->shift;
+    if (addr & 7)
+	ide_ioport_write(ide, addr, val);
+    else
+	ide_data_writew(ide, 0, val);
+}
+
+static CPUReadMemoryFunc *mmio_ide_reads[] =3D {
+    mmio_ide_read,
+    mmio_ide_read,
+    mmio_ide_read,
+};
+
+static CPUWriteMemoryFunc *mmio_ide_writes[] =3D {
+    mmio_ide_write,
+    mmio_ide_write,
+    mmio_ide_write,
+};
+
+static uint32_t mmio_ide_status_read (void *opaque, target_phys_addr_t add=
r)
+{
+    MMIOState *s =3D (MMIOState*) opaque;
+    IDEState *ide =3D (IDEState*)s->dev;
+    return ide_status_read(ide, 0);
+}
+
+static void mmio_ide_cmd_write (void *opaque, target_phys_addr_t addr,
+	uint32_t val)
+{
+    MMIOState *s =3D (MMIOState*)opaque;
+    IDEState *ide =3D (IDEState*)s->dev;
+    ide_cmd_write(ide, 0, val);
+}
+
+static CPUReadMemoryFunc *mmio_ide_status[] =3D {
+    mmio_ide_status_read,
+    mmio_ide_status_read,
+    mmio_ide_status_read,
+};
+
+static CPUWriteMemoryFunc *mmio_ide_cmd[] =3D {
+    mmio_ide_cmd_write,
+    mmio_ide_cmd_write,
+    mmio_ide_cmd_write,
+};
+
+void mmio_ide_init (target_phys_addr_t membase, target_phys_addr_t membase=
2,
+		qemu_irq irq, int shift,=20
+		BlockDriverState *hd0, BlockDriverState *hd1)
+{
+    MMIOState *s =3D qemu_mallocz(sizeof(MMIOState));
+    IDEState *ide =3D qemu_mallocz(sizeof(IDEState) * 2);
+    int mem1, mem2;
+   =20
+    ide_init2(ide, hd0, hd1, irq);
+   =20
+    s->dev =3D ide;
+    s->shift =3D shift;
+   =20
+    mem1 =3D cpu_register_io_memory(0, mmio_ide_reads, mmio_ide_writes, s);
+    mem2 =3D cpu_register_io_memory(0, mmio_ide_status, mmio_ide_cmd, s);
+    cpu_register_physical_memory(membase, 16<<shift, mem1);
+    cpu_register_physical_memory(membase2, 2<<shift, mem2);
+}
+/*************************************************************************=
**/
+   =20
+
+
+
+
+/***********************************************************/
 /* CF-ATA Microdrive */
=20
 #define METADATA_SIZE	0x20
Index: hw/sh_intc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hw/sh_intc.c	(revision 5646)
+++ hw/sh_intc.c	(working copy)
@@ -451,3 +451,21 @@
=20
     return 0;
 }
+
+/* Assert level <n> IRL interrupt=20
+    0:deassert, 1:lowest priority... 15:highest priority */
+void sh_intc_set_irl(void *opaque, int n, int level)
+{
+    struct intc_source *s =3D opaque;
+    int i, irl =3D level ^ 15;
+    for (i =3D 0; (s =3D sh_intc_source(s->parent, s->next_enum_id)); i++)=
 {
+	if (i =3D=3D irl)
+	    sh_intc_toggle_source(s, s->enable_count?0:1, s->asserted?0:1);
+	else
+	    if (s->asserted)
+		sh_intc_toggle_source(s, 0, -1);
+	}
+}
+
+
+
Index: hw/sh_intc.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- hw/sh_intc.h	(revision 5646)
+++ hw/sh_intc.h	(working copy)
@@ -72,4 +72,6 @@
 		 struct intc_prio_reg *prio_regs,
 		 int nr_prio_regs);
=20
+void sh_intc_set_irl(void *opaque, int n, int level);
+
 #endif /* __SH_INTC_H__ */




--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Sat__8_Nov_2008_21_37_18_+0100_TqQ=v3jE+6h3AM=D
Content-Type: application/octet-stream;
 name="big-sh4-svn-patch"
Content-Disposition: attachment;
 filename="big-sh4-svn-patch"
Content-Transfer-Encoding: base64

SW5kZXg6IHRhcmdldC1zaDQvaGVscGVyLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gdGFyZ2V0LXNoNC9oZWxw
ZXIuYwkocmV2aXNpb24gNTY0NikKKysrIHRhcmdldC1zaDQvaGVscGVyLmMJKHdvcmtpbmcgY29w
eSkKQEAgLTM1OSwxNCArMzU5LDEzIEBACiAJCQkgICBpbnQgKnByb3QsIHRhcmdldF91bG9uZyBh
ZGRyZXNzLAogCQkJICAgaW50IHJ3LCBpbnQgYWNjZXNzX3R5cGUpCiB7Ci0gICAgaW50IHVzZV9h
c2lkLCBpc19jb2RlLCBuOworICAgIGludCB1c2VfYXNpZCwgbjsKICAgICB0bGJfdCAqbWF0Y2hp
bmcgPSBOVUxMOwogCiAgICAgdXNlX2FzaWQgPSAoZW52LT5tbXVjciAmIE1NVUNSX1NWKSA9PSAw
IHx8IChlbnYtPnNyICYgU1JfTUQpID09IDA7Ci0gICAgaXNfY29kZSA9IGVudi0+cGMgPT0gYWRk
cmVzczsJLyogSGFjayAqLwogCiAgICAgLyogVXNlIGEgaGFjayB0byBmaW5kIGlmIHRoaXMgaXMg
YW4gaW5zdHJ1Y3Rpb24gb3IgZGF0YSBhY2Nlc3MgKi8KLSAgICBpZiAoZW52LT5wYyA9PSBhZGRy
ZXNzICYmICEocncgJiBQQUdFX1dSSVRFKSkgeworICAgIGlmIChydyA9PSAyKSB7CiAJbiA9IGZp
bmRfaXRsYl9lbnRyeShlbnYsIGFkZHJlc3MsIHVzZV9hc2lkLCAxKTsKIAlpZiAobiA+PSAwKSB7
CiAJICAgIG1hdGNoaW5nID0gJmVudi0+aXRsYltuXTsKQEAgLTM4MiwxMyArMzgxLDEzIEBACiAJ
ICAgIHN3aXRjaCAoKG1hdGNoaW5nLT5wciA8PCAxKSB8ICgoZW52LT5zciAmIFNSX01EKSA/IDEg
OiAwKSkgewogCSAgICBjYXNlIDA6CQkvKiAwMDAgKi8KIAkgICAgY2FzZSAyOgkJLyogMDEwICov
Ci0JCW4gPSAocncgJiBQQUdFX1dSSVRFKSA/IE1NVV9EVExCX1ZJT0xBVElPTl9XUklURSA6CisJ
CW4gPSAocncgPT0gMSkgPyBNTVVfRFRMQl9WSU9MQVRJT05fV1JJVEUgOgogCQkgICAgTU1VX0RU
TEJfVklPTEFUSU9OX1JFQUQ7CiAJCWJyZWFrOwogCSAgICBjYXNlIDE6CQkvKiAwMDEgKi8KIAkg
ICAgY2FzZSA0OgkJLyogMTAwICovCiAJICAgIGNhc2UgNToJCS8qIDEwMSAqLwotCQlpZiAocncg
JiBQQUdFX1dSSVRFKQorCQlpZiAocncgPT0gMSkKIAkJICAgIG4gPSBNTVVfRFRMQl9WSU9MQVRJ
T05fV1JJVEU7CiAJCWVsc2UKIAkJICAgICpwcm90ID0gUEFHRV9SRUFEOwpAQCAtMzk2LDExICsz
OTUsMTEgQEAKIAkgICAgY2FzZSAzOgkJLyogMDExICovCiAJICAgIGNhc2UgNjoJCS8qIDExMCAq
LwogCSAgICBjYXNlIDc6CQkvKiAxMTEgKi8KLQkJKnByb3QgPSBydyAmIChQQUdFX1JFQUQgfCBQ
QUdFX1dSSVRFKTsKKwkJKnByb3QgPSAocncgPT0gMSkgPyBQQUdFX1dSSVRFIDogUEFHRV9SRUFE
OwogCQlicmVhazsKIAkgICAgfQogCX0gZWxzZSBpZiAobiA9PSBNTVVfRFRMQl9NSVNTKSB7Ci0J
ICAgIG4gPSAocncgJiBQQUdFX1dSSVRFKSA/IE1NVV9EVExCX01JU1NfV1JJVEUgOgorCSAgICBu
ID0gKHJ3ID09IDEpID8gTU1VX0RUTEJfTUlTU19XUklURSA6CiAJCU1NVV9EVExCX01JU1NfUkVB
RDsKIAl9CiAgICAgfQpAQCAtNDI2LDggKzQyNSwxMiBAQAogCSAgICAmJiAoYWRkcmVzcyA8IDB4
ZTAwMDAwMDAgfHwgYWRkcmVzcyA+IDB4ZTQwMDAwMDApKSB7CiAJICAgIC8qIFVuYXV0aG9yaXpl
ZCBhY2Nlc3MgaW4gdXNlciBtb2RlIChvbmx5IHN0b3JlIHF1ZXVlcyBhcmUgYXZhaWxhYmxlKSAq
LwogCSAgICBmcHJpbnRmKHN0ZGVyciwgIlVuYXV0aG9yaXplZCBhY2Nlc3NcbiIpOwotCSAgICBy
ZXR1cm4gKHJ3ICYgUEFHRV9XUklURSkgPyBNTVVfRFRMQl9NSVNTX1dSSVRFIDoKLQkJTU1VX0RU
TEJfTUlTU19SRUFEOworCSAgICBpZiAocncgPT0gMCkKKwkJcmV0dXJuIE1NVV9EVExCX01JU1Nf
UkVBRDsKKwkgICAgZWxzZSBpZiAocncgPT0gMSkKKwkJcmV0dXJuIE1NVV9EVExCX01JU1NfV1JJ
VEU7CisJICAgIGVsc2UKKwkJcmV0dXJuIE1NVV9JVExCX01JU1M7CiAJfQogCWlmIChhZGRyZXNz
ID49IDB4ODAwMDAwMDAgJiYgYWRkcmVzcyA8IDB4YzAwMDAwMDApIHsKIAkgICAgLyogTWFzayB1
cHBlciAzIGJpdHMgZm9yIFAxIGFuZCBQMiBhcmVhcyAqLwpAQCAtNDY1LDI3ICs0NjgsNiBAQAog
ICAgIHRhcmdldF91bG9uZyBwaHlzaWNhbCwgcGFnZV9vZmZzZXQsIHBhZ2Vfc2l6ZTsKICAgICBp
bnQgcHJvdCwgcmV0LCBhY2Nlc3NfdHlwZTsKIAotICAgIHN3aXRjaCAocncpIHsKLSAgICBjYXNl
IDA6Ci0gICAgICAgIHJ3ID0gUEFHRV9SRUFEOwotICAgICAgICBicmVhazsKLSAgICBjYXNlIDE6
Ci0gICAgICAgIHJ3ID0gUEFHRV9XUklURTsKLSAgICAgICAgYnJlYWs7Ci0gICAgY2FzZSAyOiAv
KiBSRUFEX0FDQ0VTU19UWVBFID09IDIgZGVmaW5lZCBpbiBzb2Z0bW11X3RlbXBsYXRlLmggKi8K
LSAgICAgICAgcncgPSBQQUdFX1JFQUQ7Ci0gICAgICAgIGJyZWFrOwotICAgIGRlZmF1bHQ6Ci0g
ICAgICAgIC8qIGZhdGFsIGVycm9yICovCi0gICAgICAgIGFzc2VydCgwKTsKLSAgICB9Ci0KLSAg
ICAvKiBYWFhYWCAqLwotI2lmIDAKLSAgICBmcHJpbnRmKHN0ZGVyciwgIiVzIHBjICUwOHggYWQg
JTA4eCBydyAlZCBtbXVfaWR4ICVkIHNtbXUgJWRcbiIsCi0JICAgIF9fZnVuY19fLCBlbnYtPnBj
LCBhZGRyZXNzLCBydywgbW11X2lkeCwgaXNfc29mdG1tdSk7Ci0jZW5kaWYKLQogICAgIGFjY2Vz
c190eXBlID0gQUNDRVNTX0lOVDsKICAgICByZXQgPQogCWdldF9waHlzaWNhbF9hZGRyZXNzKGVu
diwgJnBoeXNpY2FsLCAmcHJvdCwgYWRkcmVzcywgcncsCkBAIC01MzcsNyArNTE5LDcgQEAKICAg
ICB0YXJnZXRfdWxvbmcgcGh5c2ljYWw7CiAgICAgaW50IHByb3Q7CiAKLSAgICBnZXRfcGh5c2lj
YWxfYWRkcmVzcyhlbnYsICZwaHlzaWNhbCwgJnByb3QsIGFkZHIsIFBBR0VfUkVBRCwgMCk7Cisg
ICAgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoZW52LCAmcGh5c2ljYWwsICZwcm90LCBhZGRyLCAwLCAw
KTsKICAgICByZXR1cm4gcGh5c2ljYWw7CiB9CiAKSW5kZXg6IE1ha2VmaWxlLnRhcmdldAo9PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09Ci0tLSBNYWtlZmlsZS50YXJnZXQJKHJldmlzaW9uIDU2NDYpCisrKyBNYWtlZmlsZS50
YXJnZXQJKHdvcmtpbmcgY29weSkKQEAgLTczOCw2ICs3MzgsNyBAQAogaWZlcSAoJChUQVJHRVRf
QkFTRV9BUkNIKSwgc2g0KQogT0JKUys9IHNoaXgubyByMmQubyBzaDc3NTAubyBzaDc3NTBfcmVn
bmFtZXMubyB0YzU4MTI4Lm8KIE9CSlMrPSBzaF90aW1lci5vIHB0aW1lci5vIHNoX3NlcmlhbC5v
IHNoX2ludGMubyBzbTUwMS5vIHNlcmlhbC5vCitPQkpTKz0gaWRlLm8gc2hfcGNpLm8KIGVuZGlm
CiBpZmVxICgkKFRBUkdFVF9CQVNFX0FSQ0gpLCBtNjhrKQogT0JKUys9IGFuNTIwNi5vIG1jZjUy
MDYubyBwdGltZXIubyBtY2ZfdWFydC5vIG1jZl9pbnRjLm8gbWNmNTIwOC5vIG1jZl9mZWMubwpJ
bmRleDogaHcvcjJkLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gaHcvcjJkLmMJKHJldmlzaW9uIDU2NDYpCisr
KyBody9yMmQuYwkod29ya2luZyBjb3B5KQpAQCAtMjgsMTkgKzI4LDI0IEBACiAjaW5jbHVkZSAi
ZGV2aWNlcy5oIgogI2luY2x1ZGUgInN5c2VtdS5oIgogI2luY2x1ZGUgImJvYXJkcy5oIgorI2lu
Y2x1ZGUgInBjaS5oIgorI2luY2x1ZGUgIm5ldC5oIgorI2luY2x1ZGUgInNoNzc1MF9yZWdzLmgi
CiAKICNkZWZpbmUgU0RSQU1fQkFTRSAweDBjMDAwMDAwIC8qIFBoeXNpY2FsIGxvY2F0aW9uIG9m
IFNEUkFNOiBBcmVhIDMgKi8KICNkZWZpbmUgU0RSQU1fU0laRSAweDA0MDAwMDAwCiAKICNkZWZp
bmUgU001MDFfVlJBTV9TSVpFIDB4ODAwMDAwCiAKKyNkZWZpbmUgUEFfSVJMTVNLCTB4MDAKICNk
ZWZpbmUgUEFfUE9XT0ZGCTB4MzAKICNkZWZpbmUgUEFfVkVSUkVHCTB4MzIKICNkZWZpbmUgUEFf
T1VUUE9SVAkweDM2CiAKIHR5cGVkZWYgc3RydWN0IHsKICAgICB0YXJnZXRfcGh5c19hZGRyX3Qg
YmFzZTsKLQorICAgIC8qcmVnaXN0ZXIgKi8KKyAgICB1aW50MTZfdCBpcmxtc2s7CiAgICAgdWlu
dDE2X3QgYmNyOwogICAgIHVpbnQxNl90IGlybG1vbjsKICAgICB1aW50MTZfdCBjZmN0bDsKQEAg
LTYyLDggKzY3LDU0IEBACiAgICAgdWludDE2X3QgaW5wb3J0OwogICAgIHVpbnQxNl90IG91dHBv
cnQ7CiAgICAgdWludDE2X3QgYnZlcnJlZzsKKworICAgIC8qIG91dHB1dF9waW4gKi8KKyAgICBx
ZW11X2lycSBpcmw7CisKIH0gcjJkX2ZwZ2FfdDsKIAorZW51bSByMmRfZmdwYV9pcnEgeworICAg
IFBDSV9JTlRELCBDRl9JREUsIENGX0NELCBQQ0lfSU5UQywgU001MDEsIEtFWSwgUlRDX0EsIFJU
Q19ULAorICAgIFNEQ0FSRCwgUENJX0lOVEEsIFBDSV9JTlRCLCBFWFQsIFRQLAorICAgIE5SX0lS
UVMKK307CisKK3N0YXRpYyBjb25zdCBzdHJ1Y3QgeyBzaG9ydCBpcmw7IHVpbnQxNl90IG1zazsg
fSBpcnF0YWJbTlJfSVJRU10gPSB7CisgICAgW0NGX0lERV0JPQl7IDEsIDE8PDkgIH0sCisgICAg
W0NGX0NEXQk9CXsgMiwgMTw8OCAgfSwKKyAgICBbUENJX0lOVEFdCT0JeyA5LCAxPDwxNCB9LAor
ICAgIFtQQ0lfSU5UQl0JPQl7MTAsIDE8PDEzIH0sCisgICAgW1BDSV9JTlRDXQk9CXsgMywgMTw8
MTIgfSwKKyAgICBbUENJX0lOVERdCT0JeyAwLCAxPDwxMSB9LAorICAgIFtTTTUwMV0JPQl7IDQs
IDE8PDEwIH0sCisgICAgW0tFWV0JPQl7IDUsIDE8PDYgIH0sCisgICAgW1JUQ19BXQk9CXsgNiwg
MTw8NSAgfSwKKyAgICBbUlRDX1RdCT0JeyA3LCAxPDw0ICB9LAorICAgIFtTRENBUkRdCT0JeyA4
LCAxPDw3ICB9LAorICAgIFtFWFRdCT0JezExLCAxPDwwICB9LAorICAgIFtUUF0JPQl7MTIsIDE8
PDE1IH0sCit9OworCitzdGF0aWMgdm9pZCB1cGRhdGVfaXJsKHIyZF9mcGdhX3QgKmZwZ2EpCit7
CisgICAgaW50IGksIGlybCA9IDE1OworICAgIGZvciAoaSA9IDA7IGkgPCBOUl9JUlFTOyBpKysp
CisJaWYgKGZwZ2EtPmlybG1vbiAmIGZwZ2EtPmlybG1zayAmIGlycXRhYltpXS5tc2spCisJICAg
IGlmIChpcnF0YWJbaV0uaXJsIDwgaXJsKQorCQlpcmwgPSBpcnF0YWJbaV0uaXJsOworICAgIHFl
bXVfc2V0X2lycShmcGdhLT5pcmwsIGlybCBeIDE1KTsKK30KKworc3RhdGljIHZvaWQgcjJkX2Zw
Z2FfaXJxX3NldCh2b2lkICpvcGFxdWUsIGludCBuLCBpbnQgbGV2ZWwpCit7CisgICAgcjJkX2Zw
Z2FfdAkqZnBnYSA9IG9wYXF1ZTsKKyAgICBpZiAobGV2ZWwpCisJZnBnYS0+aXJsbW9uIHw9IGly
cXRhYltuXS5tc2s7CisgICAgZWxzZQorCWZwZ2EtPmlybG1vbiAmPSB+aXJxdGFiW25dLm1zazsK
KyAgICB1cGRhdGVfaXJsKGZwZ2EpOworfQorCiBzdGF0aWMgdWludDMyX3QgcjJkX2ZwZ2FfcmVh
ZCh2b2lkICpvcGFxdWUsIHRhcmdldF9waHlzX2FkZHJfdCBhZGRyKQogewogICAgIHIyZF9mcGdh
X3QgKnMgPSBvcGFxdWU7CkBAIC03MSw2ICsxMjIsOCBAQAogICAgIGFkZHIgLT0gcy0+YmFzZTsK
IAogICAgIHN3aXRjaCAoYWRkcikgeworICAgIGNhc2UgUEFfSVJMTVNLOgorCXJldHVybiBzLT5p
cmxtc2s7CiAgICAgY2FzZSBQQV9PVVRQT1JUOgogCXJldHVybiBzLT5vdXRwb3J0OwogICAgIGNh
c2UgUEFfUE9XT0ZGOgpAQCAtOTAsNiArMTQzLDEwIEBACiAgICAgYWRkciAtPSBzLT5iYXNlOwog
CiAgICAgc3dpdGNoIChhZGRyKSB7CisgICAgY2FzZSBQQV9JUkxNU0s6CisJcy0+aXJsbXNrID0g
dmFsdWU7CisJdXBkYXRlX2lybChzKTsKKwlicmVhazsKICAgICBjYXNlIFBBX09VVFBPUlQ6CiAJ
cy0+b3V0cG9ydCA9IHZhbHVlOwogCWJyZWFrOwpAQCAtMTE0LDIxICsxNzEsMzUgQEAKICAgICBO
VUxMLAogfTsKIAotc3RhdGljIHZvaWQgcjJkX2ZwZ2FfaW5pdCh0YXJnZXRfcGh5c19hZGRyX3Qg
YmFzZSkKK3N0YXRpYyBxZW11X2lycSAqcjJkX2ZwZ2FfaW5pdCh0YXJnZXRfcGh5c19hZGRyX3Qg
YmFzZSwgcWVtdV9pcnEgaXJsKQogewogICAgIGludCBpb21lbXR5cGU7CiAgICAgcjJkX2ZwZ2Ff
dCAqczsKIAogICAgIHMgPSBxZW11X21hbGxvY3ooc2l6ZW9mKHIyZF9mcGdhX3QpKTsKICAgICBp
ZiAoIXMpCi0JcmV0dXJuOworCXJldHVybiBOVUxMOwogCisgICAgcy0+aXJsID0gaXJsOworCiAg
ICAgcy0+YmFzZSA9IGJhc2U7CiAgICAgaW9tZW10eXBlID0gY3B1X3JlZ2lzdGVyX2lvX21lbW9y
eSgwLCByMmRfZnBnYV9yZWFkZm4sCiAJCQkJICAgICAgIHIyZF9mcGdhX3dyaXRlZm4sIHMpOwog
ICAgIGNwdV9yZWdpc3Rlcl9waHlzaWNhbF9tZW1vcnkoYmFzZSwgMHg0MCwgaW9tZW10eXBlKTsK
KyAgICByZXR1cm4gcWVtdV9hbGxvY2F0ZV9pcnFzKHIyZF9mcGdhX2lycV9zZXQsIHMsIE5SX0lS
UVMpOwogfQogCitzdGF0aWMgdm9pZCByMmRfcGNpX3NldF9pcnEocWVtdV9pcnEgKnAsIGludCBu
LCBpbnQgbCkKK3sKKyAgICBxZW11X3NldF9pcnEocFtuXSwgbCk7Cit9CisKK3N0YXRpYyBpbnQg
cjJkX3BjaV9tYXBfaXJxKFBDSURldmljZSAqZCwgaW50IGlycV9udW0pCit7CisgICAgY29uc3Qg
aW50IGludHhbXSA9IHsgUENJX0lOVEEsIFBDSV9JTlRCLCBQQ0lfSU5UQywgUENJX0lOVEQgfTsK
KyAgICByZXR1cm4gaW50eFtkLT5kZXZmbj4+M107Cit9CisKIHN0YXRpYyB2b2lkIHIyZF9pbml0
KHJhbV9hZGRyX3QgcmFtX3NpemUsIGludCB2Z2FfcmFtX3NpemUsCiAgICAgICAgICAgICAgIGNv
bnN0IGNoYXIgKmJvb3RfZGV2aWNlLCBEaXNwbGF5U3RhdGUgKiBkcywKIAkgICAgICBjb25zdCBj
aGFyICprZXJuZWxfZmlsZW5hbWUsIGNvbnN0IGNoYXIgKmtlcm5lbF9jbWRsaW5lLApAQCAtMTM2
LDYgKzIwNywxMCBAQAogewogICAgIENQVVN0YXRlICplbnY7CiAgICAgc3RydWN0IFNINzc1MFN0
YXRlICpzOworICAgIHFlbXVfaXJxICppcnE7CisgICAgUENJQnVzICpwY2k7CisgICAgaW50IGk7
CisKICAgICByYW1fYWRkcl90IHNkcmFtX2FkZHIsIHNtNTAxX3ZnYV9yYW1fYWRkcjsKIAogICAg
IGlmICghY3B1X21vZGVsKQpAQCAtMTUxLDE0ICsyMjYsMjQgQEAKICAgICBzZHJhbV9hZGRyID0g
cWVtdV9yYW1fYWxsb2MoU0RSQU1fU0laRSk7CiAgICAgY3B1X3JlZ2lzdGVyX3BoeXNpY2FsX21l
bW9yeShTRFJBTV9CQVNFLCBTRFJBTV9TSVpFLCBzZHJhbV9hZGRyKTsKICAgICAvKiBSZWdpc3Rl
ciBwZXJpcGhlcmFscyAqLwotICAgIHIyZF9mcGdhX2luaXQoMHgwNDAwMDAwMCk7CisgICAgaXJx
ID0gcjJkX2ZwZ2FfaW5pdCgweDA0MDAwMDAwLCBzaDc3NTBfaXJsKHMpKTsKKyAgICBwY2kgPSBz
aF9wY2lfcmVnaXN0ZXJfYnVzKHIyZF9wY2lfc2V0X2lycSwgcjJkX3BjaV9tYXBfaXJxLCBpcnEs
IDAsIDQpOwogICAgIHMgPSBzaDc3NTBfaW5pdChlbnYpOwogICAgIHNtNTAxX3ZnYV9yYW1fYWRk
ciA9IHFlbXVfcmFtX2FsbG9jKFNNNTAxX1ZSQU1fU0laRSk7CiAgICAgc201MDFfaW5pdChkcywg
MHgxMDAwMDAwMCwgc201MDFfdmdhX3JhbV9hZGRyLCBTTTUwMV9WUkFNX1NJWkUsCiAJICAgICAg
IHNlcmlhbF9oZHNbMl0pOworCisgICAgbW1pb19pZGVfaW5pdCgweDE0MDAxMDAwLCAweDE0MDAw
ODBjLCBpcnFbQ0ZfSURFXSwgMSwKKwkgICAgZHJpdmVzX3RhYmxlW2RyaXZlX2dldF9pbmRleChJ
Rl9JREUsIDAsIDApXS5iZHJ2LCBOVUxMKTsKKwogICAgIC8qIFRvZG86IHJlZ2lzdGVyIG9uIGJv
YXJkIHJlZ2lzdGVycyAqLwogICAgIHsKICAgICAgIGludCBrZXJuZWxfc2l6ZTsKKyAgICAgIC8q
IGluaXRpYWxpemF0aW9uIHdoaWNoIHNob3VsZCBiZSBkb25lIGJ5IGZpcm13YXJlICovCisgICAg
ICB1aW50MzJfdCBiY3IxID0gMTw8MzsgLy8gY3MzIFNEUkFNCisgICAgICB1aW50MTZfdCBiY3Iy
ID0gMzw8KDMqMik7IC8vIGNzMyAzMmJpdAorICAgICAgY3B1X3BoeXNpY2FsX21lbW9yeV93cml0
ZShTSDc3NTBfQkNSMV9BNywgJmJjcjEsIDQpOworICAgICAgY3B1X3BoeXNpY2FsX21lbW9yeV93
cml0ZShTSDc3NTBfQkNSMl9BNywgJmJjcjIsIDIpOwogCiAgICAgICBrZXJuZWxfc2l6ZSA9IGxv
YWRfaW1hZ2Uoa2VybmVsX2ZpbGVuYW1lLCBwaHlzX3JhbV9iYXNlKTsKIApJbmRleDogaHcvc2gu
aAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09Ci0tLSBody9zaC5oCShyZXZpc2lvbiA1NjQ2KQorKysgaHcvc2guaAkod29y
a2luZyBjb3B5KQpAQCAtNDIsNyArNDIsMTQgQEAKIAkJICAgICBzdHJ1Y3QgaW50Y19zb3VyY2Ug
KnRlaV9zb3VyY2UsCiAJCSAgICAgc3RydWN0IGludGNfc291cmNlICpicmlfc291cmNlKTsKIAor
Lyogc2g3NzUwLmMgKi8KK3FlbXVfaXJxIHNoNzc1MF9pcmwoc3RydWN0IFNINzc1MFN0YXRlICpz
KTsKKwogLyogdGM1ODEyOC5jICovCiBpbnQgdGM1ODEyOF9pbml0KHN0cnVjdCBTSDc3NTBTdGF0
ZSAqcywgY29uc3QgY2hhciAqem9uZTEsIGNvbnN0IGNoYXIgKnpvbmUyKTsKIAorLyogaWRlLmMg
Ki8KK3ZvaWQgbW1pb19pZGVfaW5pdCh0YXJnZXRfcGh5c19hZGRyX3QgbWVtYmFzZSwgdGFyZ2V0
X3BoeXNfYWRkcl90IG1lbWJhc2UyLAorCQkgICAgcWVtdV9pcnEgaXJxLCBpbnQgc2hpZnQsCisJ
CSAgICBCbG9ja0RyaXZlclN0YXRlICpoZDAsIEJsb2NrRHJpdmVyU3RhdGUgKmhkMSk7CiAjZW5k
aWYKSW5kZXg6IGh3L3NoNzc1MC5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGh3L3NoNzc1MC5jCShyZXZpc2lv
biA1NjQ2KQorKysgaHcvc2g3NzUwLmMJKHdvcmtpbmcgY29weSkKQEAgLTQxLDYgKzQxLDggQEAK
ICAgICAvKiBQZXJpcGhlcmFsIGZyZXF1ZW5jeSBpbiBIeiAqLwogICAgIHVpbnQzMl90IHBlcmlw
aF9mcmVxOwogICAgIC8qIFNEUkFNIGNvbnRyb2xsZXIgKi8KKyAgICB1aW50MzJfdCBiY3IxOwor
ICAgIHVpbnQzMl90IGJjcjI7CiAgICAgdWludDE2X3QgcmZjcjsKICAgICAvKiBJTyBwb3J0cyAq
LwogICAgIHVpbnQxNl90IGdwaW9pYzsKQEAgLTIwOCw2ICsyMTAsOCBAQAogICAgIFNINzc1MFN0
YXRlICpzID0gb3BhcXVlOwogCiAgICAgc3dpdGNoIChhZGRyKSB7CisgICAgY2FzZSBTSDc3NTBf
QkNSMl9BNzoKKwlyZXR1cm4gcy0+YmNyMjsKICAgICBjYXNlIFNINzc1MF9GUlFDUl9BNzoKIAly
ZXR1cm4gMDsKICAgICBjYXNlIFNINzc1MF9SRkNSX0E3OgpAQCAtMjMxLDYgKzIzNSwxNSBAQAog
ICAgIFNINzc1MFN0YXRlICpzID0gb3BhcXVlOwogCiAgICAgc3dpdGNoIChhZGRyKSB7CisgICAg
Y2FzZSBTSDc3NTBfQkNSMV9BNzoKKwlyZXR1cm4gcy0+YmNyMTsKKyAgICBjYXNlIFNINzc1MF9C
Q1I0X0E3OgorICAgIGNhc2UgU0g3NzUwX1dDUjFfQTc6CisgICAgY2FzZSBTSDc3NTBfV0NSMl9B
NzoKKyAgICBjYXNlIFNINzc1MF9XQ1IzX0E3OgorICAgIGNhc2UgU0g3NzUwX01DUl9BNzoKKwlp
Z25vcmVfYWNjZXNzKCJsb25nIHJlYWQiLCBhZGRyKTsKKwlyZXR1cm4gMDsKICAgICBjYXNlIFNI
Nzc1MF9NTVVDUl9BNzoKIAlyZXR1cm4gcy0+Y3B1LT5tbXVjcjsKICAgICBjYXNlIFNINzc1MF9Q
VEVIX0E3OgpAQCAtMjg1LDYgKzI5OCw4IEBACiAgICAgc3dpdGNoIChhZGRyKSB7CiAJLyogU0RS
QU0gY29udHJvbGxlciAqLwogICAgIGNhc2UgU0g3NzUwX0JDUjJfQTc6CisJcy0+YmNyMiA9IG1l
bV92YWx1ZTsKKwlyZXR1cm47CiAgICAgY2FzZSBTSDc3NTBfQkNSM19BNzoKICAgICBjYXNlIFNI
Nzc1MF9SVENPUl9BNzoKICAgICBjYXNlIFNINzc1MF9SVENOVF9BNzoKQEAgLTMzMSw2ICszNDYs
OCBAQAogICAgIHN3aXRjaCAoYWRkcikgewogCS8qIFNEUkFNIGNvbnRyb2xsZXIgKi8KICAgICBj
YXNlIFNINzc1MF9CQ1IxX0E3OgorCXMtPmJjcjEgPSBtZW1fdmFsdWU7CisJcmV0dXJuOwogICAg
IGNhc2UgU0g3NzUwX0JDUjRfQTc6CiAgICAgY2FzZSBTSDc3NTBfV0NSMV9BNzoKICAgICBjYXNl
IFNINzc1MF9XQ1IyX0E3OgpAQCAtNDEyLDYgKzQyOSw4IEBACiAJVU5VU0VEID0gMCwKIAogCS8q
IGludGVycnVwdCBzb3VyY2VzICovCisJSVJMXzAsIElSTF8xLCBJUkxfMiwgSVJMXzMsIElSTF80
LCBJUkxfNSwgSVJMXzYsIElSTF83LAorCUlSTF84LCBJUkxfOSwgSVJMX0EsIElSTF9CLCBJUkxf
QywgSVJMX0QsIElSTF9FLAogCUlSTDAsIElSTDEsIElSTDIsIElSTDMsIC8qIG9ubHkgSVJMTSBt
b2RlIHN1cHBvcnRlZCAqLwogCUhVREksIEdQSU9JLAogCURNQUNfRE1URTAsIERNQUNfRE1URTEs
IERNQUNfRE1URTIsIERNQUNfRE1URTMsCkBAIC00MjgsMTAgKzQ0NywzNCBAQAogCiAJLyogaW50
ZXJydXB0IGdyb3VwcyAqLwogCURNQUMsIFBDSUMxLCBUTVUyLCBSVEMsIFNDSTEsIFNDSUYsIFJF
RiwKLQorCUlSTCwKIAlOUl9TT1VSQ0VTLAogfTsKIAorc3RhdGljIHN0cnVjdCBpbnRjX3ZlY3Qg
dmVjdG9yc19pcmxbXSA9IHsKKwlJTlRDX1ZFQ1QoSVJMXzAsIDB4MjAwKSwKKwlJTlRDX1ZFQ1Qo
SVJMXzEsIDB4MjIwKSwKKwlJTlRDX1ZFQ1QoSVJMXzIsIDB4MjQwKSwKKwlJTlRDX1ZFQ1QoSVJM
XzMsIDB4MjYwKSwKKwlJTlRDX1ZFQ1QoSVJMXzQsIDB4MjgwKSwKKwlJTlRDX1ZFQ1QoSVJMXzUs
IDB4MmEwKSwKKwlJTlRDX1ZFQ1QoSVJMXzYsIDB4MmMwKSwKKwlJTlRDX1ZFQ1QoSVJMXzcsIDB4
MmUwKSwKKwlJTlRDX1ZFQ1QoSVJMXzgsIDB4MzAwKSwKKwlJTlRDX1ZFQ1QoSVJMXzksIDB4MzIw
KSwKKwlJTlRDX1ZFQ1QoSVJMX0EsIDB4MzQwKSwKKwlJTlRDX1ZFQ1QoSVJMX0IsIDB4MzYwKSwK
KwlJTlRDX1ZFQ1QoSVJMX0MsIDB4MzgwKSwKKwlJTlRDX1ZFQ1QoSVJMX0QsIDB4M2EwKSwKKwlJ
TlRDX1ZFQ1QoSVJMX0UsIDB4M2MwKSwKK307CisKK3N0YXRpYyBzdHJ1Y3QgaW50Y19ncm91cCBn
cm91cHNfaXJsW10gPSB7CisgICAgSU5UQ19HUk9VUChJUkwsIElSTF8wLCBJUkxfMSwgSVJMXzIs
IElSTF8zLCBJUkxfNCwgSVJMXzUsIElSTF82LAorICAgIElSTF83LCBJUkxfOCwgSVJMXzksIElS
TF9BLCBJUkxfQiwgSVJMX0MsIElSTF9ELCBJUkxfRSkKK307CisKKwogc3RhdGljIHN0cnVjdCBp
bnRjX3ZlY3QgdmVjdG9yc1tdID0gewogCUlOVENfVkVDVChIVURJLCAweDYwMCksIElOVENfVkVD
VChHUElPSSwgMHg2MjApLAogCUlOVENfVkVDVChUTVUwLCAweDQwMCksIElOVENfVkVDVChUTVUx
LCAweDQyMCksCkBAIC03MTcsNSArNzYwLDE1IEBACiAJCQkJIE5VTEwsIDApOwogICAgIH0KIAor
ICAgIHNoX2ludGNfcmVnaXN0ZXJfc291cmNlcygmcy0+aW50YywKKwkJCQlfSU5UQ19BUlJBWSh2
ZWN0b3JzX2lybCksCisJCQkJX0lOVENfQVJSQVkoZ3JvdXBzX2lybCkpOwogICAgIHJldHVybiBz
OwogfQorCitxZW11X2lycSBzaDc3NTBfaXJsKFNINzc1MFN0YXRlICpzKQoreworICAgIHNoX2lu
dGNfdG9nZ2xlX3NvdXJjZShzaF9pbnRjX3NvdXJjZSgmcy0+aW50YywgSVJMKSwgMSwgMCk7IC8q
IGVuYWJsZSAqLworICAgIHJldHVybiBxZW11X2FsbG9jYXRlX2lycXMoc2hfaW50Y19zZXRfaXJs
LCBzaF9pbnRjX3NvdXJjZSgmcy0+aW50YywgSVJMKSwKKwkJCQkxKVswXTsKK30KSW5kZXg6IGh3
L2lkZS5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KLS0tIGh3L2lkZS5jCShyZXZpc2lvbiA1NjQ2KQorKysgaHcvaWRl
LmMJKHdvcmtpbmcgY29weSkKQEAgLTM0ODYsNiArMzQ4NiwxMDQgQEAKIH0KIAogLyoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLworLyog
TU1JTyBiYXNlZCBpZGUgcG9ydAorICogVGhpcyBlbXVsYXRlcyBJREUgZGV2aWNlIGNvbm5lY3Rl
ZCBkaXJlY3RseSB0byB0aGUgQ1BVIGJ1cworICogd2l0aG91dCBkZWRpY2F0ZWQgaWRlIGNvbnRy
b2xsZXIsIHdoaWNoIGlzIG9mdGVuIHNlZW4gb24KKyAqIGVtYmVkZGVkIGJvYXJkcy4KKyAqLwor
Cit0eXBlZGVmIHN0cnVjdCB7CisgICAgdm9pZCAqZGV2OworICAgIGludCBzaGlmdDsKK30gTU1J
T1N0YXRlOworCitzdGF0aWMgdWludDMyX3QgbW1pb19pZGVfcmVhZCAodm9pZCAqb3BhcXVlLCB0
YXJnZXRfcGh5c19hZGRyX3QgYWRkcikKK3sKKyAgICBNTUlPU3RhdGUgKnMgPSAoTU1JT1N0YXRl
KilvcGFxdWU7CisgICAgSURFU3RhdGUgKmlkZSA9IChJREVTdGF0ZSopcy0+ZGV2OworICAgIGFk
ZHIgPj49IHMtPnNoaWZ0OworICAgIGlmIChhZGRyICYgNykKKwlyZXR1cm4gaWRlX2lvcG9ydF9y
ZWFkKGlkZSwgYWRkcik7CisgICAgZWxzZQorCXJldHVybiBpZGVfZGF0YV9yZWFkdyhpZGUsIDAp
OworfQorCitzdGF0aWMgdm9pZCBtbWlvX2lkZV93cml0ZSAodm9pZCAqb3BhcXVlLCB0YXJnZXRf
cGh5c19hZGRyX3QgYWRkciwKKwkJdWludDMyX3QgdmFsKQoreworICAgIE1NSU9TdGF0ZSAqcyA9
IChNTUlPU3RhdGUqKSBvcGFxdWU7CisgICAgSURFU3RhdGUgKmlkZSA9IChJREVTdGF0ZSopcy0+
ZGV2OworICAgIGFkZHIgPj49IHMtPnNoaWZ0OworICAgIGlmIChhZGRyICYgNykKKwlpZGVfaW9w
b3J0X3dyaXRlKGlkZSwgYWRkciwgdmFsKTsKKyAgICBlbHNlCisJaWRlX2RhdGFfd3JpdGV3KGlk
ZSwgMCwgdmFsKTsKK30KKworc3RhdGljIENQVVJlYWRNZW1vcnlGdW5jICptbWlvX2lkZV9yZWFk
c1tdID0geworICAgIG1taW9faWRlX3JlYWQsCisgICAgbW1pb19pZGVfcmVhZCwKKyAgICBtbWlv
X2lkZV9yZWFkLAorfTsKKworc3RhdGljIENQVVdyaXRlTWVtb3J5RnVuYyAqbW1pb19pZGVfd3Jp
dGVzW10gPSB7CisgICAgbW1pb19pZGVfd3JpdGUsCisgICAgbW1pb19pZGVfd3JpdGUsCisgICAg
bW1pb19pZGVfd3JpdGUsCit9OworCitzdGF0aWMgdWludDMyX3QgbW1pb19pZGVfc3RhdHVzX3Jl
YWQgKHZvaWQgKm9wYXF1ZSwgdGFyZ2V0X3BoeXNfYWRkcl90IGFkZHIpCit7CisgICAgTU1JT1N0
YXRlICpzID0gKE1NSU9TdGF0ZSopIG9wYXF1ZTsKKyAgICBJREVTdGF0ZSAqaWRlID0gKElERVN0
YXRlKilzLT5kZXY7CisgICAgcmV0dXJuIGlkZV9zdGF0dXNfcmVhZChpZGUsIDApOworfQorCitz
dGF0aWMgdm9pZCBtbWlvX2lkZV9jbWRfd3JpdGUgKHZvaWQgKm9wYXF1ZSwgdGFyZ2V0X3BoeXNf
YWRkcl90IGFkZHIsCisJdWludDMyX3QgdmFsKQoreworICAgIE1NSU9TdGF0ZSAqcyA9IChNTUlP
U3RhdGUqKW9wYXF1ZTsKKyAgICBJREVTdGF0ZSAqaWRlID0gKElERVN0YXRlKilzLT5kZXY7Cisg
ICAgaWRlX2NtZF93cml0ZShpZGUsIDAsIHZhbCk7Cit9CisKK3N0YXRpYyBDUFVSZWFkTWVtb3J5
RnVuYyAqbW1pb19pZGVfc3RhdHVzW10gPSB7CisgICAgbW1pb19pZGVfc3RhdHVzX3JlYWQsCisg
ICAgbW1pb19pZGVfc3RhdHVzX3JlYWQsCisgICAgbW1pb19pZGVfc3RhdHVzX3JlYWQsCit9Owor
CitzdGF0aWMgQ1BVV3JpdGVNZW1vcnlGdW5jICptbWlvX2lkZV9jbWRbXSA9IHsKKyAgICBtbWlv
X2lkZV9jbWRfd3JpdGUsCisgICAgbW1pb19pZGVfY21kX3dyaXRlLAorICAgIG1taW9faWRlX2Nt
ZF93cml0ZSwKK307CisKK3ZvaWQgbW1pb19pZGVfaW5pdCAodGFyZ2V0X3BoeXNfYWRkcl90IG1l
bWJhc2UsIHRhcmdldF9waHlzX2FkZHJfdCBtZW1iYXNlMiwKKwkJcWVtdV9pcnEgaXJxLCBpbnQg
c2hpZnQsIAorCQlCbG9ja0RyaXZlclN0YXRlICpoZDAsIEJsb2NrRHJpdmVyU3RhdGUgKmhkMSkK
K3sKKyAgICBNTUlPU3RhdGUgKnMgPSBxZW11X21hbGxvY3ooc2l6ZW9mKE1NSU9TdGF0ZSkpOwor
ICAgIElERVN0YXRlICppZGUgPSBxZW11X21hbGxvY3ooc2l6ZW9mKElERVN0YXRlKSAqIDIpOwor
ICAgIGludCBtZW0xLCBtZW0yOworICAgIAorICAgIGlkZV9pbml0MihpZGUsIGhkMCwgaGQxLCBp
cnEpOworICAgIAorICAgIHMtPmRldiA9IGlkZTsKKyAgICBzLT5zaGlmdCA9IHNoaWZ0OworICAg
IAorICAgIG1lbTEgPSBjcHVfcmVnaXN0ZXJfaW9fbWVtb3J5KDAsIG1taW9faWRlX3JlYWRzLCBt
bWlvX2lkZV93cml0ZXMsIHMpOworICAgIG1lbTIgPSBjcHVfcmVnaXN0ZXJfaW9fbWVtb3J5KDAs
IG1taW9faWRlX3N0YXR1cywgbW1pb19pZGVfY21kLCBzKTsKKyAgICBjcHVfcmVnaXN0ZXJfcGh5
c2ljYWxfbWVtb3J5KG1lbWJhc2UsIDE2PDxzaGlmdCwgbWVtMSk7CisgICAgY3B1X3JlZ2lzdGVy
X3BoeXNpY2FsX21lbW9yeShtZW1iYXNlMiwgMjw8c2hpZnQsIG1lbTIpOworfQorLyoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKi8KKyAgICAKKworCisKKworLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLwogLyogQ0YtQVRBIE1pY3JvZHJpdmUgKi8K
IAogI2RlZmluZSBNRVRBREFUQV9TSVpFCTB4MjAKSW5kZXg6IGh3L3NoX2ludGMuYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Ci0tLSBody9zaF9pbnRjLmMJKHJldmlzaW9uIDU2NDYpCisrKyBody9zaF9pbnRjLmMJKHdv
cmtpbmcgY29weSkKQEAgLTQ1MSwzICs0NTEsMjEgQEAKIAogICAgIHJldHVybiAwOwogfQorCisv
KiBBc3NlcnQgbGV2ZWwgPG4+IElSTCBpbnRlcnJ1cHQgCisgICAgMDpkZWFzc2VydCwgMTpsb3dl
c3QgcHJpb3JpdHkuLi4gMTU6aGlnaGVzdCBwcmlvcml0eSAqLwordm9pZCBzaF9pbnRjX3NldF9p
cmwodm9pZCAqb3BhcXVlLCBpbnQgbiwgaW50IGxldmVsKQoreworICAgIHN0cnVjdCBpbnRjX3Nv
dXJjZSAqcyA9IG9wYXF1ZTsKKyAgICBpbnQgaSwgaXJsID0gbGV2ZWwgXiAxNTsKKyAgICBmb3Ig
KGkgPSAwOyAocyA9IHNoX2ludGNfc291cmNlKHMtPnBhcmVudCwgcy0+bmV4dF9lbnVtX2lkKSk7
IGkrKykgeworCWlmIChpID09IGlybCkKKwkgICAgc2hfaW50Y190b2dnbGVfc291cmNlKHMsIHMt
PmVuYWJsZV9jb3VudD8wOjEsIHMtPmFzc2VydGVkPzA6MSk7CisJZWxzZQorCSAgICBpZiAocy0+
YXNzZXJ0ZWQpCisJCXNoX2ludGNfdG9nZ2xlX3NvdXJjZShzLCAwLCAtMSk7CisJfQorfQorCisK
KwpJbmRleDogaHcvc2hfaW50Yy5oCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGh3L3NoX2ludGMuaAkocmV2aXNp
b24gNTY0NikKKysrIGh3L3NoX2ludGMuaAkod29ya2luZyBjb3B5KQpAQCAtNzIsNCArNzIsNiBA
QAogCQkgc3RydWN0IGludGNfcHJpb19yZWcgKnByaW9fcmVncywKIAkJIGludCBucl9wcmlvX3Jl
Z3MpOwogCit2b2lkIHNoX2ludGNfc2V0X2lybCh2b2lkICpvcGFxdWUsIGludCBuLCBpbnQgbGV2
ZWwpOworCiAjZW5kaWYgLyogX19TSF9JTlRDX0hfXyAqLwo=

--Multipart=_Sat__8_Nov_2008_21_37_18_+0100_TqQ=v3jE+6h3AM=D
Content-Type: text/x-csrc;
 name="plain-file-sh_pci.c"
Content-Disposition: attachment;
 filename="plain-file-sh_pci.c"
Content-Transfer-Encoding: quoted-printable

/*
 * SuperH on-chip PCIC emulation.     =20
 *
 * Copyright (c) 2008 Takashi YOSHII
 *
 * Permission is hereby granted, free of charge, to any person obtaining a =
copy
 * of this software and associated documentation files (the "Software"), to=
=20
eal
 * in the Software without restriction, including without limitation the ri=
ghts
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included =
in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS =
OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTH=
ER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING=
=20
FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
#include "hw.h"
#include "sh.h"
#include "pci.h"

typedef struct {
    PCIBus *bus;
    PCIDevice *dev;
    uint32_t regbase;
    uint32_t iopbase;
    uint32_t membase;
    uint32_t par;
    uint32_t mbr;
    uint32_t iobr;
} SHPCIC;

static void sh_pci_reg_write (void *p, target_phys_addr_t addr, uint32_t va=
l)
{
    SHPCIC *pcic =3D p;
    addr -=3D pcic->regbase;
    switch(addr) {
      case 0 ... 0xff: *(uint32_t*)(pcic->dev->config + addr) =3D val;
      case 0x1c0: pcic->par =3D val; break;
      case 0x1c4: pcic->mbr =3D val; break;
      case 0x1c8: pcic->iobr =3D val; break;
      case 0x220: pci_data_write(pcic->bus, pcic->par, val, 4);
    }
}

static uint32_t sh_pci_reg_read (void *p, target_phys_addr_t addr)
{
    SHPCIC *pcic =3D p;
    addr -=3D pcic->regbase;
    switch(addr) {
      case 0 ... 0xff: return *(uint32_t*)(pcic->dev->config + addr);
      case 0x1c0: return pcic->par;
      case 0x220: return pci_data_read(pcic->bus, pcic->par, 4);
    }
    return 0;
}

static void sh_pci_data_write (SHPCIC *pcic, target_phys_addr_t addr,
                               uint32_t val, int size)
{
    pci_data_write(pcic->bus, addr - pcic->membase + pcic->mbr, val, size);
}

static uint32_t sh_pci_mem_read (SHPCIC *pcic, target_phys_addr_t addr,
                                 int size)
{
    return pci_data_read(pcic->bus, addr - pcic->membase + pcic->mbr, size);
}

static void sh_pci_writeb (void *p, target_phys_addr_t addr, uint32_t val)
{
    sh_pci_data_write(p, addr, val, 1);
}

static void sh_pci_writew (void *p, target_phys_addr_t addr, uint32_t val)
{
    sh_pci_data_write(p, addr, val, 2);
}

static void sh_pci_writel (void *p, target_phys_addr_t addr, uint32_t val)
{
    sh_pci_data_write(p, addr, val, 4);
}

static uint32_t sh_pci_readb (void *p, target_phys_addr_t addr)
{
    return sh_pci_mem_read(p, addr, 1);
}

static uint32_t sh_pci_readw (void *p, target_phys_addr_t addr)
{
    return sh_pci_mem_read(p, addr, 2);
}

static uint32_t sh_pci_readl (void *p, target_phys_addr_t addr)
{
    return sh_pci_mem_read(p, addr, 4);
}

static int sh_pci_addr2port(SHPCIC *pcic, target_phys_addr_t addr)
{
    return addr - pcic->iopbase + pcic->iobr;
}

static void sh_pci_outb (void *p, target_phys_addr_t addr, uint32_t val)
{
    cpu_outb(NULL, sh_pci_addr2port(p, addr), val);
}

static void sh_pci_outw (void *p, target_phys_addr_t addr, uint32_t val)
{
    cpu_outw(NULL, sh_pci_addr2port(p, addr), val);
}

static void sh_pci_outl (void *p, target_phys_addr_t addr, uint32_t val)
{
    cpu_outl(NULL, sh_pci_addr2port(p, addr), val);
}

static uint32_t sh_pci_inb (void *p, target_phys_addr_t addr)
{
    return cpu_inb(NULL, sh_pci_addr2port(p, addr));
}

static uint32_t sh_pci_inw (void *p, target_phys_addr_t addr)
{
    return cpu_inw(NULL, sh_pci_addr2port(p, addr));
}

static uint32_t sh_pci_inl (void *p, target_phys_addr_t addr)
{
    return cpu_inl(NULL, sh_pci_addr2port(p, addr));
}

typedef struct {
    CPUReadMemoryFunc *r[3];
    CPUWriteMemoryFunc *w[3];
} MemOp;

static MemOp sh_pci_reg =3D {
    { NULL, NULL, sh_pci_reg_read },
    { NULL, NULL, sh_pci_reg_write },
};

static MemOp sh_pci_mem =3D {
    { sh_pci_readb, sh_pci_readw, sh_pci_readl },
    { sh_pci_writeb, sh_pci_writew, sh_pci_writel },
};

static MemOp sh_pci_iop =3D {
    { sh_pci_inb, sh_pci_inw, sh_pci_inl },
    { sh_pci_outb, sh_pci_outw, sh_pci_outl },
};

PCIBus *sh_pci_register_bus(pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                            qemu_irq *pic, int devfn_min, int nirq)
{
    SHPCIC *p;
    int mem, reg, iop;

    p =3D qemu_mallocz(sizeof(SHPCIC));
    p->bus =3D pci_register_bus(set_irq, map_irq, pic, devfn_min, nirq);

    p->dev =3D pci_register_device(p->bus, "SH PCIC", sizeof(PCIDevice),
                                 -1, NULL, NULL);
    p->regbase =3D 0x1e200000;
    p->iopbase =3D 0x1e240000;
    p->membase =3D 0xfd000000;
    reg =3D cpu_register_io_memory(0, sh_pci_reg.r, sh_pci_reg.w, p);
    mem =3D cpu_register_io_memory(0, sh_pci_mem.r, sh_pci_mem.w, p);
    iop =3D cpu_register_io_memory(0, sh_pci_iop.r, sh_pci_iop.w, p);
    cpu_register_physical_memory(p->regbase, 0x224, reg);
    cpu_register_physical_memory(p->iopbase, 0x40000, iop);
    cpu_register_physical_memory(p->membase, 0x1000000, mem);

    p->dev->config[0x00] =3D 0x54; // HITACHI
    p->dev->config[0x01] =3D 0x10; //
    p->dev->config[0x02] =3D 0x0e; // SH7751R
    p->dev->config[0x03] =3D 0x35; //
    p->dev->config[0x04] =3D 0x80;
    p->dev->config[0x05] =3D 0x00;
    p->dev->config[0x06] =3D 0x90;
    p->dev->config[0x07] =3D 0x02;

    return p->bus;
}

--Multipart=_Sat__8_Nov_2008_21_37_18_+0100_TqQ=v3jE+6h3AM=D--

--Signature=_Sat__8_Nov_2008_21_37_19_+0100_vxIf_tZRczq2wD.4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkV+H8ACgkQPQls10ERAGcujQCg0zchdfIJmUvU5jFrv85AR+8I
OAYAn2O1rWzr3hcNCL6RyLEzeaxxwYq0
=W4YR
-----END PGP SIGNATURE-----

--Signature=_Sat__8_Nov_2008_21_37_19_+0100_vxIf_tZRczq2wD.4--
