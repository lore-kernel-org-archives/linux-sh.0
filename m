From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 29 Feb 2008 15:32:47 +0000
Subject: Re: Questions about the interrupt controller
Message-Id: <47C8259F.9030209@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
In-Reply-To: <38b2ab8a0802290508t5e20a0cmfd04e35f0fc533a3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Francis Moreau wrote:
> Hello,
> 
> I read the sh4 core peripherals manual avalaible on renesas web site
> (BTW do you know other 'good' documentations on the sh4 architecture ?)
> in order to understand how the 'intc' works.
> 
> My question is: are there any examples in the linux kernel which use the
> IRL interrupts when *not* configured as 4 independent interrupt requests ?

The platform I'm working on does that.  A CPLD with 15 IRQ sources uses 
the 4 IRL lines to signal them (low-active 4-bit "bus" if you will).

> Do such interrupts need to use make_imask_irq() ?

Again, I can only tell for my SH7760 platform. You need to register your 
own irq_chip with mask/unmask/mask_ack callbacks. On the SH7760, the 
IRLs trigger as vectors 0-15, and one has to provide external logic to
do the irq masking/acking. SH7780 and newer IIRC provide an INTC 
register for that.

This is code I use:

/* CPU MODULE CPLD IRQ "CONTROLLER" */
static void exm7760_en_cpld_irq(unsigned int irq)
{
         unsigned short val = ctrl_inw(EXM7760_CPLD_MASK) & ~(1 << irq);
         ctrl_outw(val, EXM7760_CPLD_MASK);
}

static void exm7760_dis_cpld_irq(unsigned int irq)
{
         unsigned short val = ctrl_inw(EXM7760_CPLD_MASK) | (1 << irq);
         ctrl_outw(val, EXM7760_CPLD_MASK);
}

static struct irq_chip exm7760_cpld_chip __read_mostly = {
         .name           = "CPLD",
         .unmask         = exm7760_en_cpld_irq,
         .mask           = exm7760_dis_cpld_irq,
         .mask_ack       = exm7760_dis_cpld_irq,
};

static void __init exm7760_init_cpld_irq(void)
{
         int i;
         for (i = 0; i < EXM7760_CPLD_IRQNUM; i++)  {
                 set_irq_chip_and_handler_name(i, &exm7760_cpld_chip,
                                 handle_level_irq, "level");
                 set_irq_chip_data(i, NULL);
         }
}


> The documentation says: "Other compatible interrupt controllers can be
> cascaded with INTC.". Where can I find some details about that ?

have a look at set_irq_chained_handler() function, for example:

static struct irq_chip exm7760_pcmcia_chip __read_mostly = {
         .name           = "CPLD-PCMCIA",
         .unmask         = exm7760_en_cardirq,
         .mask           = exm7760_dis_cardirq,
         .mask_ack       = exm7760_dis_cardirq,
};

static void exm7760_pcmcia_chain_handler(unsigned int irq,
                                          struct irq_desc *desc)
{
         unsigned short cfctl = ctrl_inw(EXM7760_CPLD_CFCTL);
         if ((cfctl & CFCTL_RDY) = 0)
                 generic_handle_irq(EXM7760_CF_CARD0_IRQ);

         if ((cfctl & (CFCTL_RDY << CFCTL_SOCK1_SHIFT)) = 0)
                 generic_handle_irq(EXM7760_CF_CARD1_IRQ);
}

static void __init exm7760_init_pcmcia_irq(void)
{
         set_irq_chip_and_handler_name(EXM7760_CF_CARD0_IRQ,
                       &exm7760_pcmcia_chip, handle_level_irq, "level");
         set_irq_chip_and_handler_name(EXM7760_CF_CARD1_IRQ,
                       &exm7760_pcmcia_chip, handle_level_irq, "level");

         set_irq_chained_handler(EXM7760_CF_IRQ,
                                 exm7760_pcmcia_chain_handler);
}


Best regards,
	Manuel Lauss
