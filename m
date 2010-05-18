From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 May 2010 08:55:45 +0000
Subject: Re: [PATCH] sh: add romImage MMCIF boot for sh7724 and Ecovec
Message-Id: <20100518085545.GA2544@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100513142728.20439.17880.sendpatchset@t400s>
In-Reply-To: <20100513142728.20439.17880.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 13, 2010 at 11:27:28PM +0900, Magnus Damm wrote:
> --- 0001/arch/sh/boot/romimage/Makefile
> +++ work/arch/sh/boot/romimage/Makefile	2010-05-13 22:12:58.000000000 +0900
> @@ -6,8 +6,17 @@
>  
>  targets		:= vmlinux head.o zeropage.bin piggy.o
>  
> +IMAGE_ADDRESS	:= 0
>  OBJECTS = $(obj)/head.o
> -LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext 0 -e romstart \
> +
> +ifeq ($(CONFIG_ROMIMAGE_MMCIF),y)
> +ifeq ($(CONFIG_CPU_SUBTYPE_SH7724),y)
> +IMAGE_ADDRESS	:= 0xe5200000 # ILRAM
> +OBJECTS += $(obj)/mmcif-sh7724.o
> +endif
> +endif
> +
> +LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_ADDRESS) -e romstart \
>  		   -T $(obj)/../../kernel/vmlinux.lds
>  
This is looking pretty dire. Perhaps it's time to start looking at having
per-CPU and per-machine type boot files for exporting these things. A
combination of what MIPS and ARM are doing would fit this pretty well.

> +#ifdef CONFIG_ROMIMAGE_MMCIF
> +	mov.l	load_mem_base, r4
> +	mov.l	bytes_to_load, r5
> +	mov.l	loader_function, r7
> +	jsr	@r7
> +	 mov	r4, r15
> +
> +	mov.l	load_mem_base, r4
> +	mov.l	loaded_code_offs, r5
> +	add	r4, r5
> +	jmp	@r5
> +	 nop
> +
> +        .balign 4
> +load_mem_base:
> +	.long	P1SEG | CONFIG_MEMORY_START | (1 << 20) /* 1 MiB offset */

Not only is this totally bogus for 32-bit, it's also of questionable
veracity for 29-bit. This is basically a questionable way of saying you
want PAGE_OFFSET + MEMORY_START, which we already have via KERNEL_LOAD.

KERNEL_LOAD does factor in the zero page offset, which you can either
mask off or account for depending on what level of flexibility you are
aiming for. Note that the zero page offset is Kconfig selectable, so if
anyone were to put the zero page at a 1MiB offset you would be in trouble
here (and yes, boards have done this in the past, although the current
worst offender is only 64kB in).

> +#include <linux/io.h>
> +#include "../../../../drivers/sh/mmcif_loader.c"
> +
Uhm.. no. Just because sh-sci did it doesn't make it a good idea. In
fact, if sh-sci does it, it's probably a stupid idea.

> +/* Ecovec board specific information:
> + *
> + * Set the following to enable MMCIF boot from the MMC card in CN12:
> + *
> + * DS1.5 = OFF (SH BOOT pin set to L)
> + * DS2.6 = OFF (Select MMCIF on CN12 instead of SDHI1)
> + * DS2.7 = ON  (Select MMCIF on CN12 instead of SDHI1)
> + *
> + */
> +#ifdef CONFIG_SH_ECOVEC
> +static void set_led(int nr)
> +{
> +	/* disable Hi-Z for LED pins */
> +	__raw_writew(__raw_readw(HIZCRA) & ~(1 << 1), HIZCRA);
> +
> +	/* update progress on LED4, LED5, LED6 and LED7 */
> +	__raw_writeb(1 << (nr - 1), PGDR);
> +}
> +#else
> +#define set_led(nr) do { } while (0)
> +#endif
> +
This too, just no. You already have a romimage.h for the boards, just use
that with an __ASSEMBLY__ case.

> +/* SH7724 specific MMCIF loader
> + *
> + * loads the romImage from an MMC card starting from block 512
> + * use the following line to write the romImage to an MMC card
> + * # dd if=arch/sh/boot/romImage of=/dev/sdx bsQ2 seekQ2
> + */
> +void mmcif_loader(unsigned char *buf, unsigned long no_bytes)
> +{
asmlinkage?

> +	/* update progress */
> +	set_led(1);
> +
[snip]

> +	/* update progress */
> +	set_led(2);
> +
[snip]

> +	/* update progress */
> +	set_led(3);

I'm amazed that given your perverse obsession with enums that you've
failed to employ them in something that would actually benefit from them
in a legitimate fashion. These comments are also about as meaningful as
the hardcoded values.

> --- /dev/null
> +++ work/drivers/sh/mmcif_loader.c	2010-05-13 22:55:23.000000000 +0900

This is definitely getting out of hand, drivers/sh/ is not a dumping
ground for anything and everything. I could live with this under
linux/sh_mmcif.h or so, though some of these cases are probably a bit
large for inlining.

We may at some point simply have to live with building a library for
things on the SH side and linking them in on the ARM side. Or if that
fails, then revisit the idea of a common architecture directory.

> +#define BLOCK_SIZE 512
> +
This really wants a better name. If any of linux/io.h asm/ references
bring in linux/fs.h you're going to be screwed.
