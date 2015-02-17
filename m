From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Feb 2015 09:37:29 +0000
Subject: Re: [PATCH 6/8 v5] spi: sh-msiof: remove slave_id settings for DMAEngine
Message-Id: <CAMuHMdUaku2V9jJ=GGUdFpCiH6SDHE_oMNcL3ZUjz3a260pGjg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twyls3xm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twyls3xm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 17, 2015 at 2:47 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Current sh-msiof sets dma_slave_config :: slave_id field for DMAEngine,
> but it is no longer needed. Let's remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Mark Brown <broonie@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
