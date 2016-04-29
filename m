From: Rich Felker <dalias@libc.org>
Date: Fri, 29 Apr 2016 23:44:15 +0000
Subject: Re: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <20160429234415.GF21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
In-Reply-To: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 29, 2016 at 03:56:32AM -0500, Rob Landley wrote:
> J2 has a stable instruction set based on sh2 plus 2 backported sh3
> barrel shift instructions and one added cmpxchg instruction. Other than
> the cmpxchg (which was added last year when we started adding SMP
> support) it's been stable for a couple years now. We're pondering a run
> of ASICs, which sets it in stone, and don't expect any instruction set
> changes between now and then. (That'll probably be our next kickstarter
> after the turtle boards.)
> 
> Just today Jeff, Jen,and myself were researching the j3 roadmap. The sh3
> patents expired in december, and we're thinking of implementing it
> sometime in 2017.
> 
> The big new features sh3 (and sh3e) added are MMU, FPU, and DSP.
> 
> We're _not_ doing the DSP. (We have a better one of our own in the works
> already, using a completely different instruction set. The sh3 DSP and
> FPU instructions overlap anyway, let's just not go there.)
> 
> As for FPU: SH3 had 32 bit, SH4 had 64 bit, but we might just implement
> both sizes at the same time in j3 since it's IEEE standard format and C
> has "float" and "double". Not sure yet. If not, 64 bit would be in J4,
> but we'll probably do both because IEEE-754 was published in 1985 so
> it's out of patent regardless of the rest of superh.

I think adding both at the same time is the right solution. Having
float but not double in hardware is clunky, and the only way gcc
supports this right now is by redefining double as an alias for float
rather than doing double with soft-fp code, which utterly breaks
software that expects IEEE double. We could teach gcc to do the right
thing, but that seems like wasted effort when we could instead spend
that effort making the hardware behave right.

> The MMU is what most people will notice, so yes we're doing that. The
> j-core j3 instruction set should give you a stock with-mmu Linux system.
> 
> There are only three new nonprivileged instructions: clrs and sets to
> clear/set the S bit in the status register, and prefetch (which we might
> just NOP because we do our own prefetch and the cache is only 8k each
> for instruction and data). The rest are privileged instructions, so if
> we decide to fiddle with them we'd just have to make sure the kernel
> (and qemu) got updated to match. Userspace can avoid caring.

Indeed.

> sh3 added 4 instructions each to load/set the SSR, SPC,and  Rn_BANK
> registers. The first two are for "supervisor mode" which is necessary to
> make the mmu privileged, the third is a register bank switching thing
> sh3 did that may not actually be a good idea. (Rich, opinions?) We can
> skip that (make it trap) if we decide it's a bad idea...

Without the bank registers the kernel entrypoint from userspace would
have to be redesigned I think. Unlike on nommu where some saved state
just gets thrown on the userspace stack at trap time, in order for the
mmu to actually provide protection guarantees you need to be able to
save and restore userspace register state without using storage that's
under userspace control. Register banks make that easy and efficient,
and the current sh3/sh4 entry.S depend on them.

> It also added "ldtbl" to load the translation lookaside buffer, which
> Jeff is unhappy about (pointing out there isn't an instruction to load
> the CPU cache; he doesn't like having mmu policy in the cpu), but we're
> still looking into that part. We might do the MMU in a slightly
> different way. (In a coprocessor. He says "The good thing about all this
> is we get clean stuff up and do it the way it should have been done.")

From the SH-4 docs I've seen, the TLB is both memory-mapped (in a zone
that's not subject to MMU mappings; note that these fixed zones
unfortunately limit the amount of memory you can map) and accessible
in a primitive way through the ldtbl instruction. So you could get by
without the insn and otherwise be compatible, I think.

However, if part of the long-term goal for j4 is being able to serve
as a drop-in replacement for sh4, it might make sense not to diverge
gratuitously -- at least to keep the design sufficiently close that
someone could hook up ldtbl to behave like on a legacy sh4 if they
wanted to.

Rich
