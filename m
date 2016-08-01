From: Rich Felker <dalias@libc.org>
Date: Mon, 01 Aug 2016 16:58:07 +0000
Subject: Re: [PATCH v2] sh: system call wire up
Message-Id: <20160801165807.GR15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1467096586-24124-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467096586-24124-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 28, 2016 at 03:49:46PM +0900, Yoshinori Sato wrote:
> Changes v2
> - fix typo.
> 
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
> index 734234b..254bc22 100644
> --- a/arch/sh/kernel/syscalls_32.S
> +++ b/arch/sh/kernel/syscalls_32.S
> @@ -386,3 +386,17 @@ ENTRY(sys_call_table)
>  	.long sys_process_vm_writev
>  	.long sys_kcmp
>  	.long sys_finit_module
> +	.long sys_sched_getattr
> +	.long sys_sched_setattr		/* 370 */
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
> index 579fcb9..d6a27f7 100644
> --- a/arch/sh/kernel/syscalls_64.S
> +++ b/arch/sh/kernel/syscalls_64.S
> @@ -406,3 +406,17 @@ sys_call_table:
>  	.long sys_process_vm_writev
>  	.long sys_kcmp
>  	.long sys_finit_module
> +	.long sys_sched_getattr		/* 380 */
> +	.long sys_sched_setattr
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
> -- 
> 2.7.0

I've done basic checking that the added syscalls don't have
ABI/calling convention problems due to 64-bit args or similar. The
main ones in question were preadv2/pwritev2 and they have a clean
arch-generic mechanism for passing the 64-bit arg. So I think these
are fine to include in 4.8. I'm adding this patch and it will be in my
for-next branch soon and subsequently in my pull request for the
linux-sh tree.

Rich
