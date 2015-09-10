From: Nick Clifton <nickc@redhat.com>
Date: Thu, 10 Sep 2015 11:57:09 +0000
Subject: Re: SH FDPIC ABI spec/binutils and kernel conflict on flag definitions
Message-Id: <55F17015.8090207@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150910033400.GM17773@brightrain.aerifal.cx>
In-Reply-To: <20150910033400.GM17773@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

> In the ELF Header part of the SH FDPIC ABI document, it's stated that
> EF_SH_FDPIC|EF_SH_PIC means each LOAD segment can be independently
> positioned, while EF_SH_FDPIC by itself (without EF_SH_PIC) means the
> relative position of LOAD segments with respect to each other is fixed
> (like in normal ELF usage). This seems to match what binutils outputs.
>
> However the kernel contains the code (arch/sh/include/asm/elf.h):
>
> #define elf_check_const_displacement(x) ((x)->e_flags & EF_SH_PIC)
>
> and (fs/binfmt_elf_fdpic.c):
>
> 	if (elf_check_const_displacement(&exec_params.hdr))
> 		exec_params.flags |= ELF_FDPIC_FLAG_CONSTDISP;
>
> which does exactly the opposite: the presence of the EF_SH_PIC flag,
> rather than absence of it, causes the kernel to treat the binary as
> one requiring "constant displacement" between LOAD segments.
>
> If my analysis is correct, how should this be fixed? It seems to me
> the kernel is clearly wrong, but it might also be considered the de
> facto ABI.

I think that adopting the kernel's behaviour as correct would set a 
dangerous precedent.  A published ABI should be followed, and if the 
kernel does not implement it, then the kernel is wrong.

> Is there any way forward that allows fixing this bug (which
> defeats the whole purpose of FDPIC) without breaking existing usage?

Maybe a kernel tuning option ?  (I am not familiar with kernel 
development so maybe this idea is a non-starter).

> Or is there no existing usage to care about?

I could not say for sure, but I imagine that there must be at least some 
people who are using SH linux at the moment.

Cheers
   Nick

