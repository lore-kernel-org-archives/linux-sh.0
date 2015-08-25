From: Rich Felker <dalias@libc.org>
Date: Tue, 25 Aug 2015 07:22:46 +0000
Subject: Re: [PATCH] arch/sh: provide unified syscall trap compatible with all SH models
Message-Id: <20150825072246.GG32742@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150825030338.GA14922@brightrain.aerifal.cx>
 <CAMuHMdV3mEVY69NqZ9165vp3tVhQdqJzNkJ9_hNiJrGe_JDH8g@mail.gmail.com>
In-Reply-To: <CAMuHMdV3mEVY69NqZ9165vp3tVhQdqJzNkJ9_hNiJrGe_JDH8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, shumpei.kawasaki@swhwc.com, Yoshinori Sato <ysato@users.sourceforge.jp>, jeff@uclinux.org

On Tue, Aug 25, 2015 at 09:18:44AM +0200, Geert Uytterhoeven wrote:
> Hi Rich,
> 
> On Tue, Aug 25, 2015 at 5:03 AM, Rich Felker <dalias@libc.org> wrote:
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
> >
> > Signed-off-by: Rich Felker <dalias@libc.org>
> 
> > --- ../linux-4.2-rc6.orig/arch/sh/kernel/entry-common.S 2015-08-09 19:54:30.000000000 +0000
> > +++ ./arch/sh/kernel/entry-common.S     2015-08-24 03:33:50.062683702 +0000
> > @@ -268,19 +268,20 @@ debug_trap:
> >   *     Syscall #: R3
> >   *     Arguments #0 to #3: R4--R7
> >   *     Arguments #4 to #6: R0, R1, R2
> > - *     TRA: (number of arguments + ABI revision) x 4
> > + *     TRA>>2: 0x1f, or one of a model-specific set of legacy values:
> >   *
> > - * This code also handles delegating other traps to the BIOS/gdb stub
> > - * according to:
> > - *
> > - * Trap number
> >   * (TRA>>2)    Purpose
> >   * --------    -------
> >   * 0x00-0x0f   original SH-3/4 syscall ABI (not in general use).
> >   * 0x10-0x1f   general SH-3/4 syscall ABI.
> > - * 0x20-0x2f   syscall ABI for SH-2 parts.
> > - * 0x30-0x3f   debug traps used by the kernel.
> > - * 0x40-0xff   Not supported by all parts, so left unhandled.
> 
> Why did you remoe the two lines of documentation above?

It was an unintended side-effect of restructuring the table to be a
list of legacy values. While the actual functional work of this patch
was done months ago, I just noticed that the comments should be
changed yesterday while preparing the patch for submission. I can
rework them to avoid dropping the useful information.

Thanks for the quick initial review!

Rich
