From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 13:35:37 +0000
Subject: Re: [PATCH v2 0/3] ARM: shmobile: sh73a0: fix spurious irqpin interrupts
Message-Id: <CANqRtoTsCFu=-WfPn3NSxedxR7JGgHeS1xL=1qBDUHzy_sZE2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374510105-21896-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Jul 24, 2013 at 9:51 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Wednesday 24 July 2013 20:04:45 Magnus Damm wrote:
>> On Wed, Jul 24, 2013 at 7:33 PM, Laurent Pinchart wrote:
>> > On Wednesday 24 July 2013 18:19:40 Magnus Damm wrote:
>> >> On Wed, Jul 24, 2013 at 4:47 PM, Guennadi Liakhovetski wrote:
>> >> > On Wed, 24 Jul 2013, Magnus Damm wrote:
>> >> >> On Wed, Jul 24, 2013 at 4:02 PM, Guennadi Liakhovetski wrote:
>> >> >> > On Wed, 24 Jul 2013, Magnus Damm wrote:
>> >> >> >> On Tue, Jul 23, 2013 at 1:21 AM, Guennadi Liakhovetski wrote:
>> >> >> >> > On sh73a0 irqpin interrupts have to be masked on the parent GIC
>> >> >> >> > controller. This can only be done if interrupts are mapped when
>> >> >> >> > the first spurious IRQ occurs. Patch 2 in this series maps all
>> >> >> >> > irqpin interrupts at probe time to fix the problem. The third
>> >> >> >> > patch adds support for an irqpin IRQ to kzm9g-reference.
>> >> >> >> >
>> >> >> >> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>> >> >> >> >
>> >> >> >> > Guennadi Liakhovetski (3):
>> >> >> >> >   ARM: shmobile: sh73a0: fix spurious irqpin interrupts in the DT
>> >> >> >> >   case
>> >> >> >> >   irqchip: intc-irqpin: pre-map all interrupts in the DT case
>> >> >> >> >   ARM: shmobile: kzm9g-reference: use GPIO for card detection on
>> >> >> >> >   SDHI2
>> >> >> >> >
>> >> >> >> >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    2 +-
>> >> >> >> >  arch/arm/boot/dts/sh73a0.dtsi                |    2 ++
>> >> >> >> >  drivers/irqchip/irq-renesas-intc-irqpin.c    |   10 +++++++++-
>> >> >> >> >  3 files changed, 12 insertions(+), 2 deletions(-)
>> >> >> >>
>> >> >> >> Thanks for bringing this up again.
>> >> >> >>
>> >> >> >> Question: Would it be possible to use the following DT style for
>> >> >> >> sh73a0 INTC?
>> >> >> >>
>> >> >> >> In sh73a0.dsti:
>> >> >> >> status = "disabled"
>> >> >> >>
>> >> >> >> In board dt:
>> >> >> >> status = "okay"
>> >> >> >
>> >> >> > Sure, that's possible, if we don't just want to enable all of them
>> >> >> > on all boards like we do with all other common devices like
>> >> >> > interrupt, DMA controllers, pinctrl, even I2C controllers for some
>> >> >> > reason.
>> >> >>
>> >> >> There is a reason why we in the legacy C code enable all serial ports,
>> >> >> SPI controllers and I2C masters. =)
>> >> >>
>> >> >> Basically, if we just enable some of them then the mapping between bus
>> >> >> number and device gets out of hand. So we may end up with I2C master
>> >> >> controller 2 using bus number 1. Or ttySC0 being SCIF4. When we have a
>> >> >> wide range of boards and SoCs to support then this is exactly what I
>> >> >> don't want to spend time with. =)
>> >> >>
>> >> >> On newer code with DT reference the situation is better than in C so
>> >> >> we may not have to describe the I2C bus devices separately from the
>> >> >> I2C controller. In that case I think it is pretty clear that it makes
>> >> >> sense to allow using only a subset of the I2C controllers. Using
>> >> >> status = "disabled"/"okay" may be good.
>> >> >>
>> >> >> In general I'd like to have a discussion about how the future DT board
>> >> >> support should look like in a consistent way. But that's a different
>> >> >> topic..
>> >> >>
>> >> >> For sh73a0 INTC, since this seems to be hardware bug workaround then
>> >> >> "disabled" and "okay" may be acceptable.
>> >> >>
>> >> >> >> In the DT case, if we could enable only used interrupt controllers
>> >> >> >> then perhaps patch 1/3 and 2/3 are not needed?
>> >> >> >
>> >> >> > We then could avoid 1/3 and only add the "control-parent" property
>> >> >> > to the enabled instances in the board code together with the 'status
>> >> >> > = "okay"' property, that's true. But how do you want to remove 2/3?
>> >> >> > How do you fix the problem then?
>> >> >>
>> >> >> I thought the unused INTC instances were in "disabled" state so 2/3
>> >> >> isn't needed?
>> >> >
>> >> > Unused INTC instances would be in "disabled" state, that's right. But
>> >> > out of 4 INTC instances on sh73a0 certainly not all are unused. At
>> >> > least one of them is used for the ethernet, so, irqpin0 has to be
>> >> > enabled. Currently the DT (-reference) kzm9g support doesn't include
>> >> > any other irqpin users, but looking at kzm9g C version there are a few
>> >> > more of them like the touchscreen, an accelerometer etc. Also by
>> >> > accident as it seems, no IRQs on irqpin0 currently cause spurious
>> >> > interrupts in my configuration. So, atm just disabling irqpin1, 2, and
>> >> > 3 removes all the spurious interrupts from the system, but if for some
>> >> > reason on another board other IRQs on irqpin0 produce spurious
>> >> > interrupts, or if we enable any of irqpin1-3 we get this problem back.
>> >>
>> >> Ok, so putting irqpin 1, 2, 3 in disabled state will solve the current
>> >> issue. Can you please cook up some code for this?
>> >>
>> >> If we run into issues with IRQs for touchscreen or accelerometer then
>> >> we can solve them at that time.
>> >
>> > I agree that unused pieces of hardware should not be enabled, regardless
>> > of whether they're interrupt controllers or other devices. This reduces at
>> > least the memory footprint, and is thus a good rule of thumb.
>>
>> Sure. Please improve the DT reference board support in this regard. =)
>
> I'll add that to my TODO list :-)
>
>> > Disabling irqpin 1, 2 and 3 might work around the spurious interrupts
>> > issue, but it merely hides the problem. As quite a lot of time went into
>> > investigating the cause of the issue, I'd rather finish the work now and
>> > push a proper fix.
>>
>> May I ask who has put in a lot of effort into this?
>
> Based on your comments below, you have :-) And Guennadi has also been looking
> at the problem for some time now. We've had quite a few discussions on the
> topic.

