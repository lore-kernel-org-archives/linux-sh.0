From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 11 Jun 2016 21:32:56 +0000
Subject: Re: [PATCH] sh: system call wire up
Message-Id: <69335f97-f672-5459-5858-407ffbb28908@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1465664789-3976-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465664789-3976-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Yoshinori!

Thanks updating the syscall table. Please mark the following bug as RESOLVED once
your patches have been committed:

> https://bugzilla.kernel.org/show_bug.cgi?id9121

Adrian

On 06/11/2016 07:06 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/include/uapi/asm/unistd_32.h | 16 +++++++++++++++-
>  arch/sh/include/uapi/asm/unistd_64.h | 16 +++++++++++++++-
>  arch/sh/kernel/syscalls_32.S         | 14 ++++++++++++++
>  arch/sh/kernel/syscalls_64.S         | 14 ++++++++++++++
>  4 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
> index d13a1d6..c801bde 100644
> --- a/arch/sh/include/uapi/asm/unistd_32.h
> +++ b/arch/sh/include/uapi/asm/unistd_32.h
> @@ -380,7 +380,21 @@
>  #define __NR_process_vm_writev	366
>  #define __NR_kcmp		367
>  #define __NR_finit_module	368
> +#define __NR_sched_getattr	369
> +#define __NR_sched_setattr	370
> +#define __NR_renameat2		371
> +#define __NR_seccomp		372
> +#define __NR_getrandom		373
> +#define __NR_memfd_create	374
> +#define __NR_bpf		375
> +#define __NR_execveat		376
> +#define __NR_userfaultfd	377
> +#define __NR_membarrier		378
> +#define __NR_mlock2		379
> +#define __NR_copy_file_range	380
> +#define __NR_preadv2		381
> +#define __NR_pwritev2		382
>  
> -#define NR_syscalls 369
> +#define NR_syscalls 383
>  
>  #endif /* __ASM_SH_UNISTD_32_H */
> diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
> index 47ebd5b..ce0cb35 100644
> --- a/arch/sh/include/uapi/asm/unistd_64.h
> +++ b/arch/sh/include/uapi/asm/unistd_64.h
> @@ -400,7 +400,21 @@
>  #define __NR_process_vm_writev	377
>  #define __NR_kcmp		378
>  #define __NR_finit_module	379
> +#define __NR_sched_getattr	380
> +#define __NR_sched_setattr	381
> +#define __NR_renameat2		382
> +#define __NR_seccomp		383
> +#define __NR_getrandom		384
> +#define __NR_memfd_create	385
> +#define __NR_bpf		386
> +#define __NR_execveat		387
> +#define __NR_userfaultfd	388
> +#define __NR_membarrier		389
> +#define __NR_mlock2		390
> +#define __NR_copy_file_range	391
> +#define __NR_preadv2		392
> +#define __NR_pwritev2		393
>  
> -#define NR_syscalls 380
> +#define NR_syscalls 394
>  
>  #endif /* __ASM_SH_UNISTD_64_H */
> diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
> index 734234b..f03a16b 100644
> --- a/arch/sh/kernel/syscalls_32.S
> +++ b/arch/sh/kernel/syscalls_32.S
> @@ -386,3 +386,17 @@ ENTRY(sys_call_table)
>  	.long sys_process_vm_writev
>  	.long sys_kcmp
>  	.long sys_finit_module
> +	.long sys_sched_getattr
> +	.long sys_sched_getattr		/* 370 */
> +	.long sys_renameat2
> +	.long sys_seccomp
> +	.long sys_getrandom
> +	.long sys_memfd_create
> +	.long sys_bpf			/* 375 */
> +	.long sys_execveat
> +	.long sys_userfaultfd
> +	.long sys_membarrier
> +	.long sys_mlock2
> +	.long sys_copy_file_range	/* 380 */
> +	.long sys_preadv2
> +	.long sys_pwritev2
> diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
> index 579fcb9..7e79252 100644
> --- a/arch/sh/kernel/syscalls_64.S
> +++ b/arch/sh/kernel/syscalls_64.S
> @@ -406,3 +406,17 @@ sys_call_table:
>  	.long sys_process_vm_writev
>  	.long sys_kcmp
>  	.long sys_finit_module
> +	.long sys_sched_getattr		/* 380 */
> +	.long sys_sched_getattr
> +	.long sys_renameat2
> +	.long sys_seccomp
> +	.long sys_getrandom
> +	.long sys_memfd_create		/* 385 */
> +	.long sys_bpf
> +	.long sys_execveat
> +	.long sys_userfaultfd
> +	.long sys_membarrier
> +	.long sys_mlock2		/* 390 */
> +	.long sys_copy_file_range
> +	.long sys_preadv2
> +	.long sys_pwritev2
> 


-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
