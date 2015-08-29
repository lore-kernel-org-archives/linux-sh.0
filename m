From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 29 Aug 2015 08:39:09 +0000
Subject: Re: [PATCH][RFC] sh-pfc: add new PINMUX_IPSR_MODS() macro
Message-Id: <38944168.Lsx7EbeIaO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9nkc7km.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9nkc7km.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Friday 28 August 2015 14:20:41 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Actually, PINMUX_IPSR_MODS() macro is same as PINMUX_IPSR_MODSEL_DATA().
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
> These are readable
> 
> 	PINMUX_IPSR_NOGP(ispr, ...)
> 	PINMUX_IPSR_DATA(ipsr, ...)
> 	PINMUX_IPSR_NOGM(ispr, ...)
> 	PINMUX_IPSR_NOFN(ipsr, ...)
> 	PINMUX_IPSR_MSEL(ipsr, ...)
> 	PINMUX_IPSR_MODS(ipsr, ...)
> 
> We can replace all PINMUX_IPSR_MODSEL_DATA() to PINMUX_IPSR_MODS(),
> and remove PINMUX_IPSR_MODSEL_DATA() from header.

I agree that the PINMUX_IPSR_MODSEL_DATA() name makes code harder to read. 
However, PINMUX_IPSR_MODS() isn't very descriptive, I think it would make the 
code confusing (not that it isn't already...).

The only difference between  PINMUX_IPSR_MSEL and PINMUX_IPSR_MODSEL_DATA is 
the order in which the MODSEL, GSPR and IPSR registers are written. I wonder 
if that's actually important, or if we could merge both macros into a single 
one. What do you think ?


> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> 
> > LinusW, Laurent
> 
> As I mentioned above, if this patch was accepted, I can replace all
> PINMUX_IPSR_MODSEL_DATA() to PINMUX_IPSR_MODS(). But I didn't it since it
> is [RFC] now
> 
>  drivers/pinctrl/sh-pfc/sh_pfc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 0874cfe..40447d54 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -173,6 +173,8 @@ struct sh_pfc_soc_info {
>  	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
>  #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
>  	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr, FN_##ms)
> +#define PINMUX_IPSR_MODS(ipsr, fn, ms)			\
> +	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
>  #define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms)				\
>  	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)

-- 
Regards,

Laurent Pinchart