Yes...

>> Hiding it is pretty much the only thing we can do unless someone wants to
>> spend more time to fix it. I certainly don't want to do that. On top of this
>> issue sh73a0 has INTCS for some part of the interrupts, and DT support there
>> is stalled - so based on that it seems that IRQs will always be busted on
>> that SoC.
>>
>> I spent ages trying to figure out the reason for the initial case when I
>> started hacking on sh73a0, followed by writing the local demux code in intc-
>> sh73a0.c and rewriting it into drivers/irqchip/. And now we're dealing with
>> DT and IRQ domain difference compared to the non-DT case.
>>
>> The cause of this is most likely hardware bugs that somehow seems to route
>> PFC signals for some pins to the interrupt controller even though they are
>> supposed to be masked.
>
> As I mentioned previously Guennadi told me that the values written by the
> driver to the REG_MASK register don't seem to be latched by the hardware for
> some reason (reading the register back gives the previous value). I'm not sure
> if it's a feature or a bug, and we'll probably never know.

I may be wrong, but I recall noticing that some of the spurious
interrupts seem to come from pins that have clock input/output
functions on them.

>> And now with DT behaving differently than the non-DT case for IRQ domains it
>> seems that the GIC masking isn't really possible without the workaround
>> posted by Guennadi. It's a fucking mess. And it only happens on this SoC,
>> that can't have proper IRQs anyway due to missing INTCS DT support.
>
> I might be missing something obvious, but why can't we just disable all the
> parent IRQs at probe time like done in intc_irqpin_irq_disable_force() (as
> proposed in 3. in my previous e-mail) ? That would be pretty simple and would
> work the same way in the DT and non-DT cases.

That's fine with me.

>> > I see 3 ways to properly fix the issue:
>> >
>> > 1. Understand why the irqpin controllers on sh73a0 don't mask interrupts
>> > properly and fix the problem accordingly. That would be my favorite
>> > solution, but it might not be doable. Guennadi told me that the values
>> > written to the irqpin IRQ masking register seemed not to be latched by
>> > the hardware. This could be a hardware bug (in which case we need a work
>> > around), or a hardware feature (we might write to the register without
>> > the related clock being enabled for instance). In the latter case
>> > understanding the root cause would lead to a good fix.
>>
>> So it's an old chip. The hardware is busted. It has always been problematic.
>> And now with IRQ domain for DT the software is behaving differently so the
>> existing workaround isn't ok. The driver is fine on other SoCs - with and
>> without DT.
>>
>> Of course, if anyone wants to spend time on fixing this then go ahead. But I
>> can think of one zillion things that are more important.
>>
>> > 2. Pre-mapping interrupts at probe time, as done in patch 2/3. The irqpin
>> > IRQ handler will then ack the IRQ in the irqpin IRQ source register when
>> > the first spurious interrupt occurs, preventing the interrupt storm. This
>> > fixes the problem, but every pulse on the external signal will retrigger
>> > the spurious interrupt, which isn't perfect.
>>
>> Yes, this makes the DT case behave similar to the non-DT case. But is this
>> difference in IRQ domains between DT and non-DT really something that should
>> be fixed in the driver? If it should be fixed, then yes, having some kind of
>> comment would be nice.
>
> OK, let me try to summarize what happens in both the DT and non-DT cases.

