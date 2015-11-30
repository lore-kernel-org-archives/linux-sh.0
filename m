From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Nov 2015 08:48:34 +0000
Subject: Re: [PATCH 0/2] pinctrl: sh-pfc: r8a7791/r8a7795: Add SCIF_CLK support
Message-Id: <CACRpkdbZSJXVZrgyJZyoaVxarPbq0D4ezZdo53kQz+ANDFb9=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447957827-32637-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447957827-32637-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Nov 19, 2015 at 7:30 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

>         Hi Linus, Laurent,
>
> This patch series add pins, groups, and a function for SCIF_CLK on R-Car
> M2 and R-Car H3. SCIF_CLK is the external clock source for the Baud Rate
> Generator for External Clock (BRG) on (H)SCIF.

Acked-by from my side, expect that you queue these and send me
a pull request.

Yours,
Linus Walleij
