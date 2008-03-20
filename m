From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Thu, 20 Mar 2008 13:58:30 +0000
Subject: Re: [PATCH] sh: Add support for Solution Engine SH7721 board
Message-Id: <aec7e5c30803200658j6a552e34g650acdf413faa8a3@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <47E12059.4020302@renesas.com>
In-Reply-To: <47E12059.4020302@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 19, 2008 at 11:16 PM, Yoshihiro Shimoda
<shimoda.yoshihiro@renesas.com> wrote:
> Add support for Solution Engine SH7721 board(MS7721RP01).
>
>  Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

[snip]

>  diff -uprN a/arch/sh/boards/se/7721/irq.c b/arch/sh/boards/se/7721/irq.c
>  --- a/arch/sh/boards/se/7721/irq.c      1970-01-01 09:00:00.000000000 +0900
>  +++ b/arch/sh/boards/se/7721/irq.c      2008-03-19 23:12:00.000000000 +0900
>  @@ -0,0 +1,86 @@
>  +/*
>  + * linux/arch/sh/boards/se/7721/irq.c
>  + *
>  + * Copyright (C) 2000  Kazumoto Kojima
>  + * Copyright (C) 2006  Nobuhiro Iwamatsu
>  + * Copyright (C) 2008  Renesas Solutions Corp.
>  + *
>  + * Hitachi SolutionEngine Support.
>  + *
>  + */
>  +
>  +#include <linux/init.h>
>  +#include <linux/interrupt.h>
>  +#include <linux/irq.h>
>  +#include <asm/irq.h>
>  +#include <asm/io.h>
>  +#include <asm/se.h>
>  +
>  +static struct ipr_data ipr_irq_table[] = {
>  +       /*
>  +       * Super I/O (Just mimic PC):
>  +       *  1: keyboard
>  +       *  3: serial 0
>  +       *  4: serial 1
>  +       *  5: printer
>  +       *  6: floppy
>  +       *  8: rtc
>  +       * 12: mouse
>  +       * 14: ide0
>  +       */
>  +       { 14, 0,  8, 0x0f - 14, },
>  +       { 12, 0,  4, 0x0f - 12, },
>  +       {  8, 1,  4, 0x0f -  8, },
>  +       {  6, 2, 12, 0x0f -  6, },
>  +       {  5, 2,  8, 0x0f -  5, },
>  +       {  4, 2,  4, 0x0f -  4, },
>  +       {  3, 2,  0, 0x0f -  3, },
>  +       {  1, 3, 12, 0x0f -  1, },
>  +       /* MRSHPC IRQs setting */
>  +       {  0, 4, 12, 0x0f -  0, },      /* PCIRQ3 */
>  +       { 11, 4,  8, 0x0f - 11, },      /* PCIRQ2 */
>  +       {  9, 4,  4, 0x0f -  9, },      /* PCIRQ1 */
>  +       {  7, 4,  0, 0x0f -  7, },      /* PCIRQ0 */
>  +       /* #2, #13 are allocated for SLOT IRQ #1 and #2 (for now) */
>  +       /* NOTE: #2 and #13 are not used on PC */
>  +       { 13, 6,  4, 0x0f - 13, },      /* SLOTIRQ2 */
>  +       {  2, 6,  0, 0x0f -  2, },      /* SLOTIRQ1 */
>  +};
>  +
>  +static unsigned long ipr_offsets[] = {
>  +       BCR_ILCRA,
>  +       BCR_ILCRB,
>  +       BCR_ILCRC,
>  +       BCR_ILCRD,
>  +       BCR_ILCRE,
>  +       BCR_ILCRF,
>  +       BCR_ILCRG,
>  +};
>  +
>  +static struct ipr_desc ipr_irq_desc = {
>  +       .ipr_offsets    = ipr_offsets,
>  +       .nr_offsets     = ARRAY_SIZE(ipr_offsets),
>  +
>  +       .ipr_data       = ipr_irq_table,
>  +       .nr_irqs        = ARRAY_SIZE(ipr_irq_table),
>  +       .chip = {
>  +               .name   = "IPR-se7721",
>  +       },
>  +};
>  +
>  +/*
>  + * Initialize IRQ setting
>  + */
>  +void __init init_se7721_IRQ(void)
>  +{
>  +       /* Disable all interrupts */
>  +       ctrl_outw(0, BCR_ILCRA);
>  +       ctrl_outw(0, BCR_ILCRB);
>  +       ctrl_outw(0, BCR_ILCRC);
>  +       ctrl_outw(0, BCR_ILCRD);
>  +       ctrl_outw(0, BCR_ILCRE);
>  +       ctrl_outw(0, BCR_ILCRF);
>  +       ctrl_outw(0, BCR_ILCRG);
>  +
>  +       register_ipr_controller(&ipr_irq_desc);
>  +}

This looks like duplicated untested code.

How many of the IRQs above are actually used by device drivers? I
can't see any platform devices that use these IRQ numbers. The IRQ
code above is unfortunately using the legacy ipr controller. New code
should use intc, have a look at the code in
arch/sh/boards/renesas/rts7751r2d/irq.c.

Please consider converting the code to intc and/or removing
unused/untested interrupts.

Thanks!

/ magnus
