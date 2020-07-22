From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jul 2020 02:38:40 +0000
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <20200722023840.GA55317@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> __delay() is used from kernel module.
> We need EXPORT_SYMBOL(), otherwise we will get compile error.
> 
> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I must admit that this patch completely baffles me. __delay was
already exported, only elsewhere in the file. With this patch
in place, it is exported twice, and all sh builds in -next fail
with

In file included from include/linux/linkage.h:7,
                 from arch/sh/include/asm/bug.h:5,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:12,
                 from include/asm-generic/current.h:5,
                 from ./arch/sh/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from arch/sh/lib/delay.c:8:
include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'

Guenter

> ---
>  arch/sh/lib/delay.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
> index dad8e6a..540e670 100644
> --- a/arch/sh/lib/delay.c
> +++ b/arch/sh/lib/delay.c
> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
>  		: "0" (loops)
>  		: "t");
>  }
> +EXPORT_SYMBOL(__delay);
>  
>  inline void __const_udelay(unsigned long xloops)
>  {
