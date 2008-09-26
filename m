From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 26 Sep 2008 00:56:39 +0000
Subject: Re: MFD for hd64461 thoughts and ideas
Message-Id: <20080926005639.GA14257@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080925221814.51b06ed2.kristoffer.ericson@gmail.com>
In-Reply-To: <20080925221814.51b06ed2.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ adding MFD maintainer to Cc, he might be able to give you some more
  input ]

On Thu, Sep 25, 2008 at 10:18:14PM +0200, Kristoffer Ericson wrote:
> Now, to the issues :
> 1* Is it a good idea to link the TMU code in there also?
>    I mean same file and all?

TMU is confusing in this context, if you mean the SH TMU, then no. If you
mean the HD64461 timer, then you have a couple of options. You can either
opt to have all of your supported peripherals registered and handed off
through your mfd driver (as sm501 does), or you can break it out in to
smaller drivers and place the TMU bits in to drivers/clocksource.

In the case of SM501, look for the SM501_USE_xxx flags, and then also
grep the kernel source for the drivers that tie in to it.

> 2* platforms wanting to use this driver should somehow
>    setup their own specifics (like powering up), best
>    way to handle this? 

platform data from board setup code, the same way as every other driver?

> 3* hd64461 fb and pcmcia should be seperate, but should
>    they also register with the "main" driver?

Yes. Especially since both of these things should be centrally managed by
the MFD driver. Most of the core logic from those drivers should be
removed and consolidated in the MFD. Again, look at SM501 for the fb
case.

> 4* the current approach for hd64461 demuxer is to fiddle
>    with the irq_desc[], as I understand this is not recommended(?).
>    I've tried to workout a different approach in the code below
>    where I simply set chip type for all involved irq's and hope
>    that they therefore get acked/masked correctly.
> 
> I've studied the example drivers in drivers/mfd/ but seems
> there are very little chips that are as complete as the hd64461 :P
> seeing as it supplies FB / PCMCIA / TIMER / DEMUX...
> 
I don't know about that, most of the MFD drivers are fairly complex and
complete. It's true the HD64461 has more peripherals, but you are a long
way off from caring about that, and once you have the base stuff out of
the way, it should be obvious how to interface the rest.

> /* IO FUNCTIONS */
> void hd64461_chip_writew(u16 value, struct hd64461_info *hd64461, int reg)
> {
>     unsigned long addr = hd64461->base_addr;
>     
>     addr += reg;
> 
>     outw(value, addr);
> }
> EXPORT_SYMBOL(hd64461_chip_writew);
> 
Please use ioread/iowriteX() and go that way accordingly. Here you are
blurring the lines between PIO and MMIO, which while on your platform
might make sense, is not gauranteed to be the case in other places. The
platform data can pass down the IORESOURCE type when the register space
is registered, which we in turn pass off to ioport_map, which will work
out the proper acesssors for itself.

> static void hd64461_demux(unsigned int irq, struct irq_desc *desc)
> {
>     struct hd64461_info *hd64461 = get_irq_data(irq);
>     unsigned short	bit;
>     unsigned int	nirr, nimr, i;
>     
>     nirr = hd64461_chip_readw(hd64461, HD64461_NIRR);
>     nimr = hd64461_chip_readw(hd64461, HD64461_NIMR);
>     
>     nirr &= ~nimr;
>     
>     /* What irq is causing our interrupt? */
>     for (bit = 1, i = 0; i < 16; bit <<= 1, i++)
> 	if (nirr & bit)
> 	    break;
>     
>     /* Lets jump into the correct handler */
>     desc = &irq_desc[(nirr + i)];
>     desc->handle_irq((nirr + 1), desc);
> }

If your driver has to poke at irq_desc[], you lose. Just hook in an IRQ
handler from the driver that registers. You should only be enabling the
IRQ bits that have been requested and have drivers backing them anyways.

Anyways, this is not a new problem, and it's been solved in lots of
different ways. Given that you're going to be hanging a clocksource off
of this, deferring processing to a bottom half probably isn't the way you
want to go. So, you will need to have a handler registered to call in to
directly frop the top half. Look at ucb1x00-core.c for an example of how
these situations have traditionally been dealt with. In theory we could
find a way to abuse the genirq code by setting up a virtual IRQ range,
but there's no real reason for that, as the only one that needs access
to the IRQ information is the MFD itself, the drivers simply want a
notifier.

