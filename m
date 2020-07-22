From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jul 2020 23:20:00 +0000
Subject: Re: [PATCH 2/4] sh: Rearrange blocks in entry-common.S
Message-Id: <f9484f1b-3aee-ca1e-ce10-f3f22f636fd7@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-2-kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20200722231322.419642-2-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On 7/23/20 1:13 AM, Michael Karcher wrote:
> This avoids out-of-range jumps that get auto-replaced by the assembler
> and prepares for the changes needed to implement SECCOMP_FILTER cleanly.
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sh/kernel/entry-common.S | 57 ++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> index 9bac5bbb67f3..c4d88d61890d 100644
> --- a/arch/sh/kernel/entry-common.S
> +++ b/arch/sh/kernel/entry-common.S
> @@ -178,34 +178,6 @@ syscall_exit_work:
>  	bra	resume_userspace
>  	 nop
>  
> -	.align	2
> -syscall_trace_entry:
> -	!                     	Yes it is traced.
> -	mov     r15, r4
> -	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
> -	jsr	@r11	    	! superior (will chomp R[0-7])
> -	 nop
> -	mov.l	r0, @(OFF_R0,r15)	! Save return value
> -	!			Reload R0-R4 from kernel stack, where the
> -	!   	    	    	parent may have modified them using
> -	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
> -	!   	    	    	reloaded from the kernel stack by syscall_call
> -	!   	    	    	below, so don't need to be reloaded here.)
> -	!   	    	    	This allows the parent to rewrite system calls
> -	!   	    	    	and args on the fly.
> -	mov.l	@(OFF_R4,r15), r4   ! arg0
> -	mov.l	@(OFF_R5,r15), r5
> -	mov.l	@(OFF_R6,r15), r6
> -	mov.l	@(OFF_R7,r15), r7   ! arg3
> -	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
> -	!
> -	mov.l	6f, r10			! Number of syscalls
> -	cmp/hs	r10, r3
> -	bf	syscall_call
> -	mov	#-ENOSYS, r0
> -	bra	syscall_exit
> -	 mov.l	r0, @(OFF_R0,r15)	! Return value
> -
>  __restore_all:
>  	mov	#OFF_SR, r0
>  	mov.l	@(r0,r15), r0	! get status register
> @@ -388,6 +360,35 @@ syscall_exit:
>  	bf	syscall_exit_work
>  	bra	__restore_all
>  	 nop
> +
> +	.align	2
> +syscall_trace_entry:
> +	!                     	Yes it is traced.
> +	mov     r15, r4
> +	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
> +	jsr	@r11	    	! superior (will chomp R[0-7])
> +	 nop
> +	mov.l	r0, @(OFF_R0,r15)	! Save return value
> +	!			Reload R0-R4 from kernel stack, where the
> +	!   	    	    	parent may have modified them using
> +	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
> +	!   	    	    	reloaded from the kernel stack by syscall_call
> +	!   	    	    	below, so don't need to be reloaded here.)
> +	!   	    	    	This allows the parent to rewrite system calls
> +	!   	    	    	and args on the fly.
> +	mov.l	@(OFF_R4,r15), r4   ! arg0
> +	mov.l	@(OFF_R5,r15), r5
> +	mov.l	@(OFF_R6,r15), r6
> +	mov.l	@(OFF_R7,r15), r7   ! arg3
> +	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
> +	!
> +	mov.l	6f, r10			! Number of syscalls
> +	cmp/hs	r10, r3
> +	bf	syscall_call
> +	mov	#-ENOSYS, r0
> +	bra	syscall_exit
> +	 mov.l	r0, @(OFF_R0,r15)	! Return value
> +
>  	.align	2
>  #if !defined(CONFIG_CPU_SH2)
>  1:	.long	TRA
> 

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
