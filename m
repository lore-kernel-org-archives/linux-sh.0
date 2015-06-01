From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 01 Jun 2015 14:56:31 +0000
Subject: Re: [PATCH] gpio: pcf857x: Check for irq_set_irq_wake() failures
Message-Id: <CACRpkdZPxBL24V=D_5OwEWSAHgnrwqU-zGG6OebXSB3Q7sYZNw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432640042-16650-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432640042-16650-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, May 26, 2015 at 1:34 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If an interrupt controller doesn't support wake-up configuration,
> irq_set_irq_wake() returns an error code.  Then any subsequent call
> trying to deconfigure wake-up will cause an imbalance, and a warning
> will be printed:
>
>     WARNING: CPU: 1 PID: 1341 at kernel/irq/manage.c:540 irq_set_irq_wake+0x
>     Unbalanced IRQ 26 wake disable
>
> To fix this, refrain from any further parent interrupt controller
> (de)configuration if irq_set_irq_wake() failed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Argh how hacky. Still I have no better ideas :(

Patch applied.

Yours,
Linus Walleij
