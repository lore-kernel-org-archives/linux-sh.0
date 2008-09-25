From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 25 Sep 2008 20:18:14 +0000
Subject: MFD for hd64461 thoughts and ideas
Message-Id: <20080925221814.51b06ed2.kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Finally started looking at it, almost ready for testing.
Im not going for anything major currently, just actually
being able to replace the current structure.

Files:
drivers/mfd/hd64461.c
drivers/mfd/hd64461.h

A very basic layout is like this:

Machine files wishing to use driver sets resource with IRQ
(start->end) and chip memory area (start->end). These 
values are then used to set IRQ handling (demux) for all irq's 
involved (baseirq + 15) and also map the io area.

Now, to the issues :
1* Is it a good idea to link the TMU code in there also?
   I mean same file and all?
2* platforms wanting to use this driver should somehow
   setup their own specifics (like powering up), best
   way to handle this? 
3* hd64461 fb and pcmcia should be seperate, but should
   they also register with the "main" driver?
4* the current approach for hd64461 demuxer is to fiddle
   with the irq_desc[], as I understand this is not recommended(?).
   I've tried to workout a different approach in the code below
   where I simply set chip type for all involved irq's and hope
   that they therefore get acked/masked correctly.

I've studied the example drivers in drivers/mfd/ but seems
there are very little chips that are as complete as the hd64461 :P
seeing as it supplies FB / PCMCIA / TIMER / DEMUX...

Best wishes
Kristoffer

ps. included my code so far below, no nitpicking since its
not finished yet :) Suggestions are helpful though.


 /*
  *
  * MFD driver for the Hitachi HD64461 companion chip
  *
  * HD64461 chip contains 8 interrupts handled by an demuxer
  * They control pcmcia, compact flash, 
  *
  * (C) 2008 Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
  *
  * Based on hd64461.c (C) 2000 YAEGASHI Takeshi
  */

#include <linux/sched.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/param.h>
#include <linux/interrupt.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <linux/errno.h>
#include <linux/spinlock.h>
#include <linux/platform_device.h>
#include "hd64461.h"

struct hd64461_info {
    spinlock_t		lock;

    void __iomem	*base_addr;
    int			base_irq;
    int 		irq_end;
};

/* IO FUNCTIONS */
void hd64461_chip_writew(u16 value, struct hd64461_info *hd64461, int reg)
{
    unsigned long addr = hd64461->base_addr;
    
    addr += reg;

    outw(value, addr);
}
EXPORT_SYMBOL(hd64461_chip_writew);

void hd64461_chip_writeb(u8 value, struct hd64461_info *hd64461, int reg)
{
    unsigned long addr = hd64461->base_addr;
    
    addr += reg;
    
    outb(value, addr);
}
EXPORT_SYMBOL(hd64461_chip_writeb);

u16 hd64461_chip_readw(struct hd64461_info *hd64461, int reg)
{
    return(inw(hd64461->base_addr + reg));
}
EXPORT_SYMBOL(hd64461_chip_readw);

u8 hd64461_chip_readb(struct hd64461_info *hd64461, int reg)
{
    return(inb(hd64461->base_addr + reg));
}
EXPORT_SYMBOL(hd64461_chip_readb);

/* IRQ DEMUXER */
static void hd64461_irq_disable(unsigned int irq)
{
    struct hd64461_info *hd64461 = get_irq_chip_data(irq);
    unsigned int nimr;
    unsigned short mask = (1 << (irq - (hd64461->base_irq)));

    nimr = hd64461_chip_readw(hd64461, HD64461_NIMR);
    nimr |= mask;
    hd64461_chip_writew(nimr, hd64461, HD64461_NIMR);
}
    
static void hd64461_irq_mask_ack(unsigned int irq)
{
    hd64461_irq_disable(irq);
}

static void hd64461_irq_unmask(unsigned int irq)
{
    struct hd64461_info *hd64461 = get_irq_chip_data(irq);
    unsigned int nimr;
    unsigned short mask = 1 << (irq - (hd64461->base_irq));
    nimr &= ~mask;
    hd64461_chip_writew(nimr, hd64461, HD64461_NIMR);
}

static void hd64461_demux(unsigned int irq, struct irq_desc *desc)
{
    struct hd64461_info *hd64461 = get_irq_data(irq);
    unsigned short	bit;
    unsigned int	nirr, nimr, i;
    
    nirr = hd64461_chip_readw(hd64461, HD64461_NIRR);
    nimr = hd64461_chip_readw(hd64461, HD64461_NIMR);
    
    nirr &= ~nimr;
    
    /* What irq is causing our interrupt? */
    for (bit = 1, i = 0; i < 16; bit <<= 1, i++)
	if (nirr & bit)
	    break;
    
    /* Lets jump into the correct handler */
    desc = &irq_desc[(nirr + i)];
    desc->handle_irq((nirr + 1), desc);
}

