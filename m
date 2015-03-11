From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2015 09:08:56 +0000
Subject: Re: [PATCH] dmaengine: remove Renesas Audio DMAC peri peri
Message-Id: <CAMuHMdUuR-oBPgvGf=SRszXcsr8jeWr0Kff1ek=JCC3KbUV92w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oao1sjzp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oao1sjzp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Mar 10, 2015 at 2:46 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
> Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
> And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
> But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
> not a general purpose DMAC (2nd DMAC is for Device to Device inside
> sound system). Additionally, current DMAEngine can't support Device to
> Device, and we don't have correct DT bindings for it at this point.
> So the easiest solution for it is that move it from DMAEngine to rsnd
> driver.
> Audio DMAC peri peri on DMAEngine is no longer needed. remove it.

Thanks!

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

You can add my

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

if you add the removal of the DT bindings in
Documentation/devicetree/bindings/dma/rcar-audmapp.txt

Afer that, there's still a reference in
arch/arm/configs/multi_v7_defconfig:CONFIG_RCAR_AUDMAC_PP=m
but that should be handled in a separate patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
