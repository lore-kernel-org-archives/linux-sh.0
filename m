From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 30 Mar 2011 00:02:00 +0000
Subject: Re: [PATCH] sh: Fix build arch_ptrace function by init_fpu
Message-Id: <w3pfwq5jx1o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1301398619-10753-1-git-send-email-iwamatsu@nigauri.org>
In-Reply-To: <1301398619-10753-1-git-send-email-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Iwamatsu san

> init_fpu can use only with CPU having FPU.
> his was used in arch_ptrace, but came to use even the CPU which did not
> have an FPU.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  arch/sh/kernel/ptrace_32.c |    4 ++++
>  arch/sh/kernel/ptrace_64.c |    4 ++++
>  2 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 2130ca6..e00ddad 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -394,9 +394,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  					tmp = 0;
>  			} else {
>  				unsigned long index;
> +#ifdef CONFIG_SH_FPU
>  				ret = init_fpu(child);
>  				if (ret)
>  					break;
> +#endif

How about modify "init_fpu" function side instead of this patch ?
I don't know detail but like this ?

int init_fpu(xxx) {

#ifdef CONFIG_SH_FPU
       ....
       ....
       ...
#endif

    return 0;
}


>  				index = addr - offsetof(struct user, fpu);
>  				tmp = ((unsigned long *)child->thread.xstate)
>  					[index >> 2];
> @@ -428,9 +430,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  		else if (addr >= offsetof(struct user, fpu) &&
>  			 addr < offsetof(struct user, u_fpvalid)) {
>  			unsigned long index;
> +#ifdef CONFIG_SH_FPU
>  			ret = init_fpu(child);
>  			if (ret)
>  				break;
> +#endif
>  			index = addr - offsetof(struct user, fpu);
>  			set_stopped_child_used_math(child);
>  			((unsigned long *)child->thread.xstate)
> diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
> index c8f9764..d675b0e 100644
> --- a/arch/sh/kernel/ptrace_64.c
> +++ b/arch/sh/kernel/ptrace_64.c
> @@ -403,9 +403,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  		else if ((addr >= offsetof(struct user, fpu)) &&
>  			 (addr <  offsetof(struct user, u_fpvalid))) {
>  			unsigned long index;
> +#ifdef CONFIG_SH_FPU
>  			ret = init_fpu(child);
>  			if (ret)
>  				break;
> +#endif
>  			index = addr - offsetof(struct user, fpu);
>  			tmp = get_fpu_long(child, index);
>  		} else if (addr = offsetof(struct user, u_fpvalid)) {
> @@ -445,9 +447,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  		else if ((addr >= offsetof(struct user, fpu)) &&
>  			 (addr <  offsetof(struct user, u_fpvalid))) {
>  			unsigned long index;
> +#ifdef CONFIG_SH_FPU
>  			ret = init_fpu(child);
>  			if (ret)
>  				break;
> +#endif
>  			index = addr - offsetof(struct user, fpu);
>  			ret = put_fpu_long(child, index, data);
>  		}
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Best regards
--
Kuninori Morimoto
 
