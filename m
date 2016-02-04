From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Feb 2016 18:43:35 +0000
Subject: Re: [PATCH v3 2/2] pinctrl: sh-pfc: Rename PINMUX_IPSR_DATA() to PINMUX_IPSR_GPSR()
Message-Id: <4156451.gvQvsaIaBa@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890332-773-1-git-send-email-geert+renesas@glider.be> <1448890332-773-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448890332-773-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Monday 30 November 2015 14:32:12 Geert Uytterhoeven wrote:
> This macro describes a pinmux configuration that needs configuration in
> both a Peripheral Function Select Register (IPSR) and in a
> GPIO/Peripheral Function Select Register 1 (GPSR). Reflect that in the
> macro name for clarity.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3:
>   - New.
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  690 ++++++++++-----------
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 1136 +++++++++++++++---------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  774 +++++++++++------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  624 +++++++++----------
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  844 ++++++++++++-------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7795.c |  554 ++++++++---------
>  drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  412 ++++++------
>  drivers/pinctrl/sh-pfc/sh_pfc.h      |    2 +-
>  8 files changed, 2518 insertions(+), 2518 deletions(-)

-- 
Regards,

Laurent Pinchart

