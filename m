From: Rich Felker <dalias@libc.org>
Date: Tue, 15 Sep 2015 04:28:39 +0000
Subject: Re: [PATCH v2] arch/sh: provide unified syscall trap compatible with all SH models
Message-Id: <20150915042839.GK17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150825030338.GA14922@brightrain.aerifal.cx>
 <20150825212311.GM32742@brightrain.aerifal.cx>
 <55F78DDE.9060409@landley.net>
In-Reply-To: <55F78DDE.9060409@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, shumpei.kawasaki@swhwc.com, Yoshinori Sato <ysato@users.sourceforge.jp>, jeff@uclinux.org, Geert Uytterhoeven <geert@linux-m68k.org>

On Mon, Sep 14, 2015 at 10:17:50PM -0500, Rob Landley wrote:
> On 08/25/2015 04:23 PM, Rich Felker wrote:
> > From: Rich Felker <dalias@libc.org>
> > 
> > Historically SH-2 Linux (and originally uClinux) used a syscall
> > calling convention incompatible with the established SH-3/4 Linux ABI.
> > This choice was made because the trap range used by the existing ABI,
> > 0x10-0x17, overlaps with the hardware exception/interrupt trap range
> > reserved by SH-2, and in particular, with the SH-2A divide-by-zero and
> > division-overflow exceptions.
> > 
> > Despite the documented syscall convention using the low bits of the
> > trap number to signal the number of arguments the kernel should
> > expect, no version of the kernel has ever used this information, nor
> > is it useful; all of the registers need to be saved anyway. Therefore,
> > it is possible to pick a new trap number, 0x1f, that is both supported
> > by all existing SH-3/4 kernels and unassigned as a hardware trap in
> > the SH-2 range. This makes it possible to produce SH-2 application
> > binaries that are forwards-compatible with running on SH-3/4 kernels
> > and to treat SH as a unified platform with varying ISA support levels
> > rather than multiple gratuitously-incompatible platforms.
> > 
> > This patch adjusts the range checking SH-2 and SH-2A kernels make for
> > the syscall trap to accept the range 0x1f-0x2f rather than just
> > 0x20-0x2f. As a result, trap 0x1f now acts as a syscall for all SH
> > models.
> 
> Except that sh2 is a nommu platform, requiring different binary formats.
> You can't run a standard ELF binary on sh2,

You can. It's a near-trivial patch to make it work now, though I want
to polish it more before sending it upstream.

> and sh3/4 usually don't have
> fdpic or elf loaders configured in.

The normal ELF loader loads FDPIC just fine; it just doesn't float the
data segment separately. At first it didn't work for me due to
limitations in my entry-point code, but now even qemu-sh4eb runs my
FDPIC binaries fine. Of course it would be really _nice_ to have
separately floating text/data even on systems with MMU. In theory the
code in binfmt_elf_fdpic.c supports this, but it's just not enabled in
kconfig.

> Even if you could, basic system calls like fork() don't work on a nommu
> system.

Obviously programs that need fork will not work. But the vast majority
of software does not need fork -- or if it does need it, is using it
gratuitously, and should be using posix_spawn which would give you
both major performance boosts and NOMMU support.

And of course the other direction, which is the interesting one, of
course works perfectly fine -- software that does not expect fork to
be available because it was built for NOMMU certainly does not care if
fork is available on the system it actually runs on.

> I agree it doesn't hurt anything (other than new binaries built to use
> it not running on old kernels, but that's pretty much the case for fdpic
> anyway), but what is the actual _advantage_ of this patch?

I've been over this many times, but I can summarize again. The big
points are:

- Ability to run & debug the exact same binaries you're going to
  deploy to NOMMU hardware on a much nicer system with memory
  protection, dev tools, etc. (or qemu-sh4eb).

- Establishing SH as a mature, serious platform with ISA levels and
  only minimal hard ABI splits (like endianness, hard/soft float,
  etc.) rather than having each ISA level be its own completely
  separate and incompatible platform.

Do these seem unreasonable?

Rich
