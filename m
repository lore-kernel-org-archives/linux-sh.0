From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 27 Jan 2016 09:53:23 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: r8a7795: Remove bits SEL_VSP_1 and SEL_VSP_0
Message-Id: <CACRpkdaqiYmTOVV3f5PEGyihuH+CRieNhCGfBWi7Lg3MBhC05g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452856024-10793-1-git-send-email-geert+renesas@glider.be>
	<1452856024-10793-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452856024-10793-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Jan 15, 2016 at 12:07 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Cfr. Manual Errata for Rev 0.50 of the R-Car Gen3 datasheet.
>
> This has no user-visible impact, as the definitions were not really
> used.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess there will still be a huge influx of SH-PFC patches so we should
keep running pull request from you to me for the v4.6 kernel cycle.

Yours,
Linus Walleij
