From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 09 Aug 2020 20:26:54 +0000
Subject: Re: [regression fix] Re: "sh: convert to ->regset_get()" breaks linux-sh build
Message-Id: <8b71cdde-ad2a-e770-b2db-c0b5950994f8@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200809174508.GA3026725@ZenIV.linux.org.uk>
In-Reply-To: <20200809174508.GA3026725@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Al!

On 8/9/20 7:45 PM, Al Viro wrote:
> On Sun, Aug 09, 2020 at 05:14:38PM +0100, Al Viro wrote:
> 
>> What the... oh, I see.
>>
>> Commit in the regset followup series has fixed that, with bisect hazard unnoticed.
>> And since only the followups have not gone in, bisect hazard has turned into
>> a mainline breakage ;/
>>
>> Sorry about that.  FWIW, the commit in question is this; all per-architecture
>> parts in it are mutually independent, but I'll probably just send this one
>> to Linus - no point splitting it up.
> 
> FWIW, there are several ways to handle that.  One is to pull vfs.git#fixes -
> that's the first commit of #regset.followups.  Another is to cherry-pick
> the same.  And the minimal fix would be the subset of that commit as below.
> Linus, what would you prefer?
> 
> sh: kill unused dump_fpu() instance
> 
> dead code now that fdpic has switched to regset coredumps.
>  
> Fixes: 3399d90ce63e "sh: convert to ->regset_get()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/sh/include/asm/fpu.h b/arch/sh/include/asm/fpu.h
> index 43cfaf929aa7..04584be8986c 100644
> --- a/arch/sh/include/asm/fpu.h
> +++ b/arch/sh/include/asm/fpu.h
> @@ -37,11 +37,6 @@ struct user_regset;
>  extern int do_fpu_inst(unsigned short, struct pt_regs *);
>  extern int init_fpu(struct task_struct *);
>  
> -extern int fpregs_get(struct task_struct *target,
> -		      const struct user_regset *regset,
> -		      unsigned int pos, unsigned int count,
> -		      void *kbuf, void __user *ubuf);
> -
>  static inline void __unlazy_fpu(struct task_struct *tsk, struct pt_regs *regs)
>  {
>  	if (task_thread_info(tsk)->status & TS_USEDFPU) {
> diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
> index 6ab397bc47ed..7a59a63560c5 100644
> --- a/arch/sh/kernel/process_32.c
> +++ b/arch/sh/kernel/process_32.c
> @@ -93,24 +93,6 @@ void release_thread(struct task_struct *dead_task)
>  	/* do nothing */
>  }
>  
> -/* Fill in the fpu structure for a core dump.. */
> -int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpu)
> -{
> -	int fpvalid = 0;
> -
> -#if defined(CONFIG_SH_FPU)
> -	struct task_struct *tsk = current;
> -
> -	fpvalid = !!tsk_used_math(tsk);
> -	if (fpvalid)
> -		fpvalid = !fpregs_get(tsk, NULL,
> -				      (struct membuf){fpu, sizeof(*fpu)});
> -#endif
> -
> -	return fpvalid;
> -}
> -EXPORT_SYMBOL(dump_fpu);
> -
>  asmlinkage void ret_from_fork(void);
>  asmlinkage void ret_from_kernel_thread(void);
>  
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 5c93bdb6c41a..609b7c917e6e 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -165,7 +165,7 @@ static int genregs_set(struct task_struct *target,
>  }
>  
>  #ifdef CONFIG_SH_FPU
> -int fpregs_get(struct task_struct *target,
> +static int fpregs_get(struct task_struct *target,
>  	       const struct user_regset *regset,
>  	       struct membuf to)
>  {
> 

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

This fixes the linux-next build on SH for me and also produces a bootable kernel image
which boots without any issues on my SH7785LCR.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
