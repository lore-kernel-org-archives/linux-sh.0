From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Aug 2014 12:28:01 +0000
Subject: Re: [PATCH/RFC 4/5] dmaengine: rcar-dmac: Implement support for hardware descriptor lists
Message-Id: <CAMuHMdVg1D4oWpPbDBpkWAktDYU7zkR7fkjFT7guxUy8U5u=FQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 22, 2014 at 2:33 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> @@ -740,6 +862,14 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
>                                 size = ALIGN(dev_addr, 1ULL << 32) - dev_addr;
>                         if (mem_addr >> 32 != (mem_addr + size - 1) >> 32)
>                                 size = ALIGN(mem_addr, 1ULL << 32) - mem_addr;
> +
> +                       /*
> +                        * Check if either of the source or destination address
> +                        * can't be expressed on 32 bits. If so we can't use

s/on/in/

> +                        * hardware descriptors lists.

s/descriptors/descriptor/

> +                        */
> +                       if (dev_addr >> 32 || mem_addr >> 32)
> +                               highmem = true;
>  #endif
>
>                         chunk = rcar_dmac_xfer_chunk_get(chan);
> @@ -770,11 +900,26 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
>                         len -= size;
>
>                         list_add_tail(&chunk->node, &desc->chunks);
> +                       nchunks++;
>                 }
>         }
>
> +       desc->nchunks = nchunks;
>         desc->size = full_size;
>
> +       /*
> +        * Use hardware descriptor lists if possible when more than one chunk
> +        * needs to be transferred (otherwise they don't make much sense).
> +        *
> +        * The highmem check currently covers the whole transfer. As an
> +        * optimization we could use descriptor lists for consecutive lowmem
> +        * chunks and direct manual mode for highmem chunks. Whether the
> +        * performance improvement would be significant enough compared to the
> +        * additional complexity remains to be studied.

s/studied/investigated/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
