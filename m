From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Aug 2014 12:47:39 +0000
Subject: Re: [PATCH 5/6] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <CAMuHMdVWeonmPjzNV9bOEcYvsRMruzc+jkVYRf_gZwk8D1id+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2014 at 2:34 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> +static struct dma_async_tx_descriptor *
> +rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +                         size_t buf_len, size_t period_len,
> +                         enum dma_transfer_direction dir, unsigned long flags,
> +                         void *context)

BTW, the "context" parameter should be removed, as Laurent's independent
patch to remove it everywhere else has hit slave-dma/next"

drivers/dma/sh/rcar-dmac.c: In function 'rcar_dmac_probe':
drivers/dma/sh/rcar-dmac.c:1462:33: warning: assignment from
incompatible pointer type
  engine->device_prep_dma_cyclic = rcar_dmac_prep_dma_cyclic;
                                 ^
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
