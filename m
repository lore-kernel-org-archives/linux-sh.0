From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2015 09:15:18 +0000
Subject: Re: [PATCH] gpio: rcar: GPIO_RCAR doesn't relate to ARM
Message-Id: <CAMuHMdXxg+YPHxPdPobNS1C4+khOx6-Ve3nU2UqddTdtdUsCEg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871ter7n17.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ter7n17.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Aug 25, 2015 at 11:12 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> 8cd1470("gpio: rcar: Add r8a7795 (R-Car H3) support") added
> GPIO support for r8a7795. r8a7795 based on CONFIG_ARM64.
> OTOH, GPIO_RCAR driver can be compiled fine on non-ARM.
> This patch removed ARM dependency for it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
