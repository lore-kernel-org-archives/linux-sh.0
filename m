From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 26 May 2016 10:38:29 +0000
Subject: Re: [PATCH v3 02/12] of: add J-Core cpu bindings
Message-Id: <20160526103828.GB32186@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <39ad5c69533ef537e6ab0426efc057f9064ee581.1464148904.git.dalias@libc.org>
 <20160525102214.GF1337@leverpostej>
 <20160525230407.GT21636@brightrain.aerifal.cx>
In-Reply-To: <20160525230407.GT21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On Wed, May 25, 2016 at 07:04:08PM -0400, Rich Felker wrote:
> On Wed, May 25, 2016 at 11:22:15AM +0100, Mark Rutland wrote:
> > > +Optional properties:
> > > +
> > > +- enable-method: Required only for SMP systems. If present, must be
> > > +  "jcore,spin-table".
> > > +
> > > +
> > > +--------------------
> > > +Individual cpu nodes
> > > +--------------------
> > > +
> > > +Required properties:
> > > +
> > > +- device_type: Must be "cpu".
> > > +
> > > +- compatible: Must be "jcore,j2".
> > > +
> > > +- reg: Must be 0 on uniprocessor systems, or the sequential, zero-based
> > > +  hardware cpu id on SMP systems.
> > > +
> > > +Optional properties:
> > > +
> > > +- clock-frequency: Clock frequency of the cpu in Hz.
> > > +
> > > +- cpu-release-addr: Necessary only for secondary processors on SMP systems
> > > +  using the "jcore,spin-table" enable method. If present, must consist of
> > > +  two cells containing physical addresses. The first cell contains an
> > > +  address which, when written, unblocks the secondary cpu. The second cell
> > > +  contains an address from which the cpu will read its initial program
> > > +  counter when unblocked.
> > 
> > I take it this follows the example of the arm64 spin-table rather than
> > the ePAPR spin-table, given the lack of an ePAPR reference or struct
> > definition.
> 
> Indeed, I wasn't aware of the ePAPR spec for it. Would you prefer that
> we use a different name or something?

No, the "jcore,spin-table" name is fine.

> > From my experience with the arm64 spin-table, I would *strongly*
> > recommend that you tighten this up, and define things more thoroughly,
> > before a variety of FW/bootloader implementations appear. e.g.
> > 
> > * What initial/invalid value should the location contain? Is zero a
> >   valid address that you might want to jump a secondary CPU to?
> 
> I believe the hardware is implemented such that just the appearance of
> the address for write on the bus unblocks the secondary cpu waiting on
> it. 

Ok, so this is effectively a device register, rather than a location in
"real" memory.

> As for the address to jump to, this is provided by the kernel and,
> for Linux purposes, is always _stext. As I understand the mechanism,
> the actual initial PC for secondary cpus is in rom, and the code there
> is responsible for loading the application-desired (i.e.
> kernel-desired) initial PC and jumping to it.

Ok. Is this second address also a device register, or might this be in
"real" memory?

> > * How must the value be written?
> >   - Which endianness?
> 
> CPU native.

Ok. I take it that a CPU's endianness cannot be switched onthe fly,
then? Or does the hardware backing the release-addr register handle
arbitrary endianness dynamically?

If you want to reuse the same HW block across configurations where CPU
endianness differs, it may make sense to define an endianness
regardless, to simplify integration concerns.

> >   - With a single store? Or is there a more involved sequence to prevent
> >     the secondary CPU from seeing a torn value?
> 
> The start address is just a physical ram address (internal sram) and
> how it's written does not matter, because it's only read once the
> release write occurs.

Sure. I had initially mis-read the documentation and applied my
understanding of the arm64 spin-table sequence (which only has a single
write for both purposes).

For the actual release write are there any constraints? e.g. value, size
of access?

> > * Must CPUs have a unique cpu-release-addr? I would *strongly* recommend
> >   that they do.
> 
> There is currently no spec or implementation with more than one
> secondary cpu.

Ok. Please bear the above in mind if/when implementations with more than
two secondary CPUs are conceivable.

> >   - Is any minimal padding required around cpu-release-addrs? e.g. can
> >     FW or bootlaoder put data in the same cacheline-aligned region and
> >     exepct the OS not to corrupt this?
> 
> The word-sized memory (for J2, 32-bit) at the address is what's being
> addressed. There is no implicit license for the kernel to clobber
> other nearby data.

My concern was that if your memory system is not fully coherent, and
the CPU has a cacheable mapping of the initial program counter field, it
would need to perform a cache clean to ensure visibility of that field.
If the cache line for that region were stale, that would clobber data in
the same cache line (e.g. something owned/used by FW).

Per your comments below that doesn't matter now but may in future.

> > * How should the OS map the region (i.e. which MMU/cache attributes)?
> 
> For J2, there is no mmu. All these specs need extension for future
> models with mmu, because the properties of the mmu should be described
> in the DT.

I was going by the fact you had a binding for a cache, which I assumed
was SW configurable. If that's not the case, then my questions about
caches and MMU attributes do not apply for the timebeing.

> >   - Is the address permitted to be a device register?
> 
> I don't see a strong reason to disallow it. Do you?

So long as you can guarantee that OS does not have a cacheable mapping
of this region, and the size of the access wis well-defined, I do not
see a reason to disallow it.

