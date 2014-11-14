From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Nov 2014 10:04:03 +0000
Subject: Re: [PATCH v2] gpio: rcar: Add r8a7793 and r8a7794 support
Message-Id: <CACRpkdYajBgaRckwjqQdQysLh6hCo_=ztPRexCG=T9KT=-ryJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415361248-24610-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1415361248-24610-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Nov 7, 2014 at 12:54 PM, Yoshihiro Kaneko <ykaneko0929@gmail.com> wrote:

> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> The device tree probing for R-Car M2-N (r8a7793) and R-Car E2 (r8a7794)
> is added.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on for-next branch of Linus Walleij's gpio tree.
>
> v2 [Yoshihiro Kaneko]
> * As suggested by Geert Uytterhoeven
>   - clean up 4 identical copies of struct gpio_rcar_info.

Patch applied.

As mentions in another thread I want someone to work on using
GPIOLIB_IRQCHIP for the Rcar driver.

Yours,
Linus Walleij
