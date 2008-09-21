From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 21 Sep 2008 10:01:50 +0000
Subject: Re: Kernel configurations for R2D PLUS with Compact Flush support
Message-Id: <20080921100149.GA8905@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48D60BEA.2040806@juno.dti.ne.jp>
In-Reply-To: <48D60BEA.2040806@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 21, 2008 at 05:55:06PM +0900, Shin-ichiro KAWASAKI wrote:
> I have a plan to work on QEMU System Emulation for SH4.
> Now I consider how add compact flush/CF card support for QEMU-SH.
> If the CF would have supported, userland can be built on it.
> 
> But I have some troubles listed below.
> 
> - kernel configuration
> 
>   rts7751r2dplus_defconfig does not seem to enable CF support.
>   I'm not sure what kind of configuration is correct for R2D PLUS.
>   Enabling CONFIG_PCCARD or CONFIG_CF_ENABLER will be enough?
>   Is there a sample configuration?
> 
CF disks are handled through the pata_platform driver. Take a look at
drivers/ata/pata_platform.c.

> - CF driver
> 
>   The driver for the CF card will be a good reference to extend QEMU
>   for CF.  But I'm not sure which driver module handles CF.
> 
>   R2D plus' CF area placed in area 5 which starts from 1400-0000, and
>   when it is accessed via P2, the address start from b400-0000.
>   The start up routine for R2D PLUS set traps for the region and 
>   converted into the access to a region starts from c000-0000.
> 
>   Which driver accesses to c000-0000?  ATA drivers?
> 
Yes. arch/sh/boards/mach-r2d/setup.c contains the area 5 references in
cf_ide_resources, which in turn is handed off to the pata_platform
driver. pata_platform itself is just a simple driver that does straight
PIO access and optionally wires up the IRQ handler.

> - CF interrupts handler
> 
>   The document on R2D plus says interrupts related to CF is invoked by 
>   FPGA on the board.  And arch/sh/boards/mach-r2d/irq.c sets up
>   IRQ_CF_CD(card detect), and IRQ_CF_IDE.  I want know which part
>   of the kernel handles those interrupts.
> 
These are handled by the ATA interrupt handler, look at
ata_sff_interrupt() in drivers/ata/libata-sff.c.

Note that you can optionally just hand in 0 for the IRQ in order to
disable IRQ mode and simply default to polling (which the following patch
does).

> Any help or comments will be welcome.  Thanks.
> 
I had the same idea on the flight back from kernel summit :-)

So, how about something like this for a start?

---

 Makefile.target |    1 +
 hw/ide.c        |    3 ++-
 hw/r2d.c        |   24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

Index: Makefile.target
=================================--- Makefile.target	(revision 5262)
+++ Makefile.target	(working copy)
@@ -620,6 +620,7 @@
 ifeq ($(TARGET_BASE_ARCH), sh4)
 OBJS+= shix.o r2d.o sh7750.o sh7750_regnames.o tc58128.o
 OBJS+= sh_timer.o ptimer.o sh_serial.o sh_intc.o
+OBJS+= ide.o
 endif
 ifeq ($(TARGET_BASE_ARCH), m68k)
 OBJS+= an5206.o mcf5206.o ptimer.o mcf_uart.o mcf_intc.o mcf5208.o mcf_fec.o
Index: hw/r2d.c
=================================--- hw/r2d.c	(revision 5262)
+++ hw/r2d.c	(working copy)
@@ -25,12 +25,16 @@
 
 #include "hw.h"
 #include "sh.h"
+#include "pc.h"
+#include "isa.h"
 #include "sysemu.h"
 #include "boards.h"
 
 #define SDRAM_BASE 0x0c000000 /* Physical location of SDRAM: Area 3 */
 #define SDRAM_SIZE 0x04000000
 
+#define MAX_IDE_BUS	2
+
 #define PA_POWOFF	0x30
 #define PA_VERREG	0x32
 #define PA_OUTPORT	0x36
@@ -126,6 +130,8 @@
     cpu_register_physical_memory(base, 0x40, iomemtype);
 }
 
+static const int ide_iobase[2] = { 0x14001000, 0x1400080c };
+
 static void r2d_init(ram_addr_t ram_size, int vga_ram_size,
               const char *boot_device, DisplayState * ds,
 	      const char *kernel_filename, const char *kernel_cmdline,
@@ -133,6 +139,8 @@
 {
     CPUState *env;
     struct SH7750State *s;
+    BlockDriverState *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
+    int i, index;
 
     if (!cpu_model)
         cpu_model = "SH7751R";
@@ -148,6 +156,22 @@
     /* Register peripherals */
     r2d_fpga_init(0x04000000);
     s = sh7750_init(env);
+
+    if (drive_get_max_bus(IF_IDE) >= MAX_IDE_BUS) {
+        fprintf(stderr, "qemu: too many IDE busses\n");
+        exit(1);
+    }
+
+    for(i = 0; i < MAX_IDE_BUS * MAX_IDE_DEVS; i++) {
+        index = drive_get_index(IF_IDE, i / MAX_IDE_DEVS, i % MAX_IDE_DEVS);
+        if (index != -1)
+            hd[i] = drives_table[index].bdrv;
+        else
+            hd[i] = NULL;
+    }
+
+    isa_ide_init(ide_iobase[0], ide_iobase[1], 0, hd[0], NULL);
+
     /* Todo: register on board registers */
     {
       int kernel_size;
Index: hw/ide.c
=================================--- hw/ide.c	(revision 5262)
+++ hw/ide.c	(working copy)
@@ -2665,8 +2665,9 @@
     static int drive_serial = 1;
     int i, cylinders, heads, secs, translation, lba_detected = 0;
     uint64_t nb_sectors;
+    int max_drives = hd1 ? 2 : 1;
 
-    for(i = 0; i < 2; i++) {
+    for(i = 0; i < max_drives; i++) {
         s = ide_state + i;
         s->io_buffer = qemu_memalign(512, IDE_DMA_BUF_SECTORS*512 + 4);
         if (i = 0)
