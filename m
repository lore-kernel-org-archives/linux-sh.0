From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 28 Jul 2008 16:39:09 +0000
Subject: Re: kernel (sometimes) boot
Message-Id: <20080728163909.GA30602@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <488D864C.30808@spesonline.com>
In-Reply-To: <488D864C.30808@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 28, 2008 at 04:38:26PM +0200, Luca Santini wrote:

>>> . loading smc91c96 driver fails at probe()
>> Check MMIO area (chip is at 0x02000000 - 0x0200001f according to the
>> ESDOK7760 manual available from renesas website if you didn't change any 
>> of
>> the DIP switches on the board), and correct IRQ (9 if I interpret the
>> schematics correctly)
>
>
> I modified things according to Paul Mundt's suggestions but i have always 
> the same result... i think i make some mistake in addressing the chip; 
> edosk7760 manual says:
>
> "
>
> The LAN IC (Standard Microsystems Corporation (SMSC) - LAN91C96QFP) 
> operates in 16-bit mode by pulling pin
> ?nEN16? ground via a resistor. Removal of the resistor enables the option 
> of the LAN device operating with an 8-bit
> data bus.
>
> ...
>
> In this way the LAN IC, which has a default base address of H?00300, will 
> be accessed when the micon addresses
> H?0200 0000 to H?0200 003F.

Just use 0x02000000. No offsets.


>>> . alsa answer is "no soundcards found"
>> That's expected;  you need to write ASoC "machine" code (that is, code
>> which knows which codec and audio unit to use).  Use the "sh7760-ac97.c"
>> file as a template; replace the "ac97_dai" with something appropriate for
>> the wm8731, and don't forget to change IPSELR to enable the I2S pins.
>
> i'm trying....

I can send you working I2S machine code if you like.


>>> . every kernel option i enable often results in an unbootable kernel: 
>>> /dev/i2c support; sh7760_AC97; alsa debug, scsi support (needed by usb 
>>> mass storage): every of these i try to enable results in a kernel with  
>>> no console output.
>> Do you get any output with early_printk and sh_bios enabled?
>
> No, enabling these options results in unbootable kernel (mute - neither the 
> SpesPrint output is showed -- see the patch) .


> >> Do you have some suggestions? my kernel seems very very delicate.....
> >> i attach my .config and my edosk7760/setup.c
> >
> > Could you please post a complete patch of your edosk7760 against
> > vanilla-2.6.26?
>
>
> This is a dirty patch for edosk7760 with something wrong in smc91x support 
> (wrong addresses?)

yup. see above and below.


> > What toolchain are you using?
> >
>
> sh4-linux-gcc (GCC) 3.4.5 20060103 (3.4.5-10.1a) from MPC site

Should be fine.



> +obj-y := setup.o
> diff -uNr linux-2.6.26-vanilla/arch/sh/boards/renesas/edosk7760/setup.c linux-2.6.26-spes/arch/sh/boards/renesas/edosk7760/setup.c
> --- linux-2.6.26-vanilla/arch/sh/boards/renesas/edosk7760/setup.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.26-spes/arch/sh/boards/renesas/edosk7760/setup.c	2008-07-28 15:39:02.000000000 +0200
[...]
> +
> +static struct smc91x_platdata smc91x_info = {
> +	.flags = SMC91X_USE_16BIT,
> +};
> +
> +static struct resource smc91x_res[] = {
> +        [0] = {
> +		.start  = SMC_IOADDR,
> +		.end    = SMC_IOADDR + 0x1f, //0xff,
					 ^^ 2f

> +		.flags  = IORESOURCE_MEM,
> +        },
> +        [1] = {
> +		.start  = IRQ_ETHERNET,
> +		.end    = IRQ_ETHERNET,
> +		.flags  = IORESOURCE_IRQ,
> +        }
> +};

> diff -uNr linux-2.6.26-vanilla/include/asm-sh/edosk7760.h linux-2.6.26-spes/include/asm-sh/edosk7760.h
> --- linux-2.6.26-vanilla/include/asm-sh/edosk7760.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.26-spes/include/asm-sh/edosk7760.h	2008-07-28 15:38:18.000000000 +0200
> @@ -0,0 +1,16 @@
> +#ifndef ASM_SH_EDOSK7760
> +#define  ASM_SH_EDOSK7760
> +
> +#include <asm/addrspace.h>
> +
> +/* Bus state controller registers for CS4 area */
> +#define BSC_CS4BCR    0xA4FD0010
> +#define BSC_CS4WCR    0xA4FD0030 
> +
> +#define SMC_IOBASE  0xA2000000
> +
> +#define SMC_IO_OFFSET 0x300
> +#define SMC_IOADDR	SMC_IOBASE +	SMC_IO_OFFSET

remove SMC_IO_OFFSET and networking should work.

Best regards,
	Manuel Lauss
