From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Feb 2016 18:51:32 +0000
Subject: Re: [PATCH 0/4] pinctrl: sh-pfc: More PINMUX_SINGLE() conversions
Message-Id: <1894444.Drq0WfiSBA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890865-1856-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448890865-1856-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patches.

On Monday 30 November 2015 14:41:01 Geert Uytterhoeven wrote:
> 	Hi Laurent, Linus,
> 
> This patch series converts pin control data for a few more Renesas SoCs
> to the recently-introduced PINMUX_SINGLE() macro.
> As such this series depends on "[PATCH/RFC 0/4] pinctrl: sh-pfc: Add
> PINMUX_SINGLE()".
> 
> Thanks!
> 
> Geert Uytterhoeven (4):
>   pinctrl: sh-pfc: emev2: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
>   pinctrl: sh-pfc: r8a7778: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
>   pinctrl: sh-pfc: r8a7779: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
>   pinctrl: sh-pfc: sh7734: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/pinctrl/sh-pfc/pfc-emev2.c   | 134 +++++++++++++++----------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  22 +++---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  16 ++---
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  21 +++---
>  4 files changed, 98 insertions(+), 95 deletions(-)

-- 
Regards,

Laurent Pinchart

