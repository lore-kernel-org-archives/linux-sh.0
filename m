From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Sat, 06 Dec 2008 14:46:13 +0000
Subject: Re: [PATCH] sh: Switch HD64461 from hw_interrupt_type to irq_chip
Message-Id: <aec7e5c30812060646m97e0364g2ad734e653e8e60b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
In-Reply-To: <1227862710-11696-1-git-send-email-mjf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 5, 2008 at 11:04 PM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
> On Tue, 2 Dec 2008 15:40:46 +0900
> "Magnus Damm" <magnus.damm@gmail.com> wrote:
>
>> On Fri, Nov 28, 2008 at 5:58 PM, Matt Fleming <mjf@gentoo.org> wrote:
>> > Use struct irq_chip for the interrupt handler for the HD64461. Also
>> > convert some in{b,w} and out{b,w} calls to the equivalent __raw_* calls.
>> > Include <linux/io.h> and not <asm/io.h> to stop checkpatch.pl
>> > complaining.
>> >
>> > This change should now allow machines with HD64461 to define
>> > GENERIC_HARDIRQS_NO__DO_IRQ.
>> >
>> > Acked-by: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
>> > Signed-off-by: Matt Fleming <mjf@gentoo.org>

Hi Kristoffer,

> Sorry for my late reply, been away from school for
> a week.

No worries, thanks for following up.

>> > diff --git a/arch/sh/cchips/hd6446x/hd64461.c b/arch/sh/cchips/hd6446x/hd64461.c
>> > index f1a4a07..27ceeb9 100644
>> > --- a/arch/sh/cchips/hd6446x/hd64461.c
>> > +++ b/arch/sh/cchips/hd6446x/hd64461.c
>>
>> [snip]
>>
>> > -       setup_irq(CONFIG_HD64461_IRQ, &irq0);
>>
>> It looks like the interrupt driving the hd64461 chip is changed from
>> being requested with setup_irq()/request_irq() to using the machvec
>> demux. So the interrupt is handled by hooking up hd64461_irq_demux()
>> to the sh_machine_vector member mv_irq_demux in the
>> arch/sh/boards/mach-hp6xx/setup.c.
>>
>
> Correct.
>
>> Using the demux for IRL interrupts that cannot be acknowledged and
>> masked by the processor is a good idea. The interrupt handling for the
>> r2d board which can be found in arch/sh/boards/mach-r2d/irq.c may
>> serve as an example. If the interrupt is a regular single IRQ pin
>> configured in IRQ mode then you should not use the demux.
>>
>
> I'm fine with using a demuxer and maintaining the virtual
> IRQ range. Would also simplify the mfd driver.

Heh, I'm not trying to convince you to stop demuxing your interrupts.
=) Maintaining the range of interrupts and demuxing them is a good
idea, but the way you connect the demux function doesn't seem
consistent with the interrupt mode you configure the hardware in.

Using the machvec is correct if you use IRL mode. If you are using IRQ
mode you should _not_ hook in using the machvec.

IRL mode interrupts cannot be masked using the internal processor
hardware, so it's not possible to support them as regular intc
interrupt sources. The only way to support them is by using the
machvec demux hook together with board specific code that masks the
interrupts using external hardware.

IRQ mode always supports masking in the processor, so you can let intc
handle all details about the interrupt for you in that case. Note that
this only applies to IRQ5 in your specific case with the companion
chip, you still need to mask and manage interrupts in your own private
range like today.

>> Judging by the hp6xx board code you use IRQ3->0 in IRQ mode. If you
>> should use IRL or IRQ can be determined by looking at the board
>> schematics for your platform. If you can point me out where those are
>> then i can help you figure that part out.
>
> The code is somewhat misleading in that it uses
> the term irq0 while requesting irq. The thought is
> to think of irq0 as the base irq (for demux) and not
> the actual mapping (IRQ0->IRQ5) on the hd64461.
>
> It would be more correct to instead refer to the
> hd64461 IRQ as IRQ4 (IRQ 36 on hp6xx).

Using IRQ4 as name would maybe be a bit more clear, yes. =) The
interrupt pin name seems to be IRQ0 on the companion chip though so
the name is not so strange from that perspective.

You should be able to use intc as is today. Judging by this patch you
seem to be using intc in an inconsistent fashion. Or rather - since
you hook in your demux function using the machvec you don't use intc
for IRQ5 at all. The demux function in the machvec gets called before
intc so you never let intc get the change to handle the acknowledge
for you.

> We currently set IRQ0->IRQ3 to IRQ mode as you say,
> we do not touch IRQ4 or IRQ5 at all. I'm not exactly
> sure what the "default" puts it in. Whatever it starts
> with seems to be the correct thing, we just need
> to make sure it acks through IRR0 also.

The default depends on processor type. Processors that only have one
configuration should use that by default. This may vary a bit though
depending on the level of support. Please have a look at the intc code
to see which sources that get installed by default.

> You can access copies of the relevant datasheets
> from :
> http://jlime.com/downloads/development/datasheets/6xx/

Thanks. It looks like the companion chip only has a single IRQ output
so then IRL mode is out of the question. IRQ mode seems correct. So
please try yo use set_irq_chained_handler() and see if your interrupts
get acked properly.

This is how I add support for external interrupt controllers
step-by-step, I recommend you to follow the same way if you run into
trouble.

1. Change your kernel config to only include support for a single
piece of hardware that is using your parent interrupt, ie IRQ5 in your
case. For instance, if your hardware platform makes use of the serial
port in the companion chip then I recommend you to just use that to
begin with. Maybe it's difficult to boot your kernel fully with only a
single driver, but remember that you don't really need any user space
to hack up this code. You can do everything using compiled-in drivers.
If you need user space to trigger your interrupt then i recommend
initramfs.

2. Modify your demux code to only allow unmasking of the interrupt
associated with your hardware device. Only one interrupt source is
allowed to begin with.

3. Trigger the interrupt somehow - this depends on the type of
hardware. This may happen during probe() of the driver, but that
depends. Make sure you can mask, unmask and ack the interrupt
properly, both using the parent interrupt (IRQ5) and your own external
interrupt. You can use printk or toggle leds or something fancier to
check that the interrupts are triggered as you expect. If you can't
get this working then it may be good to skip this particular hardware
device for now and move on to a different one and come back later.

4. When interrupts for a device is working then make a patch and save
that somewhere. Then start over with another hardware device.

5. Repeat until all devices are supported or until you're satisfied.

6. Combine all patches and make sure you can use the interrupts together.

7. Post patch. =)

Good luck. If you get stuck at step 3 then let me know and i'll do my
best to help out.

Cheers,

/ magnus