Good idea, thanks.

> The irqpin controller sits between external SoC pads connected to external
> signals and the GIC.
>
>
>     +-----+       +--------+       +-----+
>     | pad | ----> |        | ----> |     |
>     +-----+       |        |       |     |
>       ...   ----> | irqpin | ----> | GIC |
>     +-----+       |        |       |     |
>     | pad | ----> |        | ----> |     |
>     +-----+       +--------+       +-----+
>
>
> The irqpin controller serves several purposes:
>
> - Detection of edge and level triggers
> - Interrupt masking
> - Priority handling (currently unused)
> - Multiplexing several external interrupts on one GIC interrupt (this can be
> ignored for the purpose of this discussion, as multiplexing irqpin controller
> don't exhibit the problem we're trying to solve)

With the GIC it's mainly there for interrupt sense/trigger
configuration. And in some cases there is not a one-to-one mapping
with the parent interrupt controller, so in that case it needs to
demux too. In the old days with the INTC interrupt controller there
were also priorities, but we don't use them.

> The irqpin driver registers one IRQ chip per irqpin device instance, and
> request one GIC interrupt for each external interrupt line (as the buggy
> devices have a 1:1 mapping between external interrupt lines and GIC
> interrupts).

For sh73a0 there is one GIC interrupt per IRQ signal. On other SoCs it
may be different.

> For an unknown reason writing to the INTMSK register to mask interrupts
> doesn't work properly on the sh73a0. On that SoC, the irqpin not correctly
> mask external interrupts and will generate a GIC interrupt request when an
> external interrupt is triggered, even if the external interrupt has been
> masked in the INTMSK register.

Right.

> An external interrupt event thus results in the handler registered by the
> irqpin driver for the corresponding GIC interrupt being called.
>
> static irqreturn_t intc_irqpin_irq_handler(int irq, void *dev_id)
> {
>         struct intc_irqpin_irq *i = dev_id;
>         struct intc_irqpin_priv *p = i->p;
>         unsigned long bit;
>
>         intc_irqpin_dbg(i, "demux1");
>         bit = intc_irqpin_hwirq_mask(p, INTC_IRQPIN_REG_SOURCE, i->hw_irq);
>
>         if (intc_irqpin_read(p, INTC_IRQPIN_REG_SOURCE) & bit) {
>                 intc_irqpin_write(p, INTC_IRQPIN_REG_SOURCE, ~bit);
>                 intc_irqpin_dbg(i, "demux2");
>                 generic_handle_irq(i->domain_irq);
>                 return IRQ_HANDLED;
>         }
>         return IRQ_NONE;
> }
>
> Let's assume no driver has registered any interrupt handler for the external
> interrupt that gets trigerred.
>
> On non-DT platforms all interrupts are pre-mapped. This means that the
> intc_irqpin_irq hw_irq and domain_irq fields are initialized. The interrupt
> handler reads the INTREQ (REG_SOURCE) register, finds out that the
> corresponding IRQ has been triggered, and ack it by clearing the corresponding
> bit in the INTREQ register. the generic_handle_irq() call will dispatch the
> interrupt, and will increment the spurious interrupts count. As the interrupt
> has been acked by the irqpin driver it will not get retrigerred immediately.
> However, note that, if the external interrupt is triggered again, another
> spurious interrupt will occur.

I may be wrong, but I believe that during this process the parent GIC
irq will be masked.

> On DT platforms interrupts are mapped when requested. The intc_irqpin_irq
> hw_irq and domain_irq fields will not be initialized and will be equal to 0.
> Assuming the external interrupt that was trigerred isn't HW IRQ 0, the driver
> will check INTREQ bit 0, find out that no interrupt occured, and just return
> IRQ_NONE without acking the real interrupt source. The interrupt will get
> trigerred again as soon as the interrupt handler finishes, resulting in an
> interrupts storm.
>
> The bottom line is that the hardware behaves exactly the same way in both the
> DT and non-DT cases, but the interrupt handler doesn't.

So the interrupt handler is fed different data depending on DT or non-DT, right?

