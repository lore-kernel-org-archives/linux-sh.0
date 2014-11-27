From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Nov 2014 14:13:42 +0000
Subject: Re: [PATCH/RFC] gpio: em: Use dynamic allocation of GPIOs
Message-Id: <CACRpkdaFFYw8446JNWJ1AO+snixcYS=XtbaaW9soqeJ8KHueZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Mon, Nov 17, 2014 at 3:30 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Use dynamic allocation of GPIOs instead of looking at the gpio%u alias
> in DT.
> ---
>   - Is this correct? Not having to care about the alias would simplify the
>     to-be-written DT binding documentation.
>   - Completely untested.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