> > * Where can this memory live?
> >   - Should it be abesnt from any memory node? To which padding?
> >   - Should the memory be described with a memreserve? If so, what are
> >     your architecture-specific memreserve semantics (i.e. which
> >     MMU/cache attributes are permitted for a memreserve'd region)?
> 
> If it's in the memory regions exposed by the DT to the kernel, it
> should be reserved, I think. In practice it's not.

Ok. This should be documented (as we do for the arm64 spin-table).

Perhaps that is not a major problem if the OS never pokes the release
register.

If you do /memreserve/ the region rather than carving it out of memory
nodes, you will also need to define semantics for memreserve. Typically
memreserve meaans that the OS should not perform any stores to the
region, but is permitted to map it with some architecture-specific
cacheable attributes.

> > * What state should the CPU be in when it branches to the provided
> >   address?
> >   - Must the MMU be off?
> 
> Current models are nommu.
> 
> >   - What state must any cache be in?
> >     Should FW perform any implementation defined coherency and cache
> >     management prior to branching?
> 
> The current dcache implementation is fully coherent, but we want to
> relax that If this changes the hw/fw should ensure that the secondary
> cpu being started does not see stale dcache.

Ok.

> The icache requires explicit flush so secondary should start with it
> off (as it does now) or ensure that it's flushed before jumping to
> kernel-provided start address.
> 
> >   - Must the CPU be in a particular endianness?
> 
> There are not any switchable-endian J-Core cpus. If such a thing is
> added it would make sense to describe this.
> 
> >   - Which exceptions must be masked?
> 
> In practice I think it's the same as how cpu0 starts. I suspect that's
> with everything masked, but I'm not sure right off.
> 
> >   - Are interrupts permitted to be pending?
> 
> In practice they won't be for current implementations, but I don't
> have an answer that can forsee the future.
> 
> >   - Should debug logic (e.g. breakpoint and watchpoints) be placed into
> >     a quiescent state?
> 
> This depends on having a model that has these features.
> 
> >   - Should any registers be programmed with specific values?
> 
> No, beyond perhaps things like control registers (IMASK).
> 
> > At some point, you are likely to want CPU hotplug and/or cpuidle. We
> > didn't provision the arm64 spin-table for either of these and never
> > extended it, but you may want to put in place some discoverability now
> > to allow future OSs to use that new support while allowing current OSs
> > to retain functional (e.g. not requiring a new enable-method string).
> > 
> > > +---------------------
> > > +Cache controller node
> > > +---------------------
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: Must be "jcore,cache".
> > > +
> > > +- reg: A memory range for the cache controller registers.
> > 
> > There is a well-defined memory map for the cache controller?
> > 
> > If so, please refer to documentation for it here (either in this
> > section, or the top of this document if common with other elements
> > described herein).
> 
> The current version "jcore,cache" has a single 32-bit control register
> per cpu that can be used to enable/disable/flush icache and/or dcache.
> There is no finer-grained control. If/when we do larger caches in the
> future where it makes sense, there will be a new binding for it. (For
> example it may make sense to do one that matches the original SH
> memory-mapped cache interface.)

Ok, this is simpler than I had anticipated.

> > > +--------
> > > +IPI node
> > > +--------
> > > +
> > > +Device trees for SMP systems must have an IPI node representing the mechanism
> > > +used for inter-processor interrupt generation.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: Must be "jcore,ipi-controller".
> > > +
> > > +- reg: A memory range used to IPI generation.
> > > +
> > > +- interrupts: An irq on which IPI will be received.
> > 
> > Likewise.
> 
> It's the same (actually even the same memory range, though I didn't
> see a sense in requiring that; there's also an IPI-generate bit).
> 
> > > +----------
> > > +CPUID node
> > > +----------
> > > +
> > > +Device trees for SMP systems must have a CPUID node representing the mechanism
> > > +used to identify the current processor on which execution is taking place.
> > > +
> > > +Required properties:
> > > +
> > > +- compatible: Must be "jcore,cpuid-mmio".
> > > +
> > > +- reg: A memory range containing a single 32-bit mmio register which produces
> > > +  the current cpu id (matching the "reg" property of the cpu performing the
> > > +  read) when read.
> > 
> > Likewise.
> 
> One general question I have about all of your comments -- is the DT
> binding file really supposed to amount to a hardware programming
> manual, fully specifying all of the programming interfaces? I don't
> see that in other binding files, and it feels like what you're asking
> for is beyond the scope of just specifying the bindings. 

The binding file is not intended to be a full HW description, but where
possible relevant documentation should be referred to, in case there is
some ambiguity.

My questions about SMP are largely orthogonal to DT; I simply have
experience in dealing with that for arm64, and am aware of some of the
pain points that were not immediately obvious.

> If you really do want a lot more detail for SMP-related bindings, I
> could consider submitting a version with SMP omitted for now (since
> the kernel patches submitted at this point don't include SMP) and do
> the addition of SMP as a separate patch later. But with the launch of
> open-hardware boards capable of running SMP J2 systems (see
> https://twitter.com/jcoreeng/status/730330848306700288) near, I'd like
> to be getting bindings we can use stabilized so that we're properly
> including DTB in the boot rom and not relying on external DTB files or
> linking DTB in kernel.

I would argue that the SMP bindings can be added at the same point as
the code. If there's any chance that something may change, having the
bindings in the kernel early gives a potentially misleading impression
of stability.

I assume that you have the facility to upgrade the boot ROM?

Thanks,
Mark.
