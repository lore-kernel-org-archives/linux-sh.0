From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 08:41:34 +0000
Subject: Re: [PATCH 01/20] i2c: rcar: add support for r8a7795 (R-Car H3)
Message-Id: <CAMuHMdW3OXCbp9py6QAhsPGsgmcJPdgdsPFv4D_waZ9G73y3Xw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twqt7kav.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twqt7kav.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 17, 2015 at 6:20 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Enable the I2C core for this SoC. I add a new type because this version
> has new features (e.g. DMA) which will be added somewhen later.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
