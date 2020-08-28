From: Rich Felker <dalias@libc.org>
Date: Fri, 28 Aug 2020 16:30:58 +0000
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
Message-Id: <20200828163057.GY3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
 <20200828155024.GX3265@brightrain.aerifal.cx>
In-Reply-To: <20200828155024.GX3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On Fri, Aug 28, 2020 at 11:50:25AM -0400, Rich Felker wrote:
> On Thu, Jul 23, 2020 at 01:13:21AM +0200, Michael Karcher wrote:
> > Port sh to use the new SECCOMP_FILTER code.
> > 
> > Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> > ---
> >  arch/sh/Kconfig                               | 1 +
> >  arch/sh/kernel/entry-common.S                 | 2 ++
> >  arch/sh/kernel/ptrace_32.c                    | 5 +++--
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 8 +++++++-
> >  4 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index 32d959849df9..10b510c16841 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -27,6 +27,7 @@ config SUPERH
> >  	select GENERIC_SMP_IDLE_THREAD
> >  	select GUP_GET_PTE_LOW_HIGH if X2TLB
> >  	select HAVE_ARCH_AUDITSYSCALL
> > +	select HAVE_ARCH_SECCOMP_FILTER
> >  	select HAVE_ARCH_KGDB
> >  	select HAVE_ARCH_TRACEHOOK
> >  	select HAVE_DEBUG_BUGVERBOSE
> > diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> > index c4d88d61890d..ad963104d22d 100644
> > --- a/arch/sh/kernel/entry-common.S
> > +++ b/arch/sh/kernel/entry-common.S
> > @@ -368,6 +368,8 @@ syscall_trace_entry:
> >  	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
> >  	jsr	@r11	    	! superior (will chomp R[0-7])
> >  	 nop
> > +	cmp/eq	#-1, r0
> > +	bt	syscall_exit
> >  	mov.l	r0, @(OFF_R0,r15)	! Save return value
> >  	!			Reload R0-R4 from kernel stack, where the
> >  	!   	    	    	parent may have modified them using
> > diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> > index 64bfb714943e..25ccfbd02bfa 100644
> > --- a/arch/sh/kernel/ptrace_32.c
> > +++ b/arch/sh/kernel/ptrace_32.c
> > @@ -485,8 +485,6 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
> >  {
> >  	long ret = 0;
> >  
> > -	secure_computing_strict(regs->regs[0]);
> > -
> >  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
> >  	    tracehook_report_syscall_entry(regs))
> >  		/*
> > @@ -496,6 +494,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
> >  		 */
> >  		ret = -1L;
> >  
> > +	if (secure_computing() = -1)
> > +		return -1;
> > +
> >  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
> >  		trace_sys_enter(regs, regs->regs[0]);
> >  
> 
> This patch broke strace - it spews out bogus syscalls and gets the
> tracee hung. I suspect the last hunk is wrong and breaks all
> non-seccomp tracing. I'll follow up with further analysis and possibly
> a fix if you don't find one sooner.

It looks like the problem is actually the hunk in entry-common.S, but
this code has been wrong since ab99c733ae in 2008: it was storing the
return value of do_syscall_trace_enter, which is supposed to replace
the syscall number and make it fail, in r0 (the 5th argument) rather
than r3 (the syscall number). This looks like the reason you put the
(apparently wrong) branch to syscall_exit in there -- the existing
code was not actually causing ENOSYS when do_syscall_trace_enter tried
to replace nr with -1, because the -1 was put in the wrong place.

I'm guessing something in syscall_exit assumes the registers have been
reloaded (the code skipped by your branch) and blows up when they
haven't.

I think the right change is going to be something like replacing 
mov.l r0, @(OFF_R0,r15) with mov r0, r3 and getting rid of the r3
reload below. do_syscall_trace_enter should also be returning
regs->regs[3] in the success case, not regs->regs[0] as it's doing, at
least if it's to match other archs (that return the original syscall
number on success). In any case, returning the 5th argument register
is nonsense.

I'm about to test a patch along these lines and will report what I
find.

Rich
