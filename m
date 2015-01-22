From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 12:23:10 +0000
Subject: Re: [PATCH 2/2] dmaengine: shdmac: fixup WARNING of slave caps retrieval
Message-Id: <CAMuHMdUggVNt78TuhwS4y31vfVrTe+J=SGoTuWy7ngP9W8vZfw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761bzmtmd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761bzmtmd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Jan 22, 2015 at 3:32 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> ecc19d17868be9c9f8f00ed928791533c420f3e0
> (dmaengine: Add a warning for drivers not using the generic slave
> caps retrieval) added WARN() for DMA_SLAVE.
> Kernel will shows WARNING without this patch.

Thanks, this gets rid of the warning on armadillo-legacy.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
