From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 27 Jul 2016 13:27:54 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727132753.GC17195@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
 <20160727101537.GD12880@leverpostej>
 <20160727130821.GB15995@brightrain.aerifal.cx>
In-Reply-To: <20160727130821.GB15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jul 27, 2016 at 09:08:21AM -0400, Rich Felker wrote:
> On Wed, Jul 27, 2016 at 11:15:38AM +0100, Mark Rutland wrote:
> > On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> > > For simplicity, there is no aic1-specific logic in the driver beyond
> > > setting the priority register, which is necessary for interrupts to
> > > work at all. Eventually aic1 will likely be phased out, but it's
> > > currently in use in deployments and all released bitstream binaries.
> > 
> > [...]
> > 
> > > +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> > 
> > If this is only meant to run for AIC1, it would be better to check for
> > the "jcore,aic1" compatible string explicitly.
> > 
> > While that shouldn't matter much currently, it better matches the intent
> > described in the commit message, and avoids surprises and/or churn in
> > future if you have AIC3+.
> 
> My intent in doing this was to support a DT that might claim an aic2
> is aic1-compatible as a fallback "compatible" property. The hardware
> is designed such that this works (ignoring the spurious writes to
> unused prio registers) as long as the DT still has the right irq
> numbers for attached devices.

Ok.

If the HW ignores it, what's the cost of those one-off spurious writes?
If it's not noticeable, you could allow the kernel to perform them
regardless.

Otherwise, please add a comment above the check, explaining why we do
the check this way around.

Thanks,
Mark.
