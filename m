From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 07 Jun 2010 03:02:09 +0000
Subject: Re: [PATCH 1/4] Add the directory mach-sh2007 for SH-2007 board support
Message-Id: <20100607030209.GB4258@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1275292796-26602-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Jun 05, 2010 at 10:32:19PM +0900, Hitoshi Mitake wrote:
> On 06/02/10 15:32, Paul Mundt wrote:
> >> +/* Support for external interrupt pins in IRQ mode */
> >> +enum {IRQ0 = 1, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7};
> >> +static struct intc_vect irq_vectors[] __initdata = {
> >> +	INTC_IRQ(IRQ0, IRQ_SMC0),
> >> +	INTC_IRQ(IRQ1, IRQ_SMC1),
> >> +	INTC_IRQ(IRQ2, IRQ_CFCARD),
> >> +	INTC_IRQ(IRQ3, IRQ_IDE),
> >> +	INTC_IRQ(IRQ4, 3),
> >> +	INTC_IRQ(IRQ5, 4),
> >> +	INTC_IRQ(IRQ6, 5),
> >> +	INTC_IRQ(IRQ7, 7),
> >> +};
> >> +
> >> +static struct intc_mask_reg irq_mask_registers[] __initdata = {
> >> +	{ INTC_INTMSK0, INTC_INTMSKCLR0, 32,
> >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> >> +};
> >> +
> >> +static struct intc_prio_reg irq_prio_registers[] __initdata = {
> >> +	{ INTC_INTPRI, 0, 32, 4,
> >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> >> +};
> >> +
> >> +static struct intc_sense_reg irq_sense_registers[] __initdata = {
> >> +	{ INTC_ICR1, 32, 2,
> >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> >> +};
> >> +
> >> +static struct intc_mask_reg irq_ack_registers[] __initdata = {
> >> +	{ INTC_INTREQ, 0, 32,
> >> +	  { IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7 } },
> >> +};
> >> +
> >> +static DECLARE_INTC_DESC_ACK(intc_irq_desc, "sh7780-irq", irq_vectors,
> >> +			NULL, irq_mask_registers, irq_prio_registers,
> >> +			irq_sense_registers, irq_ack_registers);
> >> +
> > None of this is needed, it's all taken care of by the SH7780 CPU code
> > already.
> 
> These IRQs are things for devicde specific,
> I think this is required for board support.
> # I'm an only newbie, if I make some mistakes,
> # please point out :)

I suspect this just stems from a misunderstanding of how to interact with
the IRQ code. All of these registers are part of the SH7780 CPU IRQ
controllers, and have nothing to do with the device. The only thing that
is device specific is how these IRQs are used, and we already expose full
control for that to the boards.

If you read through arch/sh/kernel/cpu/sh4a/setup-sh7780.c you can see
that everything is already centrally managed by the CPU, so the only
thing you need to take care of is the IRQ mapping and IRQ mode pins
setting.

If your board has an FPGA that's chained off of the IRLs then you can set
the controller in to IRL mode, or if you're simply using them as IRQ0-7
directly and letting the CPU controller take care of the masking, then
you can simply throw the controller in to IRQ mode.

Simply grep for plat_irq_setup_pins() to see how the CPU/board
interaction works for this, you'll likely want IRQ_MODE_IRQ for this
case.
