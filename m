From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 02 Jun 2010 06:32:19 +0000
Subject: Re: [PATCH 1/4] Add the directory mach-sh2007 for SH-2007 board support
Message-Id: <20100602063218.GF15411@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 31, 2010 at 04:59:53PM +0900, Hitoshi Mitake wrote:
> This patch adds files for SH-2007 support.
> onboardio.c ... Create /dev/dipsw. This file is for reading state of dip switch
> 	    	and writing power and error LED.
> 		(LEDs are pseudo things.)

It's not obvious that there's any point in having this as a misc device
over simply exposing the dip switch and LED toggling through sysfs.

The LEDs should ideally be managed through the LED subsystem, but as
there is no generic platform device driver there at the moment you would
have to see about writing one.

> diff --git a/arch/sh/boards/mach-sh2007/setup.c b/arch/sh/boards/mach-sh2007/setup.c
> new file mode 100644
> index 0000000..1f21a17
> --- /dev/null
> +++ b/arch/sh/boards/mach-sh2007/setup.c
> +static struct pata_platform_info cf_info = {
> +	.ioport_shift	= 0,
> +};
> +
This isn't needed, 0 is the default.

> +static struct pata_platform_info ide_info = {
> +	.ioport_shift	= 0,
> +};
> +
Likewise.

> +int __init sh2007_io_init(void)
> +{
> +	platform_add_devices(sh2007_devices, ARRAY_SIZE(sh2007_devices));
> +	return 0;
> +}
> +subsys_initcall(sh2007_io_init);
> +
This can be static.

> +#define CF_PORT(x)	((x & ~0xffff020f) = CF_OFFSET)
> +#define IDE_PORT(x)	((x & ~0xffff020f) = IDE_OFFSET)
> +#define PCI_PORT(x)	(x >= 0xfe000000 && x < 0xfe400000)
> +
> +static void __iomem *sh2007_ioport_map(unsigned long offset, unsigned int size)
> +{
> +	if (PCI_PORT(offset))
> +		return (void __iomem *)offset;
> +	if (IDE_PORT(offset))	/* IDE (160-16f, 360-36f) */
> +		return (void __iomem *)(IDE_BASE + (offset & 0xffff));
> +	if (CF_PORT(offset))	/* Compact Flash (1f0-1ff, 3f0-3ff) */
> +		return (void __iomem *)(CF_BASE + (offset & 0xffff));
> +	offset &= 0x01ffffff;
> +	return (void __iomem *)(PC104_IO_BASE + offset);
> +}
> +
We're trying to move away from this sort of PIO abuse, especially since
with the exception of PCI none of these are really PIO in the first
place.

Most of this sort of code is legacy crap when people didn't want to
modify PIO drivers and wanted to make everything look like an x86. This
hasn't been useful since the 2.2.x/2.4.x kernels, and we definitely don't
want more of it now.

It's clear from the machvec definition for this board that it doesn't
have any exotic port shifting and masking to worry about (or any special
buswidth limitations), so you should be able to simply kill this off
completely and fix up the platform device resources to reference the MMIO
addresses directly.

The PCI host controller code already takes care of registering the PCI
I/O window as the base for the PIO routines, so legacy PCI drivers will
work fine with this. I would recommend disabling PCI and having your
platform select NO_IOPORT in order to make it easier to fully migrate to
MMIO (you can use current git head or the sh/iomap topic branch for this,
sdk7786 is a good example to follow).

> +#define IODELAY()	ndelay(200)
> +
Nothing uses this?

> +static int sh2007_irq_remap[] = {
> +	IRQ_SMC0,	/* nIRL0 */
> +	IRQ_SMC1,	/* nIRL1 */
> +	IRQ_CFCARD,	/* nIRL2 */
> +	IRQ_IDE,	/* nIRL3 */
> +	3,		 /* nIRL4 (PC104 IRQ3) */
> +	4,		/* nIRL5 (PC104 IRQ4) */
> +	5,		/* nIRL6 (PC104 IRQ5) */
> +	7,		/* nIRL7 (PC104 IRQ7) */
> +};
> +
> +static int sh2007_irq_demux(int irq)
> +{
> +	if ((unsigned int)irq < 15) {
> +		irq = ((irq>>1)-1) & 7;
> +		irq = sh2007_irq_remap[irq];
> +	}
> +	return irq;
> +}
> +
This looks like a very clumsy way to do IRL to IRQ mapping, I suggest
looking at mach-r2d or mach-highlander on how to tie this in cleanly.

