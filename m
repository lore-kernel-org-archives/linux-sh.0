From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jul 2020 23:19:46 +0000
Subject: Re: [PATCH 1/4] sh: Fix validation of system call number
Message-Id: <75601e2c-6631-8a98-36a0-ef58f28e50a9@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On 7/23/20 1:13 AM, Michael Karcher wrote:
> The slow path for traced system call entries accessed a wrong memory
> location to get the number of the maximum allowed system call number.
> Renumber the numbered "local" label for the correct location to avoid
> collisions with actual local labels.
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sh/kernel/entry-common.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
> index 956a7a03b0c8..9bac5bbb67f3 100644
> --- a/arch/sh/kernel/entry-common.S
> +++ b/arch/sh/kernel/entry-common.S
> @@ -199,7 +199,7 @@ syscall_trace_entry:
>  	mov.l	@(OFF_R7,r15), r7   ! arg3
>  	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
>  	!
> -	mov.l	2f, r10			! Number of syscalls
> +	mov.l	6f, r10			! Number of syscalls
>  	cmp/hs	r10, r3
>  	bf	syscall_call
>  	mov	#-ENOSYS, r0
> @@ -353,7 +353,7 @@ ENTRY(system_call)
>  	tst	r9, r8
>  	bf	syscall_trace_entry
>  	!
> -	mov.l	2f, r8			! Number of syscalls
> +	mov.l	6f, r8			! Number of syscalls
>  	cmp/hs	r8, r3
>  	bt	syscall_badsys
>  	!
> @@ -392,7 +392,7 @@ syscall_exit:
>  #if !defined(CONFIG_CPU_SH2)
>  1:	.long	TRA
>  #endif
> -2:	.long	NR_syscalls
> +6:	.long	NR_syscalls
>  3:	.long	sys_call_table
>  7:	.long	do_syscall_trace_enter
>  8:	.long	do_syscall_trace_leave
> 

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
