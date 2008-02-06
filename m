From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Feb 2008 21:44:59 +0000
Subject: Re: [PATCH] sh: trapped io support
Message-Id: <20080206214459.GB13945@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080206151929.27099.5627.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080206151929.27099.5627.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 07, 2008 at 12:19:29AM +0900, Magnus Damm wrote:
> --- 0001/arch/sh/Kconfig
> +++ work/arch/sh/Kconfig	2008-02-06 22:57:22.000000000 +0900
> @@ -324,6 +324,9 @@ source "arch/sh/Kconfig.cpu"
>  
>  menu "Board support"
>  
> +config IO_TRAPPED
> +	bool
> +
>  config SOLUTION_ENGINE
>  	bool
>  
This is a pretty bizarre place to put this symbol.

> --- 0001/arch/sh/kernel/io.c
> +++ work/arch/sh/kernel/io.c	2008-02-06 22:57:22.000000000 +0900
> @@ -63,6 +63,14 @@ EXPORT_SYMBOL(memset_io);
>  
>  void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> +	void __iomem *ret;
> +
> +	if (nr > 4) {
> +		ret = ioremap_trapped(port, nr, IORESOURCE_IO);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return sh_mv.mv_ioport_map(port, nr);
>  }
>  EXPORT_SYMBOL(ioport_map);

SH-5 needs 64-bit I/O, as do some of the SH-5 blocks that have showed up
on SH-4 parts (ie, the SH4-202 SuperHyway CVRs and so on). I don't know
that there's any point in tying to hook this in here for unhandled sizes.

> +unsigned int trapped_ioread8(void __iomem *addr)
> +{
> +	return ctrl_inb((unsigned long __force)addr);
> +}
> +
> +unsigned int trapped_ioread16(void __iomem *addr)
> +{
> +	return ctrl_inw((unsigned long __force)addr);
> +}
> +
> +unsigned int trapped_ioread32(void __iomem *addr)
> +{
> +	return ctrl_inl((unsigned long __force)addr);
> +}
> +
> +void trapped_iowrite8(unsigned int data, void __iomem *addr)
> +{
> +	ctrl_outb(data, (unsigned long __force)addr);
> +}
> +
> +void trapped_iowrite16(unsigned int data, void __iomem *addr)
> +{
> +	ctrl_outw(data, (unsigned long __force)addr);
> +}
> +
> +void trapped_iowrite32(unsigned int data, void __iomem *addr)
> +{
> +	ctrl_outl(data, (unsigned long __force)addr);
> +}
> +
It would be nice to ioport_map() these directly and do away with the
__force casting, as per generic I/O.

> +LIST_HEAD(trapped_io);
> +LIST_HEAD(trapped_mem);

These should probably be conditionalized on CONFIG_HAS_IOPORT and
CONFIG_HAS_IOMEM, so at least boards that don't have any use for the
ioport stuff can save some space here.

