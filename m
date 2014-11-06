From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Nov 2014 19:19:56 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: sh73a0 and kzm9g Multiplatform support
Message-Id: <CAMuHMdUj875foqjsb4RPB_1-HP=tNz8VmnoC4XZ+37vQif8vRQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022835.26216.90336.sendpatchset@w520>
In-Reply-To: <20140904022835.26216.90336.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Sep 4, 2014 at 4:28 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: sh73a0 and kzm9g Multiplatform support
>
> [PATCH 01/03] ARM: shmobile: sh73a0: Introduce generic setup callback
> [PATCH 02/03] ARM: shmobile: sh73a0: Add Multiplatform support
> [PATCH 03/03] ARM: shmobile: kzm9g: Build DTS for Multiplatform
>
> This patch series enables sh73a0 Multiplatform support. At this point
> the KZM9G board code is left as-is, but future updates will make
> sure to consolidate the DTS and get rid of C board code.

Did you manage to boot this successfully?

For me, it hangs after:

    On node 0 totalpages: 124928
    free_area_init_node: node 0, pgdat c04f9a40, node_mem_map df429000
      Normal zone: 976 pages used for memmap
      Normal zone: 0 pages reserved
      Normal zone: 124928 pages, LIFO batch:31

Both kzm9g-legacy and kzm9g-reference do work.
So it must be some funky difference between reference and multi-platform.

More debugging shows it hangs in memmap_init_zone(), which loops over
all pfns, calling pfn_to_page(pfn):

        pfn 266240 -> page 0xdf448000
        ...
        pfn 388095 -> page 0xdf7fffe0
        pfn 388096 -> page 0xdf800000

As 0xdf800000 is just beyond the end of RAM, the kernel locks up.

With -reference, the output is:

    free_area_init_node: node 0, pgdat c0508740, node_mem_map de429000
      Normal zone: 976 pages used for memmap
      Normal zone: 0 pages reserved
      Normal zone: 124928 pages, LIFO batch:31

Note that node_mem_map is 0x1000000 less!
And the loop goes like:

        pfn 266240 -> page 0xde428000
        ...
        pfn 391167 -> page 0xde7f7fe0

And all pages fit in RAM.

On armadillo, node_mem_map is the same for -legacy and -multiplatform.

The kzm9g memory node has "reg = <0x41000000 0x1e800000>;".
The armadillo memory node has "reg = <0x40000000 0x20000000>;".
But, if I limit memory on armadillo to match kzm9g, it also locks up.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  Built on top of renesas-devel-20140904-v3.17-rc3

To check if this is a recent regression, I also tried on top of
renesas-devel-20140904v2-v3.17-rc3, but I get the same lock up.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
