From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jul 2020 23:20:21 +0000
Subject: Re: [PATCH 3/4] sh: Add SECCOMP_FILTER
Message-Id: <77da0625-b4b3-78ca-b540-208b7889bd75@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20200722231322.419642-3-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On 7/23/20 1:13 AM, Michael Karcher wrote:
> Port sh to use the new SECCOMP_FILTER code.
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sh/Kconfig                               | 1 +
>  arch/sh/kernel/entry-common.S                 | 2 ++
>  arch/sh/kernel/ptrace_32.c                    | 5 +++--
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 8 +++++++-
>  4 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 32d959849df9..10b510c16841 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -27,6 +27,7 @@ config SUPERH
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GUP_GET_PTE_LOW_HIGH if X2TLB
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_DEBUG_BUGVERBOSE
> diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> index c4d88d61890d..ad963104d22d 100644
> --- a/arch/sh/kernel/entry-common.S
> +++ b/arch/sh/kernel/entry-common.S
> @@ -368,6 +368,8 @@ syscall_trace_entry:
>  	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
>  	jsr	@r11	    	! superior (will chomp R[0-7])
>  	 nop
> +	cmp/eq	#-1, r0
> +	bt	syscall_exit
>  	mov.l	r0, @(OFF_R0,r15)	! Save return value
>  	!			Reload R0-R4 from kernel stack, where the
>  	!   	    	    	parent may have modified them using
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 64bfb714943e..25ccfbd02bfa 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -485,8 +485,6 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  {
>  	long ret = 0;
>  
> -	secure_computing_strict(regs->regs[0]);
> -
>  	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
>  	    tracehook_report_syscall_entry(regs))
>  		/*
> @@ -496,6 +494,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
>  		 */
>  		ret = -1L;
>  
> +	if (secure_computing() = -1)
> +		return -1;
> +
>  	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
>  		trace_sys_enter(regs, regs->regs[0]);
>  
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 252140a52553..6eb21685c88f 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -122,6 +122,8 @@ struct seccomp_data {
>  #  define __NR_seccomp 358
>  # elif defined(__s390__)
>  #  define __NR_seccomp 348
> +# elif defined(__sh__)
> +#  define __NR_seccomp 372
>  # else
>  #  warning "seccomp syscall number unknown for this architecture"
>  #  define __NR_seccomp 0xffff
> @@ -1622,6 +1624,10 @@ TEST_F(TRACE_poke, getpid_runs_normally)
>  # define SYSCALL_SYSCALL_NUM regs[4]
>  # define SYSCALL_RET	regs[2]
>  # define SYSCALL_NUM_RET_SHARE_REG
> +#elif defined(__sh__)
> +# define ARCH_REGS	struct pt_regs
> +# define SYSCALL_NUM	gpr[3]
> +# define SYSCALL_RET	gpr[0]
>  #else
>  # error "Do not know how to find your architecture's registers and syscalls"
>  #endif
> @@ -1693,7 +1699,7 @@ void change_syscall(struct __test_metadata *_metadata,
>  	EXPECT_EQ(0, ret) {}
>  
>  #if defined(__x86_64__) || defined(__i386__) || defined(__powerpc__) || \
> -	defined(__s390__) || defined(__hppa__) || defined(__riscv)
> +	defined(__s390__) || defined(__hppa__) || defined(__riscv) || defined(__sh__)
>  	{
>  		regs.SYSCALL_NUM = syscall;
>  	}
> 

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
