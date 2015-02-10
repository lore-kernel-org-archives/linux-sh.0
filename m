From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 10:55:16 +0000
Subject: Re: [PATCH v2 03/15] ARM: shmobile: r8a7778: Common clock framework DT description
Message-Id: <CAMuHMdWUbxeby4gtNgJ4G68rDTMt5YbKnO1_7TNieyfiT6D3Gg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 9, 2015 at 5:02 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +                       clock-indices = <
> +                               R8A7778_CLK_SCU_SRC0 R8A7778_CLK_SCU_SRC1
> +                               R8A7778_CLK_SCU_SRC2 R8A7778_CLK_SCU_SRC3
> +                               R8A7778_CLK_SCU_SRC4 R8A7778_CLK_SCU_SRC5
> +                               R8A7778_CLK_SCU_SRC6 R8A7778_CLK_SCU_SRC7
> +                               R8A7778_CLK_SCU_SRC8

R8A7778_CLK_SRU_SRC%u

> +                       >;
> +                       clock-output-names > +                               "scu-src0", "scu-src1", "scu-src2",
> +                               "scu-src3", "scu-src4", "scu-src5",
> +                               "scu-src6", "scu-src7", "scu-src8";

sru-src%u

> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
