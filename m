From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Jun 2015 07:47:00 +0000
Subject: Re: [PATCH 1/2] New files for 0PF FPGA board.
Message-Id: <CAMuHMdWR-pc3rghZcyv_CNgizwddX1fqtvkDwJbtGbBnpOqnaA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434647946.861556@landley.net>
	<1434647946.861804@landley.net>
In-Reply-To: <1434647946.861804@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

Hi Rob,

On Thu, Jun 18, 2015 at 7:19 PM, Rob Landley <rob@landley.net> wrote:
> New files for Open Processor Foundation j2 (superh sh2 compatible open
> hardware) FPGA board, with enough drivers to boot initramfs to a shell
> prompt on serial console. See http://0pf.org for details.

Thanks for your patch!

>
> --- /dev/null   2015-06-06 04:15:40.702718005 -0500
> +++ linux/arch/sh/boards/board-0pf.c    2015-06-17 21:20:05.825356382 -0500
> @@ -0,0 +1,270 @@

> +static inline void shj_enable_irq(struct irq_data *data)
> +{
> +       unsigned int irq = data->irq;
> +       volatile unsigned int vui;
> +
> +//     printk("%s: IRQ %d (0x%x)\n", __func__, irq, irq);

Please no C++ style comments, nor commented-out code.

> +       switch (irq) {
> +       case PIT_IRQ:
> +               //AQ_PIO = 0x0BB;
> +               /* enable, lvl 2, vector 64 */
> +               AQ_SYS = (1 << 26) |    /* enable PIT */
> +                   (0x02 << 20) |      /* interrupt level 2 */
> +                   (PIT_IRQ << 12) |   /* vector 64 */

Magic numbers need #defines.

> +                   1;          /* turn off interval timer */
> +               break;
> +
> +       case Irq_UART0:
> +               vui = *(volatile unsigned int *)(sys_SYS_BASE + Sys_IntPri);

volatile considered harmful, writel()? (more below)

> +static void __init shj_irq_init(void)
> +{
> +       int c;

unsigned int

> +
> +       printk(KERN_INFO "0PF FPGA interrupt controller...\n");

pr_info()

> +
> +       for (c = 0; c < NR_IRQS; c++) {
> +               //irq_desc[c].action = NULL;
> +               //irq_desc[c].depth = 1;
> +               irq_set_chip_and_handler_name(c, &shj_irq_chip,
> +                                             handle_simple_irq, "simple");
> +       }
> +}
> +
> +#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
> +// Commit 7b1f62076 switched this to a pointer

Please don't refer to git commits in comments.

> +static struct sh_machine_vector mv_se __initmv = {
> +       .mv_name = "0PF_FPGA",
> +       //.mv_nr_irqs = 256,

No commented-out code/data

> +static void __init start_pit(void)
> +{
> +       if (request_irq
> +           (PIT_IRQ, timer_interrupt, IRQF_TIMER, "pit", NULL))
> +               printk("irq_desc[%p] : fail to register\n", &irq_desc[PIT_IRQ]);

pr_err()

> --- /dev/null   2015-06-06 04:15:40.702718005 -0500
> +++ linux/arch/sh/include/asm/board-0pf.h       2015-06-17 21:20:05.825356382 -0500
> @@ -0,0 +1,247 @@
> +#ifndef SGM_BOARD_H
> +#define SGM_BOARD_H

Strange include guard name, not matching file name.

> +#define sys_IntTable (*(unsigned*)0x0)

NULL? Besides, it seems unused?

> +#define SIC_ENMI       ((unsigned int) 0x1<<31)        /* Emulate NMI */

"BIT(31)" (more below)

> +#if 0

No #ifdef'ed-out definitions please

> --- /dev/null   2015-06-06 04:15:40.702718005 -0500
> +++ linux/arch/sh/kernel/cpu/sh2/clock-0pf.c    2015-06-17 21:20:05.825356382 -0500
> @@ -0,0 +1,80 @@

> +int __init arch_clk_init()
> +{
> +       int ret;
> +
> +       printk("%s(): 0PF Clock init...\n", __func__);

pr_debug()?

> --- /dev/null   2015-06-06 04:15:40.702718005 -0500
> +++ linux/arch/sh/kernel/cpu/sh2/setup-0pf.c    2015-06-17 21:20:05.825356382 -0500
> @@ -0,0 +1,82 @@

> +#if defined(CONFIG_SERIAL_UARTLITE_0PF)
> +static struct resource shj_uartlite_resources[] = {
> +       [0] = DEFINE_RES_MEM(0xABCD0100, 16),
> +       [1] = DEFINE_RES_IRQ(0x12),
> +
> +       [2] = DEFINE_RES_MEM(0xABCD0300, 16),
> +       [3] = DEFINE_RES_IRQ(0x17),
> +
> +       [4] = DEFINE_RES_MEM(0xABCD0400, 16),
> +       [5] = DEFINE_RES_IRQ(0x13),
> +};
> +
> +static struct platform_device shj_uartlite_device[] = {
> +       [0] = { .name = "uartlite", .id = 0 },
> +       [1] = { .name = "uartlite", .id = 1 },
> +       [2] = { .name = "uartlite", .id = 2 },
> +};

Typically we have only the driver depend on CONFIG_XXX, not the
platform code that creates the platform device.

> +#endif
> +
> +/*****************************************************************************
> + *  0PF FPGA platform devices
> + ****************************************************************************/
> +static struct platform_device *shj_devices[] __initdata = {
> +#if defined(CONFIG_SERIAL_UARTLITE_0PF)

Idem ditto

> +       shj_uartlite_device,
> +       shj_uartlite_device + 1,
> +       shj_uartlite_device + 2,
> +#endif
> +};
> +
> +static int __init shj_devices_setup(void)
> +{
> +       int i;
> +       pr_info("%s(): registering device resources\n", __func__);
> +
> +#if defined(CONFIG_SERIAL_UARTLITE_0PF)

idem ditto

> +       for (i = 0; i < ARRAY_SIZE(shj_uartlite_device); i++) {
> +               printk("Register UARTLITE resources %d\n", i);
> +               if (platform_device_add_resources(
> +                               shj_uartlite_device + i,
> +                               shj_uartlite_resources + 2 * i,
> +                               2))
> +                       pr_err("Failed to set uartlite %d IRQ and MEM\n", i);
> +
> +       }
> +#endif
> +       platform_add_devices(shj_devices, ARRAY_SIZE(shj_devices));
> +
> +       return 0;
> +}

> --- /dev/null   2015-06-06 04:15:40.702718005 -0500
> +++ linux/arch/sh/configs/0pf_defconfig 2015-06-17 21:47:46.869366542 -0500
> @@ -0,0 +1,945 @@

I may be mistaken, but this doesn't look like a minimal defconfig as
created by "make savedefconfig".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
