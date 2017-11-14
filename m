From: jacopo mondi <jacopo@jmondi.org>
Date: Tue, 14 Nov 2017 16:59:14 +0000
Subject: Re: [PATCH] sh: migor: Reserve memory block for CEU
Message-Id: <20171114165914.GI19070@w540>
List-Id: <linux-sh.vger.kernel.org>
References: <1510164346-21134-1-git-send-email-jacopo+renesas@jmondi.org>
 <2038988.rgqq23lX41@avalon>
In-Reply-To: <2038988.rgqq23lX41@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Laurent, Geert,

On Thu, Nov 09, 2017 at 03:39:42AM +0200, Laurent Pinchart wrote:
> Hi Jacopo,
>
> Thank you for the patch.

I'm sending a v2 of this, with an additional patch to postpone page to
pfn mapping, as it hangs the CPU on SH4 with SPARSEMEM enabled.

Laurent: as you have suggested that patch, and I was under the
impression you wanted to submit a proper fix for that, please feel
free to reply to that pointing this out, if that's the case.

I need these two patch sent out because:
1) the sh_mobile_ceu driver on Migo-R mainline is broken without them
2) I'm basing my patches to move Migo-R to use the new CEU driver on
   top of them.

Thanks
  j

>
> On Wednesday, 8 November 2017 20:05:46 EET Jacopo Mondi wrote:
> > A memory region for CEU video buffer has to be reserved during machine
> > initialization.
> >
> > Originally, it was allocated through DMA API helpers and stored in the
> > second IORESOURCE_MEM entry, to be later remapped by the CEU driver with
> > a call to 'dma_declare_coherent_memory()'
> >
> > As Linux does not allow anymore to remap system RAM regions with
> > 'memremap' function, sh_mobile_ceu driver fails when trying to remap the
> > memory area:
> >
> > WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
> > 	  &offset, (unsigned long) size)
> >
> > from 'memremap()' function in kernel/memremap.c
> >
> > To avoid hitting that WARN_ONCE() and have memory successfully remapped,
> > reserve a region using '.mv_mem_reserve' member of SH's 'struct
> > sh_machine_vector' to make sure memory is reserved early enough, and
> > removed from the available system RAM.
>
> I'd phrase it the other way around. The important point here is that the
> reserved memory block must be removed from system memory in order to be
> remapable. This requires usage of the memblock API, and as this API is only
> usable very early during the boot process, we have to use the .mv_mem_reserve
> operation.
>
> > This is similar to what happens on ARM architecture with
> > 'arm_memblock_steal()' function.
> >
> > Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  arch/sh/boards/mach-migor/setup.c | 28 ++++++++++++++++++++++++++--
> >  1 file changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/sh/boards/mach-migor/setup.c
> > b/arch/sh/boards/mach-migor/setup.c index 0bcbe58..080627c 100644
> > --- a/arch/sh/boards/mach-migor/setup.c
> > +++ b/arch/sh/boards/mach-migor/setup.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/input.h>
> >  #include <linux/input/sh_keysc.h>
> > +#include <linux/memblock.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mtd/physmap.h>
> >  #include <linux/mfd/tmio.h>
> > @@ -45,6 +46,9 @@
> >   * 0x18000000       8GB    8   NAND Flash (K9K8G08U0A)
> >   */
> >
> > +#define CEU_BUFFER_MEMORY_SIZE		(4 << 20)
> > +static phys_addr_t ceu_dma_membase;
> > +
> >  static struct smc91x_platdata smc91x_info = {
> >  	.flags = SMC91X_USE_16BIT | SMC91X_NOWAIT,
> >  };
> > @@ -501,6 +505,8 @@ extern char migor_sdram_leave_end;
> >
> >  static int __init migor_devices_setup(void)
> >  {
> > +	struct resource *r = &migor_ceu_device.resource[2];
> > +
> >  	/* register board specific self-refresh code */
> >  	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
> >  					&migor_sdram_enter_start,
> > @@ -632,8 +638,6 @@ static int __init migor_devices_setup(void)
> >  #endif
> >  	__raw_writew(__raw_readw(PORT_MSELCRB) | 0x2000, PORT_MSELCRB); /* D15->D8
> > */
> >
> > -	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
> > -
> >  	/* SIU: Port B */
> >  	gpio_request(GPIO_FN_SIUBOLR, NULL);
> >  	gpio_request(GPIO_FN_SIUBOBT, NULL);
> > @@ -647,6 +651,12 @@ static int __init migor_devices_setup(void)
> >  	 */
> >  	__raw_writew(__raw_readw(PORT_MSELCRA) | 1, PORT_MSELCRA);
> >
> > +	/* Setup additional memory resources for Migo-R */
>
> I would initialize the r variable here instead of at declaration time to make
> the code more readable. Otherwise the reader will have to scroll back to find
> out what r points to.
>
> Other than that,
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > +	r->flags = IORESOURCE_MEM;
> > +	r->start = ceu_dma_membase;
> > +	r->end = r->start + CEU_BUFFER_MEMORY_SIZE - 1;
> > +	r->name = "ceu";
> > +
> >  	i2c_register_board_info(0, migor_i2c_devices,
> >  				ARRAY_SIZE(migor_i2c_devices));
> >
> > @@ -665,10 +675,24 @@ static int migor_mode_pins(void)
> >  	return MODE_PIN0 | MODE_PIN1 | MODE_PIN5;
> >  }
> >
> > +/* Reserve a portion of memory for CEU buffers */
> > +static void __init migor_mv_mem_reserve(void)
> > +{
> > +	phys_addr_t phys;
> > +	phys_addr_t size = CEU_BUFFER_MEMORY_SIZE;
> > +
> > +	phys = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_ALLOC_ANYWHERE);
> > +	memblock_free(phys, size);
> > +	memblock_remove(phys, size);
> > +
> > +	ceu_dma_membase = phys;
> > +}
> > +
> >  /*
> >   * The Machine Vector
> >   */
> >  static struct sh_machine_vector mv_migor __initmv = {
> >  	.mv_name		= "Migo-R",
> >  	.mv_mode_pins		= migor_mode_pins,
> > +	.mv_mem_reserve		= migor_mv_mem_reserve,
> >  };
>
> --
> Regards,
>
> Laurent Pinchart
>
