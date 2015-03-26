From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Mar 2015 09:18:17 +0000
Subject: Re: [PATCH 1/3] gpio: rcar: Use local variable gpio_chip in gpio_rcar_probe()
Message-Id: <CACRpkda7PtB+Sripq8BDQy9rOqa-fomzt=rfKFxCS2nB4d=ENA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
	<1426704069-26389-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426704069-26389-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Mar 18, 2015 at 7:41 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The existing variable gpio_chip already points to the gpiochip instance,
> hence use it everywhere.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
