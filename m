From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Date: Tue, 10 Nov 2020 15:53:45 +0000
Subject: Re: [PATCH resend2] sh/intc: Restore devm_ioremap() alignment
Message-Id: <370e55e9-afe7-1392-4816-3734d04351fb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20201110154939.3285928-1-geert+renesas@glider.be>
In-Reply-To: <20201110154939.3285928-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello!

On 11/10/20 6:49 PM, Geert Uytterhoeven wrote:

> Restore alignment of the continuation of the devm_ioremap() call in

   It's a plain ioremap() call below, isn't it, :-)

> register_intc_controller().
> 
> Fixes: 4bdc0d676a643140 ("remove ioremap_nocache and devm_ioremap_nocache")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/sh/intc/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index f8e070d67fa3266d..a14684ffe4c1a8ef 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -214,7 +214,7 @@ int __init register_intc_controller(struct intc_desc *desc)
>  			d->window[k].phys = res->start;
>  			d->window[k].size = resource_size(res);
>  			d->window[k].virt = ioremap(res->start,
> -							 resource_size(res));
> +						    resource_size(res));
>  			if (!d->window[k].virt)
>  				goto err2;
>  		}

MBR, Sergei
