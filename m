From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Wed, 27 Aug 2008 11:12:29 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080827111229.GA9045@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Luca,

On Wed, Aug 27, 2008 at 12:34:48PM +0200, Luca Santini wrote:
> currently you have (defconfig) :
>
>  - ramdisk support
>  - ethernet support
>  - nfs support
>  - ext2/ext3 support
>  - i2c support
>  - fb support (M)
>
> and haven't:
>
>  - usb support
>  - mmc support

I have drivers for both, although the USB part is definitely NOT mainline
material at all (it's basically a duplication of the OHCI stack with a few
adjustments and a memory manager for the 7760 ohci ram.)


>  - flash support?

look e.g. at the ap325rxa boards' use of the physmap-flash driver.


> diff -uNr -x '*.mod.c' -x '*.o' -x '*.cmd' -x '*.d' -x 'built-in.*' -x '*.S' -x '*.s' -x 'vmlinux*' -x zImage -x '*syscall*' a/arch/sh/boards/renesas/edosk7760/Makefile b/arch/sh/boards/renesas/edosk7760/Makefile
> --- a/arch/sh/boards/renesas/edosk7760/Makefile	1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/sh/boards/renesas/edosk7760/Makefile	2008-08-27 11:45:29.000000000 +0200
> @@ -0,0 +1,9 @@
> +#
> +# Makefile for HMSE EDOSK7760 board specific parts of the kernel
> +#
> +# Note! Dependencies are done automagically by 'make dep', which also
> +# removes any old dependencies. DON'T put your own dependencies here
> +# unless it's something special (ie not a .c file).
> +#
> +
> +obj-y := setup.o 

as long as the code consists of a single setup.c file, just rename it to


> diff -uNr -x '*.mod.c' -x '*.o' -x '*.cmd' -x '*.d' -x 'built-in.*' -x '*.S' -x '*.s' -x 'vmlinux*' -x zImage -x '*syscall*' a/arch/sh/boards/renesas/edosk7760/setup.c b/arch/sh/boards/renesas/edosk7760/setup.c
> --- a/arch/sh/boards/renesas/edosk7760/setup.c	1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/sh/boards/renesas/edosk7760/setup.c	2008-08-27 12:01:58.000000000 +0200
> @@ -0,0 +1,177 @@
> +/* 
> + * linux/arch/sh/edosk7760/setup.c
> + *
> + * Copyright (C) 2000  Kazumoto Kojima
> + *
> + *
> + * Modified for EDOSK7760 by
> + * Richard Bister
> + * 
> + * Port to 2.6.26 by
> + * Luca Santini www.spesonline.com
> + */
> +
> +/* Bus state controller registers for CS4 area */
> +#define BSC_CS4BCR    0xA4FD0010
> +#define BSC_CS4WCR    0xA4FD0030 
> +
> +#define SMC_IOBASE  0xA2000000
> +#define SMC_IO_OFFSET 0x300
> +#define SMC_IOADDR	SMC_IOBASE + SMC_IO_OFFSET
> +#define ETHERNET_IRQ 0x9
> +
> +#include <linux/init.h>
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +#include <asm/machvec.h>
> +#include <asm/io.h>
> +#include <asm/addrspace.h>
> +#include <asm/delay.h>
> +#include <linux/smc91x.h>
> +#include <linux/i2c.h>
> +#include <asm/i2c-sh7760.h>

Please reorder the includes:  lines with linux/ come first, followed by
asm/.


> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

should not be necessary.  If the driver is not selected, the resources won't
do any harm (consume a few bytes of ram maybe).


> +/* i2c initialization functions */
> +
> +static struct sh7760_i2c_platdata i2c_pd = {
> +        .speed_khz      = 400,
> +};
> +
> +static struct resource sh7760_i2c1_res[] = {
> +        {
> +                .start  = SH7760_I2C1_MMIO,
> +                .end    = SH7760_I2C1_MMIOEND,
> +                .flags  = IORESOURCE_MEM,
> +        },{
> +                .start  = SH7760_I2C1_IRQ,
> +                .end    = SH7760_I2C1_IRQ,
> +                .flags  = IORESOURCE_IRQ,
> +        },
> +};
> +
> +static struct platform_device sh7760_i2c1_dev = {
> +        .dev    = {
> +                .platform_data  = &i2c_pd,
> +        },
> +        .name           = SH7760_I2C_DEVNAME,
> +        .id             = 1,
> +        .resource       = sh7760_i2c1_res,
> +        .num_resources  = ARRAY_SIZE(sh7760_i2c1_res),
> +};
> +
> +
> +static struct resource sh7760_i2c0_res[] = {
> +        {
> +                .start  = SH7760_I2C0_MMIO,
> +                .end    = SH7760_I2C0_MMIOEND,
> +                .flags  = IORESOURCE_MEM,
> +        },{
> +                .start  = SH7760_I2C0_IRQ,
> +                .end    = SH7760_I2C0_IRQ,
> +                .flags  = IORESOURCE_IRQ,
> +        },
> +};
> +
> +static struct platform_device sh7760_i2c0_dev = {
> +        .dev    = {
> +                .platform_data  = &i2c_pd,
> +        },
> +        .name           = SH7760_I2C_DEVNAME,
> +        .id             = 0,
> +        .resource       = sh7760_i2c0_res,
> +        .num_resources  = ARRAY_SIZE(sh7760_i2c0_res),
> +};
> +#endif
> +
> +static void __init sh_edosk7760_init_irq(void)
> +{
> +
> +}

