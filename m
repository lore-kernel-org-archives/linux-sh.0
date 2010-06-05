From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Sat, 05 Jun 2010 13:32:19 +0000
Subject: Re: [PATCH 1/4] Add the directory mach-sh2007 for SH-2007 board support
Message-Id: <4C0A51E3.3060201@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul,
Thanks for your detailed review!
I agree with your review at almost every part,
but I have some opinions.

On 06/02/10 15:32, Paul Mundt wrote:
 > On Mon, May 31, 2010 at 04:59:53PM +0900, Hitoshi Mitake wrote:
 >> This patch adds files for SH-2007 support.
 >> onboardio.c ... Create /dev/dipsw. This file is for reading state of 
dip switch
 >> 	    	and writing power and error LED.
 >> 		(LEDs are pseudo things.)
 >
 > It's not obvious that there's any point in having this as a misc device
 > over simply exposing the dip switch and LED toggling through sysfs.
 >
 > The LEDs should ideally be managed through the LED subsystem, but as
 > there is no generic platform device driver there at the moment you would
 > have to see about writing one.

In fact, these LED devices are "pseudo" things.
So LED supporting part of onboardio.c is a thing like document.
For me, important thing is interface for reading dip switch.
But also dip switch is not a thing must required for using the board.

So I'll pend it and decide this component should be supported or not later.

 >
 >> +/* Support for external interrupt pins in IRQ mode */
 >> +enum {IRQ0 = 1, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7};
 >> +static struct intc_vect irq_vectors[] __initdata = {
 >> +	INTC_IRQ(IRQ0, IRQ_SMC0),
 >> +	INTC_IRQ(IRQ1, IRQ_SMC1),
 >> +	INTC_IRQ(IRQ2, IRQ_CFCARD),
 >> +	INTC_IRQ(IRQ3, IRQ_IDE),
 >> +	INTC_IRQ(IRQ4, 3),
 >> +	INTC_IRQ(IRQ5, 4),
 >> +	INTC_IRQ(IRQ6, 5),
 >> +	INTC_IRQ(IRQ7, 7),
 >> +};
 >> +
 >> +static struct intc_mask_reg irq_mask_registers[] __initdata = {
 >> +	{ INTC_INTMSK0, INTC_INTMSKCLR0, 32,
 >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 >> +};
 >> +
 >> +static struct intc_prio_reg irq_prio_registers[] __initdata = {
 >> +	{ INTC_INTPRI, 0, 32, 4,
 >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 >> +};
 >> +
 >> +static struct intc_sense_reg irq_sense_registers[] __initdata = {
 >> +	{ INTC_ICR1, 32, 2,
 >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 >> +};
 >> +
 >> +static struct intc_mask_reg irq_ack_registers[] __initdata = {
 >> +	{ INTC_INTREQ, 0, 32,
 >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
 >> +};
 >> +
 >> +static DECLARE_INTC_DESC_ACK(intc_irq_desc, "sh7780-irq", irq_vectors,
 >> +			NULL, irq_mask_registers, irq_prio_registers,
 >> +			irq_sense_registers, irq_ack_registers);
 >> +
 > None of this is needed, it's all taken care of by the SH7780 CPU code
 > already.

These IRQs are things for devicde specific,
I think this is required for board support.
# I'm an only newbie, if I make some mistakes,
# please point out :)
