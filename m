From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jan 2011 20:06:06 +0000
Subject: Re: sh: sh7751 pci controller io port fix
Message-Id: <20110118200606.GA5539@volta.aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Thu, Apr 22, 2010 at 06:21:10AM -0000, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch updates the sh7751 pci code to handle io ports
> correctly. The code is based on the sh7788x implementation.
> 
> Tested on a R2D-1 board with CONFIG_8139TOO_PIO=y.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> 
> ---
> arch/sh/drivers/pci/pci-sh7751.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Sorry to contact you so long after this patch has been submitted, but it
appears to break PCI I/O support in QEMU emulating an R2D board. My
guess is that one address translation layer is not fully emulated (some
PCI registers are ignored), so I would like to ask a question.

> --- 0001/arch/sh/drivers/pci/pci-sh7751.c
> +++ work/arch/sh/drivers/pci/pci-sh7751.c	2010-04-22 13:15:00.000000000 +0900
> @@ -17,6 +17,7 @@
>  #include <linux/io.h>
>  #include "pci-sh4.h"
>  #include <asm/addrspace.h>
> +#include <asm/sizes.h>
>  
>  static int __init __area_sdram_check(struct pci_channel *chan,
>  				     unsigned int area)
> @@ -47,8 +48,8 @@ static int __init __area_sdram_check(str
>  static struct resource sh7751_pci_resources[] = {
>  	{
>  		.name	= "SH7751_IO",
> -		.start	= SH7751_PCI_IO_BASE,
> -		.end	= SH7751_PCI_IO_BASE + SH7751_PCI_IO_SIZE - 1,
> +		.start	= 0x1000,
> +		.end	= SZ_4M - 1,
>  		.flags	= IORESOURCE_IO
>  	}, {
>  		.name	= "SH7751_mem",

The address in start is used later in the code to write the PCI I/O base
register:

|        /* Make sure the MSB's of IO window are set to access PCI space
|         * correctly */
|        word = chan->resources[0].start & SH4_PCIIOBR_MASK;
|        pr_debug("PCI: Setting upper bits of IO window to 0x%x\n", word);
|        pci_write_reg(chan, word, SH4_PCIIOBR);

With this change, 0 is written to this register (SH4_PCIIOBR_MASK is 
0xFFFC0000), so QEMU maps the I/O port range starting at address 
0x00000000. However the kernel still use the SH7751_PCI_IO_BASE value to
define .io_map_base. As a results access to the PCI I/O space end up in 
the 0xFE240000 range.

It seems that the PCI IO space range is not only computed from the PCI
I/O base register, but also from some other registers. However, I fail
to find how in the datasheet. Would it be possible to tell me how it is
computed?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
