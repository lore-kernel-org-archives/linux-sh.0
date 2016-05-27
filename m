From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 27 May 2016 09:13:59 +0000
Subject: Re: [PATCH v3 02/12] of: add J-Core cpu bindings
Message-Id: <20160527091359.GA24469@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <39ad5c69533ef537e6ab0426efc057f9064ee581.1464148904.git.dalias@libc.org>
 <20160525102214.GF1337@leverpostej>
 <20160525230407.GT21636@brightrain.aerifal.cx>
 <20160526103828.GB32186@leverpostej>
 <20160526153323.GX21636@brightrain.aerifal.cx>
In-Reply-To: <20160526153323.GX21636-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

On Thu, May 26, 2016 at 11:33:23AM -0400, Rich Felker wrote:
> On Thu, May 26, 2016 at 11:38:29AM +0100, Mark Rutland wrote:
> > On Wed, May 25, 2016 at 07:04:08PM -0400, Rich Felker wrote:
> > > On Wed, May 25, 2016 at 11:22:15AM +0100, Mark Rutland wrote:
> > > > * How must the value be written?
> > > >   - Which endianness?
> > > 
> > > CPU native.
> > 
> > Ok. I take it that a CPU's endianness cannot be switched onthe fly,
> > then? Or does the hardware backing the release-addr register handle
> > arbitrary endianness dynamically?
> 
> No, it's not switched on the fly.
> 
> > If you want to reuse the same HW block across configurations where CPU
> > endianness differs, it may make sense to define an endianness
> > regardless, to simplify integration concerns.
> 
> The existing cpus are all big-endian, but I believe at one point there
> was talk that it's easy to get a little-endian version if you want. In
> any case the value is to be read by the cpu, so cpu endianness (i.e.
> no endianness, just a value) is the only thing that makes sense to
> specify. Adding a fixed endian spec independent of cpu endianness just
> complicates both hardware and kernel implementation and its only
> benefit seems to be supporting runtime-switchable chips where the
> entry-point code has to select the endianness to match the rest of the
> kernel.

Sure. If endianness isn't runtime switchable, and there is no near-term
plan to add that, then my concerns do not apply.

[...]

> > If you do /memreserve/ the region rather than carving it out of memory
> > nodes, you will also need to define semantics for memreserve. Typically
> > memreserve meaans that the OS should not perform any stores to the
> > region, but is permitted to map it with some architecture-specific
> > cacheable attributes.
> 
> My interpretation of memreserve is just that it marks memory ranges
> that the kernel cannot use for allocatable memory for its own
> purposes, despite otherwise possibly lying in the range of a "memory"
> node. I would not interpret it as excluding accesses by drivers that
> were told to use specific addresses in the "reserved" range as part of
> their DT bindings.

Yes, this is strictly more correct than my wording.

Given the lack of MMU or cache configration beynd on/off, it doesn't
sound like there are any arch-specific memory attribute rules to
document.

[...]

> > My questions about SMP are largely orthogonal to DT; I simply have
> > experience in dealing with that for arm64, and am aware of some of the
> > pain points that were not immediately obvious.
> 
> OK, thanks for clarifying that. This is actually really helpful
> feedback to have but I wasn't sure if you wanted me to consider it
> part of what needs to be done for DT binding or for consideration in
> designing and documenting the SMP architecture.

Sorry for that; in retrospect I probably should have sent the boot
protocol comments as a separate reply.

[...]

> OK. I'll strip it down to just the parts that are relevant for non-SMP
> and submit the patch adding SMP bindings along with the SMP kernel
> patches.

That sounds good to me.

Thanks,
Mark,
