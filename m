From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Dec 2015 23:14:56 +0000
Subject: Re: [PATCH v2 2/2] gpio: rcar: Improve clock error handling and reporting
Message-Id: <CACRpkdYaF8pCeiKqYU9WKE8PHxV=0fsC9ZCUDm8+UqABq2r-YQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449243233-11089-1-git-send-email-geert+renesas@glider.be>
	<1449243233-11089-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449243233-11089-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Dec 4, 2015 at 4:33 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> If the Renesas R-Car GPIO driver cannot find a functional clock, it
> prints a warning, .e.g.
>
>         gpio_rcar ffc40000.gpio: unable to get clock
>
> and continues, as the clock is optional, depending on the SoC type.
> This warning may confuse users.
>
> To fix this, add a flag to indicate that the clock is mandatory or
> optional:
>   - If the clock is mandatory (on R-Car Gen2 and Gen3), a missing clock
>     is now treated as a fatal error,
>   - If the clock is optional (on R-Car Gen1), the warning is no longer
>     printed.
>
> Suggested-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Use booleans instead of bitfields,
>   - Add reference to R-Car Gen3.

Patch applied.

Yours,
Linus Walleij
