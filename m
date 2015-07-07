From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jul 2015 17:39:42 +0000
Subject: Re: [PATCH v3 1/3] sh-pfc: fix sparse GPIOs for R-Car SoCs
Message-Id: <1756227.uoeezymTmX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com> <2925145.E3lLFJfWJW@wasted.cogentembedded.com>
In-Reply-To: <2925145.E3lLFJfWJW@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Sergei,

Thank you for the patch.

On Friday 26 June 2015 01:40:56 Sergei Shtylyov wrote:
> The PFC driver causes the kernel to hang on the R-Car gen2 SoC based  boards
> when the CPU_ALL_PORT() macro is fixed to reflect the reality, i.e. when
> the GPIO space becomes actually sparse.  This happens because the
> _GP_GPIO() macro includes  an indexed initializer which causes the "holes"
> (array entries filled with all 0s) between the groups  of the existing
> GPIOs; and the driver can't cope with that.  There seems to  be no reason
> to use the indexed initializer, so we can remove the index specifier and so
> avoid the "holes".
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

I initially thought that this patch looked too good to be true. The fix is so 
simple, there must have been a reason why _GP_GPIO used indexed initializers. 
I then tried to find that reason and failed.

I still feel that this is too simple to be true, but I have no objective 
reason to push back, so

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

for the whole series, provided you have tested it, and paid attention to pins 
after the holes.

> ---
> Changes in version 3:
> - new patch.
> 
>  drivers/pinctrl/sh-pfc/sh_pfc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/sh_pfc.h
> =================================> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -224,7 +224,7 @@ struct sh_pfc_soc_info {
> 
>  /* PINMUX_GPIO_GP_ALL - Expand to a list of sh_pfc_pin entries */
>  #define _GP_GPIO(bank, _pin, _name, sfx)				\
> -	[(bank * 32) + _pin] = {					\
> +	{								\
>  		.pin = (bank * 32) + _pin,				\
>  		.name = __stringify(_name),				\
>  		.enum_id = _name##_DATA,				\

-- 
Regards,

Laurent Pinchart

