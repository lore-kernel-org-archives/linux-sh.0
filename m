From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Feb 2015 10:53:24 +0000
Subject: Re: [PATCH v2 02/15] ARM: shmobile: r8a7778: add CPG register bits header
Message-Id: <CAMuHMdVKDW7W5wMcxp85zRmjiDgwndZ=jrQpcC9ds7Jw7zt79Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Mon, Feb 9, 2015 at 5:02 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +/* MSTP5 */
> +#define R8A7778_CLK_SCU_SRC0   31
> +#define R8A7778_CLK_SCU_SRC1   30
> +#define R8A7778_CLK_SCU_SRC2   29
> +#define R8A7778_CLK_SCU_SRC3   28
> +#define R8A7778_CLK_SCU_SRC4   27
> +#define R8A7778_CLK_SCU_SRC5   26
> +#define R8A7778_CLK_SCU_SRC6   25
> +#define R8A7778_CLK_SCU_SRC7   24
> +#define R8A7778_CLK_SCU_SRC8   23

According to the documentation, these are called
SRU_SRCx on R-Car Gen1, and
SCU_SRCx on R-Car Gen2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
