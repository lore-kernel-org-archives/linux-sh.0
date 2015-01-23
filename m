From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Jan 2015 09:12:04 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: r8a7778: common clock framework CPG driver
Message-Id: <CAMuHMdUKPJEayAowU-+P5S9_UybF2uYMmRVUHmrryBPPWU4TUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wed, Jan 21, 2015 at 5:20 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Driver for the r8a7778's clocks that depend on the mode bits.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  .../bindings/clock/renesas,r8a7778-cpg-clocks.txt  |  24 ++++
>  arch/arm/mach-shmobile/board-bockw-reference.c     |   2 +
>  arch/arm/mach-shmobile/setup-r8a7778.c             |  19 +++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-r8a7778.c                 | 146 +++++++++++++++++++++
>  include/linux/clk/shmobile.h                       |   1 +

Shouldn't this be split in two parts: clk and arch/arm/mach-shmobile?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
