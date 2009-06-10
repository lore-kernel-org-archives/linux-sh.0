From: Matt Fleming <matt@console-pimps.org>
Date: Wed, 10 Jun 2009 15:54:52 +0000
Subject: Re: [PATCH] sh: Fix sh4a llsc operation
Message-Id: <20090610155452.GA5554@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A2FD353.5080201@gmail.com>
In-Reply-To: <4A2FD353.5080201@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 11, 2009 at 12:37:55AM +0900, Aoi Shinkai wrote:
> This patch fixes sh4a llsc operation.
> Most of all is taken from arm and mips.
> 
> Signed-off-by: Aoi Shinkai <shinkoi2005@gmail.com>

[...]

> diff --git a/arch/sh/include/asm/cmpxchg-llsc.h b/arch/sh/include/asm/cmpxchg-llsc.h
> index 0fac3da..4713666 100644
> --- a/arch/sh/include/asm/cmpxchg-llsc.h
> +++ b/arch/sh/include/asm/cmpxchg-llsc.h
> @@ -55,7 +55,7 @@ __cmpxchg_u32(volatile int *m, unsigned long old, unsigned long new)
>  		"mov		%0, %1				\n\t"
>  		"cmp/eq		%1, %3				\n\t"
>  		"bf		2f				\n\t"
> -		"mov		%3, %0				\n\t"
> +		"mov		%4, %0				\n\t"
>  		"2:						\n\t"
>  		"movco.l	%0, @%2				\n\t"
>  		"bf		1b				\n\t"

Good catch!

> diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
> index 6028356..69f4dc7 100644
> --- a/arch/sh/include/asm/spinlock.h
> +++ b/arch/sh/include/asm/spinlock.h
> @@ -26,7 +26,7 @@
>  #define __raw_spin_is_locked(x)		((x)->lock <= 0)
>  #define __raw_spin_lock_flags(lock, flags) __raw_spin_lock(lock)
>  #define __raw_spin_unlock_wait(x) \
> -	do { cpu_relax(); } while ((x)->lock)
> +	do { while (__raw_spin_is_locked(lock)) cpu_relax(); } while (0)
> 
>  /*
>   * Simple spin lock operations.  There are two variants, one clears IRQ's

That looks like a pasting error to me, "lock" should be "x".
