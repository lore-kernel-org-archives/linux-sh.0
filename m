From: Rob Landley <rob@landley.net>
Date: Tue, 15 Sep 2015 03:17:50 +0000
Subject: Re: [PATCH v2] arch/sh: provide unified syscall trap compatible with all SH models
Message-Id: <55F78DDE.9060409@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150825030338.GA14922@brightrain.aerifal.cx>
 <20150825212311.GM32742@brightrain.aerifal.cx>
In-Reply-To: <20150825212311.GM32742@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, shumpei.kawasaki@swhwc.com, Yoshinori Sato <ysato@users.sourceforge.jp>, jeff@uclinux.org, Geert Uytterhoeven <geert@linux-m68k.org>

On 08/25/2015 04:23 PM, Rich Felker wrote:
> From: Rich Felker <dalias@libc.org>
> 
> Historically SH-2 Linux (and originally uClinux) used a syscall
> calling convention incompatible with the established SH-3/4 Linux ABI.
> This choice was made because the trap range used by the existing ABI,
> 0x10-0x17, overlaps with the hardware exception/interrupt trap range
> reserved by SH-2, and in particular, with the SH-2A divide-by-zero and
> division-overflow exceptions.
> 
> Despite the documented syscall convention using the low bits of the
> trap number to signal the number of arguments the kernel should
> expect, no version of the kernel has ever used this information, nor
> is it useful; all of the registers need to be saved anyway. Therefore,
> it is possible to pick a new trap number, 0x1f, that is both supported
> by all existing SH-3/4 kernels and unassigned as a hardware trap in
> the SH-2 range. This makes it possible to produce SH-2 application
> binaries that are forwards-compatible with running on SH-3/4 kernels
> and to treat SH as a unified platform with varying ISA support levels
> rather than multiple gratuitously-incompatible platforms.
> 
> This patch adjusts the range checking SH-2 and SH-2A kernels make for
> the syscall trap to accept the range 0x1f-0x2f rather than just
> 0x20-0x2f. As a result, trap 0x1f now acts as a syscall for all SH
> models.

Except that sh2 is a nommu platform, requiring different binary formats.
You can't run a standard ELF binary on sh2, and sh3/4 usually don't have
fdpic or elf loaders configured in.

Even if you could, basic system calls like fork() don't work on a nommu
system. The workarounds for fork() not working (re-exec yourself
signaling that this is the second instance, then have main() detect the
signal and call a different entry point) are intrusive and cumbersome
enough that you generally don't want them in programs that _don't_ need
them. Therefore you historically always distinguish at build time
whether to include nommu codepaths or not. This is why uClibc doesn't
include those in nommu builds of the library, so you can easily
comple-time probe for it even when cross compiling.

(Speaking of which, I would very much like to be able to pass a NULL
exec to signal "re-exec this same program" without relying on /proc to
be mounted for /proc/self/exe, but alas the kernel can't do that.)

I agree it doesn't hurt anything (other than new binaries built to use
it not running on old kernels, but that's pretty much the case for fdpic
anyway), but what is the actual _advantage_ of this patch?

Rob
