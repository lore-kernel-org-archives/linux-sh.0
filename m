From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Jan 2016 13:04:57 +0000
Subject: Re: [PATCH 1/2] pinctrl: sh-pfc: r8a7795: Rename SSI_{WS,SCK}0129 to SSI_{WS,SCK}01239
Message-Id: <CACRpkda7w6A48Bk2szWmAo1mor-VQGxMjPv6bwaFfoBzhm-DVQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452856024-10793-1-git-send-email-geert+renesas@glider.be>
	<1452856024-10793-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452856024-10793-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Jan 15, 2016 at 12:07 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Cfr. Manual Errata for Rev 0.50 of the R-Car Gen3 datasheet.
>
> This has no user-visible impact, as the string used for configuration
> ("ssi01239_ctrl") was already correct.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Are these regressions that need to go in as fixes?

Yours,
Linus Walleij
