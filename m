From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 02 Oct 2015 14:45:07 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Rename .gpio_data[] to .pinmux_data[]
Message-Id: <1993757.9LYjE81XZo@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1443016754-24203-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1443016754-24203-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

On Wednesday 23 September 2015 15:59:14 Geert Uytterhoeven wrote:
> The sh_pfc_soc_info.gpio_data[] array contains not only GPIO data, but
> also various other pinmux-related data (functions and marks).
> Every single driver already calls its local array pinmux_data[].
> Hence rename the sh_pfc_soc_info member to "pinmux_data".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Everything that could make the pfc driver more readable is welcome :-)

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/core.c        | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-emev2.c   | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 8 ++++----
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 8 ++++----
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7203.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7264.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7269.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7720.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7722.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7723.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7724.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7757.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7785.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-sh7786.c  | 4 ++--
>  drivers/pinctrl/sh-pfc/pfc-shx3.c    | 4 ++--
>  drivers/pinctrl/sh-pfc/sh_pfc.h      | 6 +++---
>  24 files changed, 53 insertions(+), 53 deletions(-)

-- 
Regards,

Laurent Pinchart