> 
> static struct irq_chip hd64461_chip = {
>     .name	= "hd64461",
>     .ack	= hd64461_irq_mask_ack,
>     .mask	= hd64461_irq_mask_ack,
>     .unmask	= hd64461_irq_unmask,
> };
> 
> static int __init hd64461_probe(struct platform_device *pdev)
> {
>     struct resource 	*res;
>     struct hd64461_info *hd64461;
>     
>     int			irq;
>     u16			status_data,v;
>     
>     /* Allocate our memory */
>     hd64461 = kzalloc(size(*hd64461), GFP_KERNEL);
>     if (!hd64461) {
> 	goto fault_0;
>     }
>     
>     /* We get our base IRQ from the driver resource */
>     res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> 
>     if (!res) 
> 	goto fault_1;
> 
>     hd64461->base_irq  = res->start;
>     hd64461->irq_end   = res->end;
> 
>     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> 
>     if (!res)
> 	goto fault_1;
>     
>     hd64461->base_addr = ioremap(res->start, res->end - res->start);
> 
resource size is off by 1. Should be res->end - res->start - 1. Better
yet, use the shiny new resource_len() interface that handles this for
you, so I don't have to make a macro that repeats this sentence every
time someone posts a driver to the list. ;-)

>     platform_set_drvdata(pdev, hd64461);    
>     
>     /* Ack all currently interrupts */
>     hd64461_chip_writeb(0xffff, hd64461, HD64461_NIMR);
>     
>     /* Make sure all hd64461 interrupts are handled by us */
>     for (irq = hd64461->base_irq; (irq < hd64461->irq_end); irq++) {
> 	set_irq_chip(irq, &hd64461_chip);
> 	set_irq_chip_data(irq, hd64461);
>     }
>     
>     /* now lets set the base_irq handler (which everything runs through) */
>     set_irq_type(hd64461->base_irq, IRQF_DISABLED);
>     set_irq_data(hd64461->base_irq, hd64461);
>     set_irq_chained_handler(hd64461->base_irq, hd64461_demux);
>         
>     printk(KERN_INFO "hd64461 configured at 0x%x on base irq %d (demux irq %d - %d)\n",
> 	    hd64461->base_addr, hd64461->base_irq, hd64461->base_irq, hd64461->irq_end);
> 
>     /* Lets set the wakeup status */
>     status_data = hd64461_chip_readw(hd64461, HD64461_STBCR);
>     status_data |= HD64461_STBCR_SURTST | HD64461_STBCR_SIRST  |
> 		   HD64461_STBCR_STM1ST | HD64461_STBCR_STM0ST |
> 		   HD64461_STBCR_SAFEST | HD64461_STBCR_SPC0ST |
> 		   HD64461_STBCR_SMIAST | HD64461_STBCR_SAFECKE_OST |
> 		   HD64461_STBCR_SAFECKE_IST;
> 		   
>     /* set pcmcia and standby mode */
>     v |= HD64461_STBCR_SPC1ST;
>     
>     hd64461_chip_writew(v, hd64461, HD64461_STBCR);		   
> 
>     /* powerup speaker and pcmcia0 */    
>     v = hd64461_chip_readw(hd64461, HD64461_GPADR);
>     v |= HD64461_GPADR_SPEAKER | HD64461_GPADR_PCMCIA0;
>     hd64461_chip_writew(v, hd64461, HD64461_GPADR);
> 
>     /* Set the interrupt styles of both pcmcia */
>     hd64461_chip_writew((HD64461_PCCGCR_VCC0 | HD64461_PCCGCR_VCC1), hd64461, HD64461_PCC0GCR);
>     hd64461_chip_writew((HD64461_PCCGCR_VCC0 | HD64461_PCCGCR_VCC1), hd64461, HD64461_PCC1GCR);
> 
>     /* Set interrupt styles for pcmcia 1 (only storage, no io) */
>     hd64461_chip_writeb(0x4c, hd64461, HD64461_PCC1CSCIER);
>     hd64461_chip_writeb(0x00, hd64461, HD64461_PCC1CSCR);
>     return 0;
> 
I think you are getting confused by what an MFD driver is all about. The
MFD itself should have no knowledge of how the underlying device is going
to be utilized, or what parts of it. It should only implement all of the
base management code and provide the interfaces for drivers built on top
of it to take care of the rest. As an example, the MFD init should never
be turning on PCMCIA bits in its init code, but it should provide the
PCMCIA driver with all of the interfaces it needs (this can include a
routine that takes care of general powerup and takes a bit position as an
argument, as SM501 already does today).

> fault_0:
>     printk(KERN_ERR "Unable to aqcuire memory\n");
>     return -ENOMEM;
> 
> fault_1:
>     printk(KERN_ERR "Unable to get resources\n");
>     return -ENODEV;
> }
> 
Here you have a memory leak, since you never kfree() hd64461. Likewise,
you don't need multiple error paths here. Push your printk()'s underneath
the failing case, copy the error value over that you actually get handed
back, and have an unconditional kfree(hd64461) in the out path.
kfree(NULL) is perfectly acceptable.

Better yet, use dev_err() instead of printk(KERN_ERR ...), as it takes
care of pretty naming for you. Likewise with dev_info() and all of that
other goodness. You shouldn't need to use printk() at all in any of your
code here.

> static int __exit hd64461_remove(struct platform_device *pdev)
> {
> 
> return 0;
> }
> 
.. Yes.
