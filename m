From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 08 May 2009 15:25:27 +0000
Subject: Re: [PATCH] Add in support for ptrace GDB defines
Message-Id: <1241796327.16311.39.camel@quercus-bis>
List-Id: <linux-sh.vger.kernel.org>
References: <1241794095.16311.28.camel@quercus-bis>
In-Reply-To: <1241794095.16311.28.camel@quercus-bis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, 2009-05-09 at 00:09 +0900, Paul Mundt wrote:
> On Fri, May 08, 2009 at 03:48:15PM +0100, Peter Griffin wrote:
> > >From 74f64c22d2d3b0082cf96ed81fe2ccd02a352441 Mon Sep 17 00:00:00 2001
> > From: Kieran Bingham <kieranbingham@gmail.com>
> > Date: Mon, 2 Mar 2009 17:05:09 +0000
> > Subject: [PATCH] Add in support for ptrace GDB defines
> > 
> > 
> > Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
> > Signed-off-by: Peter Griffin <kieranbingham@gmail.com>
> 
> Copy and paste error I suppose.
> 
> On Fri, May 08, 2009 at 03:49:50PM +0100, Peter Griffin wrote:
> > >From 0eab785eda2d1c980da7ecd59acda9f50b25ac73 Mon Sep 17 00:00:00 2001
> > From: Peter Griffin <pgriffin@mpc-data.co.uk>
> > Date: Fri, 8 May 2009 14:55:48 +0100
> > Subject: [PATCH] Fix UBC setup and registers for SH2A
> > 
> > 
> > Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
> > Signed-off-by: Peter Griffin <kieranbingham@gmail.com>
> 
> Likewise.
> 
> On Fri, May 08, 2009 at 03:50:54PM +0100, Peter Griffin wrote:
> > diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> > index f7b22dd..28aa86f 100644
> > --- a/arch/sh/kernel/ptrace_32.c
> > +++ b/arch/sh/kernel/ptrace_32.c
> > @@ -33,6 +33,7 @@
> >  #include <asm/mmu_context.h>
> >  #include <asm/syscalls.h>
> >  #include <asm/fpu.h>
> > +#include <asm/asm-offsets.h>
> >  
> >  /*
> >   * This routine will get a word off of the process kernel stack.
> 
> This seems to have snuck in from somewhere else, as nothing uses it.
> 
> > @@ -334,6 +335,14 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
> >  					[(addr - (long)&dummy->fpu) >> 2];
> >  		} else if (addr = (long) &dummy->u_fpvalid)
> >  			tmp = !!tsk_used_math(child);
> > +		else if ( addr = PT_TEXT_ADDR)
> > +			tmp = child->mm->start_code;
> > +		else if ( addr = PT_DATA_ADDR)
> > +			tmp = child->mm->start_data;
> > +		else if ( addr = PT_TEXT_END_ADDR )
> > +			tmp = child->mm->end_code;
> > +		else if ( addr = PT_TEXT_LEN )
> > +			tmp = child->mm->end_code - child->mm->start_code;
> >  		else
> >  			tmp = 0;
> >  		ret = put_user(tmp, datap);
> 
> Some weird spacing here. Please run your patches through
> scripts/checkpatch.pl before sending them to the list, it will complain
> about these sorts of trivial things so I don't have to. :-)
> 
> Anyways, most of the issues were minor, so I just tidied those up by
> hand. The series is now applied, thanks.
> 
Hi Paul,

Sorry about that, thanks for fixing it and applying.

Pete

