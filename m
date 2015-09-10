From: Rich Felker <dalias@libc.org>
Date: Thu, 10 Sep 2015 14:58:09 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <20150910145808.GN17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 10, 2015 at 12:57:09PM +0100, Nick Clifton wrote:
> Hi Rich,
> 
> >In the ELF Header part of the SH FDPIC ABI document, it's stated that
> >EF_SH_FDPIC|EF_SH_PIC means each LOAD segment can be independently
> >positioned, while EF_SH_FDPIC by itself (without EF_SH_PIC) means the
> >relative position of LOAD segments with respect to each other is fixed
> >(like in normal ELF usage). This seems to match what binutils outputs.
> >
> >However the kernel contains the code (arch/sh/include/asm/elf.h):
> >
> >#define elf_check_const_displacement(x) ((x)->e_flags & EF_SH_PIC)
> >
> >and (fs/binfmt_elf_fdpic.c):
> >
> >	if (elf_check_const_displacement(&exec_params.hdr))
> >		exec_params.flags |= ELF_FDPIC_FLAG_CONSTDISP;
> >
> >which does exactly the opposite: the presence of the EF_SH_PIC flag,
> >rather than absence of it, causes the kernel to treat the binary as
> >one requiring "constant displacement" between LOAD segments.
> >
> >If my analysis is correct, how should this be fixed? It seems to me
> >the kernel is clearly wrong, but it might also be considered the de
> >facto ABI.
> 
> I think that adopting the kernel's behaviour as correct would set a
> dangerous precedent.  A published ABI should be followed, and if the
> kernel does not implement it, then the kernel is wrong.

I tend to agree. However it also seems to be backwards for FRV and
Blackfin which makes me really curious and confused about what's going
on, since these are archs where FDPIC is actually in widespread use.
I've Cc'd their maintainers in case they know anything about the
issue.

> >Is there any way forward that allows fixing this bug (which
> >defeats the whole purpose of FDPIC) without breaking existing usage?
> 
> Maybe a kernel tuning option ?  (I am not familiar with kernel
> development so maybe this idea is a non-starter).

Actually I don't think anything would break. Right now the kernel
flips the meaning of the bit, so:

- Miscompiled/mislinked "FDPIC" programs which need to run with
  constant displacement actually don't get loaded with constant
  displacement by the kernel, so they're already not working.
  Presumably no such binaries exist since no one could run them
  without fixing this bug.

- Real FDPIC programs that want to run with variable displacement and
  text sharing are not getting it right now, but they _work_ anyway
  because, aside from massive resource inefficiency, constant
  displacement is just a special case of variable displacement. Thus,
  fixing the bug would just make them work as intended.

But I'm rather shocked that such an inconsistency could persist for so
long and doubting my own reading/analysis.

> >Or is there no existing usage to care about?
> 
> I could not say for sure, but I imagine that there must be at least
> some people who are using SH linux at the moment.

For SH, it only affects SH FDPIC users. Upstream gcc lacks support for
FDPIC on SH, so anyone using it is using the 2010 patch for gcc 4.5,
or some private gcc fork it's been applied to. It's not surprising at
all if this is broken, but it's hard to believe it's broken on the
other affected archs.

Rich
