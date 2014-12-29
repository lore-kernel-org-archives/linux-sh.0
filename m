From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Dec 2014 20:24:15 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: add ADSP clocks
Message-Id: <CAMuHMdUqC5v-d95Sk2NewSE-EBKS49vn7jPKpixF2djg6NOmVw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
In-Reply-To: <1937156.Ii2YrGkOFy@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 29, 2014 at 9:19 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/include/dt-bindings/clock/r8a7791-clock.h
> +++ renesas/include/dt-bindings/clock/r8a7791-clock.h

> -#define R8A7791_CLK_RCAN               9
> +#define R8A7791_CLK_ADSP               9
> +#define R8A7791_CLK_RCAN               10

R8A7791_CLK_RCAN is changed?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
