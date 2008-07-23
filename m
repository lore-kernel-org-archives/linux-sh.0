From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Wed, 23 Jul 2008 09:55:02 +0000
Subject: Re: problems opening console
Message-Id: <20080723095502.GA2700@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4885EC04.4060708@spesonline.com>
In-Reply-To: <4885EC04.4060708@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Luca,

A few nits regarding your board code.

On Wed, Jul 23, 2008 at 11:13:24AM +0200, Luca Santini wrote:
> thanks for the help, i attach also the board-specific machvec 
> initialization files i added.
>
> Paul Mundt wrote:
>> On Tue, Jul 22, 2008 at 04:17:40PM +0200, Luca Santini wrote:
>>   
>>> (in init/main.c ;  init_post(void) function)
>>>
>>> the rootfs seems correctly mounted and the devices /dev/console and 
>>> /dev/ttySC2 are present in the filesystem.
>>>
>>> anybody can help me?
>>>     
>>
>> Post the full boot log and your .config.

> /* 
>  * linux/arch/sh/edosk7760/io.c
>  *
>  * Copyright (C) 2001  Ian da Silva, Jeremy Siegel
>  * Based largely on io_se.c.
>  *
>  * I/O routine for Hitachi EDOSK7760.
>  *
>  */

This file should not be needed any more.

 

> #define SMC_IOADDR	0xA2000300
> 
> #define maybebadio24(name,port) \
>   printk("bad PC-like io %s for port 0x%lx at 0x%08x\n", \
> 	 #name, (port), (__u32) __builtin_return_address(0))
> 
> static inline void delay(void)
> {
> 	ctrl_inw(0xa0000000);
> }
> 
> /* Map the Ethernet addresses as if it is at 0x300 - 0x320 */
> static inline unsigned long __port2addr(unsigned long port)
> {
>      if (port >= 0x300 && port < 0x320)
>      {
> 	  /* SMC91C96 registers are 4 byte aligned rather than the
> 	   * usual 2 byte!
> 	   */
> 	  return SMC_IOADDR + ( (port - 0x300) * 2);
>      }
>      
>      maybebadio24(__port2addr, port);
>      return port;
> }

better you register a platform_device for the ethernet chip, with
SMC_IOADDR as base address for it. Then you can _really_ get rid of
this file.


> /*
>  * linux/arch/sh/kernel/irq_intc2.c
>  *
>  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
>  *
>  * May be copied or modified under the terms of the GNU General Public
>  * License.  See linux/COPYING for more information.                            
>  *
>  * Interrupt handling for INTC2-based IRQ.
>  *
>  * These are the "new Hitachi style" interrupts, as present on the 
>  * Hitachi 7751 and the STM ST40 STB1.
>  *
>  * This module has been extended to support the SH7760
>  *
>  */

Why are you using this old file?  INTC2 support in vanilla 2.6.26 works very
well, there's no need to replace it with outdated code.


> /* 
>  * linux/arch/sh/edosk7760/setup.c
>  *
>  * Copyright (C) 2000  Kazumoto Kojima
>  *
>  *
>  * Modified for EDOSK7760 by
>  * Richard Bister
>  * 
>  * SPES port to 2.6 by
>  * Luca Santini
>  */
[...]
> 	/* This is the Ethernet interrupt */
> 	make_imask_irq(0x09);
> 
> 	/* This is the IntelStrata Flash interrupt */
> 	make_imask_irq(0x0A);

Are you sure IMASK irqs is what you want here (not IRL with an external mask
register?) I don't know the EDOSK7760 so I may be wrong.

 	
> 	SpesPrint("\t\tSPES  init_edosk7760 -> setup scif2 irq\n");
> 	/* Setup scif2 interrupts */
> 	sh7760_make_intc2_irq(SCIF2_ERI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
> 	 	SCIF2_ERI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
> 		SCIF2_INTPRI_OFFSET);
> 	
> 	sh7760_make_intc2_irq(SCIF2_RXI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
> 	 	SCIF2_RXI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
> 		SCIF2_INTPRI_OFFSET);
> 		
> 	sh7760_make_intc2_irq(SCIF2_BRI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
> 	 	SCIF2_BRI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
> 		SCIF2_INTPRI_OFFSET);	
> 		
> 	sh7760_make_intc2_irq(SCIF2_TXI_IRQ, INTC2_BASE0, SCIF2_INTPRI_GROUP,
> 	 	SCIF2_TXI_INTMSK_POS, SCIF2_PRIORITY, SCIF2_INTMSK_OFFSET,
> 		SCIF2_INTPRI_OFFSET);	
> 
> 	SpesPrint("\t\tSPES  init_edosk7760 -> setup usbhi irq\n");
> 
> 	sh7760_make_intc2_irq(USBHI_IRQ, INTC2_BASE0, 
> 			      USBHI_INTPRI_GROUP,
> 			      USBHI_INTMSK_POS, USBHI_PRIORITY, 
> 			      USBHI_INTMSK_OFFSET,
> 			      USBHI_INTPRI_OFFSET);	
> 
> 	/* Setup dmabrg interrupts */
> 	SpesPrint("\t\tSPES  init_edosk7760 -> setup dmabrg irq\n");
> 	sh7760_make_intc2_irq(DMABRGI0_IRQ, INTC2_BASE0, DMABRG_INTPRI_GROUP,
> 	 	DMABRGI0_INTMSK_POS, DMA_PRIORITY, DMABRG_INTMSK_OFFSET,
> 		DMABRG_INTPRI_OFFSET);
> 
> 	sh7760_make_intc2_irq(DMABRGI1_IRQ, INTC2_BASE0, DMABRG_INTPRI_GROUP,
> 	 	DMABRGI1_INTMSK_POS, DMA_PRIORITY, DMABRG_INTMSK_OFFSET,
> 		DMABRG_INTPRI_OFFSET);
> 		

These calls aren't needed on 2.6.26, remove them.  Generic code takes care
of INTC2 registration.

		
> #define SA_INTERRUPT	0x20000000 /* dummy -- ignored */ //SPES: da signal.h del 2.4 

this has become IRQF_DISABLED quite a while ago ;-)


