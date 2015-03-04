From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 04 Mar 2015 12:49:44 +0000
Subject: Re: [PATCH 1/2] [RFC] gpio: pcf857x: Switch to use gpiolib irqchip helpers
Message-Id: <CACRpkdZ6T5bj3ftuMxFKYJxuAVnLofAO9W6q6qf94S-trB49Eg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423151349-10579-1-git-send-email-geert+renesas@glider.be>
	<1423151349-10579-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423151349-10579-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 5, 2015 at 4:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Switch the PCF857x GPIO driver to use the gpiolib irqchip helpers.
> This driver uses a nested threaded interrupt, hence handle_nested_irq()
> and gpiochip_set_chained_irqchip() must be used.
>
> Note that this removes the checks added in commit 21fd3cd1874a2ac8
> ("gpio: pcf857x: call the gpio user handler iff gpio_to_irq is done"),
> as the interrupt mappings are no longer created on-demand by the driver,
> but by gpiochip_irqchip_add() during initialization.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
