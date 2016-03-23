From: Rich Felker <dalias@libc.org>
Date: Wed, 23 Mar 2016 16:41:06 +0000
Subject: Re: Fixing SH cache assumptions
Message-Id: <20160323164106.GN21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160322211905.GA11781@brightrain.aerifal.cx>
In-Reply-To: <20160322211905.GA11781@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 23, 2016 at 12:08:51AM -0500, Rob Landley wrote:
> On 03/22/2016 04:19 PM, Rich Felker wrote:
> > Currently arch/sh has a hard-coded assumption that the cache is
> > virtually indexed (and virtually tagged, from what I can tell), and
> > thus needs to account for pages that may alias. While this is correct
> > for SH3/4, it's wrong for anything NOMMU (since there are no virtual
> > addresses, only physical) and the only reason SH2 works at all is
> > because its small cache size (256 lines * 16 bytes per line) matches
> > the page size, yielding an alias_mask of 0. If the cache were any
> > larger (like it is on J2) then the alias avoidance logic would kick in
> > and lead to calling kmap_coherent (which is BUG() on NOMMU) and
> > possibly other incorrect or suboptimal behavior.
> > 
> > I've avoided the issue so far on J2 simply by lying that the cache is
> > small, but this needs a proper fix. It would be easy to just #ifndef
> > out the logic that sets up alias_mask and shm_align_mask on NOMMU, but
> > I think it would be better to somehow represent the cache indexing in
> > the cache_info struct or elsewhere. In case the future J4 has a
> > physically indexed cache (which is my hope), such an approach should
> > naturally work for it with no further modifications.
> 
> Wikipedia[citation needed] is under the impression that physically
> indexed caches are not a happy thing on systems with MMU:
> 
> https://en.wikipedia.org/wiki/CPU_cache#Address_translation
> 
> (I so want search anchors. Instead of #Address_translation, if I could
> add $PIPT it could jump you right where you needed to go. But no,
> mozilla never did that and chrome apparently hasn't thought of it.)

The information there is kind of, well, "dated" IMO. Most modern
systems (esp. x86 and ARM) with MMU use PIPT caches, because the
disadvantages of virtual indexing are pretty big:

- Without ASIDs, you have to flush the TLB at every context switch.
  ASIDs partly solve this problem but have limitations/problems of
  their own.

- With virtual tagging and indexing, memory that's mapped into
  multiple processes, like shared libraries, will get cached multiple
  times, unless it's mapped at the same location or the same location,
  which is hard to guarantee and precludes ASLR.

- With physical tagging and virtual indexing, the problem isn't quite
  as bad, but to ensure the same physical memory doesn't get cached
  multiple times (waste for RO memory, breaks coherency for RW memory)
  you have to use alignment larger (possibly much larger) than the
  page size; this is the page aliasing avoidance I was talking about.

I'm not an expert on the hardware side of things, but my understanding
is that implementing fast PIPT cache is a solved problem and shouldn't
really require anything more than a low-latency MMU.

Also, in order for your MMU to allow arbitrary mappings, rather than
having certain virtual ranges (like SH P0/P1/P2/P3/P4 zones) with
special meanings, then I don't see how you can save latency by using
virtual indexing instead of physical, since it's not determined
whether an address is cacheable until after the MMU resolves what it
maps to.

> This sounds like something nommu systems do. Are any other nommu systems
> currently device tree enabled? (Blackfish? Coldfire? Is any of the
> Cortex-M stuff actually merged in-tree yet?)

On a NOMMU system there's no such thing as a virtual/physical
distinction. Virtual addresses "are" (or map linearly to) physical
addresses and there's no multiple-mapping of the same memory at
different virtual pages.

> > Any preferences for how I do this? Just add a type field to cache_info
> > and make the default VIVT for existing models?
> 
> It sounds like a device tree issue. How would you represent it there?

Even if the value for the property comes from the DT, it needs to be
stored in the kernel's data structures at runtime; that's what I was
asking about. But this is another good question. For legacy SH
cpus/socs, should the cache properties be implied by the cpu node's
"compatible" string, or should we require the DT provide them all? I
think "renesas,sh4-* cpu has VIPT cache" is a fairly reasonable
assumption to go in the kernel's handling of the cpu type, while sizes
(which might vary by subtype/soc?) _could_ go in the DT, but I think
they're actually detectable (and currently detected) via probing the
sh4 cache controller registers, and probing should probably be
preferred over DT-provided values. On the other hand, for J2 where the
cache could easily be changed or swapped out independently of the cpu,
it makes sense for all the properties to come from the DT.

BTW this document looks helpful explaining SH4 cache architecture:

http://www.stlinux.com/node/512

Rich