Empty function -- get rid of it.


> +/* eth initialization functions */
> +
> +static struct smc91x_platdata smc91x_info = {
> +	.flags = SMC91X_USE_16BIT,
> +};
> +
> +static struct resource smc91x_res[] = {
> +        [0] = {
> +		.start  = SMC_IOADDR,
> +		.end    = SMC_IOADDR + 0x1f,
> +		.flags  = IORESOURCE_MEM,
> +        },
> +        [1] = {
> +		.start  = ETHERNET_IRQ,
> +		.end    = ETHERNET_IRQ,
> +		.flags  = IORESOURCE_IRQ,
> +        }
> +};
> +
> +static struct platform_device smc91x_dev = {
> +
> +        .name           = "smc91x",
> +        .id             = -1,
> +        .num_resources  = ARRAY_SIZE(smc91x_res),
> +        .resource       = smc91x_res,
> +		.dev	= {
> +			.platform_data	= &smc91x_info,
> +		},
> +
> +};
> +
> +/* platform init code */
> +
> +static struct platform_device *edosk7760_devices[] __initdata = {
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)

These checks are unnecessary, remove them.


> +	&sh7760_i2c0_dev,
> +	&sh7760_i2c1_dev, 
> +#endif	
> +
> +#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
> +	&smc91x_dev,
> +#endif
> +	
> +};
> +
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +/*these are custom-board specific: here you can add your I2C_BOARD_INFO devices*/
> +static struct i2c_board_info __initdata edosk7760_i2c_devices0[] = {
> +};
> +
> +static struct i2c_board_info __initdata edosk7760_i2c_devices1[] = {
> +};
> +#endif

As long as they're empty, remove them. You can add them back later when you
have the WM8731 working ;)  (incidentally, Jean Delvare posted a patch to
alsa-devel with converts the wm8731 codec to new-style i2c probing on
080826).


> +static int __init init_edosk7760_devices(void){
> +	int ret = -1;
> +
> +	/* This is the Ethernet interrupt */
> +	make_imask_irq(ETHERNET_IRQ);
> +
> +	/* This is the IntelStrata Flash interrupt */
> +	make_imask_irq(0x0A);
> +
> +#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
> +	/* i2c setup */
> +	i2c_register_board_info(0, edosk7760_i2c_devices0,
> +				ARRAY_SIZE(edosk7760_i2c_devices0));
> +	i2c_register_board_info(1, edosk7760_i2c_devices1,
> +				ARRAY_SIZE(edosk7760_i2c_devices1));
> +#endif
> +				
> +	ret = platform_add_devices(edosk7760_devices, ARRAY_SIZE(edosk7760_devices));
> +	return ret;
> +}
> +__initcall(init_edosk7760_devices);
> + 
> +/*
> + * The Machine Vector
> + */
> +
> +/// have a look to include/asm-sh/machvec.h 
> +struct sh_machine_vector mv_edosk7760 __initmv = {
> +	mv_name:		"EDOSK7760",
> +	mv_nr_irqs:		128,
> +	mv_init_irq:	sh_edosk7760_init_irq,
> +};

Please use the new initializer syntax:
	.mv_name	= "EDOSK7760",
	.mv_nr_irqs	= 128,
	.mv_init_irq	= edosk7760_init_irq,

Also, please rediff against a more current linux source tree.
Since 2.6.27-rc2 or so, the board file organization has changed slightly; as
long as you only have the setup.c file, I suggest you rename it to
mach-edosk7760.c and wire it up in arch/sh/boards/Makefile.

Best regards,
	Manuel Lauss
