From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Jun 2015 18:12:35 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150624181235.GU1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 02:10:06PM +0000, Joseph Myers wrote:
> On Wed, 24 Jun 2015, Rich Felker wrote:
> 
> > Nominally SH3 support remains in both the kernel and glibc. If it can
> > be established that multiple parties agree that there's really no one
> > left who cares about the old no-FPU sigcontext ABI on SH3, I will be
> > all for dropping it and unifying sigcontext.
> 
> Note that right now we have BE and LE versions of *three* ABIs for SH in 
> glibc (SH3 soft-float, SH4 soft-float, SH4 hard-float) (and as noted in 
> this discussion, right now each would only work properly on a kernel with 
> the corresponding configuration).  See 
> <https://sourceware.org/glibc/wiki/ABIList>.

Is your understanding that SH4 soft-float is using the SH4 ucontext_t
layout? I don't think it's even working at all. Glibc uses the layout
with fpu registers only if __SH4__ or __SH4A__ is defined, but GCC
does not define these macros when -m4-nofpu is used. Instead it
defines both __SH3__ and __SH4_NOFPU__. On the other hand, the kernel
uses:

#if defined(__SH4__) || defined(CONFIG_CPU_SH4) || \
    defined(__SH2A__) || defined(CONFIG_CPU_SH2A) || 1

to determine whether to include the FPU regs in the struct.
CONFIG_CPU_SH4 is presumably defined whenever the kernel is built for
the SH4 entry point code. So I don't think it's even possible to build
a kernel that's compatible with glibc's SH4 soft-float.

This seems to have been a silent ABI regression in glibc when the sh
sys/* sysdep headers were merged. Back when there were separate
versions in the sh3 and sh4 dirs, it _should_ have worked with the
kernel's definitions.

I think this level of breakage (that nobody seems to have noticed or
cared about) is sufficient to say let's just throw out the old no-fpu
ucontext_t and use the same struct everywhere for now. We can always
add a personality to get the old one back if anyone ever needs it.

> I think the next glibc change likely to require action from each 
> architecture's maintainer to avoid breaking the build may be Adhemerval's 
> cancellation changes - so if no-one comes forward as SH maintainer to at 
> least update SH for those changes when they are ready to go in, the build 
> for SH will be broken and that will indicate, as per 
> <https://sourceware.org/ml/libc-alpha/2015-06/msg00424.html>, that it may 
> be time to remove the port from glibc.

I may be available to do the cancellation changes (it's my design, so
I'm familiar with the requirements), but I'll probably have to get
copyright assignment paperwork taken care of first.

Rich
