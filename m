From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 18:45:13 +0000
Subject: Re: [PATCH 0/3] pinctrl: sh-pfc: r8a7779/r8a7790/r8a7794: Add SCIF_CLK support
Message-Id: <6563506.quzPSTWjGH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1449841738-17490-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449841738-17490-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 11 December 2015 14:48:55 Geert Uytterhoeven wrote:
> 	Hi Linus, Laurent,
> 
> This patch series add pins, groups, and a function for SCIF_CLK on R-Car
> SoCs that don't have that support yet (H1, H2, and E2). SCIF_CLK is the
> external clock source for the Baud Rate Generator for External Clock
> (BRG) on (H)SCIF.
> 
> Geert Uytterhoeven (3):
>   pinctrl: sh-pfc: r8a7779: Add SCIF_CLK support
>   pinctrl: sh-pfc: r8a7790: Add SCIF_CLK support
>   pinctrl: sh-pfc: r8a7794: Add SCIF_CLK support

I haven't checked the pin assignments so I'll trust you on that. The function 
and group names seem good to me, so, for the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 41 +++++++++++++++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 23 ++++++++++++++++++++
>  drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 23 ++++++++++++++++++++
>  3 files changed, 87 insertions(+)

-- 
Regards,

Laurent Pinchart

