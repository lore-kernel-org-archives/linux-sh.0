From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Sep 2015 16:06:46 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7794: Remove bogus SCIF0 SCK pin data
Message-Id: <CACRpkdZEOnBp7HkmU0XaB2ybxvF5XbKoYkC0UW0KTwcjGzrDtw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440611638-16256-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440611638-16256-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Wed, Aug 26, 2015 at 10:53 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> SCIF0 on R-Car E2 does not have an SCK pin.
>
> "SCIF_CLK" is the (H)SCIF baud rate generation clock pin, which is not
> yet supported.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

This goes for the rest of the PFC patches as well, I'll just
glance over it and trust you to pile up the stuff nicely.

Yours,
Linus Walleij
