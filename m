From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 14 Nov 2012 06:13:47 +0000
Subject: Re: [PATCH] sh: Wire up finit_module syscall
Message-Id: <20121114061347.GA22146@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1352872900-25112-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1352872900-25112-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 14, 2012 at 03:01:40PM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  arch/sh/include/uapi/asm/unistd_32.h |    3 ++-
>  arch/sh/include/uapi/asm/unistd_64.h |    3 ++-
>  arch/sh/kernel/syscalls_32.S         |    1 +
>  arch/sh/kernel/syscalls_64.S         |    1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
> index 9e465f2..d13a1d6 100644
> --- a/arch/sh/include/uapi/asm/unistd_32.h
> +++ b/arch/sh/include/uapi/asm/unistd_32.h
> @@ -379,7 +379,8 @@
>  #define __NR_process_vm_readv	365
>  #define __NR_process_vm_writev	366
>  #define __NR_kcmp		367
> +#define __NR_finit_module	368
>  
> -#define NR_syscalls 368
> +#define NR_syscalls 369
>  
>  #endif /* __ASM_SH_UNISTD_32_H */
> diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
> index 8e3a2ed..9f1a456 100644
> --- a/arch/sh/include/uapi/asm/unistd_64.h
> +++ b/arch/sh/include/uapi/asm/unistd_64.h
> @@ -399,7 +399,8 @@
>  #define __NR_process_vm_readv	376
>  #define __NR_process_vm_writev	377
>  #define __NR_kcmp		378
> +#define __NR_finit_module	368
>  
Copy and paste error, this needs to be 379.
