From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 09:17:02 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: defconfig: add MTD_BLOCK
Message-Id: <CAMuHMdX0oa3QSz8H+B90VOozAjircmGxBORGSQikcD8P3qXYSw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a93483uk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a93483uk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 4, 2014 at 4:56 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> These patches are for shmobile_defconfig.
> 1st patch cleanups current shmobile_defconfig which was not created from savedefconfig.
> 2nd patch adds MTD_BLOCK which is needed for SPI-FLASH
>
> Kuninori Morimoto (2):
>       ARM: shmobile: defconfig: cleanup by savedefconfig
>       ARM: shmobile: defconfig: add MTD_BLOCK

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
