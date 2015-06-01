From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 01 Jun 2015 09:27:42 +0000
Subject: Re: [PATCH v4 4/4] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <CAMuHMdWDjSVKDbLs_=MZteVVYTCfTBvgZ8rvSCbvrZ4Ey3w2GQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432826157-6414-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432826157-6414-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 28, 2015 at 5:15 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Regulator setup seems identical to Koelsch.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-

Again, missing Makefile update?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
