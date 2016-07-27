From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Jul 2016 13:08:21 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727130821.GB15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
 <20160727101537.GD12880@leverpostej>
In-Reply-To: <20160727101537.GD12880@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Wed, Jul 27, 2016 at 11:15:38AM +0100, Mark Rutland wrote:
> On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> > For simplicity, there is no aic1-specific logic in the driver beyond
> > setting the priority register, which is necessary for interrupts to
> > work at all. Eventually aic1 will likely be phased out, but it's
> > currently in use in deployments and all released bitstream binaries.
> 
> [...]
> 
> > +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> 
> If this is only meant to run for AIC1, it would be better to check for
> the "jcore,aic1" compatible string explicitly.
> 
> While that shouldn't matter much currently, it better matches the intent
> described in the commit message, and avoids surprises and/or churn in
> future if you have AIC3+.

My intent in doing this was to support a DT that might claim an aic2
is aic1-compatible as a fallback "compatible" property. The hardware
is designed such that this works (ignoring the spurious writes to
unused prio registers) as long as the DT still has the right irq
numbers for attached devices. I'm not sure we actually need to do that
for compatibility with any existing software but I thought it better
not to preclude it.

Rich
