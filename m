From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 24 Aug 2016 19:01:52 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824200152.33be0707@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
        <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
        <57BDCE5D.2050609@linaro.org>
        <20160824174001.GW15995@brightrain.aerifal.cx>
In-Reply-To: <20160824174001.GW15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Wed, 24 Aug 2016 13:40:01 -0400
Rich Felker <dalias@libc.org> wrote:

[...]

> > IIUC, there is a problem with the interrupt controller where
the per irq
> > line are not working correctly. Is that correct ?  
> 
> I don't think that's a correct characterization. Rather the percpu
> infrastructure just means something completely different from what you
> would expect it to mean. It has nothing to do with the hardware but
> rather with kernel-internal choice of whether to do percpu devid
> mapping inside the irq infrastructure, and the choice at the
> irq-requester side of whether to do this is required to match the
> irqchip driver's choice. I explained this better in another email
> which I could dig up if necessary, but the essence is that
> request_percpu_irq is a misnamed and unusably broken API.

Or just one that simply doesn't fit your needs, because other
architectures have different semantics than the ones you take for
granted?

> 
> > Regarding Marc Zyngier comments about the irq controller driver being
> > almost empty, I'm wondering if something in the irq controller driver
> > which shouldn't be added before submitting this timer driver with SMP
> > support (eg. irq domain ?).  
> 
> I don't think so. At most I could make the driver hard-code the percpu
> devid model for certain irqs, but that _does not reflect_ anything
> about the hardware. Rather it just reflects bad kernel internals. It

I'd appreciate it if instead of ranting about how broken the kernel is,
you'd submit a patch fixing it, since you seem to have spotted
something that we haven't in several years of using that code on a
couple of ARM-related platforms.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
