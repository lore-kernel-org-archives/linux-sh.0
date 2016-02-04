From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Feb 2016 18:53:23 +0000
Subject: Re: [PATCH 0/3] pinctrl: sh-pfc: Correct pin range comments
Message-Id: <1489274.AOuTy6zPSb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448891996-5263-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Geert,

Thank you for the patches.

On Monday 30 November 2015 14:59:53 Geert Uytterhoeven wrote:
> 	Hi Laurent, Linus,
> 
> This patch series corrects a few pin range comments in the Renesas
> pinctrl data. No functional changes.
> 
> Thanks!

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Geert Uytterhoeven (3):
>   pinctrl: sh-pfc: emev2: Correct comment for CFI data pins
>   pinctrl: sh-pfc: r8a7740: Correct comment for LCD1 data pins
>   pinctrl: sh-pfc: sh73a0: Correct comment for LCD2 data pins
> 
>  drivers/pinctrl/sh-pfc/pfc-emev2.c   | 2 +-
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

