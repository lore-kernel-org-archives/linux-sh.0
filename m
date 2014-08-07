From: Josh Triplett <josh@joshtriplett.org>
Date: Thu, 07 Aug 2014 05:10:20 +0000
Subject: Re: [PATCH] sh: bug: add unreachable() to silence warnings
Message-Id: <20140807051020.GB2340@thin>
List-Id: <linux-sh.vger.kernel.org>
References: <1407375741-3209-1-git-send-email-xerofoiify@gmail.com>
In-Reply-To: <1407375741-3209-1-git-send-email-xerofoiify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Krause <xerofoiify@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, "open list:SUPERH" <linux-sh@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Aug 07, 2014 at 03:42:20AM +0200, Nick Krause wrote:
> SuperH BUG() have warnings like
> 
> kernel/sched/core.c:2692:1: warning: control reaches end of non-void function
> [-Wreturn-type]
> net/core/ethtool.c:236:1: warning: control reaches end of non-void function
> [-Wreturn-type]
> 
> Other BUG() implementations
> have added unreachable() at end becuase of which I guess
> it does not showthese errors. We can silence them using unreachable().
> 
> Signed-off-by: Nick Krause <xerofoify@gmail.com>

This change seems reasonable to me.  Unlike the generic version of
BUG(), this one doesn't call panic() or anything else flagged as
__noreturn, so it seems reasonable to add a call to unreachable() here
to tell the compiler that the assembly will trap and not return.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

>  arch/sh/include/asm/bug.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
> index dcf2780..1ae948f 100644
> --- a/arch/sh/include/asm/bug.h
> +++ b/arch/sh/include/asm/bug.h
> @@ -48,6 +48,7 @@ do {							\
>  		   "i" (__FILE__),			\
>  		   "i" (__LINE__), "i" (0),		\
>  		   "i" (sizeof(struct bug_entry)));	\
> +	unreachable();					\
>  } while (0)
>  
>  #define __WARN_TAINT(taint)				\
> -- 
> 2.0.1
> 
