From: Rich Felker <dalias@libc.org>
Date: Thu, 23 Jun 2016 21:16:08 +0000
Subject: Re: [PATCH v3 04/12] of: add J-Core timer bindings
Message-Id: <20160623211608.GA10893@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <5341dfbb085d5647ebb6fe4390ca329b63e0e03d.1464148904.git.dalias@libc.org>
 <20160601135852.GA17217@rob-hp-laptop>
 <20160601175307.GC10893@brightrain.aerifal.cx>
 <CAL_JsqJYyvdc06v2+R=Wnmkk-cO7ZFq=7uGOhPxXdL0UfEu-iA@mail.gmail.com>
 <20160602013407.GA12184@brightrain.aerifal.cx>
 <20160602224425.GA15163@rob-hp-laptop>
In-Reply-To: <20160602224425.GA15163@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>

On Thu, Jun 02, 2016 at 05:44:25PM -0500, Rob Herring wrote:
> > > > In theory it would even be possible to just require a DT node per
> > > > cpulocal timer, but I didn't see a good way to make the bindings
> > > > represent the relationship to cpus or to make the driver handle irqs
> > > > correctly for such a setup, so I'd need a viable proposal for how that
> > > > could be done to even consider such an approach.
> > > 
> > > Yeah, there's not really a standard way to map per cpu blocks to cpus.
> > > We could, but doesn't really seem necessary here.
> > > 
> > > For the irqs, percpu irqs doesn't help you?
> > 
> > What I mean is that, if there were a separate device node and driver
> > instance per cpu, they'd all want to register the same irq just to
> > handle it on their own cpu, so we'd have a lot of spurious handlers
> > running. The right way to model this, I think, would be as a virtual
> > irqchip that's the irq parent of all the timer nodes, and that
> > multiplexes the real irq to one virq per cpu (where the current cpu id
> > becomes the irq number in its irq domain). But that's a lot of virtual
> > infrastructure just for the sake of modelling each percpu timer as its
> > own DT node and I don't think it makes sense to do it that way.
> 
> I would have thought your interrupt controller did all this. On the ARM 
> GIC for example, you have the same irq number but there is a per cpu 
> interface and really N (= # cpus) physical irq lines.

I've looked at the ARM GIC code and bindings and I don't see where the
per-cpu interrupt interfaces are modelled with multiple interrupt
controller nodes or irq domains. It looks to me like it just uses a
single interrupt controller/domain with percpu irq. Does that match
your understanding?

Rich