static struct irq_chip hd64461_chip = {
    .name	= "hd64461",
    .ack	= hd64461_irq_mask_ack,
    .mask	= hd64461_irq_mask_ack,
    .unmask	= hd64461_irq_unmask,
};

static int __init hd64461_probe(struct platform_device *pdev)
{
    struct resource 	*res;
    struct hd64461_info *hd64461;
    
    int			irq;
    u16			status_data,v;
    
    /* Allocate our memory */
    hd64461 = kzalloc(size(*hd64461), GFP_KERNEL);
    if (!hd64461) {
	goto fault_0;
    }
    
    /* We get our base IRQ from the driver resource */
    res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);

    if (!res) 
	goto fault_1;

    hd64461->base_irq  = res->start;
    hd64461->irq_end   = res->end;

    res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

    if (!res)
	goto fault_1;
    
    hd64461->base_addr = ioremap(res->start, res->end - res->start);

    platform_set_drvdata(pdev, hd64461);    
    
    /* Ack all currently interrupts */
    hd64461_chip_writeb(0xffff, hd64461, HD64461_NIMR);
    
    /* Make sure all hd64461 interrupts are handled by us */
    for (irq = hd64461->base_irq; (irq < hd64461->irq_end); irq++) {
	set_irq_chip(irq, &hd64461_chip);
	set_irq_chip_data(irq, hd64461);
    }
    
    /* now lets set the base_irq handler (which everything runs through) */
    set_irq_type(hd64461->base_irq, IRQF_DISABLED);
    set_irq_data(hd64461->base_irq, hd64461);
    set_irq_chained_handler(hd64461->base_irq, hd64461_demux);
        
    printk(KERN_INFO "hd64461 configured at 0x%x on base irq %d (demux irq %d - %d)\n",
	    hd64461->base_addr, hd64461->base_irq, hd64461->base_irq, hd64461->irq_end);

    /* Lets set the wakeup status */
    status_data = hd64461_chip_readw(hd64461, HD64461_STBCR);
    status_data |= HD64461_STBCR_SURTST | HD64461_STBCR_SIRST  |
		   HD64461_STBCR_STM1ST | HD64461_STBCR_STM0ST |
		   HD64461_STBCR_SAFEST | HD64461_STBCR_SPC0ST |
		   HD64461_STBCR_SMIAST | HD64461_STBCR_SAFECKE_OST |
		   HD64461_STBCR_SAFECKE_IST;
		   
    /* set pcmcia and standby mode */
    v |= HD64461_STBCR_SPC1ST;
    
    hd64461_chip_writew(v, hd64461, HD64461_STBCR);		   

    /* powerup speaker and pcmcia0 */    
    v = hd64461_chip_readw(hd64461, HD64461_GPADR);
    v |= HD64461_GPADR_SPEAKER | HD64461_GPADR_PCMCIA0;
    hd64461_chip_writew(v, hd64461, HD64461_GPADR);

    /* Set the interrupt styles of both pcmcia */
    hd64461_chip_writew((HD64461_PCCGCR_VCC0 | HD64461_PCCGCR_VCC1), hd64461, HD64461_PCC0GCR);
    hd64461_chip_writew((HD64461_PCCGCR_VCC0 | HD64461_PCCGCR_VCC1), hd64461, HD64461_PCC1GCR);

    /* Set interrupt styles for pcmcia 1 (only storage, no io) */
    hd64461_chip_writeb(0x4c, hd64461, HD64461_PCC1CSCIER);
    hd64461_chip_writeb(0x00, hd64461, HD64461_PCC1CSCR);
    return 0;

fault_0:
    printk(KERN_ERR "Unable to aqcuire memory\n");
    return -ENOMEM;

fault_1:
    printk(KERN_ERR "Unable to get resources\n");
    return -ENODEV;
}

static int __exit hd64461_remove(struct platform_device *pdev)
{

return 0;
}

static struct platform_driver hd64461_driver = {
    .driver	= {
	.name	= "hd64461",
    },
    .remove	= __exit_p(hd64461_remove),
};

static int __init hd64461_init(void)
{
    return platform_driver_probe(&hd64461_driver, hd64461_probe);
}

static void __exit hd64461_exit(void)
{
    platform_driver_unregister(&hd64461_driver);
}
module_init(hd64461_init)
module_exit(hd64461_exit)

MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
MODULE_DESCRIPTION("Core Driver for HD64461");
MODULE_LICENSE("GPL");




-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>
