From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 Nov 2015 00:48:44 +0000
Subject: Re: [PATCH/RFC 0/4] pinctrl: sh-pfc: Add PINMUX_SINGLE()
Message-Id: <2326541.taAcxUkgxs@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patches.

On Tuesday 20 October 2015 21:26:31 Geert Uytterhoeven wrote:
> 	Hi,
> 
> Currently single-function pins are described using the raw PINMUX_DATA()
> macro.
> 
> Morimoto-san doesn't like that. He proposed to use the existing
> PINMUX_IPSR_NOGP() macro instead (cfr. "[RFC] pinctrl: sh-pfc: r8a7795:
> Add pinmux data for single-function pins",
> http://www.spinics.net/lists/linux-sh/msg44823.html).
> However, that macro is intended to describe a pinmux configuration
> without GPIO function, which feels wrong to me.
> 
> This patch series proposes an alternative, introducing a new macro
> PINMUX_SINGLE() to describe a pinmux configuration for a single-function
> pin. It also converts the existing single-function pin descriptions.
> 
> Thanks for your comments!

For patches 2-4,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

But why haven't you included the other SoCs ?

> Geert Uytterhoeven (4):
>   pinctrl: sh-pfc: Add PINMUX_SINGLE()
>   pinctrl: sh-pfc: r8a7790: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
>   pinctrl: sh-pfc: r8a7791: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
>   pinctrl: sh-pfc: r8a7794: Use PINMUX_SINGLE() instead of raw
>     PINMUX_DATA()
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 18 +++++++--------
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 34 ++++++++++++++--------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 44 +++++++++++++++++----------------
>  drivers/pinctrl/sh-pfc/sh_pfc.h      |  7 ++++++
>  4 files changed, 55 insertions(+), 48 deletions(-)

-- 
Regards,

Laurent Pinchart