> We have several ways to fix the problem, as discussed in my previous e-mail.
> Guennadi's patch 2/3 pre-maps the interrupts to make sure the interrupt
> handler will correctly ack the interrupt source, but that's only an incomplete
> fix. If the external interrupt signal is retriggers an interrupt, another
> spurious interrupt will be generated. Note that this is valid for the non-DT
> case as well, if the external signal is pulsed you will get lots of spurious
> interrupts with the existing code.

My opinion is that they won't re-trigger since they have been masked in the GIC.

> The proper way (at least in my opinion) to fix the problem is to mask the
> disabled interrupts, both at runtime (in the irqchip .irq_disable() operation)
> and at probe time (to initialize all interrupts as masked). If we can't find
> out why masking the interrupt at the irqpin level doesn't work (or if we find
> out that it's a hardware bug and not a feature that we don't understand), we
> will then need to mask the interrupt in a different place.

Sure, but how do you mask the GIC at probe time then?

> There are two other places where we can mask the interrupts. The first one is
> the GIC, and the .irq_disable() function already disables the parent GIC
> interrupt when the control-parent property is set in DT. For the fix to be
> complete, we also need to disable the GIC interrupts at probe time, and extend
> this to cover the non-DT case (which is currently broken as well, as explained
> above).

So the control-parent thing is a big layering violation inside the
driver by itself IMO, but it seems OK for the non-DT case. I wonder
how this layering violation can be extended to mask the GIC at probe
time? =)

> Reading the datasheet I've found that interrupts can also be masked at the
> irqpin level through the INTPRI register. If this works on sh73a0, it would
> probably be a better solution, as the fix wouldn't involve disabling/enabling
> GIC interrupts at runtime. If this hasn't been tested before I think we should
> give this a try.

From my old INTC days I recall that sometimes the priority bits behave
differently depending on SoC. I'm quite sure I've tried masking with
priority - it would be the first thing I tried - and masking the
parent the last - but double checking doesn't hurt (as long as I don't
have to =)

>> Also, without an actual use case it just looks like the driver will become
>> polluted for no apparent reason when we can solve it with DT
>> status="disabled" instead.
>>
>> Show me where this is needed and we can talk about it. =)
>>
>> > 3. Disabling the parent interrupt at probe time for all IRQs, and letting
>> > the current logic enable/disable the parent interrupt when control-parent
>> > is set. I haven't tested this solution, but it wouldn't require
>> > pre-mapping all interrupts at probe time, and looks like it would get rid
>> > of all spurious interrupts.
>> >
>> > If 1 isn't possible, could 3 be implemented ?
>>
>> Maybe so, but that would require fucking around with the GIC code. Or
>> perhaps some local workaround code could be written to iterate over a
>> certain range of SPIs and masking them somehow. It seems fragile to
>> me. But in the end it seems that the current parent-masking strategy
>> is incompatible with the IRQ domain DT case - unless the interrupts
>> are mapped directly like patch 2/3.
>>
>> So how about the following order:
>>
>> A) Update the sh73a0 DT code with status = "disabled" and enable
>> necessary bits with status = "okay".
>
> Actually, thinking a bit more about the problem, there's a single INTCA0
> device in the sh73a0 that handles the 32 external IRQs, but we currently have
> 4 DT nodes. That's something we should fix by replacing the irqpin nodes with
> a single INTCA0 node. That device would then always be enabled.

You are paying attention to the sh73a0 data sheet, sweet! =) You know
there used to be a INTCA1 too for a while. Sometimes it's called
something else. It varies with time from SoC to SoC but it's about the
same.

Feel free to rearrange the driver any way you'd like. But my opinion
is that it's a waste of time since it's only covering old stuff. And
the data sheet names and boxes are probably written by marketing
people. The driver is designed like it is to support multiple legacy
SoCs. And yes, the register size and bit field size vary with SoC
type. Good luck! =)

>> B) Add stuff to DT reference over time. Or phase out the hardware.
>>
>> C) When needed, enable further INTC bits with status = "okay". Or
>> phase out the hardware.
>
> We already have a use case: IRQ18, handled by irqpin2, is used as the SDHI2
> card detect interrupt.

Can't you use the native CD function of the SDHI in this case, or is
it GPIO only?

>> D) If this doesn't work, show where it happens and send an improved
>> version of patch 2/3.
>
> If a simple, not too intrusive fix to the issue can be found, I'd rather add
> it now instead of redoing all the work again later. We could add a comment to
> the code to mention explicitly that this is only needed for broken hardware
> and could be removed later if support for that hardware is phased out.

Sure. I've gone through this multiple times before, and I tried to do
it properly then. Now the IRQ domain stuff for DT adds more enjoyment.
I of course prefer to see a proper solution, but I strongly doubt that
anything useful can come out. Also, it's totally one-off since no
other SoC needs this. So no point in spending much time on this.

Cheers,

/ magnus
