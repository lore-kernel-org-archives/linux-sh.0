From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Jun 2015 21:34:25 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150624213425.GW1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 03:40:50AM -0500, Rob Landley wrote:
> 
> 
> On 06/24/2015 01:03 PM, Rich Felker wrote:
> > On Wed, Jun 24, 2015 at 02:12:58AM -0500, Rob Landley wrote:
> >> I've lost the plot here, is what I"m saying.
> > 
> > OK, I'll try to get us back on it then.
> > 
> > To begin with, let's put aside musl, revival of SH, and anything new
> > and just look at the existing situation.
> > 
> > Right now, SH3 or SH4-nofpu binaries are ABI-incompatible with SH4
> > kernels.
> 
> On glibc? Never tested it, all my sh4 stuff was uclibc until musl showed
> an interest.

Yes, on glibc.

> > This incompatibility is in a place very few applications are
> > going to use or care about, but it's essential for musl and it's going
> > to be essential for glibc once they get around to fixing cancellation.
> > 
> > Likewise, SH2 binaries are incompatible with SH2A kernels and SH4
> > kernels.
> 
> And nobody ever cared before because elf2flt or fdpic didn't run on
> systems _with_ an mmu, so the binary packaging format incompatability
> would hit you long before anything else did.

You missed the SH2A part. Otherwise that's largely correct.

> > Since our new SH2 binaries (using ELF, musl, and possibly glibc if the
> > port is not dropped) are also going to be compatible with running on
> > later MMU-ful hardware (e.g. J4), I don't want this same issue to be a
> > point of breakage for them.
> 
> This is the "lost the plot" part. I don't get it. What's the point? I do
> not understand why you have this as a goal.

I'll try to keep this brief since it's not the point of this thread:

- Ability to test your binaries with qemu-[system-]sh4[eb].
- Ability to test and debug on a real machine with MMU where crashes
  are debuggable and don't bring down the whole system.
- Avoiding death-by-target-combinatorics (ala uclibc).
- Upgrade path from SH2 to SH4.
- Sharing base userspace between low-end SH2 devices and higher-end
  SH4-based model.

If you want to discuss this in more detail let's do it somewhere other
than in a thread CC'd on several lists it's not terribly relevant to.

> > The userspace SH2 ABI is nofpu (no float registers for float args), so
> > there is already a separate userspace ABI for SH2 (and SH3) vs the
> > usual SH4 ABI with float. That's not a problem.
> 
> Yes, a separate ABI for sh2 vs sh4 has not, historically speaking, been
> a problem.

Separate userspace ABI is not a problem. The problem is the kernel
ABI.

> > Dynamic linked
> > binaries have their own separate shared library ecosystem, and for
> > static linked binaries, there's no userspace ABI boundary left once ld
> > runs. However kernel-user ABI breakage is a show-stopper. It means
> > that, even if you had the right ldso and libraries for nofpu SH2
> > binaries, you couldn't safely run them on SH4 because the kernel would
> > give you the wrong ucontext_t layout.
> 
> And historically used entirely different trap numbers for system calls,
> although you made a kernel patch for that. And a couple more to the
> kernel binary loader...

The trap numbers are something that can be worked around even without
my patch; it's just ugly. There's really no workaround for a type
varying at runtime, though. (The closest thing to a valid workaround
would be wrapped signal handlers, which are really ugly to implement;
glibc has considered doing them but so far held off. I don't want to
do them.)

> > If we want the SH-nofpu ABI to use the old nofpu ucontext_t layout,
> > then the kernel (and qemu-user) is going to need a way to detect
> > nofpu-ABI binaries and generate the right ucontext_t for them.
> 
> Or sh2 vs sh4 could be different compile-time targets with different
> libc instances?

They already are (assuming you use FPU on SH4; then one is using the
hard-float ABI and the other is using soft-float ABI), but that
doesn't help. The problem is the kernel ABI.

> > If we switch to using the same ucontext_t layout everywhere, the
> > kernel does not have to be smart, and the kernel ABI looks the same
> > for all SH variants, but old binaries (if they depend on ucontext_t
> > layout, which is _rare_ anyway) could break.
> 
> Old binaries can run under old kernels with old userspace partitions.

Well, not so practical if those old kernels have critical vulns...
But unless someone steps forward and says SH3 ucontext_t ABI is
important to existing applications that are deploying new kernels, I
think we can just wait to address this issue (with a personality)
if/when it ever arises.

> > My leaning at this point, especially since you say SH3 is irrelevant,
> > is to use the same ucontext_t layout for them all (with the float reg
> > space empty for nofpu chips). If any real-world old apps break and
> > people care about them, we could make a personality that you set
> > manually for old-nofpu ucontext_t layout. But I suspect the issue will
> > just go away.
> 
> I suspect the issue will just go away too.
> 
> After more patents expire next year, we can add full sh4 compatibility
> to j-core. If we want a better userspace api ala x86's x32 or mips
> o32/n32/nubi or arm's oabi/eabi, we can do that. (In fact that's one of
> 0pf.org's goals, kawasaki-san is _trying_ to run a standards body. If
> you want to wave an abi proposal at him for comment, he is the original
> superh architect...)

The SH ABI seems pretty good as-is, especially considering the
constraints it's working with. The only additional need for ABI work I
see at the moment is getting FDPIC working.

> I want musl to support sh2 but I _also_ want it to support coldfire and
> h8300 and so on. If musl is the successor to uclibc (which needs to be
> put out of its misery), it needs nommu support for several different
> architectures. If you insist that every nommu architecture must also run
> those nommu binaries on with-mmu sibling architectures, you're going to
> be unifying coldfire and m68k next...

If you look at the kernel I'm pretty sure that already works...
Coldfire does not seem to be a separate arch/ABI as far as the kernel
is concerned.

Rich
