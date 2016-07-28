From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 28 Jul 2016 14:02:37 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160728140236.GC5881@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
 <20160727101235.GC12880@leverpostej>
 <20160727130606.GA15995@brightrain.aerifal.cx>
 <20160727132252.GB17195@leverpostej>
 <20160727170709.GC15995@brightrain.aerifal.cx>
 <20160727173152.GH17195@leverpostej>
 <20160727230124.GE15995@brightrain.aerifal.cx>
In-Reply-To: <20160727230124.GE15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Wed, Jul 27, 2016 at 07:01:24PM -0400, Rich Felker wrote:
> On Wed, Jul 27, 2016 at 06:31:52PM +0100, Mark Rutland wrote:

> > IIUC, that means you *could* implement per-irq masking by having the
> > CPU's mask value set to 0, and flipping the priority of an IRQ between 0
> > and 1 to disable/enable.
> > 
> > Though from your prior comments it sounds like for AIC2 writes to the
> > MMIO priority registers are ignored, so that would not work for AIC2?
> 
> Right. The register with 8 4-bit fields only made sense for the setup
> with 8 irq lines with variable priority; the aic2 has 64 lines with
> static priorities.

Thinking about this a little further, this is a good argument for the
"jcore,aic1" *not* being a valid fallback entry in an AIC2 compatible
list. Anything wanting to rely on this behaviour of AIC1 would be broken
on AIC2.

That being the case, no DT should have "jcore,aic1" for an AIC2 node,
and we can explciitly check for the AIC1 string for AIC1-specific
initialisation code (though regardless, it's worht a comment).

A further curiosity: what static priority values for AIC2 apply to
interrupts? Does it apply 0xf (or some over value) uniformly, or can
AIC2 interrupts potentially have varied priorities?

Thanks,
Mark.
