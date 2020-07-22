From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jul 2020 23:20:35 +0000
Subject: Re: [PATCH 4/4] sh: bring syscall_set_return_value in line with other architectures
Message-Id: <bfb5f986-1d49-15e4-d1e5-74408e779ffd@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20200722231322.419642-4-kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20200722231322.419642-4-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

On 7/23/20 1:13 AM, Michael Karcher wrote:
> Other architectures expect that syscall_set_return_value gets an already
> negative value as error. That's also what kernel/seccomp.c provides.
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>  arch/sh/include/asm/syscall_32.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
> index 0b5b8e75edac..cb51a7528384 100644
> --- a/arch/sh/include/asm/syscall_32.h
> +++ b/arch/sh/include/asm/syscall_32.h
> @@ -40,10 +40,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
>  					    struct pt_regs *regs,
>  					    int error, long val)
>  {
> -	if (error)
> -		regs->regs[0] = -error;
> -	else
> -		regs->regs[0] = val;
> +	regs->regs[0] = (long) error ?: val;
>  }
>  
>  static inline void syscall_get_arguments(struct task_struct *task,
> 

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
