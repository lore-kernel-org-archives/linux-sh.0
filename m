From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 01 Dec 2015 09:54:57 +0000
Subject: Re: [PATCH] gpio: rcar: Improve clock error handling and reporting
Message-Id: <CACRpkdabE9=UsGsRqzVZg3P09ntLTMz1NE3ginQ_XdFiddh4bw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448377528-19307-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448377528-19307-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Nov 24, 2015 at 4:05 PM, Geert Uytterhoeven
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
>   - If the clock is mandatory (on R-Car Gen2), a missing clock is now
>     treated as a fatal error,
>   - If the clock is optional (on R-Car Gen1), the warning is no longer
>     printed.
>
> The new flag is merged with the existing has_both_edge_trigger boolean
> into a bitfield to save space.

*DON'T* try to save bits in a megabyte kernel like this.
The better readability is worth the extra bits or bytes it takes.
Besides, did you really try to compile it before/after that change
to verify that it actually saved that space?

> Suggested-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This depends on "gpio: rcar: Remove obsolete platform data support".

Where is that patch? This does not apply to my tree,
probably because of this.

Please sent the patches in a series.

>         unsigned has_both_edge_trigger:1;
> +       unsigned needs_clk:1;

both should be bool and assigned true/false.

Yours,
Linus Walleij
