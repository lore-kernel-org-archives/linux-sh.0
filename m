From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 18 Jan 2008 06:28:00 +0000
Subject: Re: [PATCH] Add support for SDK7780 board
Message-Id: <20080118062800.GA25472@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <478F7921.4090203@mpc-data.co.uk>
In-Reply-To: <478F7921.4090203@mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 17, 2008 at 06:22:27PM +0000, Nicholas Beck wrote:
> Manuel Lauss wrote:
> >
> >However the patch is wordwrapped, does not apply to latest -git,
> >and contains backup files (*~).
> >
> Whoops, whoops & whoops! Give this one a try.
> 
> Add support for Renesas Technology Europe SDK7780 board.
> 
> Signed-off-by: Nicholas Beck <nbeck@mpc-data.co.uk>
> ---
> diff -urN -x '.git*' a/arch/sh/boards/renesas/sdk7780/irq.c 

If you want to avoid these sorts of common problems in the future, one
thing you may want to do is have git generate the diff directly, or
barring that, use the kernel's dontdiff.

ie, diff -X path-to-kernel/Documentation/dontdiff ...

Please also use -purN, it does help provide context when you're just
looking at the patch itself without looking at the source file.

> b/arch/sh/boards/renesas/sdk7780/irq.c
> --- a/arch/sh/boards/renesas/sdk7780/irq.c    1970-01-01 
> 01:00:00.000000000 +0100
> +++ b/arch/sh/boards/renesas/sdk7780/irq.c    2008-01-17 
> 17:36:20.000000000 +0000
> @@ -0,0 +1,102 @@
> +/*
> + * linux/arch/sh/boards/renesas/sdk7780/irq.c
> + *
> + * Renesas Technology Europe SDK7780 Support.
> + *
> + * Copyright (C) 2008  Nicholas Beck <nbeck@mpc-data.co.uk>
> + *
> + * Based on linux/arch/sh/boards/renesas/r7780rp/irq.c
> + *         Copyright (C) 2002  Atom Create Engineering Co., Ltd.
> + *         Copyright (C) 2006  Paul Mundt
> + *
> + */

There's no need to carry around these additional copyright notices or
what the file is based on, since they have almost nothing in common.
People seem to do this with board support code a lot, though there's no
reason or requirement for doing so. These are obviously original works.

An explicit license definition would also be nice. GPLv2 only without the
"or any later version" damage is the preferred choice.

> +static void disable_sdk7780_irq(unsigned int irq)
> +{
> +    ctrl_outw(ctrl_inw(FPGA_IRQ0MR) | (1 << mask_pos[irq]), FPGA_IRQ0MR);
> +    if (irq = 14) {
> +        /* clear ATA interrupt in FPGA */
> +        ctrl_outw((ctrl_inw(FPGA_IRQ0SR) & 0xFFBF), FPGA_IRQ0SR);
> +    }
> +}
> +
This was already covered in my reply to Magnus.

> +int pci_fixup_pcic(void)
> +{
> +    ctrl_outl(0x00000001, SH7780_PCI_VCR2);
> +
> +    /* Enable all interrupts, so we know what to fix */
> +    pci_write_reg(0x0000C3FF, SH7780_PCIIMR);
> +    pci_write_reg(0x0000380F, SH7780_PCIAINTM);
> +
> +    /* Set up standard PCI config registers */
> +    ctrl_outw(0xFB00, PCI_REG(SH7780_PCISTATUS));
> +    ctrl_outw(0x0047, PCI_REG(SH7780_PCICMD));
> +    ctrl_outb(0x00, PCI_REG(SH7780_PCIPIF));
> +    ctrl_outb(0x00, PCI_REG(SH7780_PCISUB));
> +    ctrl_outb(0x06, PCI_REG(SH7780_PCIBCC));
> +    ctrl_outw(0x1912, PCI_REG(SH7780_PCISVID));
> +    ctrl_outw(0x0001, PCI_REG(SH7780_PCISID));
> +
pci_write_reg() ?

It's basically just the IRQ bits and this above chunk that look
questionable, the rest looks ok. There's still quite a bit of whitespace
damage and word-wrapping going on here. Please run your patch through
scripts/checkpatch.pl before submitting it to make sure that these issues
are resolved. You may also want to send yourself a few test mails with
the cleaned up patch until your mailer configuration is sorted out :-)
