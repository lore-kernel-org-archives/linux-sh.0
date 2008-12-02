From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Tue, 02 Dec 2008 06:40:46 +0000
Subject: Re: [PATCH] sh: Switch HD64461 from hw_interrupt_type to irq_chip
Message-Id: <aec7e5c30812012240k5ef08ee9idb08270d61e80e8d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
In-Reply-To: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 28, 2008 at 5:58 PM, Matt Fleming <mjf@gentoo.org> wrote:
> Use struct irq_chip for the interrupt handler for the HD64461. Also
> convert some in{b,w} and out{b,w} calls to the equivalent __raw_* calls.
> Include <linux/io.h> and not <asm/io.h> to stop checkpatch.pl
> complaining.
>
> This change should now allow machines with HD64461 to define
> GENERIC_HARDIRQS_NO__DO_IRQ.
>
> Acked-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
> Signed-off-by: Matt Fleming <mjf@gentoo.org>

Hi Matt and Kristoffer,

> diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/hd64461.c
> index f1a4a07..27ceeb9 100644
> --- a/arch/sh/cchips/hd6446x/hd64461.c
> +++ b/arch/sh/cchips/hd6446x/hd64461.c

[snip]

> -       setup_irq(CONFIG_HD64461_IRQ, &irq0);

It looks like the interrupt driving the hd64461 chip is changed from
being requested with setup_irq()/request_irq() to using the machvec
demux. So the interrupt is handled by hooking up hd64461_irq_demux()
to the sh_machine_vector member mv_irq_demux in the
arch/sh/boards/mach-hp6xx/setup.c.

Using the demux for IRL interrupts that cannot be acknowledged and
masked by the processor is a good idea. The interrupt handling for the
r2d board which can be found in arch/sh/boards/mach-r2d/irq.c may
serve as an example. If the interrupt is a regular single IRQ pin
configured in IRQ mode then you should not use the demux.

Judging by the hp6xx board code you use IRQ3->0 in IRQ mode. If you
should use IRL or IRQ can be determined by looking at the board
schematics for your platform. If you can point me out where those are
then i can help you figure that part out.

Now when you're using the demux function then the intc handler will
never be invoked for your CONFIG_HD64461_IRQ interrupt. This means
that you won't get any acknowledge from the intc code.

If the hd64461 chip is hooked up to a single interrupt line in IRQ
mode, then I recommend you to use set_irq_chained_handler() or
set_irq_handler() to associate the interrupt line with a demux
function. This should make the intc code acknowledge the interrupt for
you.

Cheers,

/ magnus
