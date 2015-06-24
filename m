From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Jun 2015 18:03:01 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150624180301.GT1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 02:12:58AM -0500, Rob Landley wrote:
> I've lost the plot here, is what I"m saying.

OK, I'll try to get us back on it then.

To begin with, let's put aside musl, revival of SH, and anything new
and just look at the existing situation.

Right now, SH3 or SH4-nofpu binaries are ABI-incompatible with SH4
kernels. This incompatibility is in a place very few applications are
going to use or care about, but it's essential for musl and it's going
to be essential for glibc once they get around to fixing cancellation.

Likewise, SH2 binaries are incompatible with SH2A kernels and SH4
kernels.

I can't imagine this being intentional. While the original SH2 work
was not intended to produce binaries capable of running on later
models, SH3 and SH4 were treated like a normal MMU-ful Linux arch,
where it should aways be possible to run a binary built for cpu
revision M on an actual cpu revision N, where M<=N.

Since our new SH2 binaries (using ELF, musl, and possibly glibc if the
port is not dropped) are also going to be compatible with running on
later MMU-ful hardware (e.g. J4), I don't want this same issue to be a
point of breakage for them.

The userspace SH2 ABI is nofpu (no float registers for float args), so
there is already a separate userspace ABI for SH2 (and SH3) vs the
usual SH4 ABI with float. That's not a problem. Dynamic linked
binaries have their own separate shared library ecosystem, and for
static linked binaries, there's no userspace ABI boundary left once ld
runs. However kernel-user ABI breakage is a show-stopper. It means
that, even if you had the right ldso and libraries for nofpu SH2
binaries, you couldn't safely run them on SH4 because the kernel would
give you the wrong ucontext_t layout.

If we want the SH-nofpu ABI to use the old nofpu ucontext_t layout,
then the kernel (and qemu-user) is going to need a way to detect
nofpu-ABI binaries and generate the right ucontext_t for them.

If we switch to using the same ucontext_t layout everywhere, the
kernel does not have to be smart, and the kernel ABI looks the same
for all SH variants, but old binaries (if they depend on ucontext_t
layout, which is _rare_ anyway) could break.

My leaning at this point, especially since you say SH3 is irrelevant,
is to use the same ucontext_t layout for them all (with the float reg
space empty for nofpu chips). If any real-world old apps break and
people care about them, we could make a personality that you set
manually for old-nofpu ucontext_t layout. But I suspect the issue will
just go away.

Rich
