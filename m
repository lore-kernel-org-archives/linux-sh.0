From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Jun 2015 22:02:12 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150624220212.GX1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 04:14:45AM -0500, Rob Landley wrote:
> 
> 
> On 06/24/2015 01:12 PM, Rich Felker wrote:
> > On Wed, Jun 24, 2015 at 02:10:06PM +0000, Joseph Myers wrote:
> >> On Wed, 24 Jun 2015, Rich Felker wrote:
> >>
> >>> Nominally SH3 support remains in both the kernel and glibc. If it can
> >>> be established that multiple parties agree that there's really no one
> >>> left who cares about the old no-FPU sigcontext ABI on SH3, I will be
> >>> all for dropping it and unifying sigcontext.
> >>
> >> Note that right now we have BE and LE versions of *three* ABIs for SH in 
> >> glibc (SH3 soft-float, SH4 soft-float, SH4 hard-float) (and as noted in 
> >> this discussion, right now each would only work properly on a kernel with 
> >> the corresponding configuration).  See 
> >> <https://sourceware.org/glibc/wiki/ABIList>.
> > 
> > Is your understanding that SH4 soft-float is using the SH4 ucontext_t
> > layout? I don't think it's even working at all.
> 
> I never bothered to test floating point on it. It doesn't come up much
> with anything I do, and qemu's floating point emulation is notoriously
> dicey.

Float is not what you need to test to see the breakage. Rather you
need to test inspecting the uc_sigmask member of ucontext_t. With the
mismatched ABI it's in the wrong place so the signal handler sees the
wrong set of blocked signals if it inspects them. Without this working
right, it's impossible to implement cancellation correctly.

> If I do an x86-64 linux from scratch build the perl build dies with:
> https://twitter.com/landley/status/571883794279493633
> 
> Of course it doesn't happen in a chroot or using distcc to call out to
> the cross compiler, only when gcc does those floating point calculations
> under qemu-system-x86_64. (Presumably it wouldn't happen if I was using
> kvm instead of qemu either...) Given that, trying to prove anything
> about qemu-system-sh4's floating point seemed like a waste of time.

It's likely only x86 that's broken. Nobody emulates ld80 right.

> > Glibc uses the layout
> > with fpu registers only if __SH4__ or __SH4A__ is defined,
> 
> I've never built glibc for sh4. I could try installing the old debian
> sh4 chroot? (What release was that, squiggy? I tried installing Debian's
> alpha lenny chroot yesterday and "apt-get update" in the chroot is
> failing trying to hand off the wget data to gzip. Something with pipes
> in qemu-alpha application emulation, I think. It's on the todo list.)
> 
> If you're curious, I was following the qemu-debootstrap instructions on
> https://wiki.debian.org/ArmHardFloatChroot substituting in info from
> https://www.debian.org/ports/ (hence the ping on #musl about whether
> musl debian ports would be interesting). Also there's a debian sh4 page
> at https://wiki.debian.org/SH4 so if I needed to poke at glibc for sh4,
> that would probably be my starting point.

I doubt it would help test the SH4-nofpu config that seems to be
broken; surely they use the normal SH4 ABI with fpu. You'd need a
multilib gcc with support for -m4-nofpu (or a cross compiler for it).

> > but GCC
> > does not define these macros when -m4-nofpu is used. Instead it
> > defines both __SH3__ and __SH4_NOFPU__.
> 
> I hack around that sort of thing in builds all the time. Various bits of
> gnu software only ever agree with each other (or anything else) by
> coincidence.

You _really_ don't want to change this; doing so will break anything
using the macros. There's a reason they're done the way they are. In
particular __SH4__ indicates the availability of FPU and the
associated float ABI. For example, if __SH4__ is wrongly defined here,
musl would select asm for hard-float ABI despite the compiler
generating soft-float object files, and you'd end up with
ABI-mismatched files when linking.

> > On the other hand, the kernel uses:
> > 
> > #if defined(__SH4__) || defined(CONFIG_CPU_SH4) || \
> >     defined(__SH2A__) || defined(CONFIG_CPU_SH2A) || 1
> > 
> > to determine whether to include the FPU regs in the struct.
> > CONFIG_CPU_SH4 is presumably defined whenever the kernel is built for
> > the SH4 entry point code. So I don't think it's even possible to build
> > a kernel that's compatible with glibc's SH4 soft-float.
> 
> You think this is in any way unusual?

Yes. Patches to fix minor bugs are one thing, but having to patch
public kernel API/ABI breaking changes into a system is not something
that should be treated as normal/expected. If that feels normal to
people used to working with uclibc, well, that's part of the reason
uclibc needs to be replaced.

> http://landley.net/hg/aboriginal/file/tip/sources/patches
> 
> Patching stuff to make this kind of thing match up during a build is
> _normal_. It's means you're not on x86 (or these days, arm).

I have not encountered any breakage like this on any of the other
archs we work with. Kernel stability is usually taken very seriously.
I don't see any patches in your repo above that change kernel API/ABI.

> > This seems to have been a silent ABI regression in glibc when the sh
> > sys/* sysdep headers were merged. Back when there were separate
> > versions in the sh3 and sh4 dirs, it _should_ have worked with the
> > kernel's definitions.
> 
> Embedded development 101: first time the package broke most of the
> userbase just didn't upgrade to the broken version. If they're stuck on
> 2.4 (or 2.0!) as a result, and the device wasn't connected to the
> internet, they did not care. (The sad parts are where the device IS
> connected to the internet and they _still_ don't care.)

Just because it's been that way in the past doesn't mean it's
acceptable. Embedded/IoT are disasters waiting to happen given the way
embedded development has been handled up til now. I don't claim we can
fix everyone's practices, but without addressing fundamentally broken
things like this, it's hardly possible for anyone to fix their own.

> >> I think the next glibc change likely to require action from each 
> >> architecture's maintainer to avoid breaking the build may be Adhemerval's 
> >> cancellation changes - so if no-one comes forward as SH maintainer to at 
> >> least update SH for those changes when they are ready to go in, the build 
> >> for SH will be broken and that will indicate, as per 
> >> <https://sourceware.org/ml/libc-alpha/2015-06/msg00424.html>, that it may 
> >> be time to remove the port from glibc.
> > 
> > I may be available to do the cancellation changes (it's my design, so
> > I'm familiar with the requirements), but I'll probably have to get
> > copyright assignment paperwork taken care of first.
> 
> Ah right, copyright assignment. Rich is a much better choice to do this
> then.

:-)

Rich
