From: Rob Landley <rob@landley.net>
Date: Wed, 24 Jun 2015 08:40:50 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <558A6D12.4010104@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On 06/24/2015 01:03 PM, Rich Felker wrote:
> On Wed, Jun 24, 2015 at 02:12:58AM -0500, Rob Landley wrote:
>> I've lost the plot here, is what I"m saying.
> 
> OK, I'll try to get us back on it then.
> 
> To begin with, let's put aside musl, revival of SH, and anything new
> and just look at the existing situation.
> 
> Right now, SH3 or SH4-nofpu binaries are ABI-incompatible with SH4
> kernels.

On glibc? Never tested it, all my sh4 stuff was uclibc until musl showed
an interest.

> This incompatibility is in a place very few applications are
> going to use or care about, but it's essential for musl and it's going
> to be essential for glibc once they get around to fixing cancellation.
> 
> Likewise, SH2 binaries are incompatible with SH2A kernels and SH4
> kernels.

And nobody ever cared before because elf2flt or fdpic didn't run on
systems _with_ an mmu, so the binary packaging format incompatability
would hit you long before anything else did.

> I can't imagine this being intentional. While the original SH2 work
> was not intended to produce binaries capable of running on later
> models, SH3 and SH4 were treated like a normal MMU-ful Linux arch,
> where it should aways be possible to run a binary built for cpu
> revision M on an actual cpu revision N, where M<=N.

Nobody cared because sh3 was supplanted by sh4 literally a year after it
came out (Hitachi had a "new processor design each year" program going
for a bit, until they figured out why that was dumb). So sh4 was already
an order of magnitude more popular than sh3 by the time Linux grew
support for sh4.

> Since our new SH2 binaries (using ELF, musl, and possibly glibc if the
> port is not dropped) are also going to be compatible with running on
> later MMU-ful hardware (e.g. J4), I don't want this same issue to be a
> point of breakage for them.

This is the "lost the plot" part. I don't get it. What's the point? I do
not understand why you have this as a goal.

> The userspace SH2 ABI is nofpu (no float registers for float args), so
> there is already a separate userspace ABI for SH2 (and SH3) vs the
> usual SH4 ABI with float. That's not a problem.

Yes, a separate ABI for sh2 vs sh4 has not, historically speaking, been
a problem.

> Dynamic linked
> binaries have their own separate shared library ecosystem, and for
> static linked binaries, there's no userspace ABI boundary left once ld
> runs. However kernel-user ABI breakage is a show-stopper. It means
> that, even if you had the right ldso and libraries for nofpu SH2
> binaries, you couldn't safely run them on SH4 because the kernel would
> give you the wrong ucontext_t layout.

And historically used entirely different trap numbers for system calls,
although you made a kernel patch for that. And a couple more to the
kernel binary loader...

> If we want the SH-nofpu ABI to use the old nofpu ucontext_t layout,
> then the kernel (and qemu-user) is going to need a way to detect
> nofpu-ABI binaries and generate the right ucontext_t for them.

Or sh2 vs sh4 could be different compile-time targets with different
libc instances?

> If we switch to using the same ucontext_t layout everywhere, the
> kernel does not have to be smart, and the kernel ABI looks the same
> for all SH variants, but old binaries (if they depend on ucontext_t
> layout, which is _rare_ anyway) could break.

Old binaries can run under old kernels with old userspace partitions.

> My leaning at this point, especially since you say SH3 is irrelevant,
> is to use the same ucontext_t layout for them all (with the float reg
> space empty for nofpu chips). If any real-world old apps break and
> people care about them, we could make a personality that you set
> manually for old-nofpu ucontext_t layout. But I suspect the issue will
> just go away.

I suspect the issue will just go away too.

After more patents expire next year, we can add full sh4 compatibility
to j-core. If we want a better userspace api ala x86's x32 or mips
o32/n32/nubi or arm's oabi/eabi, we can do that. (In fact that's one of
0pf.org's goals, kawasaki-san is _trying_ to run a standards body. If
you want to wave an abi proposal at him for comment, he is the original
superh architect...)

I want musl to support sh2 but I _also_ want it to support coldfire and
h8300 and so on. If musl is the successor to uclibc (which needs to be
put out of its misery), it needs nommu support for several different
architectures. If you insist that every nommu architecture must also run
those nommu binaries on with-mmu sibling architectures, you're going to
be unifying coldfire and m68k next...

> Rich

Rob
