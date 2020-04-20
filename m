From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 20 Apr 2020 22:52:37 +0000
Subject: Re: [PATCHv3 31/50] sh: Add loglvl to printk_address()
Message-Id: <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
        <20200418201944.482088-32-dima@arista.com>
In-Reply-To: <20200418201944.482088-32-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Sat, 18 Apr 2020 21:19:25 +0100 Dmitry Safonov <dima@arista.com> wrote:

> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Add log level argument to printk_address() as a preparation to introduce
> show_stack_loglvl().
> 
> As a good side-effect show_fault_oops() now prints the address with
> KERN_EMREG as the rest of output, making sure there won't be situation
> where "PC: " is printed without actual address.
> 
> --- a/arch/sh/include/asm/kdebug.h
> +++ b/arch/sh/include/asm/kdebug.h
> @@ -12,7 +12,8 @@ enum die_val {
>  };
>  
>  /* arch/sh/kernel/dumpstack.c */
> -extern void printk_address(unsigned long address, int reliable);
> +extern void printk_address(unsigned long address, int reliable,
> +			   const char *loglvl);
>  extern void dump_mem(const char *str, const char *loglvl,
>  		     unsigned long bottom, unsigned long top);
>  
> ...
>
> --- a/arch/sh/mm/fault.c
> +++ b/arch/sh/mm/fault.c
> @@ -196,7 +196,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
>  
>  	printk(KERN_CONT " at %08lx\n", address);
>  	printk(KERN_ALERT "PC:");
> -	printk_address(regs->pc, 1);
> +	printk_address(regs->pc, 1, KERN_ALERT);
>  

It would be more intuitive to do

	printk_address(KERN_ALERT, regs->pc, 1);

because the loglevel always comes first.

I guess it doesn't matter much, as sh seems to be rather dead.
