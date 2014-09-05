From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 05 Sep 2014 09:34:12 +0000
Subject: Re: [PATCH v4 1/2] ARM: shmobile: Initial r8a7794 SoC device tree
Message-Id: <CAMuHMdWs-aYyorDQe7rxYvSsH0Q8-PcHUa_MSfQXgJKSAZjTMA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409906314-10946-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409906314-10946-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Sep 5, 2014 at 10:38 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +/* MSTP5 */
> +#define R8A7794_CLK_DMA_LOW            2

In the patches submitted for other R-Car Gen2 members, the
AUDIO DMAC bits were named differently, matching the datasheet:

+#define R8A7790_CLK_AUDIO_DMAC1                1
+#define R8A7790_CLK_AUDIO_DMAC0                2

However, as they're not yet used, and not yet integrated for other R-Car Gen2
members, perhaps it's best to just leave them out for now?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
