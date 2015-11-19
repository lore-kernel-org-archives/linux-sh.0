From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 19 Nov 2015 23:08:32 +0000
Subject: Re: [PATCH] m32r: Fix clearing of thread info fault code
Message-Id: <20151119150832.43f94bdd211e71f9f91c90ae@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20151119211319.784149af@wiggum>
In-Reply-To: <20151119211319.784149af@wiggum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael =?ISO-8859-1?Q?B=FCsch?= <m@bues.ch>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>

On Thu, 19 Nov 2015 21:13:19 +0100 Michael B__sch <m@bues.ch> wrote:

> The expression (~0 >> x) will always yield all-ones, because the right
> shift is an arithmetic right shift that will always shift ones in.
> Hence the old fault code bits will not be cleared before being ORed
> with the new fault code.
> 
> Fix this by forcing a logical right shift instead of an arithmetic
> right shift by using an unsigned long constant.
> 
> Reported-by: Ilia Mirkin <imirkin@alum.mit.edu>
> Signed-off-by: Michael Buesch <m@bues.ch>
> 
> ---
> 
> The code also assumes sizeof(ti->flags) = 4. But that probably is ok
> for this arch.
> 
> This patch is untested, because I do not have the hardware.
> 
> Resend: Patch was originally sent on Wed, 18 Jun 2015.
> 
> (Sorry, hit the send button early, so here goes the actual patch.)
>
> ...
>
> --- linux.orig/arch/m32r/include/asm/thread_info.h
> +++ linux/arch/m32r/include/asm/thread_info.h
> @@ -77,7 +77,7 @@ static inline struct thread_info *curren
>  static inline void set_thread_fault_code(unsigned int val)
>  {
>  	struct thread_info *ti = current_thread_info();
> -	ti->flags = (ti->flags & (~0 >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
> +	ti->flags = (ti->flags & (~0UL >> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
>  		| (val << TI_FLAG_FAULT_CODE_SHIFT);
>  }

I don't think we should apply this unless someone can runtime test it. 
Presumably the current code works OK, but we just don't know what
nasties the fixed version might expose.

The best I can think of is to put a big FIXME comment in there, so
perhaps one day if someone is working on m32r stuff, they may try
fixing it.

