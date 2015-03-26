From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Mar 2015 09:26:00 +0000
Subject: Re: [PATCH 3/3] gpio: rcar: Prevent module clock disable when wake-up is enabled
Message-Id: <CACRpkdYLXyA3Bfn+iLmR6w0cTmvs=i=sW4rTrzTz_zZiiCHmEA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426704069-26389-1-git-send-email-geert+renesas@glider.be>
	<1426704069-26389-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426704069-26389-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Mar 18, 2015 at 7:41 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> When the GPIO module is needed for wake-up, it's module clock must not
> be disabled. Hence implement irq_chip.irq_set_wake(), which
> increments/decrements the clock's enable_count when needed, and forwards
> the wake-up state to the upstream interrupt controller.
>
> This fixes wake-up from s2ram using gpio-keys when using a PM Domain to
> manage the module clock.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
