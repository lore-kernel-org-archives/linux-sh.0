From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Sep 2015 08:05:36 +0000
Subject: Re: [PATCH 1/9] sh-pfc: modify PINMUX_IPSR_MSEL() macro order
Message-Id: <20150902080534.GA31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpw9jn3i.wl%kuninori.morimoto.gx@renesas.com>
 <87io7tjmk6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io7tjmk6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Sep 02, 2015 at 07:44:55AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> The difference between PINMUX_IPSR_MSEL() and PINMUX_IPSR_MODSEL_DATA()
> are FN_xxx order, and PINMUX_IPSR_MSEL() is used only from r8a7778.
> Now it r8a7778 works correctly with PINMUX_IPSR_MODSEL_DATA() order.
> This means we can merge PINMUX_IPSR_MSEL() and PINMUX_IPSR_MODSEL_DATA().
> 
> Current PFC driver is very difficult to read, because macro names are
> using different lenth. Especially PINMUX_IPSR_MODSEL_DATA() is well
> used macro
> 
> 	PINMUX_IPSR_NOGP(ispr, ...)
> 	PINMUX_IPSR_DATA(ipsr, ...)
> 	PINMUX_IPSR_NOGM(ispr, ...)
> 	PINMUX_IPSR_NOFN(ipsr, ...)
> 	PINMUX_IPSR_MSEL(ipsr, ...)
> 	PINMUX_IPSR_MODSEL_DATA(ipsr, ...)
> 
> It can be readable if we can merge PINMUX_IPSR_MSEL() and PINMUX_IPSR_MODSEL_DATA()
> 
> 	PINMUX_IPSR_NOGP(ispr, ...)
> 	PINMUX_IPSR_DATA(ipsr, ...)
> 	PINMUX_IPSR_NOGM(ispr, ...)
> 	PINMUX_IPSR_NOFN(ipsr, ...)
> 	PINMUX_IPSR_MSEL(ipsr, ...)
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
> index 7cb1ed6..c8c1d49 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -179,7 +179,7 @@ struct sh_pfc_soc_info {
>  #define PINMUX_IPSR_NOFN(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
>  #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
> -	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr, FN_##ms)
> +	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
>  #define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms)				\
>  	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
>  
> -- 
> 1.9.1
> 