> #define __IO_PREFIX sh_edosk7760
> #define u8  unsigned char
> #define u16 unsigned short
> #define u32 unsigned long
> 
> #include <linux/autoconf.h>
> #include <asm/io_generic.h>
> 
> #define INTC_IPRA	0xffd00004UL
> #define INTC_IPRB	0xffd00008UL
> #define INTC_IPRC	0xffd0000cUL
> 
> #define TIMER_IRQ	16
> #define TIMER_IPR_ADDR	INTC_IPRA
> #define TIMER_IPR_POS	 3
> #define TIMER_PRIORITY	 2
> 
> #define RTC_IRQ		22
> #define RTC_IPR_ADDR	INTC_IPRA
> #define RTC_IPR_POS	 0
> #define RTC_PRIORITY	TIMER_PRIORITY
> 
> #define DMTE0_IRQ	34
> #define DMTE1_IRQ	35
> #define DMTE2_IRQ	36
> #define DMTE3_IRQ	37
> #define DMAE_IRQ	38
> #define DMA_IPR_ADDR	INTC_IPRC
> #define DMA_IPR_POS	2
> #define DMA_PRIORITY	7
> 
> #  define ONCHIP_NR_IRQS 128
> 
> #  define PINT_NR_IRQS 0
> #  define OFFCHIP_NR_IRQS 0
> 
> # define ACTUAL_NR_IRQS NR_IRQS
> 
> 
> #define SCIF2_ERI_IRQ 76
> #define SCIF2_RXI_IRQ 77
> #define SCIF2_BRI_IRQ 78
> #define SCIF2_TXI_IRQ 79
> 
> #define SCIF2_INTPRI_OFFSET INTC2_INTPRI08_OFFSET
> #define SCIF2_INTPRI_GROUP 2
> #define SCIF2_INTMSK_OFFSET INTC2_INTMSK00_OFFSET
> #define SCIF2_ERI_INTMSK_POS 3
> #define SCIF2_RXI_INTMSK_POS 2
> #define SCIF2_BRI_INTMSK_POS 1
> #define SCIF2_TXI_INTMSK_POS 0
> #define SCIF2_PRIORITY 3
> 
> 
> #define USBHI_IRQ        64
> #define USBHI_INTPRI_OFFSET INTC2_INTPRI08_OFFSET
> #define USBHI_INTPRI_GROUP 7
> #define USBHI_INTMSK_OFFSET INTC2_INTMSK00_OFFSET
> #define USBHI_INTMSK_POS 17
> #define USBHI_PRIORITY   3 
> 
> #define DMABRGI0_IRQ    68
> #define DMABRGI1_IRQ    69
> #define DMABRG_INTPRI_OFFSET INTC2_INTPRI08_OFFSET
> #define DMABRG_INTPRI_GROUP 5
> #define DMABRG_INTMSK_OFFSET INTC2_INTMSK00_OFFSET
> #define DMABRGI0_INTMSK_POS 14
> #define DMABRGI1_INTMSK_POS 13
> 
> #define INTC2_FIRST_IRQ 48
> #define NR_INTC2_IRQS 64
> 
> #define INTC2_BASE0 0xfe080000
> 
> #define INTC2_INTPRI00_OFFSET	0x00
> #define INTC2_INTPRI04_OFFSET	0x04
> #define INTC2_INTPRI08_OFFSET	0x08
> #define INTC2_INTPRI0C_OFFSET	0x0C
> #define INTC2_INTREQ00_OFFSET	0x20
> #define INTC2_INTREQ04_OFFSET	0x24
> #define INTC2_INTMSK00_OFFSET	0x40
> #define INTC2_INTMSK04_OFFSET	0x44
> #define INTC2_INTMSKCLR00_OFFSET	0x60
> #define INTC2_INTMSKCLR04_OFFSET	0x64
> 
> extern void sh7760_make_intc2_irq(unsigned int irq,unsigned int addr,
>                            unsigned int group,int pos,int priority,
> 						   int mask_offset, int pri_offset);
> 			
> extern void disable_irq(unsigned int);
> extern void disable_irq_nosync(unsigned int);
> extern void enable_irq(unsigned int);
> 
> /*
>  * Simple Mask Register Support
>  */
> extern void make_maskreg_irq(unsigned int irq);
> extern unsigned short *irq_mask_register;
> 
> /*
>  * Function for "on chip support modules".
>  */
> extern void make_ipr_irq(unsigned int irq, unsigned int addr,
> 			 int pos,  int priority);
> extern void make_imask_irq(unsigned int irq);
> 
> #endif //ASM_SH_EDOSK7760
> 

Are you sure you need these in your header?
