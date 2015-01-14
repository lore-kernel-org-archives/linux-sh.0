From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Jan 2015 13:15:23 +0000
Subject: Re: [PATCH 2/2] gpio: rcar: Switch to use gpiolib irqchip helpers
Message-Id: <CACRpkdY8HEtm_t2h7vAAZNPZMxxhfSum9TrKTD3TnRRuTUS_7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421057279-16081-1-git-send-email-geert+renesas@glider.be>
	<1421057279-16081-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421057279-16081-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jan 12, 2015 at 11:07 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Switch the R-Car Gen2 GPIO driver to use the gpiolib irqchip helpers.
>
> While doing this also make sure that gpiochip_irqchip_add() is called
> after the gpiochip itself is registered, as required.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Love it. Patch applied.

Yours,
Linus Walleij
