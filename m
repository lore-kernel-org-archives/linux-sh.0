From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Dec 2008 09:00:30 +0000
Subject: [PATCH 05/06] sh: remove ioport cruft and smc91x from se7343
Message-Id: <20081204090030.25773.62616.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove out-of-date se7343 ioport code including some old support
for unknown-ne2000-pcmcia-card, cf-over-pcmcia and a mysterical
smc91x that once must have been on a special daughterboard.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7343/Makefile  |    2 
 arch/sh/boards/mach-se/7343/io.c      |  273 ---------------------------------
 arch/sh/boards/mach-se/7343/setup.c   |   46 -----
 arch/sh/include/mach-se/mach/se7343.h |    3 
 4 files changed, 1 insertion(+), 323 deletions(-)

--- 0001/arch/sh/boards/mach-se/7343/Makefile
+++ work/arch/sh/boards/mach-se/7343/Makefile	2008-12-04 16:32:21.000000000 +0900
@@ -2,4 +2,4 @@
 # Makefile for the 7343 SolutionEngine specific parts of the kernel
 #
 
-obj-y	 := setup.o io.o irq.o
+obj-y	 := setup.o irq.o
--- 0001/arch/sh/boards/mach-se/7343/io.c
+++ /dev/null	2008-12-03 11:12:15.442019092 +0900
@@ -1,273 +0,0 @@
-/*
- * arch/sh/boards/se/7343/io.c
- *
- * I/O routine for SH-Mobile3AS 7343 SolutionEngine.
- *
- */
-#include <linux/kernel.h>
-#include <asm/io.h>
-#include <mach-se/mach/se7343.h>
-
-#define badio(fn, a) panic("bad i/o operation %s for %08lx.", #fn, a)
-
-struct iop {
-	unsigned long start, end;
-	unsigned long base;
-	struct iop *(*check) (struct iop * p, unsigned long port);
-	unsigned char (*inb) (struct iop * p, unsigned long port);
-	unsigned short (*inw) (struct iop * p, unsigned long port);
-	void (*outb) (struct iop * p, unsigned char value, unsigned long port);
-	void (*outw) (struct iop * p, unsigned short value, unsigned long port);
-};
-
-struct iop *
-simple_check(struct iop *p, unsigned long port)
-{
-	static int count;
-
-	if (count < 100)
-		count++;
-
-	port &= 0xFFFF;
-
-	if ((p->start <= port) && (port <= p->end))
-		return p;
-	else
-		badio(check, port);
-}
-
-struct iop *
-ide_check(struct iop *p, unsigned long port)
-{
-	if (((0x1f0 <= port) && (port <= 0x1f7)) || (port = 0x3f7))
-		return p;
-	return NULL;
-}
-
-unsigned char
-simple_inb(struct iop *p, unsigned long port)
-{
-	return *(unsigned char *) (p->base + port);
-}
-
-unsigned short
-simple_inw(struct iop *p, unsigned long port)
-{
-	return *(unsigned short *) (p->base + port);
-}
-
-void
-simple_outb(struct iop *p, unsigned char value, unsigned long port)
-{
-	*(unsigned char *) (p->base + port) = value;
-}
-
-void
-simple_outw(struct iop *p, unsigned short value, unsigned long port)
-{
-	*(unsigned short *) (p->base + port) = value;
-}
-
-unsigned char
-pcc_inb(struct iop *p, unsigned long port)
-{
-	unsigned long addr = p->base + port + 0x40000;
-	unsigned long v;
-
-	if (port & 1)
-		addr += 0x00400000;
-	v = *(volatile unsigned char *) addr;
-	return v;
-}
-
-void
-pcc_outb(struct iop *p, unsigned char value, unsigned long port)
-{
-	unsigned long addr = p->base + port + 0x40000;
-
-	if (port & 1)
-		addr += 0x00400000;
-	*(volatile unsigned char *) addr = value;
-}
-
-unsigned char
-bad_inb(struct iop *p, unsigned long port)
-{
-	badio(inb, port);
-}
-
-void
-bad_outb(struct iop *p, unsigned char value, unsigned long port)
-{
-	badio(inw, port);
-}
-
-#ifdef CONFIG_SMC91X
-/* MSTLANEX01 LAN at 0xb400:0000 */
-static struct iop laniop = {
-	.start = 0x00,
-	.end = 0x0F,
-	.base = 0x04000000,
-	.check = simple_check,
-	.inb = simple_inb,
-	.inw = simple_inw,
-	.outb = simple_outb,
-	.outw = simple_outw,
-};
-#endif
-
-#ifdef CONFIG_NE2000
-/* NE2000 pc card NIC */
-static struct iop neiop = {
-	.start = 0x280,
-	.end = 0x29f,
-	.base = 0xb0600000 + 0x80,	/* soft 0x280 -> hard 0x300 */
-	.check = simple_check,
-	.inb = pcc_inb,
-	.inw = simple_inw,
-	.outb = pcc_outb,
-	.outw = simple_outw,
-};
-#endif
-
-#ifdef CONFIG_IDE
-/* CF in CF slot */
-static struct iop cfiop = {
-	.base = 0xb0600000,
-	.check = ide_check,
-	.inb = pcc_inb,
-	.inw = simple_inw,
-	.outb = pcc_outb,
-	.outw = simple_outw,
-};
-#endif
-
-static __inline__ struct iop *
-port2iop(unsigned long port)
-{
-	if (0) ;
-#if defined(CONFIG_SMC91X)
-	else if (laniop.check(&laniop, port))
-		return &laniop;
-#endif
-#if defined(CONFIG_NE2000)
-	else if (neiop.check(&neiop, port))
-		return &neiop;
-#endif
-#if defined(CONFIG_IDE)
-	else if (cfiop.check(&cfiop, port))
-		return &cfiop;
-#endif
-	else
-		return NULL;
-}
-
-static inline void
-delay(void)
-{
-	ctrl_inw(0xac000000);
-	ctrl_inw(0xac000000);
-}
-
-unsigned char
-sh7343se_inb(unsigned long port)
-{
-	struct iop *p = port2iop(port);
-	return (p->inb) (p, port);
-}
-
-unsigned char
-sh7343se_inb_p(unsigned long port)
-{
-	unsigned char v = sh7343se_inb(port);
-	delay();
-	return v;
-}
-
-unsigned short
-sh7343se_inw(unsigned long port)
-{
-	struct iop *p = port2iop(port);
-	return (p->inw) (p, port);
-}
-
-unsigned int
-sh7343se_inl(unsigned long port)
-{
-	badio(inl, port);
-}
-
-void
-sh7343se_outb(unsigned char value, unsigned long port)
-{
-	struct iop *p = port2iop(port);
-	(p->outb) (p, value, port);
-}
-
-void
-sh7343se_outb_p(unsigned char value, unsigned long port)
-{
-	sh7343se_outb(value, port);
-	delay();
-}
-
-void
-sh7343se_outw(unsigned short value, unsigned long port)
-{
-	struct iop *p = port2iop(port);
-	(p->outw) (p, value, port);
-}
-
-void
-sh7343se_outl(unsigned int value, unsigned long port)
-{
-	badio(outl, port);
-}
-
-void
-sh7343se_insb(unsigned long port, void *addr, unsigned long count)
-{
-	unsigned char *a = addr;
-	struct iop *p = port2iop(port);
-	while (count--)
-		*a++ = (p->inb) (p, port);
-}
-
-void
-sh7343se_insw(unsigned long port, void *addr, unsigned long count)
-{
-	unsigned short *a = addr;
-	struct iop *p = port2iop(port);
-	while (count--)
-		*a++ = (p->inw) (p, port);
-}
-
-void
-sh7343se_insl(unsigned long port, void *addr, unsigned long count)
-{
-	badio(insl, port);
-}
-
-void
-sh7343se_outsb(unsigned long port, const void *addr, unsigned long count)
-{
-	unsigned char *a = (unsigned char *) addr;
-	struct iop *p = port2iop(port);
-	while (count--)
-		(p->outb) (p, *a++, port);
-}
-
-void
-sh7343se_outsw(unsigned long port, const void *addr, unsigned long count)
-{
-	unsigned short *a = (unsigned short *) addr;
-	struct iop *p = port2iop(port);
-	while (count--)
-		(p->outw) (p, *a++, port);
-}
-
-void
-sh7343se_outsl(unsigned long port, const void *addr, unsigned long count)
-{
-	badio(outsw, port);
-}
--- 0005/arch/sh/boards/mach-se/7343/setup.c
+++ work/arch/sh/boards/mach-se/7343/setup.c	2008-12-04 16:32:21.000000000 +0900
@@ -11,30 +11,6 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 
-static struct resource smc91x_resources[] = {
-	[0] = {
-		.start	= 0x10000000,
-		.end	= 0x1000000F,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		/*
-		 * shared with other devices via externel
-		 * interrupt controller in FPGA...
-		 */
-		.start	= SMC_IRQ,
-		.end	= SMC_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device smc91x_device = {
-	.name		= "smc91x",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(smc91x_resources),
-	.resource	= smc91x_resources,
-};
-
 static struct resource heartbeat_resources[] = {
 	[0] = {
 		.start	= PA_LED,
@@ -171,7 +147,6 @@ static struct platform_device usb_device
 };
 
 static struct platform_device *sh7343se_platform_devices[] __initdata = {
-	&smc91x_device,
 	&heartbeat_device,
 	&nor_flash_device,
 	&uart_device,
@@ -205,26 +180,5 @@ static struct sh_machine_vector mv_7343s
 	.mv_name = "SolutionEngine 7343",
 	.mv_setup = sh7343se_setup,
 	.mv_nr_irqs = SE7343_FPGA_IRQ_BASE + SE7343_FPGA_IRQ_NR,
-	.mv_inb = sh7343se_inb,
-	.mv_inw = sh7343se_inw,
-	.mv_inl = sh7343se_inl,
-	.mv_outb = sh7343se_outb,
-	.mv_outw = sh7343se_outw,
-	.mv_outl = sh7343se_outl,
-
-	.mv_inb_p = sh7343se_inb_p,
-	.mv_inw_p = sh7343se_inw,
-	.mv_inl_p = sh7343se_inl,
-	.mv_outb_p = sh7343se_outb_p,
-	.mv_outw_p = sh7343se_outw,
-	.mv_outl_p = sh7343se_outl,
-
-	.mv_insb = sh7343se_insb,
-	.mv_insw = sh7343se_insw,
-	.mv_insl = sh7343se_insl,
-	.mv_outsb = sh7343se_outsb,
-	.mv_outsw = sh7343se_outsw,
-	.mv_outsl = sh7343se_outsl,
-
 	.mv_init_irq = init_7343se_IRQ,
 };
--- 0004/arch/sh/include/mach-se/mach/se7343.h
+++ work/arch/sh/include/mach-se/mach/se7343.h	2008-12-04 16:32:21.000000000 +0900
@@ -118,9 +118,6 @@
 #define FPGA_IN		0xb1400000
 #define FPGA_OUT	0xb1400002
 
-#define __IO_PREFIX	sh7343se
-#include <asm/io_generic.h>
-
 #define IRQ0_IRQ        32
 #define IRQ1_IRQ        33
 #define IRQ4_IRQ        36
