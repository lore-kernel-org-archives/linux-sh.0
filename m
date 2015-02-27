From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2015 09:40:35 +0000
Subject: Re: [PATCH 7/9 v4] ASoC: rsnd: remove slave_id settings for DMAEngine
Message-Id: <CAMuHMdU_3jvSazjZz+uky0mUkEmAQvJ=JDXqthUjK8drcFq7Zw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzjlbiv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Jan 29, 2015 at 2:03 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current rsnd sets dma_slave_config :: slave_id field for DMAEngine,
> but it is no longer needed. Let's remove it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v3 -> v4
>
>  - no change

i noticed this patch was dropped in v5, and thus not applied by Vinod?
Did I miss a discussion about that?

https://patchwork.kernel.org/patch/5732671/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
