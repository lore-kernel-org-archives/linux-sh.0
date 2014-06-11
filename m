From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jun 2014 08:02:44 +0000
Subject: Re: [PATCH 02/07] DMA: shdma: 40-bit address prototype
Message-Id: <CAMuHMdVTP8HBo7A0ra+E2tSzC6ZWP7m9Y8xi7axjptRHBzrmug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140610230329.13594.85113.sendpatchset@w520>
In-Reply-To: <20140610230329.13594.85113.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Jun 11, 2014 at 1:03 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/drivers/dma/sh/shdmac.c
> +++ work/drivers/dma/sh/shdmac.c        2014-06-10 23:08:46.000000000 +0900

> @@ -382,12 +392,30 @@ static int sh_dmae_desc_setup(struct shd

> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +       /* unsure if crossing 32-bit boundary really works, disable for now */

As you mentioned at the top, the datasheet says it doesn't.

> +       if (shdev->pdata->fourty_bits_addr) {
> +               dma_addr_t limit = 0xffffffff;
> +               dma_addr_t src_masked = src & limit;
> +               dma_addr_t dst_masked = dst & limit;
> +
> +               if ((src_masked < limit) && ((src_masked + *len) > limit))

"src_masked < limit" fails to catch the case "src_masked = 0xffffffff".
"(src_masked + *len) > limit)" incorrectly catches the case
"(src_masked + *len) = 0x*00000000".

I think you want to check for

    if ((src >> 32) != ((src + *len - 1) >> 32))

?

> +                       *len = limit - src_masked;
> +
> +               if ((dst_masked < limit) && ((dst_masked + *len) > limit))
> +                       *len = limit - dst_masked;

Idem ditto.

> +       }
> +#endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