> +/* Support for external interrupt pins in IRQ mode */
> +enum {IRQ0 = 1, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7};
> +static struct intc_vect irq_vectors[] __initdata = {
> +	INTC_IRQ(IRQ0, IRQ_SMC0),
> +	INTC_IRQ(IRQ1, IRQ_SMC1),
> +	INTC_IRQ(IRQ2, IRQ_CFCARD),
> +	INTC_IRQ(IRQ3, IRQ_IDE),
> +	INTC_IRQ(IRQ4, 3),
> +	INTC_IRQ(IRQ5, 4),
> +	INTC_IRQ(IRQ6, 5),
> +	INTC_IRQ(IRQ7, 7),
> +};
> +
> +static struct intc_mask_reg irq_mask_registers[] __initdata = {
> +	{ INTC_INTMSK0, INTC_INTMSKCLR0, 32,
> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> +};
> +
> +static struct intc_prio_reg irq_prio_registers[] __initdata = {
> +	{ INTC_INTPRI, 0, 32, 4,
> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> +};
> +
> +static struct intc_sense_reg irq_sense_registers[] __initdata = {
> +	{ INTC_ICR1, 32, 2,
> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> +};
> +
> +static struct intc_mask_reg irq_ack_registers[] __initdata = {
> +	{ INTC_INTREQ, 0, 32,
> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> +};
> +
> +static DECLARE_INTC_DESC_ACK(intc_irq_desc, "sh7780-irq", irq_vectors,
> +			NULL, irq_mask_registers, irq_prio_registers,
> +			irq_sense_registers, irq_ack_registers);
> +
None of this is needed, it's all taken care of by the SH7780 CPU code
already.

> +static void __init sh2007_init_irq(void)
> +{
> +	/* INTC SH-4 compatible Mode */
> +	ctrl_outl(0x00e00000, INTC_ICR0);
> +	/* individual interrupt level sense type */
> +	ctrl_outl(ICR1_DATA, INTC_ICR1);
> +	/* mask IRL0-7 individual Interrupt */
> +	ctrl_outl(0xff000000, INTC_INTMSK0);
> +	/* mask IRL4-7 encoded interrupt */
> +	ctrl_outl(0xff000000, INTC_INTMSK1);
> +	/* mask IRL0-7 encoded interrupt */
> +	ctrl_outl(0xfffefffe, INTC_INTMSK2);
> +	ctrl_inl(INTC_INTREQ);
> +	/* clear all edge sense interrupt request */
> +	ctrl_outl(0x00000000, INTC_INTREQ);
> +
> +	register_intc_controller(&intc_irq_desc);
> +}
> +
ctrl_in/outX() are deprecated, you want __raw_read/writeX(). Despite
that, none of this code is necessary either since the CPU code already
takes care of it.

Take a look at arch/sh/kernel/cpu/sh4a/setup-sh7780.c, specifically
plat_irq_setup_pins() for setting the different IRQ/IRL modes.
mach-highlander is also worth looking at, since it does most of the same
things.

> +/*
> + * Initialize the board
> + */
> +static void __init sh2007_setup(char **cmdline_p)
> +{
> +	printk(KERN_INFO "SH-2007 Setup...");
> +	/* clear user interrupt mask */
> +	ctrl_outl(0x00000000, INTC_USERIMASK);
> +	/* disable all module interrupt */
> +	ctrl_outl(0xffffffff, INTC_INT2MSKR);
> +

No board code should be touching any of this, USERIMASK has its own
support infrastructure, and the INTC masking is likewise taken care of by
the CPU setup.

> +	/* setup wait control registers for area 5 */
> +	ctrl_outl(CS5BCR_D, CS5BCR);
> +	ctrl_outl(CS5WCR_D, CS5WCR);
> +	ctrl_outl(CS5PCR_D, CS5PCR);
> +
__raw_writel()

> +	ctrl_outl(ctrl_inl(CPUOPM) & ~0x20, CPUOPM);	/* drop RABD bit */

This is exceptionally lazy, RABD is only enabled if you enable
CONFIG_SPECULATIVE_EXECUTION. If you don't want this, then just turn the
config option off.

> +	ctrl_outl(0, IRMCR);
> +	asm volatile ("icbi @%0" : : "r"(0xa0000000));

This also has no place in the board code. The default value is already 0,
and if we at some point want to add options to change this at the CPU
level then the board certainly has no place disabling it silently.

> + */
> +struct sh_machine_vector mv_sh2007 __initmv = {
> +	.mv_setup		= sh2007_setup,
> +	.mv_name		= "sh2007",
> +	.mv_nr_irqs		= NR_IRQS,
> +

NR_IRQS is the default, so this doesn't need to be set either.
