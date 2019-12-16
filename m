From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Mon, 16 Dec 2019 11:28:01 +0000
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-Id: <87r214fr26.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019 11:38:43 +0900,
Kuninori Morimoto wrote:
> 
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> __delay() is used from kernel module.
> We need EXPORT_SYMBOL(), otherwise we will get compile error.
> 
> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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
> -- 
> 2.7.4
> 

Applied sh-next.
Thanks.

-- 
Yosinori Sato
