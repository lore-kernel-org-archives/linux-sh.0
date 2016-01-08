From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 08 Jan 2016 09:28:22 +0000
Subject: Re: [RFC 0/4] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <CAMuHMdWE0w4+hPesLT=E42g4aT6zWuex-=+Wniovr=UjesjAdw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452241386-22830-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452241386-22830-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Niklas,

On Fri, Jan 8, 2016 at 9:23 AM, Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
> What I'm most concerned about is that I could not find a good way too
> keep track of mappings from different DMA channels to the same address
> so that they could properly be unmapped. This issue is due to that two
> channels might both try to map the same address (think rx/tx pair) and
> that would make it unsafe for any one of the channels to unmap the
> address without knowing if it's in use by the other.
>
> A follow up problem to this is that if the same address is mapped from
> two different channels but with different sizes and the larger size is
> tried last. If such a condition should happen and the larger size is so
> large that it crosses a page boundary there would be trouble.
>
> An obvious solution to both problem would be to map address to different
> iova:s in each channel and keep track of the unique mapping. That way
> all the above problems would go away. The problem is I can't figure out
> how to allocate a unique iova to feed to iommu_map.

What about
  1. Reference counting the mappings,
  2. Returning -EBUSY if the same address is already mapped with a
     different size? In the case of RX/TX pairs, the size should be the same
     (one page).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