> +static DEFINE_SPINLOCK(trapped_lock);
> +
> +#define TRAPPED_PAGES_MAX 16
> +
> +void __init register_trapped_io_handler(struct trapped_io *tiop)
> +{
There are a lot of things that can fail in here, please make this an int
and actually pass back the return value as opposed to just BUG'ing out at
the first sign of trouble.

Perhaps it's worth splitting out the platform devices in to a set of
trapped devices and non-trapped, then only registering the trapped ones
when the trapped page setup succeeds. There's no reason to bring down the
rest of the system because you can't trap non-standard writes to a mostly
broken SuperIO.

> +static int from_device(void *dst, void *src, int cnt)
> +{
> +	struct trapped_io *tiop;
> +	unsigned long addr = (unsigned long)src;
> +	unsigned int tmp = 0;
> +
> +	tiop = lookup_tiop(addr);
> +	BUG_ON(!tiop);
> +	BUG_ON(tiop->magic != IO_TRAPPED_MAGIC);
> +
Same deal here. You can in fact pass back an error code without
BUG()'ing.

> +	addr = lookup_address(tiop, addr);
> +#ifdef DEBUG
> +	printk(KERN_DEBUG "trapped io read! 0x%08x, %d",
> +	       (unsigned int)src, cnt);
> +#endif

pr_debug().

> +	switch (cnt) {
> +	case 1:
> +		tmp = tiop->read8((void __iomem *)addr);
> +		*(unsigned char *)dst = tmp & 0xff;
> +		break;
> +	case 2:
> +		tmp = tiop->read16((void __iomem *)addr);
> +		*(unsigned short *)dst = tmp & 0xffff;
> +		break;
> +	case 4:
> +		tmp = tiop->read32((void __iomem *)addr);
> +		*(unsigned int *)dst = tmp;
> +		break;
> +	default:
> +		BUG();
> +	}
ctrl_outX() for these. The __iomem cast back and forth is also fairly
ugly. Since you force an unsigned long to a void __iomem * here and then
back to an unsigned long in the routines themselves. Grr.

> +#ifdef DEBUG
> +	printk(" -> 0x%08x 0x%08x\n", (unsigned int)addr, (unsigned int)tmp);
> +#endif

pr_debug().

> +static int to_device(void *dst, void *src, int cnt)
> +{
> +	struct trapped_io *tiop;
> +	unsigned long addr = (unsigned long)dst;
> +	unsigned int tmp = 0;
> +
> +	tiop = lookup_tiop(addr);
> +	BUG_ON(!tiop);
> +	BUG_ON(tiop->magic != IO_TRAPPED_MAGIC);
> +
> +	addr = lookup_address(tiop, addr);
> +#ifdef DEBUG
> +	printk(KERN_DEBUG "trapped io write! 0x%08x, %d",
> +	       (unsigned int)dst, cnt);
> +#endif
> +	switch (cnt) {
> +	case 1:
> +		tmp = *(unsigned char *)src;
> +		tiop->write8(tmp, (void __iomem *)addr);
> +		break;
> +	case 2:
> +		tmp = *(unsigned short *)src;
> +		tiop->write16(tmp, (void __iomem *)addr);
> +		break;
> +	case 4:
> +		tmp = *(unsigned int *)src;
> +		tiop->write32(tmp, (void __iomem *)addr);
> +		break;
> +	default:
> +		BUG();
> +	}

ctrl_inX() here.

> +#ifdef DEBUG
> +	printk("-> 0x%08x 0x%08x\n", (unsigned int)addr, (unsigned int)tmp);
> +#endif

pr_debug().

> +int handle_trapped_io(struct pt_regs *regs, unsigned long address)
> +{
> +	mm_segment_t oldfs;
> +	u16 instruction;
> +	int tmp;
> +
opcode_size_t.

> +	if (!lookup_tiop(address))
> +		return 0;
> +
> +	BUG_ON(user_mode(regs));
> +
> +	oldfs = get_fs();
> +	set_fs(KERNEL_DS);
> +	if (copy_from_user(&instruction, (u16 *)(regs->pc), 2)) {
> +		set_fs(oldfs);
> +		BUG();
> +		return 0;
> +	}
> +
opcode_size_t and instruction_size(). The BUG()'s here are also far too
aggressive, neither one looks helpful.

> +	tmp = handle_unaligned_access(instruction, regs, &trapped_mem_access);
> +	set_fs(oldfs);
> +	return !tmp;

return tmp = 0 is a bit less ugly in these sorts of cases.

> --- 0005/arch/sh/kernel/traps_32.c
> +++ work/arch/sh/kernel/traps_32.c	2008-02-06 22:57:22.000000000 +0900
> @@ -150,18 +150,43 @@ static int die_if_no_fixup(const char * 
>  static inline void sign_extend(unsigned int count, unsigned char *dst)
>  {
>  #ifdef __LITTLE_ENDIAN__
> +	if ((count = 1) && dst[0] & 0x80) {
> +		dst[1] = 0xff;
> +		dst[2] = 0xff;
> +		dst[3] = 0xff;
> +	}
>  	if ((count = 2) && dst[1] & 0x80) {
>  		dst[2] = 0xff;
>  		dst[3] = 0xff;
>  	}
>  #else
> -	if ((count = 2) && dst[2] & 0x80) {
> +	if ((count = 1) && dst[3] & 0x80) {
> +		dst[2] = 0xff;
> +		dst[1] = 0xff;
>  		dst[0] = 0xff;
> +	}
> +	if ((count = 2) && dst[2] & 0x80) {
>  		dst[1] = 0xff;
> +		dst[0] = 0xff;
>  	}
>  #endif
>  }
>  
Shouldn't this be a separate patch?

> +static int from_user(void *dst, void *src, int cnt)
> +{
> +	return copy_from_user(dst, src, cnt);
> +}
> +
> +static int to_user(void *dst, void *src, int cnt)
> +{
> +	return copy_to_user(dst, src, cnt);
> +}
> +
> +static struct mem_access user_mem_access = {
> +	from_user,
> +	to_user,
> +};
> +
The argument ordering and everything in these is exactly the same, why
don't you use copy_to_user()/copy_from_user() in your structure here
instead of these no-op wrappers?

> --- 0001/arch/sh/mm/fault_32.c
> +++ work/arch/sh/mm/fault_32.c	2008-02-06 22:57:22.000000000 +0900
> @@ -15,6 +15,7 @@
>  #include <linux/mm.h>
>  #include <linux/hardirq.h>
>  #include <linux/kprobes.h>
> +#include <asm/io_trapped.h>
>  #include <asm/system.h>
>  #include <asm/mmu_context.h>
>  #include <asm/tlbflush.h>
> @@ -163,6 +164,8 @@ no_context:
>  	if (fixup_exception(regs))
>  		return;
>  
> +	if (handle_trapped_io(regs, address))
> +		return;
>  /*
>   * Oops. The kernel tried to access some bad page. We'll have to
>   * terminate things with extreme prejudice.

This looks like a good candidate for page fault notifiers..

> --- 0001/include/asm-sh/io.h
> +++ work/include/asm-sh/io.h	2008-02-06 22:57:22.000000000 +0900
> @@ -38,6 +38,7 @@
>   */
>  #define __IO_PREFIX	generic
>  #include <asm/io_generic.h>
> +#include <asm/io_trapped.h>
>  
>  #define maybebadio(port) \
>    printk(KERN_ERR "bad PC-like io %s:%u for port 0x%lx at 0x%08x\n", \
> @@ -309,7 +310,15 @@ __ioremap_mode(unsigned long offset, uns
>  {
>  #ifdef CONFIG_SUPERH32
>  	unsigned long last_addr = offset + size - 1;
> +#endif
> +	void __iomem *ret = NULL;
> +
> +	if (!(flags & _PAGE_CACHABLE))
> +		ret = ioremap_trapped(offset, size, IORESOURCE_MEM);
> +	if (ret)
> +		return ret;
>  
> +#ifdef CONFIG_SUPERH32
>  	/*
>  	 * For P1 and P2 space this is trivial, as everything is already
>  	 * mapped. Uncached access for P1 addresses are done through P2.

This is also a bit of a mess. Why are you handing off IORESOURCE_MEM here
when y ou don't know whether it's an IORESOURCE_MEM or IORESOURCE_IO? The
pgprot validation here is also non-obvious, you may as well just
unconditionally call ioremap_trapped() (or __ioremap_trapped(), as it
shouuld be considered an internal API), and bail out early if it's happy.

> --- /dev/null
> +++ work/include/asm-sh/io_trapped.h	2008-02-06 23:34:23.000000000 +0900
> @@ -0,0 +1,59 @@
> +#ifndef __ASM_SH_IO_TRAPPED_H
> +#define __ASM_SH_IO_TRAPPED_H
> +
> +#include <linux/list.h>
> +#include <linux/ioport.h>
> +#include <asm/page.h>
> +
> +#define IO_TRAPPED_MAGIC 0xfeedbeef
> +
> +struct trapped_io {
> +	unsigned int magic;
> +	struct resource *resource;
> +	unsigned int num_resources;
> +	struct list_head list;
> +	void __iomem *virt_base;
> +	unsigned int (*read8)(void __iomem *addr);
> +	unsigned int (*read16)(void __iomem *addr);
> +	unsigned int (*read32)(void __iomem *addr);
> +	void (*write8)(unsigned int data, void __iomem *addr);
> +	void (*write16)(unsigned int data, void __iomem *addr);
> +	void (*write32)(unsigned int data, void __iomem *addr);
> +} __attribute__ ((aligned(PAGE_SIZE)));;
> +
Should probably add 64-bit versions here also. Double ;'s, and this
really wants a __page_aligned.

> +#ifdef CONFIG_IO_TRAPPED
> +void __init register_trapped_io_handler(struct trapped_io *tiop);
> +int handle_trapped_io(struct pt_regs *regs, unsigned long address);
> +#else
> +#define register_trapped_io_handler(tiop) while (0)

do { } while (0) might even work!

> +int handle_unaligned_access(u16 instruction, struct pt_regs *regs,
> +			    struct mem_access *ma);
> +
This too should use opcode_size_t. New code has to live with the fact
that we have mixed instruction sizes these days.
