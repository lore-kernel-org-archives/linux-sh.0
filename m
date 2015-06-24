From: Rob Landley <rob@landley.net>
Date: Wed, 24 Jun 2015 09:14:45 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <558A7505.6020503@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On 06/24/2015 01:12 PM, Rich Felker wrote:
> On Wed, Jun 24, 2015 at 02:10:06PM +0000, Joseph Myers wrote:
>> On Wed, 24 Jun 2015, Rich Felker wrote:
>>
>>> Nominally SH3 support remains in both the kernel and glibc. If it can
>>> be established that multiple parties agree that there's really no one
>>> left who cares about the old no-FPU sigcontext ABI on SH3, I will be
>>> all for dropping it and unifying sigcontext.
>>
>> Note that right now we have BE and LE versions of *three* ABIs for SH in 
>> glibc (SH3 soft-float, SH4 soft-float, SH4 hard-float) (and as noted in 
>> this discussion, right now each would only work properly on a kernel with 
>> the corresponding configuration).  See 
>> <https://sourceware.org/glibc/wiki/ABIList>.
> 
> Is your understanding that SH4 soft-float is using the SH4 ucontext_t
> layout? I don't think it's even working at all.

I never bothered to test floating point on it. It doesn't come up much
with anything I do, and qemu's floating point emulation is notoriously
dicey.

If I do an x86-64 linux from scratch build the perl build dies with:
https://twitter.com/landley/status/571883794279493633

Of course it doesn't happen in a chroot or using distcc to call out to
the cross compiler, only when gcc does those floating point calculations
under qemu-system-x86_64. (Presumably it wouldn't happen if I was using
kvm instead of qemu either...) Given that, trying to prove anything
about qemu-system-sh4's floating point seemed like a waste of time.

> Glibc uses the layout
> with fpu registers only if __SH4__ or __SH4A__ is defined,

I've never built glibc for sh4. I could try installing the old debian
sh4 chroot? (What release was that, squiggy? I tried installing Debian's
alpha lenny chroot yesterday and "apt-get update" in the chroot is
failing trying to hand off the wget data to gzip. Something with pipes
in qemu-alpha application emulation, I think. It's on the todo list.)

If you're curious, I was following the qemu-debootstrap instructions on
https://wiki.debian.org/ArmHardFloatChroot substituting in info from
https://www.debian.org/ports/ (hence the ping on #musl about whether
musl debian ports would be interesting). Also there's a debian sh4 page
at https://wiki.debian.org/SH4 so if I needed to poke at glibc for sh4,
that would probably be my starting point.

> but GCC
> does not define these macros when -m4-nofpu is used. Instead it
> defines both __SH3__ and __SH4_NOFPU__.

I hack around that sort of thing in builds all the time. Various bits of
gnu software only ever agree with each other (or anything else) by
coincidence.

> On the other hand, the kernel uses:
> 
> #if defined(__SH4__) || defined(CONFIG_CPU_SH4) || \
>     defined(__SH2A__) || defined(CONFIG_CPU_SH2A) || 1
> 
> to determine whether to include the FPU regs in the struct.
> CONFIG_CPU_SH4 is presumably defined whenever the kernel is built for
> the SH4 entry point code. So I don't think it's even possible to build
> a kernel that's compatible with glibc's SH4 soft-float.

You think this is in any way unusual?

http://landley.net/hg/aboriginal/file/tip/sources/patches

Patching stuff to make this kind of thing match up during a build is
_normal_. It's means you're not on x86 (or these days, arm).

> This seems to have been a silent ABI regression in glibc when the sh
> sys/* sysdep headers were merged. Back when there were separate
> versions in the sh3 and sh4 dirs, it _should_ have worked with the
> kernel's definitions.

Embedded development 101: first time the package broke most of the
userbase just didn't upgrade to the broken version. If they're stuck on
2.4 (or 2.0!) as a result, and the device wasn't connected to the
internet, they did not care. (The sad parts are where the device IS
connected to the internet and they _still_ don't care.)

> I think this level of breakage (that nobody seems to have noticed or
> cared about) is sufficient to say let's just throw out the old no-fpu
> ucontext_t and use the same struct everywhere for now. We can always
> add a personality to get the old one back if anyone ever needs it.

Seriously, the person you should be talking to is either Jeff (founder
of uclinux.org) or Kawasaki-san (original superh architect). I can
forward questions to 'em, but we've established than I'm a very
inefficient intermediary. :)

>> I think the next glibc change likely to require action from each 
>> architecture's maintainer to avoid breaking the build may be Adhemerval's 
>> cancellation changes - so if no-one comes forward as SH maintainer to at 
>> least update SH for those changes when they are ready to go in, the build 
>> for SH will be broken and that will indicate, as per 
>> <https://sourceware.org/ml/libc-alpha/2015-06/msg00424.html>, that it may 
>> be time to remove the port from glibc.
> 
> I may be available to do the cancellation changes (it's my design, so
> I'm familiar with the requirements), but I'll probably have to get
> copyright assignment paperwork taken care of first.

Ah right, copyright assignment. Rich is a much better choice to do this
then.

> Rich

Rob
