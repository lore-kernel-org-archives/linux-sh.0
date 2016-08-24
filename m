From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Aug 2016 19:20:09 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824192009.GX15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <20160824200152.33be0707@arm.com>
In-Reply-To: <20160824200152.33be0707@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Aug 24, 2016 at 08:01:52PM +0100, Marc Zyngier wrote:
> On Wed, 24 Aug 2016 13:40:01 -0400
> Rich Felker <dalias@libc.org> wrote:
> 
> [...]
> 
> > > IIUC, there is a problem with the interrupt controller where
> the per irq
> > > line are not working correctly. Is that correct ?  
> > 
> > I don't think that's a correct characterization. Rather the percpu
> > infrastructure just means something completely different from what you
> > would expect it to mean. It has nothing to do with the hardware but
> > rather with kernel-internal choice of whether to do percpu devid
> > mapping inside the irq infrastructure, and the choice at the
> > irq-requester side of whether to do this is required to match the
> > irqchip driver's choice. I explained this better in another email
> > which I could dig up if necessary, but the essence is that
> > request_percpu_irq is a misnamed and unusably broken API.

For reference, here's the thread I was referring to:

https://lkml.org/lkml/2016/7/15/585

> Or just one that simply doesn't fit your needs, because other
> architectures have different semantics than the ones you take for
> granted?

I don't think so. The choice of whether to have the irq layer or the
driver's irq handler be responsible for handling a percpu pointer has
nothing to do with the hardware.

Perhaps the intent was that the irqchip driver always knows whether a
given hwirq[-range] is associated with per-cpu events or global events
for which it doesn't matter what cpu they're delivered on. In this
case, the situations where you may want percpu dev_id mapping line up
with some property of the hardware. However that need not be the case,
and it's not when the choice of irq is programmable.

> > > Regarding Marc Zyngier comments about the irq controller driver being
> > > almost empty, I'm wondering if something in the irq controller driver
> > > which shouldn't be added before submitting this timer driver with SMP
> > > support (eg. irq domain ?).  
> > 
> > I don't think so. At most I could make the driver hard-code the percpu
> > devid model for certain irqs, but that _does not reflect_ anything
> > about the hardware. Rather it just reflects bad kernel internals. It
> 
> I'd appreciate it if instead of ranting about how broken the kernel is,
> you'd submit a patch fixing it, since you seem to have spotted
> something that we haven't in several years of using that code on a
> couple of ARM-related platforms.

I didn't intend for this to be a rant. I'm not demanding that it be
changed; I'm only objecting to being asked to make the driver use a
framework that it doesn't need and that can't model what needs to be
done. But I'm happy to discuss whether you would be open to such a
change, and if so, to write and submit a patch. The ideas for what it
would involve are in the linked email, quoted here:

   "... This is because the irq controller driver must, at irqdomain
    mapping time, decide whether to register the handler as
    handle_percpu_devid_irq (which interprets dev_id as a __percpu
    pointer and remaps it for the local cpu before invoking the
    driver's handler) or one of the other handlers that does not
    perform any percpu remapping.

    The right way for this to work would be for
    handle_irq_event_percpu to be responsible for the remapping, but
    do it conditionally on whether the irq was requested via
    request_irq or request_percpu_irq."

Do you disagree with this assessment?

Rich
