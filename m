From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 10:33:25 +0000
Subject: Re: [PATCH 02/11] ARM: shmobile: r8a7778: add CPG register bits header
Message-Id: <CAMuHMdVb2Rw5kP3ZLwjtjQsr-jh26GNm3scn44pUzNVr1e1ceg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wed, Jan 21, 2015 at 5:20 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a7778-clock.h
> @@ -0,0 +1,72 @@

> +/* MSTP5 */
> +#define R8A7778_CLK_SCU0       31
> +#define R8A7778_CLK_SCU1       30
> +#define R8A7778_CLK_SCU2       29
> +#define R8A7778_CLK_SCU3       28
> +#define R8A7778_CLK_SCU4       27
> +#define R8A7778_CLK_SCU5       26
> +#define R8A7778_CLK_SCU6       25
> +#define R8A7778_CLK_SCU7       24
> +#define R8A7778_CLK_SCU8       23

These are called "SRU (SRCx)" in the documentation, so I would use
"R8A7778_CLK_SRU_SRCx" here.

That's also similar to the R8A779x_CLK_SCU_SRCy used on R-Car Gen2 in
include/dt-bindings/clock/r8a779?-clock.h

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
