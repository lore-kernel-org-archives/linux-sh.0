From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Aug 2014 12:29:08 +0000
Subject: Re: [PATCH/RFC 5/5] dmaengine: rcar-dmac: Cache hardware descriptors memory
Message-Id: <CAMuHMdWeOPYnXBnnkm9vFDY6gC5wJ-jywNY2_rxPU_ZtsT9Oug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 22, 2014 at 2:33 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Unlike DMA transfers descriptors that are preallocated and cached,
> memory used to store hardware descriptors is allocated and freed with
> the DMA coherent allocation API for every transfer. Beside degrading

Besides

> performances, this creates a CMA stress test that seem to cause issues.

seems

> Running dmatest with the noverify option produces
>
> [   50.066539] alloc_contig_range test_pages_isolated(6b845, 6b846) failed
> [   50.235180] alloc_contig_range test_pages_isolated(6b848, 6b84e) failed
> [   52.964584] alloc_contig_range test_pages_isolated(6b847, 6b848) failed
> [   54.127113] alloc_contig_range test_pages_isolated(6b843, 6b844) failed
> [   56.270253] alloc_contig_range test_pages_isolated(6b84c, 6b850) failed
>
> The root cause need to be fixed, but in the meantime, as a workaround

needs

> and a performance improvement, cache hardware descriptors.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
